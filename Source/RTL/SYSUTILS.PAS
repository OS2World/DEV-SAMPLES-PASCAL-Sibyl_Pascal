{*******************************************************}
{                                                       }
{ Speed-Pascal Runtime Library                          }
{ System Utilities Unit (Delphi compatible)             }
{                                                       }
{ Ported 1995 by Joerg Pleumann                         }
{                                                       }
{ Mail all bugs and suggestions to:                     }
{                                                       }
{ Internet: sa021pl@unidui.uni-duisburg.de              }
{ FidoNet:  Joerg Pleumann@2:2448/136.6                 }
{                                                       }
{                                                       }
{*******************************************************}

{$define PM} { Without this switch the compiler
               uses VIO calls instead of PM ones. }

unit SysUtils;

interface

uses
  BseDos, BseErr, OS2Def;

type

  { System-dependent integer types - belongs into SYSTEM }
  Cardinal = LongWord;

const

  vtInteger  = 0;
  vtBoolean  = 1;
  vtChar     = 2;
  vtExtended = 3;
  vtString   = 4;
  vtPointer  = 5;
  vtPChar    = 6;
  vtObject   = 7;
  vtClass    = 8;

type
  PExtended = ^Extended;

type
  TVarRec = record
    case Integer of
      vtInteger:  (VInteger: LongInt; VType: LongInt);
      vtBoolean:  (VBoolean: Boolean);
      vtChar:     (VChar: Char);
      vtExtended: (VExtended: PExtended);
      vtString:   (VString: PString);
      vtPointer:  (VPointer: Pointer);
      vtPChar:    (VPChar: PChar);
      vtObject:   (VObject: TObject);
      vtClass:    (VClass: TClass);
  end;

const

 { File open modes }

  {$IFDEF OS2}
  fmOpenRead       = $0000;
  fmOpenWrite      = $0001;
  fmOpenReadWrite  = $0002;
  fmShareCompat    = $0000;
  fmShareExclusive = $0010;
  fmShareDenyWrite = $0020;
  fmShareDenyRead  = $0030;
  fmShareDenyNone  = $0040;
  {$ENDIF}
  {$IFDEF Win95}
  fmOpenRead       = $80000000;
  fmOpenWrite      = $40000000;
  fmOpenReadWrite  = $C0000000;
  fmShareCompat    = $00000003;
  fmShareExclusive = $00000000;
  fmShareDenyWrite = $00000001;
  fmShareDenyRead  = $00000002;
  fmShareDenyNone  = $00000003;
  {$ENDIF}

  { File attribute constants - no faVolumeID since there is no such constant in OS/2! }

  faReadOnly       = $0001;
  faHidden         = $0002;
  faSysFile        = $0004;
  faDirectory      = $0010;
  faArchive        = $0020;

  faAnyFile        = faReadOnly or faHidden or faSysFile or faDirectory or faArchive;

  { OS/2-specific file attribute constants for searching files }

  faMustReadOnly   = $0100;
  faMustHidden     = $0200;
  faMustSysFile    = $0400;
  faMustDirectory  = $1000;
  faMustArchive    = $2000;

  SecsPerDay = 24 * 60 * 60;
  MSecsPerDay = SecsPerDay * 1000;

type

  { Date/Time data structure (definition missing in Delphi) }

  TDateTime = Extended;

  { Type conversion records }

  WordRec = record
    Lo, Hi: Byte;
  end;

  LongRec = record
    Lo, Hi: Word;
  end;

  TMethod = record
    Code, Data: Pointer;
  end;

  {Useful arrays }

  PByteArray = ^TByteArray;
  TByteArray = array[0..MaxLongInt] of Byte;

  PWordArray = ^TWordArray;
  TWordArray = array[0..MaxLongInt div 2] of Word;

  { Generic procedure pointer }

  TProcedure = procedure;

  { Generic filename type }

  TFileName = string;

  { Search record used by FindFirst, FindNext, and FindClose }

  TSearchRec = record
    HDir: LongInt;
    Attr: Byte;
    Time: Longint;
    Size: Longint;
    Name: string;
  end;

  { Typed-file and untyped-file record - removed. Use 'FileRec' from SYSTEM }

  { FloatToText format codes }

  TFloatFormat = (ffGeneral, ffExponent, ffFixed, ffNumber, ffCurrency);

  { FloatToDecimal result record }

  TFloatRec = record
    Exponent: Integer;
    Negative: Boolean;
    Digits: array[0..18] of Char;
  end;

  { Exception support missing here, already present in SYSTEM }

const
  EmptyStr: string[1] = '';
  NullStr: PString = @EmptyStr;

{ Currency and date/time formatting options }

var
  CurrencyString: string[7];
  CurrencyFormat: Byte;
  NegCurrFormat: Byte; // not available under OS/2, synthesized :-)
  ThousandSeparator: Char;
  DecimalSeparator: Char;
  CurrencyDecimals: Byte;
  DateSeparator: Char;
  ShortDateFormat: string[15];
  LongDateFormat: string[31];
  TimeSeparator: Char;

  ListSeparator: Char;

  DateOrder: Byte;
  TwelveHours: Boolean;

const

  TimeAMString: string[7] = 'am';
  TimePMString: string[7] = 'pm';

var

  ShortTimeFormat: string[15];
  LongTimeFormat: string[31];

const

  ShortMonthNames: array[1..12] of string[7] =
    ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
     'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
  LongMonthNames: array[1..12] of string[15] =
    ('January', 'February', 'March',     'April',   'May',      'June',
     'July',    'August',   'September', 'October', 'November', 'December');
  ShortDayNames: array[1..7] of string[7] =
    ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');
  LongDayNames: array[1..7] of string[15] =
    ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');

{ Memory management routines }

function AllocMem(Size: Cardinal): Pointer;
function ReAllocMem(P: Pointer; CurSize, NewSize: Cardinal): Pointer;

{ Exit procedure handling }
procedure AddExitProc(Proc: TProcedure);
procedure CallExitProcs;

{ String handling routines }

function NewStr(const S: String): PString;
procedure DisposeStr(P: PString);
procedure AssignStr(var P: PString; const S: string);
procedure AppendStr(var Dest: string; const S: string);
function UpperCase(const S: string): string;
function LowerCase(const S: string): string;
function CompareStr(const S1, S2: string): Integer;
function CompareText(const S1, S2: string): Integer;
function AnsiUpperCase(const S: string): string;
{function AnsiLowerCase(const S: string): string;} // Not supported by OS/2
{function AnsiCompareStr(const S1, S2: string): Integer;} // Not supported by OS/2
function AnsiCompareText(const S1, S2: string): Integer;
function IsValidIdent(const Ident: string): Boolean;
function IntToStr(Value: LongInt): string;
function IntToHex(Value: LongInt; Digits: Integer): string;
function StrToInt(const S: string): LongInt;
function StrToIntDef(const S: string; Default: LongInt): LongInt;
function LoadStr(Ident: Word): string;
function FmtLoadStr(Ident: Word; const Args: array of const): string;

{ NEW NEW NEW SetLength changes the length of a string }
procedure SetLength(var S: string; NewLength: Byte);

{ File management routines }

function FileOpen(const FileName: string; Mode: Word): LongInt;
function FileCreate(const FileName: string): LongInt;
function FileOpenOrCreate(const FileName: string; Mode: Word): LongInt;
function FileCreateIfNew(const FileName: string; Mode: Word): LongInt;
function FileRead(Handle: LongInt; var Buffer; Count: Longint): Longint;
function FileWrite(Handle: LongInt; var {const} Buffer; Count: LongInt): LongInt;
function FileSeek(Handle: LongInt; Offset: LongInt; Origin: Integer): LongInt;
procedure FileClose(Handle: LongInt);
function FileAge(const FileName: string): Longint;
function FileExists(const FileName: string): Boolean;
function FindFirst(const Path: string; Attr: Integer; var SearchRec: TSearchRec): LongInt;
function FindNext(var SearchRec: TSearchRec): LongInt;
procedure FindClose(var SearchRec: TSearchRec);
function FileGetDate(Handle: LongInt): Longint;
procedure FileSetDate(Handle: Integer; Age: Longint);
function FileGetAttr(const FileName: string): LongInt;
function FileSetAttr(const FileName: string; Attr: Integer): Integer;
function CopyFile(const SourceName, DestName: string): Boolean;
function DeleteFile(const FileName: string): Boolean;
function RenameFile(const OldName, NewName: string): Boolean;
function ChangeFileExt(const FileName, Extension: string): string;
function ExtractFilePath(const FileName: string): string;
function ExtractFileName(const FileName: string): string;
function ExtractFileExt(const FileName: string): string;
function ConcatFileName(const PathName, FileName: string): string;
function ExpandFileName(FileName: string): string;
function EditFileName(const Name, Edit: string): string;
function FileSearch(const Name, DirList: string): string;
function DiskFree(Drive: Byte): Longint;
function DiskSize(Drive: Byte): Longint;
function FileDateToDateTime(FileDate: Longint): TDateTime;
function DateTimeToFileDate(DateTime: TDateTime): Longint;

{ PChar routines }

function StrLen(Str: PChar): Cardinal;
function StrEnd(Str: PChar): PChar;
function StrMove(Dest, Source: PChar; Count: Cardinal): PChar;
function StrCopy(Dest, Source: PChar): PChar;
function StrECopy(Dest, Source: PChar): PChar;
function StrLCopy(Dest, Source: PChar; MaxLen: Cardinal): PChar;
function StrPCopy(Dest: PChar; const Source: String): PChar;
function StrPLCopy(Dest: PChar; const Source: string; MaxLen: Cardinal): PChar;
function StrCat(Dest, Source: PChar): PChar;
function StrLCat(Dest, Source: PChar; MaxLen: Cardinal): PChar;
function StrComp(Str1, Str2: PChar): Integer;
function StrIComp(Str1, Str2: PChar): Integer;
function StrLComp(Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLIComp(Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrScan(Str: PChar; Chr: Char): PChar;
function StrRScan(Str: PChar; Chr: Char): PChar;
function StrPos(Str, SubStr: PChar): PChar;
function StrUpper(Str: PChar): PChar;
function StrLower(Str: PChar): PChar;
function StrPas(Str: PChar): String;
function StrAlloc(Size: Cardinal): PChar;
function StrBufSize(Str: PChar): Cardinal;
function StrNew(Str: PChar): PChar;
procedure StrDispose(Str: PChar);

{ String formatting routines }

{ Format strings contain two types of characters

  * Plain characters are copied verbatim to the resulting string.

  * Format characters apply formatting to them.

    Format specifiers have the following form:

      "%" [index ":"] ["-"] [width] ["." prec] type
}

function Format(const Format: string; const Args: array of const): string;
procedure FmtStr(var Result: string; const Format: string;
  const Args: array of const);
function StrFmt(Buffer, Format: PChar; const Args: array of const): PChar;
function StrLFmt(Buffer: PChar; MaxLen: Cardinal; Format: PChar;
  const Args: array of const): PChar;
function FormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal;

{ Floating point conversion routines }

function FloatToStr(Value: Extended): string;
function FloatToStrF(Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer): string;
function FloatToText(Buffer: PChar; Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer): Integer;
function FormatFloat(const Format: string; Value: Extended): string;
function FloatToTextFmt(Buffer: PChar; Value: Extended;
  Format: PChar): Integer;
function StrToFloat(const S: string): Extended;
function TextToFloat(Buffer: PChar; var Value: Extended): Boolean;
procedure FloatToDecimal(var Result: TFloatRec; Value: Extended;
  Precision, Decimals: Integer);

{ Date/time support routines }

function EncodeDate(Year, Month, Day: Word): TDateTime;
function EncodeTime(Hour, Min, Sec, MSec: Word): TDateTime;
procedure DecodeDate(Date: TDateTime; var Year, Month, Day: Word);
procedure DecodeTime(Time: TDateTime; var Hour, Min, Sec, MSec: Word);
function DayOfWeek(Date: TDateTime): Integer;
function Date: TDateTime;
function Time: TDateTime;
function Now: TDateTime;
function DateToStr(Date: TDateTime): string;
function TimeToStr(Time: TDateTime): string;
function DateTimeToStr(DateTime: TDateTime): string;
function StrToDate(const S: string): TDateTime;
function StrToTime(const S: string): TDateTime;
function StrToDateTime(const S: string): TDateTime;
function FormatDateTime(const Format: string; DateTime: TDateTime): string;
procedure DateTimeToString(var Result: string; const Format: string;
  DateTime: TDateTime);

{ Initialization file support }

{function GetProfileStr(Section, Entry: PChar; const Default: string): string;
function GetProfileChar(Section, Entry: PChar; Default: Char): Char;}

{  The OS2 user profile can only be accessed from inside PM programs. }

{$ifdef PM}

{
function OpenProfile: Boolean;
procedure CloseProfile;
}
function GetProfileStr(const Section, Entry: cstring; const Default: string): string;
function GetProfileChar(const Section, Entry: cstring; Default: Char): Char;
function GetProfileInt(const Section, Entry: cstring; Default: Integer): Integer;

{$endif}

procedure GetFormatSettings;

{ Exception handling routines }

procedure ConvertError(const Msg: String);

implementation

{$ifdef PM}

{$IFDEF OS2}
uses
  PMSHL, PMWIN;
{$ENDIF}
{$IFDEF Win95}
uses
  WinBase,WinUser;
{$ENDIF}
{$endif}

const

  DaysPassed: array[False..True, 1..13] of Integer =
    ((0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365),
     (0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366));

var

  CollatingSequence: array[#0..#255] of Byte;

const

  Hexadecimals: array[0..15] of Char = '0123456789ABCDEF';

procedure ConvertError(const Msg: String);
begin
  raise EConvertError.Create(Msg);
end;

{ String / PChar utility functions }

assembler

  { This function returns the length of a string and a pointer to the
    zero terminator.

    Input:   EDI holds pointer string
    Output:  EDI holds pointer to zero terminator, EAX holds string length
    Changes: EAX, EBX, ECX, EDI }

  !StringLength PROC NEAR32

    MOV       EBX, EDI
    XOR       EAX, EAX
    CMP       EDI, 0
    JE        !Out!StringLength
    MOV       ECX, $ffffffff
    CLD
    REPNE
    SCASB
    NOT       ECX
    MOV       EAX, ECX
    DEC       EAX
    DEC       EDI

  !Out!StringLength:
    RETN32

  !StringLength ENDP

  { This functions copies a maximum number of characters from one string
    to another.

    Input:   ESI holds source, EDI holds destination, ECX hold maximum
             number of characters
    Output:  EDI holds end of destination string
    Changes: EAX, EBX, ECX, EDX, ESI, EDI }

  !StringCopy PROC NEAR32

    MOV       EBX, ECX
    MOV       EDX, EDI
    XOR       EAX, EAX
    CMP       EDI, 0
    JE        !Out!StringCopy
    CMP       ESI, 0
    JE        !Out!StringCopy
    MOV       EDI, ESI
    CLD
    REPNE
    SCASB
    SUB       EBX, ECX
    MOV       ECX, EBX
    SHR       ECX, 2
    MOV       EDI, EDX
    REP       MOVSD
    MOV       ECX, EBX
    AND       ECX, 3
    REP
    MOVSB
    STOSB
    DEC       EDI
    DEC       EDI

  !Out!StringCopy:
    RETN32

  !StringCopy ENDP

  // This function compares a maximum number of characters

  !StringCompare PROC NEAR32

    REPE
    CMPSB
    XOR        EAX, EAX
    MOV        AL, [ESI - 1]
    MOV        BL, [EDI - 1]
    SUB        EAX, EBX
    RETN32

  !StringCompare ENDP

  //

  !StringICompare PROC NEAR32

    XOR        EAX, EAX;

  !Loop!StringICompare:

    REPE
    CMPSB
    JE         !Out!StringICompare

    XOR        EBX, EBX
    MOV        BL, [ESI - 1]
    CMP        BL, 'A'
    JL         !UpcaseSecondChar!StringICompare
    CMP        BL, 'Z'
    JG         !UpcaseSecondChar!StringICompare
    OR         BL, 32

  !UpcaseSecondChar!StringICompare:

    XOR        EDX, EDX
    MOV        DL, [EDI - 1]
    CMP        DL, 'A'
    JL         !CompareSingleChar!StringICompare
    CMP        DL, 'Z'
    JG         !CompareSingleChar!StringICompare
    OR         DL, 32

  !CompareSingleChar!StringICompare:

    SUB        EBX, EDX
    JE         !Loop!StringICompare
    MOV        EAX, EBX

  !Out!StringICompare:

    RETN32

  !StringICompare ENDP

end;

{ Memory management routines }

function AllocMem(Size: Cardinal): Pointer;
var
  P: Pointer;
begin
  GetMem(P, Size);
  FillChar(P^, Size, 0);
  AllocMem := P;
end;

function ReAllocMem(P: Pointer; CurSize, NewSize: Cardinal): Pointer;
var
  Q: PByteArray;
begin
  if NewSize <> 0 then GetMem(Q, NewSize)
  else Q := nil;

  if NewSize > 0 then
    begin
      if NewSize > CurSize then
        begin
          FillChar(Q^[CurSize], NewSize - CurSize, 0);
          NewSize := CurSize;
        end;
      if NewSize <> 0 then Move(P^, Q^, NewSize);
    end;
  if CurSize <> 0 then FreeMem(P, CurSize);
  ReAllocMem := Q;
end;

{ Exit procedure handling }

type
  PExitNode = ^TExitNode;
  TExitNode = record
    Next: PExitNode;
    Proc: TProcedure;
  end;

const
  ExitChain: PExitNode = nil;

var
  SaveExitProc: Pointer;

procedure CallExitProcs;
var
  First: PExitNode;
  Proc: TProcedure;
begin
  while ExitChain <> nil do
    begin
      First := ExitChain;
      Proc := First^.Proc;
      ExitChain := First^.Next;
      ExitProc := nil; { Avoids recursion! }
      Dispose(First);
      Proc;
    end;
  ExitProc := SaveExitProc;
end;

procedure AddExitProc(Proc: TProcedure);
var
  NewNode: PExitNode;
begin
  if ExitChain = nil then
    SaveExitProc := ExitProc;
  New(NewNode);
  NewNode^.Next := ExitChain;
  NewNode^.Proc := Proc;
  ExitChain := NewNode;
  ExitProc := @CallExitProcs;
end;

{ String handling routines }

function NewStr(const S: String): PString;
begin
  if Length(S) = 0 then
    Result := NullStr
  else
    begin
      GetMem(Result, Length(S) + 1);
      Result^ := S;
    end;
end;

procedure DisposeStr(P: PString);
begin
  if (P <> NullStr) and (P <> nil) then
    FreeMem(P, Length(P^) + 1);
end;

procedure AssignStr(var P: PString; const S: string);
begin
  DisposeStr(P);
  P := NewStr(S);
end;

procedure AppendStr(var Dest: string; const S: string);
begin
  Insert(S, Dest, Length(Dest) + 1);
end;

function UpperCase(const S: string): string;
var
  T: string;
  N, C: Integer;
begin
  T := S;
  for N := 1 to Length(T) do
    begin
      C := Ord(T[N]);
      if (C >= Ord('a')) and (C <= Ord('z')) then
        T[N] := Chr(C and not 32);
    end;
  UpperCase := T;
end;

function LowerCase(const S: string): string;
var
  T: string;
  N, C: Integer;
begin
  T := S;
  for N := 1 to Length(T) do
  begin
    C := Ord(T[N]);
    if (C >= Ord('A')) and (C <= Ord('Z')) then T[N] := Chr(C or 32);
  end;
  LowerCase := T;
end;

function CompareStr(const S1, S2: string): Integer;
begin
  if S1 <= S2 then
    begin
      if S1 = S2 then
        CompareStr := 0
      else
        CompareStr := -1;
    end
  else
    CompareStr := +1
end;

function CompareText(const S1, S2: string): Integer;
var
  L1, L2, L: Integer;
begin
  L1 := Length(S1);
  L2 := Length(S2);
  if L1 <= L2 then L := L1
  else L := L2;
  Result := StrLIComp(@S1[1], @S2[1], L);
  if Result = 0 then
  begin
    if L1 < L2 then Result := -1
    else if L1 > L2 then Result := 1;
  end;
  {CompareText := CompareStr(UpperCase(S1), UpperCase(S2));}
end;

{$ifdef PM}

{$IFDEF OS2}
function AnsiUpperCase(const S: string): string;
var
  Temp: cstring[256];
begin
  Temp := S;
  WinUpper(AppHandle, 0, 0, Temp);
  Result := Temp;
end;
{$ENDIF}
{$IFDEF Win95}
function AnsiUpperCase(const S: string): string;
VAR S1:STRING;
begin
  S1:=S;
  AnsiUpperBuff(@S1[1], Length(S1));
  AnsiUpperCase:=S1;
end;
{$ENDIF}

{$else}

{$IFDEF OS2}
function AnsiUpperCase(const S: string): string;
var
  CC: COUNTRYCODE;
begin
  Result := S;
  CC.Country := 0;
  CC.CodePage := 0;
  DosMapCase(Length(Result), CC, Result[1]);
end;
{$ENDIF}
{$IFDEF Win95}
function AnsiUpperCase(const S: string): string;
VAR S1:STRING;
begin
  S1:=S;
  AnsiUpperBuff(@S1[1], Length(S1));
  AnsiUpperCase:=S1;
end;
{$ENDIF}

{$endif}

{$ifdef PM}

{$IFDEF OS2}
function AnsiCompareText(const S1, S2: string): Integer;
var
  Temp1, Temp2: cstring[256];
begin
  Temp1 := S1;
  Temp2 := S2;
  case WinCompareStrings(AppHandle, 0, 0, Temp1, Temp2, 0) of
    WCS_LT: Result := -1;
    WCS_EQ: Result :=  0;
    WCS_GT: Result :=  1;
  end;
end;
{$ENDIF}

{$IFDEF Win95}
function AnsiCompareText(const S1, S2: string): Integer;
var
  Temp1,Temp2:array[0..255] of Char;
begin
  AnsiCompareText:=lstrcmpi(StrPCopy(Temp1,S1),
                            StrPCopy(Temp2,S2));
end;
{$ENDIF}

{$else}

function AnsiCompareText(const S1, S2: string): Integer;
var
  N, L1, L2: Integer;
begin
  N := 1;
  L1 := Length(S1);
  L2 := Length(S2);
  while (N <= L1) and (N <= L2) and
        (CollatingSequence[S1[N]] = CollatingSequence[S2[N]]) do Inc(N);

  if (N <= L1) and (N <= L2) then
  begin
    if CollatingSequence[S1[N]] < CollatingSequence[S2[N]] then Result := -1
    else if CollatingSequence[S1[N]] > CollatingSequence[S2[N]] then Result := 1
    else Result := 0;
  end
  else
  begin
    if L1 < L2 then Result := -1
    else if L1 > L2 then Result := 1
    else Result := 0;
  end;
end;

{$endif}

function IsValidIdent(const Ident: string): Boolean;
var
  L, N: Integer;
begin
  L := Length(Ident);
  if L = 0 then
    IsValidIdent := False
  else
    begin
      if Ident[1] in ['a'..'z', 'A'..'Z', '_'] then
        begin
          N := 2;
          while (N <= L) and (Ident[N] in ['a'..'z', 'A'..'Z', '_', '0'..'9']) do
            Inc(N);
          if N > L then
            IsValidIdent := True
          else
            IsValidIdent := False;
        end
      else
        IsValidIdent := False;
    end;
end;

function IntToStr(Value: Longint): string;
begin
  Str(Value, Result);
end;

function IntToHex(Value: Longint; Digits: Integer): string;
begin
  Result := '';
  repeat
    Dec(Digits);
    Result := Hexadecimals[Value and $0F] + Result;
    Value := Value shr 4;
  until Value = 0;
  if Digits > 0 then
  begin
    Move(Result[1], Result[1 + Digits], Byte(Result[0]));
    FillChar(Result[1], Digits, '0');
    Inc(Byte(Result[0]), Digits);
  end;
end;

function StrToInt(const S: string): Longint;
var
  L: LongInt;
  Err: Integer;
begin
  Val(S, L, Err);
  if Err <> 0 then
    raise EConvertError.Create('StrToInt(' + S + ')')
  else
    StrToInt := L;
end;

function StrToIntDef(const S: string; Default: Longint): Longint;
var
  L: LongInt;
  Err: Integer;
begin
  Val(S, L, Err);
  if Err <> 0 then
    StrToIntDef := Default
  else
    StrToIntDef := L;
end;

{$IFDEF OS2}
function LoadStr(Ident: Word): string;
var
  L: LongInt;
begin
  if DosGetMessage(nil, 0, Result[1], 255, Ident, nil, L) <> NO_ERROR then L := 0;
  SetLength(Result, L);
end;
{$ENDIF}

{$IFDEF Win95}
function LoadStr(Ident: Word): string;
var S:STRING;
begin
  S[0] := Char(LoadString(AppHandle,Ident,@S[1],254));
  LoadStr:=S;
end;
{$ENDIF}

function FmtLoadStr(Ident: Word; const Args: array of const): string;
begin
  FmtStr(Result, LoadStr(Ident), Args);
end;

procedure SetLength(var S: string; NewLength: Byte);
begin
  Byte(S[0]) := NewLength;
end;

{ File management routines }

{$IFDEF OS2}
function FileOpen(const FileName: string; Mode: Word): LongInt;
const
  Action = OPEN_ACTION_OPEN_IF_EXISTS or OPEN_ACTION_FAIL_IF_NEW;
var
  rc, ActionTaken, Handle: LongInt;
  FileNameZ: CString[256];
begin
  FileNameZ := FileName;
  if DosOpen(FileNameZ, Handle, ActionTaken, 0, 0, Action, Mode, nil) = NO_ERROR then
    FileOpen := Handle
  else
    FileOpen := -1;
end;
{$ENDIF}

{$IFDEF Win95}
??????????????
{$ENDIF}

function FileOpenOrCreate(const FileName: string; Mode: Word): LongInt;
const
  Action = OPEN_ACTION_OPEN_IF_EXISTS or OPEN_ACTION_CREATE_IF_NEW;
var
  rc, ActionTaken, Handle: LongInt;
  FileNameZ: CString[256];
begin
  FileNameZ := FileName;
  if DosOpen(FileNameZ, Handle, ActionTaken, 0, 0, Action, Mode, nil) = NO_ERROR then
    Result := Handle
  else
    Result := -1;
end;

function FileCreateIfNew(const FileName: string; Mode: Word): LongInt;
const
  Action = OPEN_ACTION_FAIL_IF_EXISTS or OPEN_ACTION_CREATE_IF_NEW;
var
  rc, ActionTaken, Handle: LongInt;
  FileNameZ: CString[256];
begin
  FileNameZ := FileName;
  if DosOpen(FileNameZ, Handle, ActionTaken, 0, 0, Action, Mode, nil) = NO_ERROR then
    Result := Handle
  else
    Result := -1;
end;

function FileCreate(const FileName: string): LongInt;
const
  Action = OPEN_ACTION_REPLACE_IF_EXISTS or OPEN_ACTION_CREATE_IF_NEW;
  Mode = fmOpenWrite + fmShareDenyNone;
var
  ActionTaken, Handle: LongInt;
  FileNameZ: CString[256];
begin
  FileNameZ := FileName;
  if DosOpen(FileNameZ, Handle, ActionTaken, 0, 0, Action, Mode, nil) = NO_ERROR then
    FileCreate := Handle
  else
    FileCreate := -1;
end;

function FileRead(Handle: LongInt; var Buffer; Count: Longint): Longint;
var
  Result: LongInt;
begin
  if DosRead(Handle, Buffer, Count, Result) = NO_ERROR then
    FileRead := Result
  else
    FileRead := -1;
end;

function FileWrite(Handle: LongInt; var {const} Buffer; Count: Longint): Longint;
begin
  if DosWrite(Handle, Buffer, Count, Result) <> NO_ERROR then
    Result := -1;
end;

function FileSeek(Handle: LongInt; Offset: Longint; Origin: Integer): Longint;
var
  NewPos: LongInt;
begin
  if DosSetFilePtr(Handle, Offset, Origin, NewPos) = NO_ERROR then
    FileSeek := NewPos
  else
    FileSeek := -1;
end;

procedure FileClose(Handle: LongInt);
begin
  DosClose(Handle);
end;

function FileAge(const FileName: string): Longint;
var
  FileNameZ: cstring[256];
  Buffer: FILESTATUS3;
begin
  FileNameZ := FileName;
  if DosQueryPathInfo(FileNameZ, FIL_STANDARD, Buffer, SizeOf(Buffer)) = NO_ERROR then
    FileAge := (Buffer.fdateLastWrite shl 16) or Buffer.ftimeLastWrite
  else FileAge := -1;
end;

function FileExists(const FileName: string): Boolean;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(FileName, faAnyFile, SearchRec) = 0 then
    begin
      FileExists := True;
      FindClose(SearchRec);
    end
  else
    FileExists := False;
end;

function FindFirst(const Path: string; Attr: Integer; var SearchRec: TSearchRec): LongInt;
var
  OS2SearchRec: FILEFINDBUF3;
  Result, Count: LongInt;
const
  Size = SizeOf(OS2SearchRec);
var
  PathZ: CString[256];
begin
  PathZ := Path;
  SearchRec.HDir := HDIR_CREATE;
  Count := 1;
  Result := DosFindFirst(PathZ, SearchRec.HDir, Attr, OS2SearchRec, Size, Count, FIL_STANDARD);
  if Result = NO_ERROR then
  begin
    with OS2SearchRec do
    begin
      SearchRec.Name := achName;
      SearchRec.Size := cbFile;
      SearchRec.Attr := attrFile;
      SearchRec.Time := fdateLastWrite;
      SearchRec.Time := SearchRec.Time shl 16 + ftimeLastWrite;
    end;
    FindFirst := 0;
  end
  else FindFirst := -Result;
end;

function FindNext(var SearchRec: TSearchRec): LongInt;
var
  OS2SearchRec: FILEFINDBUF3;
  Result: Integer;
  Count: LongInt;
const
  Size = SizeOf(OS2SearchRec);
begin
  Count := 1;
  Result := DosFindNext (SearchRec.HDir, OS2SearchRec, Size, Count);
  if Result = NO_ERROR then
  begin
    with OS2SearchRec do
    begin
      SearchRec.Name := achName;
      SearchRec.Size := cbFile;
      SearchRec.Attr := attrFile;
      SearchRec.Time := fdateLastWrite;
      SearchRec.Time := SearchRec.Time shl 16 + ftimeLastWrite;
    end;
    FindNext := 0;
  end
  else FindNext := -Result;
end;

procedure FindClose(var SearchRec: TSearchRec);
begin
  DosFindClose(SearchRec.HDir);
end;

function FileGetDate(Handle: LongInt): Longint;
var
  Buffer: FILESTATUS3;
begin
  if DosQueryFileInfo(Handle, FIL_STANDARD, Buffer, SizeOf(Buffer)) = NO_ERROR then
    FileGetDate := (Buffer.fdateLastWrite shl 16) or Buffer.ftimeLastWrite
  else FileGetDate := -1;
end;

procedure FileSetDate(Handle: Integer; Age: Longint);
var
  Buffer: FILESTATUS3;
begin
  FillChar(Buffer, SizeOf(Buffer), 0);
  Buffer.ftimeLastWrite := Age and $FFFF;
  Buffer.fdateLastWrite := Age shr 16;
  DosSetFileInfo(Handle, FIL_STANDARD, Buffer, SizeOf(Buffer));
end;

function FileGetAttr(const FileName: string): LongInt;
var
  Buffer: FILESTATUS3;
  FileNameZ: cstring[256];
begin
  FileNameZ := FileName;
  Result := - DosQueryPathInfo(FileNameZ, FIL_STANDARD, Buffer, SizeOf(Buffer));
  if Result = 0 then Result := Buffer.attrFile;
end;

function FileSetAttr(const FileName: string; Attr: Integer): Integer;
var
  Buffer: FILESTATUS3;
  FileNameZ: cstring[256];
begin
  FileNameZ := FileName;
  FillChar(Buffer, SizeOf(Buffer), 0);
  Buffer.attrFile := Attr;
  Result := - DosSetPathInfo(FileNameZ, FIL_STANDARD, Buffer, SizeOf(Buffer), 0);
end;

function CopyFile(const SourceName, DestName: string): Boolean;
var
  SourceZ, DestZ: cstring[256];
begin
  SourceZ := SourceName;
  DestZ := DestName;
  Result := (DosCopy(SourceZ, DestZ, DCPY_EXISTING) = NO_ERROR);
end;

function DeleteFile(const FileName: string): Boolean;
var
  FileNameZ: cstring[256];
begin
  FileNameZ := FileName;
  Result := (DosDelete(FileNameZ) = NO_ERROR);
end;

function RenameFile(const OldName, NewName: string): Boolean;
var
  OldNameZ, NewNameZ: cstring[256];
begin
  OldNameZ := OldName;
  NewNameZ := NewName;
  Result := (DosMove(OldNameZ, NewNameZ) = NO_ERROR);
end;

function ChangeFileExt(const FileName, Extension: string): string;
var
  P: Integer;
begin
  P := Length(FileName);
  while (P > 0) and (FileName[P] <> '.') do Dec(P);
  if P = 0 then Result := FileName + Extension
  else Result := Copy(FileName, 1, P - 1) + Extension;
end;

function ExtractFilePath(const FileName: string): string;
var
  P: Integer;
begin
  P := Length(FileName);
  while (P > 0) and (FileName[P] <> ':') and (FileName[P] <> '\') do Dec(P);
  Result := Copy(FileName, 1, P);
end;

function ExtractFileName(const FileName: string): string;
var
  P: Integer;
begin
  P := Length(FileName);
  while (P > 0) and (FileName[P] <> ':') and (FileName[P] <> '\') do Dec(P);
  Result := Copy(FileName, P + 1, 255);
end;

function ExtractFileExt(const FileName: string): string;
var
  P: Integer;
begin
  P := Length(FileName);
  while (P > 0) and (FileName[P] <> '.') do Dec(P);
  if P = 0 then Result := ''
  else Result := Copy(FileName, P, 255);
end;

function ConcatFileName(const PathName, FileName: string): string;
begin
  if (PathName = '') or (FileName = '') or
    (PathName[Length(PathName)] in ['\', ':']) then
      Result := PathName + FileName
  else Result := PathName + '\' + FileName;
end;

function ExpandFileName(FileName: string): string;
const
  Level = FIL_QUERYFULLNAME;
var
  FileNameZ, Buffer: cstring[256];
begin
  FileNameZ := FileName;
  if DosQueryPathInfo(FileNameZ, Level, Buffer, SizeOf(Buffer)) = NO_ERROR then Result := Buffer
  else Result := '';
end;

function EditFileName(const Name, Edit: string): string;
var
  Buffer, NameZ, EditZ: cstring[256];
begin
  NameZ := Name;
  EditZ := Edit;
  if DosEditName(1, NameZ, EditZ, Buffer, 256) = 0 then Result := Buffer
  else Result := '';
end;

function FileSearch(const Name, DirList: string): string;
const
  Flags = SEARCH_IGNORENETERRS;
var
  NameZ, DirListZ, Buffer: cstring[256];
begin
  NameZ := Name;
  DirListZ := DirList;
  if DosSearchPath(Flags, DirListZ, NameZ, Buffer, SizeOf(Buffer)) = NO_ERROR then
    Result := Buffer
  else Result := '';
end;

function DiskFree(Drive: Byte): Longint;
var
  Buffer: FSALLOCATE;
begin
  if DosQueryFSInfo(Drive, FSIL_ALLOC, Buffer, SizeOf(Buffer)) = NO_ERROR then
    with Buffer do Result := cUnitAvail * cSectorUnit * cbSector
  else Result := -1;
end;

function DiskSize(Drive: Byte): Longint;
var
  Buffer: FSALLOCATE;
begin
  if DosQueryFSInfo(Drive, FSIL_ALLOC, Buffer, SizeOf(Buffer)) = NO_ERROR then
    with Buffer do Result := cUnit * cSectorUnit * cbSector
  else Result := -1;
end;

function FileDateToDateTime(FileDate: Longint): TDateTime;
var
  Day, Month, Year, Hour, Min, Sec: Word;
begin
  Sec      := (FileDate and 31) shl 1;
  FileDate := FileDate shr 5;
  Min      := FileDate and 63;
  FileDate := FileDate shr 6;
  Hour     := FileDate and 31;
  FileDate := FileDate shr 5;

  Day      := FileDate and 31;
  FileDate := FileDate shr 5;
  Month    := FileDate and 15;
  FileDate := FileDate shr 4;
  Year     := 1980 + (FileDate and 127);

  Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Min, Sec, 0);
end;

function DateTimeToFileDate(DateTime: TDateTime): Longint;
var
  Day, Month, Year, Hour, Min, Sec, MSec: Word;
  FileDate: LongInt;
begin
  DecodeDate(DateTime, Year, Month, Day);
  DecodeTime(DateTime, Hour, Min, Sec, MSec);

  FileDate := Year - 1980;
  FileDate := (FileDate shl 4) or Month;
  FileDate := (FileDate shl 5) or Day;
  FileDate := Hour;
  FileDate := (FileDate shl 6) or Min;
  FileDate := (FileDate shl 5) or (Sec div 2);

  Result := FileDate;
end;

{ PChar routines }

function StrLen(Str:PChar): LongWord;
begin
  asm
    MOV       EDI, $Str
    CALLN32   !StringLength
    MOV       $!FuncResult, EAX
  end;
end;

function StrEnd(Str:PChar):PChar;
begin
  asm
    MOV       EDI, $Str
    CALLN32   !StringLength
    MOV       $!FuncResult, EDI
  end;
end;

function StrMove(Dest, Source: PChar; Count: Cardinal): PChar;
begin
  if (Source = nil) or (Dest = nil) or (Count = 0) then Result := nil
  else
  begin
    Move(Source^, Dest^, Count);
    Result := Dest;
  end;
end;

function StrCopy(Dest, Source:PChar):PChar;
begin
  asm
    MOV       ESI, $Source
    MOV       EDI, $Dest
    MOV       ECX, $FFFFFFFF
    CALLN32   !StringCopy
    MOV       EAX, $Dest
    MOV       $!FuncResult, EAX
  end;
end;

function StrECopy(Dest, Source:PChar):PChar;
begin
  asm
    MOV       ESI, $Source
    MOV       EDI, $Dest
    MOV       ECX, $FFFFFFFF
    CALLN32   !StringCopy
    MOV       $!FuncResult, EDI
  end;
end;

function StrLCopy(Dest, Source:PChar; MaxLen: Cardinal):PChar;
begin
  asm
    MOV       ESI, $Source
    MOV       EDI, $Dest
    MOV       ECX, $MaxLen
    CALLN32   !StringCopy
    MOV       EAX, $Dest
    MOV       $!FuncResult, EAX
  end;
end;

function StrPCopy(Dest: PChar; const Source: string): PChar;
begin
  asm
    MOV       EDI, $Dest
    MOV       ESI, $Source
    XOR       ECX, ECX
    MOV       CL, [ESI]
    INC       ESI
    CALLN32   !StringCopy
    MOV       EAX, $Dest
    MOV       $!FuncResult, EAX
  end;
end;

function StrPLCopy(Dest: PChar; const Source: string; MaxLen: Cardinal): PChar;
begin
  asm
    MOV       EDI, $Dest
    MOV       ESI, $Source
    XOR       ECX, ECX
    MOV       CL, [ESI]
    INC       ESI
    CMP       ECX, $MaxLen
    JLE       StrPLCopy_1
    MOV       ECX, $MaxLen

    StrPLCopy_1:

    CALLN32   !StringCopy
    MOV       EAX, $Dest
    MOV       $!FuncResult, EAX
  end;
end;

function StrCat(Dest, Source: PChar): PChar;
begin
  asm
    MOV       EDI, $Dest
    MOV       ESI, $Source
    CALLN32   !StringLength
    MOV       ECX, $FFFFFFFF
    CALLN32   !StringCopy
    MOV       EAX, $Dest
    MOV       $!FuncResult, EAX
  end;
end;

function StrLCat(Dest, Source: PChar; MaxLen: Cardinal): PChar;
begin
  asm
    MOV       EDI, $Dest
    MOV       ESI, $Source
    CALLN32   !StringLength
    MOV       ECX, $MaxLen
    SUB       ECX, EAX
    JLE       StrLCat_1
    CALLN32   !StringCopy

    StrLCat_1:

    MOV       EAX, $Dest
    MOV       $!FuncResult, EAX
  end;
end;

function StrComp(Str1, Str2: PChar): Integer;
begin
  asm
    MOV        EDI, $Str1
    CALLN32    !StringLength
    MOV        ECX, EAX
    MOV        ESI, $Str1
    MOV        EDI, $Str2
    CALLN32    !StringCompare
    MOV        $!FuncResult, EAX
  end;
end;

function StrLComp(Str1, Str2: PChar; MaxLen: Cardinal): Integer;
begin
  asm
    MOV        EDI, $Str1
    MOV        ECX, $MaxLen
    MOV        EBX, ECX
    XOR        EAX, EAX
    REPNZ      SCASB
    SUB        EBX, ECX
    MOV        ECX, EBX
    MOV        ESI, $Str1
    MOV        EDI, $Str2
    CALLN32    !StringCompare
    MOV        $!FuncResult, EAX
  end;
end;

function StrIComp(Str1, Str2: PChar): Integer;
begin
  asm
    MOV        EDI, $Str1
    CALLN32    !StringLength
    MOV        ECX, EAX
    MOV        ESI, $Str1
    MOV        EDI, $Str2
    CALLN32    !StringICompare
    MOV        $!FuncResult, EAX
  end;
end;

function StrLIComp(Str1, Str2: PChar; MaxLen: Cardinal): Integer;
begin
  asm
    MOV        EDI, $Str1
    MOV        ECX, $MaxLen
    MOV        EBX, ECX
    XOR        EAX, EAX
    REPNZ      SCASB
    SUB        EBX, ECX
    MOV        ECX, EBX
    MOV        ESI, $Str1
    MOV        EDI, $Str2
    CALLN32    !StringICompare
    MOV        $!FuncResult, EAX
  end;
end;

function StrScan(Str: PChar; Chr: Char): PChar;
begin
  asm
    MOV        EDI, $Str
    CALLN32    !StringLength
    INC        EAX
    MOV        ECX, EAX
    XOR        EBX, EBX
    MOV        AL, $Chr
    MOV        EDI, $Str
    REPNZ      SCASB
    DEC        EDI
    CMP        AL, [EDI]
    JNE        !StrScan_1
    MOV        EBX, EDI

    !StrScan_1:

    MOV        $!FuncResult, EBX
  end;
end;

function StrRScan(Str: PChar; Chr: Char): PChar;
begin
  asm
    MOV        EDI, $Str
    CALLN32    !StringLength
    INC        EAX
    MOV        ECX, EAX
    XOR        EBX, EBX
    MOV        AL, $Chr
    STD
    REPNZ      SCASB
    INC        EDI
    CMP        AL, [EDI]
    JNE        !StrRScan_1
    MOV        EBX, EDI

    !StrRScan_1:

    CLD
    MOV        $!FuncResult, EBX
  end;
end;

function StrPos(Str, SubStr: PChar): PChar;
begin
  asm
    MOV       EDI, $SubStr
    CALLN32   !StringLength
    CMP       EAX, 0
    JE        !ErrOutStrPos

    MOV       EDX, EAX
    MOV       EDI, $Str
    CALLN32   !StringLength
    CMP       EAX, 0
    JE        !ErrOutStrPos
    SUB       EAX, EDX
    JB        !ErrOutStrPos
    MOV       EDI, $Str

    !1:

    MOV       ESI, $SubStr
    LODSB
    REPNE     SCASB
    JNE       !ErrOutStrPos;
    MOV       EAX, ECX
    PUSH      EDI
    MOV       ECX, EDX
    DEC       ECX
    REPE      CMPSB
    MOV       ECX, EAX
    POP       EDI
    JNE       !1
    MOV       EAX, EDI
    DEC       EAX
    JMP       !Out

    !ErrOutStrPos:

    XOR EAX,EAX

    !Out:

    MOV $!FuncResult, EAX
  end;
end;

function StrLower(Str: PChar): PChar;
begin
  asm
    CLD
    MOV       ESI, $Str

    !StringLower1:

    LODSB
    OR        AL, AL
    JE        !OutStrLower

    CMP       AL, 'A'
    JB        !StringLower1
    CMP       AL, 'Z'
    JA        !StringLower1
    OR        AL, 32
    MOV       [ESI-1], AL
    JMP       !StringLower1

    !OutStrLower:

    MOV        EAX, $Str
    MOV        $!FuncResult, EAX
  END;
END;

function StrUpper(Str: PChar): PChar;
begin
  asm
    CLD
    MOV       ESI, $Str

    !StringUpper_Loop:

    LODSB
    OR        AL, AL
    JE        !OutStrUpper

    CMP       AL, 'a'
    JB        !StringUpper_Loop
    CMP       AL, 'z'
    JA        !StringUpper_Loop
    AND       AL, $DF
    MOV       [ESI-1], AL
    JMP       !StringUpper_Loop

    !OutStrUpper:

    MOV        EAX, $Str
    MOV        $!FuncResult, EAX
  end;
end;

function StrPas(Str: PChar): string;
begin
  Result := Str^;
end;

function StrAlloc(Size: Cardinal): PChar;
type
  PLong = ^LongInt;
var
  P: PChar;
begin
  GetMem(P, Size + 4);
  PLong(P)^ := Size + 4;
  Inc(P, 4);
  StrAlloc := P;
end;

function StrBufSize(Str: PChar): Cardinal;
type
  PLong = ^LongInt;
begin
  Dec(Str, 4);
  StrBufSize := PLong(Str)^ - 4;
end;

function StrNew(Str: PChar): PChar;
var
  Size: LongInt;
begin
  if Str = nil then
    StrNew := nil
  else
    begin
      Size := StrLen(Str) + 1;
      StrNew := StrMove(StrAlloc(Size), Str, Size);
    end;
end;

procedure StrDispose(Str: PChar);
type
  PLong = ^LongInt;
begin
  if Str <> nil then
    begin
      Dec(Str, 4);
      FreeMem(Str, PLong(Str)^);
    end;
end;

{ String formatting routines }

function FormatBuf(var Buffer; BufLen: Cardinal; const Format; FmtLen: Cardinal; const Args: array of const): Cardinal;
var
  { Format and result buffers }

  FmtPos, OldFmtPos, BufPos, ArgPos: LongInt;
  Buf: CString absolute Buffer;
  Fmt: CString absolute Format;

  { Argument buffer }

  VArgs: array[0..1023] of TVarRec absolute Args;

  { Workaround for High() problem }

  High_Args: LongInt;

  { Format details }

  Index, Width, Precision: LongInt;
  LeftAlign: Boolean;
  ArgType: Char;

  { Temporary variables }

  C: Char;
  P: Pointer;
  E: Extended;
  Pnt, L, M: LongInt;
  S: String[80];

  { Raise exception: Format and argument don't match }

  procedure IllegalArg;
  begin
    ConvertError('Format ''%' + ArgType + ''' invalid or not compatible with argument');
  end;

  { Raise exception: Out of arguments }

  procedure OutOfArgs;
  begin
    ConvertError('No argument for format ''%' + ArgType + '''');
  end;

  { Get an argument from the open array. If the
    type is unexpected, raise an exception. }

  function GetIntegerArg: LongInt;
  begin
    if ArgPos > High_Args then OutOfArgs;
    if VArgs[ArgPos].VType <> vtInteger then IllegalArg;
    Result := VArgs[ArgPos].VInteger;
    Inc(ArgPos);
  end;

  function GetExtendedArg: Extended;
  begin
    if ArgPos > High_Args then OutOfArgs;
    if VArgs[ArgPos].VType <> vtExtended then IllegalArg;
    Result := VArgs[ArgPos].VExtended^;
    Inc(ArgPos);
  end;

  function GetPointerArg: Pointer;
  begin
    if ArgPos > High_Args then OutOfArgs;
    if VArgs[ArgPos].VType <> vtPointer then IllegalArg;
    Result := VArgs[ArgPos].VPointer;
    Inc(ArgPos);
  end;

  procedure GetStringArg(var FirstChar: Pointer; var Len: LongInt);
  begin
    if ArgPos > High_Args then OutOfArgs;
    case VArgs[ArgPos].VType of
      vtChar:    begin
                   FirstChar := @VArgs[ArgPos].VChar;
                   Len := 1;
                 end;
      vtString:  begin
                   FirstChar := VArgs[ArgPos].VString;
                   Len := Byte(FirstChar^);
                {   WriteLn('Len=', Len); }
                   Inc(FirstChar);
                 end;
      vtPointer: begin { Should be vtPChar }
                   FirstChar := VArgs[ArgPos].VPChar;
                   Len := StrLen(FirstChar);
                 end;
      else       IllegalArg;
    end;
    Inc(ArgPos);
  end;

  { Parse a number from the format string. A '*' means:
    get the next integer argument from the open array. }

  function ParseNum: LongInt;
  begin
    if Fmt[FmtPos] = '*' then Result := GetIntegerArg
    else
    begin
      Result := 0;
      while (Fmt[FmtPos] in ['0'..'9']) and (FmtPos < FmtLen) do
      begin
        Result := Result * 10 + Ord(Fmt[FmtPos]) - 48;
        Inc(FmtPos);
      end;
    end;
  end;

  { Parse a whole format specifier. }

  function ParseFmtSpec: Char;
  label
    LIndex, LColon, LMinus, LWidth, LPoint, LPRec, LType;
  begin
    Width := -1;
    Index := -1;
    Precision := -1;
    LeftAlign := False;
    ArgType := #0;
    C := Fmt[FmtPos];

    LIndex:

      if not (C in ['0'..'9']) then goto LMinus;
      Width := ParseNum;
      if FmtPos >= FmtLen then exit;
      C := Fmt[FmtPos];

    LColon:

      if C <> ':' then goto LPoint;
      Index := Width;
      Width := -1;
      Inc(FmtPos);
      if FmtPos >= FmtLen then exit;
      C := Fmt[FmtPos];

    LMinus:

      if C <> '-' then goto LWidth;
      LeftAlign := True;
      Inc(FmtPos);
      if FmtPos >= FmtLen then exit;
      C := Fmt[FmtPos];

    LWidth:

      if not (C in ['0'..'9']) then goto LPoint;
      Width := ParseNum;
      if FmtPos >= FmtLen then exit;
      C := Fmt[FmtPos];

    LPoint:

      if C <> '.' then goto LType;
      Inc(FmtPos);
      Precision := ParseNum;
      if FmtPos >= FmtLen then exit;
      C := Fmt[FmtPos];

    LType:

      Result := UpCase(C);
      ArgType := Result;
      {WriteLn;
      WriteLn('Index:', Index, ' Align:', LeftAlign, ' Width:', Width, ' Prec: ', Precision, ' Type:', Result);
      WriteLn;}
      Inc(FmtPos);
  end;

  { Append something to the result buffer }

  procedure AppendStr(P: Pointer; Count: LongInt);
  begin
    if BufLen - BufPos < Count then Count := BufLen - BufPos;
    Move(P^, Buf[BufPos], Count);
    Inc(BufPos, Count);
  end;

  procedure AppendChar(C: Char; Count: LongInt);
  begin
    if BufLen - BufPos < Count then Count := BufLen - BufPos;
    FillChar(Buf[BufPos], Count, C);
    Inc(BufPos, Count);
  end;

begin
  FmtPos := 0;
  OldFmtPos := 0;
  BufPos := 0;
  ArgPos := 0;

  High_Args := High(Args);

  while (FmtPos < FmtLen) and (BufPos < BufLen) do
  begin
    C := Fmt[FmtPos];
    Inc(FmtPos);
    if C = '%' then
    begin
      C := ParseFmtSpec;
      if C = 'S' then
      begin
        GetStringArg(P, L);
        if (Precision > -1) and (Precision < L) then L := Precision;
      end
      else
      begin
        case C of
          'D': begin
                 Str(GetIntegerArg, S);
                 L := Length(S);
                 if (Precision <> -1) and (L < Precision) then
                 begin
                   SetLength(S, Precision);
                   Move(S[1], S[1 + Precision - L], L);
                   FillChar(S[1], Precision - L, '0');
                 end;
               end;
          'E': S := FloatToStrF(GetExtendedArg, ffExponent, Precision, 3);
          'F': S := FloatToStrF(GetExtendedArg, ffFixed, 9999, Precision);
          'G': S := FloatToStrF(GetExtendedArg, ffGeneral, Precision, 3);
          'N': S := FloatToStrF(GetExtendedArg, ffFixed, 9999, Precision);
          'M': S := FloatToStrF(GetExtendedArg, ffCurrency, 9999, Precision);
          'P': begin
                 L := LongInt(GetPointerArg);
                 S := IntToHex(L shr 16, 4) + ':' + IntToHex(L and $FFFF, 4);
               end;
          'X': begin
                 if Precision <> -1 then S := IntToHex(GetIntegerArg, Precision)
                 else S := IntToHex(GetIntegerArg, 0);
               end;
          else raise Exception.Create('Illegal format type');
        end;
        P := @S[1];
        L := Length(S);
      end;

      { Now P points to the first char to append to our result, L holds the
        length of the text to insert. If Width > L then we have to pad our
        text with spaces. }

      if LeftAlign then
      begin
        AppendStr(@S[1], L);
        if (Width > -1) and (L < Width) then AppendChar(' ', Width - L );
      end
      else
      begin
        if (Width > -1) and (L < Width) then AppendChar(' ', Width - L );
        AppendStr(@S[1], L);
      end;
    end
    else
    begin
      { Ordinary character }
      Buf[BufPos] := C;
      Inc(BufPos);
    end;
    OldFmtPos := FmtPos;
  end;
  Result := BufPos;
end;

function Format(const Format: string; const Args: array of const): string;
begin
  SetLength(Result, FormatBuf(Result[1], 255, Format[1], Length(Format), Args));
end;

procedure FmtStr(var Result: string; const Format: string; const Args: array of const);
begin
  SetLength(Result, FormatBuf(Result[1], 255, Format[1], Length(Format), Args));
end;

function StrFmt(Buffer, Format: PChar; const Args: array of const): PChar;
begin
  FormatBuf(Buffer, MaxLongInt, Format, StrLen(Format), Args);
  Result := Buffer;
end;

function StrLFmt(Buffer: PChar; MaxLen: Cardinal; Format: PChar; const Args: array of const): PChar;
begin
  FormatBuf(Buffer, MaxLen, Format, StrLen(Format), Args);
  Result := Buffer;
end;

{ Floating point conversion routines }

function FloatToStr(Value: Extended): string;
begin
  Result := FloatToStrF(Value, ffGeneral, 15, 0);
end;

function FloatToStrF(Value: Extended; Format: TFloatFormat; Precision, Digits: Integer): string;
var
  P: Integer;
  Negative, TooSmall, TooLarge: Boolean;
begin
  case Format of

    ffGeneral:

      begin
        if (Precision = -1) or (Precision > 15) then Precision := 15;
        TooSmall := Value < 0.00001;
        if not TooSmall then
        begin
          Str(Value:0:999, Result);
          P := Pos('.', Result);
          Result[P] := DecimalSeparator;
          TooLarge := P > Precision + 1;
        end;
        if TooSmall or TooLarge then
          Result := FloatToStrF(Value, ffExponent, Precision, Digits)
        else
        begin
          P := Length(Result);
          while Result[P] = '0' do Dec(P);
          if Result[P] = DecimalSeparator then Dec(P);
          SetLength(Result, P);
        end;
      end;

    ffExponent:

      begin
        if (Precision = -1) or (Precision > 15) then Precision := 15;
        Str(Value:Precision + 8, Result);
        Result[3] := DecimalSeparator;
        if (Digits < 4) and (Result[Precision + 5] = '0') then
        begin
          Delete(Result, Precision + 5, 1);
          if (Digits < 3) and (Result[Precision + 5] = '0') then
          begin
            Delete(Result, Precision + 5, 1);
            if (Digits < 2) and (Result[Precision + 5] = '0') then
            begin
              Delete(Result, Precision + 5, 1);
              if (Digits < 1) and (Result[Precision + 5] = '0') then Delete(Result, Precision + 3, 3);
            end;
          end;
        end;
        if Result[1] = ' ' then Delete(Result, 1, 1);
      end;

    ffFixed:

      begin
        if Digits = -1 then Digits := 2
        else if Digits > 15 then Digits := 15;
        Str(Value:0:Digits, Result);
        if Result[1] = ' ' then Delete(Result, 1, 1);
        P := Pos('.', Result);
        if P <> 0 then Result[P] := DecimalSeparator;
      end;

    ffNumber:

      begin
        if Digits = -1 then Digits := 2
        else if Digits > 15 then Digits := 15;
        Str(Value:0:Digits, Result);
        if Result[1] = ' ' then Delete(Result, 1, 1);
        P := Pos('.', Result);
        if P <> 0 then Result[P] := DecimalSeparator;
        Dec(P, 3);
        while (P > 1) do
        begin
          if Result[P - 1] <> '-' then Insert(ThousandSeparator, Result, P);
          Dec(P, 3);
        end;
      end;

    ffCurrency:

      begin
        if Value < 0 then
        begin
          Negative := True;
          Value := -Value;
        end
        else Negative := False;

        if Digits = -1 then Digits := CurrencyDecimals
        else if Digits > 15 then Digits := 15;
        Str(Value:0:Digits, Result);
        if Result[1] = ' ' then Delete(Result, 1, 1);
        P := Pos('.', Result);
        if P <> 0 then Result[P] := DecimalSeparator;
        Dec(P, 3);
        while (P > 1) do
        begin
          Insert(ThousandSeparator, Result, P);
          Dec(P, 3);
        end;

        if not Negative then
        begin
          case CurrencyFormat of
            0: Result := CurrencyString + Result;
            1: Result := Result + CurrencyString;
            2: Result := CurrencyString + ' ' + Result;
            3: Result := Result + ' ' + CurrencyString;
          end
        end
        else
        begin
          case NegCurrFormat of
            0: Result := '(' + CurrencyString + Result + ')';
            1: Result := '-' + CurrencyString + Result;
            2: Result := CurrencyString + '-' + Result;
            3: Result := CurrencyString + Result + '-';
            4: Result := '(' + Result + CurrencyString + ')';
            5: Result := '-' + Result + CurrencyString;
            6: Result := Result + '-' + CurrencyString;
            7: Result := Result + CurrencyString + '-';
            8: Result := '-' + Result + ' ' + CurrencyString;
            9: Result := '-' + CurrencyString + ' ' + Result;
            10: Result := CurrencyString + ' ' + Result + '-';
          end;
        end;
      end;
  end;
end;

function FloatToText(Buffer: PChar; Value: Extended; Format: TFloatFormat; Precision, Digits: Integer): Integer;
var
  Tmp: string[40];
begin
  Tmp := FloatToStrF(Value, Format, Precision, Digits);
  Result := Length(Tmp);
  Move(Tmp[1], Buffer[0], Result);
end;

function StrToFloat(const S: string): Extended;
var
  Error: Integer;
  Tmp: string;
  P: Integer;
begin
  Tmp := S;
  P := Pos(DecimalSeparator, Tmp);
  if P <> 0 then Tmp[P] := '.';
  Val(Tmp, Result, Error);
  if Error <> 0 then ConvertError('Not a number!');
end;

function TextToFloat(Buffer: PChar; var Value: Extended): Boolean;
var
  Error: Integer;
  Tmp: string;
  P: Integer;
begin
  Tmp := StrPas(Buffer);
  P := Pos(DecimalSeparator, Tmp);
  if P <> 0 then Tmp[P] := '.';
  Val(Tmp, Value, Error);
  Result := (Error = 0);
end;

function FloatToTextFmt(Buffer: PChar; Value: Extended; Format: PChar): Integer;
var
  Digits: string[40];                         { Ziffern-String                   }
  Exponent: string[8];                        { Exponenten-String                }
  FmtStart, FmtStop: PChar;                   { Anfang und Ende des relevanten   }
                                              { Teils des Formatstrings          }
  ExpFmt, ExpSize: Integer;                   { Formatangaben fÅr                }
                                              { Exponentialdarstellung           }
  Placehold: array[1..4] of Integer;          { Platzhalter in den 4 Bereichen   }
  Thousand: Boolean;                          { Tausender-Separatoren?           }
  UnexpectedDigits: Integer;                  { Anzahl der Zeichen, um die die   }
                                              { formatierte Zahl die Platzhalter }
                                              { Åberschreitet. Diese Zeichen     }
                                              { werden vor der ersten Ziffer     }
                                              { ausgegeben                       }
  DigitExponent: Integer;                     { Exponent der ersten Ziffer       }
                                              { von Digits                       }

  { Ermittle das Ende der Format-Sektion, die mit P beginnt. False, wenn leer. }

  function GetSectionEnd(var P: PChar): Boolean;
  var
    C: Char;
    SQ, DQ: Boolean;
  begin
    Result := False;
    SQ := False;
    DQ := False;
    C := P[0];
    while (C <> #0) and ((C <> ';') or SQ or DQ) do
    begin
      Result := True;
      case C of
        #34: if not SQ then DQ := not DQ;
        #39: if not DQ then SQ := not SQ;
      end;
      Inc(P);
      C := P[0];
    end;
  end;

  { Ermittle Anfang und Ende der benîtigten Format-Sektion. Ist die Sektion nicht
    vorhanden, weiche auf Sektion 1 aus. Falls Sektion 2 gewÑhlt wird, geht das
    Vorzeichen von Value verloren. }

  procedure GetSectionRange(Section: Integer);
  var
    Sec: array[1..3] of PChar;
    SecOk: array[1..3] of Boolean;
  begin
    Sec[1] := Format;
    SecOk[1] := GetSectionEnd(Sec[1]);
    if Section > 1 then
    begin
      Sec[2] := Sec[1];
      if Sec[2][0] <> #0 then Inc(Sec[2]);
      SecOk[2] := GetSectionEnd(Sec[2]);
      if Section > 2 then
      begin
        Sec[3] := Sec[2];
        if Sec[3][0] <> #0 then Inc(Sec[3]);
        SecOk[3] := GetSectionEnd(Sec[3]);
      end;
    end;
    if not SecOk[1] then FmtStart := nil
    else
    begin
      if not SecOk[Section] then Section := 1
      else if Section = 2 then Value := -Value;   { Vorzeichen beseitigen }
      if Section = 1 then FmtStart := Format else
      begin
        FmtStart := Sec[Section - 1];
        Inc(FmtStart);
      end;
      FmtStop := Sec[Section];
    end;
  end;

  { Ermittle die Format-Optionen der Sektion, die von FmtStart bis FmtStop geht. }

  procedure GetFormatOptions;
  var
    Fmt: PChar;
    SQ, DQ: Boolean;
    Area: Integer;
  begin
    SQ := False;
    DQ := False;
    Fmt := FmtStart;
    ExpFmt := 0;
    Area := 1;
    Thousand := False;
    PlaceHold[1] := 0;
    PlaceHold[2] := 0;
    PlaceHold[3] := 0;
    PlaceHold[4] := 0;

    while Fmt <> FmtStop do
    begin
      case Fmt[0] of
        #34:
        begin
          if not SQ then DQ := not DQ;
          Inc(Fmt);
        end;

        #39:
        begin
          if not DQ then SQ := not SQ;
          Inc(Fmt);
        end;

        else if not SQ or DQ then
        case Fmt[0] of
          '0':
          begin
            case Area of
              1:
                Area := 2;
              4:
                begin
                  Area := 3;
                  Inc(Placehold[3], PlaceHold[4]);
                  PlaceHold[4] := 0;
                end;
            end;
            Inc(PlaceHold[Area]);
            Inc(Fmt);
          end;

          '#':
          begin
            if Area = 3 then Area := 4;
            Inc(PlaceHold[Area]);
            Inc(Fmt);
          end;

          '.':
          begin
            if Area < 3 then Area := 3;
            Inc(Fmt);
          end;

          ',':
          begin
            Thousand := True;
            Inc(Fmt);
          end;

          'e', 'E':
          if ExpFmt = 0 then
          begin
            if Fmt[0] = 'E' then ExpFmt := 1 else ExpFmt := 3;
            Inc(Fmt);
            if Fmt <> FmtStop then
            begin
              case Fmt[0] of
                '+':
                begin
                end;

                '-':
                Inc(ExpFmt);

                else ExpFmt := 0;
              end;
              if ExpFmt <> 0 then
              begin
                Inc(Fmt);
                ExpSize := 0;
                while (Fmt <> FmtStop) and (ExpSize < 4) and (Fmt[0] in ['0'..'9']) do
                begin
                  Inc(ExpSize);
                  Inc(Fmt);
                end;
              end;
            end;
          end
          else Inc(Fmt);

          else Inc(Fmt);

        end; { CASE }
      end; { CASE }
    end; { WHILE .. BEGIN }
  end;

  function _Abs(E: Extended): Extended;
  begin
    if E < 0 then E := -E;
    Result := E;
  end;

  procedure FloatToStr;
  var
    I, J, Exp, Width, Decimals, DecimalPoint, Len: Integer;
  begin
    if ExpFmt = 0 then
    begin
      { Fixpoint }
      Decimals := PlaceHold[3] + PlaceHold[4];
      Width := PlaceHold[1] + PlaceHold[2] + Decimals;

      if Decimals = 0 then Str(Value: Width: 0, Digits)
      else Str(Value: Width + 1: Decimals, Digits);

      Len := Length(Digits);

      { Position des Punktes ermitteln }
      if Decimals = 0 then DecimalPoint := Len  + 1 else DecimalPoint := Len - Decimals;

      { Falls Zahl < 1 und keine Vorkommastellen gewÅnscht, 0 beseitigen }
      if (_Abs(Value) < 1) {(Value < 1) and (Value > -1)} and (PlaceHold[2] = 0) then
         { ^--- Wegen Bug! }
      begin
        if PlaceHold[1] = 0 then Delete(Digits, DecimalPoint - 1, 1)
        else Digits[DecimalPoint - 1] := ' ';
      end;

      { Optionale Nullen rechts in Leerzeichen umwandeln }
      I := Len;
      J := DecimalPoint + PlaceHold[3];
      while (I > J) and (Digits[I] = '0') do
      begin
        Digits[I] := ' ';
        Dec(I);
      end;

      { Falls ganze Zahl und keine Pflicht-Nachkommastellen, Komma entfernen }

      if (DecimalPoint < Len) and (Digits[DecimalPoint + 1] = ' ') then
          Digits[DecimalPoint] := ' ';

      { Leerzeichen an 'Pflicht'-Stellen links des Kommas in '0' Ñndern }

      I := DecimalPoint - PlaceHold[2];
      while (I < DecimalPoint) and (Digits[I] = ' ') do
      begin
        Digits[I] := '0';
        Inc(I);
      end;

      Exp := 0;
    end
    else
    begin
      { Scientific: Exactly <Width> digits with <Precision> decimals
        and adjusted exponent. }
      if PlaceHold[1] + PlaceHold[2] = 0 then PlaceHold[1] := 1;

      Decimals := PlaceHold[3] + PlaceHold[4];
      Width := PlaceHold[1] + PlaceHold[2] + Decimals;

      Str(Value: Width + 8, Digits);

      { Exponenten ermitteln und herausschneiden }
      I := Length(Digits) - 5;
      Val(Copy(Digits, I  + 1, 5), Exp, J);
      Exp := Exp + 1 - (PlaceHold[1] + PlaceHold[2]);
      Delete(Digits, I, 6);

      { Weil Str() bei Exponentialdarstellung mindestens eine Nachkommastelle
        liefert, mÅssen wir die eventuell beseitigen, wenn wir keine wollen. }
      if (Decimals = 0) and (PlaceHold[1] + PlaceHold[2] <= 1) then
      begin
        if Digits[4] >= '5' then
        begin
          Inc(Digits[2]);
          if Digits[2] > '9' then
          begin
            Digits[2] := '1';
            Inc(Exp);
          end;
        end;
        Delete(Digits, 3, 2);
        DecimalPoint := Length(Digits) + 1;
      end
      else
      begin
//      WriteLn(Digits);

        { Komma hinter die gewÅnschte Vorkommstellen versetzen }
        Delete(Digits, 3, 1);
        DecimalPoint := 2 + PlaceHold[1] + PlaceHold[2];
        if Decimals <> 0 then Insert('.', Digits, DecimalPoint);
      end;

//      WriteLn(Digits);

      { Optionale Nullen rechts in Leerzeichen umwandeln }
      I := Length(Digits);
      J := DecimalPoint + PlaceHold[3];
      while (I > J) and (Digits[I] = '0') do
      begin
        Digits[I] := ' ';
        Dec(I);
      end;

      { Falls ganze Zahl und keine Pflicht-Nachkommastellen, Komma entfernen }

      if (DecimalPoint < Length(Digits)) and (Digits[DecimalPoint + 1] = ' ') then
          Digits[DecimalPoint] := ' ';

      if Digits[1] = ' ' then
      begin
        Delete(Digits, 1, 1);
        Dec(DecimalPoint);
      end;

      { Exponent-String berechnen }
      Str(Abs(Exp), Exponent);
      while Length(Exponent) < ExpSize do Insert('0', Exponent, 1);
      if Exp >= 0 then
      begin
        if ExpFmt in [1, 3] then Insert('+', Exponent, 1);
      end
      else Insert('-', Exponent, 1);
      if ExpFmt < 3 then Insert('E', Exponent, 1) else Insert('e', Exponent, 1);
    end;

    DigitExponent := DecimalPoint - 2;
    if Digits[1] = '-' then Dec(DigitExponent);

    UnexpectedDigits := DecimalPoint - 1 - (PlaceHold[1] + PlaceHold[2]);
  end;

  function PutResult: LongInt;
  var
    SQ, DQ: Boolean;
    Fmt, Buf: PChar;
    Dig, N, I: Integer;
  begin
    SQ := False;
    DQ := False;
    Fmt := FmtStart;
    Buf := Buffer;
    Dig := 1;

    while Fmt <> FmtStop do
    begin
      case Fmt[0] of
        #34:
        begin
          if not SQ then DQ := not DQ;
          Inc(Fmt);
        end;

        #39:
        begin
          if not DQ then SQ := not SQ;
          Inc(Fmt);
        end;

        else
        if not SQ or DQ then
        begin
          case Fmt[0] of
            '0', '#', '.':
            begin
              if (Dig = 1) and (UnexpectedDigits > 0) then
              begin
                { Vor der ersten Ziffer alles ausgeben, was zuviel ist }
                for N := 1 to UnexpectedDigits do
                begin
                  Buf[0] := Digits[N];
                  Inc(Buf);
                  if Thousand and (Digits[N] <> '-') then
                  begin
                    if (DigitExponent mod 3 = 0) and (DigitExponent > 0) then
                    begin
                      Buf[0] := ThousandSeparator;
                      Inc(Buf);
                    end;
                    Dec(DigitExponent);
                  end;
                end;
                Inc(Dig, UnexpectedDigits);
              end;

              if Digits[Dig] <> ' ' then
              begin
                if Digits[Dig] = '.' then Buf[0] := DecimalSeparator
                else Buf[0] := Digits[Dig];
                Inc(Buf);
                if Thousand and (DigitExponent mod 3 = 0) and (DigitExponent > 0) then
                begin
                  Buf[0] := ThousandSeparator;
                  Inc(Buf);
                end;
              end;
              Inc(Dig);
              Dec(DigitExponent);
              Inc(Fmt);
            end;

            'e', 'E':
            if ExpFmt <> 0 then
            begin
              Inc(Fmt);
              if Fmt <> FmtStop then
              begin
                if Fmt[0] in ['+', '-'] then
                begin
                  Inc(Fmt, ExpSize);
                  for N := 1 to Length(Exponent) do Buf[N - 1] := Exponent[N];
                  Inc(Buf, Length(Exponent));
                  ExpFmt := 0;
                end;
                Inc(Fmt);
              end;
            end; { DIESES SEMIKOLON AUF KEINEM FALL ENTFERNEN!!! }

            else
            begin
              { Gewîhnliches Zeichen }
              if Fmt[0] <> ',' then
              begin
                Buf[0] := Fmt[0];
                Inc(Buf);
              end;
              Inc(Fmt);
            end;

          end; { CASE }
        end
        else
        begin
          { Zeichen innerhalb von Hochkommas }
          Buf[0] := Fmt[0];
          Inc(Buf);
          Inc(Fmt);
        end;
      end; { CASE }
    end; { WHILE .. BEGIN }
    Result := LongInt(Buf) - LongInt(Buffer);
  end;

begin
  if Value > 0 then GetSectionRange(1)
  else if Value < 0 then GetSectionRange(2)
  else GetSectionRange(3);

  if FmtStart = nil then
  begin
    { WriteLn('No format sections available.'); }
    Result := FloatToText(Buffer, Value, ffGeneral, 15, 4);
  end
  else
  begin
    GetFormatOptions;
    { WriteLn('Parsing complete'); }
    if (ExpFmt = 0) and (_Abs(Value) >= 1E18) then Result := FloatToText(Buffer, Value, ffGeneral, 15, 4)
    else
    begin
      FloatToStr;
{
      WriteLn('FloatToStr() complete: "', Digits, '" / ', Exponent);
      WriteLn('Unexpected digits: ', UnexpectedDigits);
      WriteLn('DigitExponent: ', DigitExponent);}
      Result := PutResult;
{      WriteLn('PutResult() complete'); }
    end;
  end;
end;

function FormatFloat(const Format: string; Value: Extended): string;
var
  Temp: cstring[128];
begin
  Temp := Format;
  SetLength(Result, FloatToTextFmt(@Result[1], Value, @Temp));
end;

procedure FloatToDecimal(var Result: TFloatRec; Value: Extended; Precision, Decimals: Integer);
var
  Buffer: string[24];
  Error, N: Integer;
begin
{  if Precision > 15 then Precision := 15;
   if Decimals > 15 then Decimals := 15; }

  Str(Value:23, Buffer);
  {WriteLn('Buffer is: ', Buffer);}

  Result.Negative := (Buffer[1] = '-');
  Val(Copy(Buffer, 19, 5), Result.Exponent, Error);
  Inc(Result. Exponent);
  {WriteLn('Exponent is: ', Result.Exponent);}

  Result.Digits[0] := Buffer[2];
  Move(Buffer[4], Result.Digits[1], 14);

  if Decimals + Result.Exponent < Precision then N := Decimals + Result.Exponent
  else N := Precision;

  {WriteLn('Cut point is ', N);}

  if N > 15 then N := 15;

  {WriteLn('That makes ', N, ' with our precision.');}

  {WriteLn;}

  if N = 0 then
  begin
    if Result.Digits[0] >= '5' then
    begin
      Result.Digits[0] := '1';
      Result.Digits[1] := #0;
      Inc(Result.Exponent);
    end
    else Result.Digits[0] := #0;
  end
  else if N > 0 then
  begin
    if Result.Digits[N] >= '5' then
    begin
      { Round up }
      repeat
        Result.Digits[N] := #0;
        Dec(N);
        Inc(Result.Digits[N]);
      until (N = 0) or (Result.Digits[N] < ':');
      if Result.Digits[0] = ':' then
      begin
        Result.Digits[0] := '1';
        Inc(Result.Exponent);
      end;
    end
    else
    begin
      { Cut zeros }
      Result.Digits[N] := '0';
      while (Result.Digits[N] = '0') and (N > -1) do
      begin
        Result.Digits[N] := #0;
        Dec(N);
      end;
    end;
  end
  else Result.Digits[0] := #0;

  if Result.Digits[0] = #0 then
  begin
    { Zero has neither exponent nor signum }
    Result.Exponent := 0;
    Result.Negative := False;
  end;
end;

{ Time encoding and decoding }

function _EncodeDate(var Date: TDateTime; Year, Month, Day: LongWord): Boolean;
var
  LeapYear: Boolean;
begin
  if (Year <= 9999) and (Month in [1..12]) and (Day in [1..31]) then
  begin
    LeapYear := (Year mod 4 = 0) and not (Year mod 100 = 0) or (Year mod 400 = 0);
    Dec(Year);
    Date := Year * 365 + Year div 4 - Year div 100 + Year div 400
            + 1 + DaysPassed[LeapYear, Month] + Day - 1;
    Result := True;
  end
  else Result := False;
end;

function _EncodeTime(var Time: TDateTime; Hour, Min, Sec, MSec: LongWord): Boolean;
var
  Temp: LongWord;
begin
  if (Hour < 24) and (Min < 60) and (Sec < 60) and (MSec < 1000) then
  begin
    Time := (((Hour * 60 + Min) * 60 + Sec) * 1000 + MSec) / MSecsPerDay;
    Result := True
  end
  else Result := False;
end;

function EncodeDate(Year, Month, Day: Word): TDateTime;
begin
  if not _EncodeDate(Result, Year, Month, Day) then ConvertError('Bla');
end;

function EncodeTime(Hour, Min, Sec, MSec: Word): TDateTime;
begin
  if not _EncodeTime(Result, Hour, Min, Sec, MSec) then ConvertError('Bla');
end;

procedure DecodeDate(Date: TDateTime; var Year, Month, Day: Word);
const
  Days400 = 146097;
  Days100 = 36524;
  Days4   = 1461;
var
  Cnt, DayNum: LongInt;
  LeapYear: Boolean;
begin
  DayNum := Trunc(Date);

  Year := 1;

  while DayNum > Days400 do
    begin
      Inc(Year, 400);
      Dec(DayNum, Days400);
    end;

  Cnt := 0;
  while (DayNum > Days100) and (Cnt < 3) do
    begin
      Inc(Year, 100);
      Dec(DayNum, Days100);
      Inc(Cnt);
    end;

  while DayNum > Days4 do
    begin
      Inc(Year, 4);
      Dec(DayNum, Days4);
    end;

  Cnt := 0;
  while (DayNum > 365) and (Cnt < 3) do
    begin
      Inc(Year);
      Dec(DayNum, 365);
      Inc(Cnt);
    end;

  LeapYear := (Year mod 4 = 0) and not (Year mod 100 = 0) or (Year mod 400 = 0);

  Month := 0;
  while DaysPassed[LeapYear, Month + 1] < DayNum do
    Inc(Month);

  Day := DayNum - DaysPassed[LeapYear, Month];
end;

procedure DecodeTime(Time: TDateTime; var Hour, Min, Sec, MSec: Word);
begin
  Time := Frac(Time) * 24;
  Hour := Trunc(Time);
  Time := Frac(Time) * 60;
  Min  := Trunc(Time);
  Time := Frac(Time) * 60;
  Sec  := Trunc(Time);
  MSec := Trunc(Frac(Time) * 1000);
end;

function DayOfWeek(Date: TDateTime): Integer;
begin
  DayOfWeek := 1 + (1 + Trunc(Date)) mod 7;
end;

function Date: TDateTime;
var
  DT: DATETIME;
begin
  DosGetDateTime (DT);
  Date := EncodeDate(DT.Year, DT.Month, DT.Day);
end;

function Time: TDateTime;
var
  DT: DATETIME;
begin
  DosGetDateTime (DT);
  Time := EncodeTime(DT.Hour, DT.Min, DT.Sec, DT.Hundredths * 10);
end;

function Now: TDateTime;
var
  DT: DATETIME;
begin
  DosGetDateTime (DT);
  Now := EncodeDate(DT.Year, DT.Month, DT.Day) + EncodeTime(DT.Hour, DT.Min, DT.Sec, DT.Hundredths * 10);
end;

{ Date/time to string conversions }

procedure DateTimeToString(var Result: string; const Format: string; DateTime: TDateTime);
var
  Year, Month, Day, Hour, Min, Sec, MSec, Hour12: Integer;
  BeforeNoon: Boolean;

  procedure _DateTimeToString(var Result: string; const Format: string; Recursive: Boolean);
    { Internal function to control recursion in format specifiers. Avoids
      stack overflow when format strings contain macros for other format
      strings. }

  var
    Start, Count, Pos, Len, LastHourPos, LastHourSize, Tmp: Integer;
    Token: Char;
    UseMinutes: Boolean;

    procedure AppendInt(I, Digits: Integer);
    var
      S: string[5];
      P: Integer;
    begin
      Str(I:Digits, S);
      P := 1;
      while S[P] = ' ' do
      begin
        S[P] := '0';
        Inc(P);
      end;
      AppendStr(Result, S);
    end;

    procedure AppendStr(const S: string);
    begin
      Insert(S, Result, Length(Result) + 1);
    end;

    function CountChar(C: Char; Max: Integer): Integer;
    var
      Result: Integer;
    begin
      Result := 1;
      while (Pos <= Len) and (UpCase(Format[Pos]) = C) and (Result < Max) do
      begin
        Inc(Pos);
        Inc(Result);
      end;
      CountChar := Result;
    end;

    function IsSubStr(const S: string): Boolean;
    begin
      IsSubStr := (UpperCase(Copy(Format, Pos, Length(S))) = S);
    end;

    procedure GetNextToken(BeforeNoon: Boolean);
    begin
      Start := Pos;
      Token := UpCase(Format[Pos]);
      Inc(Pos);
      case Token of
        #34,
        #39: begin
               Inc(Start);
               while (Pos <= Len) and (Format[Pos] <> Token) do Inc(Pos);
               Count := Pos - Start;
               if Pos < Len then Inc(Pos);
               Token := '$';
             end;
        'D': Count := CountChar('D', 6);
        'M': Count := CountChar('M', 4);
        'Y': Count := CountChar('Y', 4);
        'H',
        'N',
        'S',
        'T': Count := CountChar(Token, 2);
        'A': begin
               if IsSubStr('MPM') then
               begin
                 Inc(Pos, 3);
                 Count := 0;
               end
               else if IsSubStr('/P') then
               begin
                 Inc(Pos, 2);
                 if not BeforeNoon then Inc(Start, 2);
                 Count := 1;
               end
               else if IsSubStr('M/PM') then
               begin
                 Inc(Pos, 4);
                 if not BeforeNoon then Inc(Start, 3);
                 Count := 2;
               end
               else
               begin
                 Token := '$';
                 Count := 1;
               end;
             end;
        'C',
        '/',
        ':': begin
               { Nope }
             end;
        else begin
               Token := '$';
               Count := 1;
               while (Pos <= Len) and not (UpCase(Format[Pos]) in
                   [#34, #39, 'A', 'C', 'D', 'H', 'M', 'N', 'S', 'T', 'Y', ':', '/']) do
               begin
                 Inc(Pos);
                 Inc(Count);
               end;
             end;
      end;

      if (Token = 'M') and UseMinutes then Token := 'N';

      case Token of
        'H': UseMinutes := True;
        'A', 'C', 'D', 'M', 'N', 'S', 'T', 'Y': UseMinutes := False;
      end;
    end;

  begin
    Pos := 1;
    Len := Length(Format);
    LastHourPos := 0;
    UseMinutes := False;

    if Len = 0 then _DateTimeToString(Result, 'C', True)
    else while (Pos <= Len) do
    begin
      GetNextToken(BeforeNoon);
      // WriteLn('Token=', Token, ' Start=', Start, ' Count=', Count);
      case Token of
        'C': if Recursive then
             begin
               _DateTimeToString(Result, ShortDateFormat, False);
               if (Hour + Min + Sec) > 0 then
               begin
                 AppendStr(' ');
                 _DateTimeToString(Result, LongTimeFormat, False);
               end;
             end
             else AppendStr('C');
        'D': case Count of
               1: AppendInt(Day, 1);
               2: AppendInt(Day, 2);
               3: AppendStr(ShortDayNames[DayOfWeek(DateTime)]);
               4: AppendStr(LongDayNames[DayOfWeek(DateTime)]);
               5: if Recursive then _DateTimeToString(Result, ShortDateFormat, False)
                  else AppendStr('DDDDD');
               6: if Recursive then _DateTimeToString(Result, LongDateFormat, False)
                  else AppendStr('DDDDDD');
             end;
        'M': case Count of
               1: AppendInt(Month, 1);
               2: AppendInt(Month, 2);
               3: AppendStr(ShortMonthNames[Month]);
               4: AppendStr(LongMonthNames[Month]);
             end;
        'Y': case Count of
               1, 2: AppendInt(Year mod 100, 2);
               3, 4: AppendInt(Year, 4);
             end;
        'H': begin
               LastHourPos := Length(Result) + 1;
               LastHourSize := Count;
               AppendInt(Hour, Count);
             end;
        'N': AppendInt(Min, Count);
        'S': AppendInt(Sec, Count);
        'T': case Count of
               1: if Recursive then _DateTimeToString(Result, ShortTimeFormat, False)
                  else AppendStr('T');
               2: if Recursive then _DateTimeToString(Result, LongTimeFormat, False)
                  else AppendStr('TT');
             end;
        'A': begin
               if LastHourPos <> 0 then
               begin
                 if (LastHourSize = 1) and (Hour < 10) then Tmp := 1
                 else Tmp := 2;
                 Delete(Result, LastHourPos, Tmp);
                 if (LastHourSize = 2) and (Hour12 < 10) then
                     Insert('0' + IntToStr(Hour12), Result, LastHourPos)
                 else Insert(IntToStr(Hour12), Result, LastHourPos);
                 LastHourPos := 0;
               end;
               case Count of
                 0: if BeforeNoon then AppendStr(TimeAMString)
                    else AppendStr(TimePMString);
                 1: AppendStr(Format[Start]);
                 2: AppendStr(Format[Start] + Format[Start  + 1]);
               end
             end;
        '/': AppendStr(DateSeparator);
        ':': AppendStr(TimeSeparator);
        '$': AppendStr(Copy(Format, Start, Count));
      end;
    end;
  end;

begin
  DecodeDate(DateTime, Year, Month, Day);
  DecodeTime(DateTime, Hour, Min, Sec, MSec);

  if (Hour = 0) or (Hour > 12) then
  begin
    if Hour = 0 then Hour12 := 12
    else Hour12 := Hour - 12;
    BeforeNoon := False;
  end
  else
  begin
    BeforeNoon := True;
    Hour12 := Hour;
  end;
  Result := '';

  if Length(Format) <> 0 then _DateTimeToString(Result, Format, True)
  else _DateTimeToString(Result, 'C', True)
end;

function DateToStr(Date: TDateTime): string;
begin
  DateTimeToString(Result, ShortDateFormat, Date);
end;

function TimeToStr(Time: TDateTime): string;
begin
  DateTimeToString(Result, LongTimeFormat, Time);
end;

function DateTimeToStr(DateTime: TDateTime): string;
begin
  DateTimeToString(Result, ShortDateFormat + ' ' + LongTimeFormat, DateTime);
end;

function FormatDateTime(const Format: string; DateTime: TDateTime): string;
begin
  DateTimeToString(Result, Format, DateTime);
end;

{ String to date/time conversions }

procedure IgnoreSpaces(const S: string; var Pos: Integer; Len: Integer);
begin
  while (Pos <= Len) and (S[Pos] = ' ') do Inc(Pos);
end;

function GetNumber(var Num: Integer; const S: string; var Pos: Integer; Len: Integer): Boolean;
begin
  Result := False;
  Num := 0;
  IgnoreSpaces(S, Pos, Len);
  while (Pos <= Len) and (S[Pos] in ['0'..'9']) do
  begin
    Result := True;
    Num := Num * 10 + Ord(S[Pos]) - 48;
    Inc(Pos);
  end;
end;

function CompareString(const SubStr, S: string; var Pos: Integer; Len: Integer): Boolean;
begin
  if CompareText(SubStr, Copy(S, 1, Length(SubStr))) = 0 then
  begin
    Result := True;
    Inc(Pos, Length(SubStr));
  end
  else Result := False;
end;

function CompareChar(C: Char; S: string; var Pos: Integer; Len: Integer): Boolean;
begin
  if (Pos <= Len) and (UpCase(C) = UpCase(S[Pos])) then
  begin
    Result := True;
    Inc(Pos);
  end
  else Result := False;
end;

function CutString(var S: string; Separator: Char): string;
var
  P: Integer;
begin
  P := Pos(Separator, S);
  if P = 0 then P := Length(S) + 1;
  Result := Copy(S, 1, P - 1);
  Delete(S, 1, P);
end;

function ParseDate(var Date: TDateTime; const S: String; var Pos: Integer; Len: Integer): Boolean;
var
  Head, Temp: string[15];
  N, Year, Month, Day: Integer;
  Number: array[1..3] of Integer;
  Order: string[3];

  function GetCurrentYear: Integer;
  var
    M, D: Integer;
  begin
    DecodeDate(Now, Result, M, D);
  end;

begin
  Order := 'XXX';

  Result := False;

  if not GetNumber(Number[1], S, Pos, Len) then Exit;
  if not CompareChar(DateSeparator, S, Pos, Len) then Exit;
  if not GetNumber(Number[2], S, Pos, Len) then Exit;
  if not CompareChar(DateSeparator, S, Pos, Len) then Exit;
  if not GetNumber(Number[3], S, Pos, Len) then Number[3] := -1;

  for N := 1 to 3 do WriteLn(Number[N]);

  Temp := ShortDateFormat;

  for N := 1 to 3 do
  begin
    Head := CutString(Temp, '/');
    if Length(Head) <> 0 then Order[N] := UpCase(Head[1]);
  end;

  if Order = 'MDY' then
  begin
    Month := Number[1];
    Day := Number[2];
    Year := Number[3];
  end
  else if Order = 'DMY' then
  begin
    WriteLn('DMY');
    Day := Number[1];
    Month := Number[2];
    Year := Number[3];
  end
  else if Order = 'YMD' then
  begin
    if Number[3] = -1 then
    begin
      Year := -1;
      Month := Number[1];
      Day := Number[2];
    end
    else
    begin
      Year := Number[1];
      Month := Number[2];
      Day := Number[3];
    end;
  end;

  if Year = -1 then Year := GetCurrentYear
  else if Year < 100 then Inc(Year, 1900);

  Result := True;
  Result := _EncodeDate(Date, Year, Month, Day);
end;

function ParseTime(var Time: TDateTime; const S: String; var Pos: Integer; Len: Integer): Boolean;
var
  Hour, Min, Sec: Word;
begin
  Result := False;

  if not GetNumber(Hour, S, Pos, Len) then Exit;
  if not CompareChar(TimeSeparator, S, Pos, Len) then Exit;
  if not GetNumber(Min, S, Pos, Len) then Exit;
  if CompareChar(TimeSeparator, S, Pos, Len) and not GetNumber(Sec, S, Pos, Len) then Exit;

  IgnoreSpaces(S, Pos, Len);
  if CompareChar('A', S, Pos, Len) then
  begin
    CompareChar('M', S, Pos, Len);
    if Hour = 12 then Hour := 0;
  end
  else if CompareChar('P', S, Pos, Len) then
  begin
    CompareChar('M', S, Pos, Len);
    if (Hour >= 1) and (Hour <= 11) then Inc(Hour, 12);
  end;

  Result := _EncodeTime(Time, Hour, Min, Sec, 0);
end;

function StrToDate(const S: string): TDateTime;
var
  Pos, Len: Integer;
begin
  Pos := 1;
  Len := Length(S);
  if not ParseDate(Result, S, Pos, Len) then ConvertError('No legal Date!');
end;

function StrToTime(const S: string): TDateTime;
var
  Pos, Len: Integer;
begin
  Pos := 1;
  Len := Length(S);
  if not ParseTime(Result, S, Pos, Len) then ConvertError('No legal Time!');
end;

function StrToDateTime(const S: string): TDateTime;
var
  Time: TDateTime;
  Pos, Len: Integer;
begin
  Pos := 1;
  Len := Length(S);
  if not ParseDate(Result, S, Pos, Len) then ConvertError('No legal date!');
  if ParseDate(Time, S, Pos, Len) then Result := Result + Time;
end;

{ Initialization file support }

{$ifdef PM }

var
  UserProfile: HINI;

imports

FUNCTION PrfQueryProfileInt(ahini:HINI;CONST pszApp,pszKey:CSTRING;
             sDefault:LONG):LONG;
             APIENTRY; PMSHAPI index 114;

FUNCTION PrfQueryProfileString(ahini:HINI;CONST pszApp,pszKey,pszDefault: CSTRING;
             pBUFFER: PCHAR; cchBufferMax:ULONG):ULONG;
             APIENTRY; PMSHAPI index 115;

end;

{
function OpenProfile: Boolean;
var
  Info: PRFPROFILE;
  Name: cstring[256];
begin
  Info.cchUserName := 256;
  Info.pszUserName := @Name;
  Info.cchSysName := 0;
  Info.pszSysName := @Name;
  Result := PrfQueryProfile(AppHandle, Info);
  if not Result then Exit;
  UserProfile := PrfOpenProfile(AppHandle, Name);
end;

procedure CloseProfile;
begin
  PrfCloseProfile(UserProfile);
end;
}

function GetProfileStr(const Section, Entry: cstring; const Default: string): string;
var
  CDefault: cstring[256];
begin
  CDefault := Default;
  SetLength(Result, PrfQueryProfileString(HINI_UserProfile, Section,
      Entry, CDefault, @Result[1], 255));
end;

function GetProfileChar(const Section, Entry: cstring; Default: Char): Char;
var
  InBuf, OutBuf: cstring[2];
begin
  InBuf[0] := Default;
  InBuf[1] := #0;
  PrfQueryProfileString(HINI_UserProfile, Section, Entry, InBuf, @OutBuf, 2);
  Result := OutBuf[0];
end;

function GetProfileInt(const Section, Entry: cstring; Default: Integer): Integer;
begin
  Result := PrfQueryProfileInt(HINI_UserProfile, Section, Entry, Default);
end;

procedure GetFormatSettings;
const
  Key = 'PM_National';
var
  Temp: Integer;
begin
  // if not OpenProfile then Exit;

  TimeAmString := GetProfileStr(Key, 's1159', 'am');
  TimePmString := GetProfileStr(Key, 's2359', 'pm');
  CurrencyString := GetProfileStr(Key, 'sCurrency', '$');
  ThousandSeparator := GetProfileChar(Key, 'sThousand', ',');
  DecimalSeparator := GetProfileChar(Key, 'sDecimal', '.');
  DateSeparator := GetProfileChar(Key, 'sDate', '/');
  TimeSeparator := GetProfileChar(Key, 'sTime', ':');
  ListSeparator := GetProfileChar(Key, 'sList', 'X');

  DateOrder := GetProfileInt(Key, 'iDate', 0);
  case DateOrder of
    0: begin
         ShortDateFormat := 'm/d/yy';
         LongDateFormat := 'mm/dd/yyyy';
       end;
    1: begin
         ShortDateFormat := 'd/m/yy';
         LongDateFormat := 'dd/mm/yyyy';
       end;
    2: begin
         ShortDateFormat := 'y/m/dd';
         LongDateFormat := 'yyyy/mm/dd';
       end;
  end;

  CurrencyFormat := GetProfileInt(Key, 'iCurrency', 0);

  case CurrencyFormat of
    0: NegCurrFormat := 1;
    1: NegCurrFormat := 5;
    2: NegCurrFormat := 9;
    3: NegCurrFormat := 8;
  end;

  CurrencyDecimals := GetProfileInt(Key, 'iDigits', 2);

  case GetProfileInt(Key, 'iLzero', 0) of
    0: begin
         ShortTimeFormat := 'h:mm';
         LongTimeFormat := 'h:mm:ss';
       end;
    1: begin
         ShortTimeFormat := 'hh:mm';
         LongTimeFormat := 'hh:mm:ss';
       end;
  end;

  if GetProfileInt(Key, 'iTime', 0) = 0 then
  begin
    ShortTimeFormat := ShortTimeFormat + ' ampm';
    LongTimeFormat := LongTimeFormat + ' ampm';
    TwelveHours := True;
  end
  else TwelveHours := False;

  // CloseProfile;
end;

{$else}

procedure GetFormatSettings;
var
  CC: COUNTRYCODE;
  CI: COUNTRYINFO;
  L: LongInt;
begin
  CC.Country :=  0;
  CC.CodePage := 0;
  if DosQueryCtryInfo(SizeOf(CI), CC, CI, L) <> NO_ERROR then Halt(255);

  CurrencyString := CI.szCurrency;
  CurrencyFormat := CI.fsCurrencyFmt;

  ThousandSeparator := CI.szThousandsSeparator[0];
  DecimalSeparator := CI.szDecimal[0];
  DateSeparator := CI.szDateSeparator[0];
  TimeSeparator := CI.szTimeSeparator[0];
  ListSeparator := CI.szDataSeparator[0];
  CurrencyDecimals := CI.cDecimalPlace;

  case CurrencyFormat of
    0: NegCurrFormat := 1;
    1: NegCurrFormat := 5;
    2: NegCurrFormat := 9;
    3: NegCurrFormat := 8;
  end;

  DateOrder := CI.fsDateFmt;
  case DateOrder of
    0: begin
         ShortDateFormat := 'mm/dd/yy';
         LongDateFormat := 'mm/dd/yyyy';
       end;
    1: begin
         ShortDateFormat := 'dd/mm/yy';
         LongDateFormat := 'dd/mm/yyyy';
       end;
    2: begin
         ShortDateFormat := 'yy/mm/dd';
         LongDateFormat := 'yyyy/mm/dd';
       end;
  end;

  case CI.fsTimeFmt of
    0: begin
         ShortTimeFormat := 'hh:mm ampm';
         LongTimeFormat := 'hh:mm:ss ampm';
         TwelveHours := True;
       end;
    1: begin
         ShortTimeFormat := 'hh:mm';
         LongTimeFormat := 'hh:mm:ss';
         TwelveHours := False;
       end;
  end;

  DosQueryCollate(256, CC, CollatingSequence, L);
end;

{$endif}

begin
  GetFormatSettings;
end.

{
  Changes: 25-11-95 - CompareText optimized
           28-11-95 - OpenProfile / CloseProfile entfernt (weil
                      ÅberflÅssig)
           30-11-95 - Fehler in FindFirst/FindNext beseitigt
           07-12-95 - Neue Funktion EditFileName
           08.12.95 - Kleine énderung an NewStr / DisposeStr
           18.12.95 - Neue Funktionen FileOpenOrCreate und
                      FileCreateIfNew fÅr atomare Operationen bei
                      z.B. LogFiles
}
