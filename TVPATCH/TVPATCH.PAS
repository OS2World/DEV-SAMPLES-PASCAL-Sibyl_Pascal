program tvpatch;

VAR source,dest,patch:TEXT;
    sourcedir,destdir,patchdir,sourcename,destname:STRING;
    patchline,sourceline:WORD;

procedure patcherror(msg:string);
begin
     Writeln('Error occured:'+msg);
     Writeln('Patchline:',patchline,'   Sourceline:',SourceLine);
     Writeln('Patch program aborted');
     halt(0);
end;

function newpatchline:string;
var s:string;
begin
     IF eof(patch) THEN patcherror('Unexpected end of patch file:'+patchdir+'\tvpatch !');
     {$i-}
     readln(patch,s);
     {$i+}
     IF ioresult<>0 THEN patcherror('Read error from '+patchdir+'\tvpatch !');
     WHILE s[length(s)]=#32 DO dec(s[0]);
     inc(patchline);
     newpatchline:=s;
end;

function newsourceline:string;
var s:string;
begin
     IF eof(source) THEN patcherror('Unexpected end of source:'+sourcename+' !');
     {$i-}
     readln(source,s);
     {$i+}
     IF ioresult<>0 THEN patcherror('Read error from '+sourcename+' !');
     WHILE s[length(s)]=#32 DO dec(s[0]);
     inc(SourceLine);
     newsourceline:=s;
end;

procedure newdestline(VAR s:STRING);
begin
     {$i-}
     writeln(dest,s);
     {$i+}
     IF ioresult<>0 THEN patcherror('Write error to '+destname+' !');
end;

procedure patchfile(VAR LastLine:STRING);
var line,sourceline:string;
LABEL l,l1;
begin
     line:=newpatchline;
     IF line[1]<>'#' THEN patcherror(patchdir+'\tvpatch damaged or invalid !');
l:
     delete(line,1,1);
     sourceline:=NewSourceLine;
     WHILE line<>sourceline DO
     BEGIN
          NewDestLine(SourceLine);
          sourceline:=NewSourceLine;
     END;
     {line found}
     line:=newpatchline;
     IF line[1]='#' THEN {multiple lines}
     BEGIN
          delete(line,1,1);
          sourceline:=NewSourceLine;
          WHILE line<>sourceline DO sourceline:=NewSourceLine;
          {line found}
          line:=newpatchline;
          IF Line[1]<>'>' THEN patcherror(patchdir+'\tvpatch damaged or invalid !');
     END;
l1:
     IF line[1]<>'>' THEN
     BEGIN
          CASE line[1] OF
             '#':goto l;
             '!':
             BEGIN
                  LastLine:=line;
                  exit;
             END;
             ELSE patcherror(patchdir+'\tvpatch damaged or invalid !');
          END;
     END;
     delete(line,1,1);
     NewDestline(line);
     line:=newpatchline;
     goto l1;
end;

procedure patchit;
var line:string;
label l;
begin
     line:=newpatchline;
l:
     IF line[1]<>'!' THEN patcherror(patchdir+'\tvpatch damaged or invalid !');
     IF line[2]='!' THEN exit; {end}
     delete(line,1,1);

     sourcename:=sourcedir+'\'+line;
     assign(source,sourcename);
     {$i-}
     reset(source);
     {$i+}
     IF ioresult<>0 THEN patcherror('Could not open '+sourcename+' !');

     destname:=destdir+'\'+line;
     assign(dest,destname);
     {$i-}
     rewrite(dest);
     {$i+}
     IF ioresult<>0 THEN patcherror('Could not open '+destname+' !');

     patchfile(line);

     {$i-}
     close(source);
     {$i+}
     IF ioresult<>0 THEN
        IF ioresult<>0 THEN patcherror('Could not close '+sourcename+' !');
     {$i-}
     close(dest);
     {$i+}
     IF ioresult<>0 THEN
        IF ioresult<>0 THEN patcherror('Could not write '+destname+' !');

     goto l;
end;

begin
     Writeln('Patch utility for Turbo Vision 2.0');
     Writeln('(C) 1998 SpeedSoft');
     Writeln('May not run with Turbo Pascal 7.01');
     Writeln;

     Write('Please enter the directory of the original TV sources:');
     Readln(sourcedir);
     Write('Please enter the destination directory:');
     Readln(destdir);
     patchline:=0;
     sourceline:=0;

     getdir(0,patchdir);
     IF patchdir[length(patchdir)]='\' THEN dec(patchdir[0]);

     assign(patch,patchdir+'\tvpatch.dat');
     {$i-}
     reset(patch);
     {$i+}
     IF ioresult<>0 THEN patcherror('Could not open '+patchdir+'\tvpatch.dat !');

     patchit;

     {$i-}
     close(patch);
     {$i+}

     Writeln('SUCCESS !');
end.