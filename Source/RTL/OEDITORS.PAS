UNIT OEditors;

{**************************************************************************
 *                                                                        *
 *    General definitions for OEditors                                    *
 *    (C) 1993,94,95  NL SpeedSoft                                        *
 *                                                                        *
 **************************************************************************}

INTERFACE

{$Z+}

USES Dos,Crt,Os2Def,ObjectPm,ODialogs,BseDos,PMWin,PMGpi,PMStdDlg,PMDev,PMSpl,
     PMShl;


CONST StringLength       = 250;
      NormalChars        : SET OF CHAR = ['0'..'9','A'..'Z','a'..'z','_',
                                          '„','Ž','”','™','','š','á'];
      MaxUndoEvents      = 32;
      MaxRedoEvents      = 32;

      FRD_Forward        = 1;
      FRD_FromCursor     = 2;
      FRD_CaseSensitiv   = 4;
      FRD_WordsOnly      = 8;
      FRD_Confirm        = 16;
      FRD_ReplaceAll     = 32;
      FR_Find            = 1;
      FR_Replace         = 2;

      EOD_UseCUA         = 1;
      EOD_CreateBackup   = 2;
      EOD_InsertMode     = 4;
      EOD_AutoIndentMode = 8;
      EOD_Unindent       = 16;

      CI_Normal          = 0;
      CI_Selected        = 1;

      BM_0               = 4096;
      Mask4MSB           = 61440;

      UG_NoGroup         = 0;
      UG_CursorMove      = 1;
      UG_InsertChar      = 2;
      UG_OverwriteChar   = 4;
      UG_DeleteChar      = 8;
      UG_BackspaceChar   = 16;

      kbPreCtrlK         = kb_Ctrl + 4096;
      kbPreCtrlQ         = kb_Ctrl + 8192;
      kbPreCtrlO         = kb_Ctrl + 16384;
      kbPreCtrlB         = kb_Ctrl + 32768;
      kbPreCtrlU         = kb_Ctrl + 65536;

      {Ctrl-K Codes}
      kbCtrlKA           = kbPreCtrlK + 65;
      kbCtrlKB           = kbPreCtrlK + 66;
      kbCtrlKC           = kbPreCtrlK + 67;
      kbCtrlKD           = kbPreCtrlK + 68;
      kbCtrlKE           = kbPreCtrlK + 69;
      kbCtrlKF           = kbPreCtrlK + 70;
      kbCtrlKG           = kbPreCtrlK + 71;
      kbCtrlKH           = kbPreCtrlK + 72;
      kbCtrlKI           = kbPreCtrlK + 73;
      kbCtrlKJ           = kbPreCtrlK + 74;
      kbCtrlKK           = kbPreCtrlK + 75;
      kbCtrlKL           = kbPreCtrlK + 76;
      kbCtrlKM           = kbPreCtrlK + 77;
      kbCtrlKN           = kbPreCtrlK + 78;
      kbCtrlKO           = kbPreCtrlK + 79;
      kbCtrlKP           = kbPreCtrlK + 80;
      kbCtrlKQ           = kbPreCtrlK + 81;
      kbCtrlKR           = kbPreCtrlK + 82;
      kbCtrlKS           = kbPreCtrlK + 83;
      kbCtrlKT           = kbPreCtrlK + 84;
      kbCtrlKU           = kbPreCtrlK + 85;
      kbCtrlKV           = kbPreCtrlK + 86;
      kbCtrlKW           = kbPreCtrlK + 87;
      kbCtrlKX           = kbPreCtrlK + 88;
      kbCtrlKY           = kbPreCtrlK + 89;
      kbCtrlKZ           = kbPreCtrlK + 90;

      {Ctrl-Q Codes}
      kbCtrlQA           = kbPreCtrlQ + 65;
      kbCtrlQB           = kbPreCtrlQ + 66;
      kbCtrlQC           = kbPreCtrlQ + 67;
      kbCtrlQD           = kbPreCtrlQ + 68;
      kbCtrlQE           = kbPreCtrlQ + 69;
      kbCtrlQF           = kbPreCtrlQ + 70;
      kbCtrlQG           = kbPreCtrlQ + 71;
      kbCtrlQH           = kbPreCtrlQ + 72;
      kbCtrlQI           = kbPreCtrlQ + 73;
      kbCtrlQJ           = kbPreCtrlQ + 74;
      kbCtrlQK           = kbPreCtrlQ + 75;
      kbCtrlQL           = kbPreCtrlQ + 76;
      kbCtrlQM           = kbPreCtrlQ + 77;
      kbCtrlQN           = kbPreCtrlQ + 78;
      kbCtrlQO           = kbPreCtrlQ + 79;
      kbCtrlQP           = kbPreCtrlQ + 80;
      kbCtrlQQ           = kbPreCtrlQ + 81;
      kbCtrlQR           = kbPreCtrlQ + 82;
      kbCtrlQS           = kbPreCtrlQ + 83;
      kbCtrlQT           = kbPreCtrlQ + 84;
      kbCtrlQU           = kbPreCtrlQ + 85;
      kbCtrlQV           = kbPreCtrlQ + 86;
      kbCtrlQW           = kbPreCtrlQ + 87;
      kbCtrlQX           = kbPreCtrlQ + 88;
      kbCtrlQY           = kbPreCtrlQ + 89;
      kbCtrlQZ           = kbPreCtrlQ + 90;

      kbCtrlShiftCLeft   = kb_Ctrl + kb_Shift + kbCLeft;
      kbCtrlShiftCRight  = kb_Ctrl + kb_Shift + kbCRight;
      kbCtrlShiftPageUp  = kb_Ctrl + kb_Shift + kbPageUp;
      kbCtrlShiftPageDown= kb_Ctrl + kb_Shift + kbPageDown;
      kbCtrlShiftPos1    = kb_Ctrl + kb_Shift + kbPos1;
      kbCtrlShiftEnd     = kb_Ctrl + kb_Shift + kbEnd;

      kbShiftAltBS       = kb_Shift + kb_Alt + kbBS;

      kbCtrlSlash        = kb_Ctrl + 47;
      kbCtrlBackSlash    = kb_Ctrl + 92;

      kbCtrlOI           = kbPreCtrlO + 73;
      kbCtrlK0           = kbPreCtrlK + 48;
      kbCtrlK9           = kbPreCtrlK + 57;
      kbCtrlQ0           = kbPreCtrlQ + 48;
      kbCtrlQ9           = kbPreCtrlQ + 57;
      kbCtrlU0           = kbPreCtrlU + 48;
      kbCtrlU9           = kbPreCtrlU + 57;
      kbCtrlUU           = kbPreCtrlU + 85;

      WM_DISMISS         = WM_SPEED_USER + 1;


TYPE PLine=^TLine;
     TLine=RECORD
                 prev  : PLine;
                 zk    : PSTRING;
                 color : WORD;
                 next  : PLine;
            END;


     PLineColor=^TLineColor;
     TLineColor=RECORD
                      Color     : INTEGER;
                      BackColor : INTEGER;
                END;


     PPrintInfo=^TPrintInfo;
     TPrintInfo=RECORD
                      PRN_LeftIndent  : LONGINT;
                      PRN_UpperIndent : LONGINT;
                      PRN_LowerIndent : LONGINT;
                      PRN_LineDist    : LONGINT;
                      OffsX           : LONGWORD;
                      OffsY           : LONGWORD;
                      OffsFL          : LONGWORD;
                      PrinterDC       : HDC;
                      PrinterPS       : HPS;
                      Text            : POINTER;
                      TextLen         : LONGWORD;
                      AbortHwnd       : HWND;
                      Status          : BYTE;
                      PTid            : TID;
                END;


     PSliderData=^SliderData;
     SliderData=RECORD
                      scrollbottom : LONGWORD; { Scroll lower border  }
                      scrolltop    : LONGWORD; { Scroll upper border  }
                      viewarea     : LONGWORD; { View area of window  }
                      acvalue      : LONGWORD; { actual Slider value  }
                END;


     TICB=RECORD                               {Internal Clipboard}
                FirstLine : PLine;
                FirstX    : WORD;
                LastLine  : PLine;
                LastX     : WORD;
          END;


     TUNDO=RECORD
                 Event         : BYTE;
                 Modified      : BOOLEAN;
                 ICBFL         : LONGWORD;
                 ICBFX         : WORD;
                 ICBLL         : LONGWORD;
                 ICBLX         : WORD;
                 FCX           : WORD;
                 FCY           : LONGWORD;
                 FrameBegin    : LONGWORD;
                 FrameEnd      : LONGWORD;
                 FirstUndoLine : PLine;
                 LastUndoLine  : PLine;
                 Lines         : LONGWORD;
           END;


     TUndoList=ARRAY[0..MaxUndoEvents-1] OF TUNDO;


     PEditorWindow=^TEditorWindow;
     TEditorWindow=OBJECT(TWindow)
                   FileName        : STRING;
                   StdExt          : STRING;
                   NewEditorPtr    : LONGWORD;
                   ResidentHPS     : HPS;
                   HSlider         : SliderData;
                   VSlider         : SliderData;
                   WindowRect      : RECTL;
                   WinSizeX        : LONGWORD;
                   WinSizeY        : LONGWORD;
                   Sel_Color       : INTEGER;
                   Sel_BackColor   : INTEGER;
                   ICBVisible      : BOOLEAN;
                   ClearFullBkGr   : BOOLEAN;
                   Modified        : BOOLEAN;
                   Untitled        : BOOLEAN;
                   WLactivated     : BOOLEAN;
                   IgnoreRedraw    : BOOLEAN;
                   WindowGetFocus  : BOOLEAN;
                   FirstLine       : PLine;
                   ActLine         : PLine;
                   LastLine        : PLine;
                   FirstScreenLine : PLine;
                   FileCursorY     : LONGWORD;
                   FileCursorX     : WORD;
                   ScrCursorY      : WORD;
                   ScrCursorX      : WORD;
                   CountLines      : LONGWORD;
                   WorkLine        : PSTRING;
                   ICB             : TICB;
                   OldICB          : TICB;
                   FindICB         : BOOLEAN;
                   UndoEvents      : WORD;
                   LastUndo        : WORD;
                   UndoEvent       : TUndoList;
                   RedoEvents      : WORD;
                   LastRedo        : WORD;
                   RedoEvent       : TUndoList;
                   LastUndoGroup   : WORD;
                   szDriverName    : CSTRING;
                   szDeviceName    : CSTRING;
                   szLogAddress    : CSTRING;
                   szDataType      : CSTRING;
                   PrintInfo       : TPrintInfo;
                   BookMarkColumn  : ARRAY[0..9] OF WORD;

                   CONSTRUCTOR Init(AParent:PWindowsObject; ATitle:STRING);
                   FUNCTION    CanClose:BOOLEAN;VIRTUAL;
                   PROCEDURE   SetupWindow;VIRTUAL;
                   PROCEDURE   HandleCharEvent(Win:HWND; param,Rep:WORD);VIRTUAL;
                   PROCEDURE   HandleScanEvent(Win:HWND; param,Rep:WORD);VIRTUAL;
                   PROCEDURE   Redraw(VAR ahps:HPS; VAR rc:RECTL);VIRTUAL;
                   PROCEDURE   WindowDestroyed;VIRTUAL;

                   PROCEDURE   WMPresParamChanged(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_PRESPARAMCHANGED;
                   PROCEDURE   WMSize(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_SIZE;
                   PROCEDURE   WMSetFocus(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_SETFOCUS;
                   PROCEDURE   WMButton1Up(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_BUTTON1UP;
                   PROCEDURE   WMButton1Down(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_BUTTON1DOWN;
                   PROCEDURE   WMButton1DBLCLK(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_BUTTON1DBLCLK;
                   PROCEDURE   WMMouseDrag1(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_MOUSEDRAG1;
                   PROCEDURE   WMMouseMove(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_MOUSEMOVE;
                   PROCEDURE   WMHScroll(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_HSCROLL;
                   PROCEDURE   WMVScroll(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_VSCROLL;
                   PROCEDURE   WMBeginDrag(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+WM_BEGINDRAG;
                   PROCEDURE   DMDragOver(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+DM_DRAGOVER;
                   PROCEDURE   DMDrop(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+DM_DROP;
                   PROCEDURE   DMDropHelp(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+DM_DROPHELP;
                   PROCEDURE   DMPrintObject(VAR Msg:TMessage);
                               VIRTUAL WM_FIRST+DM_PRINTOBJECT;

                   PROCEDURE   SetSliderValues;
                   PROCEDURE   SetSliderPosition;
                   PROCEDURE   SetCursorXY;
                   PROCEDURE   SetEditorPtr(id,res:LONGWORD);VIRTUAL;
                   PROCEDURE   UpdateEditorStatus;VIRTUAL;
                   PROCEDURE   SetStatusMessage(sm:STRING);VIRTUAL;
                   PROCEDURE   SetWindowTitleText(str:STRING);VIRTUAL;
                   PROCEDURE   SetErrorMessage(button:LONGWORD;titel,text:STRING);
                               VIRTUAL;
                   FUNCTION    SetQueryMessage(titel,text:STRING;buttons:LONGWORD):
                               LONGWORD;VIRTUAL;
                   FUNCTION    UpdateLineColorFlag(PL:PLine):BOOLEAN;VIRTUAL;
                   PROCEDURE   SetLineColorFlag(PL1,PL2:PLine);VIRTUAL;
                   PROCEDURE   CalcLineColor(PL:PLine);VIRTUAL;
                   PROCEDURE   InvalidateEditorLine(PL:PLine; CY:WORD);VIRTUAL;
                   PROCEDURE   InvalidateSingleLine;VIRTUAL;
                   PROCEDURE   InvalidateEditorWindow(ab:WORD);VIRTUAL;

                   PROCEDURE   LoadFile(Name:STRING);VIRTUAL;
                   FUNCTION    CopyLinesLinear(VAR Len:LONGWORD):POINTER;
                   FUNCTION    SaveFile:BOOLEAN;VIRTUAL;
                   PROCEDURE   SaveAsFile;VIRTUAL;
                   PROCEDURE   CloseFile;VIRTUAL;
                   FUNCTION    GetTextFromCursor:STRING;
                   FUNCTION    FindTextPos(s:STRING; w:WORD;
                               VAR CY:LONGWORD; VAR CX:LONGWORD):BOOLEAN;
                   PROCEDURE   FindText(s:STRING; w:WORD);VIRTUAL;
                   PROCEDURE   ReplaceText(s,s1:STRING; w:WORD);VIRTUAL;
                   PROCEDURE   SearchTextAgain;VIRTUAL;
                   FUNCTION    GotoLine(y,x:LONGWORD):BOOLEAN;VIRTUAL;
                   PROCEDURE   UpdateFont;
                   PROCEDURE   _WriteWorkLine;
                   PROCEDURE   _ReadWorkLine;
                   FUNCTION    _Long2PLine(L:LONGWORD):PLine;
                   FUNCTION    _PLine2Long(PL:PLine):LONGWORD;
                   FUNCTION    _HorizMove:BOOLEAN;
                   FUNCTION    _ReadString(PL:PLine; CX,count:WORD):STRING;
                   FUNCTION    _InsertString(CX:WORD; str:STRING):BOOLEAN;
                   FUNCTION    _WriteString(CX:WORD; str:STRING):BOOLEAN;
                   FUNCTION    _DeleteString(CX:WORD; anz:WORD):BOOLEAN;
                   FUNCTION    _InsertLine(PL:PLine):BOOLEAN;
                   FUNCTION    _DeleteLine(PL:PLine):BOOLEAN;
                   PROCEDURE   _Connect(PL1,PL2:PLine);
                   PROCEDURE   DeleteChar;
                   PROCEDURE   BackSpace;
                   FUNCTION    _FindNextTab(PL:PLine; CX:WORD):WORD;
                   PROCEDURE   Tabulator;
                   PROCEDURE   CarriageReturn;
                   PROCEDURE   DeleteLine;
                   PROCEDURE   LineInsert;
                   PROCEDURE   DeleteUntilEnd;
                   PROCEDURE   DeleteRightWord;
                   PROCEDURE   ToggleInsertMode;
                   PROCEDURE   ToggleICBVisibility;
                   PROCEDURE   CursorDown(rep:WORD);
                   PROCEDURE   CursorUp(rep:WORD);
                   PROCEDURE   CursorRight;
                   PROCEDURE   CursorLeft;
                   PROCEDURE   PageDown;
                   PROCEDURE   PageUp;
                   PROCEDURE   RollUp;
                   PROCEDURE   RollDown;
                   PROCEDURE   CursorPos1;
                   PROCEDURE   CursorEnd;
                   PROCEDURE   WordRight;
                   PROCEDURE   WordLeft;
                   PROCEDURE   GotoBegin;
                   PROCEDURE   GotoEnd;
                   PROCEDURE   PageHome;
                   PROCEDURE   PageEnd;
                   FUNCTION    _CuaICBPresent:BOOLEAN;
                   PROCEDURE   _CuaClearMark;
                   PROCEDURE   _CuaOverWriteBlock;
                   PROCEDURE   CuaCursorDown(rep:WORD);
                   PROCEDURE   CuaCursorUp(rep:WORD);
                   PROCEDURE   CuaCursorRight;
                   PROCEDURE   CuaCursorLeft;
                   PROCEDURE   CuaPageDown;
                   PROCEDURE   CuaPageUp;
                   PROCEDURE   CuaRollUp;
                   PROCEDURE   CuaRollDown;
                   PROCEDURE   CuaCursorPos1;
                   PROCEDURE   CuaCursorEnd;
                   PROCEDURE   CuaWordRight;
                   PROCEDURE   CuaWordLeft;
                   PROCEDURE   CuaGotoBegin;
                   PROCEDURE   CuaGotoEnd;
                   PROCEDURE   CuaPageHome;
                   PROCEDURE   CuaPageEnd;
                   PROCEDURE   CuaDeleteChar;
                   PROCEDURE   CuaBackSpace;

                   PROCEDURE   CuaTabulator;
                   PROCEDURE   CuaCarriageReturn;
                   PROCEDURE   CuaPasteFromClipBoard;
                   PROCEDURE   CuaPasteFromFile(s:STRING);

                   PROCEDURE   _ICBClearMark;
                   PROCEDURE   _ICBSetMark;
                   PROCEDURE   _CheckICB;
                   FUNCTION    _ICBPos(PL:PLine; CX:WORD):BYTE;
                   PROCEDURE   ICBSetBegin;
                   PROCEDURE   ICBSetEnd;
                   PROCEDURE   ICBSelectWord;
                   PROCEDURE   ICBSelectLine;
                   PROCEDURE   ICBSelectAll;
                   PROCEDURE   ICBDeselectAll;
                   PROCEDURE   ICBGotoBegin;
                   PROCEDURE   ICBGotoEnd;
                   PROCEDURE   ICBCopyBlock;
                   PROCEDURE   ICBMoveBlock;
                   PROCEDURE   ICBDeleteBlock;
                   PROCEDURE   ICBReadBlock;
                   PROCEDURE   ICBWriteBlock;
                   PROCEDURE   ICBMoveLeft;
                   PROCEDURE   ICBMoveRight;
                   PROCEDURE   _ICBExtSetICB;
                   PROCEDURE   _ICBExtCorrectICB;
                   PROCEDURE   ICBExtLeft;
                   PROCEDURE   ICBExtRight;
                   PROCEDURE   ICBExtUp;
                   PROCEDURE   ICBExtDown;
                   PROCEDURE   ICBExtPageUp;
                   PROCEDURE   ICBExtPageDown;
                   PROCEDURE   ICBExtPos1;
                   PROCEDURE   ICBExtEnd;
                   PROCEDURE   ICBExtWordLeft;
                   PROCEDURE   ICBExtWordRight;
                   PROCEDURE   ICBExtFileBegin;
                   PROCEDURE   ICBExtFileEnd;
                   FUNCTION    _CopyICBLinear(VAR Len:LONGWORD):POINTER;
                   PROCEDURE   _PasteICBLinear(P:POINTER; Len:LONGWORD);
                   FUNCTION    _SetClipBoardText(P:POINTER; Len:LONGWORD):BOOLEAN;
                   FUNCTION    _GetClipBoardText(VAR Len:LONGWORD):POINTER;
                   FUNCTION    _GetFileText(s:STRING; VAR Len:LONGWORD):POINTER;
                   PROCEDURE   CutToClipBoard;
                   PROCEDURE   CopyToClipBoard;
                   PROCEDURE   PasteFromClipBoard;
                   PROCEDURE   PasteFromFile(s:STRING);
                   PROCEDURE   EnableCopyCut;VIRTUAL;
                   PROCEDURE   DisableCopyCut;VIRTUAL;
                   PROCEDURE   EnablePaste;VIRTUAL;
                   PROCEDURE   DisablePaste;VIRTUAL;
                   PROCEDURE   EnableUndo;VIRTUAL;
                   PROCEDURE   DisableUndo;VIRTUAL;
                   PROCEDURE   EnableRedo;VIRTUAL;
                   PROCEDURE   DisableRedo;VIRTUAL;
                   FUNCTION    _CountLines(FirstL,LastL:PLine):LONGWORD;
                   PROCEDURE   _StoreUndoCursor;
                   FUNCTION    _CopyUndoLines(FirstL,LastL:PLine):LONGWORD;
                   FUNCTION    _MoveUndoLines(FirstL,LastL:PLine):LONGWORD;
                   PROCEDURE   _CreateUndoEvent(U:TUNDO);
                   PROCEDURE   _DeleteUndoEvent(Nr:WORD);
                   PROCEDURE   Undo;
                   FUNCTION    _MoveRedoLines(FirstL,LastL:PLine):LONGWORD;
                   PROCEDURE   _CreateRedoEvent(U:TUNDO);
                   PROCEDURE   _DeleteRedoEvent(Nr:WORD);
                   PROCEDURE   Redo;
                   FUNCTION    _FindBookMark(BM:WORD):PLine;
                   PROCEDURE   GotoBookMark(Scan:LONGWORD);
                   PROCEDURE   SetBookMark(Scan:LONGWORD);
                   PROCEDURE   DeleteBookMark(Scan:LONGWORD);
                   PROCEDURE   DeleteAllBookMarks;
                   FUNCTION    GetPrinterDevice(VAR dopPrinter:DEVOPENSTRUC):
                               BOOLEAN;VIRTUAL;
                   PROCEDURE   PrintFile;VIRTUAL;
                   PROCEDURE   InitializePrinting;VIRTUAL;
                   END;



     TAvailFont=RECORD
                      PointSize : BYTE;
                      FontName  : STRING[32];
                      Height    : BYTE;
                      Width     : BYTE;
                      BaseLine  : BYTE;
                END;


     FUNCTION QueryFonts(ahps:HPS):BYTE;


VAR  OutputString   : STRING;
     LineColor      : ARRAY[1..260] OF TLineColor;
     EditOptions    : LONGWORD;
     FindOptions    : WORD;
     ReplOptions    : WORD;
     LastFRD        : BYTE;
     aSearchString  : STRING;
     aReplaceString : STRING;
     DragStaticX    : WORD;
     DragStaticY    : LONGWORD;
     DragStaticLine : PLine;
     PreCtrl        : LONGWORD;
     ChangeICB      : BOOLEAN;
     WinReadOnly    : BOOLEAN;
     FaceName       : CSTRING;
     CharHeight     : BYTE;
     CharWidth      : BYTE;
     CharBaseLine   : BYTE;
     AvailFontCount : BYTE;
     AvailFont      : ARRAY[0..99] OF TAvailFont;
     NLSTable       : ARRAY[1..29] OF STRING[80]; {Language Support Table}
     CursorRate     : LONGWORD;



IMPLEMENTATION

CONST
     POS_OUTICB         = 0;
     POS_BEFOREICBFIRST = 1;
     POS_AFTERICBFIRST  = 2;
     POS_INICB          = 4;
     POS_BEFOREICBLAST  = 8;
     POS_AFTERICBLAST   = 16;
     POS_FIRSTICBLINE   = 3;      {Bit 1 or 2 set}
     POS_LASTICBLINE    = 24;     {Bit 8 or 16 set}



{ ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow._WriteWorkLine;
{Write back content of WORKLINE}
BEGIN
     WHILE (Length(WorkLine^) > 0) AND (WorkLine^[Length(WorkLine^)] = ' ')
       DO dec(WorkLine^[0]);
     IF Length(WorkLine^) > StringLength THEN WorkLine^[0] := chr(StringLength);

     GetMem(ActLine^.zk,Length(WorkLine^)+1);    {+1 Byte for Length}
     move(WorkLine^[0],ActLine^.zk^[0],Length(WorkLine^)+1);
     WLactivated := FALSE;
END;



PROCEDURE TEditorWindow._ReadWorkLine;
{Read content of a line into WORKLINE}
BEGIN
     FillChar(WorkLine^[1],StringLength,32);

     move(ActLine^.zk^[0],WorkLine^[0],Length(ActLine^.zk^)+1);
     FreeMem(ActLine^.zk,Length(ActLine^.zk^)+1);
     ActLine^.zk := NIL;
     WLactivated := TRUE;
END;



FUNCTION TEditorWindow._PLine2Long(PL:PLine):LONGWORD;
{convert pointer to linenumber}
VAR  ptline : PLine;
     L : LONGWORD;
BEGIN
     L := 0;
     IF PL <> NIL THEN
     BEGIN
          ptline := FirstLine;
          L := 1;
          WHILE (ptline <> PL) AND (ptline <> NIL) DO
          BEGIN
               ptline := ptline^.next;
               inc(L);
          END;
          IF ptline = NIL THEN L := 0;
     END;
     _PLine2Long := L;
END;



FUNCTION TEditorWindow._Long2PLine(L:LONGWORD):PLine;
{convert linenumber to pointer}
VAR  ptline : PLine;
     i : LONGWORD;
BEGIN
     ptline := NIL;
     IF (L >= 1) AND (L <= CountLines) THEN
     BEGIN
          ptline := FirstLine;
          FOR i := 2 TO L DO
             IF ptline^.next <> NIL THEN ptline := ptline^.next
     END;
     _Long2PLine := ptline;
END;



FUNCTION TEditorWindow._HorizMove:BOOLEAN;
BEGIN
     _HorizMove := HSlider.acvalue <> FileCursorX-ScrCursorX+1;
END;


FUNCTION QueryFonts(ahps:HPS):BYTE;
TYPE tFM=ARRAY[0..999] OF FONTMETRICS;
     pFM=^tFM;
VAR  ahdc : HDC;
     lRequestFonts,FontCount : LONGINT;
     lHorzRes,lVertRes : LONGINT;
     i : INTEGER;
     count : WORD;
     FM : pFM;
     PointSize : WORD;
BEGIN
     QueryFonts := 0;

     ahdc := GpiQueryDevice(ahps);
     DevQueryCaps(ahdc, CAPS_HORIZONTAL_FONT_RES, 1, lHorzRes);
     DevQueryCaps(ahdc, CAPS_VERTICAL_FONT_RES, 1, lVertRes);

     lRequestFonts := 0;

     FontCount := GpiQueryFonts(ahps,
                                QF_PUBLIC,
                                NIL,
                                lRequestFonts,
                                0,
                                NIL);

     IF FontCount <= 0 THEN exit;

     GetMem(FM,FontCount*SizeOf(FONTMETRICS));

     GpiQueryFonts(ahps,
                   QF_PUBLIC,
                   NIL,
                   FontCount,
                   SizeOf(FONTMETRICS),
                   FM^[0]);

     count := 0;
     FOR i := 0 TO FontCount-1 DO
     IF (FM^[i].sXDeviceRes = lHorzRes) AND
        (FM^[i].sYDeviceRes = lVertRes) AND
        ((FM^[i].fsDefn AND FM_DEFN_OUTLINE) = 0) AND      {is Bitmap font}
        ((FM^[i].fsType AND FM_TYPE_FIXED) <> 0) THEN      {is monospaced}
     BEGIN
          PointSize := FM^[i].sNominalPointSize DIV 10;
          AvailFont[count].PointSize := PointSize;
          AvailFont[count].FontName := FM^[i].szFaceName;
          AvailFont[count].Height := FM^[i].lMaxBaseLineExt;
          AvailFont[count].Width := FM^[i].lAveCharWidth;
          AvailFont[count].BaseLine := FM^[i].lMaxDescender;
          inc(count);
          IF count > 99 THEN break;
     END;

     FreeMem(FM,FontCount*SizeOf(FONTMETRICS));

     QueryFonts := count;
END;


PROCEDURE TEditorWindow.UpdateFont;
VAR  FCX, FCY : LONGWORD;
     rc : RECTL;
BEGIN
     WinSizeX := (WindowRect.XRight-4) DIV CharWidth;
     WinSizeY := (WindowRect.yTop-2-CharBaseLine) DIV CharHeight;
     IF ScrCursorY > WinSizeY
     THEN FCY := FileCursorY-ScrCursorY+WinSizeY
     ELSE FCY := FileCursorY;
     IF ScrCursorX > WinSizeX
     THEN FCX := FileCursorX-ScrCursorX+WinSizeX
     ELSE FCX := FileCursorX;

     CreateLogFont(ResidentHPS,FaceName,CharHeight,CharWidth,0);
     SetSliderValues;
     GotoLine(FCY,FCX);
     Redraw(ResidentHPS,rc);
     IgnoreRedraw := WinSizeY = 0;
END;


{ +++ Block ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow._ICBClearMark;
{Delete all ICB marks}
VAR  ptline : PLine;
BEGIN
     _CheckICB;
     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN exit;
     ptline := ICB.FirstLine;
     WHILE ptline <> ICB.LastLine DO
     BEGIN
          ptline^.color := ptline^.color AND NOT CI_Selected;
          ptline := ptline^.next;
     END;
     ptline^.color := ptline^.color AND NOT CI_Selected;
END;



PROCEDURE TEditorWindow._ICBSetMark;
{mark lines of current ICB}
VAR  ptline : PLine;
BEGIN
     _CheckICB;
     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN exit;
     ptline := ICB.FirstLine;
     WHILE ptline <> ICB.LastLine DO
     BEGIN
          ptline^.color := ptline^.color OR CI_Selected;
          ptline := ptline^.next;
     END;
     ptline^.color := ptline^.color OR CI_Selected;
     ICBVisible := TRUE;
END;



PROCEDURE TEditorWindow._CheckICB;
BEGIN
     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN DisableCopyCut
     ELSE
     BEGIN
          IF (ICB.FirstLine = ICB.LastLine) AND (ICB.FirstX = ICB.LastX)
          THEN DisableCopyCut
          ELSE EnableCopyCut;
     END;

     IF ICB.FirstX > StringLength THEN ICB.FirstX := StringLength;
     IF ICB.LastX > StringLength THEN ICB.LastX := StringLength;
END;



FUNCTION TEditorWindow._ICBPos(PL:PLine; CX:WORD):BYTE;
{Calculate code of current position to ICB}
VAR  P : BYTE;
BEGIN
     P := 0;
     IF PL = NIL THEN exit;

     IF PL = ICB.FirstLine THEN
     BEGIN
          IF CX < ICB.FirstX THEN P := P OR POS_BEFOREICBFIRST
          ELSE P := P OR POS_AFTERICBFIRST;
     END;

     IF PL = ICB.LastLine THEN
     BEGIN
          IF CX < ICB.LastX THEN P := P OR POS_BEFOREICBLAST
          ELSE P := P OR POS_AFTERICBLAST;
     END;

     IF (PL^.color AND CI_Selected <> 0) AND (P = 0) THEN P := POS_INICB;
     _ICBPos := P;
END;



FUNCTION TEditorWindow._SetClipBoardText(P:POINTER; Len:LONGWORD):BOOLEAN;
VAR  PBuf : POINTER;
BEGIN
     _SetClipBoardText := FALSE;
     IF WinOpenClipBrd(AppHandle) THEN
     BEGIN
          DosAllocSharedMem(PBuf,NIL,Len,PAG_WRITE OR PAG_COMMIT OR OBJ_GIVEABLE);
          IF PBuf = NIL THEN
          BEGIN
               WinCloseClipBrd(AppHandle);
               SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[2]);
               exit;
          END;
          ASM
             MOV ESI,$P
             MOV EDI,$PBuf
             MOV ECX,$Len
             CLD
             MOV EDX,ECX
             SHR ECX,2
             REP
             MOVSD
             MOV ECX,EDX
             AND ECX,3
             REP
             MOVSB
          END;
          WinEmptyClipBrd(AppHandle);
          WinSetClipBrdData(AppHandle,LONGWORD(PBuf),CF_TEXT,CFI_POINTER);
          WinCloseClipBrd(AppHandle);
          _SetClipBoardText := TRUE;
     END
     ELSE SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[3]);
END;



FUNCTION TEditorWindow._GetClipBoardText(VAR Len:LONGWORD):POINTER;
VAR  Clip : ^LONGWORD;
     P : ^LONGWORD;
     Leng : LONGWORD;
BEGIN
     _GetClipBoardText := NIL;
     IF WinOpenClipBrd(AppHandle) THEN
     BEGIN
          Clip := POINTER(WinQueryClipBrdData(AppHandle,CF_TEXT));
          IF Clip = NIL THEN
          BEGIN
               WinCloseClipBrd(AppHandle);
               exit;
          END;
          ASM
             CLD
             MOV ECX,0
             MOV ESI,$Clip
!gt:
             INC ECX
             LODSB
             CMP AL,0
             JNE !gt
             MOV $Leng,ECX
          END;
          IF Leng > 1 THEN
          BEGIN
               Len := Leng;
               Getmem(P,Len);
               Move(Clip^,P^,Len);
              _GetClipBoardText := P;
          END;
          WinCloseClipBrd(AppHandle);
     END
     ELSE SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[3]);
END;



FUNCTION TEditorWindow._CopyICBLinear(VAR Len:LONGWORD):POINTER;
VAR  ptline : PLine;
     LinearStart : ^LONGWORD;
     LinearPtr : ^LONGWORD;
     pstr : PSTRING;
     icbstr : STRING;
BEGIN
     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN
     BEGIN
          _CopyICBLinear := NIL;
          exit;
     END;
     IF WLactivated THEN _WriteWorkLine;
     IF ICB.FirstLine = ICB.LastLine THEN
     BEGIN
          Len := ICB.LastX-ICB.FirstX;
          IF Len > 0 THEN
          BEGIN
               inc(Len);         {#0}
               GetMem(LinearStart,Len);
               icbstr := _ReadString(ICB.FirstLine,ICB.FirstX,Len-1);
               icbstr := icbstr + #0;
               Move(icbstr[1],LinearStart^,Length(icbstr));
          END
          ELSE LinearStart := NIL;
     END
     ELSE
     BEGIN
          ptline := ICB.FirstLine;
          Len := Length(ptline^.zk^)-ICB.FirstX+1+2;     {first ICB line}
          ptline := ptline^.next;
          WHILE ptline <> ICB.LastLine DO
          BEGIN
               inc(Len,Length(ptline^.zk^)+2);
               ptline := ptline^.next;
          END;
          inc(Len,ICB.LastX-1);                          {last ICB line}
          inc(Len);        {#0}
          GetMem(LinearStart,Len);

          ptline := ICB.FirstLine;
          LinearPtr := LinearStart;
          {first ICB line}
          icbstr := _ReadString(ICB.FirstLine,ICB.FirstX,
                                Length(ICB.FirstLine^.zk^)-ICB.FirstX+1);
          icbstr := icbstr + #13#10;
          Move(icbstr[1],LinearPtr^,Length(icbstr));
          inc(LinearPtr,Length(icbstr));
          ptline := ptline^.next;
          WHILE ptline <> ICB.LastLine DO
          BEGIN
               pstr := ptline^.zk;
               ASM
                  CLD
                  MOV EDI,$LinearPtr
                  MOV ESI,$pstr
                  XOR ECX,ECX
                  MOV CL,[ESI+0]
                  INC ESI
                  MOV EDX,ECX
                  SHR ECX,2
                  REP
                  MOVSD
                  MOV ECX,EDX
                  AND ECX,3
                  REP
                  MOVSB
                  MOV AX,$0A0D
                  STOSW
                  MOV $LinearPtr,EDI
               END;
               ptline := ptline^.next;
          END;
          {last ICB line}
          icbstr := _ReadString(ICB.LastLine,1,ICB.LastX-1);
          icbstr := icbstr + #0;
          Move(icbstr[1],LinearPtr^,Length(icbstr));
     END;
     _CopyICBLinear := LinearStart;
END;



PROCEDURE TEditorWindow._PasteICBLinear(P:POINTER; Len:LONGWORD);
VAR  TabSize : LONGWORD;
     StrL : LONGWORD;
     laststr : STRING;
     str : STRING;
BEGIN
     ICB.FirstLine := ActLine;
     ICB.FirstX := FileCursorX;
     IF NOT WLactivated THEN _ReadWorkLine;
     IF FileCursorX <= Length(WorkLine^)
     THEN laststr := copy(WorkLine^,FileCursorX,Length(WorkLine^)-FileCursorX+1)
     ELSE laststr := '';
     WorkLine^[0] := chr(FileCursorX-1);

     {Copy the object varriables to access via assembler}
     TabSize := EditOptions DIV $1000000;
     IF TabSize = 0 THEN TabSize := 8;
     StrL := StringLength;
     str := '';

     WHILE Len > 0 DO
     BEGIN
          ASM
             CLD
             LEA EDI,$str
             MOV ESI,$P
             INC EDI
             XOR ECX,ECX
!pl1:
             CMPD $Len,0
             JE !pl6
             LODSB
             DECD $Len
             CMP AL,13
             JE !pl3
             CMP AL,10
             JE !pl4
             CMP AL,9
             JE !pl2
             CMP AL,0
             JE !pl6
             CMP AL,32
             JAE !pl5
             MOV AL,32
             JMP !pl5
!pl2:
             MOV EBX,ECX
             MOV EDX,$TabSize
             // insert spaces til to the next tab mark
!pl8:
             CMP EDX,EBX
             JA !pl7
             ADD EDX,$TabSize
             JMP !pl8
!pl7:
             SUB EDX,EBX
             // EDX = count of spaces
             ADD EBX,EDX
             CMP EBX,$StrL
             JAE !pl6
             MOV ECX,EDX
             MOV AL,32
             REP
             STOSB
             MOV ECX,EBX
             JMP !pl1
!pl3:
             CMPB [ESI],10
             JNE !pl6
             LODSB
             DECD $Len
             JMP !pl6
!pl4:
             CMPB [ESI],13
             JNE !pl6
             LODSB
             DECD $Len
             JMP !pl6
!pl5:
             STOSB
             INC ECX
             CMP ECX,$StrL
             JB !pl1
!pl6:
             MOV $P,ESI
             MOV $str,CL
          END;

          _WriteString(FileCursorX,str);
          GetMem(ActLine^.zk,Length(WorkLine^)+1);
          move(WorkLine^[0],ActLine^.zk^[0],Length(WorkLine^)+1);

          _InsertLine(ActLine);
          ActLine := ActLine^.next;
          FileCursorX := 1;
          WorkLine^ := '';
          WLactivated := TRUE;
     END;
     ActLine := ActLine^.prev;
     _DeleteLine(ActLine^.next);
     ICB.LastLine := ActLine;
     ICB.LastX := Length(ActLine^.zk^)+1;
     _ReadWorkLine;
     _WriteString(ICB.LastX,laststr);
     _WriteWorkLine;
     _ICBSetMark;
END;


{ +++ WORKLINE +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ }


FUNCTION TEditorWindow._ReadString(PL:PLine; CX, count:WORD):STRING;
VAR  L : BYTE;
     s : STRING;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     _ReadString := '';
     IF PL = NIL THEN exit;
     IF PL^.zk = NIL THEN exit;
     FillChar(s[1],StringLength,32);
     move(PL^.zk^[1],s[1],Length(PL^.zk^));
     s[0] := chr(StringLength);
     _ReadString := copy(s,CX,count);
END;



FUNCTION TEditorWindow._InsertString(CX:WORD; str:STRING):BOOLEAN;
{insert a string in the current line at position CX}
{Result FALSE if line will be to long and cut at end of line}
VAR  endline : WORD;
     Lstr : WORD;
     appstr : STRING;
BEGIN
     IF NOT WLactivated THEN _ReadWorkLine;
     _InsertString := TRUE;
     Lstr := Length(str);
     IF Lstr = 0 THEN exit;

     IF CX > Length(WorkLine^) THEN
     BEGIN
          IF Lstr + CX > StringLength THEN _InsertString := FALSE;
          WorkLine^[0] := chr(CX-1);
          WorkLine^ := WorkLine^ + str;
     END
     ELSE
     BEGIN
          IF Lstr + Length(WorkLine^) > StringLength THEN _InsertString:=FALSE;
          appstr := copy(WorkLine^,CX,Length(WorkLine^)-CX+1);
          WorkLine^[0] := chr(CX-1);
          WorkLine^ := WorkLine^ + str + appstr;
     END;
     IF Length(WorkLine^) > StringLength THEN WorkLine^[0] := chr(StringLength);
     Modified := TRUE;
END;



FUNCTION TEditorWindow._WriteString(CX:WORD; str:STRING):BOOLEAN;
{overwrite current line at position CX with STR}
{Result FALSE if line will be to long and cut at end of line}
VAR  newend : WORD;
BEGIN
     IF NOT WLactivated THEN _ReadWorkLine;
     _WriteString := TRUE;
     IF Length(str) = 0 THEN exit;

     IF CX+(Length(str)-1) > StringLength THEN
     BEGIN
          str[0] := chr(StringLength-CX+1);
          _WriteString := FALSE;
     END;

     move(str[1],Workline^[CX],Length(str));
     newend := CX + (Length(str)-1);
     IF Length(WorkLine^) < newend THEN WorkLine^[0] := chr(newend);
     Modified := TRUE;
END;



FUNCTION TEditorWindow._DeleteString(CX, anz:WORD):BOOLEAN;
{Delete ANZ characters at position CX in the current line}
BEGIN
     IF NOT WLactivated THEN _ReadWorkLine;
     IF anz = 0 THEN exit;
     IF CX > Length(WorkLine^) THEN exit;
     IF CX+anz > Length(WorkLine^) THEN anz := Length(WorkLine^)-CX+1;
     delete(WorkLine^,CX,anz);
     Modified := TRUE;
END;



FUNCTION TEditorWindow._InsertLine(PL:PLine):BOOLEAN;
{insert a line after PL}
VAR  ptline : PLine;
     newnextline : PLine;
BEGIN
     IF PL = NIL THEN newnextline := FirstLine
     ELSE newnextline := PL^.next;

     New(ptline);
     ptline^.color := CI_Normal;
     ptline^.zk := NIL;
     _Connect(ptline,newnextline);
     _Connect(PL,ptline);

     inc(CountLines);
     Modified := TRUE;
     _InsertLine := TRUE;
END;



FUNCTION TEditorWindow._DeleteLine(PL:PLine):BOOLEAN;
{Delete a line}
VAR  ptline : PLine;
     prevline : PLine;
     nextline : PLine;
BEGIN
     IF (CountLines = 1) OR (PL = NIL) THEN
     BEGIN
          _DeleteLine := FALSE;
          exit;
     END;
     IF PL^.zk <> NIL THEN FreeMem(PL^.zk,Length(PL^.zk^)+1);

     _Connect(PL^.prev,PL^.next);
     Dispose(PL);
     dec(CountLines);
     Modified := TRUE;
     _DeleteLine := TRUE;
END;



PROCEDURE TEditorWindow._Connect(PL1, PL2:PLine);
BEGIN
     IF PL1 <> NIL THEN PL1^.next := PL2
     ELSE FirstLine := PL2;
     IF PL2 <> NIL THEN PL2^.prev := PL1
     ELSE LastLine := PL1;
END;


{ +++ Undo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ }


FUNCTION TEditorWindow._CountLines(FirstL,LastL:PLine):LONGWORD;
VAR  lines : LONGWORD;
     TempL : PLine;
BEGIN
     lines := 1;
     TempL := FirstL;
     WHILE (TempL <> LastL) AND (TempL <> NIL) DO
     BEGIN
          TempL := TempL^.next;
          inc(lines);
     END;

     IF TempL <> NIL THEN  {FirstL <= LastL}
     BEGIN
          {Reset Color}
          TempL := FirstL;
          WHILE TempL <> LastL DO
          BEGIN
               TempL^.color := CI_Normal;
               TempL := TempL^.next;
          END;
          IF LastL <> NIL THEN LastL^.color := CI_Normal;
          _CountLines := lines;
     END
     ELSE _CountLines := 0;
END;



PROCEDURE TEditorWindow._StoreUndoCursor;
VAR  U : TUNDO;
BEGIN
     U.Event := 0;
     U.Modified := Modified;
     U.ICBFL := _PLine2Long(ICB.FirstLine);
     U.ICBFX := ICB.FirstX;
     U.ICBLL := _PLine2Long(ICB.LastLine);
     U.ICBLX := ICB.LastX;
     U.FCX := FileCursorX;
     U.FCY := FileCursorY;
     _CreateUndoEvent(U);
END;



FUNCTION TEditorWindow._CopyUndoLines(FirstL,LastL:PLine):LONGWORD;
VAR  U : TUNDO;
     FUL,LUL : PLine;
     ptline : PLine;
     ptnew : PLine;
     ptlast : PLine;
     cl : LONGWORD;
BEGIN
     IF Wlactivated THEN _WriteWorkLine;
     cl := 0;
     ptnew := NIL;
     ptline := FirstL;
     WHILE ptline <> LastL^.next DO
     BEGIN
           New(ptnew);
           IF cl = 0 THEN FUL := ptnew;
           GetMem(ptnew^.zk,Length(ptline^.zk^)+1);
           ptnew^.zk^ := ptline^.zk^;
           ptnew^.color := CI_Normal;
           IF cl > 0 THEN _Connect(ptlast,ptnew);
           ptline := ptline^.next;
           ptlast := ptnew;
           inc(cl);
     END;
     LUL := ptnew;

     U.Event := 1;
     U.Modified := Modified;
     U.ICBFL := _PLine2Long(ICB.FirstLine);
     U.ICBFX := ICB.FirstX;
     U.ICBLL := _PLine2Long(ICB.LastLine);
     U.ICBLX := ICB.LastX;
     U.FCX := FileCursorX;
     U.FCY := FileCursorY;
     U.FrameBegin := _PLine2Long(FirstL)-1;
     U.FrameEnd := _PLine2Long(LastL)+1;   {default: count of lines constant}
     U.FirstUndoLine := FUL;
     U.LastUndoLine := LUL;
     U.Lines := cl;
     _CreateUndoEvent(U);
     _CopyUndoLines := cl;
END;



FUNCTION TEditorWindow._MoveUndoLines(FirstL,LastL:PLine):LONGWORD;
VAR  U : TUNDO;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     U.Event := 1;
     U.Modified := Modified;
     U.ICBFL := _PLine2Long(ICB.FirstLine);
     U.ICBFX := ICB.FirstX;
     U.ICBLL := _PLine2Long(ICB.LastLine);
     U.ICBLX := ICB.LastX;
     U.FCX := FileCursorX;
     U.FCY := FileCursorY;

     U.Lines := _CountLines(FirstL,LastL);    {count lines for UNDO stack}
     IF U.Lines > 0 THEN
     BEGIN
          U.FrameBegin := _PLine2Long(FirstL)-1;
          U.FirstUndoLine := FirstL;
          U.LastUndoLine := LastL;
     END
     ELSE
     BEGIN
          U.FrameBegin := _PLine2Long(LastL);
          U.FirstUndoLine := NIL;
          U.LastUndoLine := NIL;
     END;
     _CreateUndoEvent(U);
     _MoveUndoLines := U.Lines;
END;



PROCEDURE TEditorWindow._CreateUndoEvent(U:TUNDO);
BEGIN
     LastUndo := (LastUndo+1) MOD MaxUndoEvents;
     IF UndoEvents < MaxUndoEvents THEN inc(UndoEvents);
     _DeleteUndoEvent(LastUndo);
     UndoEvent[LastUndo] := U;
     EnableUndo;
END;



PROCEDURE TEditorWindow._DeleteUndoEvent(Nr:WORD);
VAR  ptline : PLine;
     ptnext : PLine;
     i : LONGWORD;
BEGIN
     IF UndoEvent[Nr].Event = 0 THEN exit;
     UndoEvent[Nr].Event := 0;

     ptline := UndoEvent[Nr].FirstUndoLine;
     FOR i := 1 TO UndoEvent[Nr].Lines DO
     BEGIN
          IF ptline = NIL THEN exit;
          ptnext := ptline^.next;
          IF ptline^.zk <> NIL THEN FreeMem(ptline^.zk,Length(ptline^.zk^)+1);
          Dispose(ptline);
          ptline := ptnext;
     END;
END;



PROCEDURE TEditorWindow.Undo;
VAR  U,U2 : TUNDO;
     cl : LONGWORD;
     FL,LL : PLine;
     FFL,LFL : PLine;
     SRE : WORD;
LABEL l;
BEGIN
     IF WinReadOnly THEN exit;
     IF UndoEvents = 0 THEN
     BEGIN
          DisableUndo;
          exit;
     END;
     _ICBClearMark;
     U := UndoEvent[LastUndo];
     IF U.Event = 0 THEN
     BEGIN
           U2.Event := 0;
           U2.Modified := Modified;
           U2.ICBFL := _PLine2Long(ICB.FirstLine);
           U2.ICBFX := ICB.FirstX;
           U2.ICBLL := _PLine2Long(ICB.LastLine);
           U2.ICBLX := ICB.LastX;
           U2.FCX := FileCursorX;
           U2.FCY := FileCursorY;
          _CreateRedoEvent(U2);
          goto l; {only cursor event}
     END;

     {save into redo stack}
     FL := _Long2PLine(U.FrameBegin+1);
     IF U.FrameEnd = 0 THEN LL := LastLine
     ELSE LL := _Long2PLine(U.FrameEnd-1);
     cl := _MoveRedoLines(FL,LL);
     FFL := FL^.prev;
     IF LL <> NIL THEN LFL := LL^.next
     ELSE LFL := FirstLine;

     IF U.Lines > 0 THEN
     BEGIN
          _Connect(FFL,U.FirstUndoLine);
          _Connect(U.LastUndoLine,LFL);
     END
     ELSE _Connect(FFL,LFL);
     SetLineColorFlag(FFL,LFL);

     RedoEvent[LastRedo].FrameEnd := _PLine2Long(LFL);
     UndoEvent[LastUndo].Event := 0;

     inc(CountLines,U.Lines);
     dec(CountLines,cl);
l:
     LastUndo := (LastUndo+MaxUndoEvents-1) MOD MaxUndoEvents;
     dec(UndoEvents);
     IF UndoEvents = 0 THEN DisableUndo;
     ICB.FirstLine := _Long2PLine(U.ICBFL);
     ICB.FirstX := U.ICBFX;
     ICB.LastLine := _Long2PLine(U.ICBLL);
     ICB.LastX := U.ICBLX;
     _ICBSetMark;
     Modified := U.Modified;
     SRE := RedoEvents;
     LastUndoGroup := UG_CursorMove; {for gotoline}
     GotoLine(U.FCY,U.FCX);
     RedoEvents := SRE;
     IF RedoEvents > 0 THEN EnableRedo;
     LastUndoGroup := UG_NoGroup;
END;



FUNCTION TEditorWindow._MoveRedoLines(FirstL,LastL:PLine):LONGWORD;
VAR  U : TUNDO;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     U.Event := 1;
     U.Modified := Modified;
     U.ICBFL := _PLine2Long(ICB.FirstLine);
     U.ICBFX := ICB.FirstX;
     U.ICBLL := _PLine2Long(ICB.LastLine);
     U.ICBLX := ICB.LastX;
     U.FCX := FileCursorX;
     U.FCY := FileCursorY;

     U.Lines := _CountLines(FirstL,LastL);
     IF U.Lines > 0 THEN
     BEGIN
          U.FrameBegin := _PLine2Long(FirstL)-1;
          U.FirstUndoLine := FirstL;
          U.LastUndoLine := LastL;
     END
     ELSE
     BEGIN
          U.FrameBegin := _PLine2Long(LastL);
          U.FirstUndoLine := NIL;
          U.LastUndoLine := NIL;
     END;
     _CreateRedoEvent(U);
     _MoveRedoLines := U.Lines;
END;



PROCEDURE TEditorWindow._CreateRedoEvent(U:TUNDO);
BEGIN
     LastRedo := (LastRedo+1) MOD MaxRedoEvents;
     IF RedoEvents < MaxRedoEvents THEN inc(RedoEvents);
     _DeleteRedoEvent(LastRedo);
     RedoEvent[LastRedo] := U;
END;



PROCEDURE TEditorWindow._DeleteRedoEvent(Nr:WORD);
VAR  ptline : PLine;
     ptnext : PLine;
     i : LONGWORD;
BEGIN
     IF RedoEvent[Nr].Event = 0 THEN exit;
     RedoEvent[Nr].Event := 0;

     ptline := RedoEvent[Nr].FirstUndoLine;
     FOR i := 1 TO RedoEvent[Nr].Lines DO
     BEGIN
          IF ptline = NIL THEN exit;
          ptnext := ptline^.next;
          IF ptline^.zk <> NIL THEN FreeMem(ptline^.zk,Length(ptline^.zk^)+1);
          Dispose(ptline);
          ptline := ptnext;
     END;
END;



PROCEDURE TEditorWindow.Redo;
VAR  U,U2 : TUNDO;
     cl : LONGWORD;
     FL,LL : PLine;
     FFL,LFL : PLine;
     SRE : WORD;
LABEL l;
BEGIN
     IF WinReadOnly THEN exit;
     IF RedoEvents = 0 THEN
     BEGIN
          DisableRedo;
          exit;
     END;
     _ICBClearMark;
     U := RedoEvent[LastRedo];
     IF U.Event = 0 THEN
     BEGIN
           U2.Event := 0;
           U2.Modified := Modified;
           U2.ICBFL := _PLine2Long(ICB.FirstLine);
           U2.ICBFX := ICB.FirstX;
           U2.ICBLL := _PLine2Long(ICB.LastLine);
           U2.ICBLX := ICB.LastX;
           U2.FCX := FileCursorX;
           U2.FCY := FileCursorY;
          _CreateUndoEvent(U2);
          goto l; {only cursor event}
     END;

     {save into undo stack}
     FL := _Long2PLine(U.FrameBegin+1);
     IF U.FrameEnd = 0 THEN LL := LastLine
     ELSE LL := _Long2PLine(U.FrameEnd-1);
     cl := _MoveUndoLines(FL,LL);
     FFL := FL^.prev;
     IF LL <> NIL THEN LFL := LL^.next
     ELSE LFL := FirstLine;

     IF U.Lines > 0 THEN
     BEGIN
          _Connect(FFL,U.FirstUndoLine);
          _Connect(U.LastUndoLine,LFL);
     END
     ELSE _Connect(FFL,LFL);
     SetLineColorFlag(FFL,LFL);

     UndoEvent[LastUndo].FrameEnd := _PLine2Long(LFL);
     RedoEvent[LastRedo].Event := 0;

     inc(CountLines,U.Lines);
     dec(CountLines,cl);
l:
     LastRedo := (LastRedo+MaxRedoEvents-1) MOD MaxRedoEvents;
     dec(RedoEvents);
     IF RedoEvents = 0 THEN DisableRedo;
     ICB.FirstLine := _Long2PLine(U.ICBFL);
     ICB.FirstX := U.ICBFX;
     ICB.LastLine := _Long2PLine(U.ICBLL);
     ICB.LastX := U.ICBLX;
     _ICBSetMark;
     Modified := U.Modified;
     SRE := RedoEvents;
     LastUndoGroup := UG_CursorMove; {for gotoline}
     GotoLine(U.FCY,U.FCX);
     RedoEvents := SRE;
     IF UndoEvents > 0 THEN EnableUndo;
     LastUndoGroup := UG_NoGroup;
END;


{ +++ Block-Manipulating +++++++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow.ICBSetBegin; {Crtl-K B}
VAR  ptline : PLine;
     L : WORD;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     IF ICB.LastLine <> NIL THEN
     BEGIN
          _ICBClearMark;

          ptline := ICB.LastLine;
          WHILE (ptline <> NIL) AND (ActLine <> ptline) DO
               ptline := ptline^.prev;
          IF (ActLine = ICB.LastLine) AND (FileCursorX >= ICB.LastX)
          THEN ptline := NIL;

          IF ptline = NIL THEN ICB.LastLine := NIL;
     END;

     {set new the begin mark}
     ICB.FirstLine := ActLine;
     L := Length(ActLine^.zk^);
     IF L < FileCursorX THEN ICB.FirstX := L+1
     ELSE ICB.FirstX := FileCursorX;
     _ICBSetMark;
     InvalidateEditorWindow(1);
END;



PROCEDURE TEditorWindow.ICBSetEnd;
VAR  ptline : PLine;
     L : WORD;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     IF ICB.FirstLine <> NIL THEN
     BEGIN
          _ICBClearMark;

          ptline := ICB.FirstLine;
          WHILE (ptline <> NIL) AND (ActLine <> ptline) DO
               ptline := ptline^.next;
          IF (ActLine = ICB.FirstLine) AND (FileCursorX <= ICB.FirstX)
          THEN ptline := NIL;

          IF ptline = NIL THEN ICB.FirstLine := NIL;
     END;

     {set new the end mark}
     ICB.LastLine := ActLine;
     L := Length(ActLine^.zk^);
     IF L < FileCursorX THEN ICB.LastX := L+1
     ELSE ICB.LastX := FileCursorX;
     _ICBSetMark;
     InvalidateEditorWindow(1);
END;



PROCEDURE TEditorWindow.ICBSelectWord;
VAR  FCX : WORD;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     FCX := FileCursorX;
     IF FileCursorX > Length(ActLine^.zk^) THEN
     BEGIN
          CursorEnd;
          IF FileCursorX = 1 THEN exit;
          FCX := FileCursorX-1;
     END;
     _ICBClearMark;

     WHILE (ActLine^.zk^[FCX-1] IN NormalChars) AND (FCX > 1) DO dec(FCX);
     ICB.FirstLine := ActLine;
     ICB.FirstX := FCX;

     WHILE (ActLine^.zk^[FCX] IN NormalChars) AND (FCX < StringLength) DO inc(FCX);
     ICB.LastLine := ActLine;
     ICB.LastX := FCX;

     _ICBSetMark;
     InvalidateEditorWindow(1);
END;



PROCEDURE TEditorWindow.ICBSelectLine;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     _ICBClearMark;
     ICB.FirstLine := ActLine;
     ICB.FirstX := 1;
     IF ActLine^.next <> NIL THEN
     BEGIN
          ICB.LastLine := ActLine^.next;
          ICB.LastX := 1;
     END
     ELSE
     BEGIN
          ICB.LastLine := ActLine;
          ICB.LastX := Length(ActLine^.zk^)+1;
     END;
     _ICBSetMark;
     InvalidateEditorWindow(1);
END;



PROCEDURE TEditorWindow.ICBSelectAll;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     ICB.FirstLine := FirstLine;
     ICB.FirstX := 1;
     ICB.LastLine := LastLine;
     ICB.LastX := Length(LastLine^.zk^)+1;
     _ICBSetMark;
     InvalidateEditorWindow(1);
END;



PROCEDURE TEditorWindow.ICBDeselectAll;
BEGIN
     _ICBClearMark;
     ICB.FirstLine := NIL;
     ICB.LastLine := NIL;
     InvalidateEditorWindow(1);
END;



PROCEDURE TEditorWindow.ICBGotoBegin;
VAR  cy : LONGWORD;
BEGIN
     (*gotoline set the UNDO*)
     IF ICB.FirstLine = NIL THEN exit;
     cy := _PLine2Long(ICB.FirstLine);
     IF cy <> 0 THEN GotoLine(cy,ICB.FirstX);
END;



PROCEDURE TEditorWindow.ICBGotoEnd;
VAR  cy : LONGWORD;
BEGIN
     (*gotoline set the UNDO*)
     IF ICB.LastLine = NIL THEN exit;
     cy := _PLine2Long(ICB.LastLine);
     IF cy <> 0 THEN GotoLine(cy,ICB.LastX);
END;



PROCEDURE TEditorWindow.ICBCopyBlock;
VAR  laststr : STRING;
     icbstr : STRING;
     CurX : WORD;
     CurLine : PLine;
     ptline : PLine;
     Actnext : PLine;
     ptlnext : PLine;
     insanchor : PLine;
     first : BOOLEAN;
BEGIN
     IF NOT ICBVisible THEN
     BEGIN
          ToggleICBVisibility;
          exit;
     END;
     IF WinReadOnly THEN exit;
     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN exit;
     (*UNDO*)
     _CopyUndoLines(ActLine,ActLine);
     (*UNDO*)
     _ICBClearMark;
     CurLine := ActLine;
     CurX := FileCursorX;
     IF WLactivated THEN _WriteWorkLine;
     IF ICB.FirstLine = ICB.LastLine THEN
     BEGIN
          icbstr := _ReadString(ICB.FirstLine,ICB.FirstX,ICB.LastX-ICB.FirstX);
          _ReadWorkLine;
          IF NOT _InsertString(CurX,icbstr) THEN beep(1000,10);
          ICB.LastLine := CurLine;
          ICB.LastX := CurX+(ICB.LastX-ICB.FirstX);
          _CheckICB;
          _WriteWorkLine;
     END
     ELSE
     BEGIN
          ptline := ICB.FirstLine;
          icbstr := _ReadString(ptline,ICB.FirstX,
                                Length(ptline^.zk^)-ICB.FirstX+1);
          laststr := _ReadString(CurLine,CurX,Length(ActLine^.zk^)-CurX+1);

          first := TRUE;
          Actnext := ActLine^.next;
          ptlnext := ptline^.next;
          REPEAT
                _InsertLine(ActLine);
                ptline := ptline^.next;
                ActLine := ActLine^.next;
                IF first THEN
                BEGIN
                     insanchor := Actline;
                     CurLine^.next := Actnext;
                     ptline := ptlnext;
                     first := FALSE;
                END;
                WorkLine^ := _ReadString(ptline,1,Length(ptline^.zk^));
                _WriteWorkLine;
                Actline^.color := ptline^.color;
          UNTIL ptline = ICB.LastLine;

          _ReadWorkLine;
          WorkLine^[0] := chr(ICB.LastX-1);
          _WriteString(Length(WorkLine^)+1,laststr);
          _WriteWorkLine;
          _Connect(CurLine,insanchor);
          ICB.LastLine := ActLine;

          ActLine := CurLine;
          _ReadWorkLine;
          WorkLine^[0] := chr(CurX-1);
          _WriteString(CurX,icbstr);
          _WriteWorkLine;
          SetSliderValues;
     END;

     ICB.FirstLine := CurLine;
     ICB.FirstX := CurX;
     _ICBSetMark;
     LastUndoGroup := UG_CursorMove;
     SetLineColorFlag(ICB.FirstLine,ICB.LastLine);
     ICBGotoBegin;
     (*UNDO*)
     UndoEvent[LastUndo].FrameEnd := _PLine2Long(ICB.LastLine^.next);
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.ICBMoveBlock;
VAR  art : BYTE;
     CurX : WORD;
     CurLine : PLine;
     laststr : STRING;
     icbstr : STRING;
     B, icb1 : STRING;
     Licb : WORD;
     CurLinenext : PLine;
     ICBFirstLnext : PLine;
     ICBLastLnext : PLine;
     FL,LL : PLine;
     AL,IFL,ILL : LONGWORD;
BEGIN
     IF NOT ICBVisible THEN
     BEGIN
          ToggleICBVisibility;
          exit;
     END;
     IF WinReadOnly THEN exit;
     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN exit;

     IF ActLine^.color AND CI_Selected <> 0 THEN
     BEGIN
          art := 0; {CurPos is within the ICB}
          IF (ActLine = ICB.FirstLine) AND (FileCursorX < ICB.FirstX)
          THEN art := 1; {CurPos in ICB firstline, before ICBFirstX}
          IF (ActLine = ICB.LastLine) AND (FileCursorX > ICB.LastX)
          THEN art := 2; {CurPos in ICB endline, after ICBLastX}
     END
     ELSE art := 3; {CurPos not within the ICB lines}

     IF art = 0 THEN exit;
     (*UNDO*)
     AL := _PLine2Long(ActLine);
     IFL := _PLine2Long(ICB.FirstLine);
     ILL := _PLine2Long(ICB.LastLine);
     IF AL < IFL THEN FL := ActLine
     ELSE FL := ICB.FirstLine;
     IF AL > ILL THEN LL := ActLine
     ELSE LL := ICB.LastLine;
     _CopyUndoLines(FL,LL);
     (*UNDO*)

     IF WLactivated THEN _WriteWorkLine;
     CurLine := ActLine;
     CurX := FileCursorX;
     CASE art OF
          1 :
          BEGIN
               laststr := _ReadString(ICB.FirstLine,CurX,ICB.FirstX-CurX);
               _DeleteString(CurX,Length(laststr));
               _WriteWorkLine;
               ActLine := ICB.LastLine;
               IF ICB.FirstLine = ICB.LastLine
               THEN ICB.LastX := ICB.LastX - Length(laststr);
               IF NOT _InsertString(ICB.LastX,laststr) THEN beep(1000,10);
               _WriteWorkLine;
               ICB.FirstX := CurX;
          END;
          2 :
          BEGIN
               laststr := _ReadString(ICB.LastLine,ICB.LastX,CurX-ICB.LastX);
               _DeleteString(ICB.LastX,Length(laststr));
               _WriteWorkLine;
               ActLine := ICB.FirstLine;
               IF NOT _InsertString(ICB.FirstX,laststr) THEN beep(1000,10);
               _WriteWorkLine;
               IF ICB.FirstLine = ICB.LastLine
               THEN ICB.LastX := ICB.LastX + Length(laststr);
               ICB.FirstX := ICB.FirstX + Length(laststr);
          END;
          3 :
          BEGIN
               IF ICB.FirstLine = ICB.LastLine THEN
               BEGIN
                    Licb := ICB.LastX-ICB.FirstX;
                    icbstr := _ReadString(ICB.FirstLine,ICB.FirstX,Licb);
                    IF NOT _InsertString(CurX,icbstr) THEN beep(1000,10);
                    _ICBClearMark;
                    _WriteWorkLine;
                    ActLine := ICB.FirstLine;
                    _DeleteString(ICB.FirstX,Licb);
                    _WriteWorkLine;
                    ICB.FirstLine := CurLine;
                    ICB.FirstX := CurX;
                    ICB.LastLine := CurLine;
                    ICB.LastX := CurX + Licb;
                    _ICBSetMark;
               END
               ELSE
               BEGIN
                    laststr := _ReadString(CurLine,CurX,
                                           Length(CurLine^.zk^)-CurX+1);
                    B := _ReadString(ICB.LastLine,ICB.LastX,
                                     Length(ICB.LastLine^.zk^)-ICB.LastX+1);
                    icb1 := _ReadString(ICB.FirstLine,ICB.FirstX,
                                 Length(ICB.FirstLine^.zk^)-ICB.FirstX+1);
                    _ReadWorkLine;
                    WorkLine^[0] := chr(CurX-1);
                    _WriteString(CurX,icb1);
                    _WriteWorkLine;
                     Actline^.color := Actline^.color OR CI_Selected;

                    ActLine := ICB.FirstLine;
                    _ReadWorkLine;
                    WorkLine^[0] := chr(ICB.FirstX-1);
                    _WriteString(ICB.FirstX,B);
                    _WriteWorkLine;
                    Actline^.color := Actline^.color AND NOT CI_Selected;

                    ActLine := ICB.LastLine;
                    _ReadWorkLine;
                    WorkLine^[0] := chr(ICB.LastX-1);
                    _WriteString(ICB.LastX,laststr);
                    _WriteWorkLine;

                    CurLinenext := CurLine^.next;
                    ICBFirstLnext := ICB.FirstLine^.next;
                    ICBLastLnext := ICB.LastLine^.next;
                    _Connect(CurLine,ICBFirstLnext);
                    _Connect(ICB.LastLine,CurLinenext);
                    _Connect(ICB.FirstLine,ICBLastLnext);
                    IF CurLinenext = NIL THEN LastLine := ICB.LastLine;

                    ICB.FirstLine := CurLine;
                    ICB.FirstX := CurX;
                    {solid reference point for ICBGotoBegin}
                    FileCursorY := 1;
                    ScrCursorY := 1;
                    ActLine := FirstLine;
                    FirstScreenLine := FirstLine;
               END;
          END;
     END;
     _CheckICB;

     IF AL < IFL THEN FL := _Long2PLine(AL)
     ELSE FL := _Long2PLine(IFL);
     IF AL > ILL THEN LL := _Long2PLine(AL)
     ELSE LL := _Long2PLine(ILL);
     SetLineColorFlag(FL,LL);

     LastUndoGroup := UG_CursorMove;
     ICBGotoBegin;
     (*UNDO*)
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.ICBDeleteBlock;
VAR  FrameFirst : PLine;
     FrameLast  : PLine;
     firststring : STRING;
     laststring : STRING;
     cl : LONGWORD;
BEGIN
     IF NOT ICBVisible THEN
     BEGIN
          ToggleICBVisibility;
          exit;
     END;
     IF WinReadOnly THEN exit;
     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN exit;

     IgnoreRedraw := TRUE;
     ICBGotoBegin;

     firststring := _ReadString(ICB.FirstLine,1,ICB.FirstX-1);
     laststring := _ReadString(ICB.LastLine,ICB.LastX,
                               Length(ICB.LastLine^.zk^)-ICB.LastX+1);

     FrameFirst := ICB.FirstLine^.prev;
     FrameLast := ICB.LastLine^.next;
     (*UNDO*)
     cl := _MoveUndoLines(ICB.FirstLine,ICB.LastLine);
     (*UNDO*)
     _Connect(FrameFirst,FrameLast);
     dec(countlines,cl);
     Modified := TRUE;

     _InsertLine(FrameFirst);
     IF FrameFirst = NIL THEN ActLine := FirstLine
     ELSE ActLine := FrameFirst^.next;
     IF ScrCursorY = 1 THEN FirstScreenLine := ActLine;
     WorkLine^ := firststring + laststring;
     _WriteWorkLine;

     ICB.FirstLine := ActLine;
     ICB.FirstX := FileCursorX;
     ICB.LastLine := ActLine;
     ICB.LastX := FileCursorX;
     _ICBSetMark;     {includes _CheckICB and mark the line}

     IgnoreRedraw := FALSE;
     SetSliderValues;
     IF FrameFirst <> NIL THEN SetLineColorFlag(FrameFirst,Actline)
     ELSE UpdateLineColorFlag(ActLine);
     InvalidateEditorWindow(1);
     (*UNDO*)
     UndoEvent[LastUndo].FrameEnd := _PLine2Long(FrameLast);
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.ICBReadBlock;
VAR  s : STRING;
     dir,name,ext : STRING;
     F : FILE;
BEGIN
     FileOpenDlgWildCards := '';
     FileOpenDlgTitle := NLSTable[4];
     FileOpenDlgOkname := NLSTable[27];
     IF FileOpenDialog(Application^.MainWindow^.HWindow,s) THEN
     BEGIN
          WinUpdateWindow(Application^.MainWindow^.HWindow);
          {Cut long filenames}
          FSplit(s,dir,name,ext);
          s := dir + name + ext;
          Assign(F,s);
          FileMode := fmInput;
          {$i-}
          Reset(F,1);
          {$i+}
          FileMode := fmInOut;
          IF IOResult <> 0 THEN
          BEGIN
               s := NLSTable[12] + name + ext + NLSTable[29];
               SetErrorMessage(MB_ICONHAND,NLSTable[1], s);
          END
          ELSE
          BEGIN
               {$i-}
               Close(F);
               {$i+}
               PasteFromFile(s);
          END;
     END;
     FileOpenDlgTitle := NLSTable[5];
END;



PROCEDURE TEditorWindow.ICBWriteBlock;
VAR  s : STRING;
     P : POINTER;
     Len : LONGWORD;
     utF : FILE;
     dir,name,ext : STRING;
BEGIN
     FileSaveDlgWildCards := '';
     FileSaveDlgTitle := NLSTable[6];
     FileSaveDlgOkname := NLSTable[28];
     IF FileSaveDialog(Application^.MainWindow^.HWindow,s) THEN
     BEGIN
          WinUpdateWindow(Application^.MainWindow^.HWindow);
          {Cut long filenames}
          FSplit(s,dir,name,ext);
          s := dir + name + ext;
          FileSaveDlgTitle := NLSTable[7];
          P := _CopyICBLinear(Len);
          IF P = NIL THEN exit;       {Length=0}
          Assign(utF,s);
          {$i-}
          Rewrite(utF,1);
          {$i+}
          IF IoResult = 0 THEN
          BEGIN
               {$i-}
               BlockWrite(utF,P^,Len-1);     {without #0}
               {$i+}
               IF Ioresult <> 0
               THEN SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[8]+s);
               {$i-}
               Close(utF);
               {$i+}
          END
          ELSE SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[8]+s);
          FreeMem(P,Len);
     END;
     FileSaveDlgTitle := NLSTable[7];
END;



PROCEDURE TEditorWindow.ICBMoveLeft;
BEGIN
     IF NOT ICBVisible THEN exit;
     IF WinReadOnly THEN exit;
     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN exit;
     IF WLactivated THEN _WriteWorkLine;
     (*UNDO*)
     _CopyUndoLines(ICB.FirstLine,ICB.LastLine);
     (*UNDO*)
     IF Length(ICB.FirstLine^.zk^) > 0 THEN
       IF (ICB.FirstLine^.zk^[1] = #32) AND (ICB.FirstX > 1)
       THEN dec(ICB.FirstX);

     ActLine := ICB.FirstLine;
     WHILE ActLine <> ICB.LastLine DO
     BEGIN
          IF Length(ActLine^.zk^) > 0 THEN
            IF ActLine^.zk^[1] = #32 THEN
            BEGIN
                 _ReadWorkLine;
                 _DeleteString(1,1);
                 _WriteWorkLine;
            END;
          ActLine := ActLine^.next;
     END;
     IF (Length(ICB.LastLine^.zk^) > 0) AND (ICB.LastX > 1) THEN
       IF ICB.LastLine^.zk^[1] = #32 THEN
       BEGIN
            _ReadWorkLine;
            _DeleteString(1,1);
            _WriteWorkLine;
            dec(ICB.LastX);
       END;
     LastUndoGroup := UG_CursorMove;
     ICBGotoBegin;
     (*UNDO*)
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.ICBMoveRight;
BEGIN
     IF NOT ICBVisible THEN exit;
     IF WinReadOnly THEN exit;
     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN exit;
     IF WLactivated THEN _WriteWorkLine;
     (*UNDO*)
     _CopyUndoLines(ICB.FirstLine,ICB.LastLine);
     (*UNDO*)

     ActLine := ICB.FirstLine;
     WHILE ActLine <> ICB.LastLine DO
     BEGIN
          IF Length(ActLine^.zk^) < StringLength THEN
          BEGIN
               _ReadWorkLine;
               _InsertString(1,' ');
               _WriteWorkLine;
          END;
          ActLine := ActLine^.next;
     END;
     IF (Length(ICB.LastLine^.zk^) < StringLength) AND (ICB.LastX > 1) THEN
     BEGIN
          _ReadWorkLine;
          _InsertString(1,' ');
          _WriteWorkLine;
          IF ICB.LastX < StringLength THEN inc(ICB.LastX);
     END;
     LastUndoGroup := UG_CursorMove;
     ICBGotoBegin;
     (*UNDO*)
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow._ICBExtSetICB;
VAR  FCX : WORD;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     ChangeICB := FALSE;

     IF FileCursorX <= Length(ActLine^.zk^) THEN FCX := FileCursorX
     ELSE FCX := Length(ActLine^.zk^)+1;
     IF FCX > StringLength THEN FCX := StringLength;

     _ICBClearMark;
     IF NOT ICBVisible THEN ICB.FirstLine := NIL; {force to create new ICB}

     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN
     BEGIN
          ICB.FirstLine := ActLine;
          ICB.FirstX := FCX;
          ICB.LastLine := ActLine;
          ICB.LastX := FCX;
          exit;
     END;

     IF ((ICB.FirstLine = ActLine) AND (ICB.FirstX = FCX)) OR
        ((ICB.LastLine = ActLine) AND (ICB.LastX = FCX)) THEN exit;

     ICB.FirstLine := ActLine;
     ICB.FirstX := FCX;
     ICB.LastLine := ActLine;
     ICB.LastX := FCX;
     InvalidateEditorWindow(1);
     ChangeICB := TRUE;
END;



PROCEDURE TEditorWindow._ICBExtCorrectICB;
VAR  ptline : PLine;
     FL : PLine;
     FX : WORD;
BEGIN
     ptline := ICB.FirstLine;

     IF (ICB.FirstLine = ICB.LastLine) AND (ICB.FirstX > ICB.LastX)
     THEN ptline := NIL;

     WHILE (ptline <> ICB.LastLine) AND (ptline <> NIL) DO
          ptline := ptline^.next;

     IF ptline <> NIL THEN exit;

     {exchange first & last}
     FL := ICB.FirstLine;
     FX := ICB.FirstX;
     ICB.FirstLine := ICB.LastLine;
     ICB.FirstX := ICB.LastX;
     ICB.LastLine := FL;
     ICB.LastX := FX;
END;



PROCEDURE TEditorWindow.ICBExtLeft;
LABEL l;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     _ICBExtSetICB;
     IF FileCursorX > Length(ActLine^.zk^)+1 THEN goto l;

     IF (ICB.FirstLine = ActLine) AND (ICB.FirstX = FileCursorX) THEN
     BEGIN
          IF ICB.FirstX > 1 THEN dec(ICB.FirstX);
          goto l;
     END;

     IF (ICB.LastLine = ActLine) AND (ICB.LastX = FileCursorX) THEN
     BEGIN
          IF ICB.LastX > 1 THEN dec(ICB.LastX);
     END;
l:
     _ICBSetMark;
     CursorLeft;
     InvalidateSingleLine;
END;



PROCEDURE TEditorWindow.ICBExtRight;
LABEL l;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     _ICBExtSetICB;
     IF FileCursorX > Length(ActLine^.zk^)+1 THEN goto l;

     IF (ICB.LastLine = ActLine) AND (ICB.LastX = FileCursorX) THEN
     BEGIN
          IF ICB.LastX <= Length(ActLine^.zk^) THEN inc(ICB.LastX);
          goto l;
     END;

     IF (ICB.FirstLine = ActLine) AND (ICB.FirstX = FileCursorX) THEN
     BEGIN
          IF ICB.FirstX <= Length(ActLine^.zk^) THEN inc(ICB.FirstX);
     END;
l:
     _ICBSetMark;
     CursorRight;
     InvalidateSingleLine;
END;



PROCEDURE TEditorWindow.ICBExtUp;
VAR  FCX : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     _ICBExtSetICB;
     IF FileCursorX <= Length(ActLine^.zk^) THEN FCX := FileCursorX
     ELSE FCX := Length(ActLine^.zk^)+1;
     IF FCX > StringLength THEN FCX := StringLength;

     IF (ICB.FirstLine = ActLine) AND (ICB.FirstX = FCX) THEN
     BEGIN
          IF ICB.FirstLine^.prev <> NIL THEN
          BEGIN
               ICB.FirstLine := ICB.FirstLine^.prev;
               IF FileCursorX <= Length(ICB.FirstLine^.zk^)
               THEN ICB.FirstX := FileCursorX
               ELSE ICB.FirstX := Length(ICB.FirstLine^.zk^)+1;
          END;
     END
     ELSE
     BEGIN
          IF ICB.LastLine^.prev <> NIL THEN
          BEGIN
               ICB.LastLine := ICB.LastLine^.prev;
               IF FileCursorX <= Length(ICB.LastLine^.zk^)
               THEN ICB.LastX := FileCursorX
               ELSE ICB.LastX := Length(ICB.LastLine^.zk^)+1;
          END;
     END;

     _ICBExtCorrectICB;
     _ICBSetMark;
     InvalidateSingleLine;
     CursorUp(1);
     InvalidateSingleLine;
END;



PROCEDURE TEditorWindow.ICBExtDown;
VAR  FCX : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     _ICBExtSetICB;
     IF FileCursorX <= Length(ActLine^.zk^) THEN FCX := FileCursorX
     ELSE FCX := Length(ActLine^.zk^)+1;
     IF FCX > StringLength THEN FCX := StringLength;

     IF (ICB.LastLine = ActLine) AND (ICB.LastX = FCX) THEN
     BEGIN
          IF ICB.LastLine^.next <> NIL THEN
          BEGIN
               ICB.LastLine := ICB.LastLine^.next;
               IF FileCursorX <= Length(ICB.LastLine^.zk^)
               THEN ICB.LastX := FileCursorX
               ELSE ICB.LastX := Length(ICB.LastLine^.zk^)+1;
          END;
     END
     ELSE
     BEGIN
          IF ICB.FirstLine^.next <> NIL THEN
          BEGIN
               ICB.FirstLine := ICB.FirstLine^.next;
               IF FileCursorX <= Length(ICB.FirstLine^.zk^)
               THEN ICB.FirstX := FileCursorX
               ELSE ICB.FirstX := Length(ICB.FirstLine^.zk^)+1;
          END;
     END;

     _ICBExtCorrectICB;
     _ICBSetMark;
     InvalidateSingleLine;
     CursorDown(1);
     InvalidateSingleLine;
END;



PROCEDURE TEditorWindow.ICBExtPageUp;
VAR  OldLine : PLine;
     OldX : WORD;
     FCX : WORD;
     i : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     IgnoreRedraw := TRUE;
     _ICBExtSetICB;
     IF FileCursorX <= Length(ActLine^.zk^) THEN OldX := FileCursorX
     ELSE OldX := Length(ActLine^.zk^)+1;
     IF OldX > StringLength THEN OldX := StringLength;
     OldLine := ActLine;

     PageUp;
     IgnoreRedraw := FALSE;

     IF (OldLine = ICB.FirstLine) AND (OldX = ICB.FirstX) THEN
     BEGIN
          ICB.FirstLine := ActLine;
          IF FileCursorX <= Length(ActLine^.zk^)
          THEN ICB.FirstX := FileCursorX
          ELSE ICB.FirstX := Length(ActLine^.zk^)+1;
     END
     ELSE
     BEGIN
          ICB.LastLine := ActLine;
          IF FileCursorX <= Length(ActLine^.zk^)
          THEN ICB.LastX := FileCursorX
          ELSE ICB.LastX := Length(ActLine^.zk^)+1;
     END;

     _ICBExtCorrectICB;
     _ICBSetMark;
     InvalidateEditorWindow(1);
END;



PROCEDURE TEditorWindow.ICBExtPageDown;
VAR  OldLine : PLine;
     OldX : WORD;
     FCX : WORD;
     i : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     IgnoreRedraw := TRUE;
     _ICBExtSetICB;
     IF FileCursorX <= Length(ActLine^.zk^) THEN OldX := FileCursorX
     ELSE OldX := Length(ActLine^.zk^)+1;
     IF OldX > StringLength THEN OldX := StringLength;
     OldLine := ActLine;

     PageDown;
     IgnoreRedraw := FALSE;

     IF (OldLine = ICB.FirstLine) AND (OldX = ICB.FirstX) THEN
     BEGIN
          ICB.FirstLine := ActLine;
          IF FileCursorX <= Length(ActLine^.zk^)
          THEN ICB.FirstX := FileCursorX
          ELSE ICB.FirstX := Length(ActLine^.zk^)+1;
     END
     ELSE
     BEGIN
          ICB.LastLine := ActLine;
          IF FileCursorX <= Length(ActLine^.zk^)
          THEN ICB.LastX := FileCursorX
          ELSE ICB.LastX := Length(ActLine^.zk^)+1;
     END;

     _ICBExtCorrectICB;
     _ICBSetMark;
     InvalidateEditorWindow(1);
END;



PROCEDURE TEditorWindow.ICBExtPos1;
VAR  FCX : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     _ICBExtSetICB;
     IF FileCursorX <= Length(ActLine^.zk^) THEN FCX := FileCursorX
     ELSE FCX := Length(ActLine^.zk^)+1;
     IF FCX > StringLength THEN FCX := StringLength;

     IF (ICB.FirstLine = ActLine) AND (ICB.FirstX = FCX)
     THEN ICB.FirstX := 1
     ELSE ICB.LastX := 1;

     _ICBExtCorrectICB;
     _ICBSetMark;
     CursorPos1;
     InvalidateSingleLine;
END;



PROCEDURE TEditorWindow.ICBExtEnd;
VAR  FCX : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     _ICBExtSetICB;
     IF FileCursorX <= Length(ActLine^.zk^) THEN FCX := FileCursorX
     ELSE FCX := Length(ActLine^.zk^)+1;
     IF FCX > StringLength THEN FCX := StringLength;

     IF (ICB.LastLine = ActLine) AND (ICB.LastX = FCX)
     THEN ICB.LastX := Length(ActLine^.zk^)+1
     ELSE ICB.FirstX := Length(ActLine^.zk^)+1;

     _ICBExtCorrectICB;
     _ICBSetMark;
     CursorEnd;
     InvalidateSingleLine;
END;



PROCEDURE TEditorWindow.ICBExtWordLeft;
VAR  OldLine : PLine;
     OldX : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     IgnoreRedraw := TRUE;
     _ICBExtSetICB;
     IF FileCursorX <= Length(ActLine^.zk^) THEN OldX := FileCursorX
     ELSE OldX := Length(ActLine^.zk^)+1;
     IF OldX > StringLength THEN OldX := StringLength;
     OldLine := ActLine;

     WordLeft;
     IgnoreRedraw := FALSE;

     IF (OldLine = ICB.FirstLine) AND (OldX = ICB.FirstX) THEN
     BEGIN
          ICB.FirstLine := ActLine;
          IF FileCursorX <= Length(ActLine^.zk^)
          THEN ICB.FirstX := FileCursorX
          ELSE ICB.FirstX := Length(ActLine^.zk^)+1;
     END
     ELSE
     BEGIN
          ICB.LastLine := ActLine;
          IF FileCursorX <= Length(ActLine^.zk^)
          THEN ICB.LastX := FileCursorX
          ELSE ICB.LastX := Length(ActLine^.zk^)+1;
     END;

     _ICBExtCorrectICB;
     _ICBSetMark;
     IF (OldLine = ActLine) AND (NOT _HorizMove) AND (NOT ChangeICB) THEN
     BEGIN
          SetCursorXY;
          InvalidateSingleLine;
     END
     ELSE InvalidateEditorWindow(1);
END;



PROCEDURE TEditorWindow.ICBExtWordRight;
VAR  OldLine : PLine;
     OldX : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     IgnoreRedraw := TRUE;
     _ICBExtSetICB;
     IF FileCursorX <= Length(ActLine^.zk^) THEN OldX := FileCursorX
     ELSE OldX := Length(ActLine^.zk^)+1;
     IF OldX > StringLength THEN OldX := StringLength;
     OldLine := ActLine;

     WordRight;
     IgnoreRedraw := FALSE;

     IF (OldLine = ICB.LastLine) AND (OldX = ICB.LastX) THEN
     BEGIN
          ICB.LastLine := ActLine;
          IF FileCursorX <= Length(ActLine^.zk^)
          THEN ICB.LastX := FileCursorX
          ELSE ICB.LastX := Length(ActLine^.zk^)+1;
     END
     ELSE
     BEGIN
          ICB.FirstLine := ActLine;
          IF FileCursorX <= Length(ActLine^.zk^)
          THEN ICB.FirstX := FileCursorX
          ELSE ICB.FirstX := Length(ActLine^.zk^)+1;
     END;

     _ICBExtCorrectICB;
     _ICBSetMark;
     IF (OldLine = ActLine) AND (NOT _HorizMove) AND (NOT ChangeICB) THEN
     BEGIN
          SetCursorXY;
          InvalidateSingleLine;
     END
     ELSE InvalidateEditorWindow(1);
END;



PROCEDURE TEditorWindow.ICBExtFileBegin;
VAR  FCX : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     IgnoreRedraw := TRUE;
     _ICBExtSetICB;
     IgnoreRedraw := FALSE;
     IF FileCursorX <= Length(ActLine^.zk^) THEN FCX := FileCursorX
     ELSE FCX := Length(ActLine^.zk^)+1;
     IF FCX > StringLength THEN FCX := StringLength;

     IF (ICB.FirstLine = ActLine) AND (ICB.FirstX = FCX) THEN
     BEGIN
          ICB.FirstLine := FirstLine;
          ICB.FirstX := 1;
     END
     ELSE
     BEGIN
          ICB.LastLine := FirstLine;
          ICB.LastX := 1;
     END;

     _ICBExtCorrectICB;
     _ICBSetMark;
     GotoBegin;
END;



PROCEDURE TEditorWindow.ICBExtFileEnd;
VAR  FCX : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     IgnoreRedraw := TRUE;
     _ICBExtSetICB;
     IgnoreRedraw := FALSE;
     IF FileCursorX <= Length(ActLine^.zk^) THEN FCX := FileCursorX
     ELSE FCX := Length(ActLine^.zk^)+1;
     IF FCX > StringLength THEN FCX := StringLength;

     IF (ICB.LastLine = ActLine) AND (ICB.LastX = FCX) THEN
     BEGIN
          ICB.LastLine := LastLine;
          ICB.LastX := Length(LastLine^.zk^)+1;
     END
     ELSE
     BEGIN
          ICB.FirstLine := LastLine;
          ICB.FirstX := Length(LastLine^.zk^)+1;
     END;

     _ICBExtCorrectICB;
     _ICBSetMark;
     GotoEnd;
END;


{ +++ Clipboard-Functions ++++++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow.CutToClipBoard;
VAR  P : POINTER;
     Len : LONGWORD;
BEGIN
     IF NOT ICBVisible THEN exit;
     IF WinReadOnly THEN exit;
     P := _CopyICBLinear(Len);
     IF P = NIL THEN exit;       {Length=0}
     IF _SetClipBoardText(P,Len) THEN
     BEGIN
          ICBDeleteBlock;        {ICBDeleteBlock includes UNDO settings}
          EnablePaste;
     END;
     FreeMem(P,Len);
END;



PROCEDURE TEditorWindow.CopyToClipBoard;
VAR  P : POINTER;
     Len : LONGWORD;
BEGIN
     IF NOT ICBVisible THEN exit;
     P := _CopyICBLinear(Len);
     IF P = NIL THEN exit;       {Length=0}
     IF _SetClipBoardText(P,Len) THEN EnablePaste;
     FreeMem(P,Len);
END;



PROCEDURE TEditorWindow.PasteFromClipBoard;
VAR  P : POINTER;
     Len : LONGWORD;
BEGIN
     IF WinReadOnly THEN exit;
     IF WLactivated THEN _WriteWorkLine;
     P := _GetClipBoardText(Len);
     IF P <> NIL THEN
     BEGIN
          (*UNDO*)
          _CopyUndoLines(ActLine,ActLine);
          LastUndoGroup := UG_CursorMove;
          (*UNDO*)
          _ICBClearMark;
          _PasteICBLinear(P,Len);
          SetSliderValues;
          SetLineColorFlag(ICB.FirstLine,ICB.LastLine);
          ICBGotoBegin;
          FreeMem(P,Len);
          (*UNDO*)
          UndoEvent[LastUndo].FrameEnd := _PLine2Long(ICB.LastLine^.next);
          LastUndoGroup := UG_NoGroup;
          (*UNDO*)
     END;
END;



PROCEDURE TEditorWindow.EnableCopyCut;
BEGIN
END;


PROCEDURE TEditorWindow.DisableCopyCut;
BEGIN
END;


PROCEDURE TEditorWindow.EnablePaste;
BEGIN
END;


PROCEDURE TEditorWindow.DisablePaste;
BEGIN
END;


PROCEDURE TEditorWindow.EnableUndo;
BEGIN
END;


PROCEDURE TEditorWindow.DisableUndo;
BEGIN
END;


PROCEDURE TEditorWindow.EnableRedo;
BEGIN
END;


PROCEDURE TEditorWindow.DisableRedo;
BEGIN
     RedoEvents := 0;
END;


{ +++ Procedures of TEditorWindow ++++++++++++++++++++++++++++++++++++++++++ }


CONSTRUCTOR TEditorWindow.Init(AParent:PWindowsObject; ATitle:STRING);
VAR  i : WORD;
BEGIN
     Inherited.Init(AParent,ATitle);
     Attr.FrameFlags:=Attr.FrameFlags OR FCF_VERTSCROLL OR FCF_HORZSCROLL;
     StdExt := '.TXT';
     WinColor := CLR_BLACK;
     WinBackColor := CLR_WHITE;
     Sel_Color := CLR_WHITE;
     Sel_BackColor := CLR_BLACK;
     WLactivated := FALSE;
     ICBVisible := TRUE;
     IgnoreRedraw := FALSE;
     Untitled := TRUE;
     Modified := FALSE;
     FileCursorY := 1;
     FileCursorX := 1;
     ScrCursorY := 1;
     ScrCursorX := 1;
     HSlider.acvalue := 1;
     CountLines := 1;
     NewEditorPtr := WinQuerySysPointer(HWND_DESKTOP,SPTR_TEXT,FALSE);
     FileName := '';
     ICB.FirstLine := NIL;
     ICB.FirstX := 0;
     ICB.LastLine := NIL;
     ICB.LastX := 0;
     OldICB := ICB;
     FindICB := FALSE;
     New(WorkLine);
     WorkLine^ := '';
     {create anchor}
     New(FirstLine);
     FirstLine^.color := CI_Normal;
     FirstLine^.prev := NIL;
     FirstLine^.next := NIL;
     LastLine := FirstLine;
     ActLine := FirstLine;
     FirstScreenLine := FirstLine;
     _WriteWorkLine;
     CountLines := 1;
     SetFlags(WF_DELETEDOUBLESCAN,TRUE); {delete multiple scan events}
     MaxDoubleChars := 15;
     MaxDoubleScans := 15;
     UndoEvents := 0;
     LastUndo := 0;
     FOR i := 0 TO MaxUndoEvents-1 DO UndoEvent[i].Event := 0;
     RedoEvents := 0;
     LastRedo := 0;
     FOR i := 0 TO MaxRedoEvents-1 DO RedoEvent[i].Event := 0;
     LastUndoGroup := UG_NoGroup;
     PrintInfo.Status := 0;
END;



PROCEDURE TEditorWindow.WindowDestroyed;
BEGIN
     CloseFile;
END;


FUNCTION TEditorWindow.CanClose:BOOLEAN;
VAR  resp : LONGWORD;
     text,titel : STRING;
BEGIN
     CanClose := TRUE;
     IF Modified THEN
     BEGIN
          IF Untitled THEN text := Attr.Title + NLSTable[9]
          ELSE text := FileName + NLSTable[9];
          titel := NLSTable[10];
          resp := SetQueryMessage(titel,text,MB_YESNOCANCEL OR MB_MOVEABLE OR
                                             MB_QUERY);
          CASE resp OF
               MBID_YES    : IF NOT SaveFile THEN CanClose := FALSE;
               MBID_CANCEL : CanClose := FALSE;
          END;
     END;
END;


{ +++ Drag & Drop Procedures +++++++++++++++++++++++++++++++++++++++++++++++ }


FUNCTION TEditorWindow._GetFileText(s: STRING; VAR Len:LONGWORD):POINTER;
VAR  utF : FILE;
     P : ^LONGWORD;
BEGIN
     Assign(utF,s);
     FileMode := fmInput;
     {$i-}
     Reset(utF,1);
     FileMode := fmInOut;
     IF IOResult <> 0 THEN Len := 0
     ELSE Len := FileSize(utF);
     {$i+}
     IF Len > 0 THEN
     BEGIN
          GetMem(P,Len);
          {$i-}
          Blockread(utF,P^,Len);
          {$i+}
     END
     ELSE P := NIL;
     {$i-}
     Close(utF);
     {$i+}
     _GetFileText := P;
END;



PROCEDURE TEditorWindow.PasteFromFile(s:STRING);
VAR  P : POINTER;
     Len : LONGWORD;
BEGIN
     IF WinReadOnly THEN exit;
     IF WLactivated THEN _WriteWorkLine;
     P := _GetFileText(s,Len);
     IF P <> NIL THEN
     BEGIN
          (*UNDO*)
          _CopyUndoLines(ActLine,ActLine);
          LastUndoGroup := UG_CursorMove;
          (*UNDO*)
          _ICBClearMark;
          _PasteICBLinear(P,Len);
          SetSliderValues;
          SetLineColorFlag(ICB.FirstLine,ICB.LastLine);
          ICBGotoBegin;
          FreeMem(P,Len);
          (*UNDO*)
          UndoEvent[LastUndo].FrameEnd := _PLine2Long(ICB.LastLine^.next);
          LastUndoGroup := UG_NoGroup;
          (*UNDO*)
     END;
END;


{ +++ Procedures for Drag & Drop +++++++++++++++++++++++++++++++++++++++++++ }

{Initiate drag operation}
PROCEDURE TEditorWindow.WMBeginDrag(VAR Msg:TMessage);
VAR  P : POINTER;
     Len : LONGWORD;
     utF : FILE;
     fname,fdir : STRING;
     cType,cRMF,cContainer,cSource : CSTRING;
     h,m,s,s100 : WORD;
     TargetWin : HWND;
     ditem : DragItem;
     dimage : DragImage;
     pdinfo : PDragInfo;
     TempFilename : STRING;
LABEL l;
BEGIN
     Msg.Result := 0;
     Msg.Handled := TRUE;

     {Create temp file}
     P := _CopyICBLinear(Len);
     IF P = NIL THEN exit;                    {Length=0}
     FSplit(ParamStr(0),fdir,fname,fname);    {only fdir is relevant}
     IF fdir = '' THEN fdir := 'c:\';
     GetTime(h,m,s,s100);
     fname := tostr(s)+tostr(s100)+'.tmp';    {random filename}
     TempFilename := fdir+fname;
     Assign(utF,TempFilename);
     {$i-}
     Rewrite(utF,1);
     {$i+}
     IF IoResult <> 0 THEN
     BEGIN
l:
          FreeMem(P,Len);
          exit;
     END;
     {$i-}
     BlockWrite(utF,P^,Len-1);                {without #0}
     {$i+}
     IF IoResult <> 0 THEN goto l;
     {$i-}
     Close(utF);
     {$i+}
     IF IoResult <> 0 THEN goto l;
     FreeMem(P,Len);

     {Init dragitem struct}
     ditem.hwndItem := HWindow;
     ditem.ulItemID := 0;
     cType := 'Plain Text';
     ditem.hstrType := DrgAddStrHandle(cType);
     cRMF := '(DRM_OS2FILE,DRM_PRINT) x (DRF_TEXT,DRF_UNKNOWN)';
     ditem.hstrRMF  := DrgAddStrHandle(cRMF);
     cContainer := fdir;
     ditem.hstrContainerName := DrgAddStrHandle(cContainer);
     cSource := fname;
     ditem.hstrSourceName := DrgAddStrHandle(cSource);
     ditem.hstrTargetName := DrgAddStrHandle(cSource);
     ditem.cxOffset := 0;
     ditem.cyOffset := 0;
     ditem.fsControl := 0;
     ditem.fsSupportedOps := DO_COPYABLE OR DO_MOVEABLE;

     {Init dragimage struct}
     dimage.cb := SizeOf(DragImage);
     dimage.hImage := WinQuerySysPointer(HWND_DESKTOP,SPTR_TEXT,TRUE);
     dimage.fl := DRG_ICON;
     dimage.cxOffset := 0;
     dimage.cyOffset := 0;

     {Initiate drag}
     pdinfo := DrgAllocDragInfo(1);
     IF pdinfo = NIL THEN exit;
     pdinfo^.usOperation := DO_COPY;    {default is copy}
     DrgSetDragItem(pdinfo^,ditem,SizeOf(DragItem),0);
     TargetWin := DrgDrag(HWindow,pdinfo^,dimage,1,VK_ENDDRAG,NIL);

     IF TargetWin <> 0 THEN
     BEGIN
          IF TargetWin <> HWindow THEN
          BEGIN
               IF pdinfo^.usOperation = DO_MOVE THEN ICBDeleteBlock;
          END
          ELSE
          BEGIN
               IF pdinfo^.usOperation = DO_MOVE THEN ICBMoveBlock
               ELSE ICBCopyBlock;
          END;
     END;

     DrgFreeDragInfo(pdinfo^);

     Assign(utF,TempFilename);
     {$i-}
     Erase(utF);     {delete temp file if possible}
     {$i+}
END;



PROCEDURE TEditorWindow.DMDragOver(VAR Msg:TMessage);
VAR  pdinfo : PDragInfo;
     ditem : DragItem;
     szNativeRMF : CSTRING;
     szDropDirectory : CSTRING;
     szDropFileName : CSTRING;
     s,sDir,sFile : STRING;
     i : WORD;
     F : FILE;
BEGIN
     pdinfo := PDragInfo(Msg.Param1);
     IF NOT WinReadOnly THEN
       IF DrgAccessDraginfo(pdinfo^) THEN
       BEGIN
            IF pdinfo^.usOperation = DO_LINK THEN {no valid operation}
            BEGIN
                 Msg.Result := (DO_UNKNOWN SHL 16) OR DOR_NODROPOP;
                 Msg.Handled := TRUE;
                 exit;
            END;
            FOR i := 0 TO pdinfo^.cditem-1 DO
            BEGIN
                 IF DrgQueryDragitem(pdinfo^,sizeof(ditem),ditem,i) THEN
                   IF DrgQueryNativeRMF(ditem,255,szNativeRMF) THEN
                   BEGIN
                        s := szNativeRMF;
                        IF pos('DRM_OS2FILE,DRF_TEXT',s) <> 0 THEN
                          IF (ditem.fsSupportedOps AND DO_COPYABLE <> 0) OR
                             (ditem.fsSupportedOps AND DO_MOVEABLE <> 0) THEN
                          BEGIN
                               DrgQueryStrName(ditem.hstrContainerName,
                                          sizeof(szDropDirectory),szDropDirectory);
                               sDir := szDropDirectory;
                               IF sDir[Length(sDir)] <> '\' THEN sDir := sDir + '\';
                               DrgQueryStrName(ditem.hstrSourceName,
                                               sizeof(szDropFileName),szDropFileName);
                               sFile := szDropFileName;

                               Assign(F,sDir+sFile);
                               FileMode := fmInput;
                               {$i-}
                               Reset(F);
                               {$i+}
                               FileMode := fmInOut;
                               IF IoResult = 0 THEN
                               BEGIN
                                    {$i-}
                                    Close(F);
                                    {$i+}
                                    Msg.Result := (DO_UNKNOWN SHL 16) OR DOR_DROP;
                                    Msg.Handled := TRUE;
                                    exit;
                               END;
                        END;
                   END;
            END;
       END;
     Msg.Result := (DO_UNKNOWN SHL 16) OR DOR_NEVERDROP;
     Msg.Handled := TRUE;
END;



PROCEDURE TEditorWindow.DMDrop(VAR Msg:TMessage);
VAR  pdinfo : PDragInfo;
     ditem : DragItem;
     szNativeRMF : CSTRING;
     szDropDirectory : CSTRING;
     szDropFileName : CSTRING;
     s,sDir,sFile : STRING;
     i : WORD;
BEGIN
     pdinfo := PDragInfo(Msg.Param1);
     IF NOT WinReadOnly THEN
       IF DrgAccessDraginfo(pdinfo^) THEN
         FOR i := 0 TO pdinfo^.cditem-1 DO
         IF pdinfo^.hwndSource <> HWindow THEN  {else WMBeginDrag does it}
           IF DrgQueryDragitem(pdinfo^,sizeof(ditem),ditem,i) THEN
             IF DrgQueryNativeRMF(ditem,255,szNativeRMF) THEN
             BEGIN
                  s := szNativeRMF;
                  IF pos('DRM_OS2FILE,DRF_TEXT',s) <> 0 THEN
                    IF (ditem.fsSupportedOps AND DO_COPYABLE <> 0) OR
                       (ditem.fsSupportedOps AND DO_MOVEABLE <> 0) THEN
                    BEGIN
                         DrgQueryStrName(ditem.hstrContainerName,
                                         sizeof(szDropDirectory),szDropDirectory);
                         sDir := szDropDirectory;
                         IF sDir[Length(sDir)] <> '\' THEN sDir := sDir + '\';
                         DrgQueryStrName(ditem.hstrSourceName,
                                         sizeof(szDropFileName),szDropFileName);
                         sFile := szDropFileName;
                         IF EditOptions AND EOD_UseCUA <> 0
                         THEN CuaPasteFromFile(sDir+sFile)
                         ELSE PasteFromFile(sDir+sFile);

                         DrgSendTransferMsg(ditem.hwndItem,DM_ENDCONVERSATION,
                                            MPFROMLONG(ditem.ulItemID),
                                            MPFROMSHORT(DMFL_TARGETSUCCESSFUL));
                    END
                    ELSE DrgSendTransferMsg(ditem.hwndItem,DM_ENDCONVERSATION,
                                            MPFROMLONG(ditem.ulItemID),
                                            MPFROMSHORT(DMFL_TARGETFAIL));
             END;
     DrgDeleteDraginfoStrHandles(pdinfo^);
     DrgFreeDraginfo(pdinfo^);
     Msg.Result := 0;
     Msg.Handled := TRUE;
END;



PROCEDURE TEditorWindow.DMDropHelp(VAR Msg:TMessage);
BEGIN
     Msg.Handled := TRUE;
     Msg.Result := 0;
END;



PROCEDURE TEditorWindow.DMPrintObject(VAR Msg:TMessage);
CONST g : SIZEL = (cx:0; cy:0);
TYPE  PPrintDest = ^PrintDest;
VAR  dopPrinter : DEVOPENSTRUC;
     InfoDC : HDC;
     InfoPS : HPS;
     PrinterDC : HDC;
     PrinterPS : HPS;
     ptl : POINTL;
     ptlRes : POINTL;
     lSizeHC : LONGWORD;
     pHCInfo : ^HCINFO;
     pHCI : ^HCINFO;
     physPageSize : SIZEL;
     PrintArea : SIZEL;
     PrintOffset : SIZEL;
     Len : LONGWORD;
     i : WORD;
     pp : PPrintDest;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     IF PrintInfo.Status <> 0 THEN exit;
     PrintInfo.PRN_LeftIndent := 100;
     PrintInfo.PRN_UpperIndent := 100;
     PrintInfo.PRN_LowerIndent := 150;
     PrintInfo.PRN_LineDist := 45;

     pp := PPrintDest(Msg.Param2);
     IF pp = NIL THEN exit;
     {Get Printer Device Open Structure}
     dopPrinter := DEVOPENSTRUC(pp^.pdopData^);

     {Open Info DC}
     InfoDC := DevOpenDC(HInstance, OD_INFO, '*', 4, dopPrinter, 0);
     IF InfoDC = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[22]);
          exit;
     END;
     InfoPS := GpiCreatePS(HInstance, InfoDC, g,
                           PU_LOMETRIC OR GPIT_MICRO OR GPIA_ASSOC);
     IF InfoPS = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[23]);
          exit;
     END;

     GpiQueryPS(InfoPS,PrintArea);

     lSizeHC := DevQueryHardcopyCaps(InfoDC,0,0,NIL);
     IF lSizeHC = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[24]);
          exit;
     END;

     GetMem(pHCInfo,lSizeHC*SizeOf(HCINFO));
     DevQueryHardcopyCaps(InfoDC,0,lSizeHC,pHCInfo^);

     pHCI := pHCInfo;
     FOR i := 0 TO lSizeHC-1 DO
     BEGIN
          IF pHCI^.flAttributes AND HCAPS_CURRENT <> 0 THEN
          BEGIN
               /* Get Resolution */
               DevQueryCaps (InfoDC,CAPS_HORIZONTAL_RESOLUTION,1,ptlRes.x);
               DevQueryCaps (InfoDC,CAPS_VERTICAL_RESOLUTION,1,ptlRes.y);

               /* Calculate the physical page size */
               physPageSize.cx := round((ptlRes.x * pHCI^.cx) / 1000);
               physPageSize.cy := round((ptlRes.y * pHCI^.cy) / 1000);
               /* Convert from device to world coordinate space */
               GpiConvert(InfoPS,CVTC_DEVICE,CVTC_WORLD,1,POINTL(physPageSize));

               /* Calculate Print Offset */
               PrintOffset.cx := round((ptlRes.x * pHCI^.xLeftClip) / 1000);
               PrintOffset.cy := round((ptlRes.y * pHCI^.yBottomClip) / 1000);
               /* Convert from device to world coordinate space */
               GpiConvert(InfoPS,CVTC_DEVICE,CVTC_WORLD,1,POINTL(PrintOffset));

               /* Correct Print Offset if necessary */
               DevQueryCaps (InfoDC,CAPS_WIDTH,1,ptl.x);
               DevQueryCaps (InfoDC,CAPS_HEIGHT,1,ptl.y);
               /* Convert from device to world coordinate space */
               GpiConvert(InfoPS,CVTC_DEVICE,CVTC_WORLD,1,ptl);
               IF PrintOffset.cx = 0
               THEN PrintOffset.cx := (physPageSize.cx - ptl.x) DIV 2;
               IF PrintOffset.cy = 0
               THEN PrintOffset.cy := (physPageSize.cy - ptl.y) DIV 2;
           END;
           inc(pHCI,SizeOf(HCINFO));
     END;
     FreeMem(pHCInfo,lSizeHC*SizeOf(HCINFO));
     GpiAssociate(InfoPS,0);
     GpiDestroyPS(InfoPS);
     DevCloseDC(InfoDC);


     {Open Printer DC}
     PrinterDC := DevOpenDC(HInstance, OD_QUEUED, '*', 4, dopPrinter, 0);
     IF PrinterDC = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[25]);
          exit;
     END;
     {Set DeviceContext and PresentationSpace}
     PrinterPS := GpiCreatePS(HInstance, PrinterDC, g,
                         PU_LOMETRIC OR GPIT_MICRO OR GPIA_ASSOC);
     IF PrinterPS = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[26]);
          DevCloseDC(PrinterDC);
          exit;
     END;

     {Calculate PrintOffset within the Presentation space}
     IF PrintOffset.cx < PrintInfo.PRN_LeftIndent
     THEN PrintInfo.OffsX := PrintInfo.PRN_LeftIndent-PrintOffset.cx
     ELSE PrintInfo.OffsX := 0;

     IF PrintOffset.cy < PrintInfo.PRN_LowerIndent
     THEN PrintInfo.OffsY := PrintInfo.PRN_LowerIndent-PrintOffset.cy
     ELSE PrintInfo.OffsY := 0;

     PrintInfo.OffsFL := physPageSize.cy-PrintOffset.cy-PrintInfo.PRN_UpperIndent;
     IF PrintInfo.OffsFL > PrintArea.cy THEN PrintInfo.OffsFL := PrintArea.cy;

     PrintInfo.PrinterDC := PrinterDC;
     PrintInfo.PrinterPS := PrinterPS;
     PrintInfo.Text := _CopyICBLinear(Len);
     PrintInfo.TextLen := Len;
     PrintInfo.AbortHwnd := 0;
     PrintInfo.Status := 1;

     InitializePrinting;
END;


{ +++ Procedures to Window management ++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow.WMPresParamChanged(VAR Msg:TMessage);
VAR  PPid : LONGWORD;
     cFNS : CSTRING;
     FNS,s : STRING;
     Size,p : BYTE;
     c,i : INTEGER;
BEGIN
     PPid := Msg.Param1;
     IF PPid = PP_FONTNAMESIZE THEN
     BEGIN
          WinQueryPresParam(HWindow,
                            PPid,
                            0,
                            NIL,
                            SizeOf(cFNS),
                            cFNS,
                            QPF_NOINHERIT);
          FNS := cFNS;
          p := pos('.',FNS);
          IF p = 0 THEN exit;
          Val(copy(FNS,1,p-1),Size,c);
          IF c <> 0 THEN exit;
          delete(FNS,1,p);
          UpcaseStr(FNS);

          FOR i := 0 TO AvailFontCount-1 DO
          BEGIN
               s := AvailFont[i].FontName;
               UpcaseStr(s);
               IF (s = FNS) AND (AvailFont[i].PointSize = Size) THEN
               BEGIN
                    FaceName := AvailFont[i].FontName;
                    CharHeight := AvailFont[i].Height;
                    CharWidth := AvailFont[i].Width;
                    CharBaseLine := AvailFont[i].BaseLine;
                    UpdateFont;
                    exit;
               END;
          END;
          beep(100,10); {Font not available}
     END;
END;


PROCEDURE TEditorWindow.WMSize(VAR Msg:TMessage);
VAR  CursorMoved : BOOLEAN;
     FCX : WORD;
     FCY : LONGWORD;
BEGIN
     Inherited.WMSize(Msg);
     ClearFullBkGr := TRUE;
     WinQueryWindowRect(HWindow,WindowRect);
     WinSizeX := (WindowRect.XRight - 4) DIV CharWidth;
     WinSizeY := (WindowRect.yTop - 2 - CharBaseLine) DIV CharHeight;
     CursorMoved := FALSE;
     IF ScrCursorY > WinSizeY THEN
     BEGIN
          FCY := FileCursorY-ScrCursorY+WinSizeY;
          CursorMoved := TRUE;
     END
     ELSE FCY := FileCursorY;
     IF ScrCursorX > WinSizeX THEN
     BEGIN
          FCX := FileCursorX-ScrCursorX+WinSizeX;
          CursorMoved := TRUE;
     END
     ELSE FCX := FileCursorX;
     IF CursorMoved THEN
     BEGIN
          IgnoreRedraw := TRUE;
          GotoLine(FCY,FCX);
     END;
     IgnoreRedraw := WinSizeY = 0;
     SetCursorXY;
     SetSliderValues;
END;



PROCEDURE TEditorWindow.SetupWindow;
BEGIN
     Inherited.SetupWindow;
     DisableAutoFill;  {No background fill}
     ResidentHPS:=WinGetPS(HWindow);
     GpiSetBackMix(ResidentHPS,BM_OVERPAINT);
     CreateLogFont(ResidentHPS,FaceName,CharHeight,CharWidth,0);

     IF AvailFontCount = 0
     THEN AvailFontCount := QueryFonts(ResidentHPS); {enumerate available Fonts}
END;


{ +++ Procedures to screen output ++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow.SetCursorXY;
VAR  cux,cuy:LONGWORD;
BEGIN
     WinShowCursor(HWindow,FALSE);  {Hide cursor}
     cux:=2+((ScrCursorX-1)*CharWidth);
     cuy:=WindowRect.yTop-(ScrCursorY*CharHeight);
     dec(cuy,CharBaseLine);
     WinCreateCursor(HWindow,cux,cuy,CharWidth,2,$8004,NIL);
     WinShowCursor(HWindow,TRUE);
     UpdateEditorStatus;
     IF RedoEvents > 0 THEN DisableRedo;
END;



PROCEDURE TEditorWindow.SetStatusMessage(sm:STRING);
BEGIN
END;



PROCEDURE TEditorWindow.UpdateEditorStatus;
BEGIN
END;



PROCEDURE TEditorWindow.SetWindowTitleText(str:STRING);
VAR  cs : CSTRING;
BEGIN
     cs := str;
     WinSetWindowText(HWindowFrame,cs);
     Attr.Title := str;
END;



PROCEDURE TEditorWindow.SetErrorMessage(button:LONGWORD; titel,text:STRING);
BEGIN
     ErrorBox(button,titel,text);
END;



FUNCTION TEditorWindow.SetQueryMessage(titel,text:STRING;buttons:LONGWORD):LONGWORD;
VAR  ct,cx : CSTRING;
BEGIN
     ct := titel;
     cx := text;
     SetQueryMessage := WinMessageBox(HWND_DESKTOP,HWindowframe,cx,ct,0,buttons);
END;



FUNCTION TEditorWindow.UpdateLineColorFlag(PL:PLine):BOOLEAN;
BEGIN
     UpdateLineColorFlag := FALSE;
END;


PROCEDURE TEditorWindow.SetLineColorFlag(PL1,PL2:PLine);
BEGIN
END;



PROCEDURE TEditorWindow.CalcLineColor(PL:PLine);
VAR  i : WORD;
     SelAnfang : WORD;
     SelEnde : WORD;
     ac : LONGWORD;
     asmCol:LONGINT;
     asmBCol:LONGINT;
     asmLen:LONGWORD;
BEGIN
     ac := HSlider.acvalue;
     asmCol := WinColor;
     asmBCol := WinBackColor;
     asmLen := ac+WinSizeX-1;
     ASM
        LEA EDI,OEDITORS.LINECOLOR
        MOV EAX,$asmBCol
        SHL EAX,16         //shift into high word
        MOV AX,$asmCol
        MOV ECX,$asmLen
        CLD
        REP
        STOSD
     END;

     IF PL = NIL THEN exit;
     IF (PL^.color AND CI_Selected = 0) OR NOT ICBVisible THEN exit;

     IF ICB.FirstLine = PL THEN SelAnfang := ICB.FirstX
     ELSE SelAnfang := 1;
     IF ICB.LastLine = PL THEN SelEnde := ICB.LastX-1
     ELSE SelEnde := asmLen;
     IF SelAnfang > asmLen THEN exit;
     IF SelEnde > asmLen THEN SelEnde := asmLen;

     FOR i := SelAnfang TO SelEnde DO
     BEGIN
          LineColor[i].Color := Sel_Color;
          LineColor[i].BackColor := Sel_BackColor;
     END;
END;



PROCEDURE TEditorWindow.InvalidateEditorLine(PL:PLine; CY:WORD);
VAR  pt : POINTL;
     ac : WORD;
     i : WORD;
     Color : INTEGER;
     BackColor : INTEGER;
     count : WORD;
     pos : WORD;
     w : WORD;
BEGIN
     IF IgnoreRedraw THEN exit;
     ac := HSlider.acvalue;
     IF PL <> NIL THEN
     BEGIN
          IF PL^.zk <> NIL THEN OutputString := PL^.zk^
          ELSE OutputString := WorkLine^;
     END
     ELSE OutputString := '';

     CalcLineColor(PL);

     FOR i := Length(OutputString)+1 TO ac+WinsizeX-1 DO
     BEGIN
          OutputString[i]:=#32;
          inc(OutputString[0]);
     END;
     OutputString[Length(OutputString)+1]:=#0;

     {BookMark}
     IF PL <> NIL THEN
     BEGIN
          w := (PL^.color AND Mask4MSB) DIV BM_0;
          IF (w > 0) AND (w < 11) THEN
          BEGIN
               LineColor[ac+WinSizeX-2].Color := CLR_RED;
               LineColor[ac+WinSizeX-1].Color := CLR_RED;
               OutputString[ac+WinSizeX-2] := chr(174);
               OutputString[ac+WinSizeX-1] := chr(w+47);
          END;
     END;

     Color := LineColor[ac].color;
     BackColor := LineColor[ac].backcolor;
     count := 0;
     pos := 0;
     pt.y := WindowRect.yTop-(CY*CharHeight);
     FOR i := ac TO ac+WinSizeX-1 DO
     BEGIN
          IF (Color=LineColor[i].color) AND (BackColor=LineColor[i].backcolor)
          THEN inc(count)
          ELSE
          BEGIN
               pt.x:=2+pos*CharWidth;

               GpiSetColor(ResidentHPS,Color);
               GpiSetBackColor(ResidentHPS,BackColor);
               GpiCharStringAt(ResidentHPS,pt,count,OutputString[pos+ac]);

               inc(pos,count);
               count := 1;
               Color := LineColor[i].color;
               BackColor := LineColor[i].backcolor;
          END;
     END;
     IF count <> 0 THEN
     BEGIN
          pt.x := 2+(pos)*CharWidth;
          GpiSetColor(ResidentHPS,Color);
          GpiSetBackColor(ResidentHPS,BackColor);
          GpiCharStringAt(ResidentHPS,pt,count,OutputString[pos+ac]);
     END;
END;



PROCEDURE TEditorWindow.InvalidateSingleLine;
BEGIN
     IF IgnoreRedraw THEN exit;
     IF NOT UpdateLineColorFlag(ActLine) THEN
     BEGIN
          WinShowCursor(HWindow,FALSE); {Hide cursor}
          InvalidateEditorLine(ActLine,ScrCursorY);
          SetCursorXY;
          WinShowCursor(HWindow,TRUE);  {Show cursor}
     END
     ELSE InvalidateEditorWindow(ScrCursorY);
END;



PROCEDURE TEditorWindow.InvalidateEditorWindow(ab:WORD);
VAR  ptline : PLine;
     CursorY : WORD;
     i : WORD;
BEGIN
     IF IgnoreRedraw THEN exit;
     IF ab < 1 THEN ab := 1;
     IF ab > WinSizeY THEN ab := WinSizeY;
     SetSliderPosition;
     WinShowCursor(HWindow,FALSE);  {Hide cursor}
     IF WLactivated THEN _WriteWorkLine;
     ptline := FirstScreenLine;
     FOR i := 2 TO ab DO
        IF ptline <> NIL THEN ptline := ptline^.next;
     FOR CursorY := ab TO WinSizeY DO
     BEGIN
          InvalidateEditorLine(ptline,CursorY);
          IF ptline <> NIL THEN ptline := ptline^.next;
     END;

     SetCursorXY;
     WinShowCursor(HWindow,TRUE);  {Show cursor again}
END;



PROCEDURE TEditorWindow.Redraw(VAR ahps:HPS;VAR rc:RECTL);
VAR  rec : RECTL;
     ptline : PLine;
     CursorY : WORD;
     SaveIR : BOOLEAN;
BEGIN
     WinShowCursor(HWindow,FALSE);  {Hide cursor}
     IF ClearFullBkGr THEN
     BEGIN
          WinFillRect(ResidentHPS,WindowRect,WinBackColor);
          ClearFullBkGr := FALSE;
     END
     ELSE
     BEGIN
          rec := WindowRect;
          rec.yTop := rec.yTop-(WinSizeY*CharHeight+CharBaseLine-1);
          WinFillRect(ResidentHPS,rec,WinBackColor);    {down}
          rec := WindowRect;
          rec.yBottom := rec.yTop-CharBaseLine;
          WinFillRect(ResidentHPS,rec,WinBackColor);    {up}
          rec := WindowRect;
          rec.xRight := 3;
          WinFillRect(ResidentHPS,rec,WinBackColor);    {left}
          rec := WindowRect;
          rec.xLeft := WinSizeX*CharWidth+2;
          WinFillRect(ResidentHPS,rec,WinBackColor);    {right}
     END;

     SaveIR := IgnoreRedraw;
     IgnoreRedraw := FALSE;
     IF WLactivated THEN _WriteWorkLine;
     ptline := FirstScreenLine;
     FOR CursorY := 1 TO WinSizeY DO
     BEGIN
          InvalidateEditorLine(ptline,CursorY);
          IF ptline <> NIL THEN ptline := ptline^.next;
     END;
     IgnoreRedraw := SaveIR;
     WinShowCursor(HWindow,TRUE);  {Show cursor again}
END;


{ +++ Menu select procedures +++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow.LoadFile(Name:STRING);
VAR  utF : FILE;
     LinearStart : ^LONGWORD;
     LinearPtr : ^LONGWORD;
     fsize : LONGINT;
     storedfsize : LONGWORD;
     asmWorkLine : PSTRING;
     asmStringLength : LONGWORD;
     asmTabSize : LONGWORD;
     dir1,name1,ext1 : STRING;
BEGIN
     {Cut long filename}
     FSplit(Name,dir1,name1,ext1);
     Name := dir1 + name1 + ext1;

     {UpcaseStr(Name);}
     Assign(utF,Name);
     FileMode := fmInput;
     {$i-}
     Reset(utF,1);
     FileMode := fmInOut;
     IF IOResult <> 0 THEN fsize := 0
     ELSE fsize := FileSize(utF);
     {$i+}

     IF fsize > 0 THEN
     BEGIN
          SetStatusMessage(NLSTable[11]+Name);
          {Copy the object varriables to access via assembler}
          asmWorkLine := WorkLine;
          asmStringLength := StringLength;
          asmTabSize := EditOptions DIV $1000000;
          IF asmTabSize = 0 THEN asmTabSize := 8;

          GetMem(LinearStart,fsize+1);
          {$i-}
          Blockread(utF,LinearStart^,fsize);
          {$i+}
          storedfsize := fsize;

          _ReadWorkLine;
          LinearPtr := LinearStart;
          WHILE fsize > 0 do
          BEGIN
               WLactivated := TRUE;
               ASM
                  CLD
                  MOV EDI,$asmWorkLine
                  MOV ESI,$LinearPtr
                  INC EDI
                  XOR ECX,ECX
!lf1:
                  CMPD $fsize,0
                  JE !lf6
                  LODSB
                  DECD $fsize
                  CMP AL,32
                  JAE !lf5
                  CMP AL,13
                  JE !lf3
                  CMP AL,10
                  JE !lf4
                  CMP AL,9
                  JE !lf2
                  MOV AL,32
                  JMP !lf5
!lf2:
                  MOV EBX,ECX
                  MOV EDX,$asmTabSize
                  // insert spaces til to the next tab mark
!lf8:
                  CMP EDX,EBX
                  JA !lf7
                  ADD EDX,$asmTabSize
                  JMP !lf8
!lf7:
                  SUB EDX,EBX
                  // EDX = count of spaces
                  ADD EBX,EDX
                  CMP EBX,$asmStringLength
                  JAE !lf6
                  MOV ECX,EDX
                  MOV AL,32
                  REP
                  STOSB
                  MOV ECX,EBX
                  JMP !lf1
!lf3:
                  CMPB [ESI],10
                  JNE !lf6
                  LODSB
                  DECD $fsize
                  JMP !lf6
!lf4:
                  CMPB [ESI],13
                  JNE !lf6
                  LODSB
                  DECD $fsize
                  JMP !lf6
!lf5:
                  STOSB
                  INC ECX
                  CMP ECX,$asmStringLength
                  JB !lf1
!lf6:
                  MOV $LinearPtr,ESI
                  MOV EDI,$asmWorkLine
                  MOV [EDI+0],CL
               END;
               _WriteWorkLine;
               _InsertLine(ActLine);
               ActLine := ActLine^.next;
          END;
          _DeleteLine(ActLine);
          FreeMem(LinearStart,storedfsize+1);
     END;
     {$i-}
     Close(utF);
     {$i+}
     ActLine := FirstLine;
     FirstScreenLine := FirstLine;
     FileName := Name;
     SetWindowTitleText(FileName);
     SetStatusMessage('');
     Untitled := FALSE;
     Modified := FALSE;
     SetSliderValues;
     UpdateEditorStatus;
     SetLineColorFlag(FirstLine,LastLine);
END;



FUNCTION TEditorWindow.CopyLinesLinear(VAR Len:LONGWORD):POINTER;
VAR  ptline : PLine;
     LinearStart : POINTER;
     LinearPtr : POINTER;
     pstr : PSTRING;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     ptline := FirstLine;
     Len := 0;
     WHILE ptline <> NIL DO
     BEGIN
          inc(Len,Length(ptline^.zk^)+2);
          ptline := ptline^.next;
     END;
     GetMem(LinearStart,Len);
     ptline := FirstLine;

     LinearPtr := LinearStart;
     WHILE ptline <> NIL DO
     BEGIN
          pstr := ptline^.zk;
          ASM
             CLD
             MOV EDI,$LinearPtr
             MOV ESI,$pstr
             XOR ECX,ECX
             MOV CL,[ESI+0]
             INC ESI
             MOV EDX,ECX
             SHR ECX,2
             REP
             MOVSD
             MOV ECX,EDX
             AND ECX,3
             REP
             MOVSB
             MOV AX,$0A0D
             STOSW
             MOV $LinearPtr,EDI
          END;
          ptline := ptline^.next;
     END;
     CopyLinesLinear := LinearStart;
END;



FUNCTION TEditorWindow.SaveFile:BOOLEAN;
VAR  ptline : PLine;
     utF : FILE;
     eF : FILE;
     F : FILE;
     StartLinear : ^LONGWORD;
     Len : LONGWORD;
     p,IoR : WORD;
     BackupName : STRING;
     FName : STRING;
     name,dir,ext : STRING;
     titel,text : STRING;
     resp : LONGWORD;
BEGIN
     SaveFile := FALSE;
     IF Untitled THEN
     BEGIN
          FileSaveDlgWildCards := '*' + StdExt;
          FileSaveDlgTitle := NLSTable[7];
          FileSaveDlgOkname := NLSTable[28];
          IF NOT FileSaveDialog(Application^.MainWindow^.HWindow,FName) THEN exit;
          WinUpdateWindow(Application^.MainWindow^.HWindow);

          IF pos('.',FName) = 0 THEN FName := FName + StdExt;
          Assign(F,FName);
          {$i-}
          Reset(F);
          {$i+}
          IF IoResult = 0 THEN
          BEGIN
               {$i-}
               Close(F);
               {$i+}
               text := NLSTable[12] + FName + NLSTable[13];
               titel := NLSTable[14];
               resp := SetQueryMessage(titel,text,MB_OKCANCEL OR MB_MOVEABLE OR
                                                  MB_QUERY);
               IF resp = MBID_CANCEL THEN exit;
          END;
     END
     ELSE FName := FileName;

     p := pos('.',FName);
     IF p = 0 THEN FName := FName + StdExt;
     {Cut long filename}
     FSplit(FName,dir,name,ext);
     FileName := dir + name + ext;

     SetStatusMessage(NLSTable[15]+FileName);
     IF (EditOptions AND EOD_CreateBackup) <> 0 THEN
     BEGIN
          p := pos('.',FileName);
          BackupName := copy(FileName,1,p-1) + '.BAK';
          Assign(utF,FileName);
          {$i-}
          Reset(utF);
          IoR := IoResult;
          Close(utF);
          {$i+}
          IF IoR = 0 THEN
          BEGIN
               Assign(eF,BackupName);
               {$i-}
               Erase(eF);
               Rename(utF,BackupName);
               {$i+}
          END;
     END;
     Assign(utF,FileName);
     {$i-}
     Rewrite(utF,1);
     {$i+}
     IF IoResult <> 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[8]+FileName);
          SetStatusMessage('');
          exit;
     END;
     StartLinear := CopyLinesLinear(Len);
     IF Len > 2 THEN  {not only 1 empty line}
     BEGIN
          {$i-}
          BlockWrite(utF,StartLinear^,Len);
          {$i+}
          IF Ioresult<>0 THEN
          BEGIN
               SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[8]+FileName);
               FreeMem(StartLinear,Len);
               {$i-}
               Close(utF);
               {$i+}
               SetStatusMessage('');
               exit;
          END;
     END;
     FreeMem(StartLinear,Len);
     {$i-}
     Close(utF);
     {$i+}
     Untitled := FALSE;
     Modified := FALSE;
     SetStatusMessage('');
     SetWindowTitleText(FileName);
     UpdateEditorStatus;
     SaveFile := TRUE;
END;



PROCEDURE TEditorWindow.SaveAsFile;
VAR  p : WORD;
     Ext : STRING;
     FName : STRING;
     titel,text : STRING;
     resp : LONGWORD;
     F : FILE;
BEGIN
     p := pos('.',FileName);
     IF (p = 0) OR Untitled THEN Ext := StdExt
     ELSE Ext := copy(FileName,p,4);
     FileSaveDlgWildCards := '*' + Ext;
     FileSaveDlgTitle := NLSTable[7];
     FileSaveDlgOkname := NLSTable[28];
     IF NOT FileSaveDialog(Application^.MainWindow^.HWindow,FName) THEN exit;
     WinUpdateWindow(Application^.MainWindow^.HWindow);

     IF pos('.',FName) = 0 THEN FName := FName + Ext;
     Assign(F,FName);
     {$i-}
     Reset(F);
     {$i+}
     IF IoResult = 0 THEN
     BEGIN
          {$i-}
          Close(F);
          {$i+}
          text := NLSTable[12] + FName + NLSTable[13];
          titel := NLSTable[14];
          resp := SetQueryMessage(titel,text,MB_OKCANCEL OR MB_MOVEABLE OR
                                             MB_QUERY);
          IF resp = MBID_CANCEL THEN exit;
     END;
     FileName := FName;
     Untitled := FALSE;
     SaveFile;
END;



PROCEDURE TEditorWindow.CloseFile;
VAR  ptline : PLine;
     nextptline : PLine;
     i : WORD;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     ptline := FirstLine;
     WHILE ptline <> NIL DO
     BEGIN
         Freemem(ptline^.zk,length(ptline^.zk^)+1);
         nextptline := ptline^.next;
         dispose(ptline);
         ptline := nextptline;
     END;
     dispose(WorkLine);
     WinReleasePS(ResidentHPS);

     FOR i := 0 TO MaxUndoEvents-1 DO _DeleteUndoEvent(i);
     FOR i := 0 TO MaxRedoEvents-1 DO _DeleteRedoEvent(i);
END;



FUNCTION TEditorWindow.GetTextFromCursor:STRING;
VAR  FCX : WORD;
     count : WORD;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     FCX := FileCursorX;
     WHILE (ActLine^.zk^[FCX-1] IN NormalChars) AND (FCX > 1) DO dec(FCX);
     count := 0;
     WHILE (ActLine^.zk^[FCX+count] IN NormalChars) AND
           (FCX+count < StringLength) DO inc(count);
     GetTextFromCursor := copy(ActLine^.zk^,FCX,count);
END;



FUNCTION TEditorWindow.FindTextPos(s:STRING; w:WORD; VAR CY:LONGWORD;
                                   VAR CX:LONGWORD):BOOLEAN;
VAR  SForward : BOOLEAN;
     CaseSensitiv : BOOLEAN;
     FromCursor : BOOLEAN;
     WordsOnly : BOOLEAN;
     zeile : STRING;
     cutzeile : STRING;
     sl : STRING;
     P : WORD;
     ptline : PLine;
LABEL l1,l2,l3,l4;

FUNCTION IsFullWord:BOOLEAN;
VAR  locCX : LONGWORD;
BEGIN
     locCX := CX;
     IsFullWord := FALSE;
     IF locCX > 1 THEN
     BEGIN
          IF ptline^.zk^[locCX-1] IN NormalChars THEN exit;
     END;
     IF locCX+Length(sl)-1 < Length(ptline^.zk^) THEN
     BEGIN
          IF ptline^.zk^[locCX+Length(sl)] IN NormalChars THEN exit;
     END;
     IsFullWord := TRUE;
END;

BEGIN
     {evaluate the w flag}
     CaseSensitiv := w AND FRD_CaseSensitiv <> 0;
     FromCursor := w AND FRD_FromCursor <> 0;
     SForward := w AND FRD_Forward <> 0;
     WordsOnly := w AND FRD_WordsOnly <> 0;

     FindTextPos := FALSE;
     IF s = '' THEN exit;
     sl := s;
     IF NOT CaseSensitiv THEN UpcaseStr(s);
     IF WLactivated THEN _WriteWorkLine;
     IF SForward THEN
     BEGIN {Forward-Search}
          IF FromCursor THEN
          BEGIN
               ptline := ActLine;
               CY := FileCursorY;
          END
          ELSE
          BEGIN
               ptline := FirstLine;
               CY := 1;
          END;

          IF FromCursor THEN
          BEGIN
               zeile := copy(ptline^.zk^,FileCursorX,
                             Length(ptline^.zk^)-FileCursorX+1);
               IF NOT CaseSensitiv THEN UpcaseStr(zeile);
l1:
               CX := pos(s,zeile);
               IF CX <> 0 THEN
               BEGIN
                    FindTextPos := TRUE;
                    zeile[CX] := #0;
                    CX := CX + FileCursorX - 1;
                    IF NOT WordsOnly THEN exit;
                    IF IsFullWord THEN exit;
                    FindTextPos := FALSE;
                    goto l1;
               END;
               ptline := ptline^.next;
               inc(CY);
          END;

          WHILE ptline <> NIL DO
          BEGIN
               zeile := ptline^.zk^;
               IF NOT CaseSensitiv THEN UpcaseStr(zeile);
l2:
               CX := pos(s,zeile);
               IF CX <> 0 THEN
               BEGIN
                    FindTextPos := TRUE;
                    zeile[CX] := #0;
                    IF NOT WordsOnly THEN exit;
                    IF IsFullWord THEN exit;
                    FindTextPos := FALSE;
                    goto l2;
               END;
               ptline := ptline^.next;
               inc(CY);
          END;
     END
     ELSE {Backward-Search}
     BEGIN
          IF FromCursor THEN
          BEGIN
               ptline := ActLine;
               CY := FileCursorY;
          END
          ELSE
          BEGIN
               ptline := LastLine;
               CY := CountLines;
          END;

          IF FromCursor THEN
          BEGIN
               zeile := copy(ptline^.zk^,1,FileCursorX-1);
               IF NOT CaseSensitiv THEN UpcaseStr(zeile);
l3:
               CX := pos(s,zeile);
               IF CX <> 0 THEN
               BEGIN
                    FindTextPos := TRUE;
                    cutzeile := zeile;
                    REPEAT
                          cutzeile := copy(zeile,CX+1,Length(zeile)-CX);
                          IF NOT CaseSensitiv THEN UpcaseStr(cutzeile);
                          P := pos(s,cutzeile);
                          inc(CX,P);
                    UNTIL P = 0;
                    zeile[CX] := #0;
                    IF NOT WordsOnly THEN exit;
                    IF IsFullWord THEN exit;
                    FindTextPos := FALSE;
                    goto l3;
               END;
               ptline := ptline^.prev;
               dec(CY);
          END;

          WHILE ptline <> NIL DO
          BEGIN
               zeile := ptline^.zk^;
               IF NOT CaseSensitiv THEN UpcaseStr(zeile);
l4:
               CX := pos(s,zeile);
               IF CX <> 0 THEN
               BEGIN
                    FindTextPos := TRUE;
                    cutzeile := zeile;
                    REPEAT
                          cutzeile := copy(zeile,CX+1,Length(zeile)-CX);
                          IF NOT CaseSensitiv THEN UpcaseStr(cutzeile);
                          P := pos(s,cutzeile);
                          inc(CX,P);
                    UNTIL P = 0;
                    zeile[CX] := #0;
                    IF NOT WordsOnly THEN exit;
                    IF IsFullWord THEN exit;
                    FindTextPos := FALSE;
                    goto l4;
               END;
               ptline := ptline^.prev;
               dec(CY);
          END;
     END;
END;



PROCEDURE TEditorWindow.FindText(s:STRING; w:WORD); {Ctrl-Q F}
VAR  SForward : BOOLEAN;
     cy, cx : LONGWORD;
     dCursPos : WORD;
     ptline : PLine;
BEGIN
     SForward := w AND FRD_Forward <> 0;
     aSearchString := s;
     FindOptions := w;

     IF FindTextPos(s,w,cy,cx) THEN
     BEGIN
          IF SForward THEN dCursPos := Length(s)
          ELSE dCursPos := 0;
          OldICB := ICB;
          FindICB := TRUE;
          _ICBClearMark;
          ptline := _Long2PLine(cy);
          ICB.FirstLine := ptline;
          ICB.FirstX := cx;
          ICB.LastLine := ptline;
          ICB.LastX := cx+Length(s);
          _ICBSetMark;
          GotoLine(cy,cx+dCursPos);
     END
     ELSE SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[16]);
     LastFRD := FR_Find;
END;



PROCEDURE TEditorWindow.ReplaceText(s,s1:STRING; w:WORD); {Ctrl-Q A}
VAR  SForward : BOOLEAN;
     ReplaceAll : BOOLEAN;
     Confirm : BOOLEAN;
     Contin : BOOLEAN;
     Found : BOOLEAN;
     Repl : BOOLEAN;
     cy, cx : LONGWORD;
     resp : LONGWORD;
     dCursPos : WORD;
     ptline : PLine;
     foundmind1 : BOOLEAN;
BEGIN
     {evaluate w flag}
     SForward := w AND FRD_Forward <> 0;
     ReplaceAll := w AND FRD_ReplaceAll <> 0;
     Confirm := w AND FRD_Confirm <> 0;

     aSearchString := s;
     aReplaceString := s1;
     ReplOptions := w;
     Contin := TRUE;
     foundmind1 := FALSE;

     WHILE Contin DO
     BEGIN
          Found := FindTextPos(s,w,cy,cx);
          IF Found THEN
          BEGIN
               foundmind1 := TRUE;
               IF SForward THEN dCursPos := Length(s)
               ELSE dCursPos := 0;
               IF NOT FindICB THEN OldICB := ICB;
               FindICB := TRUE;
               _ICBClearMark;
               ptline := _Long2PLine(cy);
               ICB.FirstLine := ptline;
               ICB.FirstX := cx;
               ICB.LastLine := ptline;
               ICB.LastX := cx+Length(s);
               _ICBSetMark;
               GotoLine(cy,cx+dCursPos);
               IF Confirm THEN
               BEGIN
                    resp := SetQueryMessage(NLSTable[17],NLSTable[18],
                                            MB_YESNOCANCEL OR
                                            MB_MOVEABLE OR MB_QUERY);
                    Repl := FALSE;
                    CASE resp OF
                         MBID_YES    : Repl := TRUE;
                         MBID_CANCEL : Found := FALSE;
                    END;
               END
               ELSE Repl := TRUE;
               IF Repl THEN
               BEGIN
                    (*UNDO*)
                    _CopyUndoLines(ActLine,ActLine);
                    (*UNDO*)
                    _DeleteString(cx,Length(s));
                    IF NOT _InsertString(cx,s1) THEN beep(1000,10);
                    IF SForward THEN dCursPos := Length(s1)
                    ELSE dCursPos := 0;
                    ICB.LastX := cx+Length(s1);
                    _CheckICB;

                    FileCursorX := cx+dCursPos;
                    IF FileCursorX > WinSizeX THEN ScrCursorX := WinSizeX
                    ELSE ScrCursorX := FileCursorX;
                    IF _HorizMove THEN
                    BEGIN
                         UpdateLineColorFlag(ActLine);
                         InvalidateEditorWindow(1);
                    END
                    ELSE InvalidateSingleLine;
                    (*UNDO*)
                   _StoreUndoCursor;
                    (*UNDO*)
               END;
          END
          ELSE
          IF NOT foundmind1 THEN SetErrorMessage(MB_ICONHAND,
                                                 NLSTable[1],NLSTable[16]);
          w := w OR FRD_FromCursor;
          Contin := ReplaceAll AND Found;
     END;
     LastFRD := FR_Replace;
END;



PROCEDURE TEditorWindow.SearchTextAgain; {Ctrl-L}
VAR  OldOpt : WORD;
BEGIN
     IF LastFRD = FR_Replace THEN
     BEGIN
          IF WinReadOnly THEN exit;
          OldOpt := ReplOptions;
          TEditorWindow.ReplaceText(aSearchString,aReplaceString,
                                    ReplOptions OR FRD_FromCursor);
          ReplOptions := OldOpt;
     END;

     IF LastFRD = FR_Find THEN
     BEGIN
          OldOpt := FindOptions;
          TEditorWindow.FindText(aSearchString,FindOptions OR FRD_FromCursor);
          FindOptions := OldOpt;
     END;
END;



FUNCTION TEditorWindow.GotoLine(y,x:LONGWORD):BOOLEAN;
VAR  deltaY : LONGINT;
     i : LONGWORD;
BEGIN
     IF (y < 1) OR (y > CountLines) OR (x < 1) OR (x > Stringlength) THEN
     BEGIN
          GotoLine := FALSE;
          exit;
     END;
     IF WLactivated THEN _WriteWorkLine;
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     (*UNDO*)
     IF x <= WinSizeX THEN ScrCursorX := x
     ELSE ScrCursorX := WinSizeX;
     FileCursorX := x;
     deltaY := y - FileCursorY;
     FileCursorY := y;
     IF (ScrCursorY + deltaY >= 1) AND (ScrCursorY + deltaY <= WinSizeY)
     THEN ScrCursorY := ScrCursorY + deltaY
     ELSE
     BEGIN
          ScrCursorY := WinSizeY DIV 2;
          IF ScrCursorY = 0 THEN ScrCursorY := 1;
          IF y < ScrCursorY THEN ScrCursorY := y;
     END;
     FirstScreenLine := _Long2PLine(y-ScrCursorY+1);
     InvalidateEditorWindow(1);
     ActLine := _Long2PLine(y);
     GotoLine := TRUE;
     (*UNDO*)
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
END;


{ +++ Keyboard-Events ++++++++++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow.DeleteChar;
VAR  newstring : STRING;
     lpl : WORD;
     lwl : WORD;
     P : BYTE;
BEGIN
     IF WinReadOnly THEN exit;
     IF NOT WLactivated THEN _ReadWorkLine;
     IF FileCursorX > Length(WorkLine^) THEN
     BEGIN
          IF ActLine^.next = NIL THEN exit;
          (*UNDO*)
          _CopyUndoLines(ActLine,ActLine^.next);
          UndoEvent[LastUndo].FrameEnd := _PLine2Long(ActLine^.next);
          IF NOT WLactivated THEN _ReadWorkLine;
          (*UNDO*)
          lpl := Length(ActLine^.next^.zk^);
          IF lpl + FileCursorX <= StringLength THEN
          BEGIN
               P := _ICBPos(ActLine^.next,0);
               IF P AND POS_FIRSTICBLINE <> 0 THEN
               BEGIN
                    ICB.FirstLine := ActLine;
                    inc(ICB.FirstX,FileCursorX-1);
                    IF ActLine^.next^.color AND CI_Selected <> 0
                    THEN ActLine^.color := ActLine^.color OR CI_Selected;
               END;
               IF P AND POS_LASTICBLINE <> 0 THEN
               BEGIN
                    ICB.LastLine := ActLine;
                    inc(ICB.LastX,FileCursorX-1);
               END;
               lwl := Length(WorkLine^);
               FillChar(WorkLine^[lwl+1],FileCursorX-lwl-1,32);
               newstring := _ReadString(ActLine^.next,1,lpl);
               _WriteString(FileCursorX,newstring);
               _DeleteLine(ActLine^.next);
          END
          ELSE SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[19]);
          SetSliderValues;
          UpdateLineColorFlag(ActLine);
          InvalidateEditorWindow(ScrCursorY);
          (*UNDO*)
          LastUndoGroup := UG_NoGroup;
          (*UNDO*)
     END
     ELSE
     BEGIN
          (*UNDO*)
          IF LastUndoGroup <> UG_DeleteChar
          THEN _CopyUndoLines(ActLine,ActLine);
          (*UNDO*)
          P := _ICBPos(ActLine,FileCursorX);
          IF P AND POS_BEFOREICBFIRST <> 0 THEN dec(ICB.FirstX);
          IF P AND POS_BEFOREICBLAST <> 0 THEN dec(ICB.LastX);
          _DeleteString(FileCursorX,1);
          InvalidateSingleLine;
          (*UNDO*)
          LastUndoGroup := UG_DeleteChar;
          (*UNDO*)
     END;
     _CheckICB;
END;



PROCEDURE TEditorWindow.BackSpace;
VAR  prevline : PLine;
     oldstring : STRING;
     lpl : WORD;
     P : BYTE;
     CountDel : WORD;
     FNT : WORD;
     ptline : PLine;
BEGIN
     IF WinReadOnly THEN exit;
     IF FileCursorX <= 1 THEN
     BEGIN
          IF ActLine^.prev = NIL THEN exit;
          (*UNDO*)
          _CopyUndoLines(ActLine^.prev,ActLine);
          UndoEvent[LastUndo].FrameEnd := _PLine2Long(ActLine);
          (*UNDO*)
          IF NOT WLactivated THEN _ReadWorkLine;
          oldstring := WorkLine^;
          prevline := ActLine^.prev;
          lpl := Length(prevline^.zk^);
          IF lpl + Length(WorkLine^) <= StringLength THEN
          BEGIN
               P := _ICBPos(ActLine,0);
               IF P AND POS_FIRSTICBLINE <> 0 THEN
               BEGIN
                    ICB.FirstLine := prevline;
                    inc(ICB.FirstX,lpl);
                    IF ActLine^.color AND CI_Selected <> 0
                    THEN prevline^.color := prevline^.color OR CI_Selected;
               END;
               IF P AND POS_LASTICBLINE <> 0 THEN
               BEGIN
                    ICB.LastLine := prevline;
                    inc(ICB.LastX,lpl);
               END;
               IF ScrCursorY > 1 THEN dec(ScrCursorY)
               ELSE FirstScreenLine := prevline;
               dec(FileCursorY);
               ActLine := prevline;
               _ReadWorkLine;
               IgnoreRedraw := TRUE;
               LastUndoGroup := UG_CursorMove; {ignore UNDO}
               CursorEnd;
               IgnoreRedraw := FALSE;
               _WriteString(FileCursorX,oldstring);
               _DeleteLine(ActLine^.next);
               UpdateLineColorFlag(ActLine);
               IF _HorizMove THEN InvalidateEditorWindow(1)
               ELSE InvalidateEditorWindow(ScrCursorY);
               SetSliderValues;
          END
          ELSE SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[19]);
          (*UNDO*)
          LastUndoGroup := UG_NoGroup;
          (*UNDO*)
     END
     ELSE
     BEGIN
          (*UNDO*)
          IF LastUndoGroup <> UG_BackspaceChar
          THEN _CopyUndoLines(ActLine,ActLine);
          (*UNDO*)
          IF WLactivated THEN _WriteWorkLine;
          IF EditOptions AND EOD_Unindent <> 0 THEN
          BEGIN
               IF (_FindNextTab(ActLine,1) >= FileCursorX) OR
                  (Length(ActLine^.zk^) = 0) THEN
               BEGIN
                    ptline := ActLine;
                    REPEAT
                          IF ptline^.prev <> NIL THEN
                          BEGIN
                               ptline := ptline^.prev;
                               FNT := _FindNextTab(ptline,1);
                          END
                          ELSE FNT := 1;
                    UNTIL FNT < FileCursorX;
                    CountDel := FileCursorX-FNT;
               END
               ELSE CountDel := 1;
          END
          ELSE CountDel := 1;

          dec(FileCursorX,CountDel);
          P := _ICBPos(ActLine,FileCursorX);
          IF P AND POS_BEFOREICBFIRST <> 0 THEN
          BEGIN
               IF ICB.FirstX-FileCursorX > CountDel
               THEN dec(ICB.FirstX,CountDel)
               ELSE ICB.FirstX := FileCursorX;
          END;
          IF P AND POS_BEFOREICBLAST <> 0 THEN
          BEGIN
               IF ICB.LastX-FileCursorX > CountDel
               THEN dec(ICB.LastX,CountDel)
               ELSE ICB.LastX := FileCursorX;
          END;
          _DeleteString(FileCursorX,CountDel);
          IF ScrCursorX <= CountDel THEN
          BEGIN
               ScrCursorX := 1;
               UpdateLineColorFlag(ActLine);
               InvalidateEditorWindow(1);
          END
          ELSE
          BEGIN
               dec(ScrCursorX,CountDel);
               InvalidateSingleLine;
          END;
          (*UNDO*)
          LastUndoGroup := UG_BackspaceChar;
          (*UNDO*)
     END;
     _CheckICB;
END;



FUNCTION TEditorWindow._FindNextTab(PL:PLine; CX:WORD):WORD;
VAR  tabvorbild : STRING;
     ptline : PLine;
     NormalTabSize : WORD;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     tabvorbild := '!';
     ptline := PL;
     WHILE ptline <> NIL DO
     BEGIN
          IF Length(ptline^.zk^) <> 0 THEN
          BEGIN
               tabvorbild := ptline^.zk^;
               ptline := NIL;
          END
          ELSE ptline := ptline^.prev;
     END;

     IF (CX = 1) AND (tabvorbild[1] <> ' ') THEN {for ENTER}
     BEGIN
          _FindNextTab := 1;
          exit;
     END;

     NormalTabSize := EditOptions DIV $1000000;
     IF NormalTabSize = 0 THEN NormalTabSize := 8;
     IF CX <= Length(tabvorbild) THEN
     BEGIN
          dec(CX);
          WHILE (tabvorbild[CX] <> ' ') AND (CX <= Length(tabvorbild))
            DO inc(CX);
          WHILE (tabvorbild[CX] = ' ') AND (CX <= Length(tabvorbild))
            DO inc(CX);
     END
     ELSE CX := ((CX DIV NormalTabSize)+1)*NormalTabSize + 1;

     IF CX > StringLength THEN CX := StringLength;
     _FindNextTab := CX;
END;



PROCEDURE TEditorWindow.Tabulator;
VAR  p : WORD;
     i : WORD;
     leerstring : STRING;
     B : BYTE;
BEGIN
     IF WinReadOnly THEN exit;
     (*UNDO*)
     _CopyUndoLines(ActLine,ActLine);
     (*UNDO*)
     p := _FindNextTab(ActLine^.prev,FileCursorX+1); {search from fcx+1}
     leerstring := '';
     FOR i := 1 TO p-FileCursorX DO leerstring := leerstring + ' ';
     IF NOT _InsertString(FileCursorX,leerstring) THEN beep(1000,10);
     B := _ICBPos(ActLine,FileCursorX);
     IF B AND POS_BEFOREICBFIRST <> 0  THEN inc(ICB.FirstX,p-FileCursorX);
     IF B AND POS_BEFOREICBLAST <> 0 THEN inc(ICB.LastX,p-FileCursorX);
     _CheckICB;
     FileCursorX := p;
     IF p > WinSizeX THEN ScrCursorX := WinSizeX
     ELSE ScrCursorX := p;

     IF _HorizMove THEN
     BEGIN
          UpdateLineColorFlag(ActLine);
          InvalidateEditorWindow(1);
     END
     ELSE InvalidateSingleLine;
     (*UNDO*)
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.CarriageReturn;
VAR  newstring : STRING;
     leerstring : STRING;
     i : WORD;
     FNT : WORD;
     NCX : WORD;
     P : BYTE;
     FCX : WORD;
     AL : PLine;
BEGIN
     IF WinReadOnly THEN exit;
     (*UNDO*)
     _CopyUndoLines(ActLine,ActLine);
     (*UNDO*)
     IF NOT WLactivated THEN _ReadWorkLine;

     IF FileCursorX <= Length(WorkLine^) THEN
     BEGIN
          newstring := copy(WorkLine^,FileCursorX,Length(WorkLine^)-FileCursorX+1);
          WorkLine^[0] := chr(FileCursorX-1);
     END
     ELSE newstring := '';
     _WriteWorkLine;

     _InsertLine(ActLine);
     P := _ICBPos(ActLine,FileCursorX);
     FCX := FileCursorX;
     AL := ActLine;
     ActLine := ActLine^.next;
     IF (EditOptions AND EOD_AutoIndentMode) <> 0 THEN
     BEGIN
          leerstring := '';
          IF Length(ActLine^.prev^.zk^) = 0 THEN FNT := FileCursorX
          ELSE
          BEGIN
               FNT := 1;
               WHILE (ActLine^.prev^.zk^[FNT] = ' ') AND
                     (FNT <= Length(ActLine^.prev^.zk^)) DO inc(FNT);
          END;
          FOR i := 1 TO FNT-1 DO leerstring := leerstring + ' ';
          WorkLine^ := leerstring + newstring;
          _WriteWorkLine;

          IF Length(ActLine^.prev^.zk^) = 0 THEN NCX := _FindNextTab(ActLine,1)
          ELSE NCX := _FindNextTab(ActLine^.prev,1);
          FileCursorX := NCX;
          ScrCursorX := NCX;
          IF ScrCursorX > WinSizeX THEN ScrCursorX := WinSizeX;
     END
     ELSE
     BEGIN
          FileCursorX := 1;
          ScrCursorX := 1;
          WorkLine^ := newstring;
          _WriteWorkLine;
          FNT := 1;
     END;
     {update ICB}
     IF P AND POS_BEFOREICBFIRST <> 0 THEN
     BEGIN
          AL^.next^.color := AL^.next^.color OR (AL^.color AND CI_Selected);
          AL^.color := AL^.color AND NOT CI_Selected;
          dec(ICB.FirstX,FCX-1);
          inc(ICB.FirstX,FNT-1);
          ICB.FirstLine := ICB.FirstLine^.next;
     END;
     IF P AND POS_BEFOREICBLAST <> 0 THEN
     BEGIN
          AL^.next^.color := AL^.next^.color OR (AL^.color AND CI_Selected);
          dec(ICB.LastX,FCX-1);
          inc(ICB.LastX,FNT-1);
          ICB.LastLine := ICB.LastLine^.next;
     END;
     IF (P AND POS_AFTERICBFIRST <> 0) OR (P AND POS_INICB <> 0)
     THEN AL^.next^.color := AL^.next^.color OR (AL^.color AND CI_Selected);
     IF P AND POS_AFTERICBLAST  <> 0
     THEN AL^.next^.color := AL^.next^.color AND NOT CI_Selected;

     inc(FileCursorY);
     SetLineColorFlag(ActLine^.prev,ActLine);
     IF ScrCursorY = WinSizeY THEN
     BEGIN
          FirstScreenLine := FirstScreenLine^.next;
          InvalidateEditorWindow(1);
     END
     ELSE
     BEGIN
          inc(ScrCursorY);
          IF _HorizMove THEN InvalidateEditorWindow(1)
          ELSE InvalidateEditorWindow(ScrCursorY-1);
     END;
     SetSliderValues;
     _CheckICB;
     (*UNDO*)
     UndoEvent[LastUndo].FrameEnd := _PLine2Long(ActLine^.next);
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.LineInsert; {Ctrl-N}
VAR  newstring : STRING;
     P : BYTE;
     FCX : WORD;
     AL : PLine;
BEGIN
     IF WinReadOnly THEN exit;
     (*UNDO*)
     _CopyUndoLines(ActLine,ActLine);
     (*UNDO*)
     IF NOT WLactivated THEN _ReadWorkLine;

     IF FileCursorX <= Length(WorkLine^)
     THEN newstring := copy(WorkLine^,FileCursorX,Length(WorkLine^)-FileCursorX+1)
     ELSE newstring := '';
     WorkLine^[0] := chr(FileCursorX-1);
     _WriteWorkLine;

     _InsertLine(ActLine);
     {update ICB}
     P := _ICBPos(ActLine,FileCursorX);
     FCX := FileCursorX;
     AL := ActLine;
     IF P AND POS_BEFOREICBFIRST <> 0 THEN
     BEGIN
          AL^.next^.color := AL^.next^.color OR (AL^.color AND CI_Selected);
          AL^.color := AL^.color AND NOT CI_Selected;
          dec(ICB.FirstX,FCX-1);
          ICB.FirstLine := ICB.FirstLine^.next;
     END;
     IF P AND POS_BEFOREICBLAST <> 0 THEN
     BEGIN
          AL^.next^.color := AL^.next^.color OR (AL^.color AND CI_Selected);
          dec(ICB.LastX,FCX-1);
          ICB.LastLine := ICB.LastLine^.next;
     END;
     IF (P AND POS_AFTERICBFIRST <> 0) OR (P AND POS_INICB <> 0)
     THEN AL^.next^.color := AL^.next^.color OR (AL^.color AND CI_Selected);
     IF P AND POS_AFTERICBLAST  <> 0
     THEN AL^.next^.color := AL^.next^.color AND NOT CI_Selected;

     ActLine := ActLine^.next;
     WorkLine^ := newstring;
     _WriteWorkLine;

     ActLine := ActLine^.prev;
     IF Length(newstring) = 0 THEN
     BEGIN
          LastUndoGroup := UG_CursorMove;
          CursorEnd;
     END;

     SetLineColorFlag(ActLine,ActLine^.next);
     IF (ScrCursorY = WinSizeY) AND (ScrCursorY > 1) THEN
     BEGIN
          dec(ScrCursorY);
          FirstScreenLine := FirstScreenLine^.next;
          InvalidateEditorWindow(1);
     END
     ELSE InvalidateEditorWindow(ScrCursorY);
     SetSliderValues;
     _CheckICB;
     (*UNDO*)
     UndoEvent[LastUndo].FrameEnd := _PLine2Long(ActLine^.next^.next);
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.DeleteLine;
VAR  nextline : PLine;
     prevline : PLine;
     P : BYTE;
BEGIN
     IF WinReadOnly THEN exit;
     IF NOT WLactivated THEN _ReadWorkLine;
     nextline := ActLine^.next;

     P := _ICBPos(ActLine,0);

     IF nextline <> NIL THEN
     BEGIN
          IF FirstScreenLine = ActLine THEN FirstScreenLine := nextline;
          prevline := ActLine^.prev;
          (*UNDO*)
          _MoveUndoLines(ActLine,ActLine);
          _Connect(prevline,nextline);
          UndoEvent[LastUndo].FrameEnd := _PLine2Long(nextline);
          dec(CountLines);
          (*UNDO*)
          SetSliderValues;
          ActLine := nextline;
          WLactivated := FALSE;
     END
     ELSE
     BEGIN
          (*UNDO*)
          _CopyUndoLines(ActLine,ActLine);
          IF NOT WLactivated THEN _ReadWorkLine;
          (*UNDO*)
          WorkLine^ := '';
     END;

     IF P AND POS_FIRSTICBLINE <> 0 THEN
     BEGIN
          IF nextline <> NIL THEN ICB.FirstLine := nextline;
          ICB.FirstX := 1;
     END;
     IF P AND POS_LASTICBLINE <> 0 THEN
     BEGIN
          IF nextline <> NIL THEN ICB.LastLine := nextline;
          ICB.LastX := 1;
     END;

     FileCursorX := 1;
     ScrCursorX := 1;
     Modified := TRUE;
     IF ActLine^.prev <> NIL THEN UpdateLineColorFlag(ActLine^.prev)
     ELSE UpdateLineColorFlag(ActLine);
     IF _HorizMove THEN InvalidateEditorWindow(1)
     ELSE InvalidateEditorWindow(ScrCursorY);
     _ICBSetMark;
     _CheckICB;
     (*UNDO*)
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.DeleteUntilEnd; {Ctrl-Q Y}
VAR  P : BYTE;
BEGIN
     IF WinReadOnly THEN exit;
     (*UNDO*)
     _CopyUndoLines(ActLine,ActLine);
     (*UNDO*)
     Modified := true;
     IF NOT WLactivated THEN _ReadWorkLine;
     WorkLine^[0] := chr(FileCursorX-1);
     _WriteWorkLine;
     P := _ICBPos(ActLine,FileCursorX);
     IF P AND POS_BEFOREICBFIRST <> 0 THEN ICB.FirstX := FileCursorX;
     IF P AND POS_BEFOREICBLAST <> 0 THEN ICB.LastX := FileCursorX;
     InvalidateSingleLine;
     _CheckICB;
     (*UNDO*)
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.DeleteRightWord; {Ctrl-T}
VAR  CX : WORD;
     newstring : STRING;
     P : BYTE;
BEGIN
     IF WinReadOnly THEN exit;
     IF NOT WLactivated THEN _ReadWorkLine;
     CX := 0;
     IF FileCursorX <= Length(WorkLine^) THEN
     BEGIN
          (*UNDO*)
          _CopyUndoLines(ActLine,ActLine);
          IF NOT WLactivated THEN _ReadWorkLine;
          (*UNDO*)
          WHILE (WorkLine^[FileCursorX+CX] IN NormalChars) AND
                (FileCursorX+CX <= Length(WorkLine^)) DO inc(CX);
          IF CX = 0 THEN CX := 1;
          WHILE (WorkLine^[FileCursorX+CX] = ' ') AND
                (FileCursorX+CX <= Length(WorkLine^)) DO inc(CX);
          _DeleteString(FileCursorX,CX);
          _WriteWorkLine;
          P := _ICBPos(ActLine,FileCursorX);
          IF P AND POS_BEFOREICBFIRST <> 0 THEN
          BEGIN
               IF ICB.FirstX-FileCursorX < CX THEN ICB.FirstX := FileCursorX
               ELSE dec(ICB.FirstX,CX);
          END;
          IF P AND POS_BEFOREICBLAST <> 0 THEN
          BEGIN
               IF ICB.LastX-FileCursorX < CX THEN ICB.LastX := FileCursorX
               ELSE dec(ICB.LastX,CX);
          END;
          InvalidateSingleLine;
     END
     ELSE
     BEGIN
          IF ActLine^.next = NIL THEN exit;
          (*UNDO*)
          _CopyUndoLines(ActLine,ActLine^.next);
          IF NOT WLactivated THEN _ReadWorkLine;
          UndoEvent[LastUndo].FrameEnd := _PLine2Long(ActLine^.next);
          (*UNDO*)
          IF FileCursorX + Length(ActLine^.next^.zk^) <= StringLength THEN
          BEGIN
               WorkLine^[0] := chr(FileCursorX-1);
               CX := 1;
               WHILE (ActLine^.next^.zk^[CX] = ' ') AND
                     (CX <= Length(ActLine^.next^.zk^)) DO inc(CX);
               newstring := _ReadString(ActLine^.next,CX,
                                        Length(ActLine^.next^.zk^)-CX+1);
               _WriteString(FileCursorX,newstring);
               P := _ICBPos(ActLine^.next,0);
               dec(CX);      {CX count of deletable ' '}
               IF P AND POS_FIRSTICBLINE <> 0 THEN
               BEGIN
                    ICB.FirstLine := ActLine;
                    inc(ICB.FirstX,FileCursorX-1);
                    IF ICB.FirstX-FileCursorX < CX
                    THEN ICB.FirstX := FileCursorX
                    ELSE dec(ICB.FirstX,CX);
               END;
               IF P AND POS_LASTICBLINE <> 0 THEN
               BEGIN
                    ICB.LastLine := ActLine;
                    inc(ICB.LastX,FileCursorX-1);
                    IF ICB.LastX-FileCursorX < CX
                    THEN ICB.LastX := FileCursorX
                    ELSE dec(ICB.LastX,CX);
               END;
               _DeleteLine(ActLine^.next);
               SetSliderValues;
          END
          ELSE SetErrorMessage(MB_ICONHAND,NLSTable[1],NLSTable[19]);
          UpdateLineColorFlag(ActLine);
          InvalidateEditorWindow(ScrCursorY);
     END;
     {_ICBSetMark;}
     _CheckICB;
     (*UNDO*)
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.ToggleInsertMode;
VAR  r:LONGWORD;
     cux,cuy:WORD;
BEGIN
     EditOptions := EditOptions XOR EOD_InsertMode;
     IF (EditOptions AND EOD_InsertMode) <> 0 THEN r := 2
     ELSE r:=CharHeight;
     WinDestroyCursor(HWindow);
     WinCreateCursor(HWindow,40,40,CharWidth,r,4,NIL);
     cux:=2+((ScrCursorX-1)*CharWidth);
     cuy:=WindowRect.yTop-(ScrCursorY*CharHeight);
     dec(cuy,CharBaseLine);
     WinCreateCursor(HWindow,cux,cuy,CharWidth,2,$8004,NIL);
     WinStartTimer(HInstance,HWindow,TID_CURSOR,CursorRate);
     WinShowCursor(HWindow,TRUE);
     UpdateEditorStatus;
END;



PROCEDURE TEditorWindow.ToggleICBVisibility;
BEGIN
     ICBVisible := NOT ICBVisible;
     IF ICBVisible THEN EnableCopyCut
     ELSE DisableCopyCut;
     InvalidateEditorWindow(1);
END;


{ +++ CursorMove-Events ++++++++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow.CursorDown(rep:WORD);
VAR  t : WORD;
     ToScroll : WORD;
     maxrep : WORD;
BEGIN
     IF WinSizeY = 0 THEN exit;
     IF FileCursorY = CountLines THEN exit;
     IF WLactivated THEN _WriteWorkLine;
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     (*UNDO*)

     maxrep := (WinSizeY SHR 1) + 1;
     IF rep > maxrep THEN rep := maxrep;
     IF FileCursorY + rep > CountLines THEN rep := CountLines - FileCursorY;

     inc(FileCursorY,rep);
     FOR t := 1 TO rep DO ActLine := ActLine^.next;
     IF ScrCursorY + rep > WinSizeY THEN {ScrollDown}
     BEGIN
          ToScroll := (ScrCursorY+rep) - WinSizeY;
          ScrCursorY := WinSizeY;
          FOR t := 1 TO ToScroll DO FirstScreenLine := FirstScreenLine^.next;
          InvalidateEditorWindow(1);
     END
     ELSE
     BEGIN
          inc(ScrCursorY,rep);
          SetCursorXY;
     END;
     (*UNDO*)
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.CursorUp(rep:WORD);
VAR  t : WORD;
     ToScroll : WORD;
     maxrep : WORD;
BEGIN
     IF WinSizeY = 0 THEN exit;
     IF FileCursorY = 1 THEN exit;
     IF WLactivated THEN _WriteWorkLine;
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     (*UNDO*)

     maxrep := (WinSizeY SHR 1) + 1;
     IF rep > maxrep THEN rep := maxrep;
     IF FileCursorY <= rep THEN rep := FileCursorY-1;

     dec(FileCursorY,rep);
     FOR t := 1 TO rep DO ActLine := ActLine^.prev;
     IF rep >= ScrCursorY THEN {ScrollUp}
     BEGIN
          ToScroll := rep - ScrCursorY + 1;
          ScrCursorY := 1;
          FOR t := 1 TO ToScroll DO FirstScreenLine := FirstScreenLine^.prev;
          InvalidateEditorWindow(1);
     END
     ELSE
     BEGIN
          dec(ScrCursorY,rep);
          SetCursorXY;
     END;
     (*UNDO*)
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.CursorRight;
BEGIN
     IF FileCursorX < StringLength THEN
     BEGIN
          (*UNDO*)
          IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
          (*UNDO*)
          inc(FileCursorX);
          IF ScrCursorX < WinSizeX THEN
          BEGIN
               inc(ScrCursorX);
               SetCursorXY;
          END
          ELSE InvalidateEditorWindow(1);
          (*UNDO*)
          LastUndoGroup := UG_CursorMove;
          (*UNDO*)
     END;
END;



PROCEDURE TEditorWindow.CursorLeft;
BEGIN
     IF FileCursorX > 1 THEN
     BEGIN
          (*UNDO*)
          IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
          (*UNDO*)
          dec(FileCursorX);
          IF ScrCursorX > 1 THEN
          BEGIN
               dec(ScrCursorX);
               SetCursorXY;
          END
          ELSE InvalidateEditorWindow(1);
          (*UNDO*)
          LastUndoGroup := UG_CursorMove;
          (*UNDO*)
     END;
END;



PROCEDURE TEditorWindow.PageDown;
VAR  i : INTEGER;
BEGIN
     IF FileCursorY < CountLines THEN
     BEGIN
          (*UNDO*)
          IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
          (*UNDO*)
          IF WLactivated THEN _WriteWorkLine;
          FOR i := 1 TO WinSizeY-1 DO
          BEGIN
               IF ActLine^.next <> NIL THEN
               BEGIN
                    {SrollDown}
                    ActLine := ActLine^.next;
                    FirstScreenLine := FirstScreenLine^.next;
                    inc(FileCursorY);
               END;
          END;
          InvalidateEditorWindow(1);
          (*UNDO*)
          LastUndoGroup := UG_CursorMove;
          (*UNDO*)
     END;
END;



PROCEDURE TEditorWindow.PageUp;
VAR  i : INTEGER;
BEGIN
     IF FileCursorY > 1 THEN
     BEGIN
          (*UNDO*)
          IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
          (*UNDO*)
          IF WLactivated THEN _WriteWorkLine;
          FOR i := 1 TO WinSizeY-1 DO
          BEGIN
               IF FirstScreenLine^.prev <> NIL THEN
               BEGIN
                    {ScrollUp}
                    ActLine := ActLine^.prev;
                    FirstScreenLine := FirstScreenLine^.prev;
                    dec(FileCursorY);
               END
               ELSE
               BEGIN
                    IF ActLine^.prev <> NIL THEN
                    BEGIN
                         {JumpUp}
                         ActLine := ActLine^.prev;
                         dec(FileCursorY);
                         dec(ScrCursorY);
                    END;
               END;
          END;
          InvalidateEditorWindow(1);
          (*UNDO*)
          LastUndoGroup := UG_CursorMove;
          (*UNDO*)
     END;
END;



PROCEDURE TEditorWindow.RollUp; {Ctrl-W}
BEGIN
     IF WinSizeY = 0 THEN exit;
     IF WLactivated THEN _WriteWorkLine;
     IF FirstScreenLine^.Prev <> NIL THEN
     BEGIN
          (*UNDO*)
          IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
          (*UNDO*)
          FirstScreenLine := FirstScreenLine^.Prev;
          IF ScrCursorY >= WinSizeY THEN
          BEGIN
               ActLine := ActLine^.Prev;
               dec(FileCursorY);
          END
          ELSE inc(ScrCursorY);
          InvalidateEditorWindow(1);
          (*UNDO*)
          LastUndoGroup := UG_CursorMove;
          (*UNDO*)
     END;
END;



PROCEDURE TEditorWindow.RollDown; {Ctrl-Z}
BEGIN
     IF WinSizeY = 0 THEN exit;
     IF WLactivated THEN _WriteWorkLine;
     IF ActLine^.Next <> NIL THEN
     BEGIN
          (*UNDO*)
         IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
          (*UNDO*)
          FirstScreenLine := FirstScreenLine^.Next;
          IF ScrCursorY <= 1 THEN
          BEGIN
               ActLine := ActLine^.Next;
               inc(FileCursorY);
          END
          ELSE dec(ScrCursorY);
          InvalidateEditorWindow(1);
          (*UNDO*)
          LastUndoGroup := UG_CursorMove;
          (*UNDO*)
     END;
END;



PROCEDURE TEditorWindow.CursorPos1;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     (*UNDO*)
     FileCursorX := 1;
     ScrCursorX := 1;
     IF _HorizMove THEN InvalidateEditorWindow(1)
     ELSE SetCursorXY;
     (*UNDO*)
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.CursorEnd;
VAR  LastChar : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     (*UNDO*)
     IF WLactivated THEN _WriteWorkLine;
     LastChar := Length(ActLine^.zk^)+1;
     IF LastChar > StringLength THEN LastChar := StringLength;

     FileCursorX := LastChar;
     IF LastChar <= WinSizeX THEN ScrCursorX := LastChar
     ELSE ScrCursorX := WinSizeX;

     IF _HorizMove THEN InvalidateEditorWindow(1)
     ELSE SetCursorXY;
     (*UNDO*)
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.WordRight; {Ctrl-F}
VAR  ptline : PLine;
     scroll : BOOLEAN;
     i,dFCY : LONGWORD;
     FCX : WORD;
     CC : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     (*UNDO*)
     IF WLactivated THEN _WriteWorkLine;
     scroll := FALSE;
     IF FileCursorX > Length(ActLine^.zk^) THEN
     BEGIN
          ptline := ActLine^.next;
          IF ptline = NIL THEN
          BEGIN
               CursorEnd;
               exit;
          END;
          FileCursorX := 1;
          ScrCursorX := 1;
          dFCY := 0;
          CC := 0;
          WHILE (ptline <> NIL) AND (CC = 0) DO
          BEGIN
               inc(dFCY);
               IF Length(ptline^.zk^) = 0 THEN ptline := ptline^.next
               ELSE CC := 1; {line with <> '' found}
          END;

          FOR i := 1 TO dFCY DO
          BEGIN
               ActLine := ActLine^.next;
               inc(FileCursorY);
               IF ScrCursorY = WinSizeY THEN
               BEGIN
                    FirstScreenLine := FirstScreenLine^.next;
                    scroll := TRUE;
               END
               ELSE inc(ScrCursorY);
          END;
     END
     ELSE CC := 2;  {next word in the same line}

     FCX := 0;
     IF ((CC=1) AND NOT (ActLine^.zk^[1] IN NormalChars)) OR (CC = 2) THEN
     BEGIN
          WHILE (ActLine^.zk^[FileCursorX+FCX] IN NormalChars) AND
                (FileCursorX+FCX <= Length(ActLine^.zk^)) DO inc(FCX);
          WHILE (NOT (ActLine^.zk^[FileCursorX+FCX] IN NormalChars)) AND
                (FileCursorX+FCX <= Length(ActLine^.zk^)) DO inc(FCX);
     END;

     FileCursorX := FileCursorX+FCX;
     IF FileCursorX > StringLength THEN FileCursorX := StringLength;
     ScrCursorX := ScrCursorX+FCX;
     IF ScrCursorX > WinSizeX THEN ScrCursorX := WinSizeX;

     IF scroll OR _HorizMove THEN InvalidateEditorWindow(1)
     ELSE SetCursorXY;
     (*UNDO*)
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.WordLeft; {Ctrl-A}
VAR  ptline : PLine;
     scroll : BOOLEAN;
     i,dFCY : LONGWORD;
     FCX : WORD;
     CC : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     (*UNDO*)
     IF WLactivated THEN _WriteWorkLine;
     scroll := FALSE;
     IF FileCursorX > Length(ActLine^.zk^)+1 THEN CursorEnd;
     IF FileCursorX > 1 THEN
     BEGIN
          CC := 0;
          FCX := 1;
          IF NOT (ActLine^.zk^[FileCursorX-FCX] IN NormalChars) THEN
            WHILE (NOT (ActLine^.zk^[FileCursorX-FCX] IN NormalChars)) AND
                  (FileCursorX-FCX  > 0) DO inc(FCX);
          IF FileCursorX-FCX = 0 THEN CC := 1;

          WHILE (ActLine^.zk^[FileCursorX-FCX] IN NormalChars) AND
                (FileCursorX-FCX > 0) DO inc(FCX);

          FileCursorX := FileCursorX-FCX+1;
          IF FCX > ScrCursorX THEN ScrCursorX := 1
          ELSE ScrCursorX := ScrCursorX-FCX+1;
     END
     ELSE CC := 1; {mind. 1 line up}

     IF CC = 1 THEN
     BEGIN
          ptline := ActLine^.prev;
          IF ptline = NIL THEN
          BEGIN
               CursorPos1;
               exit;
          END;
          dFCY := 0;
          WHILE (ptline <> NIL) DO
          BEGIN
               inc(dFCY);
               IF Length(ptline^.zk^) = 0 THEN ptline := ptline^.prev
               ELSE ptline := NIL; {line with <> '' found}
          END;

          FOR i := 1 TO dFCY DO
          BEGIN
               ActLine := ActLine^.prev;
               dec(FileCursorY);
               IF ScrCursorY = 1 THEN
               BEGIN
                    FirstScreenLine := FirstScreenLine^.prev;
                    scroll := TRUE;
               END
               ELSE dec(ScrCursorY);
          END;
          CursorEnd;
     END;

     IF scroll OR _HorizMove THEN InvalidateEditorWindow(1)
     ELSE SetCursorXY;
     (*UNDO*)
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
END;



PROCEDURE TEditorWindow.GotoBegin;
BEGIN
     GotoLine(1,1);
END;



PROCEDURE TEditorWindow.GotoEnd;
BEGIN
     GotoLine(CountLines,1);
     CursorEnd;
END;



PROCEDURE TEditorWindow.PageHome;
BEGIN
     GotoLine(FileCursorY-ScrCursorY+1,FileCursorX);
END;



PROCEDURE TEditorWindow.PageEnd;
BEGIN
     GotoLine(FileCursorY+WinSizeY-ScrCursorY,FileCursorX);
END;


{ +++ CUA Procedures +++++++++++++++++++++++++++++++++++++++++++++++++++++++ }


FUNCTION TEditorWindow._CuaICBPresent:BOOLEAN;
BEGIN
     _CuaICBPresent := FALSE;
     IF (ICB.FirstLine = NIL) OR (ICB.LastLine = NIL) THEN exit;
     IF (ICB.FirstLine = ICB.LastLine) AND (ICB.FirstX = ICB.LastX)
     THEN exit;
     _CuaICBPresent := TRUE;
END;



PROCEDURE TEditorWindow._CuaClearMark;
BEGIN
     _ICBClearMark;
     ICB.FirstLine := NIL;
     ICB.LastLine := NIL;
     _CheckICB;
END;



PROCEDURE TEditorWindow._CuaOverWriteBlock;
VAR  FrameFirst : PLine;
     FrameLast  : PLine;
     firststring : STRING;
     laststring : STRING;
     cl : LONGWORD;
BEGIN
     IF WinReadOnly THEN exit;
     IgnoreRedraw := TRUE;
     ICBGotoBegin;

     firststring := _ReadString(ICB.FirstLine,1,ICB.FirstX-1);
     laststring := _ReadString(ICB.LastLine,ICB.LastX,
                               Length(ICB.LastLine^.zk^)-ICB.LastX+1);

     FrameFirst := ICB.FirstLine^.prev;
     FrameLast := ICB.LastLine^.next;
     (*UNDO*)
     cl := _MoveUndoLines(ICB.FirstLine,ICB.LastLine);
     (*UNDO*)
     _Connect(FrameFirst,FrameLast);
     dec(countlines,cl);
     Modified := TRUE;

     _InsertLine(FrameFirst);
     IF FrameFirst = NIL THEN ActLine := FirstLine
     ELSE ActLine := FrameFirst^.next;
     IF ScrCursorY = 1 THEN FirstScreenLine := ActLine;
     WorkLine^ := firststring + laststring;
     _WriteWorkLine;

     ICB.FirstLine := ActLine;
     ICB.FirstX := FileCursorX;
     ICB.LastLine := ActLine;
     ICB.LastX := FileCursorX;
     _CheckICB;

     IgnoreRedraw := FALSE;
     SetSliderValues;
     IF FrameFirst <> NIL THEN SetLineColorFlag(FrameFirst,ActLine)
     ELSE UpdateLineColorFlag(ActLine);
     (*UNDO*)
     UndoEvent[LastUndo].FrameEnd := _PLine2Long(FrameLast);
     LastUndoGroup := UG_NoGroup;
     (*UNDO*)
     ICB.FirstLine := NIL;
     ICB.LastLine := NIL;
END;



PROCEDURE TEditorWindow.CuaCursorDown(rep:WORD);
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          CursorDown(rep);
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE CursorDown(rep);
END;



PROCEDURE TEditorWindow.CuaCursorUp(rep:WORD);
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          CursorUp(rep);
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE CursorUp(rep);
END;



PROCEDURE TEditorWindow.CuaCursorRight;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          CursorRight;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE CursorRight;
END;



PROCEDURE TEditorWindow.CuaCursorLeft;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          CursorLeft;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE CursorLeft;
END;



PROCEDURE TEditorWindow.CuaPageDown;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          PageDown;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE PageDown;
END;



PROCEDURE TEditorWindow.CuaPageUp;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          PageUp;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE PageUp;
END;



PROCEDURE TEditorWindow.CuaCursorPos1;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          CursorPos1;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE CursorPos1;
END;



PROCEDURE TEditorWindow.CuaCursorEnd;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          CursorEnd;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE CursorEnd;
END;



PROCEDURE TEditorWindow.CuaWordRight;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          WordRight;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE WordRight;
END;



PROCEDURE TEditorWindow.CuaWordLeft;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          WordLeft;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE WordLeft;
END;



PROCEDURE TEditorWindow.CuaGotoBegin;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          GotoBegin;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE GotoBegin;
END;



PROCEDURE TEditorWindow.CuaGotoEnd;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          GotoEnd;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE GotoEnd;
END;



PROCEDURE TEditorWindow.CuaPageHome;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          PageHome;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE PageHome;
END;



PROCEDURE TEditorWindow.CuaPageEnd;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          PageEnd;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE PageEnd;
END;



PROCEDURE TEditorWindow.CuaDeleteChar;
BEGIN
     IF _CuaICBPresent THEN ICBDeleteBlock
     ELSE DeleteChar;
END;



PROCEDURE TEditorWindow.CuaBackSpace;
BEGIN
     IF _CuaICBPresent THEN ICBDeleteBlock
     ELSE BackSpace;
END;



PROCEDURE TEditorWindow.CuaRollUp;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          RollUp;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE RollUp;
END;



PROCEDURE TEditorWindow.CuaRollDown;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          RollDown;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE RollDown;
END;



PROCEDURE TEditorWindow.CuaTabulator;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          IgnoreRedraw := TRUE;
          Tabulator;
          IgnoreRedraw := FALSE;
          _CuaClearMark;
          InvalidateEditorWindow(1);
     END
     ELSE Tabulator;
END;


PROCEDURE TEditorWindow.CuaCarriageReturn;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          _CuaOverWriteBlock;
          IgnoreRedraw := TRUE;
          CarriageReturn;
          IgnoreRedraw := FALSE;
          InvalidateEditorWindow(1);
     END
     ELSE CarriageReturn;
END;



PROCEDURE TEditorWindow.CuaPasteFromClipBoard;
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          _CuaOverWriteBlock;
          IgnoreRedraw := TRUE;
          PasteFromClipBoard;
          IgnoreRedraw := FALSE;
          InvalidateEditorWindow(1);
     END
     ELSE PasteFromClipBoard;
END;



PROCEDURE TEditorWindow.CuaPasteFromFile(s:STRING);
BEGIN
     IF _CuaICBPresent THEN
     BEGIN
          _CuaOverWriteBlock;
          IgnoreRedraw := TRUE;
          PasteFromFile(s);
          IgnoreRedraw := FALSE;
          InvalidateEditorWindow(1);
     END
     ELSE PasteFromFile(s);
END;


{ +++ Normal Keyboard-Events +++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow.HandleCharEvent(Win:HWND;param,Rep:WORD);
VAR  P : BYTE;
     ch : CHAR;
BEGIN
     IF FindICB THEN
     BEGIN
          _ICBClearMark;
          ICB := OldICB;
          _ICBSetMark;
          InvalidateEditorWindow(1);
          FindICB := FALSE;
     END;

     IF IsWindowMinimized(HWindowFrame) THEN exit;
     ch := chr(Lo(param));
     IF PreCtrl > 0 THEN
     BEGIN
          param := ord(upcase(ch));
          HandleScanEvent(Win,param,Rep);
          exit;
     END;
     IF WinReadOnly THEN exit;

     IF (EditOptions AND EOD_UseCUA <> 0) AND _CuaICBPresent THEN
     BEGIN
          _CuaOverWriteBlock;
          InvalidateEditorWindow(1);
     END;
     IF (EditOptions AND EOD_InsertMode) <> 0 THEN
     BEGIN
          (*UNDO*)
          IF LastUndoGroup <> UG_InsertChar
          THEN _CopyUndoLines(ActLine,ActLine);
          LastUndoGroup := UG_InsertChar;
          (*UNDO*)
          IF NOT _InsertString(FileCursorX,ch) THEN beep(1000,10);
          P := _ICBPos(ActLine,FileCursorX);
          IF P AND POS_BEFOREICBFIRST <> 0 THEN inc(ICB.FirstX);
          IF P AND POS_BEFOREICBLAST <> 0 THEN inc(ICB.LastX);
          _CheckICB;
     END
     ELSE
     BEGIN
          (*UNDO*)
          IF LastUndoGroup <> UG_OverwriteChar
          THEN _CopyUndoLines(ActLine,ActLine);
          LastUndoGroup := UG_OverwriteChar;
          (*UNDO*)
          IF NOT _WriteString(FileCursorX,ch) THEN beep(1000,10);
     END;

     {Cursor Right}
     IF FileCursorX < StringLength THEN inc(FileCursorX);
     IF ScrCursorX < WinSizeX THEN
     BEGIN
          inc(ScrCursorX);
          InvalidateSingleLine;
     END
     ELSE
     BEGIN
          UpdateLineColorFlag(ActLine);
          InvalidateEditorWindow(1);
     END;
END;


{ +++ special Keyboard-Events ++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow.HandleScanEvent(Win:HWND;param,Rep:WORD);
VAR  Scan : LONGWORD;
LABEL l;
BEGIN
     IF FindICB THEN
     BEGIN
          _ICBClearMark;
          ICB := OldICB;
          _ICBSetMark;
          InvalidateEditorWindow(1);
          FindICB := FALSE;
     END;

     IF IsWindowMinimized(HWindowFrame) THEN
     BEGIN
          IF param IN [kbCR,kbEnter]
          THEN WinSetWindowPos(HWindowFrame,HWND_TOP,0,0,0,0,
                               SWP_RESTORE OR SWP_ACTIVATE OR SWP_SHOW);
          exit;
     END;

     Scan := PreCtrl OR param;
     IF (param <> kbCtrl) AND (param <> kbShift) THEN PreCtrl := 0;

     IF EditOptions AND EOD_UseCUA <> 0 THEN
     BEGIN
          CASE Scan OF
              kbCUp                 : CuaCursorUp(Rep);
              kbCDown               : CuaCursorDown(Rep);
              kbCLeft               : CuaCursorLeft;
              kbCRight              : CuaCursorRight;
              kbPageUp              : CuaPageUp;
              kbPageDown            : CuaPageDown;
              kbPos1                : CuaCursorPos1;
              kbEnd                 : CuaCursorEnd;
              kbCtrlCRight          : CuaWordRight;
              kbCtrlCLeft           : CuaWordLeft;
              kbCtrlPageUp          : CuaPageHome;
              kbCtrlPageDown        : CuaPageEnd;
              kbCtrlPos1            : CuaGotoBegin;
              kbCtrlEnd             : CuaGotoEnd;

              kbBS                  : CuaBackSpace;
              kbDel                 : CuaDeleteChar;
              kbTab                 : CuaTabulator;
              kbCR, kbEnter         : CuaCarriageReturn;

              kbCtrlS               : FindText(aSearchString,FRD_Forward);
              kbCtrlR               : ReplaceText(aSearchString,aReplaceString,
                                                  FRD_Forward);
              kbCtrlN               : SearchTextAgain;

              kbShiftInsert         : CuaPasteFromClipBoard;
              kbCtrlBS              : DeleteLine;
              kbCtrlF7              : ICBMoveLeft;
              kbCtrlF8              : ICBMoveRight;
              ELSE goto l;
          END;
     END
     ELSE
     BEGIN
          CASE Scan OF
              kbCUp, kbCtrlE        : CursorUp(Rep);
              kbCDown, kbCtrlX      : CursorDown(Rep);
              kbCLeft, kbCtrlS      : CursorLeft;
              kbCRight, kbCtrlD     : CursorRight;
              kbPageUp, kbCtrlR     : PageUp;
              kbPageDown, kbCtrlC   : PageDown;
              kbCtrlW               : RollUp;
              kbCtrlZ               : RollDown;
              kbPos1, kbCtrlQS      : CursorPos1;
              kbEnd, kbCtrlQD       : CursorEnd;
              kbCtrlCRight, kbCtrlF : WordRight;
              kbCtrlCLeft, kbCtrlA  : WordLeft;
              kbCtrlPageUp,kbCtrlQR : GotoBegin;
              kbCtrlPageDown,
              kbCtrlQC              : GotoEnd;
              kbCtrlPos1,kbCtrlQE   : PageHome;
              kbCtrlEnd,kbCtrlQX    : PageEnd;

              kbCtrlV       : ToggleInsertMode;
              kbCtrlOI      : EditOptions := EditOptions XOR EOD_AutoIndentMode;
              kbBS, kbCtrlH : BackSpace;
              kbDel,kbCtrlG : DeleteChar;
              kbtab,kbCtrlI : Tabulator;
              kbCR, kbEnter : CarriageReturn;
              kbCtrlY       : DeleteLine;
              kbCtrlN       : LineInsert;
              kbCtrlQY      : DeleteUntilEnd;
              kbCtrlT       : DeleteRightWord;

              kbCtrlQF      : FindText(aSearchString,FRD_Forward);
              kbCtrlQA      : ReplaceText(aSearchString,aReplaceString,
                                          FRD_Forward);
              kbCtrlL       : SearchTextAgain;

              kbCtrlKB      : ICBSetBegin;
              kbCtrlKK      : ICBSetEnd;
              kbCtrlKT      : ICBSelectWord;
              kbCtrlKL      : ICBSelectLine;
              kbCtrlQB      : ICBGotoBegin;
              kbCtrlQK      : ICBGotoEnd;
              kbCtrlKC      : ICBCopyBlock;
              kbCtrlKV      : ICBMoveBlock;
              kbCtrlKY      : ICBDeleteBlock;
              kbCtrlKR      : ICBReadBlock;
              kbCtrlKW      : ICBWriteBlock;
              kbCtrlKU      : ICBMoveLeft;
              kbCtrlKI      : ICBMoveRight;
              kbCtrlShiftPageUp  : ICBExtFileBegin;
              kbCtrlShiftPageDown: ICBExtFileEnd;

              kbCtrlKS      : SaveFile;
              kbCtrlKH      : ToggleICBVisibility;
              kbShiftInsert : PasteFromClipBoard;
              ELSE goto l;
          END;
     END;
     exit;
l:
     CASE Scan OF
         kbCtrlDel          : ICBDeleteBlock;
         kbCtrlInsert       : CopyToClipBoard;
         kbShiftDel         : CutToClipBoard;

         kbShiftCLeft       : ICBExtLeft;
         kbShiftCRight      : ICBExtRight;
         kbShiftCUp         : ICBExtUp;
         kbShiftCDown       : ICBExtDown;
         kbShiftPageUp      : ICBExtPageUp;
         kbShiftPageDown    : ICBExtPageDown;
         kbShiftPos1        : ICBExtPos1;
         kbShiftEnd         : ICBExtEnd;
         kbCtrlShiftCLeft   : ICBExtWordLeft;
         kbCtrlShiftCRight  : ICBExtWordRight;
         kbCtrlShiftPos1    : ICBExtFileBegin;
         kbCtrlShiftEnd     : ICBExtFileEnd;

         kbInsert           : ToggleInsertMode;
         kbF2               : SaveFile;
         kbAltBS            : Undo;
         kbShiftAltBS       : Redo;

         kbCtrlSlash        : ICBSelectAll;
         kbCtrlBackSlash    : ICBDeselectAll;

         kbCtrlK0..kbCtrlK9 : SetBookMark(Scan);
         kbCtrlQ0..kbCtrlQ9 : GotoBookMark(Scan);
         kbCtrlU0..kbCtrlU9 : DeleteBookMark(Scan);
         kbCtrlUU           : DeleteAllBookMarks;

         kbCtrlK            : PreCtrl := kbPreCtrlK;
         kbCtrlQ            : PreCtrl := kbPreCtrlQ;
         kbCtrlO            : PreCtrl := kbPreCtrlO;
         kbCtrlB            : PreCtrl := kbPreCtrlB;
         kbCtrlU            : PreCtrl := kbPreCtrlU;
     END;
END;


{ +++ BookMark Events ++++++++++++++++++++++++++++++++++++++++++++++++++++++ }


FUNCTION TEditorWindow._FindBookMark(BM:WORD):PLine;
VAR  ptline : PLine;
     w : WORD;
BEGIN
     ptline := FirstLine;
     WHILE ptline <> NIL DO
     BEGIN
          w := ptline^.color AND Mask4MSB;  {mask 4 MSB}
          IF w = BM THEN
          BEGIN
               _FindBookMark := ptline;
               exit;
          END;
          ptline := ptline^.next;
     END;
     _FindBookMark := NIL;
END;


PROCEDURE TEditorWindow.GotoBookMark(Scan:LONGWORD);
VAR  ptline : PLine;
     BM,Nr : WORD;
     cy : LONGWORD;
BEGIN
     Nr := (Scan AND 255) - 47;
     BM := Nr * BM_0;
     ptline := _FindBookMark(BM);
     IF ptline = NIL THEN exit;
     cy := _PLine2Long(ptline);
     GotoLine(cy,BookMarkColumn[Nr]);
END;


PROCEDURE TEditorWindow.SetBookMark(Scan:LONGWORD);
VAR  ptline : PLine;
     BM,Nr : WORD;
BEGIN
     Nr := (Scan AND 255) - 47;
     BM := Nr * BM_0;
     ptline := _FindBookMark(BM);
     IF ptline <> NIL THEN ptline^.color := ptline^.color AND (BM_0 - 1);
     Actline^.color := Actline^.color AND (BM_0 - 1);
     ActLine^.color := ActLine^.color OR BM;
     IF Nr < 10 THEN BookMarkColumn[Nr] := FileCursorX;
     InvalidateEditorWindow(1);
END;


PROCEDURE TEditorWindow.DeleteBookMark(Scan:LONGWORD);
VAR  ptline : PLine;
     BM,Nr : WORD;
BEGIN
     Nr := (Scan AND 255) - 47;
     BM := Nr * BM_0;
     ptline := _FindBookMark(BM);
     IF ptline = NIL THEN exit;
     ptline^.color := ptline^.color AND (BM_0 - 1);
     InvalidateEditorWindow(1);
END;


PROCEDURE TEditorWindow.DeleteAllBookMarks;
VAR  ptline : PLine;
BEGIN
     ptline := FirstLine;
     WHILE ptline <> NIL DO
     BEGIN
          ptline^.color := ptline^.color AND (BM_0 - 1);
          ptline := ptline^.next;
     END;
     InvalidateEditorWindow(1);
END;


{ +++ Mouse-Events +++++++++++++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE GetPosFromMaus(pt:POINTS; WinRect:RECTL; VAR ret:POINTS);
BEGIN
     pt.x := pt.x DIV CharWidth;
     pt.y := (WinRect.yTop - pt.y - CharBaseLine) DIV CharHeight;
     inc(pt.x);
     inc(pt.y);
     ret := pt;
END;



PROCEDURE TEditorWindow.SetEditorPtr(id,res:LONGWORD);
VAR  Ptr:LONGWORD;
BEGIN
     Ptr:=WinLoadPointer(HWND_DESKTOP,res,id);
     IF Ptr<>0 THEN NewEditorPtr:=Ptr;
END;



PROCEDURE TEditorWindow.WMSetFocus(VAR Msg:TMessage); {Set Input focus}
VAR  r : LONGWORD;
     SRE : WORD;
BEGIN
     IF (EditOptions AND EOD_InsertMode) <> 0 THEN r := 2
     ELSE r := CharHeight;
     IF Msg.Param2 <> 0 THEN {Window is becoming focus}
     BEGIN
          WinCreateCursor(Msg.Receiver,40,40,CharWidth,r,4,NIL);
          WinStartTimer(HInstance,HWindow,TID_CURSOR,CursorRate);
          WinShowCursor(Msg.Receiver,TRUE);
          SRE := RedoEvents;
          SetCursorXY;
          RedoEvents := SRE;
          _CheckICB;
          IF WinOpenClipBrd(AppHandle) THEN
          BEGIN
               IF WinQueryClipBrdData(AppHandle,CF_TEXT) = 0
               THEN DisablePaste
               ELSE EnablePaste;
               WinCloseClipBrd(AppHandle);
          END
          ELSE DisablePaste;
          IF UndoEvents = 0 THEN DisableUndo
          ELSE EnableUndo;
          IF RedoEvents = 0 THEN DisableRedo
          ELSE EnableRedo;
          PreCtrl := 0;
     END
     ELSE {Window is loosing focus}
     BEGIN
          WinDestroyCursor(Msg.Receiver);
     END;
     Msg.Handled:=TRUE;
     Msg.result:=0;
END;



PROCEDURE TEditorWindow.WMButton1DBLCLK(VAR Msg:TMessage);
BEGIN
     ICBSelectLine;
END;



PROCEDURE TEditorWindow.WMMouseMove(VAR Msg:TMessage);
BEGIN
     Inherited.WMMouseMove(Msg);
     IF NewEditorPtr <> 0 THEN WinSetPointer(HWND_DESKTOP,NewEditorPtr);
     Msg.Handled := TRUE;
     Msg.result := 0;
END;



PROCEDURE TEditorWindow.WMButton1Down(VAR Msg:TMessage);
VAR  pt : POINTS;
     lpt : POINTS;
     t : WORD;
     FCX : WORD;
BEGIN
     Inherited.WMButton1Down(Msg);
     Capture(FALSE);
     IF WinQueryFocus(HWND_DESKTOP) <> HWindow THEN
     BEGIN
          WindowToTop;
          Focus;
          Enable;
          WindowGetFocus := TRUE;
          exit;
     END
     ELSE WindowGetFocus := FALSE;

     FindICB := FALSE;

     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)

     IF WLactivated THEN _WriteWorkLine;
     pt := POINTS(Msg.Param1);
     GetPosFromMaus(pt,WindowRect,lpt);

     IF lpt.x < 1 THEN lpt.x := 1;
     IF lpt.x > WinSizeX THEN lpt.x := WinSizeX;
     IF lpt.y < 1 then lpt.y := 1;
     IF lpt.y > WinSizeY THEN lpt.y := WinSizeY;

     IF lpt.x > ScrCursorX THEN inc(FileCursorX,lpt.x-ScrCursorX)
     ELSE dec(FileCursorX,ScrCursorX-lpt.x);
     ScrCursorX := lpt.x;

     IF (FileCursorY+lpt.y)-ScrCursorY > CountLines THEN
        lpt.y := Countlines-FileCursorY+ScrCursorY;

     IF lpt.y > ScrCursorY THEN
     BEGIN
         inc(FileCursorY,lpt.y-ScrCursorY);
         FOR t := 1 TO lpt.y-ScrCursorY DO Actline := ActLine^.Next;
         ScrCursorY := lpt.y;
     END
     ELSE
     BEGIN
          dec(FileCursorY,ScrCursorY-lpt.y);
          FOR t := 1 TO ScrCursorY-lpt.y DO Actline := ActLine^.Prev;
          ScrCursorY := lpt.y;
     END;
     Enable;
     Focus;
     SetCursorXY;

     _ICBExtSetICB;
     _ICBSetMark;

     IF Length(ActLine^.zk^) < FileCursorX
     THEN FCX := Length(ActLine^.zk^)+1
     ELSE FCX := FileCursorX;
     IF FCX > StringLength THEN FCX := StringLength;

     IF (ActLine = ICB.LastLine) AND (FCX = ICB.LastX) THEN
     BEGIN
          DragStaticY := _PLine2Long(ICB.FirstLine);
          DragStaticX := ICB.FirstX;
          DragStaticLine := ICB.FirstLine;
     END
     ELSE
     BEGIN
          DragStaticY := _PLine2Long(ICB.LastLine);
          DragStaticX := ICB.LastX;
          DragStaticLine := ICB.LastLine;
     END;

     WinShowCursor(HWindow,FALSE);
     Msg.Handled := TRUE;
     Msg.result := 0;
END;



PROCEDURE TEditorWindow.WMButton1Up(VAR Msg:TMessage);
BEGIN
     Inherited.WMButton1Up(Msg);
     Capture(TRUE);
     IF NOT WindowGetFocus THEN
     BEGIN
          _CheckICB;
          WinShowCursor(HWindow,TRUE);
     END;
     WindowGetFocus := FALSE;
     Msg.Handled := TRUE;
     Msg.result := 0;
END;



PROCEDURE TEditorWindow.WMMouseDrag1(VAR Msg:TMessage);
VAR  pt : POINTS;
     lpt : POINTS;
     newY : LONGINT;
     newX : INTEGER;
     von,bis,cl,i : INTEGER;
     ptline : PLine;

FUNCTION BeforeDragStatic:BOOLEAN;
BEGIN
     BeforeDragStatic := FALSE;
     IF newY > DragStaticY THEN exit;
     IF newY = DragStaticY THEN
       IF newX >= DragStaticX THEN exit;
     BeforeDragStatic := TRUE;
END;

BEGIN
     IF WindowGetFocus THEN exit;
     Capture(FALSE); {!!}

     pt := POINTS(Msg.Param1);
     GetPosFromMaus(pt,WindowRect,lpt);

     IF lpt.x < 1 THEN
     BEGIN
          dec(FileCursorX,ScrCursorX - 1);
          ScrCursorX := 1;
          IF FileCursorX <= 1 THEN newX := 1
          ELSE newX := FileCursorX - 1;
     END;

     IF lpt.x > WinSizeX THEN
     BEGIN
          inc(FileCursorX,WinSizeX - ScrCursorX);
          ScrCursorX := WinSizeX;
          IF FileCursorX >= StringLength THEN newX := StringLength
          ELSE newX := FileCursorX + 1;
     END;

     IF (lpt.x >= 1) AND (lpt.x <= WinSizeX) THEN
     BEGIN
          FileCursorX := FileCursorX - ScrCursorX + lpt.x;
          ScrCursorX := lpt.x;
          newX := FileCursorX;
     END;


     cl := abs(lpt.y - ScrCursorY);
     IF cl >= WinSizeY THEN cl := WinSizeY-1;

     newY := FileCursorY;

     IF lpt.y > ScrCursorY THEN
     BEGIN
          IF FileCursorY + cl > CountLines
          THEN cl := CountLines - FileCursorY;
          newY := FileCursorY + cl;
          von := ScrCursorY;
          bis := ScrCursorY + cl;
          IF bis > WinSizeY THEN bis := WinSizeY;
     END;

     IF lpt.y < ScrCursorY THEN
     BEGIN
          IF FileCursorY < 1 + cl
          THEN cl := FileCursorY - 1;
          newY := FileCursorY - cl;
          von := ScrCursorY - cl;
          IF von < 1 THEN von := 1;
          bis := ScrCursorY;
     END;


     _ICBClearMark;
     IF BeforeDragStatic THEN
     BEGIN
          ICB.FirstLine := _Long2PLine(newY);
          ICB.FirstX := newX;
          ICB.LastLine := DragStaticLine;
          ICB.LastX := DragStaticX;
     END
     ELSE
     BEGIN
          ICB.FirstLine := DragStaticLine;
          ICB.FirstX := DragStaticX;
          ICB.LastLine := _Long2PLine(newY);
          ICB.LastX := newX;
     END;

     IF Length(ICB.FirstLine^.zk^) < ICB.FirstX
     THEN ICB.FirstX := Length(ICB.FirstLine^.zk^)+1;
     IF Length(ICB.LastLine^.zk^) < ICB.LastX
     THEN ICB.LastX := Length(ICB.LastLine^.zk^)+1;
     _ICBSetMark;


     IF lpt.x < 1 THEN CursorLeft
     ELSE IF lpt.x > WinSizeX THEN CursorRight
          ELSE InvalidateSingleLine;


     ptline := ActLine;
     IF lpt.y > ScrCursorY THEN
     BEGIN
          FOR i := von TO bis DO
          BEGIN
               InvalidateEditorLine(ptline,i);
               ptline := ptline^.next;
          END;
          CursorDown(cl);
     END
     ELSE
     IF lpt.y < ScrCursorY THEN
     BEGIN
          FOR i := bis DOWNTO von DO
          BEGIN
               InvalidateEditorLine(ptline,i);
               ptline := ptline^.prev;
          END;
          CursorUp(cl);
     END;

     Msg.Handled := TRUE;
     Msg.result := 0;
END;


{ +++ Scrollbar-Events +++++++++++++++++++++++++++++++++++++++++++++++++++++ }


PROCEDURE TEditorWindow.SetSliderValues;
VAR  ww1,ww2:WORD;
     p:LONGWORD;
     ScrollWin,FrameWin:HWND;
BEGIN
     FrameWin:=WinQueryWindow(HWindow,QW_PARENT);

     {init horicontal ScrollWindow}
     ScrollWin:=WinWindowFromID(FrameWin,FID_HORZSCROLL);
     HSlider.scrollbottom:=1;
     HSlider.scrolltop:=StringLength;
     HSlider.viewarea:=WinSizeX;

     {define horizontal Scroll intervall}
     ww1:=HSlider.scrollbottom;
     ww2:=(HSlider.scrolltop-HSlider.scrollbottom)-HSlider.viewarea+2;
     p:=MPFROM2SHORT(ww1,ww2);
     WinSendMsg(ScrollWin,SBM_SETSCROLLBAR,1,p);

     {Set horizontal slider size}
     ww1:=HSlider.viewarea;
     ww2:=HSlider.scrolltop-HSlider.scrollbottom+1;
     p:=MPFROM2SHORT(ww1,ww2);
     WinSendmsg(ScrollWin,SBM_SETTHUMBSIZE,p,0);

     {init vertical ScrollWindow}
     ScrollWin:=WinWindowFromID(FrameWin,FID_VERTSCROLL);
     VSlider.scrollbottom:=1;
     VSlider.scrolltop:=CountLines;
     VSlider.viewarea:=WinSizeY;

     {define vertical Scroll intervall}
     ww1:=VSlider.scrollbottom;
     ww2:=(VSlider.scrolltop-VSlider.scrollbottom)-VSlider.viewarea+2;
     p:=MPFROM2SHORT(ww1,ww2);
     WinSendMsg(ScrollWin,SBM_SETSCROLLBAR,1,p);

     {Set vertical slider size}
     ww1:=VSlider.viewarea;
     ww2:=VSlider.scrolltop-VSlider.scrollbottom+1;
     p:=MPFROM2SHORT(ww1,ww2);
     WinSendmsg(ScrollWin,SBM_SETTHUMBSIZE,p,0);

     SetSliderPosition;
END;



PROCEDURE TEditorWindow.SetSliderPosition;
VAR  ScrollWin : HWND;
     FrameWin : HWND;
     w : WORD;
     p : ULONG;
BEGIN
     HSlider.acvalue := FileCursorX-ScrCursorX+1;
     VSlider.acvalue := FileCursorY-ScrCursorY+1;
     FrameWin:=WinQueryWindow(HWindow,QW_PARENT);

     ScrollWin:=WinWindowFromID(FrameWin,FID_HORZSCROLL);
     w:=HSlider.acvalue;
     p:=MPFROMSHORT(w);
     WinSendMsg(ScrollWin,SBM_SETPOS,p,0);

     ScrollWin:=WinWindowFromID(FrameWin,FID_VERTSCROLL);
     w:=VSlider.acvalue;
     p:=MPFROMSHORT(w);
     WinSendMsg(ScrollWin,SBM_SETPOS,p,0);
END;



PROCEDURE TEditorWindow.WMHScroll(VAR Msg:TMessage);
VAR  w : Word;
     l : LONGWORD;
     ScrollWin : HWND;
     FrameWin : HWND;
     SliderID : LONGWORD;
     Win : HWND;
     acval : WORD;
BEGIN
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     Msg.Handled:=TRUE;
     Msg.Result:=0;
     Win:=Msg.Receiver;

     l:=Msg.param2;
     SliderID:=Msg.param1;
     SliderID:=Lo(SliderID);
     w:=hi(l);
     FrameWin:=WinQueryWindow(Win,QW_PARENT);
     ScrollWin:=WinWindowFromID(FrameWin,SliderID);
     CASE w OF
         SB_LINELEFT:
         BEGIN
              IF HSlider.acvalue > 1 THEN
              BEGIN
                   dec(FileCursorX);
                   IF EditOptions AND EOD_UseCUA <> 0 THEN _CuaClearMark;
                   InvalidateEditorWindow(1);
              END;
         END;
         SB_LINERIGHT:
         BEGIN
              IF HSlider.acvalue+WinSizeX <= StringLength THEN
              BEGIN
                   inc(FileCursorX);
                   IF EditOptions AND EOD_UseCUA <> 0 THEN _CuaClearMark;
                   InvalidateEditorWindow(1);
              END;
         END;
         SB_PAGELEFT:
         BEGIN
              IF HSlider.acvalue > WinSizeX THEN
              BEGIN
                   dec(FileCursorX,WinSizeX);
                   IF EditOptions AND EOD_UseCUA <> 0 THEN _CuaClearMark;
                   InvalidateEditorWindow(1);
              END
              ELSE
              BEGIN
                   dec(FileCursorX,HSlider.acvalue-1);
                   IF EditOptions AND EOD_UseCUA <> 0 THEN _CuaClearMark;
                   InvalidateEditorWindow(1);
              END;
         END;
         SB_PAGERIGHT:
         BEGIN
              IF HSlider.acvalue+WinSizeX+WinSizeX <= StringLength THEN
              BEGIN
                   inc(FileCursorX,WinSizeX);
                   IF EditOptions AND EOD_UseCUA <> 0 THEN _CuaClearMark;
                   InvalidateEditorWindow(1);
              END
              ELSE
              BEGIN
                   FileCursorX := StringLength-(WinSizeX-ScrCursorX);
                   IF EditOptions AND EOD_UseCUA <> 0 THEN _CuaClearMark;
                   InvalidateEditorWindow(1);
              END;
         END;
         SB_SLIDERTRACK,SB_SLIDERPOSITION:
         BEGIN
              acval := lo(l);
              IF acval=HSlider.acvalue THEN exit;

              IF acval > HSlider.acvalue THEN
              BEGIN  {to the right}
                   dec(acval,HSlider.acvalue);
                   inc(FileCursorX,acval);
              END
              ELSE
              BEGIN {to the left}
                   acval:=HSlider.acvalue-acval;
                   dec(FileCursorX,acval);
              END;
              IF EditOptions AND EOD_UseCUA <> 0 THEN _CuaClearMark;
              InvalidateEditorWindow(1);
         END;
         ELSE exit;
     END; {Case}
END;



PROCEDURE TEditorWindow.WMVScroll(VAR Msg:TMessage);
VAR  w : Word;
     l : LONGWORD;
     ScrollWin : HWND;
     FrameWin : HWND;
     SliderID : LONGWORD;
     acval : WORD;
     Win : HWND;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     (*UNDO*)
     IF LastUndoGroup <> UG_CursorMove THEN _StoreUndoCursor;
     LastUndoGroup := UG_CursorMove;
     (*UNDO*)
     Msg.Handled:=TRUE;
     Msg.result:=0;
     Win:=Msg.receiver;

     l:=msg.param2;
     SliderID:=msg.param1;
     SliderID:=lo(SliderID);
     w:=hi(l);
     FrameWin:=WinQueryWindow(Win,QW_PARENT);
     ScrollWin:=WinWindowFromID(FrameWin,SliderID);

     CASE w OF
         SB_LINEUP:
         BEGIN
              IF EditOptions AND EOD_UseCUA <> 0 THEN CuaRollUp
              ELSE RollUp;
         END;
         SB_LINEDOWN:
         BEGIN
              IF EditOptions AND EOD_UseCUA <> 0 THEN CuaRollDown
              ELSE RollDown;
         END;
         SB_PAGEUP:
         BEGIN
              IF EditOptions AND EOD_UseCUA <> 0 THEN CuaPageUp
              ELSE PageUp;
         END;
         SB_PAGEDOWN:
         BEGIN
              IF EditOptions AND EOD_UseCUA <> 0 THEN CuaPageDown
              ELSE PageDown;
         END;
         SB_SLIDERTRACK,SB_SLIDERPOSITION:
         BEGIN
              acval := lo(l);
              IF acval=VSlider.acvalue THEN exit;

              IF acval>VSlider.acvalue THEN  {downward}
              BEGIN
                   dec(acval,VSlider.acvalue);
                   FOR l:=1 TO acval DO
                   BEGIN
                         IF ActLine^.Next<>NIL THEN
                         BEGIN
                              inc(FileCursorY);
                              ActLine:=ActLine^.Next;
                              FirstScreenLine:=FirstScreenLine^.Next;
                         END;
                   END;
              END
              ELSE
              BEGIN   {upward}
                   acval:=VSlider.acvalue-acval;
                   FOR l:=1 TO acval DO
                   BEGIN
                         IF FirstScreenLine^.Prev<>NIL THEN
                         BEGIN
                              dec(FileCursorY);
                              ActLine:=ActLine^.Prev;
                              FirstScreenLine:=FirstScreenLine^.Prev;
                         END;
                   END;
              END;
              IF EditOptions AND EOD_UseCUA <> 0 THEN _CuaClearMark;
              InvalidateEditorWindow(1);
         END;
     END; {Case}
END;


{*** Printing **************************************************************}


FUNCTION TEditorWindow.GetPrinterDevice(VAR dopPrinter:DEVOPENSTRUC):BOOLEAN;
VAR  ppuffer : PPRQINFO3;
     LengthInByte : LONGWORD;
     pspool : PPRQINFO3;
     szTemp : CSTRING;
     pszApp : CSTRING;
     pszKey : CSTRING;
     pszDefault : CSTRING;
     szPrinter : CSTRING;
     lSize : LONGWORD;
     s : STRING;
     p : BYTE;
BEGIN
     GetPrinterDevice := FALSE;

     {Query the default printer}
     pszApp := 'PM_SPOOLER';
     pszKey := 'QUEUE';
     pszDefault := '';
     IF PrfQueryProfileString(HINI_PROFILE,
                              pszApp,pszKey,pszDefault,szTemp,255) = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[20]);
          exit;
     END;

     {Remove Semicolon}
     s := szTemp;
     p := pos(';',s);
     IF p <> 0 THEN
     BEGIN
          s[p] := #0;
          s[0] := chr(p-1);
     END;
     szTemp := s;

     SplQueryQueue(NIL,szTemp,3,NIL,0,LengthInByte);
     IF LengthInByte = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[21]);
          exit;
     END;

     GetMem(ppuffer,LengthInByte);
     SplQueryQueue(NIL,szTemp,3,ppuffer^,LengthInByte,LengthInByte);

     pspool := PPRQINFO3(ppuffer);
     IF pspool = NIL THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[21]);
          exit;
     END;

     {Fill Structure with SpoolerInfo}
     s := pspool^.pszDriverName^;
     p := pos('.',s);
     IF p <> 0 THEN
     BEGIN
          s[p] := #0;
          s[0] := chr(p-1);
     END;
     szDriverName := s;
     szLogAddress := pspool^.pszName^;
     szDeviceName := pspool^.pDriverData^.szDeviceName;
     szPrinter    := pspool^.pszPrinters^;
     szDataType   := 'PM_Q_STD';

     lSize := DevPostDeviceModes(HInstance,
                                 NIL,
                                 szDriverName,
                                 szDeviceName,
                                 szPrinter,
                                 DPDM_POSTJOBPROP);

     GetMem(dopPrinter.pDriv,lSize);

     move(pspool^.pDriverData^, dopPrinter.pDriv^, pspool^.pDriverData^.cb);
     dopPrinter.pszDriverName := @szDriverName;
     dopPrinter.pszLogAddress := @szLogAddress;
     dopPrinter.pszDataType := @szDataType;

     FreeMem(ppuffer,LengthInByte);

     GetPrinterDevice := TRUE;
END;



PROCEDURE Printing(pPI:PPrintInfo);CDECL;
VAR  pkt : POINTL;
     s : STRING;
     P : POINTER;
     Len : LONGWORD;
BEGIN
     DevEscape(pPI^.PrinterDC, DEVESC_STARTDOC, 0, NIL, NIL, NIL);
     pkt.x := pPI^.OffsX;
     pkt.y := pPI^.OffsFL;
     P := pPI^.Text;
     Len := pPI^.TextLen;

     WHILE Len > 0 DO
     BEGIN
          dec(pkt.y, pPI^.PRN_LineDist);
          IF pkt.y < pPI^.OffsY THEN
          BEGIN
               pkt.y := pPI^.OffsFL - pPI^.PRN_LineDist;
               DevEscape(pPI^.PrinterDC, DEVESC_NEWFRAME, 0, NIL, NIL, NIL);
          END;
          ASM
             CLD
             LEA EDI,$s
             MOV ESI,$P
             INC EDI
             XOR ECX,ECX
!pr1:
             CMPD $Len,0
             JE !pr6
             LODSB
             DECD $Len
             CMP AL,13
             JE !pr3
             STOSB
             INC ECX
             JMP !pr1
!pr3:
             LODSB
             DECD $Len
!pr6:
             MOV $P,ESI
             MOVB [EDI],0     // terminal 0
             MOV $s,CL
          END;
          IF Length(s) > 0
          THEN GpiCharStringAt(pPI^.PrinterPS, pkt, Length(s), s[1]);
     END;
     DevEscape(pPI^.PrinterDC, DEVESC_ENDDOC, 0, NIL, NIL, NIL);

     DosEnterCritSec;
     IF pPI^.Status = 1 THEN      {Job is active}
     BEGIN
          pPI^.Status := 2;       {Job Killing initiated}
          DosExitCritSec;
          GpiAssociate(pPI^.PrinterPS,0);
          GpiDestroyPS(pPI^.PrinterPS);
          DevCloseDC(pPI^.PrinterDC);
          FreeMem(pPI^.Text,pPI^.TextLen);
          IF pPI^.AbortHwnd <> 0 THEN WinPostMsg(pPI^.AbortHwnd,WM_DISMISS,0,0);
          pPI^.Status := 0;       {Job finished}
     END
     ELSE DosExitCritSec;
END;



PROCEDURE TEditorWindow.PrintFile;
CONST g : SIZEL = (cx:0; cy:0);
VAR  dopPrinter : DEVOPENSTRUC;
     InfoDC : HDC;
     InfoPS : HPS;
     PrinterDC : HDC;
     PrinterPS : HPS;
     ptl : POINTL;
     ptlRes : POINTL;
     lSizeHC : LONGWORD;
     pHCInfo : ^HCINFO;
     pHCI : ^HCINFO;
     physPageSize : SIZEL;
     PrintArea : SIZEL;
     PrintOffset : SIZEL;
     Len : LONGWORD;
     i : WORD;
BEGIN
     IF WLactivated THEN _WriteWorkLine;
     IF PrintInfo.Status <> 0 THEN exit;
     PrintInfo.PRN_LeftIndent := 100;
     PrintInfo.PRN_UpperIndent := 100;
     PrintInfo.PRN_LowerIndent := 150;
     PrintInfo.PRN_LineDist := 45;
     {Get Printer Device Open Structure}
     FillChar(dopPrinter,SizeOf(dopPrinter),0);
     IF NOT GetPrinterDevice(dopPrinter) THEN exit; {Canceled or Error}

     {Open Info DC}
     InfoDC := DevOpenDC(HInstance, OD_INFO, '*', 4, dopPrinter, 0);
     IF InfoDC = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[22]);
          exit;
     END;
     InfoPS := GpiCreatePS(HInstance, InfoDC, g,
                            PU_LOMETRIC OR GPIT_MICRO OR GPIA_ASSOC);
     IF InfoPS = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[23]);
          exit;
     END;

     GpiQueryPS(InfoPS,PrintArea);

     lSizeHC := DevQueryHardcopyCaps(InfoDC,0,0,NIL);
     IF lSizeHC = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[24]);
          exit;
     END;

     GetMem(pHCInfo,lSizeHC*SizeOf(HCINFO));
     DevQueryHardcopyCaps(InfoDC,0,lSizeHC,pHCInfo^);

     pHCI := pHCInfo;
     FOR i := 0 TO lSizeHC-1 DO
     BEGIN
          IF pHCI^.flAttributes AND HCAPS_CURRENT <> 0 THEN
          BEGIN
               /* Get Resolution */
               DevQueryCaps (InfoDC,CAPS_HORIZONTAL_RESOLUTION,1,ptlRes.x);
               DevQueryCaps (InfoDC,CAPS_VERTICAL_RESOLUTION,1,ptlRes.y);

               /* Calculate the physical page size */
               physPageSize.cx := round((ptlRes.x * pHCI^.cx) / 1000);
               physPageSize.cy := round((ptlRes.y * pHCI^.cy) / 1000);
               /* Convert from device to world coordinate space */
               GpiConvert(InfoPS,CVTC_DEVICE,CVTC_WORLD,1,POINTL(physPageSize));

               /* Calculate Print Offset */
               PrintOffset.cx := round((ptlRes.x * pHCI^.xLeftClip) / 1000);
               PrintOffset.cy := round((ptlRes.y * pHCI^.yBottomClip) / 1000);
               /* Convert from device to world coordinate space */
               GpiConvert(InfoPS,CVTC_DEVICE,CVTC_WORLD,1,POINTL(PrintOffset));

               /* Correct Print Offset if necessary */
               DevQueryCaps (InfoDC,CAPS_WIDTH,1,ptl.x);
               DevQueryCaps (InfoDC,CAPS_HEIGHT,1,ptl.y);
               /* Convert from device to world coordinate space */
               GpiConvert(InfoPS,CVTC_DEVICE,CVTC_WORLD,1,ptl);
               IF PrintOffset.cx = 0
               THEN PrintOffset.cx := (physPageSize.cx - ptl.x) DIV 2;
               IF PrintOffset.cy = 0
               THEN PrintOffset.cy := (physPageSize.cy - ptl.y) DIV 2;
           END;
           inc(pHCI,SizeOf(HCINFO));
     END;
     FreeMem(pHCInfo,lSizeHC*SizeOf(HCINFO));
     GpiAssociate(InfoPS,0);
     GpiDestroyPS(InfoPS);
     DevCloseDC(InfoDC);


     {Open Printer DC}
     PrinterDC := DevOpenDC(HInstance, OD_QUEUED, '*', 4, dopPrinter, 0);
     IF PrinterDC = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[25]);
          exit;
     END;
     {Set DeviceContext and PresentationSpace}
     PrinterPS := GpiCreatePS(HInstance, PrinterDC, g,
                         PU_LOMETRIC OR GPIT_MICRO OR GPIA_ASSOC);
     IF PrinterPS = 0 THEN
     BEGIN
          SetErrorMessage(MB_ICONHAND, NLSTable[1],NLSTable[26]);
          DevCloseDC(PrinterDC);
          exit;
     END;

     {Release Memory allocated in the GetPrinterDevice-Function}
     IF dopPrinter.pDriv <> NIL THEN FreeMem(dopPrinter.pDriv,dopPrinter.pDriv^.cb);

     {Calculate PrintOffset within the Presentation space}
     IF PrintOffset.cx < PrintInfo.PRN_LeftIndent
     THEN PrintInfo.OffsX := PrintInfo.PRN_LeftIndent-PrintOffset.cx
     ELSE PrintInfo.OffsX := 0;

     IF PrintOffset.cy < PrintInfo.PRN_LowerIndent
     THEN PrintInfo.OffsY := PrintInfo.PRN_LowerIndent-PrintOffset.cy
     ELSE PrintInfo.OffsY := 0;

     PrintInfo.OffsFL := physPageSize.cy-PrintOffset.cy-PrintInfo.PRN_UpperIndent;
     IF PrintInfo.OffsFL > PrintArea.cy THEN PrintInfo.OffsFL := PrintArea.cy;

     PrintInfo.PrinterDC := PrinterDC;
     PrintInfo.PrinterPS := PrinterPS;
     PrintInfo.Text := CopyLinesLinear(Len);
     PrintInfo.TextLen := Len;
     PrintInfo.AbortHwnd := 0;
     PrintInfo.Status := 1;

     InitializePrinting;
END;



PROCEDURE TEditorWindow.InitializePrinting;
BEGIN
     DosCreateThread(PrintInfo.PTid,@Printing,@PrintInfo,0,32768);
END;





BEGIN
     EditOptions := EOD_CreateBackup OR EOD_InsertMode OR EOD_AutoIndentMode
                    OR $8000000;
     ReplOptions := FRD_Forward;
     FindOptions := FRD_Forward;
     aSearchString := '';
     aReplaceString := '';
     LastFRD := 0;
     PreCtrl := 0;
     FaceName := 'System VIO';
     CharHeight := 16;
     CharWidth := 8;
     CharBaseLine := 4;
     WinReadOnly := FALSE;
     AvailFontCount := 0;
     CursorRate := 500;

     NLSTable[1] := 'Error';
     NLSTable[2] := 'Could not copy text.';
     NLSTable[3] := 'Could not access clipboard.';
     NLSTable[4] := 'Read block from file';
     NLSTable[5] := 'Open a file';
     NLSTable[6] := 'Write block to file';
     NLSTable[7] := 'Save file as';
     NLSTable[8] := 'Error writing: ';
     NLSTable[9] := ' was modified. Save?';
     NLSTable[10] := 'Information';
     NLSTable[11] := 'Loading...';
     NLSTable[12] := 'File ';
     NLSTable[13] := ' already exist. Overwrite?';
     NLSTable[14] := 'Warning';
     NLSTable[15] := 'Saving...';
     NLSTable[16] := 'Search string not found.';
     NLSTable[17] := 'Confirm';
     NLSTable[18] := 'Replace this string?';
     NLSTable[19] := 'Line would be to long.';
     NLSTable[20] := 'Default Printer not found.';
     NLSTable[21] := 'Default Spooler Queue not found.';
     NLSTable[22] := 'Cannot create Information Device Context.';
     NLSTable[23] := 'Cannot create Information Presentation Space.';
     NLSTable[24] := 'Cannot acces to Hardcopy capabilities.';
     NLSTable[25] := 'Cannot create Printer Device Context.';
     NLSTable[26] := 'Cannot create Printer Presentation Space.';
     NLSTable[27] := 'Open';
     NLSTable[28] := 'Save';
     NLSTable[29] := ' not found.';
END.
