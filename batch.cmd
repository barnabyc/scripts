@echo off

if "%~1"=="" if "%~2"=="" goto error

set cmd=%1
set pattern=%2

for %%i in (%pattern%) do (
  %cmd% %%i
)

exit /b 0

:error
echo Usage: %0 ^<command^> ^<pattern^>
echo Example: %0 encode_as_h264_with_subdirs.cmd *.avi
exit /b 1
