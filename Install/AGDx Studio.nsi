; Script generated by the HM NIS Edit Script Wizard.

!include FontRegAdv.nsh
!include FontName.nsh

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "AGDx Studio"
!define PRODUCT_VERSION "0.1.0 BETA"
!define PRODUCT_PUBLISHER "Tony Thompson"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\ADGx Studio"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 2.1 compatible ------
!include "MUI2.nsh"

!include LogicLib.nsh

;Request application privileges for Windows Vista
  RequestExecutionLevel user

; MUI Settings
;--------------------------------
;Interface Configuration

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "agdxstudio-installer-header.bmp" ; optional
!define MUI_WELCOMEFINISHPAGE_BITMAP "agdxstudio-installer-side.bmp"
!define MUI_COMPONENTSPAGE_CHECKBITMAP "${NSISDIR}\Contrib\Graphics\Checks\simple.bmp"
!define MUI_ABORTWARNING
!define MUI_ICON "agdxstudio.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\nsis3-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; Components page
;!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\AGDx Studio.exe"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\ReadMe.txt"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "AGDx Studio Install ${PRODUCT_VERSION}.exe"
RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)
InstallDir "$PROGRAMFILES\AGDx Studio"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Function .onInit
UserInfo::GetAccountType
pop $0
${If} $0 != "admin" ;Require admin rights on NT4+
    MessageBox mb_iconstop "Administrator rights required!"
    SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
    Quit
${EndIf}
FunctionEnd

; Font(s)
Section "Fonts" SEC05
  StrCpy $FONT_DIR $FONTS
  !insertmacro InstallTTF '..\Fonts\Comfortaa-Bold.TTF'
  !insertmacro InstallTTF '..\Fonts\Comfortaa-Light.TTF'
  !insertmacro InstallTTF '..\Fonts\Comfortaa-Regular.TTF'
  !insertmacro InstallTTF '..\Fonts\Roboto-Black.TTF'
  !insertmacro InstallTTF '..\Fonts\Roboto-Bold.TTF'
  !insertmacro InstallTTF '..\Fonts\Roboto-BoldCondensed.TTF'
  !insertmacro InstallTTF '..\Fonts\Roboto-Light.TTF'
  !insertmacro InstallTTF '..\Fonts\Roboto-Medium.TTF'
  !insertmacro InstallTTF '..\Fonts\Roboto-Regular.TTF'
  !insertmacro InstallTTF '..\Fonts\Roboto-Thin.TTF'
SendMessage ${HWND_BROADCAST} ${WM_FONTCHANGE} 0 0 /TIMEOUT=5000
SectionEnd

;Section "un.Fonts"
;StrCpy $FONT_DIR $FONTS
;  !insertmacro RemoveTTF 'OCTINSTENCILRG.TTF'
;  SendMessage ${HWND_BROADCAST} ${WM_FONTCHANGE} 0 0 /TIMEOUT=5000
;SectionEnd

; Main Application Files
Section "Main files" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  CreateDirectory "$SMPROGRAMS\AGDx Studio"
  File "..\Binaries\borlndmm.dll"
  File "..\Binaries\cc3280mt.dll"
  ;File "..\Binaries\libeay32.dll"
  ;File "..\Binaries\ssleay32.dll"
  ;File "..\Binaries\indy100.bpl"
  ;File "..\Binaries\IndyCore100.bpl"
  ;File "..\Binaries\IndyProtocols100.bpl"
  ;File "..\Binaries\IndySystem100.bpl"
  File "..\Binaries\Core_R6.dll"
  File "..\Binaries\CoreUtils_R6.dll"
  File "..\Binaries\ImageLibrary_R6.dll"
  File "..\Binaries\LogFiles_R6.dll"
  File "..\Binaries\PluginCommon_R6.dll"
  File "..\Binaries\ReadMe.txt"
  File "..\Binaries\Scorpio_R6.bpl"
  File "..\Binaries\Scintilla_R6.bpl"
  File "..\Binaries\SciLexer.dll"
  File "..\Binaries\Scitilla License.txt"
  File "..\Binaries\agdxstudio.exe"
  File "..\Binaries\agdxstudio.exe.manifest"
  File "..\Binaries\dbrtl100.bpl"
  File "..\Binaries\designide100.bpl"
  File "..\Binaries\rtl100.bpl"
  File "..\Binaries\vcl100.bpl"
  File "..\Binaries\vclactnband100.bpl"
  File "..\Binaries\vcldb100.bpl"
  File "..\Binaries\vclx100.bpl"
  File "..\Binaries\xmlrtl100.bpl"
  SetOverwrite off
  # Don't overwrite the users presets or the tools definitions
  File "..\Binaries\Tools.xml"
  SetOverwrite on
SectionEnd

; Main Plugins
Section "Main plugins" SEC02
  SetOutPath "$INSTDIR\Plugins"
  File "..\Binaries\Plugins\AttributeImageParser.cpi"
  File "..\Binaries\Plugins\CharacterType.ipi"
  File "..\Binaries\Plugins\CodeEditor.tpi"
  File "..\Binaries\Plugins\DesignEditor.tpi"
  File "..\Binaries\Plugins\ImageEditor.tpi"
  File "..\Binaries\Plugins\ImageImport.ipi"
  File "..\Binaries\Plugins\ImageTools.ipi"
  File "..\Binaries\Plugins\MapEditor.tpi"
  File "..\Binaries\Plugins\MapParser.cpi"
  File "..\Binaries\Plugins\PaintTools.ipi"
  File "..\Binaries\Plugins\PaletteParser.cpi"
  File "..\Binaries\Plugins\PaletteImageParser.cpi"
  File "..\Binaries\Plugins\ScreenType.ipi"
  File "..\Binaries\Plugins\SpriteType.ipi"
  File "..\Binaries\Plugins\StringEditor.tpi"
  File "..\Binaries\Plugins\StringTableParser.cpi"
  File "..\Binaries\Plugins\TileType.ipi"
SectionEnd

; Pasmo
Section "Documentation" SEC03
  SetOutPath "$INSTDIR\Pasmo"
  File "..\Binaries\Pasmo\pasmo.exe"
  File "..\Binaries\Pasmo\cc3280mt.dll"
  File "..\Binaries\Pasmo\pasmodoc.html"
  File "..\Binaries\Pasmo\NEWS"
  File "..\Binaries\Pasmo\README"
SectionEnd

; Documentation
Section "Documentation" SEC04
  SetOutPath "$INSTDIR"
  File "..\Binaries\agdxstudio.doc"
  File "..\Binaries\Getting Started Guide.doc"
SectionEnd

; ZX Spectrum Plugins
Section "ZX Spectrum plugins" SEC10
  SetOutPath "$INSTDIR\Plugins\_ZX Spectrum"
  File "..\Binaries\Plugins\_ZX Spectrum\defaults.xml"
  File "..\Binaries\Plugins\_ZX Spectrum\MonochromePalette.ipi"
  File "..\Binaries\Plugins\_ZX Spectrum\SevenuPImageParser.cpi"
  File "..\Binaries\Plugins\_ZX Spectrum\ZXImageTableParser.cpi"
  File "..\Binaries\Plugins\_ZX Spectrum\ZXScreenParser.cpi"
  File "..\Binaries\Plugins\_ZX Spectrum\ZXSpectrumPalette.ipi"
  ;File "..\Binaries\Plugins\_ZX Spectrum\ZXSpectrumHiColourPalette.ipi"
  ;File "..\Binaries\Plugins\_ZX Spectrum\ZXSpectrumUlaPlusPalette.ipi"
  File "..\Binaries\Plugins\_ZX Spectrum\ZXSpectrumNext256Palette.ipi"
SectionEnd

; Example Projects
Section "Example Projects" SEC11
  SetOverwrite ifnewer
  ; Library
  SetOutPath "$DOCUMENTS\agdxstudio\Library"
  File "..\Binaries\Projects\Library\debugstring.asm"
  ; Screen$
  SetOutPath "$DOCUMENTS\agdxstudio\A - Z Screens"
  File "C:\Users\Kiwi\Documents\agdxstudio\A - Z Screens\project.xml"
  ; 1942
  SetOutPath "$DOCUMENTS\agdxstudio\1942"
  File "C:\Users\Kiwi\Documents\agdxstudio\1942\project.xml"
  File "C:\Users\Kiwi\Documents\agdxstudio\1942\Level1.bmp"
  ; BigSpritesDemo
  SetOutPath "$DOCUMENTS\agdxstudio\BigSpritesDemo"
  File "C:\Users\Kiwi\Documents\agdxstudio\BigSpritesDemo\project.xml"
  File "C:\Users\Kiwi\Documents\agdxstudio\BigSpritesDemo\game.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\BigSpritesDemo\libinput.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\BigSpritesDemo\libscreen.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\BigSpritesDemo\libspritemasked.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\BigSpritesDemo\libspritexor.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\BigSpritesDemo\debugstring.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\BigSpritesDemo\background.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\BigSpritesDemo\spritesxor.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\BigSpritesDemo\spritesmasked.inc"
  ; Boriel Basic Demo
  SetOutPath "$DOCUMENTS\agdxstudio\Boriel Basic Demo"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\project.xml"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\circle.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\clock.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\clock2.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\colors.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\fact.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\fill.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\flag.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\flights.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\freregustav.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\led.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\lines.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\pong.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\scroll.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\spfill.bas"
  File "C:\Users\Kiwi\Documents\agdxstudio\Boriel Basic Demo\stars.bas"
  ; Buddy
  SetOutPath "$DOCUMENTS\agdxstudio\Buddy"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\project.xml"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\controls.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\icons.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\menus.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\startup.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\windows.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\caret_draw.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\caret_gfx.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\controls.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\desktop.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\display.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\font64.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\fontPro.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\gui_checkrect.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\gui_controls.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\icon_draw.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\icons.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\memory.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\menus.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\print_64.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Buddy\print_pro.inc"
  ; GEMS
  SetOutPath "$DOCUMENTS\agdxstudio\Gems"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\project.xml"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\window.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\screen.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\menu.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\math.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\isr.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\images.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\hiscoredata.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\hiscore.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\gameplay.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\font.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\control.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\ay_player.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\game.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\game_logic.txt"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\The_Gem_Machine.SFX"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\SoundFx.SFX"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\TuneF_Ska.pt3"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\TuneE_DnB.pt3"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\TuneD_HeavyMetal.pt3"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\TuneC.pt3"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\TuneB.pt3"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\TuneA.pt3"
  File "C:\Users\Kiwi\Documents\agdxstudio\Gems\TitleTune.pt3"
  ; Noughts and Crosses tutorial game
  SetOutPath "$DOCUMENTS\agdxstudio\Noughts and Crosses"
  File "C:\Users\Kiwi\Documents\agdxstudio\Noughts and Crosses\project.xml"
  File "C:\Users\Kiwi\Documents\agdxstudio\Noughts and Crosses\game.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Noughts and Crosses\gameplay.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Noughts and Crosses\images.inc"
  ; SabreWulf
  SetOutPath "$DOCUMENTS\agdxstudio\SabreWulf"
  File "C:\Users\Kiwi\Documents\agdxstudio\SabreWulf\project.xml"
  File "C:\Users\Kiwi\Documents\agdxstudio\SabreWulf\game.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\SabreWulf\map.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\SabreWulf\screen.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\SabreWulf\sprites.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\SabreWulf\tiles.inc"
  ; Space Invaders
  SetOutPath "$DOCUMENTS\agdxstudio\Space Invaders"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\project.xml"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\tables.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\strings.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\sprites.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\screen.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\font.inc"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\player.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\mothership.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\menu.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\libtext.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\libsprite.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\libscreen.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\libscore.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\libosb.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\libmath.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\libisr.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\libinput.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\libbeeper.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\game.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\aliens.asm"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\README.txt"
  File "C:\Users\Kiwi\Documents\agdxstudio\Space Invaders\license.txt"
  ; Z88DK demo
  SetOutPath "$DOCUMENTS\agdxstudio\z88dk"
  File "C:\Users\Kiwi\Documents\agdxstudio\z88dk\project.xml"
  File "C:\Users\Kiwi\Documents\agdxstudio\z88dk\main.c"
  ; Nivana Sprites
  SetOutPath "$DOCUMENTS\agdxstudio\Nivana Sprites"
  File "C:\Users\Kiwi\Documents\agdxstudio\Nivana Sprites\project.xml"
  File "C:\Users\Kiwi\Documents\agdxstudio\Nivana Sprites\MultiColorSprites.asm"
  SetOverwrite on
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  CreateShortCut "$SMPROGRAMS\agdxstudio\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\agdxstudio.exe"
  WriteRegStr HKCU "Software\Scorpio\agdxstudio\Plugins" "MachineFolder" "ZX Spectrum"
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "ImageEditor.tpi" 0x00000001
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "DesignEditor.tpi"  0x00000002
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "MapEditor.tpi"   0x00000003
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "StringEditor.tpi"   0x00000004
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "CodeEditor.tpi"  0x00000005
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "MusicEditor.tpi"  0x00000006
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "MemoryEditor.tpi"  0x00000007
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "DNL_ImageEditor.tpi" 0x00000000
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "DNL_MapEditor.tpi"   0x00000000
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "DNL_CodeEditor.tpi"  0x00000000
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "DNL_DesignEditor.tpi"  0x00000000
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "DNL_MusicEditor.tpi"  0x00000000
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "DNL_MemoryEditor.tpi"  0x00000000
  WriteRegDWORD HKCU "Software\Scorpio\agdxstudio\Plugins" "DNL_StringEditor.tpi"   0x00000000
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\agdxstudio.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "agdxstudio main application files."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "Editing and tool plugins. Include editors for Images, Maps, Text, and Coding."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} "Pasmo Z80 Assembler."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC04} "agdxstudio documentation. Includes the start of a Manual and the Getting Started Guide."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC05} "The Octin Stencil True Type Font."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC10} "Sinclair ZX Spectrum plugins and files."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC11} "Sinclair ZX Spectrum example projects including SabreWulf, Space Invaders, Gems, Noughts and Cross and more."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  ; Application Files
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\borlndmm.dll"
  Delete "$INSTDIR\BuildPresets.xml"
  Delete "$INSTDIR\cc3280mt.dll"
  ;Delete "$INSTDIR\libeay32.dll"
  ;Delete "$INSTDIR\ssleay32.dll"
  ;Delete "$INSTDIR\indy100.bpl"
  ;Delete "$INSTDIR\IndyCore100.bpl"
  ;Delete "$INSTDIR\IndyProtocols100.bpl"
  ;Delete "$INSTDIR\IndySystem100.bpl"
  Delete "$INSTDIR\Core_R6.dll"
  Delete "$INSTDIR\CoreUtils_R6.dll"
  Delete "$INSTDIR\ImageLibrary_R6.dll"
  Delete "$INSTDIR\LogFiles_R6.dll"
  Delete "$INSTDIR\PluginCommon_R6.dll"
  Delete "$INSTDIR\ReadMe.txt"
  Delete "$INSTDIR\rtl100.bpl"
  Delete "$INSTDIR\Scorpio_R6.bpl"
  Delete "$INSTDIR\Scintilla_R6.bpl"
  Delete "$INSTDIR\SciLexer.dll"
  Delete "$INSTDIR\Scitilla License.txt"
  Delete "$INSTDIR\agdxstudio.exe"
  Delete "$INSTDIR\agdxstudio.exe.manifest"
  Delete "$INSTDIR\dbrtl100.bpl"
  Delete "$INSTDIR\designide100.bpl"
  Delete "$INSTDIR\rtl100.bpl"
  Delete "$INSTDIR\vcl100.bpl"
  Delete "$INSTDIR\vclactnband100.bpl"
  Delete "$INSTDIR\vcldb100.bpl"
  Delete "$INSTDIR\vclx100.bpl"
  Delete "$INSTDIR\xmlrtl00.bpl"
  ; PASMO
  Delete "$INSTDIR\Pasmo\pasmo.exe"
  Delete "$INSTDIR\Pasmo\cc3280mt.dll"
  Delete "$INSTDIR\Pasmo\pasmodoc.html"
  Delete "$INSTDIR\Pasmo\NEWS"
  Delete "$INSTDIR\Pasmo\README"
  ; Plugins
  Delete "$INSTDIR\Plugins\AttributeImageParser.cpi"
  Delete "$INSTDIR\Plugins\CharacterType.ipi"
  Delete "$INSTDIR\Plugins\CodeEditor.tpi"
  Delete "$INSTDIR\Plugins\DesignEditor.tpi"
  Delete "$INSTDIR\Plugins\ImageEditor.tpi"
  Delete "$INSTDIR\Plugins\ImageImport.ipi"
  Delete "$INSTDIR\Plugins\ImageTools.ipi"
  Delete "$INSTDIR\Plugins\MapEditor.tpi"
  Delete "$INSTDIR\Plugins\MapParser.cpi"
  Delete "$INSTDIR\Plugins\PaintTools.ipi"
  Delete "$INSTDIR\Plugins\PaletteParser.cpi"
  Delete "$INSTDIR\Plugins\PaletteImageParser.cpi"
  Delete "$INSTDIR\Plugins\ScreenType.ipi"
  Delete "$INSTDIR\Plugins\SpriteType.ipi"
  Delete "$INSTDIR\Plugins\StringEditor.tpi"
  Delete "$INSTDIR\Plugins\StringTableParser.cpi"
  Delete "$INSTDIR\Plugins\TileType.ipi"
  ; ZX Spectrum Plugins
  Delete "$INSTDIR\Plugins\_ZX Spectrum\defaults.xml"
  Delete "$INSTDIR\Plugins\_ZX Spectrum\MonochromePalette.ipi"
  Delete "$INSTDIR\Plugins\_ZX Spectrum\SevenuPImageParser.cpi"
  Delete "$INSTDIR\Plugins\_ZX Spectrum\ZXImageTableParser.cpi"
  Delete "$INSTDIR\Plugins\_ZX Spectrum\ZXScreenParser.cpi"
  Delete "$INSTDIR\Plugins\_ZX Spectrum\ZXSpectrumPalette.ipi"
  ;Delete "$INSTDIR\Plugins\_ZX Spectrum\ZXSpectrumHiColourPalette.ipi"
  ;Delete "$INSTDIR\Plugins\_ZX Spectrum\ZXSpectrumUlaPlusPalette.ipi"
  Delete "$INSTDIR\Plugins\_ZX Spectrum\ZXSpectrumNext256Palette.ipi"
  ; Documentation
  Delete "$INSTDIR\agdxstudio.doc"
  Delete "$INSTDIR\Getting Started Guide.doc"
  Delete "$INSTDIR\WindowsAPI.log"
  Delete "$INSTDIR\Exception.log"
  Delete "$INSTDIR\Plugin.log"
  Delete "$INSTDIR\PluginCommon.log"
  Delete "$INSTDIR\General.log"
  Delete "$INSTDIR\LogFiles.log"
  ; Example Projects
  ;Delete "$INSTDIR\Projects\A - Z Screens\project.xml"
  ;Delete "$INSTDIR\Projects\Buddy\project.xml"
  ;Delete "$INSTDIR\Projects\Buddy\controls.asm"
  ;Delete "$INSTDIR\Projects\Buddy\icons.asm"
  ;Delete "$INSTDIR\Projects\Buddy\menus.asm"
  ;Delete "$INSTDIR\Projects\Buddy\startup.asm"
  ;Delete "$INSTDIR\Projects\Buddy\windows.asm"
  ;Delete "$INSTDIR\Projects\Buddy\caret_draw.inc"
  ;Delete "$INSTDIR\Projects\Buddy\caret_gfx.inc"
  ;Delete "$INSTDIR\Projects\Buddy\controls.inc"
  ;Delete "$INSTDIR\Projects\Buddy\desktop.inc"
  ;Delete "$INSTDIR\Projects\Buddy\display.inc"
  ;Delete "$INSTDIR\Projects\Buddy\font64.inc"
  ;Delete "$INSTDIR\Projects\Buddy\fontPro.inc"
  ;Delete "$INSTDIR\Projects\Buddy\gui_checkrect.inc"
  ;Delete "$INSTDIR\Projects\Buddy\gui_controls.inc"
  ;Delete "$INSTDIR\Projects\Buddy\icon_draw.inc"
  ;Delete "$INSTDIR\Projects\Buddy\icons.inc"
  ;Delete "$INSTDIR\Projects\Buddy\memory.inc"
  ;Delete "$INSTDIR\Projects\Buddy\menus.inc"
  ;Delete "$INSTDIR\Projects\Buddy\print_64.inc"
  ;Delete "$INSTDIR\Projects\Buddy\print_pro.inc"
  ;Delete "$INSTDIR\Projects\Gems\project.xml"
  ;Delete "$INSTDIR\Projects\Gems\window.inc"
  ;Delete "$INSTDIR\Projects\Gems\screen.inc"
  ;Delete "$INSTDIR\Projects\Gems\menu.inc"
  ;Delete "$INSTDIR\Projects\Gems\math.inc"
  ;Delete "$INSTDIR\Projects\Gems\isr.inc"
  ;Delete "$INSTDIR\Projects\Gems\images.inc"
  ;Delete "$INSTDIR\Projects\Gems\hiscoredata.inc"
  ;Delete "$INSTDIR\Projects\Gems\hiscore.inc"
  ;Delete "$INSTDIR\Projects\Gems\gameplay.inc"
  ;Delete "$INSTDIR\Projects\Gems\font.inc"
  ;Delete "$INSTDIR\Projects\Gems\control.inc"
  ;Delete "$INSTDIR\Projects\Gems\ay_player.inc"
  ;Delete "$INSTDIR\Projects\Gems\game.asm"
  ;Delete "$INSTDIR\Projects\Gems\game_logic.txt"
  ;Delete "$INSTDIR\Projects\Gems\The_Gem_Machine.SFX"
  ;Delete "$INSTDIR\Projects\Gems\SoundFx.SFX"
  ;Delete "$INSTDIR\Projects\Gems\TuneF_Ska.pt3"
  ;Delete "$INSTDIR\Projects\Gems\TuneE_DnB.pt3"
  ;Delete "$INSTDIR\Projects\Gems\TuneD_HeavyMetal.pt3"
  ;Delete "$INSTDIR\Projects\Gems\TuneC.pt3"
  ;Delete "$INSTDIR\Projects\Gems\TuneB.pt3"
  ;Delete "$INSTDIR\Projects\Gems\TuneA.pt3"
  ;Delete "$INSTDIR\Projects\Gems\TitleTune.pt3"
  ;Delete "$INSTDIR\Projects\Noughts and Crosses\project.xml"
  ;Delete "$INSTDIR\Projects\Noughts and Crosses\game.asm"
  ;Delete "$INSTDIR\Projects\Noughts and Crosses\gameplay.inc"
  ;Delete "$INSTDIR\Projects\Noughts and Crosses\images.inc"
  ;Delete "$INSTDIR\Projects\SabreWulf\project.xml"
  ;Delete "$INSTDIR\Projects\SabreWulf\game.asm"
  ;Delete "$INSTDIR\Projects\SabreWulf\map.inc"
  ;Delete "$INSTDIR\Projects\SabreWulf\screen.inc"
  ;Delete "$INSTDIR\Projects\SabreWulf\sprites.inc"
  ;Delete "$INSTDIR\Projects\SabreWulf\tiles.inc"
  ;Delete "$INSTDIR\Projects\Space Invaders\project.xml"
  ;Delete "$INSTDIR\Projects\Space Invaders\tables.inc"
  ;Delete "$INSTDIR\Projects\Space Invaders\strings.inc"
  ;Delete "$INSTDIR\Projects\Space Invaders\sprites.inc"
  ;Delete "$INSTDIR\Projects\Space Invaders\screen.inc"
  ;Delete "$INSTDIR\Projects\Space Invaders\font.inc"
  ;Delete "$INSTDIR\Projects\Space Invaders\player.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\mothership.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\menu.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\libtext.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\libsprite.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\libscreen.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\libscore.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\libosb.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\libmath.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\libisr.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\libinput.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\libbeeper.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\game.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\aliens.asm"
  ;Delete "$INSTDIR\Projects\Space Invaders\README.txt"
  ;Delete "$INSTDIR\Projects\Space Invaders\license.txt"
  ;Delete "$INSTDIR\Projects\z88dk\project.xml"
  ;Delete "$INSTDIR\Projects\z88dk\main.c"
  ;Delete "$INSTDIR\Projects\BigSprites\project.xml"
  ;Delete "$INSTDIR\Projects\BigSprites\game.asm"
  ;Delete "$INSTDIR\Projects\BigSprites\spritesxor.asm"
  ;Delete "$INSTDIR\Projects\BigSprites\spritesmasked.asm"
  ;Delete "$INSTDIR\Projects\BigSprites\libspritexor.asm"
  ;Delete "$INSTDIR\Projects\BigSprites\libspritemasked.asm"
  ;Delete "$INSTDIR\Projects\BigSprites\libinput.asm"
  ;Delete "$INSTDIR\Projects\BigSprites\libscreen.asm"
  ;Delete "$INSTDIR\Projects\BigSprites\debugstring.asm"
  ;Delete "$INSTDIR\Projects\BigSprites\background.inc"
  ;Delete "$INSTDIR\Projects\BigSprites\spritesxor.inc"
  ;Delete "$INSTDIR\Projects\BigSprites\spritesmasked.inc"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\project.xml"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\circle.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\clock.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\clock2.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\colors.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\fact.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\fill.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\flag.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\flights.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\freregustav.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\led.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\lines.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\pong.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\scroll.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\spfill.bas"
  ;Delete "$INSTDIR\Projects\Boriel Basic Demo\stars.bas"
  ;Delete "$INSTDIR\Projects\debugstring.asm"
  ; Program Links
  Delete "$SMPROGRAMS\agdxstudio\Uninstall.lnk"
  Delete "$DESKTOP\agdxstudio.lnk"
  Delete "$SMPROGRAMS\agdxstudio\agdxstudio.lnk"
  Delete "$SMPROGRAMS\agdxstudio\Getting Started Guide.lnk"
  Delete "$SMPROGRAMS\agdxstudio\agdxstudio Manual.lnk"
  ; Application Folders
  RMDir "$SMPROGRAMS\agdxstudio"
  RMDir /r "$INSTDIR"
  ; Registry
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  DeleteRegKey HKCU "Software\Scorpio\agdxstudio"
  SetAutoClose true
SectionEnd