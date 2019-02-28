; Script generated by the HM NIS Edit Script Wizard.

SetCompressor /SOLID /FINAL lzma

!include FontRegAdv.nsh
!include FontName.nsh

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "AGDx Studio 64"
!define PRODUCT_VERSION "0.1.0 BETA"
!define PRODUCT_PUBLISHER "Tony Thompson"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\ADGx Studio 64"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 2.1 compatible ------
!include "MUI2.nsh"

!include LogicLib.nsh

;Request application privileges for Windows Vista
RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)
#RequestExecutionLevel user

!ifndef IPersistFile
!define IPersistFile {0000010b-0000-0000-c000-000000000046}
!endif
!ifndef CLSID_ShellLink
!define CLSID_ShellLink {00021401-0000-0000-C000-000000000046}
!define IID_IShellLinkA {000214EE-0000-0000-C000-000000000046}
!define IID_IShellLinkW {000214F9-0000-0000-C000-000000000046}
!define IShellLinkDataList {45e2b4ae-b1c3-11d0-b92f-00a0c90312e1}
	!ifdef NSIS_UNICODE
	!define IID_IShellLink ${IID_IShellLinkW}
	!else
	!define IID_IShellLink ${IID_IShellLinkA}
	!endif
!endif

; MUI Settings
;--------------------------------
;Interface Configuration

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "agdxstudio-installer-header.bmp" ; optional
!define MUI_WELCOMEFINISHPAGE_BITMAP "agdxstudio-installer-side.bmp"
!define MUI_COMPONENTSPAGE_CHECKBITMAP "${NSISDIR}\Contrib\Graphics\Checks\simple.bmp"
#!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_ABORTWARNING
!define MUI_ICON "icon.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\nsis3-uninstall.ico"
!define APP_DATA "C:\Users\Kiwi\AppData\Roaming\"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; Components page
#!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\AGDx Studio.exe"
#!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\ReadMe.txt"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME} ${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES64\${PRODUCT_NAME}"
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
Section "Fonts" SEC00
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
  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\AGDx Studio.exe"
  push "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk"
  call ShellLinkSetRunAs
  pop $0
  DetailPrint HR=$0
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\AGDx Converter.lnk" "$INSTDIR\AGD Converter.exe"
  push "$SMPROGRAMS\${PRODUCT_NAME}\AGDx Converter.lnk"
  call ShellLinkSetRunAs
  pop $0
  DetailPrint HR=$0
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\AGDx Studio.exe"  
  push "$DESKTOP\${PRODUCT_NAME}.lnk"
  call ShellLinkSetRunAs
  pop $0
  DetailPrint HR=$0
  File "..\Binaries\64\AGDx Studio.exe"
  File "..\Binaries\64\AGDx-Studio.dll"
  File "..\Binaries\64\AGD Converter.exe"
  File "..\Binaries\64\borlndmm.dll"
  File "..\Binaries\64\cc64260.dll"
  File "..\Binaries\64\cc64260mt.dll"
  File "..\Binaries\64\lmdrtcore260.bpl"
  File "..\Binaries\64\lmdrtdocking260.bpl"
  File "..\Binaries\64\lmdrtelcore260.bpl"
  File "..\Binaries\64\lmdrtinspector260.bpl"
  File "..\Binaries\64\lmdrtl260.bpl"
  File "..\Binaries\64\lmdrtlog260.bpl"
  File "..\Binaries\64\lmdrtprint260.bpl"
  File "..\Binaries\64\lmdrtrtlx260.bpl"
  File "..\Binaries\64\lmdrtsyntax260.bpl"
  File "..\Binaries\64\rtl260.bpl"
  File "..\Binaries\64\vcl260.bpl"
  File "..\Binaries\64\vclactnband260.bpl"
  File "..\Binaries\64\vclimg260.bpl"
  File "..\Binaries\64\vclsmp260.bpl"
  File "..\Binaries\64\vclx260.bpl"
  SetOverwrite off
SectionEnd

; AGDx Studio definition files
Section "Configuration Files" SEC02
  SetOverwrite on
  SetShellVarContext current
  CreateDirectory "$APPDATA\AGDx Studio\"
  SetOutPath "$APPDATA\AGDx Studio\"
  File "${APP_DATA}\AGDx Studio\AGDX Commands.csv"  
  File "${APP_DATA}\AGDx Studio\File Definitions.json"
  File "${APP_DATA}\AGDx Studio\Mru.json"
  File "${APP_DATA}\AGDx Studio\Settings.json"
  CreateDirectory "$APPDATA\AGDx Studio\GraphicsModes\"
  SetOutPath "$APPDATA\AGDx Studio\GraphicsModes\"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Acorn Atom 4 Colour.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Acorn Atom Monochrome.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Amstrad CPC Mode 0.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Amstrad CPC Mode 1.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Amstrad CPC Mode 2.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\BBC Micro Mode 0.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\BBC Micro Mode 1.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\BBC Micro Mode 2.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\BBC Micro Mode 4.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\BBC Micro Mode 5.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Dragon PMODE3.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Dragon PMODE4.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Enterprise Mode 0.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Sam Coupe Mode 1.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Sam Coupe Mode 2.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Sega Master System Mode 4.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\Sinclair QL Mode 8.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\ZX Spectrum Colour.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\ZX Spectrum Monochrome.json"
  File "${APP_DATA}\AGDx Studio\GraphicsModes\ZX Spectrum ULA+.json"
  CreateDirectory "$APPDATA\AGDx Studio\Machines\"
  SetOutPath "$APPDATA\AGDx Studio\Machines\"
  File "${APP_DATA}\AGDx Studio\Machines\Acorn Atom 128x192 4 Colour.json"
  File "${APP_DATA}\AGDx Studio\Machines\Acorn Atom 256x192 Monochrome.json"
  File "${APP_DATA}\AGDx Studio\Machines\Amstrad CPC 160x200 16 Colour.json"
  File "${APP_DATA}\AGDx Studio\Machines\BBC Micro 160x256 16 Colour.json"
  File "${APP_DATA}\AGDx Studio\Machines\BBC Micro 320x256 4 Colour.json"
  File "${APP_DATA}\AGDx Studio\Machines\Dragon 128x192 4 Colour.json"
  File "${APP_DATA}\AGDx Studio\Machines\Dragon 256x192 Monochrome.json"
  File "${APP_DATA}\AGDx Studio\Machines\Sam Coupe 256x192 16 Colour Mode 2.json"
  File "${APP_DATA}\AGDx Studio\Machines\Sega Master System 256x192 16 Colour.json"
  File "${APP_DATA}\AGDx Studio\Machines\Sinclair QL 256x256 8 Colour.json"
  File "${APP_DATA}\AGDx Studio\Machines\ZX Spectrum 256x192 16 Colour.json"
  File "${APP_DATA}\AGDx Studio\Machines\ZX Spectrum 256x192 ULA+.json"
  CreateDirectory "$APPDATA\AGDx Studio\Palettes\"
  SetOutPath "$APPDATA\AGDx Studio\Palettes\"
  File "${APP_DATA}\AGDx Studio\Palettes\Acorn Atom 4 Colour.json"
  File "${APP_DATA}\AGDx Studio\Palettes\Acorn Atom Monochrome.json"
  File "${APP_DATA}\AGDx Studio\Palettes\Amstrad CPC.json"
  File "${APP_DATA}\AGDx Studio\Palettes\BBC Micro.json"
  File "${APP_DATA}\AGDx Studio\Palettes\Dragon 4 Colour.json"
  File "${APP_DATA}\AGDx Studio\Palettes\Dragon Monochrome.json"
  File "${APP_DATA}\AGDx Studio\Palettes\Monochrome.json"
  File "${APP_DATA}\AGDx Studio\Palettes\Sam Coupe Mode 1+2.json"
  File "${APP_DATA}\AGDx Studio\Palettes\Sega Master System.json"
  File "${APP_DATA}\AGDx Studio\Palettes\Sinclair QL 8 Colour.json"
  File "${APP_DATA}\AGDx Studio\Palettes\ZX Spectrum Next 256.json"
  File "${APP_DATA}\AGDx Studio\Palettes\ZX Spectrum ULA+.json"
  File "${APP_DATA}\AGDx Studio\Palettes\ZX Spectrum.json"
  CreateDirectory "$APPDATA\AGDx Studio\Styles\"
  SetOutPath "$APPDATA\AGDx Studio\Styles\"
  File "${APP_DATA}\AGDx Studio\Styles\Amakrits.vsf"  
  File "${APP_DATA}\AGDx Studio\Styles\Amethyst Kamri.vsf"  
  File "${APP_DATA}\AGDx Studio\Styles\Aqua Graphite.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Aqua Light Slate 2.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Aqua Light Slate.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Auric.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Carbon.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Charcoal Dark Slate.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Cobalt XE Media.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Copper Dark.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Copper.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Coral.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Cyan Dusk.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Cyan Night.vsf"  
  File "${APP_DATA}\AGDx Studio\Styles\Diamond.vsf"  
  File "${APP_DATA}\AGDx Studio\Styles\Emerald Light Slate.vsf" 
  File "${APP_DATA}\AGDx Studio\Styles\Emerald.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Glossy 2.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Glossy.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Glow.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Golden Graphite.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Iceberg Classico.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Jet.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Lavender Classico.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Light.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Luna.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Metropolis UI Black.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Metropolis UI Blue.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Metropolis UI Dark.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Metropolis UI Green.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Obsidian.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Radiant.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Ruby Graphite.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Sapphire Kamri.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Silver.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Sky 2.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Sky.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Slate Classico.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Smokey Quartz Kamri.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Tablet Dark.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Tablet Light.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Turquoise Gray.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Vapor.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Windows 10 Blue.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Windows 10 Dark.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Windows 10 Green.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Windows 10 Purple.vsf"
  File "${APP_DATA}\AGDx Studio\Styles\Windows 10 Slate Gray.vsf"  
  File "${APP_DATA}\AGDx Studio\Styles\Windows 10.vsf"
  CreateDirectory "$APPDATA\AGDx Studio\Coding Templates\"
  SetOutPath "$APPDATA\AGDx Studio\Coding Templates\"
  File "${APP_DATA}\AGDx Studio\Coding Templates\BouncingEnemy.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\ControlMenuCPC.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\ControlMenuSpectrum.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\FlashingCollectable.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\HorizontalPatrol.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\LaddersAndLevels.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\LaddersAndLevelsEnemyPursuers.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\MainLoopClock.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\MainLoopTimeBar.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\ManicMiner.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\PlayerRocketMan.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\PushableBlocks.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\StaticCollectable.AGD"
  File "${APP_DATA}\AGDx Studio\Coding Templates\VerticalPatrol.AGD"
  CreateDirectory "$APPDATA\AGDx Studio\Compilers\"
  CreateDirectory "$APPDATA\AGDx Studio\GraphicsModes\Acorn Atom\"
  SetOutPath "$APPDATA\AGDx Studio\Compilers\Acorn Atom\"
  File "${APP_DATA}\AGDx Studio\Compilers\Acorn Atom\CompilerAtom.exe"
  File "${APP_DATA}\AGDx Studio\Compilers\Acorn Atom\engine.inc"
  CreateDirectory "$APPDATA\AGDx Studio\GraphicsModes\Amstrad CPC\"
  SetOutPath "$APPDATA\AGDx Studio\Compilers\Amstrad CPC\"
  File "${APP_DATA}\AGDx Studio\Compilers\Amstrad CPC\CompilerCPC.exe"
  File "${APP_DATA}\AGDx Studio\Compilers\Amstrad CPC\EngineCPC.asm"
  CreateDirectory "$APPDATA\AGDx Studio\GraphicsModes\Dragon\"
  SetOutPath "$APPDATA\AGDx Studio\Compilers\Dragon\"
  File "${APP_DATA}\AGDx Studio\Compilers\Dragon\CompilerDragon.exe"
  File "${APP_DATA}\AGDx Studio\Compilers\Dragon\engine.inc"
  CreateDirectory "$APPDATA\AGDx Studio\GraphicsModes\Enterprise\"
  SetOutPath "$APPDATA\AGDx Studio\Compilers\Enterprise\"
  File "${APP_DATA}\AGDx Studio\Compilers\Enterprise\CompilerEP.exe"
  File "${APP_DATA}\AGDx Studio\Compilers\Enterprise\EngineEP.asm"
  CreateDirectory "$APPDATA\AGDx Studio\GraphicsModes\ZX Spectrum\"
  CreateDirectory "$APPDATA\AGDx Studio\GraphicsModes\ZX Spectrum\0.7.0\"
  SetOutPath "$APPDATA\AGDx Studio\Compilers\ZX Spectrum\0.7.0\"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\0.7.0\CompilerZX.exe"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\0.7.0\EngineZX.asm"
  CreateDirectory "$APPDATA\AGDx Studio\GraphicsModes\ZX Spectrum\0.7.2\"
  SetOutPath "$APPDATA\AGDx Studio\Compilers\ZX Spectrum\0.7.2\"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\0.7.2\CompilerZX.exe"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\0.7.2\EngineZX.asm"
  CreateDirectory "$APPDATA\AGDx Studio\GraphicsModes\ZX Spectrum\0.7.3\"
  SetOutPath "$APPDATA\AGDx Studio\Compilers\ZX Spectrum\0.7.3\"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\0.7.3\CompilerZX.exe"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\0.7.3\EngineZX.asm"
  CreateDirectory "$APPDATA\AGDx Studio\Images\"
  SetOutPath "$APPDATA\AGDx Studio\Images\"
  File "${APP_DATA}\AGDx Studio\Images\Acorn Atom.png"
  File "${APP_DATA}\AGDx Studio\Images\Acorn Atom2.png"
  File "${APP_DATA}\AGDx Studio\Images\Amstrad CPC.png"
  File "${APP_DATA}\AGDx Studio\Images\Amstrad CPC2.png"
  File "${APP_DATA}\AGDx Studio\Images\BBC.png"
  File "${APP_DATA}\AGDx Studio\Images\BBC2.png"
  File "${APP_DATA}\AGDx Studio\Images\BBC3.png"
  File "${APP_DATA}\AGDx Studio\Images\Dragon.png"
  File "${APP_DATA}\AGDx Studio\Images\Sam Coupe.png"
  File "${APP_DATA}\AGDx Studio\Images\Spectrum Next.png"
  File "${APP_DATA}\AGDx Studio\Images\Timex.png"
  File "${APP_DATA}\AGDx Studio\Images\ZX Spectrum.png"
  File "${APP_DATA}\AGDx Studio\Images\ZX Spectrum2.png"
SectionEnd


; Project Files
Section "Example Projects" SEC03
  SetShellVarContext all
  CreateDirectory "$DOCUMENTS\AGDx Studio\Projects\Foggy\"
  SetOutPath "$DOCUMENTS\AGDx Studio\Projects\Foggy\"
  SetOverwrite off
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Foggy.agdx"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Collect block.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Completed game.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Fell too far.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Game initialisation.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Initialise sprite.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Introduction menu.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Kill player.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Lost game.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Main loop 1.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Main loop 2.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\New high score.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Player control.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Restart screen.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite type 1.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite type 2.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite type 3.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite type 4.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite type 5.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite type 6.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite type 7.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite type 8.event"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Controls.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Game Font.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\JumpTable.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 1.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 2.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 3.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 4.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 5.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 6.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 7.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 8.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 9.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 10.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 11.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 12.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 13.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 14.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 15.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 16.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 17.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 18.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 19.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Object 20.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 1.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 2.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 3.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 4.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 5.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 6.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 7.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 8.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 9.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 10.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sprite 11.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 1.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 2.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 3.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 4.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 5.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 6.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 7.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 8.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 9.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 10.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 11.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 12.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 13.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 14.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 15.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 16.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 17.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 18.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 19.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 20.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 21.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 22.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 23.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 24.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 25.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 26.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 27.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 28.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 29.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 30.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 31.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 32.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 33.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 34.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 35.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 36.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 37.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 38.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 39.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 40.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 41.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 42.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 43.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 44.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 45.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 46.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 47.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 48.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 49.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 51.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 52.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 53.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 54.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 55.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 56.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 57.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 58.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 59.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 60.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 61.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 62.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 63.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 64.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 65.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 66.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 67.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 68.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 69.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 70.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 71.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 72.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 73.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 74.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 75.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 76.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 77.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 78.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile 79.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Tile Map.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Window.json"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Sound effects.sfx"
  File "C:\Users\Public\Documents\AGDx Studio\Projects\Foggy\Messages.txt"
SectionEnd

; pasmo
Section "Pasmo" SEC04
  SetOverwrite on
  SetShellVarContext current
  CreateDirectory "$APPDATA\AGDx Studio\Compilers\ZX Spectrum\Pasmo\"
  SetOutPath "$APPDATA\AGDx Studio\Compilers\ZX Spectrum\Pasmo\"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Pasmo\NEWS"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Pasmo\pasmo.exe"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Pasmo\pasmodoc.html"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Pasmo\README"
SectionEnd

; ZX Spin
Section "ZX Spin" SEC05
  SetOverwrite on
  SetShellVarContext current
  CreateDirectory "$APPDATA\AGDx Studio\Compilers\ZX Spectrum\Spin\"
  SetOutPath "$APPDATA\AGDx Studio\Compilers\ZX Spectrum\Spin\"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\48.ROM"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\128.ROM"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\atapi.dll"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\csw.dll"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\Default.spincfg"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\fdc765.dll"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\Spin.bin"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\Spin.ini"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\SpinNet.cfg"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\szx.dll"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\UnzDll.dll"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\wd1793.dll"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\whatsnew.txt"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\ZipDll.dll"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\zlib1.dll"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\ZXSpin keys.txt"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\ZXSpin.exe"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\ZXSpin.exe.manifest"
  File "${APP_DATA}\AGDx Studio\Compilers\ZX Spectrum\Spin\ZXSpin.hlp"
SectionEnd


; Documentation
;Section "Documentation" SEC06
;  SetOutPath "$INSTDIR"
;SectionEnd


Section -AdditionalIcons
  SetOutPath $INSTDIR
  CreateShortCut "$SMPROGRAMS\agdxstudio\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\AGDx Studio.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\AGDx Studio.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "AGDx Studi main application files."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "Configuration Files."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} "Example Projects."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC04} "Pasmo (ZX Spectrum Assembler)."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC05} "ZX Spin (ZX Spectrum emulator."
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
  Delete "$INSTDIR\AGDx Studio.exe"
  Delete "$INSTDIR\AGDx-Studio.dll"
  Delete "$INSTDIR\borlndmm.dll"
  Delete "$INSTDIR\cc32x260.dll"
  Delete "$INSTDIR\cc32x260mt.bpl"
  Delete "$INSTDIR\32260.dll"
  Delete "$INSTDIR\32260mt.dll"
  Delete "$INSTDIR\lmdrtcore260.bpl"
  Delete "$INSTDIR\lmdrtdocking260.bpl"
  Delete "$INSTDIR\lmdrtelcore260.bpl"
  Delete "$INSTDIR\lmdrtinspector260.bpl"
  Delete "$INSTDIR\lmdrtl260.bpl"
  Delete "$INSTDIR\lmdrtlog260.bpl"
  Delete "$INSTDIR\lmdrtprint260.bpl"
  Delete "$INSTDIR\lmdrtxl260.bpl"
  Delete "$INSTDIR\lmdrtsyntax260.bpl"
  Delete "$INSTDIR\rtl260.bpl"
  Delete "$INSTDIR\vcl260.bpl"
  Delete "$INSTDIR\vclactnband260.bpl"
  Delete "$INSTDIR\vclimg260.bpl"
  Delete "$INSTDIR\vclwinx260.bpl"
  Delete "$INSTDIR\vclx260.bpl"

  ; Application Folders
  RMDir "$SMPROGRAMS\${PRODUCT_NAME}"
  RMDir /r "$INSTDIR"
  ; Registry
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd

Function ShellLinkSetRunAs
System::Store S
pop $9
System::Call "ole32::CoCreateInstance(g'${CLSID_ShellLink}',i0,i1,g'${IID_IShellLink}',*i.r1)i.r0"
${If} $0 = 0
	System::Call "$1->0(g'${IPersistFile}',*i.r2)i.r0" ;QI
	${If} $0 = 0
		System::Call "$2->5(w '$9',i 0)i.r0" ;Load
		${If} $0 = 0
			System::Call "$1->0(g'${IShellLinkDataList}',*i.r3)i.r0" ;QI
			${If} $0 = 0
				System::Call "$3->6(*i.r4)i.r0" ;GetFlags
				${If} $0 = 0
					System::Call "$3->7(i $4|0x2000)i.r0" ;SetFlags ;SLDF_RUNAS_USER
					${If} $0 = 0
						System::Call "$2->6(w '$9',i1)i.r0" ;Save
					${EndIf}
				${EndIf}
				System::Call "$3->2()" ;Release
			${EndIf}
		System::Call "$2->2()" ;Release
		${EndIf}
	${EndIf}
	System::Call "$1->2()" ;Release
${EndIf}
push $0
System::Store L
FunctionEnd