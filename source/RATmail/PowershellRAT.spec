#####################################
# Software "OffSpring", versão 4.58 #
# OffSpring é uma ferramenta educa- #        
# cional projetada para conduzir    #
# testes simulados de penetração em #
# ambientes Windows exclusivamente. #
#####################################
# Este software destina-se única e  #
# exclusivamente a fins educacionais#
# e de pesquisa em segurança ciber- #
# nética. O autor não encoraja nem  #
# apoia a utilização deste software #
# para atividades ilegais ou malici-#
# osas.                             #
#####################################
# O autor declina qualquer respon-  #
# sabilidade por quaisquer conse-   #
# quências derivadas do uso deste   #
# software para fins não educacion- #
# ais ou não autorizados.           #
#####################################

# -*- mode: python ; coding: utf-8 -*-


a = Analysis(
    ['/source/RATmail/PowershellRAT.py'],
    pathex=[],
    binaries=[],
    datas=[],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='PowershellRAT',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
coll = COLLECT(
    exe,
    a.binaries,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='PowershellRAT',
)
