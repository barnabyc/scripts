@echo off

set pattern=%1

for %%i in (%1) do (
  encode_as_h264.cmd %%i
)

