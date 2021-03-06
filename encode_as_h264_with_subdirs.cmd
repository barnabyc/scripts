@echo off

set logfile=d:\temp\encode_as_h264.log
set file=%1

set ffmpeg="d:\temp\ffmpeg-20170503-a75ef15-win64-static\bin\ffmpeg.exe"
set options=-c:v libx264 -preset slow

rem 100KiB = 102,400 bytes
set minimumViableSizeBytes=102400

rem enable execution-time variable expansion, instead of parse-time
setlocal enabledelayedexpansion

rem capture any output of this block to the log
>>%logfile% (

  if "%~1"=="" echo [!date! !time!] --- No input file specified && exit /b
  if not exist !file! echo [!date! !time!] --- Input file does not exist: !file! && exit /b

  echo [!date! !time!] Start processing: !file! ...

  rem ---
  rem parse the file properties and construct input and output paths for ffmpeg
  rem ---
  for /f "tokens=* delims= " %%F in ('echo !file!') do (
    set fileSize=%%~zF
    set driveAndDirectory=%%~dpF
    set fullPath=%%~dpF
    set fileName=%%~nF
    set fileExtension=%%~xF

    for /f "tokens=1,2,3 delims=/ " %%A in ("%%~tF") do (
      set dateSubdir=%%C-%%A
      set pathWithDate=!fullPath!..\shrunk\!dateSubdir!
      if not exist !pathWithDate! mkdir !pathWithDate!
    )

    set output=!pathWithDate!\!fileName!.mkv
    set renamedInput=!fileName!.converted!fileExtension!
  )

  rem ---
  rem if minimum filesize is met, call ffmpeg
  rem ---
  if !fileSize! GEQ !minimumViableSizeBytes! (
    !ffmpeg! -i !file! !options! "!output!"

    if %ERRORLEVEL% EQU 0 (
      if exist !output! (
        rename !file! "!renamedInput!"
        del "!driveAndDirectory!!renamedInput!"

        echo [!date! !time!] Done, converted: !file! to: !output!
      ) else (
        echo [!date! !time!] --- Error, output does not exist !output!
      )
    ) else (
      echo [!date! !time!] --- Error converting !file!
    )
  ) else (
    echo [!date! !time!] --- File size minimum not met: !fileSize! less than !minimumViableSizeBytes! !file! 
  )

)
