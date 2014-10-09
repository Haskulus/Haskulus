module Gui.Mainframe
	where

import Graphics.UI.WX

width = 640
height = 480

mainCallBack :: IO ()
mainCallBack = do
	
	-- Container Frame
	hkFrame <- frame [text:="Haskulus IDE", resizeable:=True]
	
	--Panels
	pTPanel <-panel hkFrame []  --pt stand for Project Tree
	
	--Other widgets
	
	pTLabel <- staticText pTPanel [text := "Projects"]  -- Temporary Label
	
	hkStatusBar <- statusField [text := "Haskell"]  -- Status Bar

	--MenuBar
	--File, Edit, Search, Run, Help
	--File
	fileMenuPane <- menuPane [text := "&File"]
	fNew <- menuItem fileMenuPane [text := "&New\tCtrl+N", help := "New"] -- help updates status bar text	
	fOpen <- menuItem fileMenuPane [text := "&Open\tCtrl+O", help := "Open"]
	fSave <- menuItem fileMenuPane [text := "&Save\tCtrl+S", help := "Save"]
	fSaveAs <- menuItem fileMenuPane [text := "&Save As\tCtrl+Shift+S", help := "Save as"]
        menuLine fileMenuPane
	fQuit <- menuItem  fileMenuPane [ text := "&Quit\tCtrl+Q",  help := "Quit the IDE"]

	
	--Edit
	
	editMenuPane <- menuPane [text := "&Edit"]
	eCut <- menuItem editMenuPane [text := "&Cut\tCtrl+X", help := "Cut"]	
	eCopy <- menuItem editMenuPane [text := "&Copy\tCtrl+C", help := "Copy"]
	ePaste <- menuItem editMenuPane [text := "&Paste\tCtrl+V", help := "Paste"]
        menuLine editMenuPane
	eUndo <- menuItem editMenuPane [text := "&Undo\tCtrl+Z", help := "Undo last action"]
	eRedo <- menuItem  editMenuPane [ text := "&Redo\tCtrl+Y",  help := "Redo last action"]
        
	--Search
	
	searchMenuPane <- menuPane [text := "&Search"]
	sFind <- menuItem searchMenuPane [text := "&Find\tCtrl+F", help := "Find"]	
	sReplace <- menuItem searchMenuPane [text := "&Replace\tCtrl+H", help := "Replace"]
	
	--Run	
	runMenuPane <- menuPane [text := "&Run"]
	rRunGhci <- menuItem runMenuPane [text := "&Run in ghci\tCtrl+G", help := "Run in ghci"]	
	rCompile <- menuItem runMenuPane [text := "&Compile\tCtrl+K", help := "Compile"]
 	rCompileAndRun <- menuItem runMenuPane [text := "&Compile and Run\tCtrl+Shift+R", help := "Compile and Run"]
	
	--Help 

	helpMenuPane <- menuPane [text := "&Help"]
 	hHelp <- menuItem helpMenuPane [text := "&Help\tF1", help := "Help"]
	hAbout <- menuItem helpMenuPane [text := "&About", help := "About"]	


	--Text area
	hkTextEditor <- textCtrl hkFrame [text := "module Main where \n\n main :: IO() \nmain = putStrLn \"Hello World\" "] 
	
	--Events

	set fQuit [ on command := close hkFrame]

	
	
	--GUI layout
	set pTPanel [bgcolor:=white,
		     layout := column 5 [floatCenter (widget pTLabel)],
		     clientSize := sz 100 height
		    ]
	set hkFrame [ menuBar := [fileMenuPane, editMenuPane, searchMenuPane, runMenuPane, helpMenuPane]]
	set hkFrame [statusBar := [hkStatusBar]]
	set hkFrame [layout := minsize (sz width height) $ row  5 [fill (widget pTPanel),fill (widget hkTextEditor)]] 
 

