UNIT Streams;

{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Speed-Pascal Component Classes (SPCC)                                     บ
บ                                                                           บ
บ This file: Streams class definitions                                      บ
บ                                                                           บ
บ Last modified: September 1995                                             บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

INTERFACE

USES SysUtils;

TYPE
    EStreamReadError=CLASS(Exception);
    EStreamWriteError=CLASS(Exception);
    EStreamCreateError=CLASS(Exception);
    EStreamOpenError=CLASS(Exception);
    EStreamSeekError=CLASS(Exception);

CONST
    StreamReadErrorText   = 'TStream read error exception (EStreamReadError) occured';
    StreamWriteErrorText  = 'TStream write error exception (EStreamReadError) occured';
    StreamCreateErrorText = 'TStream create error exception (EStreamCreateError) occured';
    StreamOpenErrorText   = 'TStream open error exception (EStreamOpenError) occured';
    StreamSeekErrorText   = 'TStream seek error exception (EStreamSeekError) occured';

TYPE
    TStream name 'TStream'=CLASS(TObject)
                     PROTECTED
                            FUNCTION GetSize:LONGINT;VIRTUAL;
                            FUNCTION GetPosition:LONGINT;
                            PROCEDURE SetPosition(NewPos:Longint);
                     PUBLIC
                            PROCEDURE ReadBuffer(VAR Buffer;Count:LONGINT);
                            PROCEDURE WriteBuffer(CONST Buffer;Count:LONGINT);
                            FUNCTION Read(VAR Buffer;Count:LONGINT):LONGINT;
                                     VIRTUAL;ABSTRACT;
                            FUNCTION Write(CONST Buffer;Count:LONGINT):LONGINT;
                                     VIRTUAL;ABSTRACT;
                            FUNCTION Seek(Offset:LONGINT;Origin:WORD):LONGINT;
                                     VIRTUAL;ABSTRACT;
                            PROCEDURE ReadError;VIRTUAL;
                            PROCEDURE WriteError;VIRTUAL;
                            PROCEDURE CreateError;VIRTUAL;
                            PROCEDURE OpenError;VIRTUAL;
                            PROCEDURE SeekError;VIRTUAL;
                            PROCEDURE SetSize(NewSize:LONGINT);VIRTUAL;ABSTRACT;
                            DESTRUCTOR Destroy;OVERRIDE;

                            FUNCTION EndOfData: Boolean; virtual;

                            FUNCTION ReadLn: string; virtual;
                            PROCEDURE WriteLn(const S: string); virtual;

                            PROPERTY
                                     Position:LONGINT    read GetPosition
                                                         write SetPosition;
                            PROPERTY
                                     Size:LONGINT        read GetSize;
    END;
    TStreamClass=CLASS OF TStream;

CONST
    {FileStream Open modes}
    Stream_Create    = 1;
    Stream_Open      = 2;

TYPE
  THandleStream name 'THandleStream'= class(TStream)
                     PRIVATE
                            FHandle: LongInt;

                     PUBLIC
                          CONSTRUCTOR Create(AHandle: Integer);
                          FUNCTION Read(var Buffer; Count: Longint): Longint; override;
                          FUNCTION Write(CONST Buffer; Count: Longint): Longint; override;
                          FUNCTION Seek(Offset: Longint; Origin: Word): Longint; override;

                     PUBLIC
                          PROPERTY Handle: LongInt read FHandle;
  END;
  THandleStreamClass=CLASS OF THandleStream;

TYPE
  TFileHandleStream = class(THandleStream)
                     PUBLIC
                          CONSTRUCTOR Create(const FileName: string; Mode: LongInt);
                          DESTRUCTOR Destroy; virtual;
  END;
  TFileHandleStreamClass=CLASS OF TFileHandleStream;

TYPE
    TFileStream name 'TFileStream'=CLASS(TStream)
                     PRIVATE
                           PStreamFile:FILE;
                     PUBLIC
                           CONSTRUCTOR Create(CONST FileName:STRING;Mode:WORD);
                           DESTRUCTOR Destroy;OVERRIDE;
                           FUNCTION Read(VAR Buffer;Count:LONGINT):LONGINT;OVERRIDE;
                           FUNCTION Write(CONST Buffer;Count:LONGINT):LONGINT;OVERRIDE;
                           FUNCTION Seek(Offset:LONGINT;Origin:WORD):LONGINT;OVERRIDE;
    END;
    TFileStreamClass=CLASS OF TFileStream;

CONST
    {Memory increase size for Write}
    MemoryDelta:LONGWORD=8192;

TYPE
    PMemoryStreamBuffer=^TMemoryStreamBuffer;
    TMemoryStreamBuffer=ARRAY[0..1] OF BYTE;

    TMemoryStream name 'TMemoryStream'=CLASS(TStream)
                     PROTECTED
                           PBuffer:PMemoryStreamBuffer;
                           PSize:LONGINT;
                           PCapacity:LONGINT;
                           PPosition:LONGINT;
                     PROTECTED
                           PROCEDURE SetCapacity(NewCapacity:LONGINT);
                           FUNCTION GetCapacity:LONGINT;
                           FUNCTION GetSize:LONGINT;OVERRIDE;
                           FUNCTION GetBuffer:PMemoryStreamBuffer;
                     PUBLIC
                           CONSTRUCTOR Create;
                           DESTRUCTOR Destroy;OVERRIDE;
                           PROCEDURE LoadFromStream(Stream: TStream);
                           PROCEDURE LoadFromFile(CONST FileName:STRING);
                           PROCEDURE SaveToStream(Stream:TStream);
                           FUNCTION SaveToFile(CONST FileName:STRING):BOOLEAN;
                           FUNCTION Read(VAR Buffer;Count:Longint):Longint;OVERRIDE;
                           FUNCTION Write(CONST Buffer;Count:Longint):Longint;OVERRIDE;
                           FUNCTION Seek(Offset:Longint;Origin:Word):LONGINT;OVERRIDE;
                           PROCEDURE Clear;
                           PROCEDURE SetSize(NewSize:LONGINT);OVERRIDE;
                           FUNCTION GetCurrentBufPtr:POINTER;
                     PROPERTY Memory:PMemoryStreamBuffer
                                                    read GetBuffer;
                     PROPERTY Capacity:LONGINT      read GetCapacity
                                                    write SetCapacity;
    END;
    TMemoryStreamClass=CLASS OF TMemoryStream;


FUNCTION CreateSCUStream(Memory:POINTER):TMemoryStream;
PROCEDURE DestroySCUStream(VAR Stream:TMemoryStream);

IMPLEMENTATION

{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Speed-Pascal Component Classes (SPCC)                                     บ
บ                                                                           บ
บ This section: TStream class implementation                                บ
บ                                                                           บ
บ Last modified: September 1995                                             บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

FUNCTION TStream.GetSize:LONGINT;
VAR
   OldPos:LONGINT;
   Result:LONGINT;
BEGIN
     OldPos:=GetPosition;
     result:=Seek(0,Seek_End);
     SetPosition(OldPos);
     GetSize:=result;
END;

FUNCTION TStream.EndOfData: Boolean;
BEGIN
  Result := (Position >= Size);
END;

FUNCTION TStream.GetPosition:LONGINT;
BEGIN
     GetPosition:=Seek(0,Seek_Current);
END;

PROCEDURE TStream.SetPosition(NewPos:Longint);
BEGIN
     Seek(NewPos,Seek_Begin);
END;

PROCEDURE TStream.ReadBuffer(VAR Buffer;Count:LONGINT);
BEGIN
     IF Count=0 THEN exit;  {Nothing to read}
     IF Read(Buffer,Count)<>Count THEN ReadError;
END;

PROCEDURE TStream.WriteBuffer(CONST Buffer;Count:LONGINT);
BEGIN
     IF Count=0 THEN exit;
     IF Write(Buffer,Count)<>Count THEN WriteError;
END;

PROCEDURE TStream.ReadError;
BEGIN
     RAISE EStreamReadError.Create(StreamReadErrorText);
END;

PROCEDURE TStream.WriteError;
BEGIN
     RAISE EStreamWriteError.Create(StreamWriteErrorText);
END;

PROCEDURE TStream.CreateError;
BEGIN
     RAISE EStreamCreateError.Create(StreamCreateErrorText);
END;

PROCEDURE TStream.OpenError;
BEGIN
     RAISE EStreamOpenError.Create(StreamOpenErrorText);
END;

PROCEDURE TStream.SeekError;
BEGIN
     RAISE EStreamSeekError.Create(StreamSeekErrorText);
END;

DESTRUCTOR TStream.Destroy;
BEGIN
     Inherited Destroy;
END;


FUNCTION TStream.ReadLn: STRING;
VAR
  Buffer: cstring[260];
  OldPos, Count, Temp: LongInt;
BEGIN
  OldPos := Position;

  Count := Read(Buffer[0], 257);
  Buffer[Count] := #0;

  Temp := 0;
  while not (Buffer[Temp] in [#10, #13, #26])
    and (Temp < Count) and (Temp < 255) do Inc (Temp);

  Move(Buffer[0], Result[1], Temp);
  SetLength(Result, Temp);
  Inc(Temp);

  if (Buffer[Temp - 1] = #13) and (Buffer[Temp] = #10) then Inc(Temp);

  Position := OldPos + Temp;
END;

PROCEDURE TStream.WriteLn(const S: string);
VAR
  CRLF: Word;
BEGIN
  CRLF := $0A0D;
  WriteBuffer(S[1], Length(S));
  WriteBuffer(CRLF, 2);
END;

{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Speed-Pascal Component Classes (SPCC)                                     บ
บ                                                                           บ
บ This section: THandleStream class implementation                          บ
บ                                                                           บ
บ Last modified: September 1995                                             บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

constructor THandleStream.Create(AHandle: Integer);
begin
  FHandle := AHandle;
end;

function THandleStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := FileRead(Handle, Buffer, Count);
  if Result = -1 then Result := 0;
end;

function THandleStream.Write(CONST Buffer; Count: Longint): Longint;
var temp:^BYTE;
begin
  Temp:=@Buffer;
  Result := FileWrite(Handle, Temp^, Count);
  if Result = -1 then Result := 0;
end;

function THandleStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  Result := FileSeek(Handle, Offset, Origin);
  if Result < 0 then SeekError;
end;

{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Speed-Pascal Component Classes (SPCC)                                     บ
บ                                                                           บ
บ This section: TFileHandleStream class implementation                      บ
บ                                                                           บ
บ Last modified: September 1995                                             บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

constructor TFileHandleStream.Create(const FileName: string; Mode: LongInt);
begin
  if Mode = Stream_Create then
  begin
    FHandle := FileCreate(FileName);
    if FHandle = -1 then CreateError;
  end
  else
  begin
    FHandle := FileOpen(FileName, Mode);
    if FHandle = -1 then OpenError;
  end;
end;

destructor TFileHandleStream.Destroy;
begin
  if FHandle > 0 then FileClose(FHandle);
end;


{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Speed-Pascal Component Classes (SPCC)                                     บ
บ                                                                           บ
บ This section: TFileStream class implementation                            บ
บ                                                                           บ
บ Last modified: September 1995                                             บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

CONSTRUCTOR TFileStream.Create(CONST FileName:STRING;Mode:WORD);
BEGIN
     Inherited Create;

     Assign(PStreamFile,FileName);
     CASE Mode OF
        Stream_Open:
        BEGIN
             {$i-}
             Reset(PStreamFile,1);
             {$i+}
             IF IoResult<>0 THEN OpenError;
        END;
        Stream_Create:
        BEGIN
             {$i-}
             Rewrite(PStreamFile,1);
             {$i+}
             IF IoResult<>0 THEN CreateError;
        END;
     END; {case}
END;

DESTRUCTOR TFileStream.Destroy;
BEGIN
     {$i-}
     Close(PStreamFile);
     {$i+}
END;

FUNCTION TFileStream.Read(VAR Buffer;Count:LONGINT):LONGINT;
VAR
   Result:LONGINT;
BEGIN
     {$i-}
     BlockRead(PStreamFile,Buffer,Count,Result);
     {$i+}
     IF IoResult<>0 THEN ReadError;
     Read:=Result;
END;

FUNCTION TFileStream.Write(CONST Buffer;Count:LONGINT):LONGINT;
VAR
   pb:POINTER;
   Result:LONGINT;
BEGIN
     pb:=@Buffer;
     {$i-}
     BlockWrite(PStreamFile,pb^,Count,Result);
     {$i+}
     IF IoResult<>0 THEN WriteError;
     Write:=Result;
END;

FUNCTION TFileStream.Seek(Offset:LONGINT;Origin:WORD):LONGINT;
VAR
   SaveSeekMode:LONGWORD;
BEGIN
     SaveSeekMode:=SeekMode;
     SeekMode:=Origin;
     {$i-}
     SYSTEM.Seek(PStreamFile,Offset);
     {$i+}
     IF IoResult<>0 THEN SeekError;
     SeekMode:=SaveSeekMode;
     {$i-}
     Seek:=FilePos(PStreamFile);
     {$i+}
     IF IoResult<>0 THEN SeekError;
END;


{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Speed-Pascal Component Classes (SPCC)                                     บ
บ                                                                           บ
บ This section: TMemoryStream class implementation                          บ
บ                                                                           บ
บ Last modified: September 1995                                             บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

FUNCTION TMemoryStream.GetBuffer:PMemoryStreamBuffer;
BEGIN
     GetBuffer:=PBuffer;
END;

PROCEDURE TMemoryStream.SetCapacity(NewCapacity:LONGINT);
VAR
   p:POINTER;
BEGIN
     IF NewCapacity=PCapacity THEN exit;
     IF NewCapacity=0 THEN
     BEGIN
          IF PBuffer<>NIL THEN FreeMem(PBuffer,PCapacity);
          PSize:=0;
          PPosition:=0;
          PBuffer:=NIL;
     END
     ELSE
     BEGIN
          Getmem(p,NewCapacity);
          IF PBuffer<>NIL THEN
          BEGIN
               IF NewCapacity<PCapacity THEN
               BEGIN
                   move(PBuffer^,p^,NewCapacity);
                   PSize:=NewCapacity;
                   IF PPosition>PSize THEN PPosition:=PSize;
               END
               ELSE move(PBuffer^,p^,PCapacity);
               FreeMem(PBuffer,PCapacity);
          END
          ELSE
          BEGIN
               PSize:=0;
               PPosition:=0;
          END;
          PBuffer:=p;
     END;

     PCapacity:=NewCapacity;
END;

FUNCTION TMemoryStream.GetCapacity:LONGINT;
BEGIN
     GetCapacity:=Capacity;
END;

PROCEDURE TMemoryStream.SetSize(NewSize:LONGINT);
BEGIN
     Clear;
     SetCapacity(NewSize);
     PSize:=NewSize;
END;

FUNCTION TMemoryStream.GetSize:LONGINT;
BEGIN
     GetSize:=PSize;
END;

CONSTRUCTOR TMemoryStream.Create;
BEGIN
     Inherited Create;

     PSize:=0;
     PCapacity:=0;
     PPosition:=0;
     PBuffer:=NIL;
END;

DESTRUCTOR TMemoryStream.Destroy;
BEGIN
     Clear;
     Inherited Destroy;
END;

FUNCTION TMemoryStream.Read(VAR Buffer;Count:Longint):Longint;
VAR
   result:LONGINT;
LABEL l;
BEGIN
     Result:=0;
     IF PBuffer=NIL THEN goto l;
     IF PPosition+Count>PSize THEN Count:=PSize-PPosition;
     IF Count<=0 THEN goto l;

     move(PBuffer^[PPosition],Buffer,Count);
     inc(PPosition,Count);
     result:=Count;
l:
     Read:=result;
END;

FUNCTION TMemoryStream.GetCurrentBufPtr:POINTER;
BEGIN
     result:=PBuffer;
     inc(result,PPosition);
END;

FUNCTION TMemoryStream.Write(CONST Buffer;Count:Longint):Longint;
VAR
   Result:LONGINT;
   pb:POINTER;
LABEL l;
BEGIN
     Result:=0;
     IF Count<=0 THEN goto l;
     IF PBuffer=NIL THEN goto l;

     pb:=@Buffer;
     IF PPosition+Count>PCapacity THEN SetCapacity(PPosition+Count+MemoryDelta);
     move(pb^,PBuffer^[PPosition],Count);
     inc(PPosition,Count);
     IF PPosition>PSize THEN PSize:=PPosition;
     result:=Count;
l:
     Write:=Result;
END;

FUNCTION TMemoryStream.Seek(Offset:Longint;Origin:Word):LONGINT;
BEGIN
     CASE Origin OF
        Seek_Begin:IF Offset<=PSize THEN PPosition:=Offset;
        Seek_Current:IF PPosition+Offset<=PSize THEN PPosition:=PPosition+Offset;
        Seek_End:IF PSize+Offset<=PSize THEN PPosition:=PSize+Offset;
     END; {case}

     Seek:=PPosition;
END;

PROCEDURE TMemoryStream.LoadFromStream(Stream: TStream);
BEGIN
     IF PBuffer=NIL THEN exit;
     Stream.Position:=0;
     SetSize(Stream.Size);
     IF PSize=0 THEN exit;  {nothing to read}
     Stream.ReadBuffer(PBuffer^,PSize);
END;

PROCEDURE TMemoryStream.LoadFromFile(CONST FileName:STRING);
VAR
   FileStream:TFileStream;
BEGIN
     FileStream.Create(FileName,Stream_Open);
     TRY
        LoadFromStream(FileStream);
     FINALLY
        FileStream.Destroy;
     END;
END;

PROCEDURE TMemoryStream.SaveToStream(Stream:TStream);
BEGIN
     IF PBuffer=NIL THEN exit;
     IF PSize=0 THEN exit; {Nothing to write}
     Stream.WriteBuffer(PBuffer^,PSize);
END;

FUNCTION TMemoryStream.SaveToFile(CONST FileName:STRING):BOOLEAN;
VAR
   FileStream:TFileStream;
BEGIN
     result:=TRUE;

     TRY
        FileStream.Create(FileName,Stream_Create);
        SaveToStream(FileStream);
     EXCEPT
        result:=FALSE;
     END;

     FileStream.Destroy;
END;

PROCEDURE TMemoryStream.Clear;
BEGIN
     SetCapacity(0);
END;

FUNCTION CreateSCUStream(Memory:POINTER):TMemoryStream;
BEGIN
     result.Create;
     result.PBuffer:=Memory;
     result.PSize:=MaxLongInt;
     result.PCapacity:=MaxLongInt;
     result.PPosition:=0;
END;

PROCEDURE DestroySCUStream(VAR Stream:TMemoryStream);
BEGIN
     Stream.PBuffer:=NIL;
     Stream.PSize:=0;
     Stream.PCapacity:=0;
     Stream.Destroy;
END;

END.
