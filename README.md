## batch.cmd
Run any arbitrary command against an iterable pattern. Similar to `xargs` on other platforms.

`batch.cmd encode_as_h264_with_subdirs.cmd *.avi`

## encode_as_h264_with_subdirs.cmd
Encode a video file as x264 using ffmpeg. On success move to a destination path based on original file date.

`encode_as_h264_with_subdirs.cmd timelapse_20170618.avi`

## move_a_to_b.bat
Literally move a file from source to destination. Why? Because the `move` command can't be called from outside a Command Prompt. Annoying right? You could use `robocopy` but that seems like overkill.

`move_a_to_b.bat d:\foo\bar.txt c:\baz`

## run_hidden_with_1_arg.vbs
VBScript was the only reliable way I could find to run a command without any visible windows appearing. PowerShell has similar options but the initial ps1 script still creates a window of its own.

`wscript run_hidden_with_1_arg.vbs encode_as_h264_with_subdirs.cmd timelapse_20170618.avi`

## run_hidden_with_2_args.vbs
Literally the same but supports a 2nd argument. Obviously these should be a single script, but it wasn't really worth the effort.

`wscript run_hidden_with_2_args.vbs move_a_to_b.bat d:\foo\bar.txt c:\baz`
