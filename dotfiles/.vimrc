" Algemene Vim/Neovim instellingen die altijd geladen worden
" ----------------------------------------------------------

" Leader key
let mapleader = ' '


" ----------------------------------------------------------
" IdeaVim-specifieke instellingen (worden alleen in JetBrains geladen)
" ----------------------------------------------------------

if exists("g:ideavim")
    " Window management
    map <leader>wv <Action>(SplitVertically)
    map <leader>wh <Action>(SplitHorizontally)
    map <leader>ww <Action>(Unsplit)
    map <leader>wa <Action>(UnsplitAll)

    " Navigatie
    map <leader>sc <Action>(GotoClass)
    map <leader>sf <Action>(GotoFile)
    map <leader>ss <Action>(GotoSymbol)
    map <leader>sa <Action>(GotoAction)
    map <leader>gd <Action>(GotoDeclaration)
    map <leader>gy <Action>(GotoTypeDeclaration)
    map <leader>gi <Action>(GotoImplementation)
    map <leader>gt <Action>(GotoTest)
    map <leader>gm <Action>(GotoSuperMethod)
    map <leader>gl <Action>(GotoLine)

    " Zoekfunctionaliteiten
    map <leader>ug <Action>(FindUsages)
    map <leader>uu <Action>(ShowUsages)
    map <leader>vs <Action>(ViewSource)
    map <leader>im <Action>(QuickImplementations)
    map <leader>td <Action>(QuickTypeDefinition)
    map <leader>ti <Action>(ExpressionTypeInfo)
    map <leader>sh <Action>(ShowHoverInfo)
    map <leader>oo <Action>(FileStructurePopup)

    " Refactoring
    map <leader>rn <Action>(RenameElement)
    map <leader>rm <Action>(ExtractMethod)
    map <leader>rv <Action>(IntroduceVariable)
    map <leader>rf <Action>(IntroduceField)
    map <leader>rs <Action>(ChangeSignature)
    map <leader>rr <Action>(Refactorings.QuickListPopupAction)

    " Foutnavigatie
    map <leader>en <Action>(GotoNextError)
    map <leader>ep <Action>(GotoPreviousError)

    " Code formatting & imports
    map <leader><leader> <Action>(ReformatCode)
    map <leader>oi <Action>(OptimizeImports)
    map <leader>ra <Action>(RearrangeCode)

    " Lines verplaatsen
    map <C-k> <Action>(MoveLineDown)
    map <C-l> <Action>(MoveLineUp)
    map <C-i> <Action>(MoveStatementDown)
    map <C-o> <Action>(MoveStatementUp)

    " Bestandsacties
    map <leader>fs <Action>(NewScratchFile)
    map <leader>qq <Action>(CloseContent)
    map <leader>qa <Action>(CloseAllEditors)
    map <leader>nf <Action>(NewFile)
    map <leader>nd <Action>(NewDir)
    map <leader>re <Action>(RenameFile)
    map <leader>of <Action>(OpenFile)
    map <leader>ri <Action>(RestartIde)
endif
