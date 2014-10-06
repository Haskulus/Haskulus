module Gui.Mainframe
	where

import Graphics.UI.WX

width = 450
height = 400

mainCallBack :: IO ()
mainCallBack = do
	
	hkFrame <- frame [text:="Haskulus IDE", resizeable:=True]   --Container Frame
	
	hkLabel <- staticText hkFrame [text := "Label"]  -- Temporary Label
	
	hkStatusBar <- statusField [text := "Haskell"]  -- Status Bar

	--File, Edit, Search, Run, Help
	--File
	fileMenuPane <- menuPane [text := "&File"]
	fNew <- menuItem fileMenuPane [text := "&New\tCtrl+N", help := "New"] -- help updates status bar text	
	fOpen <- menuItem fileMenuPane [text := "&Open\tCtrl+O", help := "Open"]
	fSave <- menuItem fileMenuPane [text := "&Save\tCtrl+S", help := "Save"]
	fSaveAs <- menuItem fileMenuPane [text := "&Save As\tCtrl+Shift+S", help := "Save as"]
        menuLine fileMenuPane
	fQuit <- menuItem  fileMenuPane [ text := "&Quit\tCtrl+Q",  help := "Quit the IDE"]
        sQuit <- menuQuit fileMenuPane [ help := "Quit the IDE"]
	
	--Edit
	
	editMenuPane <- menuPane [text := "&Edit"]
	eCut <- menuItem editMenuPane [text := "&Cut\tCtrl+X", help := "Cut"]	
	eCopy <- menuItem editMenuPane [text := "&Copy\tCtrl+C", help := "Copy"]
	ePaste <- menuItem editMenuPane [text := "&Paste\tCtrl+V", help := "Paste"]
        menuLine editMenuPane
	eUndo <- menuItem editMenuPane [text := "&Undo\tCtrl+Z", help := "Undo last action"]
	eRedo <- menuItem  editMenuPane [ text := "&Redo\tCtrl+Y",  help := "Redo last action"]
   
	set fQuit [ on command := close hkFrame]
        set sQuit [ on command := close hkFrame]
	
	set hkFrame [ menuBar := [fileMenuPane,editMenuPane]]
	set hkFrame [statusBar := [hkStatusBar],layout := minsize (sz width height) $ column 5 [floatCenter (widget hkLabel)]] -- Gui layout
 

