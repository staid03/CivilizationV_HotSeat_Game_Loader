﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleinstance , force

gamefile = (GMR) Play this one!.Civ5Save            ;the name of the Civ hotseat download file
dowloadFolder = C:\Users\study\Downloads\           ;where the file is downloaded to
primaryFolder = C:\Users\study\Documents\My Games\Sid Meier's Civilization 5\Saves\hotseat\         ;where Civ loads and saves files
backupFolder = %primaryFolder%backups               ;backup folder created for backing up save files

IfNotExist, %dowloadFolder%%gamefile%
{
    msg = Could not find %gamefile%
    errorMessage(msg)
}

IfExist, %primaryFolder%*.Civ5Save
{
    IfNotExist, %backupFolder%
    {
        FileCreateDir, %backupFolder%
        If ErrorLevel
        {
            msg = Could not create folder %backupFolder%
            errorMessage(msg)
        }
    }
    IfExist, %primaryFolder%%gamefile%
    {
        FormatTime, atime , ,  yyyyMMdd_HHmmss
        FileMove, %primaryFolder%%gamefile% , %backupFolder%\%atime%_%gamefile%
        If ErrorLevel
        {
            msg = Could not move files - %primaryFolder%%gamefile% -- %backupFolder%\%gamefile%_%atime%
            errorMessage(msg)
        }
    }
    FileMove, %primaryFolder%*.Civ5Save , %backupFolder%\
    If ErrorLevel
    {
        msg = Could not move files - %primaryFolder%*.Civ5Save -- %backupFolder%\
        errorMessage(msg)
    }
    Sleep, 500
}

FileMove, %dowloadFolder%%gamefile% , %primaryFolder%%gamefile%
If ErrorLevel
{
    msg = Could not move files - %dowloadFolder%%gamefile% -- %primaryFolder%%gamefile%
    errorMessage(msg)
}
SoundBeep
SoundBeep
Return

errorMessage(msg)
{
    MsgBox ,,, %msg%
}
Return