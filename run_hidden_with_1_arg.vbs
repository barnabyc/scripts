Dim WinScriptHost
Set WinScriptHost = CreateObject("WScript.Shell")
WinScriptHost.Run """" & WScript.Arguments.Item(0) & """ """ & WScript.Arguments.Item(1) & """", 0
Set WinScriptHost = Nothing
