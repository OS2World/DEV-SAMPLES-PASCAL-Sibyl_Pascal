unit IniFiles; { IniFiles for SpeedPascal 1.5 }

{ TIniFile: Standard (bin„res) OS/2 Inifile
  TAsciiIniFile: Text-Inifile, lesbar, mit Editor zu bearbeiten.

  Beide benutzen exakt das gleiche Interface und sind bis
  auf die neue Methode 'Erase' kompatibel zu den normalen
  Delphi-Inifiles. }

interface

uses Lists, PMSHL; { OS/2 profile functions }

type
  EIniFileError = class(Exception);

type
  TIniFile = class(TObject)
  private
    FFileName: PString;         // Physical name of file
    FHandle: HINI;              // Profile handle
    function GetFileName: string;

  protected
    procedure Error(const Msg: string); virtual;

  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
    procedure Erase(const Section, Ident: string); virtual;
    procedure EraseSection(const Section: string); virtual;
    function ReadString(const Section, Ident, Default: string): string; virtual;
    function ReadInteger(const Section, Ident: string; Default: Longint): Longint; virtual;
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean; virtual;
    procedure ReadSection(const Section: string; AStrings: TStrings); virtual;
    procedure ReadSectionValues(const Section: string; AStrings: TStrings); virtual;
    procedure WriteString(const Section, Ident, Value: String); virtual;
    procedure WriteInteger(const Section, Ident: string; Value: Longint); virtual;
    procedure WriteBool(const Section, Ident: string; Value: Boolean); virtual;

    property FileName: string
      read GetFileName;
  end;

type
  TAsciiIniFile = class(TIniFile)
  private
    //FFileName: PString;         // Physical name of file
    FSections: TStringList;     // List of sections and their names
    FName: PString;             // Name of last used section
    FList: TStringList;         // List of last used section
    FChanged: Boolean;          // Has the data been changed?
    procedure WriteToSection(const Section: string);
    function ReadFromSection(const Section: string): Boolean;
    //function GetFileName: string;

  protected
    FTrueString: string[7];
    FFalseString: string[7];

  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
    procedure Erase(const Section, Ident: string); override;
    procedure EraseSection(const Section: string); override;
    function ReadString(const Section, Ident, Default: string): string; override;
    function ReadInteger(const Section, Ident: string; Default: Longint): Longint; override;
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean; override;
    procedure ReadSection(const Section: string; AStrings: TStrings); override;
    procedure ReadSectionValues(const Section: string; AStrings: TStrings); override;
    procedure Refresh;
    procedure WriteString(const Section, Ident, Value: String); override;
    procedure WriteInteger(const Section, Ident: string; Value: Longint); override;
    procedure WriteBool(const Section, Ident: string; Value: Boolean); override;

    property FileName: string
      read GetFileName;
    property Changed: Boolean
      read FChanged write FChanged;
  end;

function GetDefaultINI: string;
  { Get name of INI-file that matches program path & name with
    extension .INI instead of .EXE }

implementation

uses
  SysUtils;

const
  NULL = 0;

type
  TIniSection = class(TStringList)
    function GetValue(const Name: string): string; override;
    procedure SetValue(const Name, Value: string); override;
    function FindValue(const Name: string; var Value: string): LongInt; override;
    {function Get(Index: LongInt): string; override;
    procedure Put(Index: LongInt; const S: string); override;}
    procedure Delete(Index: LongInt); override;
  end;

function CutStr(var S: string; C: Char): string;
var
  P: Integer;
begin
  P := Pos(C, S);
  if P = 0 then
  begin
    Result := S;
    SetLength(S, 0);
  end
  else
  begin
    Result := Copy(S, 1, P - 1);
    Delete(S, 1, P);
  end;
end;

function TrimStr(const S: string): string;
var
  L, R: Integer;
begin
  R := Length(S);
  while (R > 0) and (S[R] = ' ') do Dec(R);
  L := 1;
  while (L <= R) and (S[L] = ' ') do Inc(L);
  Result := Copy(S, L, R - L + 1);
end;

function GetDefaultINI: string;
begin
  Result := ExpandFileName(ChangeFileExt(ParamStr(0), '.INI'));
end;

{ TIniSection }

procedure TIniSection.Delete(Index: LongInt);
var
  P: PString;
begin
  P := PString(GetObject(Index));
  DisposeStr(P);
  inherited Delete(Index);
end;

{procedure TIniSection.Put(Index: LongInt; const S: string);
var
  Ident, Value: string;
begin
  Value := S;
  Ident := CutStr(Value, '=');
  SetValue(Ident, Value);
end;}

function TIniSection.GetValue(const Name: string): string;
var
  I: LongInt;
begin
  if Find(Name, I) then Result := PString(GetObject(I))^
  else Result := '';
end;

function TIniSection.FindValue(const Name: string; var Value: string): LongInt;
begin
  if Find(Name, Result) then Value := PString(GetObject(Result))^
  else
  begin
    Value := '';
    Result := -1;
  end;
end;

procedure TIniSection.SetValue(const Name, Value: string);
var
  I: LongInt;
  P: PString;
begin
  if Find(Name, I) then
  begin
    P := PString(GetObject(I));
    DisposeStr(P);
    PutObject(I, TObject(NewStr(Value)));
  end
  else
  begin
    Sorted := False;
    InsertObject(I, Name, TObject(NewStr(Value)));
    Sorted := True;
  end;
end;

{ TIniFile }

constructor TIniFile.Create(const FileName: string);
begin
  FHandle := PrfOpenProfile(AppHandle, FileName);
  if FHandle = NULL then Error('Cannot open ini-file.');
  FFileName := NewStr(FileName);
end;

destructor TIniFile.Destroy;
begin
  PrfCloseProfile(FHandle);
  DisposeStr(FFileName);
end;

procedure TIniFile.Erase(const Section, Ident: string);
begin
  PrfWriteProfileString(FHandle, Section, Ident, nil);
end;

procedure TIniFile.EraseSection(const Section: string);
begin
  PrfWriteProfileString(FHandle, Section, nil, nil);
end;

procedure TIniFile.Error(const Msg: string);
begin
  raise EIniFileError.Create(Msg);
end;

function TIniFile.GetFileName: string;
begin
  Result := FFileName^;
end;

function TIniFile.ReadString(const Section, Ident, Default: string): string;
var
  CSection, CIdent, CDefault: CString[256];
begin
  CSection := Section;
  CIdent := Ident;
  CDefault := Default;
  SetLength(Result, PrfQueryProfileString(FHandle,
    CSection, CIdent, CDefault, Result[1], 255) - 1);
end;

function TIniFile.ReadInteger(const Section, Ident: string; Default: Longint): Longint;
begin
  Result := PrfQueryProfileInt(FHandle, Section, Ident, Default);
end;

function TIniFile.ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
var
  L: LongInt;
begin
  if Default then L := 1 else L := 0;
  Result := (PrfQueryProfileInt(FHandle, Section, Ident, L) <> 0);
end;

procedure TIniFile.ReadSection(const Section: string; AStrings: TStrings);
var
  Size, RealSize: LongInt;
  Buffer, Pos: PChar;
  S: string;
begin
  if not PrfQueryProfileSize(FHandle, Section, nil, Size) then Exit;
  GetMem(Buffer, Size);
  try
    PrfQueryProfileString(FHandle, Section, nil, nil, Buffer, Size);
    Buffer[Size - 1] := #0;
    Pos := Buffer;
    while Pos[0] <> #0 do
    begin
      S := StrPas(Pos);
      Inc(Pos, Length(S) + 1);
      Dec(RealSize, Length(S) + 1);
      AStrings.Add(S);
    end;
  finally
    FreeMem(Buffer, Size);
  end;
end;

procedure TIniFile.ReadSectionValues(const Section: string; AStrings: TStrings);
var
  Temp: TIniSection;
  I: LongInt;
begin
  Temp := TIniSection.Create;
  Temp.Sorted := True;
  Temp.Duplicates := dupIgnore;
  try
    ReadSection(Section, Temp);
    for I := 0 to Temp.Count - 1 do
      AStrings.SetValue(Temp.Get(I),
        ReadString(Section, Temp.Get(I), ''));
  finally
    Temp.Destroy;
  end;
end;

procedure TIniFile.WriteString(const Section, Ident, Value: String);
var
  CSection, CIdent, CValue: CString[256];
begin
  CSection := Section;
  CIdent := Ident;
  CValue := Value;
  if not PrfWriteProfileString(FHandle, CSection, CIdent, CValue) then
    Error('Error during write.');
end;

procedure TIniFile.WriteInteger(const Section, Ident: string; Value: Longint);
begin
  WriteString(Section, Ident, IntToStr(Value));
end;

procedure TIniFile.WriteBool(const Section, Ident: string; Value: Boolean);
var
  C: Char;
begin
  if Value then C := '1' else C := '0';
  WriteString(Section, Ident, C);
end;

{ TAsciiIniFile }

constructor TAsciiIniFile.Create(const FileName: string);
var
  Source: Text;
  S, T: string;
begin
  FSections := TStringList.Create;
  FSections.Duplicates := dupIgnore;
  FSections.Sorted := True;
  FTrueString := 'True';
  FFalseString := 'False';

  FFileName := NewStr(FileName);
  FName := NullStr;

  if FFileName <> NullStr then
  begin
    Assign(Source, FileName);
    {$i-}
    Reset(Source);
    {$i+}
    if IOResult = 0 then
    begin
      while not EOF(Source) do
      begin
        ReadLn(Source, S);
        if Length(S) <> 0 then
        begin
          if S[1] = '[' then
          begin
            { New Section }
            Delete(S, 1, 1);
            WriteToSection(CutStr(S, ']'));
          end
          else
          if not (S[1] in [';', '#', '%']) then
          begin
            { New entry }
            if FList = nil then WriteToSection('');
            T := CutStr(S, '=');
            FList.AddObject(TrimStr(T), TObject(NewStr(TrimStr(S))));
          end;
        end;
      end;
      Close(Source);
    end;
  end;
end;

destructor TAsciiIniFile.Destroy;
var
  I: LongInt;
begin
  Refresh;
  DisposeStr(FName);
  DisposeStr(FFileName);
  for I := 0 to FSections.Count - 1 do
  begin
    FList := FSections.GetObject(I);
    FList.Destroy;
  end;
  FSections.Destroy;
end;

procedure TAsciiIniFile.Erase(const Section, Ident: string);
var
  I: LongInt;
begin
  if ReadFromSection(Section) then
  begin
    if FList.Find(Ident, I) then FList.Delete(I);
  end;
end;

procedure TAsciiIniFile.EraseSection(const Section: string);
var
  I: LongInt;
  S: TIniSection;
begin
  if FSections.Find(Section, I) then
  begin
    S := FSections.GetObject(I);
    S.Destroy;
    FSections.Delete(I);
    if S = FList then
    begin
      AssignStr(FName, '');
      FList := nil;
    end;
    FChanged := True;
  end;
end;

procedure TAsciiINIFile.WriteToSection(const Section: string);
var
  I: LongInt;
begin
  if CompareText(Section, FName^) <> 0 then
  begin
    if FSections.Find(Section, I) then
    begin
      AssignStr(FName, Section);
      FList := FSections.GetObject(I);
    end
    else
    begin
      FList := TIniSection.Create;
      FList.Duplicates := dupAccept;
      FList.Sorted := True;
      FList.CaseSensitive := False;
      FSections.AddObject(Section, FList);
      AssignStr(FName, Section);
    end;
  end;
end;

function TAsciiINIFile.ReadFromSection(const Section: string): Boolean;
var
  I: LongInt;
begin
  if CompareText(Section, FName^) <> 0 then
  begin
    if FSections.Find(Section, I) then
    begin
      AssignStr(FName, Section);
      FList := FSections.GetObject(I);
    end;
  end;
  Result := (FList <> nil);
end;

{function TAsciiIniFile.GetFileName: string;
begin
  Result := FFileName^;
end;}

function TAsciiIniFile.ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
var
  S: string;
begin
  if ReadFromSection(Section) then
  with TIniSection(FList) { as TIniSection} do
  begin
    if FindValue(Ident, S) = -1 then Result := Default
    else
    begin
      if CompareText(S, FTrueString) = 0 then Result := True
      else if CompareText(S, FFalseString) = 0 then Result := False
      else Result := Default;
    end;
  end
  else Result := Default;
end;

function TAsciiIniFile.ReadInteger(const Section, Ident: string; Default: Longint): Longint;
var
  S: string;
begin
  if ReadFromSection(Section) then
  with TIniSection(FList) { as TIniSection} do
  begin
    if FindValue(Ident, S) = -1 then Result := Default
    else Result := StrToIntDef(S, Default);
  end
  else Result := Default;
end;

function TAsciiIniFile.ReadString(const Section, Ident, Default: string): string;
begin
  if ReadFromSection(Section) then
  with TIniSection(FList) { as TIniSection} do
  begin
    if FindValue(Ident, Result) = -1 then Result := Default;
  end
  else Result := Default;
end;

procedure TAsciiIniFile.ReadSection(const Section: string; AStrings: TStrings);
var
  N: LongInt;
begin
  if ReadFromSection(Section) then
  begin
    for N := 0 to FList.Count - 1 do AStrings.Add(FList.Get(N));
  end;
end;

procedure TAsciiIniFile.ReadSectionValues(const Section: string; AStrings: TStrings);
var
  N: LongInt;
begin
  if ReadFromSection(Section) then
  begin
    for N := 0 to FList.Count - 1 do
      AStrings.Add(FList.Get(N) + '=' + PString(FList.GetObject(N))^);
  end;
end;

procedure TAsciiIniFile.Refresh;
var
  Dest: Text;
  N, I: LongInt;
  L: TStringList;
  S: string;
begin
  if FChanged and (FFileName <> NullStr) then
  begin
    Assign(Dest, FileName);
    Rewrite(Dest);
    for N := 0 to FSections.Count - 1 do
    begin
      S := FSections.Get(N);
      if Length(S) <> 0 then
      begin
        WriteLn(Dest, '[' + S + ']');
        WriteLn(Dest);
      end;
      L := FSections.GetObject(N);
      for I := 0 to L.Count - 1 do
        WriteLn(Dest, L.Get(I), '=', PString(L.GetObject(I))^);
      if N < FSections.Count then WriteLn(Dest);
      FChanged := False;
    end;
    Close(Dest);
  end;
end;

procedure TAsciiIniFile.WriteBool(const Section, Ident: string; Value: Boolean);
begin
  FChanged := True;
  WriteToSection(Section);
  if Value then FList.SetValue(Ident, FTrueString)
  else FList.SetValue(Ident, FFalseString);
end;

procedure TAsciiIniFile.WriteInteger(const Section, Ident: string; Value: LongInt);
begin
  FChanged := True;
  WriteToSection(Section);
  FList.SetValue(Ident, IntToStr(Value));
end;

procedure TAsciiIniFile.WriteString(const Section, Ident, Value: string);
begin
  FChanged := True;
  WriteToSection(Section);
  FList.SetValue(Ident, Value);
end;

end.

{ Žnderungen: 26.11.95  Sections werden sortiert, Eintr„ge aber nicht
              28.11.95  Alles wird sortiert, schneller durch Trennung
                        von Ident und Value (TIniSection).
              30.11.95  Fehler in TIniSection korrigiert, es
                        fehlten Get/Put
              16.12.95  Neue Funktion GetDefaultINI()

  To-Do: - Eventuell ReadData / WriteData einbauen
         - Eventuell ReadSectionNames einbauen
         - Wenn String -> CString Fehler in SP/2 behoben,
           Workaround entfernen.


