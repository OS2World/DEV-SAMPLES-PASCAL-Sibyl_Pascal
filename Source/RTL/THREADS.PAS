UNIT Threads;

{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Portable Class Library (PCL) Version 1.0                                  บ
บ                                                                           บ
บ This file: Threads and processes class definitions                        บ
บ                                                                           บ
บ Last modified: 22.08.1995                                                 บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

INTERFACE

{$IFDEF OS2}
USES BseDos;
{$ELSE}
Error: Wrong operating system
{$ENDIF}

{$IFDEF OS2}
TYPE
    HThread  = TID;
{$ELSE}
Error: Wrong operating system
{$ENDIF}


TYPE
    TThreadProc=PROCEDURE(ThreadParam1,ThreadParam2:POINTER);

    TThread name 'TThread'=CLASS(TObject)
                       PRIVATE
                             PThreadProc:TThreadProc;
                             PThreadParam1:POINTER;
                             PThreadParam2:POINTER;
                             PStackSize:ULONG;
                             PThreadTID:HThread;
                             PSuspended:BOOLEAN;
                       PRIVATE
                             FUNCTION GetSuspended:BOOLEAN;
                       PUBLIC
                             CONSTRUCTOR Create(ThreadProc:TThreadProc;
                                                ThreadParam1:POINTER;
                                                ThreadParam2:POINTER;
                                                ThreadStack:LONGWORD);
                             PROCEDURE Run;
                             PROCEDURE Kill;
                             PROCEDURE Suspend;
                             PROCEDURE Resume;
                             PROCEDURE ThreadProc;
                             PROCEDURE SetPriority(PClass,PDelta:LONGWORD);
                             FUNCTION HasEnded:BOOLEAN;
                             PROCEDURE Sleep(ms:LONGWORD);
                             DESTRUCTOR Destroy;VIRTUAL;
                       PROPERTY
                             Suspended:BOOLEAN      read GetSuspended;
    END;

IMPLEMENTATION

{
ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                                                           บ
บ Speed-Pascal/2 Version 2.0                                                บ
บ                                                                           บ
บ Portable Class Library (PCL) Version 1.0                                  บ
บ                                                                           บ
บ This section: TThread Class implementation                                บ
บ                                                                           บ
บ Last modified: 22.08.1995                                                 บ
บ                                                                           บ
บ (C) 1995 SpeedSoft. All rights reserved. Disclosure probibited !          บ
บ                                                                           บ
ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
}

CONSTRUCTOR TThread.Create(ThreadProc:TThreadProc;
                           ThreadParam1:POINTER;
                           ThreadParam2:POINTER;ThreadStack:LONGWORD);
BEGIN
     PThreadProc:=ThreadProc;
     PThreadParam1:=ThreadParam1;
     PThreadParam2:=ThreadParam2;
     IF ThreadStack<16384 THEN ThreadStack:=16384;
     PStackSize:=ThreadStack;
     PThreadTID:=0;
     PSuspended:=FALSE;
END;

PROCEDURE TThread.Sleep(ms:LONGWORD);
BEGIN
     {$IFDEF OS2}
     DosSleep(ms);
     {$ELSE}
     Error: Wrong operating system
     {$ENDIF}
END;

FUNCTION TThread.GetSuspended:BOOLEAN;
BEGIN
     GetSuspended:=PSuspended;
END;

PROCEDURE TThread.ThreadProc;CDECL;
BEGIN
     PThreadProc(PThreadParam1,PThreadParam2);
     {Clear TID if Thread resumed}
     PThreadTID:=0;
END;

PROCEDURE TThread.Run;
BEGIN
     {$IFDEF OS2}
     DosCreateThread(PThreadTID,@ThreadProc,POINTER(SELF),
                     0{STACK_COMMITTED},PStackSize);
     {$ELSE}
     Error: Wrong operating system
     {$ENDIF}
END;

PROCEDURE TThread.Kill;
VAR r:LONGWORD;
LABEL l;
BEGIN
     {$IFDEF OS2}
     IF PThreadTID<>0 THEN
     BEGIN
          IF PSuspended THEN Resume; {Cant kill a suspended thread}
l:
          r:=DosKillThread(PThreadTID);
          IF r=170 THEN  {Thread busy}
          BEGIN
               DosSleep(50);  //wait a while
               goto l;
          END;
     END;
     {$ELSE}
     Error: Wrong operating system
     {$ENDIF}
     PThreadTID:=0;
END;

PROCEDURE TThread.Suspend;
BEGIN
     IF PThreadTID<>0 THEN IF not PSuspended THEN
     BEGIN
          {$IFDEF OS2}
          DosSuspendThread(PThreadTID);
          {$ELSE}
          Error: Wrong operating system
          {$ENDIF}
          PSuspended:=TRUE;
     END;
END;

PROCEDURE TThread.Resume;
BEGIN
     IF PThreadTID<>0 THEN IF PSuspended THEN
     BEGIN
          {$IFDEF OS2}
          DosResumeThread(PThreadTID);
          {$ELSE}
          Error: Wrong operating system
          {$ENDIF}
          PSuspended:=FALSE;
     END;
END;

PROCEDURE TThread.SetPriority(PClass,PDelta:LONGWORD);
BEGIN
     {$IFDEF OS2}
     IF PThreadTID<>0 THEN
       DosSetPriority(PRTYS_THREAD,PClass,PDelta,PThreadTID);
     {$ELSE}
     Error: Wrong operating system
     {$ENDIF}
END;

FUNCTION TThread.HasEnded:BOOLEAN;
BEGIN
     HasEnded:=PThreadTID=0;
END;

DESTRUCTOR TThread.Destroy;
BEGIN
     Kill;

     Inherited Destroy;
END;

END.