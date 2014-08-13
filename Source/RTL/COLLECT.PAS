UNIT Collect;

INTERFACE

USES ObjectPM;

CONST
  MaxCollectionSize = $7FFFFFFF;
  vmtHeaderSize     = 8;

  { TCollection error codes }
  coIndexError = 1;              { Index out of range }
  coOverflow   = 2;              { Overflow }

TYPE
    {TCollection types}
    PItemList = ^TItemList;
    TItemList = array[0..655350] OF Pointer;

    {TCollection object}
    PCollection = ^TCollection;
    TCollection = OBJECT
                     Items: PItemList;
                     Count: LONGINT;
                     Limit: LONGINT;
                     Delta: LONGINT;
                     CONSTRUCTOR Init(ALimit, ADelta: LONGINT);
                     DESTRUCTOR  Done;VIRTUAL;
                     FUNCTION    At(Index:LONGINT): Pointer;
                     PROCEDURE   AtDelete(Index:LONGINT);
                     PROCEDURE   AtFree(Index:LONGINT);
                     PROCEDURE   AtInsert(Index:LONGINT; Item: Pointer);
                     PROCEDURE   AtPut(Index: LONGINT; Item: Pointer);
                     PROCEDURE   Delete(Item: Pointer);
                     PROCEDURE   DeleteAll;
                     PROCEDURE   Error(Code, Info: Integer);VIRTUAL;
                     FUNCTION    FirstThat(Test: Pointer): Pointer;
                     PROCEDURE   ForEach(Action: Pointer);
                     PROCEDURE   Free(Item: Pointer);
                     PROCEDURE   FreeAll;
                     PROCEDURE   FreeItem(Item: Pointer);VIRTUAL;
                     FUNCTION    IndexOf(Item: Pointer): LONGINT;VIRTUAL;
                     PROCEDURE   Insert(Item: Pointer); virtual;
                     FUNCTION    LastThat(Test: Pointer): Pointer;
                     PROCEDURE   Pack;
                     PROCEDURE  SetLimit(ALimit: LONGINT);VIRTUAL;
                END;



     {TSortedCollection object}
     PSortedCollection = ^TSortedCollection;
     TSortedCollection = OBJECT(TCollection)
                 Duplicates: Boolean;
                 CONSTRUCTOR Init(ALimit, ADelta: Integer);
                 FUNCTION    Compare(Key1, Key2: Pointer): Integer;VIRTUAL;
                 FUNCTION    IndexOf(Item: Pointer): LONGINT;VIRTUAL;
                 PROCEDURE   Insert(Item: Pointer);VIRTUAL;
                 FUNCTION    KeyOf(Item: Pointer): Pointer;VIRTUAL;
                 FUNCTION    Search(Key: Pointer; var Index: LONGINT): Boolean;VIRTUAL;
            END;


IMPLEMENTATION

{*************************************************************************
 *                                                                       *
 *  Object TCollection                                                   *
 *                                                                       *
 *************************************************************************}

CONSTRUCTOR TCollection.Init(ALimit, ADelta: LONGINT);
BEGIN
     Items := NIL;
     Count := 0;
     Limit := 0;
     Delta := ADelta;
     SetLimit(ALimit);
END;

DESTRUCTOR TCollection.Done;
BEGIN
     FreeAll;
     SetLimit(0);
END;

FUNCTION TCollection.At(Index: LONGINT): Pointer;
BEGIN
     IF (Index >= Count) OR (Index < 0) then Error(coIndexError,1);
     At := Items^[Index];
END;

PROCEDURE TCollection.AtDelete(Index: LONGINT);
VAR t:LONGINT;
BEGIN
    IF (Index >= Count) OR (Index < 0) then Error(coIndexError,2);

    t:=Count-Index;
    IF t>1 THEN Move(Items^[Index+1],Items^[Index],(t-1) * 4);
    Dec(Count);
end;

PROCEDURE TCollection.AtFree(Index: LONGINT);
BEGIN
     IF (Index > Count) OR (Index < 0) THEN Error(coIndexError,3);

     FreeItem(Items^[index]);
     AtDelete(Index);
end;

PROCEDURE TCollection.AtInsert(Index: LONGINT; Item: Pointer);
BEGIN
     IF (Index > Count) OR (Index < 0) THEN Error(coIndexError,3);

     IF Count >= Limit THEN SetLimit(Limit+Delta);
     IF Index < Count THEN
       Move(Items^[Index],Items^[Index+1],(Count-Index) * 4);
     Items^[Index] := Item;
     Inc(Count);
END;

PROCEDURE TCollection.AtPut(Index: LONGINT; Item: Pointer);
BEGIN
     IF (Index >= Count) OR (Index < 0) THEN Error(coIndexError,3);

     Items^[Index] := Item;
END;

PROCEDURE TCollection.Delete(Item: Pointer);
BEGIN
     AtDelete(IndexOf(Item));
end;

PROCEDURE TCollection.DeleteAll;
BEGIN
     Count := 0;
end;

PROCEDURE TCollection.Error(Code, Info: Integer);
BEGIN
     RunError(214 - Code);
END;

FUNCTION TCollection.FirstThat(Test: Pointer): Pointer;
VAR
    t:LONGINT;
    ThatFunc : FUNCTION(p:POINTER):BOOLEAN;
    result:POINTER;
LABEL l;
BEGIN
  ThatFunc := Test;
  IF Count>0 THEN
  FOR t:=0 TO Count-1 DO
  BEGIN
       IF ThatFunc(Items^[t]) THEN
       BEGIN
            result:=Items^[t];
            goto l;
       END;
  END;
  result:=NIL;
l:
  FirstThat:=result;
END;

PROCEDURE TCollection.ForEach(Action: Pointer);
VAR
    EachFunc:PROCEDURE(P:Pointer);
    t:LONGINT;
BEGIN
     EachFunc := Action;
     IF Count>0 THEN
       FOR t:= 0 to Count-1 DO EachFunc(Items^[t]);
END;

PROCEDURE TCollection.Free(Item: Pointer);
BEGIN
    Delete(Item);
    FreeItem(Item);
END;

PROCEDURE TCollection.FreeAll;
VAR
   t:LONGINT;
BEGIN
     IF Count>0 THEN
       FOR t:= 0 TO Count - 1 DO FreeItem(Items^[t]);
     Count := 0;
end;

PROCEDURE TCollection.FreeItem(Item: Pointer);
VAR
    p : POPMLObject;
BEGIN
    p:=Item;
    IF p <> NIL THEN Dispose(P, Done);
END;


FUNCTION TCollection.IndexOf(Item: Pointer):LONGINT;
VAR
   t : LONGINT;
   Result:LONGINT;
LABEL l;
BEGIN
     IF Count>0 THEN
     FOR t:=0 TO Count-1 DO
     BEGIN
          IF Items^[t]=Item THEN
          BEGIN
               result:=t;
               goto l;
          END;
     END;
     result:=-1;
l:
     IndexOf:=result;
END;

PROCEDURE TCollection.Insert(Item: Pointer);
BEGIN
     AtInsert(Count, Item);
END;

FUNCTION TCollection.LastThat(Test: Pointer): Pointer;
VAR
    t:LONGINT;
    ThatFunc:FUNCTION(p:Pointer):Boolean;;
    result:POINTER;
LABEL l;
BEGIN
     ThatFunc:=Test;
     IF Count>0 THEN
     FOR t:=Count-1 DOWNTO 0 DO
     BEGIN
          IF ThatFunc(Items^[t]) THEN
          BEGIN
               result:=Items^[t];
               goto l;
          END;
     END;
     result:=NIL;
l:
     LastThat:=result;
END;

PROCEDURE TCollection.Pack;
VAR
   t:LONGINT;
   t1:LONGINT;
BEGIN
     IF Count=0 THEN exit;
     FOR t:=0 TO Count-1 DO
     BEGIN
          IF Items^[t]=NIL THEN
          BEGIN
               t1:=Count-t;
               IF t1>1 THEN Move(Items^[t+1],Items^[t],t1-1);
               Dec(Count);
          END;
     END;
END;


PROCEDURE TCollection.SetLimit(ALimit: LONGINT);
VAR
   dummy:PItemList;
BEGIN
     IF ALimit=0 THEN
     BEGIN
          IF Items<>NIL THEN FreeMem(Items,Limit*4);
          Items:=NIL;
          Limit:=0;
          exit;
     END;

     IF ALimit<Count THEN ALimit:=Count;
     GetMem(dummy,ALimit*4);
     Move(Items^[0],dummy^[0],Count*4);
     IF Limit<>0 THEN FreeMem(Items,Limit*4);
     Limit:=ALimit;
     Items:=dummy;
END;


{*************************************************************************
 *                                                                       *
 *  Object TCollection                                                   *
 *                                                                       *
 *************************************************************************}

CONSTRUCTOR TSortedCollection.Init(ALimit, ADelta: Integer);
BEGIN
  TCollection.Init(ALimit, ADelta);
  Duplicates := False;
END;


FUNCTION TSortedCollection.Compare(Key1, Key2: Pointer): Integer;
BEGIN
     Abstract;
END;

FUNCTION TSortedCollection.IndexOf(Item: Pointer): LONGINT;
VAR
  t: LONGINT;
  result:LONGINT;
BEGIN
     result := -1;
     IF Count>0 THEN IF Search(KeyOf(Item), t) THEN
     BEGIN
         IF Duplicates THEN
           WHILE (t< Count) AND (Item <> Items^[t]) DO Inc(t);
         IF t < Count THEN result := t;
     END;
     IndexOf:=result;
END;

PROCEDURE TSortedCollection.Insert(Item: Pointer);
VAR
   I: LONGINT;
BEGIN
     IF Search(KeyOf(Item), I) THEN
     BEGIN
          IF Duplicates THEN AtInsert(I, Item);
     END
     ELSE AtInsert(I,Item);
END;

FUNCTION TSortedCollection.KeyOf(Item: Pointer): Pointer;
BEGIN
     KeyOf := Item;
END;

FUNCTION TSortedCollection.Search(Key: Pointer;
                                  VAR Index: LONGINT): BOOLEAN;
VAR
   L, H, I, C: LONGINT;
   result:BOOLEAN;
LABEL ll;
BEGIN
     L := 0;
     H := Count - 1;
     result:=FALSE;
     WHILE L <= H do
     BEGIN
          I := (L + H) DIV 2;
          C := Compare(KeyOf(Items^[I]), Key);
          CASE C OF
             0:
             BEGIN
                  result:=TRUE;
                  IF NOT Duplicates THEN
                  BEGIN
                       L:=I;
                       goto ll;
                  END
                  ELSE
                  BEGIN
                       WHILE ((c = 0)AND(i > 0)) DO
                       BEGIN
                            Dec(i);
                            C := Compare(KeyOf(Items^[i]), Key);
                       END;
                       L:=I;
                       goto ll;
                  END;
             END;
             ELSE
             BEGIN
                  IF C < 0 then L := I + 1
                  ELSE  H := I - 1;
             END;
          END; {case}
    END; {WHILE}
ll:
    Index := L;
    Search:=Result;
END;


BEGIN
END.