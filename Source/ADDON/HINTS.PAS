Unit Hints;


Interface

Uses
  Classes,Forms;

Type
  {$M+}
  TShadowStyle=(shsSolid,shsShadowed);
  {$M-}

  TCustomHint=Class(TComponent)
    Private
      FOutlined:BOOLEAN;
      FOutlineColor:TColor;
      FShadowSize:LONGINT;
      FShadowStyle:TShadowStyle;
      FShadowColor:TColor;
      FHintPenColor:TColor;
      FHintColor:TColor;
      FMaxWidth:LONGINT;
      FHintOrigin:THintOrigin;
      Procedure SetShadowSize(NewValue:LONGINT);
      Procedure SetHintOrigin(NewValue:THintOrigin);
    Protected
      Procedure SetupComponent;Override;
    Public
      Destructor Destroy;Override;
    Published
      Property Outlined:BOOLEAN read FOutlined write FOutLined;
      Property OutlineColor:TColor read FOutlineColor write FOutlineColor;
      Property ShadowSize:LONGINT read FShadowSize write SetShadowSize;
      Property ShadowStyle:TShadowStyle read FShadowStyle write FShadowStyle;
      Property ShadowColor:TColor read FShadowColor write FShadowColor;
      Property HintPenColor:TColor read FHintPenColor write FHintPenColor;
      Property HintColor:TColor read FHintColor write FHintColor;
      Property MaxWidth:LONGINT read FMaxWidth write FMaxWidth;
      Property Origin:THintOrigin read FHintOrigin write SetHintOrigin;
  End;


  {$M+}
  TBalloonShape=(basRectangle,basRounded);
  {$M-}

  TBalloonHint=Class(TCustomHint)
    Private
      FBalloonShape:TBalloonShape;
      Property Origin;
    Protected
      Procedure SetupComponent;Override;
    Public
      Destructor Destroy;Override;
    Published
      Property BalloonShape:TBalloonShape read FBalloonShape write FBalloonShape;
  End;


Implementation

Const
  CustomHint:TCustomHint=Nil;
  BalloonHint:TBalloonHint=Nil;

{
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
�                                                                           �
� Speed-Pascal/2 Version 2.0                                                �
�                                                                           �
� Speed-Pascal Component Classes (SPCC)                                     �
�                                                                           �
� This section: TCustomHintWindow Class implementation                      �
�                                                                           �
� Last modified: September 1995                                             �
�                                                                           �
� (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          �
�                                                                           �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
}

Type
  TCustomHintWindow=Class(THintWindow)
    Private
      FCustomHint:TCustomHint;
    Protected
      Procedure SplitText(Bubble:String;Ret:TStrings;Var CX,CY:LONGINT);Virtual;
      Procedure DrawBubbleShape(Const rec:TRect);Virtual;
      Procedure DrawBubbleText(Const Bubble:String;Const rec:TRect);Virtual;
    Public
      Procedure Redraw(Const rec:TRect);Override;
      Procedure ActivateHint(Rect:TRect; Const AHint:String);Override;
  End;


Procedure TCustomHintWindow.SplitText(Bubble:String;Ret:TStrings;Var CX,CY:LONGINT);
Const
  Separators:Set Of CHAR = [' ','.',',',':',';',')',']','!','?'];
Var
  CX1,CY1:LONGINT;
  t:LONGINT;
  s:String;
  LastFound:LONGINT;
Begin
   CY := 0;
   CX := 0;
   While Bubble <> '' Do
   Begin
     LastFound := 0;
     For t := 1 To length(Bubble) Do
       If Bubble[t] In Separators Then
       Begin
         s := Copy(Bubble,1,t);
         Canvas.GetTextExtent(s,CX1,CY1);
         If CX1 < CustomHint.FMaxWidth - CustomHint.FShadowSize Then
         Begin
           LastFound := t;
           If CX1 > CX Then CX := CX1;
         End
         Else break;
       End;

     If LastFound=0 Then //no separator, split at will
     Begin
       For t := 1 To length(Bubble) Do
       Begin
         s := Copy(Bubble,1,t);
         Canvas.GetTextExtent(s,CX1,CY1);
         If CX1 < CustomHint.FMaxWidth - CustomHint.FShadowSize Then
         Begin
           LastFound := t;
           If CX1 > CX Then CX := CX1;
         End
         Else break;
       End;
     End;

     If LastFound = 0 Then LastFound := 1;

     s := Copy(Bubble,1,LastFound);
     Delete(Bubble,1,LastFound);
     Ret.Add(s);
     inc(CY,Canvas.Font.Height);
   End;
End;


Procedure TCustomHintWindow.DrawBubbleShape(Const rec:TRect);
Begin
  Canvas.Rectangle(rec);
End;


Procedure TCustomHintWindow.DrawBubbleText(Const Bubble:String;Const rec:TRect);
Var
  CX,CY:LONGINT;
  X,Y:LONGINT;
  Strings:TStringList;
  t:LONGINT;
Begin
  {Draw Text}
  Canvas.ClipRect := rec;
  Canvas.GetTextExtent(Bubble,CX,CY);
  Canvas.Brush.Mode := bmTransparent;

  If CX < CustomHint.FMaxWidth - CustomHint.FShadowSize Then
  Begin
    //Center text within the rectangle
    X := rec.Left+((rec.Right-rec.Left-CX) Div 2);
    If X < rec.Left Then X := rec.Left;

    Y := rec.Bottom+((rec.Top-rec.Bottom-CY) Div 2);
    If Y < rec.Bottom Then Y := rec.Bottom;
    Canvas.TextOut(X,Y,Bubble);
  End
  Else //split
  Begin
    Strings.Create;
    SplitText(Bubble,Strings,CX,CY);

    X := rec.Left+((rec.Right-rec.Left-CX) Div 2);
    If X < rec.Left Then X := rec.Left;
    Y := rec.Top-Canvas.Font.Height-((rec.Top-rec.Bottom-CY) Div 2);
    For t := 0 To Strings.Count-1 Do
    Begin
      Canvas.TextOut(X,Y,Strings[t]);
      dec(Y,Canvas.Font.Height);
    End;

    Strings.Destroy;
  End;

  Canvas.Brush.Mode := bmOpaque;
  Canvas.DeleteClipRegion;
End;


Procedure TCustomHintWindow.ActivateHint(Rect:TRect; Const AHint:String);
Var
  Strings:TStringList;
  CX:LONGINT;
  w,h:LONGINT;
Begin
  Canvas.Font := Font;

  Canvas.GetTextExtent(AHint,w,h);

  If w >= CustomHint.FMaxWidth - CustomHint.FShadowSize Then
  Begin
    //Split
    w := CustomHint.FMaxWidth - CustomHint.FShadowSize;
    Strings.Create;
    SplitText(AHint,Strings,CX,h);
    w := CX;
    Strings.Destroy;
  End;

  inc(w,CustomHint.FShadowSize+16);
  inc(h,CustomHint.FShadowSize+10);

  If Application.HintOrigin = hiTop Then Rect.Bottom := Screen.MousePos.Y
  Else Rect.Bottom := Screen.MousePos.Y - 15 - h;

  Rect.Right := Rect.Left + w;
  Rect.Top := Rect.Bottom + h;

  Inherited ActivateHint(Rect,AHint);
End;


Procedure TCustomHintWindow.Redraw(Const rec:TRect);
Var
  Target:TRect;
Begin
  Canvas.Pen.Color := CustomHint.FHintColor;
  Canvas.Pen.Width := 1;
  Canvas.Brush.Style := bsSolid;

  Canvas.ClipRect := rec;

  Target := ClientRect;
  dec(Target.Right,4+CustomHint.FShadowSize);
  dec(Target.Top,4);
  inc(Target.Bottom,CustomHint.FShadowSize);

  Canvas.BeginPath;
  DrawBubbleShape(Target);
  Canvas.EndPath;
  Canvas.FillPath;

  If CustomHint.FOutlined Then
  Begin
    Canvas.Pen.Color := CustomHint.FOutlineColor;
    DrawBubbleShape(Target);
  End;

  {Draw shadow}
  If CustomHint.FShadowSize > 0 Then
  Begin
       Canvas.Pen.Color:=CustomHint.FShadowColor;

       {Create complex clip region}
       Canvas.BeginPath;
       DrawBubbleShape(Target);
       Canvas.EndPath;
       Canvas.PathToClipRegion(paSubtract);

       If CustomHint.FShadowStyle = shsShadowed Then
       Begin
            Canvas.Pen.Mode := pmMerge;
            Canvas.Brush.Style := bsDiagCross;
            Canvas.Pen.Color := clBlack;
            Canvas.Brush.Color := clBlack;
       End;

       Target := rec;
       dec(Target.Right,4);
       dec(Target.Top,4+CustomHint.FShadowSize);
       inc(Target.Left,CustomHint.FShadowSize);

       Canvas.BeginPath;
       DrawBubbleShape(Target);
       Canvas.EndPath;
       Canvas.FillPath;
  End;

  Canvas.Pen.Mode := pmCopy;
  Canvas.DeleteClipRegion;

  Target := rec;
  inc(Target.Bottom,CustomHint.FShadowSize);
  dec(Target.Right,CustomHint.FShadowSize+3);
  Canvas.Pen.Color := CustomHint.FHintPenColor;
  DrawBubbleText(Caption,Target);
End;


{
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
�                                                                           �
� Speed-Pascal/2 Version 2.0                                                �
�                                                                           �
� Speed-Pascal Component Classes (SPCC)                                     �
�                                                                           �
� This section: TCustomHint Class implementation                            �
�                                                                           �
� Last modified: September 1995                                             �
�                                                                           �
� (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          �
�                                                                           �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
}

Procedure TCustomHint.SetupComponent;
Begin
  Inherited SetupComponent;

  If Not InDesigner Then
  Begin
    HintWindowClass := TCustomHintWindow;
    CustomHint := Self;
  End;

  Name := 'CustomHint';
  FOutlined := TRUE;
  FShadowSize := 10;
  FShadowStyle := shsShadowed;
  FShadowColor := clBlack;
  FHintPenColor := Application.HintPenColor;
  FHintColor := Application.HintColor;
  FHintOrigin := Application.HintOrigin;
  FMaxWidth := 200;
End;


Destructor TCustomHint.Destroy;
Begin
  If CustomHint = Self Then CustomHint := Nil;
  Inherited Destroy;
End;


Procedure TCustomHint.SetHintOrigin(NewValue:THintOrigin);
Begin
  If Not InDesigner Then Application.HintOrigin := NewValue;
  FHintOrigin := NewValue;
End;


Procedure TCustomHint.SetShadowSize(NewValue:LONGINT);
Begin
  If (NewValue < 0) Or (NewValue > 50) Then exit;
  FShadowSize := NewValue;
End;


{
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
�                                                                           �
� Speed-Pascal/2 Version 2.0                                                �
�                                                                           �
� Speed-Pascal Component Classes (SPCC)                                     �
�                                                                           �
� This section: TBallonHintWindow Class implementation                      �
�                                                                           �
� Last modified: September 1995                                             �
�                                                                           �
� (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          �
�                                                                           �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
}

Type
  TBalloonHintWindow=Class(TCustomHintWindow)
    Protected
      Procedure DrawBubbleShape(Const rec:TRect);Override;
      Procedure DrawBubbleText(Const Bubble:String;Const rec:TRect);Override;
    Public
      Procedure ActivateHint(Rect:TRect; Const AHint:String);Override;
  End;


Procedure TBalloonHintWindow.DrawBubbleShape(Const rec:TRect);
Begin
  Canvas.PenPos := Point(rec.Left,rec.Bottom);

  Canvas.LineTo(rec.Left+20,rec.Bottom+15);

  If BalloonHint.FBalloonShape = basRectangle Then
  Begin
    Canvas.LineTo(rec.Right,rec.Bottom+15);
    Canvas.LineTo(rec.Right,rec.Top);
    Canvas.LineTo(rec.Left+5,rec.Top);
    Canvas.LineTo(rec.Left+5,rec.Bottom+15);
    Canvas.LineTo(rec.Left+10,rec.Bottom+15);
    Canvas.LineTo(rec.Left,rec.Bottom);
  End
  Else
  Begin
    Canvas.LineTo(rec.Right-8,rec.Bottom+15);
    Canvas.Arc(rec.Right-8,rec.Bottom+23,8,8,270,90);
    Canvas.LineTo(rec.Right,rec.Top-8);
    Canvas.Arc(rec.Right-8,rec.Top-8,8,8,0,90);
    Canvas.LineTo(rec.Left+13,rec.Top);
    Canvas.Arc(rec.Left+13,rec.Top-8,8,8,90,90);
    Canvas.LineTo(rec.Left+5,rec.Bottom+23);
    Canvas.Arc(rec.Left+13,rec.Bottom+23,8,8,180,70);
    Canvas.LineTo(rec.Left+10,rec.Bottom+15);
    Canvas.LineTo(rec.Left,rec.Bottom);
  End;
End;


Procedure TBalloonHintWindow.DrawBubbleText(Const Bubble:String;Const rec:TRect);
Var
  rc1:TRect;
Begin
  rc1 := rec;
  inc(rc1.Left,4);
  inc(rc1.Bottom,15);

  Inherited DrawBubbleText(Bubble,rc1);
End;


Procedure TBalloonHintWindow.ActivateHint(Rect:TRect; Const AHint:String);
Var
  Strings:TStringList;
  CX:LONGINT;
  w,h:LONGINT;
Begin
  Canvas.Font := Font;

  Canvas.GetTextExtent(AHint,w,h);

  If w >= CustomHint.FMaxWidth - CustomHint.FShadowSize Then
  Begin
    //Split
    w := CustomHint.FMaxWidth - CustomHint.FShadowSize;
    Strings.Create;
    SplitText(AHint,Strings,CX,h);
    w := CX;
    Strings.Destroy;
  End;

  inc(w,CustomHint.FShadowSize+16);
  inc(h,CustomHint.FShadowSize+10);

  If Application.HintOrigin = hiTop Then Rect.Bottom := Screen.MousePos.Y
  Else Rect.Bottom := Screen.MousePos.Y - 15 - h;

  inc(w,8);
  inc(h,15);

  Rect.Right := Rect.Left + w;
  Rect.Top := Rect.Bottom + h;

  THintWindow.ActivateHint(Rect,AHint);
End;


{
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
�                                                                           �
� Speed-Pascal/2 Version 2.0                                                �
�                                                                           �
� Speed-Pascal Component Classes (SPCC)                                     �
�                                                                           �
� This section: TBalloonHint Class implementation                           �
�                                                                           �
� Last modified: September 1995                                             �
�                                                                           �
� (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          �
�                                                                           �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
}

Procedure TBalloonHint.SetupComponent;
Begin
  Inherited SetupComponent;

  If Not InDesigner Then
  Begin
    HintWindowClass := TBalloonHintWindow;
    BalloonHint := Self;
    Application.HintOrigin := hiTop;
  End;

  Name := 'BalloonHint';
  FBalloonShape := basRounded;
End;


Destructor TBalloonHint.Destroy;
Begin
  If BalloonHint = Self Then BalloonHint := Nil;
  Inherited Destroy;
End;



Begin
  RegisterClasses([TCustomHint,TBalloonHint]);
End.
