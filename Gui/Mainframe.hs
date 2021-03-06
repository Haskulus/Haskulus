module Gui.Mainframe
	where

import Graphics.UI.WX
import Graphics.UI.WXCore
import System.IO
import System.Process
import System.Exit
width = 640
height = 480

--Global Variables



onClickSave frame textEditor  filePath = do
	     maybePath <-fileSaveDialog frame True False "Save File..."
	     		 [("Haskell file(*.hs)",["*.hs"])] "" ""
             case maybePath of
             		Nothing  -> return ()
             		Just path -> do 
             			     textCtrlSaveFile textEditor path
				     varSet filePath $ Just path	
             		

onClickOpen frame textEditor filePath = do
	     maybePath <-fileOpenDialog frame True False "Open File..."
	     		 [("Haskell file(*.hs)",["*.hs"]),("All files",["*.*"])] "" ""
             case maybePath of
             		Nothing  -> return ()
             		Just path -> do
				     textCtrlLoadFile textEditor path
				     varSet filePath $ Just path
				     print path


compileRun varGetPath = do
			maybePath <- varGet varGetPath
		       	case maybePath of
			   Nothing -> return ()
			   Just path -> do
					pid<-runCommand ("ghc "++path)
					waitForProcess pid 
					pid2 <-runCommand ("./"++(fst $ splitAt ((length path) -3) path))
					waitForProcess pid2 >>= exitWith
		       			putStrLn ""
			putStrLn ""

--onOpen :: String -> IO (TextCtrl ()) -> IO ()
{-onOpen path textEditor= do
		handle <- openFile path ReadMode
		contents <- hGetContents handle
		set textEditor [text := contents]
		hClose handle -}


mainCallBack :: IO ()
mainCallBack = do
	
	--Mutable Variables
	filePath <- varCreate $ Just "/"

	-- Container Frame
	hkFrame <- frame [text:="Haskulus IDE", resizeable:=True]
	
	--Panels
	pTPanel <-panel hkFrame []  --pt stands for Project Tree
	tBPanel <-panel hkFrame [] -- tB stands for task bar
	--Other widgets
	pTLabel <- staticText pTPanel [text := "Projects\t\t\t\t\t",visible:=True]  -- Temporary Label
	hkStatusBar <- statusField [text := "Haskell"]  -- Status Bar
	tBCompileRun <- button tBPanel [text := "Compile & Run"]

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
	set fSave [ on command := onClickSave hkFrame hkTextEditor filePath]
	set fQuit [ on command := close hkFrame]
	set fOpen [ on command := onClickOpen hkFrame hkTextEditor filePath]
	set tBCompileRun [ on command := compileRun filePath ]	
	
	--GUI layout
	set pTPanel [bgcolor:=white,
		    layout := column 5 [fill (widget pTLabel)],
		    visible:=True
		    ]
	set tBPanel [layout := row 5 [vfill (widget tBCompileRun)]]
		    
	set hkFrame [ menuBar := [fileMenuPane, editMenuPane, searchMenuPane, runMenuPane, helpMenuPane]]
	set hkFrame [statusBar := [hkStatusBar]]
	set hkFrame [layout := minsize (sz width height) $ column 5 [hfill (widget tBPanel), 
								     row  5 [vfill (widget pTPanel),fill 									    (widget hkTextEditor)]],visible :=True] 
								     
								     
								
								
--onClickSave::IO ()

		
    

