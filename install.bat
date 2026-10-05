@echo off
REM Install Social AI Team skills into Claude Code

SET SKILLS_DIR=%USERPROFILE%\.claude\skills
SET SCRIPT_DIR=%~dp0

echo Installing Social AI Team skills...

FOR %%S IN (idea-intake devto-writer weekly-content-run social-media-manager brand-onboarding content-calendar caption-writer social-creative-designer social-performance-review linkedin-writer threads-writer x-writer publisher) DO (
    IF NOT EXIST "%SKILLS_DIR%\%%S" MKDIR "%SKILLS_DIR%\%%S"
    XCOPY /E /Y /Q "%SCRIPT_DIR%.claude\skills\%%S\*" "%SKILLS_DIR%\%%S\" >nul
    echo   OK  %%S
)

echo.
echo Done. All 13 skills installed to %SKILLS_DIR%
echo Open Claude Code and run /social-media-manager to get started.
pause
