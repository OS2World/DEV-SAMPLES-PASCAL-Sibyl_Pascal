UNIT Lists;

{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Speed-Pascal Component Classes (SPCC)                                     บ
บ                                                                           บ
บ This file: Lists class definitions                                        บ
บ                                                                           บ
บ Last modified: 16.10.1995                                                 บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
บ Partially ported by Joerg Pleumann (C) 1996                               บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

INTERFACE

USES Streams,SysUtils;

CONST
    EListErrorText = 'List error exception (EListError) occured';

    MaxListSize = MaxLongInt DIV SizeOf(Pointer);

    { A notify event is a method variable, i.e. a PROCEDURE
    variable for objects. Some classes allow the specification
    of objects to be notified of changes. }

type
  TNotifyEvent = PROCEDURE(Sender: TObject) of object;


TYPE
    EListError = CLASS(Exception);

    {TList CLASS}
    PPointerList = ^TPointerList;
    TPointerList = ARRAY[0..MaxListSize-1] OF POINTER;

    TList = CLASS
       PROTECTED
             FList:PPointerList;
             FCount:LONGINT;
             FCapacity:LONGINT;
             FGrowth:LONGINT;
       PROTECTED
             PROCEDURE Error; VIRTUAL;
             FUNCTION  Get(Index:LONGINT):POINTER;
             PROCEDURE Put(Index:LONGINT;Item:POINTER);
             PROCEDURE Grow; VIRTUAL;
             PROCEDURE SetCapacity(NewCapacity:LONGINT);
             PROCEDURE SetCount(NewCount:LONGINT);
       PUBLIC
             DESTRUCTOR Destroy; OVERRIDE;
             PROCEDURE Clear; VIRTUAL;
             FUNCTION  Add(Item:POINTER):LONGINT;
             PROCEDURE Delete(Index:LONGINT);
             FUNCTION  Remove(Item:POINTER):LONGINT;
             PROCEDURE Cut(Index1,Index2:LONGINT);
             PROCEDURE Insert(Index:LONGINT;Item:POINTER);
             PROCEDURE Exchange(Index1,Index2:LONGINT);
             PROCEDURE Move(CurIndex,NewIndex:LONGINT);
             FUNCTION  IndexOf(Item:POINTER):LONGINT;
             FUNCTION  First:POINTER;
             FUNCTION  Last:POINTER;
             FUNCTION  Expand:TList;
             PROCEDURE Pack;
       PUBLIC
             PROPERTY  Capacity:LONGINT read FCapacity write SetCapacity;
             PROPERTY  Count:LONGINT read FCount write SetCount;
             PROPERTY  Growth:LONGINT read FGrowth write FGrowth;
             PROPERTY  Items[Index:LONGINT]:POINTER read Get write Put; {default;}
             PROPERTY  List:PPointerList read FList;
    END;
    TListClass=CLASS OF TList;


    {TChainList CLASS}
    PChainListItem = ^TChainListItem;
    TChainListItem = RECORD
                      prev:PChainListItem;
                      Item:Pointer;
                      next:PChainListItem;
                END;

    TChainList name 'TChainList' = CLASS(TObject)
       PROTECTED
             FList   :PChainListItem;
             FListEnd:PChainListItem;
             FCount  :LongInt;
       PROTECTED
             PROCEDURE Error; VIRTUAL;
             FUNCTION  Index2PLE(Index:LongInt):PChainListItem;
             FUNCTION  Item2PLE(Item:Pointer):PChainListItem;
             FUNCTION  PLE2Index(ple:PChainListItem):LongInt;
             FUNCTION  Item2Index(Item:Pointer):LongInt;
             PROCEDURE Connect(ple1,ple2:PChainListItem);
             FUNCTION  Get(Index:LongInt):Pointer;
             PROCEDURE Put(Index:LongInt;Item:Pointer);
       PUBLIC
             DESTRUCTOR Destroy; OVERRIDE;
             PROCEDURE Clear;
             FUNCTION  Add(Item:Pointer):LongInt;
             FUNCTION  Remove(Item:Pointer):LongInt;
             PROCEDURE Delete(Index:LongInt);
             FUNCTION  First:Pointer;
             FUNCTION  Last:Pointer;
             FUNCTION  IndexOf(Item:Pointer):LongInt;
             PROCEDURE Insert(Index:LongInt;Item:Pointer);
             PROCEDURE Move(CurIndex,NewIndex:LongInt);
             PROCEDURE Exchange(Index1,Index2:LongInt);
             PROCEDURE Pack;
       PUBLIC
             PROPERTY  Count:LongInt read FCount;
             PROPERTY  Items[Index:LongInt]:Pointer read Get write Put; {default;}
    END;
    TChainListClass=CLASS OF TChainList;

    { TSTRINGs is an abstract base class for storing a
  number of STRINGs. Every STRING can be associated
  with a value as well as with an object. So, IF you
  want to store simple STRINGs, or collections of
  keys and values, or collection of named objects,
  TSTRINGs is the abstract ancestor you should
  derive your class from. }

TYPE
  ESTRINGListError = class(Exception);

  TSTRINGs = class(TObject)
  PRIVATE
    FUpdateSemaphore: LongInt;
  PROTECTED
    FUNCTION GetValue(CONST Name: STRING): STRING; VIRTUAL;
    PROCEDURE SetValue(CONST Name, Value: STRING); VIRTUAL;
    FUNCTION FindValue(CONST Name: STRING; VAR Value: STRING): LongInt; VIRTUAL;
    FUNCTION Get(Index: LongInt): STRING; VIRTUAL; abstract;
    FUNCTION GetCount: LongInt; VIRTUAL; abstract;
    FUNCTION GetObject(Index: LongInt): TObject; VIRTUAL; abstract;
    PROCEDURE Put(Index: LongInt; CONST S: STRING); VIRTUAL; abstract;
    PROCEDURE PutObject(Index: LongInt; AObject: TObject); VIRTUAL; abstract;
    PROCEDURE SetUpdateState(Updating: Boolean); VIRTUAL;
  PUBLIC
    FUNCTION Add(CONST S: STRING): LongInt; VIRTUAL;
    FUNCTION AddObject(CONST S: STRING; AObject: TObject): LongInt; VIRTUAL;
    PROCEDURE AddSTRINGs(ASTRINGs: TSTRINGs); VIRTUAL;
    PROCEDURE BEGINUpdate;
    PROCEDURE Clear; VIRTUAL; abstract;
    PROCEDURE Delete(Index: LongInt); VIRTUAL; abstract;
    PROCEDURE EndUpdate;
    FUNCTION Equals(ASTRINGs: TSTRINGs): Boolean;
    PROCEDURE Exchange(Index1, Index2: LongInt); VIRTUAL;
    FUNCTION GetText: PChar; VIRTUAL;
    FUNCTION IndexOf(CONST S: STRING): LongInt; VIRTUAL;
    FUNCTION IndexOfObject(AObject: TObject): Integer;
    PROCEDURE Insert(Index: LongInt; CONST S: STRING); VIRTUAL; abstract;
    PROCEDURE InsertObject(Index: LongInt; CONST S: STRING; AObject: TObject);
    PROCEDURE LoadFromFile(CONST FileName: STRING);
    PROCEDURE LoadFromStream(Stream: TStream); VIRTUAL;
    PROCEDURE Move(CurIndex, NewIndex: LongInt); VIRTUAL;
    PROCEDURE SaveToFile(CONST FileName: STRING);
    PROCEDURE SaveToStream(Stream: TStream); VIRTUAL;
    PROCEDURE SetText(Text: PChar); VIRTUAL;
    PROPERTY Count: LongInt read GetCount;
    PROPERTY Objects[Index: LongInt]: TObject read GetObject write PutObject;
    PROPERTY Values[CONST Name: STRING]: STRING read GetValue write SetValue;
    PROPERTY STRINGs[Index: LongInt]: STRING read Get write Put; default;
  END;

{ TStringList is a concrete class derived
  from TSTRINGs. TStringList stores its items
  in a PRIVATE field of type TList. It's very
  fast, since it performs binary search for
  retrieving objects by name. You can specify
  whether you want TStringList to be sorted or
  unsorted as well as case-sensitive or not.
  You can also specify the way a TStringList
  object handles duplicate entries.

  TStringList is able to notify the user when
  the list's data changes or has been changed.
  Use the properties OnChange and OnChanged. }

TYPE

  TDuplicates = (dupIgnore, dupAccept, dupError, dupReplace);
    { dupReplace ist neu! }

TYPE

  TStringList = class(TSTRINGs)
  PRIVATE
    FList: TList;
    FSorted: Boolean;
    FDuplicates: TDuplicates;
    FCaseSensitive: Boolean;
    FOnChange: TNotifyEvent;
    FOnChanging: TNotifyEvent;
    PROCEDURE BottomUpHeapSort;
    PROCEDURE SetSorted(Value: Boolean);
    PROCEDURE SetCaseSensitive(Value: Boolean);
  PROTECTED
    PROCEDURE Changed; VIRTUAL;
    PROCEDURE Changing; VIRTUAL;
    FUNCTION Get(Index: LongInt): STRING; OVERRIDE;
    FUNCTION GetCount: LongInt; OVERRIDE;
    FUNCTION GetObject(Index: LongInt): TObject; OVERRIDE;
    PROCEDURE Put(Index: LongInt; CONST S: STRING); OVERRIDE;
    PROCEDURE PutObject(Index: LongInt; AObject: TObject); OVERRIDE;
    PROCEDURE SetUpdateState(Updating: Boolean); OVERRIDE;
  PUBLIC
    CONSTRUCTOR Create;
    DESTRUCTOR Destroy; OVERRIDE;
    FUNCTION Add(CONST S: STRING): LongInt; OVERRIDE;
    PROCEDURE Clear; OVERRIDE;
    PROCEDURE Delete(Index: LongInt); OVERRIDE;
    PROCEDURE Exchange(Index1, Index2: LongInt); OVERRIDE;
    FUNCTION Find(CONST S: STRING; VAR Index: LongInt): Boolean; VIRTUAL;
    FUNCTION IndexOf(CONST S: STRING): LongInt; OVERRIDE;
    PROCEDURE Insert(Index: LongInt; CONST S: STRING); OVERRIDE;
    PROCEDURE Sort; VIRTUAL;
    PROPERTY Duplicates: TDuplicates read FDuplicates write FDuplicates;
    PROPERTY CaseSensitive: Boolean read FCaseSensitive write SetCaseSensitive;
    PROPERTY Sorted: Boolean read FSorted write SetSorted;
    PROPERTY OnChange: TNotifyEvent read FOnChange write FOnChange;
    PROPERTY OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
  END;

{ StrItem is a space-efficient way to store an object
  associated with a STRING. It is used inside TStringList. }

type
  PStrItem = ^TStrItem;
  TStrItem = record
    FObject: TObject;
    FSTRING: STRING;
  END;

FUNCTION NewStrItem(CONST ASTRING: STRING; AObject: TObject): PStrItem;
PROCEDURE DisposeStrItem(P: PStrItem);


IMPLEMENTATION

{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Speed-Pascal Component Classes (SPCC)                                     บ
บ                                                                           บ
บ This section: TList class implementation                                  บ
บ                                                                           บ
บ Last modified: 10.01.1996                                                 บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

PROCEDURE TList.Error;
BEGIN
     RAISE EListError.Create(EListErrorText);
END;


FUNCTION TList.Get(Index:LONGINT):POINTER;
BEGIN
     Result := NIL;
     IF (Index < 0) OR (Index >= FCount) THEN Error
     ELSE Result := FList^[Index];
END;


PROCEDURE TList.Put(Index:LONGINT;Item:POINTER);
BEGIN
     IF (Index < 0) OR (Index >= FCount) THEN Error
     ELSE FList^[Index] := Item;
END;


PROCEDURE TList.Grow;
VAR  gr:LONGINT;
BEGIN
     IF FGrowth <= 0 THEN
     BEGIN
          IF FCapacity < 128 THEN gr := 16
          ELSE gr := FCapacity SHR 3;
     END
     ELSE gr := FGrowth;
     SetCapacity(FCapacity + gr);
END;


PROCEDURE TList.SetCapacity(NewCapacity:LONGINT);
VAR  newList:PPointerList;
BEGIN
     IF (NewCapacity > MaxListSize) OR (NewCapacity < FCount) THEN Error
     ELSE
     IF NewCapacity <> FCapacity THEN
     BEGIN
          IF NewCapacity > 0 THEN
          BEGIN
               GetMem(newList, NewCapacity*SizeOf(Pointer));
               IF FCount > 0 THEN System.Move(FList^,newList^,
                                              FCount*SizeOf(Pointer));
          END
          ELSE newList := NIL;
          IF FList<>NIL THEN FreeMem(FList, FCapacity*SizeOf(Pointer));
          FCapacity := NewCapacity;
          FList := newList;
     END;
END;


PROCEDURE TList.SetCount(NewCount:LONGINT);
BEGIN
     IF (NewCount > MaxListSize) OR (NewCount < 0) THEN Error
     ELSE
     BEGIN
          IF NewCount > FCapacity THEN SetCapacity(NewCount);
          IF NewCount > FCount
          THEN FillChar(FList^[FCount], (NewCount-FCount)*SizeOf(Pointer),0);
          FCount := NewCount;
     END;
END;


{--- PUBLIC part ------------------------------------------------------------}

(* Clear the whole list and destroy the list object *)
DESTRUCTOR TList.Destroy;
BEGIN
     Clear;
END;


(* Clear the whole list and release the allocated memory *)
PROCEDURE TList.Clear;
BEGIN
     SetCount(0);
     SetCapacity(0);
END;


(*  Append a new item at the end of the list and return the new index *)
FUNCTION TList.Add(Item:POINTER):LONGINT;
BEGIN
     IF FCount = FCapacity THEN Grow;
     FList^[FCount] := Item;
     inc(FCount);
     Result := FCount-1;
END;


(* Delete the item and decrement the count of elements in the list *)
PROCEDURE TList.Delete(Index:LONGINT);
BEGIN
     IF (Index < 0) OR (Index >= FCount) THEN Error
     ELSE
     BEGIN
          dec(FCount);
          IF Index <> FCount THEN System.Move(FList^[Index + 1],FList^[Index],
                                              (FCount-Index)*SizeOf(Pointer));
     END;
END;


(* Remove the item and decrement the count of elements in the list *)
FUNCTION TList.Remove(Item:POINTER):LONGINT;
BEGIN
     Result := IndexOf(Item);
     IF Result <> -1 THEN Delete(Result);
END;


(* Cut the specified range out of the list (including both indices) *)
PROCEDURE TList.Cut(Index1,Index2:LONGINT);
VAR  swap:LONGINT;
BEGIN
     IF (Index1 < 0) OR (Index1 >= FCount) OR
        (Index2 < 0) OR (Index2 >= FCount) THEN Error
     ELSE
     BEGIN
          IF Index2 < Index1 THEN
          BEGIN
               swap := Index1;
               Index1 := Index2;
               Index2 := swap;
          END;
          IF Index2 <> FCount-1 THEN System.Move(FList^[Index2+1],FList^[Index1],
                                                 (FCount-Index2)*SizeOf(Pointer));
          dec(FCount,Index2-Index1+1);
     END;
END;


(* Insert a new item at the specified position in the list *)
PROCEDURE TList.Insert(Index:LONGINT;Item:POINTER);
BEGIN
     IF (Index < 0) OR (Index > FCount) THEN Error
     ELSE
     BEGIN
          IF FCount = FCapacity THEN Grow;
          IF Index <> FCount THEN System.Move(FList^[Index],FList^[Index+1],
                                              (FCount-Index)*SizeOf(Pointer));
          FList^[Index] := Item;
          inc(FCount);
     END;
END;


(* Exchange two items in the list *)
PROCEDURE TList.Exchange(Index1,Index2:LONGINT);
VAR  Item:POINTER;
BEGIN
     Item := Get(Index1);
     Put(Index1, Get(Index2));
     Put(Index2, Item);
END;


(* Move an item to a new position in the list *)
PROCEDURE TList.Move(CurIndex,NewIndex:LONGINT);
VAR  Item:POINTER;
BEGIN
     IF (CurIndex < 0) OR (CurIndex >= FCount) OR
        (NewIndex < 0) OR (NewIndex >= FCount) THEN Error
     ELSE
     IF CurIndex <> NewIndex THEN
     BEGIN
          Item := FList^[CurIndex];
          IF CurIndex < NewIndex
          THEN System.Move(FList^[CurIndex+1], FList^[CurIndex],
                           (NewIndex-CurIndex)*SizeOf(Pointer))
          ELSE System.Move(FList^[NewIndex], FList^[NewIndex+1],
                           (CurIndex-NewIndex)*SizeOf(Pointer));
          FList^[NewIndex] := Item;
     END;
END;


(* Return the index of an item *)
FUNCTION TList.IndexOf(Item:POINTER):LONGINT;
BEGIN
     FOR Result := 0 TO FCount-1 DO
        IF FList^[Result] = Item THEN exit;
     Result := -1;
END;


(* Return the first item in the list *)
FUNCTION TList.First:POINTER;
BEGIN
     Result := Get(0);
END;


(* Return the last item in the list *)
FUNCTION TList.Last:POINTER;
BEGIN
     Result := Get(FCount-1);
END;


(* Expand the list IF capacity is reached *)
FUNCTION TList.Expand:TList;
BEGIN
     IF FCount = FCapacity THEN Grow;
     Result := SELF;
END;


(* Remove all NIL elements in the list *)
PROCEDURE TList.Pack;
VAR  i:LONGINT;
BEGIN
     FOR i := FCount-1 DOWNTO 0 DO
        IF FList^[i] = NIL THEN Delete(i);
END;


{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Speed-Pascal Component Classes (SPCC)                                     บ
บ                                                                           บ
บ This section: TChainList class implementation                             บ
บ                                                                           บ
บ Last modified: 16.10.1995                                                 บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

PROCEDURE TChainList.Error;
BEGIN
     RAISE EListError.Create(EListErrorText);
END;


FUNCTION TChainList.Index2PLE(Index:LongInt):PChainListItem;
VAR  i:LongInt;
BEGIN
     IF (Index < 0) OR (Index >= FCount) THEN Result := NIL
     ELSE
     BEGIN
          Result := FList;
          FOR i := 0 TO Index-1 DO Result := Result^.next;
          IF Result = NIL THEN exit;
     END;
END;


FUNCTION TChainList.Item2PLE(Item:Pointer):PChainListItem;
BEGIN
     Result := FList;
     WHILE Result <> NIL DO
     BEGIN
          IF Result^.Item = Item THEN exit;
          Result := Result^.next;
     END;
END;


FUNCTION TChainList.PLE2Index(ple:PChainListItem):LongInt;
VAR  ple1:PChainListItem;
BEGIN
     Result := -1;
     ple1 := FList;
     WHILE ple1 <> NIL DO
     BEGIN
          inc(Result);
          IF ple1 = ple THEN exit;
          ple1 := ple1^.next;
     END;
     Result := -1;
END;


FUNCTION TChainList.Item2Index(Item:Pointer):LongInt;
VAR  ple:PChainListItem;
BEGIN
     Result := -1;
     ple := FList;
     WHILE ple <> NIL DO
     BEGIN
          inc(Result);
          IF ple^.Item = Item THEN exit;
          ple := ple^.next;
     END;
     Result := -1;
END;


PROCEDURE TChainList.Connect(ple1,ple2:PChainListItem);
BEGIN
     IF ple1 <> NIL THEN ple1^.next := ple2
     ELSE FList := ple2;
     IF ple2 <> NIL THEN ple2^.prev := ple1
     ELSE FListEnd := ple1;
END;


FUNCTION TChainList.Get(Index:LongInt):Pointer;
VAR  ple:PChainListItem;
BEGIN
     ple := Index2PLE(Index);
     IF ple = NIL THEN Error;
     Result := ple^.Item;
END;


PROCEDURE TChainList.Put(Index:LongInt;Item:Pointer);
VAR  ple:PChainListItem;
BEGIN
     ple := Index2PLE(Index);
     IF ple = NIL THEN Error;
     ple^.Item := Item;
END;



DESTRUCTOR TChainList.Destroy;
BEGIN
     Clear;
END;


PROCEDURE TChainList.Clear;
VAR  i:LongInt;
     ple,plenext:PChainListItem;
BEGIN
     ple := FList;
     FOR i := 0 TO FCount-1 DO
     BEGIN
          plenext := ple^.next;
          Dispose(ple);
          ple := plenext;
     END;
     FCount := 0;
     FList := NIL;
     FListEnd := NIL;
END;


FUNCTION TChainList.Add(Item:Pointer):LongInt;
VAR  plenew:PChainListItem;
BEGIN
     New(plenew);
     plenew^.Item := Item;
     plenew^.next := NIL;
     Connect(FListEnd,plenew);
     FListEnd := plenew;
     Result := FCount;
     inc(FCount);
END;


FUNCTION TChainList.Remove(Item:Pointer):LongInt;
VAR  i:LongInt;
     ple:PChainListItem;
BEGIN
     ple := FList;
     FOR i := 0 TO FCount-1 DO
     BEGIN
          IF ple^.Item = Item THEN
          BEGIN
               Result := i;
               Connect(ple^.prev,ple^.next);
               Dispose(ple);
               dec(FCount);
               exit;
          END;
          ple := ple^.next;
     END;
     Result := -1;
END;


PROCEDURE TChainList.Delete(Index:LongInt);
VAR  ple:PChainListItem;
BEGIN
     ple := Index2PLE(Index);
     IF ple = NIL THEN Error;
     Connect(ple^.prev,ple^.next);
     Dispose(ple);
     dec(FCount);
END;


FUNCTION TChainList.First:Pointer;
VAR  ple:PChainListItem;
BEGIN
     ple := FList;
     IF ple = NIL THEN Error;
     Result := ple^.Item;
END;


FUNCTION TChainList.Last:Pointer;
VAR  ple:PChainListItem;
BEGIN
     ple := FListEND;
     IF ple = NIL THEN Error;
     Result := ple^.Item;
END;


FUNCTION TChainList.IndexOf(Item:Pointer):LongInt;
BEGIN
     Result := Item2Index(Item);
END;


PROCEDURE TChainList.Insert(Index:LongInt;Item:Pointer);
VAR  ple,plenew:PChainListItem;
BEGIN
     IF Index < 0 THEN Error;
     IF Index > FCount THEN Error;

     ple := Index2PLE(Index);
     IF ple <> NIL THEN
     BEGIN
          New(plenew);
          plenew^.Item := Item;
          Connect(ple^.prev,plenew);
          Connect(plenew,ple);
          inc(FCount);
     END
     ELSE Add(Item);
END;


PROCEDURE TChainList.Move(CurIndex,NewIndex:LongInt);
VAR  TempItem:Pointer;
BEGIN
     IF CurIndex < 0 THEN Error;
     IF CurIndex >= FCount THEN Error;
     IF NewIndex < 0 THEN Error;
     IF NewIndex >= FCount THEN Error;
     IF CurIndex = NewIndex THEN exit;

     TempItem := Get(CurIndex);
     Delete(CurIndex);
     Insert(NewIndex,TempItem);
END;


PROCEDURE TChainList.Exchange(Index1,Index2:LongInt);
VAR  ple1,ple2:PChainListItem;
     TempItem:Pointer;
BEGIN
     ple1 := Index2PLE(Index1);
     ple2 := Index2PLE(Index2);
     IF (ple1 = NIL) OR (ple2 = NIL) THEN Error;

     TempItem := ple1^.Item;
     ple1^.Item := ple2^.Item;
     ple2^.Item := TempItem;
END;


PROCEDURE TChainList.Pack;
VAR  i:LongInt;
     ple,plenext:PChainListItem;
BEGIN
     ple := FList;
     FOR i := 0 TO FCount-1 DO
     BEGIN
          plenext := ple^.next;
          IF ple^.Item = NIL THEN
          BEGIN
               Connect(ple^.prev,ple^.next);
               Dispose(ple);
               dec(FCount);
          END;
          ple := plenext;
     END;
END;

{ --- Utility FUNCTIONs for TStrItem --- }

FUNCTION NewStrItem(CONST ASTRING: STRING; AObject: TObject): PStrItem;
BEGIN
  GetMem(Result, SizeOf(TObject) + Length(ASTRING) + 1);
  Result^.FObject := AObject;
  Result^.FSTRING := ASTRING;
END;

PROCEDURE DisposeStrItem(P: PStrItem);
BEGIN
  FreeMem(P, SizeOf(TObject) + Length(P^.FSTRING) + 1);
END;


{ --- TSTRINGs --- }

FUNCTION TSTRINGs.Add(CONST S: STRING): LongInt;
BEGIN
  Result := Count;
  Insert(Result, S);
END;

FUNCTION TSTRINGs.AddObject(CONST S: STRING; AObject: TObject): LongInt;
BEGIN
  Result := Add(S);
  PutObject(Result, AObject);
END;

PROCEDURE TSTRINGs.AddSTRINGs(ASTRINGs: TSTRINGs);
var
  I: Integer;
BEGIN
  BEGINUpdate;
  try
    for I := 0 to ASTRINGs.Count - 1 do AddObject(ASTRINGs.Get(I), ASTRINGs.GetObject(I));
  finally
    EndUpdate;
  END;
END;

PROCEDURE TSTRINGs.BEGINUpdate;
BEGIN
  IF FUpdateSemaphore = 0 THEN SetUpdateState(True);
  Inc(FUpdateSemaphore);
END;

PROCEDURE TSTRINGs.EndUpdate;
BEGIN
  Dec(FUpdateSemaphore);
  IF FUpdateSemaphore = 0 THEN SetUpdateState(False);
END;

FUNCTION TSTRINGs.Equals(ASTRINGs: TSTRINGs): Boolean;
var
  N: LongInt;
BEGIN
  Result := False;
  IF Count <> ASTRINGs.Count THEN Exit;
  for N := 0 to Count - 1 do IF Get(N) <> ASTRINGs.Get(N) THEN Exit;
  Result := True;
END;

PROCEDURE TSTRINGs.Exchange(Index1, Index2: LongInt);
var
  S: STRING;
  O: TObject;
BEGIN
  S := Get(Index1);
  O := GetObject(Index1);
  Put(Index1, Get(Index2));
  PutObject(Index1, GetObject(Index2));
  Put(Index2, S);
  PutObject(Index2, O);
END;

FUNCTION TSTRINGs.GetText: PChar;

  PROCEDURE SingleLineToBuffer(CONST S: STRING; VAR P: PChar);
  BEGIN
    System.Move(S[1], P[0], Length(S));
    Inc(P, Length(S));
    P[0] := #13;
    P[1] := #10;
    Inc(P, 2);
  END;

var
  N, BufSize: LongInt;
  BufPtr: PChar;
BEGIN
  BufSize := 1;
  for N := 0 to Count - 1 do Inc(BufSize, Length(Get(N)) + 2);
  GetMem(Result, BufSize);

  WriteLn(LongWord(Result));
  BufPtr := Result;
  for N := 0 to Count - 1 do
  BEGIN
    SingleLineToBuffer(Get(N), BufPtr);
    WriteLn(LongWord(BufPtr));
  END;
  BufPtr[0] := #0;
END;

FUNCTION TSTRINGs.GetValue(CONST Name: STRING): STRING;
BEGIN
  FindValue(Name, Result);
END;

FUNCTION TSTRINGs.FindValue(CONST Name: STRING; VAR Value: STRING): Integer;
var
  P: Integer;
BEGIN
  for Result := 0 to Count - 1 do
  BEGIN
    Value := Get(Result);
    P := Pos('=', Value);
    IF P <> 0 THEN
    BEGIN
      IF CompareText(Copy(Value, 1, P - 1), Name) = 0 THEN
      BEGIN
        System.Delete(Value, 1, P);
        Exit;
      END;
    END;
  END;
  Result := -1;
  Value := '';
END;

FUNCTION TSTRINGs.IndexOf(CONST S: STRING): Integer;
BEGIN
  for Result := 0 to Count do IF CompareText(Get(Result), S) = 0 THEN Exit;
  Result := -1;
END;

FUNCTION TSTRINGs.IndexOfObject(AObject: TObject): Integer;
BEGIN
  for Result := 0 to Count do IF GetObject(Result) = AObject THEN Exit;
  Result := -1;
END;

PROCEDURE TSTRINGs.InsertObject(Index: LongInt; CONST S: STRING; AObject: TObject);
BEGIN
  Insert(Index, S);
  PutObject(Index, AObject);
END;

PROCEDURE TSTRINGs.LoadFromFile(CONST FileName: STRING);
var
  Source: TFileStream;
BEGIN
  try
    Source := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  except
    Source.Destroy;
    raise;
  END;

  try
    LoadFromStream(Source);
  finally
    Source.Destroy;
  END;
END;

PROCEDURE TSTRINGs.LoadFromStream(Stream: TStream);
BEGIN
  BEGINUpdate;
  try
    while not Stream.EndOfData do Add(Stream.ReadLn);
  finally
    EndUpdate;
  END;
END;

PROCEDURE TSTRINGs.Move(CurIndex, NewIndex: LongInt);
var
  O: TObject;
  S: STRING;
BEGIN
  IF CurIndex = NewIndex THEN Exit;
  S := Get(CurIndex);
  O := GetObject(CurIndex);
  Delete(CurIndex);
  InsertObject(NewIndex, S, O);
END;

PROCEDURE TSTRINGs.SaveToFile(CONST FileName: STRING);
var
  Dest: TFileStream;
BEGIN
  try
    Dest := TFileStream.Create(FileName, Stream_Create);
  except
    Dest.Destroy;
    raise;
  END;

  try
    SaveToStream(Dest);
  finally
    Dest.Destroy;
  END;
END;

PROCEDURE TSTRINGs.SaveToStream(Stream: TStream);
var
  N: LongInt;
BEGIN
  for N := 0 to Count - 1 do Stream.WriteLn(Get(N));
END;

PROCEDURE TSTRINGs.SetText(Text: PChar);

  FUNCTION SingleLineFromBuffer(VAR P: PChar): STRING;
  var
    I: Integer;
    Q: PChar;
  BEGIN
    {
    asm
      mov si, $P;
      mov di, !$FuncResult;
      inc di;
      xor cx, cx;

      !SingleLineFromBuffer_1:

      lodsb;
      cmp al, ' ';
      jng !SingleLineFromBuffer_2

      cmp al, 0;
      je !SingleLineFromBuffer_3
      cmp al, 10;
      je !SingleLineFromBuffer_3
      cmp al, 13;
      je !SingleLineFromBuffer_3
      cmp al, 26;
      je !SingleLineFromBuffer_3

      !SingleLineFromBuffer_2:

      stosb;
      inc cx;
      cmp cx, 255;
      jne !SingleLineFromBuffer_1

      !SingleLineFromBuffer_3:

      mov $P, si;
      mov $Result, cl;
    END;
    }

    I := 0;
    Q := P;
    while not (Q[0] in [#13, #10, #26, #0]) and (I < 255) do
    BEGIN
      Inc(Q);
      Inc(I);
    END;
    StrMove(@Result[1], P, I);
    SetLength(Result, I);
    P := Q;
    IF P[0] = #13 THEN Inc(P);
    IF P[0] = #10 THEN Inc(P);
  END;

BEGIN
  BEGINUpdate;
  try
    Clear;
    while not (Text[0] in [#0, #26]) do
    BEGIN
      Add(SingleLineFromBuffer(Text));
    END;
  finally
    EndUpdate;
  END;
END;

PROCEDURE TSTRINGs.SetUpdateState(Updating: Boolean);
BEGIN
END;

PROCEDURE TSTRINGs.SetValue(CONST Name, Value: STRING);
var
  I: LongInt;
  S: STRING;
BEGIN
  I := FindValue(Name, S);
  IF I < 0 THEN
  BEGIN
    IF Length(Value) <> 0 THEN Add(Name + '=' + Value)
  end
  else
  BEGIN
    IF Length(Value) <> 0 THEN Put(I, Name + '=' + Value)
    ELSE Delete(I);
  END;
END;

{ --- TStringList --- }

CONSTRUCTOR TStringList.Create;
BEGIN
  INHERITED Create;
  FList := TList.Create;
  FCaseSensitive := False;
END;

DESTRUCTOR TStringList.Destroy;
BEGIN
  { Die folgenden zwei Zeilen spter wieder ndern }
  Pointer(FOnChanging) := NIL;
  Pointer(FOnChange) := NIL;
  Clear;
  FList.Destroy;
END;

FUNCTION TStringList.Add(CONST S: STRING): LongInt;
BEGIN
  IF FSorted THEN
  BEGIN
    IF Find(S, Result) THEN
    BEGIN
      case FDuplicates of
        dupIgnore,
        dupReplace: Exit;
        dupError: raise ESTRINGListError.Create('TStringList: Dupe error.');
      END;
    END;
  end
  ELSE Result := Count;
  Changing;
  FList.Insert(Result, NewStrItem(S, nil));
  Changed;
END;

PROCEDURE TStringList.Changed;
BEGIN
  IF (FUpdateSemaphore = 0) and (FOnChange <> nil) THEN FOnChange(Self);
END;

PROCEDURE TStringList.Changing;
BEGIN
  IF (FUpdateSemaphore = 0) and (FOnChanging <> nil) THEN FOnChanging(Self);
END;

PROCEDURE TStringList.Clear;
var
  N: LongInt;
BEGIN
  Changing;
  for N := Count - 1 downto 0 do Delete(N);
  Changed;
END;

PROCEDURE TStringList.Delete(Index: LongInt);
BEGIN
  Changing;
  DisposeStrItem(FList.Get(Index));
  FList.Delete(Index);
  Changed;
END;

PROCEDURE TStringList.Exchange(Index1, Index2: LongInt);
BEGIN
  Changing;
  FList.Exchange(Index1, Index2);
  Changed;
END;

FUNCTION TStringList.Find(CONST S: STRING; VAR Index: LongInt): Boolean;
var
  Low, High: LongInt;
  Cmp: Integer;
  DoCompare: FUNCTION(CONST S, T: STRING): Integer;

BEGIN
  IF CaseSensitive THEN DoCompare := CompareStr
  ELSE DoCompare := CompareText;

  IF Sorted THEN
  BEGIN
    { Binary search }
    Low := 0;
    High := GetCount - 1;
    Index := 0;
    Cmp := -1;
    while (Cmp <> 0) and (Low <= High) do
    BEGIN
      Index := (Low + High) div 2;
      Cmp := DoCompare(S, Get(Index));
      IF Cmp < 0 THEN High := Index -1
      ELSE IF Cmp > 0 THEN Low := Index + 1;
    END;
    IF Low = Index + 1 THEN Inc(Index);
    Result := (Cmp = 0);
  end
  else
  BEGIN
    { Linear search }
    Index := 0;
    while (Index < Count) and (DoCompare(Get(Index), S) <> 0) do Inc(Index);
    Result := (Index < Count);
  END;
END;

FUNCTION TStringList.Get(Index: LongInt): STRING;
BEGIN
  Result := PStrItem(FList.Get(Index))^.FSTRING;
END;

FUNCTION TStringList.GetCount: LongInt;
BEGIN
  Result := FList.Count;
END;

FUNCTION TStringList.GetObject(Index: LongInt): TObject;
BEGIN
  Result := PStrItem(FList.Get(Index))^.FObject;
END;

FUNCTION TStringList.IndexOf(CONST S: STRING): LongInt;
BEGIN
  IF not Find(S, Result) THEN Result := -1;
END;

PROCEDURE TStringList.Insert(Index: LongInt; CONST S: STRING);
BEGIN
  Changing;
  IF FSorted THEN raise EListError.Create('Insertion into sorted list is not allowed.')
  ELSE FList.Insert(Index, NewStrItem(S, nil));
  Changed;
END;

PROCEDURE TStringList.Put(Index: LongInt; CONST S: STRING);
BEGIN
  Changing;
  DisposeStrItem(FList.Get(Index));
  FList.Put(Index, NewStrItem(S, nil));
  Changed;
END;

PROCEDURE TStringList.PutObject(Index: LongInt; AObject: TObject);
var
  P: PStrItem;
BEGIN
  P := FList.Get(Index);
  P^.FObject := AObject;
END;

PROCEDURE TStringList.BottomUpHeapSort;
var
  DoCompare: FUNCTION (CONST S, T: STRING): Integer;

  PROCEDURE Reheap(I, K: LongInt);
  var
    J: LongInt;
  BEGIN
    J := I;
    while J shl 1 < K do
    BEGIN
      IF DoCompare(Get(J shl 1 - 1), Get(J shl 1 + 1 - 1)) > 0 THEN J := J shl 1
      ELSE J := J shl 1 + 1;
    END;
    IF J shl 1 = K THEN J := K;

    while DoCompare(Get(I - 1), Get(J - 1)) > 0 do J := J shr 1;

    FList.Exchange(I - 1, J - 1);
    J := J shr 1;

    while J >= I do
    BEGIN
      FList.Exchange(I - 1, J - 1);
      J := J shr 1;
    END;
  END;

var
  I, C: LongInt;
BEGIN
  IF CaseSensitive THEN DoCompare := CompareStr
  ELSE DoCompare := CompareText;

  C := Count;
  for I := C shr 1 downto 1 do Reheap(I, C);
  for I := C downto 2 do
  BEGIN
    FList.Exchange(0, I - 1);
    Reheap(1, I - 1);
  END;
END;

PROCEDURE TStringList.SetCaseSensitive(Value: Boolean);
var
  Old: Boolean;
BEGIN
  Changing;
  Old := FCaseSensitive;
  FCaseSensitive := Value;
  IF FSorted and (FCaseSensitive <> Old) THEN Sort;
  Changed;
END;

PROCEDURE TStringList.SetSorted(Value: Boolean);
BEGIN
  Changing;
  IF (not FSorted) and Value THEN Sort;
  FSorted := Value;
  Changed;
END;

PROCEDURE TStringList.SetUpdateState(Updating: Boolean);
BEGIN
  IF Updating THEN Changing
  ELSE Changed;
END;

PROCEDURE TStringList.Sort;
BEGIN
  IF Count > 1 THEN
  BEGIN
    Changing;
    BottomUpHeapSort;
    Changed;
  END;
END;


BEGIN
END.
