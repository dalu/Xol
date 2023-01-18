#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  // insert mbs registration
		  
		  'if not registerMBSPlugin(n, p, e, s+t) then  
		  'MsgBox "MBS Plugin serial not valid?"  
		  'end if  
		  
		  if TargetMachO=false then
		    MsgBox "This example needs a MachO target running on Mac OS X."
		    quit
		  end if
		  
		  var f as FolderItem
		  app.e=new MyCocoaStatusItemMBS
		  if not app.e.Available then
		    MsgBox "Cocoa not loaded."
		  end if
		  
		  
		  myview = new NSViewMBS(0,0,150,20)
		  mytext = new MyNSTextFieldMBS(20, 0, 110, 20)
		  mytext.StringValue = "He" 
		  myview.addSubview mytext
		  
		  
		  app.showDocXol = true
		  app.counter = 0
		  app.xol = new Dictionary()
		  app.xolMin = new Dictionary()
		  app.linksMisc = new Dictionary ()
		  app.linksMBS = new Dictionary ()
		  app.linksEin = new Dictionary ()
		  app.linksTopics = new Dictionary ()
		  app.searchMBS = true
		  app.searchEin = true
		  
		  defaultURL = "https://documentation.xojo.com/index.html"
		  
		  createMenu
		  PopulateMain
		  populateLinks
		  populateLinks2
		  populateLinks3
		  
		  app.xolMin = app.xol.Clone
		  
		  buildWordList
		  
		  'PList 
		  'LSUIElement = true
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub addHistory(whichItem as string)
		  var f as NSMenuItemMBS
		  var m,mm as NSMenuMBS
		  var mh as MyCocoaMenuItemMBS
		  var wCounter as integer
		  
		  wCounter = app.itemsHistory.count
		  
		  if wCounter < 100 then
		    mh=new MyCocoaMenuItemMBS
		    mh.CreateMenuItem whichItem
		    mh.Enabled=true
		    mh.state=0
		    mh.Tag=4000+wCounter+1 
		    app.itemsHistory.Append mh
		    mHistory.AddItem mh
		    
		    mm=app.e.menu
		    
		  else
		    msgbox ("Xol will clear history to reduce memory")
		    mh=new MyCocoaMenuItemMBS
		    mh.CreateMenuItem whichItem
		    mh.Enabled=true
		    mh.state=0
		    mh.Tag=4000 
		    
		    app.itemsHistory.RemoveAll
		    app.itemsHistory.Append mh
		    
		    mHistory = new MyCocoaMenuMBS 
		    mHistory.AddItem mh
		    
		  end if
		  
		  
		  
		  mm=app.e.menu
		  
		  f=mm.Item(4)
		  
		  f.Submenu=mHistory
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addSubMenu(insertAt as integer, numberLines as integer)
		  var m,mm as NSMenuMBS
		  var f as NSMenuItemMBS
		  var a as MyCocoaMenuItemMBS
		  var n as integer
		  
		  
		  m=new NSMenuMBS
		  mm=new NSMenuMBS
		  f = new NSMenuItemMBS
		  
		  
		  counter = (links.KeyCount ) // count language entries
		  n = counter - numberLines
		  
		  for n =  (counter - numberLines) to (counter-1)
		    'var menuItem As DictionaryEntry 
		    'links.Key(i)
		    a=new MyCocoaMenuItemMBS
		    a.CreateMenuItem (links.Key(n))
		    'a.CreateMenuItem menuItem.Key
		    'links.Key(i) menuItem.
		    a.Enabled=true
		    a.tag=counter+n+1000
		    app.items.Append a
		    m.AddItem a
		    
		  next
		  
		  
		  
		  
		  
		  mm=app.e.menu
		  f=mm.Item(insertAt+5)
		  f.Submenu=m
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addSubMenuMisc(insertAt as integer, numberLines as integer)
		  var m,mm as NSMenuMBS
		  var f as NSMenuItemMBS
		  var a as MyCocoaMenuItemMBS
		  var n as integer
		  
		  
		  m=new NSMenuMBS
		  mm=new NSMenuMBS
		  f = new NSMenuItemMBS
		  
		  
		  counterMisc = (linksMisc.KeyCount ) // count misc entries
		  n = counterMisc - numberLines
		  
		  for n =  (counterMisc - numberLines) to (counterMisc-1)
		    'var menuItem As DictionaryEntry 
		    'links.Key(i)
		    a=new MyCocoaMenuItemMBS
		    a.CreateMenuItem (linksMisc.Key(n))
		    'a.CreateMenuItem menuItem.Key
		    'links.Key(i) menuItem.
		    a.Enabled=true
		    a.tag=counterMisc+n+5000
		    app.items.Append a
		    m.AddItem a
		    
		  next
		  
		  
		  mm=app.e.menu
		  f=mm.Item(insertAt+4)
		  f.Submenu=m
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addSubMenuTopics(insertAt as integer, numberLines as integer)
		  var m,mm as NSMenuMBS
		  var f as NSMenuItemMBS
		  var a as MyCocoaMenuItemMBS
		  var n as integer
		  
		  
		  m=new NSMenuMBS
		  mm=new NSMenuMBS
		  f = new NSMenuItemMBS
		  
		  
		  counterMisc = (linksMisc.KeyCount ) // count misc entries
		  n = counterMisc - numberLines
		  
		  for n =  (counterMisc - numberLines) to (counterMisc-1)
		    'var menuItem As DictionaryEntry 
		    'links.Key(i)
		    a=new MyCocoaMenuItemMBS
		    a.CreateMenuItem (linksMisc.Key(n))
		    'a.CreateMenuItem menuItem.Key
		    'links.Key(i) menuItem.
		    a.Enabled=true
		    a.tag=counterMisc+n+5000
		    app.items.Append a
		    m.AddItem a
		    
		  next
		  
		  
		  mm=app.e.menu
		  f=mm.Item(insertAt+4)
		  f.Submenu=m
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addXol(howMany as integer)
		  var n as integer
		  
		  counter = app.links.KeyCount  // count links entries
		  
		  n = counter - howMany
		  
		  for n =  (counter - howMany) to (counter-1)
		    xol.Value(app.links.key(n)) = app.links.key(n)
		    
		  next
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addXolEin(howMany as integer)
		  var n as integer
		  
		  counter = app.linksEin.KeyCount  
		  
		  n = counter - howMany
		  
		  for n =  (counter - howMany) to (counter-1)
		    xol.Value(app.linksEin.key(n)) = app.linksEin.key(n)
		    
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addXolMBS(howMany as integer)
		  var n as integer
		  
		  counter = app.linksMBS.KeyCount  
		  
		  n = counter - howMany
		  
		  for n =  (counter - howMany) to (counter-1)
		    xol.Value(app.linksMBS.key(n)) = app.linksMBS.key(n)
		    
		  next
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub buidEinMenu()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub buildWordList()
		  var j, counterDict as Integer
		  var wWord as String
		  var wWordDict as Dictionary
		  
		  
		  j = 1
		  counterDict = app.links.KeyCount
		  
		  wWord = "aaa"
		  
		  app.wordList.RemoveAll
		  
		  'wWordDict = new Dictionary ()
		  'wWordDict = app.xol.Clone
		  
		  if app.searchMbs then 
		    PopulateLinksMBS 
		    'app.xolMin = app.xol.clone
		  else
		    app.xol = app.xolMin.clone
		  end if
		  
		  'msgbox("xolmin"+str(app.xolMin.KeyCount))
		  
		  
		  'app.xol = app.xolMin
		  
		  
		  if app.searchEin then 
		    PopulateLinksEin
		    'app.xolMin = app.xol.clone
		  else
		    'app.xol = app.xolMin.clone
		  end if
		  
		  
		  
		  
		  For Each entry As DictionaryEntry In app.xol
		    
		    'languageList.AddRow app.links.Key(i)
		    'Var entry As string = entry.Value
		    
		    wWord = entry.key
		    app.wordList.Add wWord
		    
		    'languageList.AddRow wWord
		    
		  Next
		  
		  app.wordList.Sort
		  
		  counterDict = app.wordList.Count
		  
		  'msgbox( str(counterDict) )
		  
		  
		  
		  // 921
		  
		  // 3691 with mBS
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub createMenu()
		  dim p,m as Picture
		  dim s as String
		  dim img as NSImageMBS
		  
		  if not e.CreateMenu(-1) then
		    break
		  end if
		  
		  
		  
		  
		  
		  e.Title="Xol"
		  e.HighlightMode=true // clickable
		  
		  p = greenmenu
		  'p.Graphics.ForeColor=&c5BB57300
		  'p.Graphics.fillrect 0,0,10,10
		  'p.Graphics.ForeColor=rgb(0,255,0)
		  'p.Graphics.fillrect 10,0,10,10
		  'p.Graphics.ForeColor=rgb(0,0,255)
		  'p.Graphics.fillrect 20,0,10,10
		  'p.Graphics.ForeColor=rgb(0,0,0)
		  'p.Graphics.fillrect 30,0,10,10
		  'p.Graphics.ForeColor=rgb(127,0,0)
		  'p.Graphics.fillrect 40,0,10,10
		  'p.Graphics.ForeColor=rgb(0,127,0)
		  'p.Graphics.fillrect 50,0,10,10
		  'p.Graphics.ForeColor=rgb(0,0,127)
		  'p.Graphics.fillrect 60,0,10,10
		  
		  'm = new picture(10,10,32) // Mask
		  m = greenmenu
		  'm.Graphics.ForeColor=rgb(0,0,0) // full
		  'm.Graphics.FillRect 0,0,30,10
		  'm.Graphics.ForeColor=rgb(127,127,127) // half
		  'm.Graphics.FillRect 40,0,30,10
		  'm.Graphics.ForeColor=rgb(255,255,255) // nothing
		  'm.Graphics.FillRect 30,0,10,10
		  
		  img=new NSImageMBS(p,m)
		  
		  e.Image=img
		  
		  '// New in 10.3, an alternative picture:
		  '
		  'p = new picture(70,10,32)
		  ''p.Graphics.ForeColor=rgb(255,255,255) // first white
		  ''p.Graphics.fillrect 0,0,10,10
		  ''p.Graphics.ForeColor=rgb(0,255,0)
		  ''p.Graphics.fillrect 10,0,10,10
		  ''p.Graphics.ForeColor=rgb(0,0,255)
		  ''p.Graphics.fillrect 20,0,10,10
		  ''p.Graphics.ForeColor=rgb(0,0,0)
		  ''p.Graphics.fillrect 30,0,10,10
		  ''p.Graphics.ForeColor=rgb(127,0,0)
		  ''p.Graphics.fillrect 40,0,10,10
		  ''p.Graphics.ForeColor=rgb(0,127,0)
		  ''p.Graphics.fillrect 50,0,10,10
		  ''p.Graphics.ForeColor=rgb(0,0,127)
		  ''p.Graphics.fillrect 60,0,10,10
		  '
		  'm = new picture(70,10,32) // Mask
		  ''m.Graphics.ForeColor=rgb(0,0,0) // full
		  ''m.Graphics.FillRect 0,0,30,10
		  ''m.Graphics.ForeColor=rgb(127,127,127) // half
		  ''m.Graphics.FillRect 40,0,30,10
		  ''m.Graphics.ForeColor=rgb(255,255,255) // nothing
		  ''m.Graphics.FillRect 30,0,10,10
		  '
		  'img=new NSImageMBS(p,m)
		  '
		  ''e.AlternateImage=img
		  
		  const NSLeftMouseDownMask    = &h00002
		  const NSLeftMouseUpMask      = &H00004
		  const NSLeftMouseDraggedMask = &h00040
		  const NSPeriodicMask         = &h10000
		  
		  e.SendActionOn NSLeftMouseDownMask+NSLeftMouseUpMask
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub displayDoc()
		  
		  
		  if app.showDocXol  then
		    WinDoc.show
		    WinDoc.updateViewer
		  else
		    System.GotoURL app.wLink
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocateEin()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub populateLinks()
		  
		  
		  // code_execution
		  
		  'links.Value("")="https://documentation.xojo.com/api/code_execution/index.html"
		  
		  links.Value("AddHandler")="https://documentation.xojo.com/api/code_execution/addhandler.html"
		  links.Value("Assigns")="https://documentation.xojo.com/api/code_execution/assigns.html"
		  links.Value("Break")="https://documentation.xojo.com/api/code_execution/break.html"
		  links.Value("Call")="https://documentation.xojo.com/api/code_execution/call.html"
		  links.Value("Catch")="https://documentation.xojo.com/api/code_execution/catch.html"
		  links.Value("Commenting")="https://documentation.xojo.com/api/code_execution/commenting.html"
		  links.Value("Continue")="https://documentation.xojo.com/api/code_execution/continue.html"
		  links.Value("CriticalSection")="https://documentation.xojo.com/api/code_execution/criticalsection.html"
		  links.Value("Destructor")="https://documentation.xojo.com/api/code_execution/destructor.html"
		  links.Value("Do...Loop")="https://documentation.xojo.com/api/code_execution/do...loop.html"
		  links.Value("DownTo")="https://documentation.xojo.com/api/code_execution/downto.html"
		  links.Value("Else")="https://documentation.xojo.com/api/code_execution/else.html"
		  links.Value("End")="https://documentation.xojo.com/api/code_execution/end.html"
		  links.Value("Exit")="https://documentation.xojo.com/api/code_execution/exit.html"
		  links.Value("Finally")="https://documentation.xojo.com/api/code_execution/finally.html"
		  links.Value("ForEach...Next")="https://documentation.xojo.com/api/code_execution/for_each...next.html"
		  links.Value("For...Next")="https://documentation.xojo.com/api/code_execution/for...next.html"
		  links.Value("GoTo")="https://documentation.xojo.com/api/code_execution/goto.html"
		  links.Value("Greaterthan")="https://documentation.xojo.com/api/code_execution/greater_than_or_equal.html"
		  links.Value("Greaterthanorequal")="https://documentation.xojo.com/api/code_execution/greater_than.html"
		  links.Value("If")="https://documentation.xojo.com/api/code_execution/if...then...else.html"
		  links.Value("If...Then...Else")="https://documentation.xojo.com/api/code_execution/if.html"
		  links.Value("Iterable")="https://documentation.xojo.com/api/code_execution/iterable.html"
		  links.Value("Iterator")="https://documentation.xojo.com/api/code_execution/iterator.html"
		  links.Value("Next")="https://documentation.xojo.com/api/code_execution/next.html"
		  links.Value("Or")="https://documentation.xojo.com/api/code_execution/or.html"
		  links.Value("SelectCase")="https://documentation.xojo.com/api/code_execution/select_case.html"
		  links.Value("To")="https://documentation.xojo.com/api/code_execution/to.html"
		  links.Value("Try")="https://documentation.xojo.com/api/code_execution/try.html"
		  links.Value("While...Wend")="https://documentation.xojo.com/api/code_execution/while...wend.html"
		  links.Value("XojoScript")="https://documentation.xojo.com/api/code_execution/xojoscript.html"
		  links.Value("XojoScriptLocation")="https://documentation.xojo.com/api/code_execution/xojoscriptlocation.html"
		  
		  addSubMenu (1,32)
		  addXol (32)
		  
		  // compiler_directives
		  
		  'links.Value("") = "https://documentation.xojo.com/api/compiler_directives/index.html"
		  
		  links.Value("DebugBuild") = "https://documentation.xojo.com/api/compiler_directives/debugbuild.html"
		  links.Value("SaveProfile") = "https://documentation.xojo.com/api/compiler_directives/saveprofile.html"
		  links.Value("StartProfiling") = "https://documentation.xojo.com/api/compiler_directives/startprofiling.html"
		  links.Value("StopProfiling") = "https://documentation.xojo.com/api/compiler_directives/stopprofiling.html"
		  links.Value("Target32Bit") = "https://documentation.xojo.com/api/compiler_directives/target32bit.html"
		  links.Value("Target64Bit") = "https://documentation.xojo.com/api/compiler_directives/target64bit.html"
		  links.Value("TargetARM") = "https://documentation.xojo.com/api/compiler_directives/targetarm.html"
		  links.Value("TargetBigEndian") = "https://documentation.xojo.com/api/compiler_directives/targetbigendian.html"
		  links.Value("TargetConsole") = "https://documentation.xojo.com/api/compiler_directives/targetconsole.html"
		  links.Value("TargetDesktop") = "https://documentation.xojo.com/api/compiler_directives/targetdesktop.html"
		  links.Value("TargetiOS") = "https://documentation.xojo.com/api/compiler_directives/targetios.html"
		  links.Value("TargetLinux") = "https://documentation.xojo.com/api/compiler_directives/targetlinux.html"
		  links.Value("TargetLittleEndian") = "https://documentation.xojo.com/api/compiler_directives/targetlittleendian.html"
		  links.Value("TargetMachO") = "https://documentation.xojo.com/api/compiler_directives/targetmacho.html"
		  links.Value("TargetMacOS") = "https://documentation.xojo.com/api/compiler_directives/targetmacos.html"
		  links.Value("TargetMobileDevice") = "https://documentation.xojo.com/api/compiler_directives/targetmobiledevice.html"
		  links.Value("TargetMobileSimulator") = "https://documentation.xojo.com/api/compiler_directives/targetmobilesimulator.html"
		  links.Value("TargetRemoteDebugger") = "https://documentation.xojo.com/api/compiler_directives/targetremotedebugger.html"
		  links.Value("TargetWeb") = "https://documentation.xojo.com/api/compiler_directives/targetweb.html"
		  links.Value("TargetWindows") = "https://documentation.xojo.com/api/compiler_directives/targetwindows.html"
		  links.Value("TargetX86") = "https://documentation.xojo.com/api/compiler_directives/targetx86.html"
		  links.Value("TargetXojoCloud") = "https://documentation.xojo.com/api/compiler_directives/targetxojocloud.html"
		  links.Value("＃If...＃Endif") = "https://documentation.xojo.com/api/compiler_directives/if...endif.html"
		  
		  addSubMenu (2,23)
		  addXol (23)
		  
		  // cryptography
		  
		  'links.Value("") = "https://documentation.xojo.com/api/cryptography/index.html
		  links.Value("Crypto") = "https://documentation.xojo.com/api/cryptography/crypto.html"
		  links.Value("MD5") = "https://documentation.xojo.com/api/cryptography/md5.html"
		  links.Value("MD5Digest") = "https://documentation.xojo.com/api/cryptography/md5digest.html"
		  
		  addSubMenu (3,3)
		  
		  
		  //    data_types
		  
		  'https://documentation.xojo.com/getting_started/using_the_xojo_language/data_types.html
		  
		  'links.Value("") = "https://documentation.xojo.com/api/data_types/index.html"
		  links.Value("Boolean") = "https://documentation.xojo.com/api/data_types/boolean.html"
		  links.Value("Currency") = "https://documentation.xojo.com/api/data_types/currency.html"
		  links.Value("DateTime") = "https://documentation.xojo.com/api/data_types/datetime.html"
		  links.Value("Double") = "https://documentation.xojo.com/api/data_types/double.html"
		  links.Value("Enumeration") = "https://documentation.xojo.com/api/data_types/enumeration.html"
		  links.Value("Integer") = "https://documentation.xojo.com/api/data_types/integer.html"
		  links.Value("Pair") = "https://documentation.xojo.com/api/data_types/pair.html"
		  links.Value("Single") = "https://documentation.xojo.com/api/data_types/single.html"
		  links.Value("String") = "https://documentation.xojo.com/api/data_types/string.html"
		  links.Value("Variant") = "https://documentation.xojo.com/api/data_types/variant.html"
		  links.Value("Additional Types") = "https://documentation.xojo.com/api/data_types/additional_types/index.html"
		  links.Value("Information About Additional Integer Data Types") = "https://documentation.xojo.com/api/data_types/additional_types/information_about_additional_integer_data_types.html"
		  links.Value("CFStringRef") = "https://documentation.xojo.com/api/data_types/additional_types/cfstringref.html"
		  links.Value("CGFloat") = "https://documentation.xojo.com/api/data_types/additional_types/cgfloat.html"
		  links.Value("CString") = "https://documentation.xojo.com/api/data_types/additional_types/cstring.html"
		  links.Value("Int16") = "https://documentation.xojo.com/api/data_types/additional_types/int16.html"
		  links.Value("Int32") = "https://documentation.xojo.com/api/data_types/additional_types/int32.html"
		  links.Value("Int64") = "https://documentation.xojo.com/api/data_types/additional_types/int64.html"
		  links.Value("Int8") = "https://documentation.xojo.com/api/data_types/additional_types/int8.html"
		  links.Value("PString") = "https://documentation.xojo.com/api/data_types/additional_types/pstring.html"
		  links.Value("Ptr") = "https://documentation.xojo.com/api/data_types/additional_types/ptr.html"
		  links.Value("UInt16") = "https://documentation.xojo.com/api/data_types/additional_types/uint16.html"
		  links.Value("UInt32") = "https://documentation.xojo.com/api/data_types/additional_types/uint32.html"
		  links.Value("UInt64") = "https://documentation.xojo.com/api/data_types/additional_types/uint64.html"
		  links.Value("UInt8") = "https://documentation.xojo.com/api/data_types/additional_types/uint8.html"
		  links.Value("UInteger") = "https://documentation.xojo.com/api/data_types/additional_types/uinteger.html"
		  links.Value("WString") = "https://documentation.xojo.com/api/data_types/additional_types/wstring.html"
		  
		  
		  addSubMenu (4,27)
		  addXol (27)
		  
		  //    databases
		  
		  'links.Value("") = "https://documentation.xojo.com/api/databases/index.html"
		  links.Value("Database") = "https://documentation.xojo.com/api/databases/database.html"
		  links.Value("DatabaseColumn") = "https://documentation.xojo.com/api/databases/databasecolumn.html"
		  links.Value("DatabaseRow") = "https://documentation.xojo.com/api/databases/databaserow.html"
		  links.Value("MSSQLServerDatabase") = "https://documentation.xojo.com/api/databases/mssqlserverdatabase.html"
		  links.Value("MSSQLServerPreparedStatement") = "https://documentation.xojo.com/api/databases/mssqlserverpreparedstatement.html"
		  links.Value("MySQLCommunityServer") = "https://documentation.xojo.com/api/databases/mysqlcommunityserver.html"
		  links.Value("MySQLPreparedStatement") = "https://documentation.xojo.com/api/databases/mysqlpreparedstatement.html"
		  links.Value("ODBCConstant") = "https://documentation.xojo.com/api/databases/odbcconstant.html"
		  links.Value("ODBCDatabase") = "https://documentation.xojo.com/api/databases/odbcdatabase.html"
		  links.Value("ODBCPreparedStatement") = "https://documentation.xojo.com/api/databases/odbcpreparedstatement.html"
		  links.Value("OracleDatabase") = "https://documentation.xojo.com/api/databases/oracledatabase.html"
		  links.Value("OracleSQLPreparedStatement") = "https://documentation.xojo.com/api/databases/oraclesqlpreparedstatement.html"
		  links.Value("PostgreSQLDatabase") = "https://documentation.xojo.com/api/databases/postgresqldatabase.html"
		  links.Value("PostgreSQLLargeObject") = "https://documentation.xojo.com/api/databases/postgresqllargeobject.html"
		  links.Value("PostgreSQLPreparedStatement") = "https://documentation.xojo.com/api/databases/postgresqlpreparedstatement.html"
		  links.Value("PreparedSQLStatement") = "https://documentation.xojo.com/api/databases/preparedsqlstatement.html"
		  links.Value("RowSet") = "https://documentation.xojo.com/api/databases/rowset.html"
		  links.Value("SQLiteBackupInterface") = "https://documentation.xojo.com/api/databases/sqlitebackupinterface.html"
		  links.Value("SQLiteBLOB") = "https://documentation.xojo.com/api/databases/sqliteblob.html"
		  links.Value("SQLiteDatabase") = "https://documentation.xojo.com/api/databases/sqlitedatabase.html"
		  links.Value("SQLitePreparedStatement") = "https://documentation.xojo.com/api/databases/sqlitepreparedstatement.html"
		  
		  addSubMenu (5,21)
		  addXol (21)
		  
		  //   deprecated
		  
		  'links.Value("") = "https://documentation.xojo.com/api/deprecated/index.html"
		  links.Value("AddressBook") = "https://documentation.xojo.com/api/deprecated/addressbook.html"
		  links.Value("AddressBookAddress") = "https://documentation.xojo.com/api/deprecated/addressbookaddress.html"
		  links.Value("AddressBookContact") = "https://documentation.xojo.com/api/deprecated/addressbookcontact.html"
		  links.Value("AddressBookData") = "https://documentation.xojo.com/api/deprecated/addressbookdata.html"
		  links.Value("AddressBookGroup") = "https://documentation.xojo.com/api/deprecated/addressbookgroup.html"
		  links.Value("AddressBookRecord") = "https://documentation.xojo.com/api/deprecated/addressbookrecord.html"
		  links.Value("Append") = "https://documentation.xojo.com/api/deprecated/append.html"
		  links.Value("AppleEventTarget") = "https://documentation.xojo.com/api/deprecated/appleeventtarget.html"
		  links.Value("AppleMenuItem") = "https://documentation.xojo.com/api/deprecated/applemenuitem.html"
		  links.Value("Application") = "https://documentation.xojo.com/api/deprecated/application.html"
		  links.Value("AscB") = "https://documentation.xojo.com/api/deprecated/ascb.html"
		  links.Value("Auto") = "https://documentation.xojo.com/api/deprecated/auto.html"
		  links.Value("Beep") = "https://documentation.xojo.com/api/deprecated/beep.html"
		  links.Value("BevelButton") = "https://documentation.xojo.com/api/deprecated/bevelbutton.html"
		  links.Value("BitwiseAnd") = "https://documentation.xojo.com/api/deprecated/bitwiseand.html"
		  links.Value("BitwiseOr") = "https://documentation.xojo.com/api/deprecated/bitwiseor.html"
		  links.Value("Canvas") = "https://documentation.xojo.com/api/deprecated/canvas.html"
		  links.Value("CDbl") = "https://documentation.xojo.com/api/deprecated/cdbl.html"
		  links.Value("Ceil") = "https://documentation.xojo.com/api/deprecated/ceil.html"
		  links.Value("CheckBox") = "https://documentation.xojo.com/api/deprecated/checkbox.html"
		  links.Value("ChrB") = "https://documentation.xojo.com/api/deprecated/chrb.html"
		  links.Value("CLong") = "https://documentation.xojo.com/api/deprecated/clong.html"
		  links.Value("CMY") = "https://documentation.xojo.com/api/deprecated/cmy.html"
		  links.Value("ComboBox") = "https://documentation.xojo.com/api/deprecated/combobox.html"
		  links.Value("ContainerControl") = "https://documentation.xojo.com/api/deprecated/containercontrol.html"
		  links.Value("Control") = "https://documentation.xojo.com/api/deprecated/control.html"
		  links.Value("CountFields") = "https://documentation.xojo.com/api/deprecated/countfields.html"
		  links.Value("CountFieldsB") = "https://documentation.xojo.com/api/deprecated/countfieldsb.html"
		  links.Value("DarkBevelColor") = "https://documentation.xojo.com/api/deprecated/darkbevelcolor.html"
		  links.Value("DarkTingeColor") = "https://documentation.xojo.com/api/deprecated/darktingecolor.html"
		  links.Value("DatabaseField") = "https://documentation.xojo.com/api/deprecated/databasefield.html"
		  links.Value("DatabaseRecord") = "https://documentation.xojo.com/api/deprecated/databaserecord.html"
		  links.Value("Date") = "https://documentation.xojo.com/api/deprecated/date.html"
		  links.Value("DateTimePicker") = "https://documentation.xojo.com/api/deprecated/datetimepicker.html"
		  links.Value("Deprecated Class Members") = "https://documentation.xojo.com/api/deprecated/deprecated_class_members/index.html"
		  links.Value("DisabledTextColor") = "https://documentation.xojo.com/api/deprecated/disabledtextcolor.html"
		  links.Value("DisclosureTriangle") = "https://documentation.xojo.com/api/deprecated/disclosuretriangle.html"
		  links.Value("EnableMenuItems") = "https://documentation.xojo.com/api/deprecated/enablemenuitems.html"
		  links.Value("ErrorException") = "https://documentation.xojo.com/api/deprecated/errorexception.html"
		  links.Value("FillColor") = "https://documentation.xojo.com/api/deprecated/fillcolor.html"
		  links.Value("Font Method") = "https://documentation.xojo.com/api/deprecated/font_method.html"
		  links.Value("FontCount") = "https://documentation.xojo.com/api/deprecated/fontcount.html"
		  links.Value("FrameColor") = "https://documentation.xojo.com/api/deprecated/framecolor.html"
		  links.Value("GetFolderItem") = "https://documentation.xojo.com/api/deprecated/getfolderitem.html"
		  links.Value("GetOpenFolderItem") = "https://documentation.xojo.com/api/deprecated/getopenfolderitem.html"
		  links.Value("GetSaveFolderItem") = "https://documentation.xojo.com/api/deprecated/getsavefolderitem.html"
		  links.Value("GetTemporaryFolderItem") = "https://documentation.xojo.com/api/deprecated/gettemporaryfolderitem.html"
		  links.Value("GetTrueFolderItem") = "https://documentation.xojo.com/api/deprecated/gettruefolderitem.html"
		  links.Value("GroupBox") = "https://documentation.xojo.com/api/deprecated/groupbox.html"
		  links.Value("HighlightColor") = "https://documentation.xojo.com/api/deprecated/highlightcolor.html"
		  links.Value("HSV") = "https://documentation.xojo.com/api/deprecated/hsv.html"
		  links.Value("HTMLViewer") = "https://documentation.xojo.com/api/deprecated/htmlviewer.html"
		  links.Value("HTTPSecureSocket") = "https://documentation.xojo.com/api/deprecated/httpsecuresocket.html"
		  links.Value("HTTPSocket") = "https://documentation.xojo.com/api/deprecated/httpsocket.html"
		  links.Value("ImageWell") = "https://documentation.xojo.com/api/deprecated/imagewell.html"
		  links.Value("Insert") = "https://documentation.xojo.com/api/deprecated/insert.html"
		  links.Value("InStr") = "https://documentation.xojo.com/api/deprecated/instr.html"
		  links.Value("InStrB") = "https://documentation.xojo.com/api/deprecated/instrb.html"
		  links.Value("iOSApplication") = "https://documentation.xojo.com/api/deprecated/iosapplication.html"
		  links.Value("iOSBitmap") = "https://documentation.xojo.com/api/deprecated/iosbitmap.html"
		  links.Value("iOSBlock") = "https://documentation.xojo.com/api/deprecated/iosblock.html"
		  links.Value("iOSButton") = "https://documentation.xojo.com/api/deprecated/iosbutton.html"
		  links.Value("iOSCanvas") = "https://documentation.xojo.com/api/deprecated/ioscanvas.html"
		  links.Value("iOSContainerControl") = "https://documentation.xojo.com/api/deprecated/ioscontainercontrol.html"
		  links.Value("iOSControl") = "https://documentation.xojo.com/api/deprecated/ioscontrol.html"
		  links.Value("iOSCustomTableCell") = "https://documentation.xojo.com/api/deprecated/ioscustomtablecell.html"
		  links.Value("iOSDatePicker") = "https://documentation.xojo.com/api/deprecated/iosdatepicker.html"
		  links.Value("iOSEventInfo") = "https://documentation.xojo.com/api/deprecated/ioseventinfo.html"
		  links.Value("iOSFont") = "https://documentation.xojo.com/api/deprecated/iosfont.html"
		  links.Value("iOSGraphics") = "https://documentation.xojo.com/api/deprecated/iosgraphics.html"
		  links.Value("iOSHTMLViewer") = "https://documentation.xojo.com/api/deprecated/ioshtmlviewer.html"
		  links.Value("iOSImage") = "https://documentation.xojo.com/api/deprecated/iosimage.html"
		  links.Value("iOSImageView") = "https://documentation.xojo.com/api/deprecated/iosimageview.html"
		  links.Value("iOSLabel") = "https://documentation.xojo.com/api/deprecated/ioslabel.html"
		  links.Value("iOSLocation") = "https://documentation.xojo.com/api/deprecated/ioslocation.html"
		  links.Value("iOSMessageBox") = "https://documentation.xojo.com/api/deprecated/iosmessagebox.html"
		  links.Value("iOSMotion") = "https://documentation.xojo.com/api/deprecated/iosmotion.html"
		  links.Value("iOSOval") = "https://documentation.xojo.com/api/deprecated/iosoval.html"
		  links.Value("iOSPath") = "https://documentation.xojo.com/api/deprecated/iospath.html"
		  links.Value("iOSPicturePicker") = "https://documentation.xojo.com/api/deprecated/iospicturepicker.html"
		  links.Value("iOSProgressBar") = "https://documentation.xojo.com/api/deprecated/iosprogressbar.html"
		  links.Value("iOSProgressWheel") = "https://documentation.xojo.com/api/deprecated/iosprogresswheel.html"
		  links.Value("iOSRectangle") = "https://documentation.xojo.com/api/deprecated/iosrectangle.html"
		  links.Value("iOSScreen") = "https://documentation.xojo.com/api/deprecated/iosscreen.html"
		  links.Value("iOSScreenContent") = "https://documentation.xojo.com/api/deprecated/iosscreencontent.html"
		  links.Value("iOSScrollableArea") = "https://documentation.xojo.com/api/deprecated/iosscrollablearea.html"
		  links.Value("iOSSegmentedControl") = "https://documentation.xojo.com/api/deprecated/iossegmentedcontrol.html"
		  links.Value("iOSSegmentedControlItem") = "https://documentation.xojo.com/api/deprecated/iossegmentedcontrolitem.html"
		  links.Value("iOSSeparator") = "https://documentation.xojo.com/api/deprecated/iosseparator.html"
		  links.Value("iOSSharingPanel") = "https://documentation.xojo.com/api/deprecated/iossharingpanel.html"
		  links.Value("iOSSlider") = "https://documentation.xojo.com/api/deprecated/iosslider.html"
		  links.Value("iOSSound") = "https://documentation.xojo.com/api/deprecated/iossound.html"
		  links.Value("iOSSQLiteDatabase") = "https://documentation.xojo.com/api/deprecated/iossqlitedatabase.html"
		  links.Value("iOSSQLiteDatabaseField") = "https://documentation.xojo.com/api/deprecated/iossqlitedatabasefield.html"
		  links.Value("iOSSQLiteException") = "https://documentation.xojo.com/api/deprecated/iossqliteexception.html"
		  links.Value("iOSSQLiteRecordSet") = "https://documentation.xojo.com/api/deprecated/iossqliterecordset.html"
		  links.Value("iOSSwitch") = "https://documentation.xojo.com/api/deprecated/iosstylechangeobserver.html"
		  links.Value("iOSStyleChangeObserver") = "https://documentation.xojo.com/api/deprecated/iosswitch.html"
		  links.Value("iOSTable") = "https://documentation.xojo.com/api/deprecated/iostable.html"
		  links.Value("iOSTableCellData") = "https://documentation.xojo.com/api/deprecated/iostablecelldata.html"
		  links.Value("iOSTableDataSource") = "https://documentation.xojo.com/api/deprecated/iostabledatasource.html"
		  links.Value("iOSTableDataSourceEditing") = "https://documentation.xojo.com/api/deprecated/iostabledatasourceediting.html"
		  links.Value("iOSTableDataSourceReordering") = "https://documentation.xojo.com/api/deprecated/iostabledatasourcereordering.html"
		  links.Value("iOSTableRowAction") = "https://documentation.xojo.com/api/deprecated/iostablerowaction.html"
		  links.Value("iOSTextArea") = "https://documentation.xojo.com/api/deprecated/iostextarea.html"
		  links.Value("iOSTextField") = "https://documentation.xojo.com/api/deprecated/iostextfield.html"
		  links.Value("iOSToolbar") = "https://documentation.xojo.com/api/deprecated/iostoolbar.html"
		  links.Value("iOSToolButton") = "https://documentation.xojo.com/api/deprecated/iostoolbutton.html"
		  links.Value("iOSUserControl") = "https://documentation.xojo.com/api/deprecated/iosusercontrol.html"
		  links.Value("iOSView") = "https://documentation.xojo.com/api/deprecated/iosview.html"
		  links.Value("IsDarkMode") = "https://documentation.xojo.com/api/deprecated/isdarkmode.html"
		  links.Value("Join") = "https://documentation.xojo.com/api/deprecated/join.html"
		  links.Value("Label") = "https://documentation.xojo.com/api/deprecated/label.html"
		  links.Value("LeftB") = "https://documentation.xojo.com/api/deprecated/leftb.html"
		  links.Value("LenB") = "https://documentation.xojo.com/api/deprecated/lenb.html"
		  links.Value("LightBevelColor") = "https://documentation.xojo.com/api/deprecated/lightbevelcolor.html"
		  links.Value("LightTingeColor") = "https://documentation.xojo.com/api/deprecated/lighttingecolor.html"
		  links.Value("Line") = "https://documentation.xojo.com/api/deprecated/line.html"
		  links.Value("ListBox") = "https://documentation.xojo.com/api/deprecated/listbox.html"
		  links.Value("ListBoxColumn") = "https://documentation.xojo.com/api/deprecated/listboxcolumn.html"
		  links.Value("ListBoxRow") = "https://documentation.xojo.com/api/deprecated/listboxrow.html"
		  links.Value("ListColumn") = "https://documentation.xojo.com/api/deprecated/listcolumn.html"
		  links.Value("LogicException") = "https://documentation.xojo.com/api/deprecated/logicexception.html"
		  links.Value("LTrim") = "https://documentation.xojo.com/api/deprecated/ltrim.html"
		  links.Value("MenuBar") = "https://documentation.xojo.com/api/deprecated/menubar.html"
		  links.Value("MenuItem") = "https://documentation.xojo.com/api/deprecated/menuitem.html"
		  links.Value("Microseconds") = "https://documentation.xojo.com/api/deprecated/microseconds.html"
		  links.Value("MidB") = "https://documentation.xojo.com/api/deprecated/midb.html"
		  links.Value("MoviePlayer") = "https://documentation.xojo.com/api/deprecated/movieplayer.html"
		  links.Value("MsgBox") = "https://documentation.xojo.com/api/deprecated/msgbox.html"
		  links.Value("NotePlayer") = "https://documentation.xojo.com/api/deprecated/noteplayer.html"
		  links.Value("NthField") = "https://documentation.xojo.com/api/deprecated/nthfield.html"
		  links.Value("NthFieldB") = "https://documentation.xojo.com/api/deprecated/nthfieldb.html"
		  links.Value("OpenDialog") = "https://documentation.xojo.com/api/deprecated/opendialog.html"
		  links.Value("OpenGLSurface") = "https://documentation.xojo.com/api/deprecated/openglsurface.html"
		  links.Value("OpenPrinter") = "https://documentation.xojo.com/api/deprecated/openprinter.html"
		  links.Value("OpenPrinterDialog") = "https://documentation.xojo.com/api/deprecated/openprinterdialog.html"
		  links.Value("OpenURLMovie") = "https://documentation.xojo.com/api/deprecated/openurlmovie.html"
		  links.Value("Oval") = "https://documentation.xojo.com/api/deprecated/oval.html"
		  links.Value("PagePanel") = "https://documentation.xojo.com/api/deprecated/pagepanel.html"
		  links.Value("ParseDate") = "https://documentation.xojo.com/api/deprecated/parsedate.html"
		  links.Value("Placard") = "https://documentation.xojo.com/api/deprecated/placard.html"
		  links.Value("POP3Socket") = "https://documentation.xojo.com/api/deprecated/pop3socket.html"
		  links.Value("PopupArrow") = "https://documentation.xojo.com/api/deprecated/popuparrow.html"
		  links.Value("PopupMenu") = "https://documentation.xojo.com/api/deprecated/popupmenu.html"
		  links.Value("ProgressBar") = "https://documentation.xojo.com/api/deprecated/progressbar.html"
		  links.Value("ProgressWheel") = "https://documentation.xojo.com/api/deprecated/progresswheel.html"
		  links.Value("PushButton") = "https://documentation.xojo.com/api/deprecated/pushbutton.html"
		  links.Value("RadioButton") = "https://documentation.xojo.com/api/deprecated/radiobutton.html"
		  links.Value("RBScript") = "https://documentation.xojo.com/api/deprecated/rbscript.html"
		  links.Value("RbScriptAlreadyRunningException") = "https://documentation.xojo.com/api/deprecated/rbscriptalreadyrunningexception.html"
		  links.Value("RBVersion") = "https://documentation.xojo.com/api/deprecated/rbversion.html"
		  links.Value("RBVersionString") = "https://documentation.xojo.com/api/deprecated/rbversionstring.html"
		  links.Value("Realbasic.Point") = "https://documentation.xojo.com/api/deprecated/realbasic.point.html"
		  links.Value("Realbasic.Rect") = "https://documentation.xojo.com/api/deprecated/realbasic.rect.html"
		  links.Value("Realbasic.Size") = "https://documentation.xojo.com/api/deprecated/realbasic.size.html"
		  links.Value("RealSQLBlob") = "https://documentation.xojo.com/api/deprecated/realsqlblob.html"
		  links.Value("REALSQLdatabase") = "https://documentation.xojo.com/api/deprecated/realsqldatabase.html"
		  links.Value("REALSQLPreparedStatement") = "https://documentation.xojo.com/api/deprecated/realsqlpreparedstatement.html"
		  links.Value("RecordSet") = "https://documentation.xojo.com/api/deprecated/recordset.html"
		  links.Value("RecordSetQuery") = "https://documentation.xojo.com/api/deprecated/recordsetquery.html"
		  links.Value("Rectangle") = "https://documentation.xojo.com/api/deprecated/rectangle.html"
		  links.Value("RectControl") = "https://documentation.xojo.com/api/deprecated/rectcontrol.html"
		  links.Value("Rem, //, '") = "https://documentation.xojo.com/api/deprecated/rem-_---_&#39"
		  links.Value("Remove") = "https://documentation.xojo.com/api/deprecated/remove.html"
		  links.Value("Replace") = "https://documentation.xojo.com/api/deprecated/replace.html"
		  links.Value("ReplaceAllB") = "https://documentation.xojo.com/api/deprecated/replaceallb.html"
		  links.Value("ReplaceB") = "https://documentation.xojo.com/api/deprecated/replaceb.html"
		  links.Value("ReplaceLineEndings") = "https://documentation.xojo.com/api/deprecated/replacelineendings.html"
		  links.Value("RGB") = "https://documentation.xojo.com/api/deprecated/rgb.html"
		  links.Value("RightB") = "https://documentation.xojo.com/api/deprecated/rightb.html"
		  links.Value("RoundRectangle") = "https://documentation.xojo.com/api/deprecated/roundrectangle.html"
		  links.Value("RTrim") = "https://documentation.xojo.com/api/deprecated/rtrim.html"
		  links.Value("SaveAsDialog") = "https://documentation.xojo.com/api/deprecated/saveasdialog.html"
		  links.Value("Screen Method") = "https://documentation.xojo.com/api/deprecated/screen_method.html"
		  links.Value("ScreenCount") = "https://documentation.xojo.com/api/deprecated/screencount.html"
		  links.Value("Scrollbar") = "https://documentation.xojo.com/api/deprecated/scrollbar.html"
		  links.Value("SearchField") = "https://documentation.xojo.com/api/deprecated/searchfield.html"
		  links.Value("SegmentedButton") = "https://documentation.xojo.com/api/deprecated/segmentedbutton.html"
		  links.Value("SegmentedControl") = "https://documentation.xojo.com/api/deprecated/segmentedcontrol.html"
		  links.Value("SegmentedControlItem") = "https://documentation.xojo.com/api/deprecated/segmentedcontrolitem.html"
		  links.Value("SelectColor") = "https://documentation.xojo.com/api/deprecated/selectcolor.html"
		  links.Value("SelectFolder") = "https://documentation.xojo.com/api/deprecated/selectfolder.html"
		  links.Value("Separator") = "https://documentation.xojo.com/api/deprecated/separator.html"
		  links.Value("Serial") = "https://documentation.xojo.com/api/deprecated/serial.html"
		  links.Value("SerialPort") = "https://documentation.xojo.com/api/deprecated/serialport.html"
		  links.Value("Short") = "https://documentation.xojo.com/api/deprecated/short.html"
		  links.Value("ShowURL") = "https://documentation.xojo.com/api/deprecated/showurl.html"
		  links.Value("Slider") = "https://documentation.xojo.com/api/deprecated/slider.html"
		  links.Value("SMTPSocket") = "https://documentation.xojo.com/api/deprecated/smtpsocket.html"
		  links.Value("Speak") = "https://documentation.xojo.com/api/deprecated/speak.html"
		  links.Value("Split") = "https://documentation.xojo.com/api/deprecated/split.html"
		  links.Value("SplitB") = "https://documentation.xojo.com/api/deprecated/splitb.html"
		  links.Value("StrComp") = "https://documentation.xojo.com/api/deprecated/strcomp.html"
		  links.Value("StringShape") = "https://documentation.xojo.com/api/deprecated/stringshape.html"
		  links.Value("TabPanel") = "https://documentation.xojo.com/api/deprecated/tabpanel.html"
		  links.Value("TargetCarbon") = "https://documentation.xojo.com/api/deprecated/targetcarbon.html"
		  links.Value("TargetCocoa") = "https://documentation.xojo.com/api/deprecated/targetcocoa.html"
		  links.Value("TargetHasGUI") = "https://documentation.xojo.com/api/deprecated/targethasgui.html"
		  links.Value("TargetWin32") = "https://documentation.xojo.com/api/deprecated/targetwin32.html"
		  links.Value("Task") = "https://documentation.xojo.com/api/deprecated/task.html"
		  links.Value("Text") = "https://documentation.xojo.com/api/deprecated/text.html"
		  links.Value("TextArea") = "https://documentation.xojo.com/api/deprecated/textarea.html"
		  links.Value("TextColor") = "https://documentation.xojo.com/api/deprecated/textcolor.html"
		  links.Value("TextEdit") = "https://documentation.xojo.com/api/deprecated/textedit.html"
		  links.Value("TextField") = "https://documentation.xojo.com/api/deprecated/textfield.html"
		  links.Value("Ticks") = "https://documentation.xojo.com/api/deprecated/ticks.html"
		  links.Value("TickStyles Enumeration") = "https://documentation.xojo.com/api/deprecated/tickstyles_enumeration.html"
		  links.Value("Titlecase") = "https://documentation.xojo.com/api/deprecated/titlecase.html"
		  links.Value("Toolbar") = "https://documentation.xojo.com/api/deprecated/toolbar.html"
		  links.Value("ToolbarButton") = "https://documentation.xojo.com/api/deprecated/toolbarbutton.html"
		  links.Value("ToolbarItem") = "https://documentation.xojo.com/api/deprecated/toolbaritem.html"
		  links.Value("ToolButton") = "https://documentation.xojo.com/api/deprecated/toolbutton.html"
		  links.Value("ToolItem") = "https://documentation.xojo.com/api/deprecated/toolitem.html"
		  links.Value("ToolTip") = "https://documentation.xojo.com/api/deprecated/tooltip.html"
		  links.Value("Ubound") = "https://documentation.xojo.com/api/deprecated/ubound.html"
		  links.Value("UpDownArrows") = "https://documentation.xojo.com/api/deprecated/updownarrows.html"
		  links.Value("Volume") = "https://documentation.xojo.com/api/deprecated/volume.html"
		  links.Value("VolumeCount") = "https://documentation.xojo.com/api/deprecated/volumecount.html"
		  links.Value("WebToolbarContainer") = "https://documentation.xojo.com/api/deprecated/webtoolbarcontainer.html"
		  links.Value("WebToolbarFlexibleSpace") = "https://documentation.xojo.com/api/deprecated/webtoolbarflexiblespace.html"
		  links.Value("WebToolbarMenu") = "https://documentation.xojo.com/api/deprecated/webtoolbarmenu.html"
		  links.Value("WebToolbarSeparator") = "https://documentation.xojo.com/api/deprecated/webtoolbarseparator.html"
		  links.Value("WebToolbarSpace") = "https://documentation.xojo.com/api/deprecated/webtoolbarspace.html"
		  links.Value("Window") = "https://documentation.xojo.com/api/deprecated/window_method.html"
		  links.Value("Window Method") = "https://documentation.xojo.com/api/deprecated/window.html"
		  links.Value("WindowCount") = "https://documentation.xojo.com/api/deprecated/windowcount.html"
		  links.Value("Xojo.Core.Date") = "https://documentation.xojo.com/api/deprecated/xojo.core.date.html"
		  links.Value("Xojo.Core.Dictionary") = "https://documentation.xojo.com/api/deprecated/xojo.core.dictionary.html"
		  links.Value("Xojo.Core.Locale") = "https://documentation.xojo.com/api/deprecated/xojo.core.locale.html"
		  links.Value("Xojo.Core.MemoryBlock") = "https://documentation.xojo.com/api/deprecated/xojo.core.memoryblock.html"
		  links.Value("Xojo.Core.MutableMemoryBlock") = "https://documentation.xojo.com/api/deprecated/xojo.core.mutablememoryblock.html"
		  links.Value("Xojo.Core.TextEncoding") = "https://documentation.xojo.com/api/deprecated/xojo.core.textencoding.html"
		  links.Value("Xojo.Core.Timer") = "https://documentation.xojo.com/api/deprecated/xojo.core.timer.html"
		  links.Value("Xojo.Crypto") = "https://documentation.xojo.com/api/deprecated/xojo.crypto.html"
		  links.Value("Xojo.Data") = "https://documentation.xojo.com/api/deprecated/xojo.data.html"
		  links.Value("Xojo.Introspection") = "https://documentation.xojo.com/api/deprecated/xojo.introspection.attributeinfo.html"
		  links.Value("Xojo.Introspection.AttributeInfo") = "https://documentation.xojo.com/api/deprecated/xojo.introspection.constructorinfo.html"
		  links.Value("Xojo.Introspection.ConstructorInfo") = "https://documentation.xojo.com/api/deprecated/xojo.introspection.gettype.html"
		  links.Value("Xojo.Introspection.GetType") = "https://documentation.xojo.com/api/deprecated/xojo.introspection.html"
		  links.Value("Xojo.Introspection.MemberInfo") = "https://documentation.xojo.com/api/deprecated/xojo.introspection.memberinfo.html"
		  links.Value("Xojo.Introspection.MethodInfo") = "https://documentation.xojo.com/api/deprecated/xojo.introspection.methodinfo.html"
		  links.Value("Xojo.Introspection.ParameterInfo") = "https://documentation.xojo.com/api/deprecated/xojo.introspection.parameterinfo.html"
		  links.Value("Xojo.Introspection.TypeInfo") = "https://documentation.xojo.com/api/deprecated/xojo.introspection.typeinfo.html"
		  links.Value("Xojo.IO.BinaryStream") = "https://documentation.xojo.com/api/deprecated/xojo.io.binarystream.html"
		  links.Value("Xojo.IO.FolderItem") = "https://documentation.xojo.com/api/deprecated/xojo.io.folderitem.html"
		  links.Value("Xojo.IO.SpecialFolder") = "https://documentation.xojo.com/api/deprecated/xojo.io.specialfolder.html"
		  links.Value("Xojo.IO.TextInputStream") = "https://documentation.xojo.com/api/deprecated/xojo.io.textinputstream.html"
		  links.Value("Xojo.IO.TextOutputStream") = "https://documentation.xojo.com/api/deprecated/xojo.io.textoutputstream.html"
		  links.Value("Xojo.iOSKeyboardTypes") = "https://documentation.xojo.com/api/deprecated/xojo.ioskeyboardtypes.html"
		  links.Value("Xojo.iOSLineBreakMode") = "https://documentation.xojo.com/api/deprecated/xojo.ioslinebreakmode.html"
		  links.Value("Xojo.iOSTextAlignment") = "https://documentation.xojo.com/api/deprecated/xojo.iostextalignment.html"
		  links.Value("Xojo.Net.HTTPSocket") = "https://documentation.xojo.com/api/deprecated/xojo.net.httpsocket.html"
		  links.Value("Xojo.Net.TCPSocket") = "https://documentation.xojo.com/api/deprecated/xojo.net.tcpsocket.html"
		  links.Value("Xojo.Threading.CriticalSection") = "https://documentation.xojo.com/api/deprecated/xojo.threading.criticalsection.html"
		  links.Value("Xojo.Threading.Semaphore") = "https://documentation.xojo.com/api/deprecated/xojo.threading.semaphore.html"
		  links.Value("Xojo.Threading.Thread") = "https://documentation.xojo.com/api/deprecated/xojo.threading.thread.html"
		  
		  addSubMenu (6,257)
		  addXol (257)
		  
		  // exceptions
		  
		  'links.Value("") = "https://documentation.xojo.com/api/exceptions/index.html"
		  links.Value("COMException") = "https://documentation.xojo.com/api/exceptions/comexception.html"
		  links.Value("CryptoException") = "https://documentation.xojo.com/api/exceptions/cryptoexception.html"
		  links.Value("DatabaseException") = "https://documentation.xojo.com/api/exceptions/databaseexception.html"
		  links.Value("EndException") = "https://documentation.xojo.com/api/exceptions/endexception.html"
		  links.Value("Exception") = "https://documentation.xojo.com/api/exceptions/exception.html"
		  links.Value("FunctionNotFoundException") = "https://documentation.xojo.com/api/exceptions/functionnotfoundexception.html"
		  links.Value("HTMLViewerException") = "https://documentation.xojo.com/api/exceptions/htmlviewerexception.html"
		  links.Value("IllegalCastException") = "https://documentation.xojo.com/api/exceptions/illegalcastexception.html"
		  links.Value("IllegalLockingException") = "https://documentation.xojo.com/api/exceptions/illegallockingexception.html"
		  links.Value("InvalidArgumentException") = "https://documentation.xojo.com/api/exceptions/invalidargumentexception.html"
		  links.Value("InvalidJSONException") = "https://documentation.xojo.com/api/exceptions/invalidjsonexception.html"
		  links.Value("InvalidParentException") = "https://documentation.xojo.com/api/exceptions/invalidparentexception.html"
		  links.Value("IOException") = "https://documentation.xojo.com/api/exceptions/ioexception.html"
		  links.Value("IteratorException") = "https://documentation.xojo.com/api/exceptions/iteratorexception.html"
		  links.Value("JSONException") = "https://documentation.xojo.com/api/exceptions/jsonexception.html"
		  links.Value("KeychainException") = "https://documentation.xojo.com/api/exceptions/keychainexception.html"
		  links.Value("KeyNotFoundException") = "https://documentation.xojo.com/api/exceptions/keynotfoundexception.html"
		  links.Value("MenuHasParentException") = "https://documentation.xojo.com/api/exceptions/menuhasparentexception.html"
		  links.Value("NamespaceException") = "https://documentation.xojo.com/api/exceptions/namespaceexception.html"
		  links.Value("NetworkException") = "https://documentation.xojo.com/api/exceptions/networkexception.html"
		  links.Value("NilObjectException") = "https://documentation.xojo.com/api/exceptions/nilobjectexception.html"
		  links.Value("ObjCException") = "https://documentation.xojo.com/api/exceptions/objcexception.html"
		  links.Value("OLEException") = "https://documentation.xojo.com/api/exceptions/oleexception.html"
		  links.Value("OutOfBoundsException") = "https://documentation.xojo.com/api/exceptions/outofboundsexception.html"
		  links.Value("OutOfMemoryException") = "https://documentation.xojo.com/api/exceptions/outofmemoryexception.html"
		  links.Value("PlatformNotSupportedException") = "https://documentation.xojo.com/api/exceptions/platformnotsupportedexception.html"
		  links.Value("Raise") = "https://documentation.xojo.com/api/exceptions/raise.html"
		  links.Value("RegExException") = "https://documentation.xojo.com/api/exceptions/regexexception.html"
		  links.Value("RegExSearchPatternException") = "https://documentation.xojo.com/api/exceptions/regexsearchpatternexception.html"
		  links.Value("RegistryAccessErrorException") = "https://documentation.xojo.com/api/exceptions/registryaccesserrorexception.html"
		  links.Value("RuntimeException") = "https://documentation.xojo.com/api/exceptions/runtimeexception.html"
		  links.Value("ServiceNotAvailableException") = "https://documentation.xojo.com/api/exceptions/servicenotavailableexception.html"
		  links.Value("SessionNotAvailableException") = "https://documentation.xojo.com/api/exceptions/sessionnotavailableexception.html"
		  links.Value("ShellNotAvailableException") = "https://documentation.xojo.com/api/exceptions/shellnotavailableexception.html"
		  links.Value("ShellNotRunningException") = "https://documentation.xojo.com/api/exceptions/shellnotrunningexception.html"
		  links.Value("SpotlightException") = "https://documentation.xojo.com/api/exceptions/spotlightexception.html"
		  links.Value("StackOverFlowException") = "https://documentation.xojo.com/api/exceptions/stackoverflowexception.html"
		  links.Value("ThreadAccessingUIException") = "https://documentation.xojo.com/api/exceptions/threadaccessinguiexception.html"
		  links.Value("ThreadAlreadyRunningException") = "https://documentation.xojo.com/api/exceptions/threadalreadyrunningexception.html"
		  links.Value("ThreadEndException") = "https://documentation.xojo.com/api/exceptions/threadendexception.html"
		  links.Value("TypeMismatchException") = "https://documentation.xojo.com/api/exceptions/typemismatchexception.html"
		  links.Value("UnsupportedFormatException") = "https://documentation.xojo.com/api/exceptions/unsupportedformatexception.html"
		  links.Value("UnsupportedOperationException") = "https://documentation.xojo.com/api/exceptions/unsupportedoperationexception.html"
		  links.Value("XMLDOMException") = "https://documentation.xojo.com/api/exceptions/xmldomexception.html"
		  links.Value("XMLException") = "https://documentation.xojo.com/api/exceptions/xmlexception.html"
		  links.Value("XMLReaderException") = "https://documentation.xojo.com/api/exceptions/xmlreaderexception.html"
		  links.Value("XojoScriptAlreadyRunningException") = "https://documentation.xojo.com/api/exceptions/xojoscriptalreadyrunningexception.html"
		  links.Value("XojoScriptException") = "https://documentation.xojo.com/api/exceptions/xojoscriptexception.html"'
		  
		  addSubMenu (7,48)
		  addXol (48)
		  
		  // file
		  
		  'links.Value("") = "https://documentation.xojo.com/api/files/index.html"
		  links.Value("BinaryStream") = "https://documentation.xojo.com/api/files/binarystream.html"
		  links.Value("FileType") = "https://documentation.xojo.com/api/files/filetype.html"
		  links.Value("FolderItem") = "https://documentation.xojo.com/api/files/folderitem.html"
		  links.Value("IOStreamHandleTypes") = "https://documentation.xojo.com/api/files/iostreamhandletypes.html"
		  links.Value("Permissions") = "https://documentation.xojo.com/api/files/permissions.html"
		  links.Value("SpecialFolder") = "https://documentation.xojo.com/api/files/specialfolder.html"
		  links.Value("StandardInputStream") = "https://documentation.xojo.com/api/files/standardinputstream.html"
		  links.Value("StandardOutputStream") = "https://documentation.xojo.com/api/files/standardoutputstream.html"
		  links.Value("TextInputStream") = "https://documentation.xojo.com/api/files/textinputstream.html"
		  links.Value("TextOutputStream") = "https://documentation.xojo.com/api/files/textoutputstream.html"
		  
		  addSubMenu (8,10)
		  addXol (10)
		  
		  // graphics 30
		  'https://documentation.xojo.com/api/graphics/index.html    
		  
		  links.Value("ArcShape") = "https://documentation.xojo.com/api/graphics/arcshape.html"
		  links.Value("Color") = "https://documentation.xojo.com/api/graphics/color.html"
		  links.Value("ColorGroup") = "https://documentation.xojo.com/api/graphics/colorgroup.html"
		  links.Value("CurveShape") = "https://documentation.xojo.com/api/graphics/curveshape.html"
		  links.Value("ExportPicture") = "https://documentation.xojo.com/api/graphics/exportpicture.html"
		  links.Value("FigureShape") = "https://documentation.xojo.com/api/graphics/figureshape.html"
		  links.Value("Font") = "https://documentation.xojo.com/api/graphics/font.html"
		  links.Value("FontUnits") = "https://documentation.xojo.com/api/graphics/fontunits.html"
		  links.Value("Graphics ") = "https://documentation.xojo.com/api/graphics/graphics.html"
		  links.Value("GraphicsBrush") = "https://documentation.xojo.com/api/graphics/graphicsbrush.html"
		  links.Value("GraphicsPath") = "https://documentation.xojo.com/api/graphics/graphicspath.html"
		  links.Value("Group2D") = "https://documentation.xojo.com/api/graphics/group2d.html"                
		  links.Value("LinearGradientBrush") = "https://documentation.xojo.com/api/graphics/lineargradientbrush.html"
		  links.Value("Object2D") = "https://documentation.xojo.com/api/graphics/object2d.html"
		  links.Value("OpenGL") = "https://documentation.xojo.com/api/graphics/opengl.html"
		  links.Value("OvalShape") = "https://documentation.xojo.com/api/graphics/ovalshape.html"
		  links.Value("Picture") = "https://documentation.xojo.com/api/graphics/picture.html"
		  links.Value("PictureBrush") = "https://documentation.xojo.com/api/graphics/picturebrush.html"
		  links.Value("PixmapShape") = "https://documentation.xojo.com/api/graphics/pixmapshape.html"
		  links.Value("Point") = "https://documentation.xojo.com/api/graphics/point.html"
		  links.Value("RadialGradientBrush") = "https://documentation.xojo.com/api/graphics/radialgradientbrush.html"
		  links.Value("Rect") = "https://documentation.xojo.com/api/graphics/rect.html"
		  links.Value("RectShape") = "https://documentation.xojo.com/api/graphics/rectshape.html"
		  links.Value("RGBSurface") = "https://documentation.xojo.com/api/graphics/rgbsurface.html"
		  links.Value("RoundRectShape") = "https://documentation.xojo.com/api/graphics/roundrectshape.html"
		  links.Value("ShadowBrush") = "https://documentation.xojo.com/api/graphics/shadowbrush.html"
		  links.Value("Size") = "https://documentation.xojo.com/api/graphics/size.html"
		  links.Value("TextShape") = "https://documentation.xojo.com/api/graphics/textshape.html"
		  links.Value("WebGraphics") = "https://documentation.xojo.com/api/graphics/webgraphics.html"
		  links.Value("WebPicture") = "https://documentation.xojo.com/api/graphics/webpicture.html"
		  
		  addSubMenu (9,30)
		  addXol (30)
		  
		  // hardware
		  
		  'links.Value("") = "https://documentation.xojo.com/api/hardware/index.html"
		  links.Value("GameInputDevice") = "https://documentation.xojo.com/api/hardware/gameinputdevice.html"
		  links.Value("GameInputElement") = "https://documentation.xojo.com/api/hardware/gameinputelement.html"
		  links.Value("GameInputManager") = "https://documentation.xojo.com/api/hardware/gameinputmanager.html"
		  links.Value("Keyboard") = "https://documentation.xojo.com/api/hardware/keyboard.html"
		  links.Value("SerialConnection") = "https://documentation.xojo.com/api/hardware/serialconnection.html"
		  links.Value("SerialDevice") = "https://documentation.xojo.com/api/hardware/serialdevice.html"
		  
		  addSubMenu (10,6)
		  addXol (6)
		  
		  // ios
		  
		  'links.Value("") = "https://documentation.xojo.com/api/ios/index.html"
		  links.Value("iOSCountdownPicker") = "https://documentation.xojo.com/api/ios/ioscountdownpicker.html"
		  links.Value("iOSLayout") = "https://documentation.xojo.com/api/ios/ioslayout.html"
		  links.Value("iOSLayoutConstraint") = "https://documentation.xojo.com/api/ios/ioslayoutconstraint.html"
		  links.Value("iOSLayoutContent") = "https://documentation.xojo.com/api/ios/ioslayoutcontent.html"
		  links.Value("iOSMobileTable") = "https://documentation.xojo.com/api/ios/iosmobiletable.html"
		  links.Value("iOSMobileTableDataSource") = "https://documentation.xojo.com/api/ios/iosmobiletabledatasource.html"
		  links.Value("iOSMobileTableDataSourceEditing") = "https://documentation.xojo.com/api/ios/iosmobiletabledatasourceediting.html"
		  links.Value("iOSMobileTableDataSourceReordering") = "https://documentation.xojo.com/api/ios/iosmobiletabledatasourcereordering.html"
		  links.Value("iOSMobileTableRowAction") = "https://documentation.xojo.com/api/ios/iosmobiletablerowaction.html"
		  links.Value("iOSMobileUserControl") = "https://documentation.xojo.com/api/ios/iosmobileusercontrol.html"
		  links.Value("iOSSplitContent") = "https://documentation.xojo.com/api/ios/iossplitcontent.html"
		  links.Value("iOSSplitView") = "https://documentation.xojo.com/api/ios/iossplitview.html"
		  links.Value("iOSTabBar") = "https://documentation.xojo.com/api/ios/iostabbar.html"
		  links.Value("iOSTabContent") = "https://documentation.xojo.com/api/ios/iostabcontent.html"
		  links.Value("MapLocation") = "https://documentation.xojo.com/api/ios/maplocation.html"
		  links.Value("UserAuthentication") = "https://documentation.xojo.com/api/ios/userauthentication.html"
		  
		  addSubMenu (11,16)
		  addXol (16)
		  
		  //   language
		  
		  links.Value("&b") = "https://documentation.xojo.com/api/language/b.html"
		  links.Value("&c") = "https://documentation.xojo.com/api/language/c.html"
		  links.Value("&h") = "https://documentation.xojo.com/api/language/h.html"
		  links.Value("&o") = "https://documentation.xojo.com/api/language/o.html"
		  links.Value("&u") = "https://documentation.xojo.com/api/language/u.html"
		  links.Value("ActionNotificationReceiver") = "https://documentation.xojo.com/api/language/actionnotificationreceiver.html"
		  links.Value("ActionSource") = "https://documentation.xojo.com/api/language/actionsource.html"
		  links.Value("AddressOf") = "https://documentation.xojo.com/api/language/addressof.html"
		  links.Value("And") = "https://documentation.xojo.com/api/language/and.html"
		  links.Value("App") = "https://documentation.xojo.com/api/language/app.html"
		  links.Value("Array") = "https://documentation.xojo.com/api/language/array.html"
		  links.Value("Arrays") = "https://documentation.xojo.com/api/language/arrays.html"
		  links.Value("As") = "https://documentation.xojo.com/api/language/as.html"
		  links.Value("AttributeInfo") = "https://documentation.xojo.com/api/language/attributeinfo.html"
		  links.Value("Bitwise") = "https://documentation.xojo.com/api/language/bitwise.html"
		  links.Value("ByRef") = "https://documentation.xojo.com/api/language/byref.html"
		  links.Value("ByVal") = "https://documentation.xojo.com/api/language/byval.html"
		  links.Value("Class") = "https://documentation.xojo.com/api/language/class.html"
		  links.Value("Collection") = "https://documentation.xojo.com/api/language/collection.html"
		  links.Value("ComparisonOptions") = "https://documentation.xojo.com/api/language/comparisonoptions.html"
		  links.Value("ConsoleApplication") = "https://documentation.xojo.com/api/language/consoleapplication.html"
		  links.Value("Const") = "https://documentation.xojo.com/api/language/const.html"
		  links.Value("Constants") = "https://documentation.xojo.com/api/language/constants.html"
		  links.Value("Constructor") = "https://documentation.xojo.com/api/language/constructor.html"
		  links.Value("ConstructorInfo") = "https://documentation.xojo.com/api/language/constructorinfo.html"
		  links.Value("CType") = "https://documentation.xojo.com/api/language/ctype.html"
		  links.Value("CurrentMethodName") = "https://documentation.xojo.com/api/language/currentmethodname.html"
		  links.Value("DataNotificationReceiver") = "https://documentation.xojo.com/api/language/datanotificationreceiver.html"
		  links.Value("DataNotifier") = "https://documentation.xojo.com/api/language/datanotifier.html"
		  links.Value("DateInterval") = "https://documentation.xojo.com/api/language/dateinterval.html"
		  links.Value("Declare") = "https://documentation.xojo.com/api/language/declare.html"
		  links.Value("Delegate") = "https://documentation.xojo.com/api/language/delegate.html"
		  links.Value("Dictionary") = "https://documentation.xojo.com/api/language/dictionary.html"
		  links.Value("DictionaryEntry") = "https://documentation.xojo.com/api/language/dictionaryentry.html"
		  links.Value("Dim") = "https://documentation.xojo.com/api/language/dim.html"
		  links.Value("Equals") = "https://documentation.xojo.com/api/language/equals.html"
		  links.Value("Event") = "https://documentation.xojo.com/api/language/event.html"
		  links.Value("Extends") = "https://documentation.xojo.com/api/language/extends.html"
		  links.Value("False") = "https://documentation.xojo.com/api/language/false.html"
		  links.Value("Function") = "https://documentation.xojo.com/api/language/function.html"
		  links.Value("GetTypeInfo") = "https://documentation.xojo.com/api/language/gettypeinfo.html"
		  links.Value("Global") = "https://documentation.xojo.com/api/language/global.html"
		  links.Value("Implements") = "https://documentation.xojo.com/api/language/implements.html"
		  links.Value("Inherits") = "https://documentation.xojo.com/api/language/inherits.html"
		  links.Value("Interface") = "https://documentation.xojo.com/api/language/interface.html"
		  links.Value("Introspection") = "https://documentation.xojo.com/api/language/introspection.html"
		  links.Value("Is") = "https://documentation.xojo.com/api/language/is.html"
		  links.Value("IsA") = "https://documentation.xojo.com/api/language/isa.html"
		  links.Value("IsNumeric") = "https://documentation.xojo.com/api/language/isnumeric.html"
		  links.Value("Less than") = "https://documentation.xojo.com/api/language/less_than_or_equal.html"
		  links.Value("Less than or equal") = "https://documentation.xojo.com/api/language/less_than.html"
		  links.Value("Line Continuation") = "https://documentation.xojo.com/api/language/line_continuation.html"
		  links.Value("ListSelectionNotificationReceiver") = "https://documentation.xojo.com/api/language/listselectionnotificationreceiver.html"
		  links.Value("ListSelectionNotifier") = "https://documentation.xojo.com/api/language/listselectionnotifier.html"
		  links.Value("Me") = "https://documentation.xojo.com/api/language/me.html"
		  links.Value("MemberInfo") = "https://documentation.xojo.com/api/language/memberinfo.html"
		  links.Value("MemoryBlock") = "https://documentation.xojo.com/api/language/memoryblock.html"
		  links.Value("MethodInfo") = "https://documentation.xojo.com/api/language/methodinfo.html"
		  links.Value("Module") = "https://documentation.xojo.com/api/language/module.html"
		  links.Value("Mutex") = "https://documentation.xojo.com/api/language/mutex.html"
		  links.Value("New") = "https://documentation.xojo.com/api/language/new.html"
		  links.Value("Nil") = "https://documentation.xojo.com/api/language/nil.html"
		  links.Value("Not") = "https://documentation.xojo.com/api/language/not.html"
		  links.Value("Not equal") = "https://documentation.xojo.com/api/language/not_equal.html"
		  links.Value("Object") = "https://documentation.xojo.com/api/language/object.html"
		  links.Value("ObjectIterator") = "https://documentation.xojo.com/api/language/objectiterator.html"
		  links.Value("Optional") = "https://documentation.xojo.com/api/language/optional.html"
		  links.Value("Pair operator") = "https://documentation.xojo.com/api/language/pair_operator.html"
		  links.Value("ParamArray") = "https://documentation.xojo.com/api/language/paramarray.html"
		  links.Value("ParameterInfo") = "https://documentation.xojo.com/api/language/parameterinfo.html"
		  links.Value("Pragma Directives") = "https://documentation.xojo.com/api/language/pragma_directives.html"
		  links.Value("Private") = "https://documentation.xojo.com/api/language/private.html"
		  links.Value("Property") = "https://documentation.xojo.com/api/language/property.html"
		  links.Value("PropertyInfo") = "https://documentation.xojo.com/api/language/propertyinfo.html"
		  links.Value("Protected") = "https://documentation.xojo.com/api/language/protected.html"
		  links.Value("Public") = "https://documentation.xojo.com/api/language/public.html"
		  links.Value("Quit") = "https://documentation.xojo.com/api/language/quit.html"
		  links.Value("RaiseEvent") = "https://documentation.xojo.com/api/language/raiseevent.html"
		  links.Value("Readable") = "https://documentation.xojo.com/api/language/readable.html"
		  links.Value("Redim") = "https://documentation.xojo.com/api/language/redim.html"
		  links.Value("RemoveHandler") = "https://documentation.xojo.com/api/language/removehandler.html"
		  links.Value("Return") = "https://documentation.xojo.com/api/language/return.html"
		  links.Value("Runtime") = "https://documentation.xojo.com/api/language/runtime.html"
		  links.Value("Self") = "https://documentation.xojo.com/api/language/self_keyword.html"
		  links.Value("Semaphore") = "https://documentation.xojo.com/api/language/semaphore.html"
		  links.Value("ServiceApplication") = "https://documentation.xojo.com/api/language/serviceapplication.html"
		  links.Value("Shared") = "https://documentation.xojo.com/api/language/shared.html"
		  links.Value("Shuffle") = "https://documentation.xojo.com/api/language/shuffle.html"
		  links.Value("StackFrame") = "https://documentation.xojo.com/api/language/stackframe.html"
		  links.Value("Static") = "https://documentation.xojo.com/api/language/static.html"
		  links.Value("Structure") = "https://documentation.xojo.com/api/language/structure.html"
		  links.Value("Sub") = "https://documentation.xojo.com/api/language/sub.html"
		  links.Value("Super") = "https://documentation.xojo.com/api/language/super.html"
		  links.Value("Thread") = "https://documentation.xojo.com/api/language/thread.html"
		  links.Value("Timer") = "https://documentation.xojo.com/api/language/timer.html"
		  links.Value("True") = "https://documentation.xojo.com/api/language/true.html"
		  links.Value("TypeInfo") = "https://documentation.xojo.com/api/language/typeinfo.html"
		  links.Value("Using") = "https://documentation.xojo.com/api/language/using.html"
		  links.Value("Var") = "https://documentation.xojo.com/api/language/var.html"
		  links.Value("VarType") = "https://documentation.xojo.com/api/language/vartype.html"
		  links.Value("WeakAddressOf") = "https://documentation.xojo.com/api/language/weakaddressof.html"
		  links.Value("WeakRef") = "https://documentation.xojo.com/api/language/weakref.html"
		  links.Value("Worker") = "https://documentation.xojo.com/api/language/worker.html"
		  links.Value("Writeable") = "https://documentation.xojo.com/api/language/writeable.html"
		  links.Value("XojoVersion") = "https://documentation.xojo.com/api/language/xojoversion.html"
		  links.Value("XojoVersionString") = "https://documentation.xojo.com/api/language/xojoversionstring.html"
		  links.Value("Xor") = "https://documentation.xojo.com/api/language/xor.html"
		  
		  addSubMenu (-4,107)
		  addXol (107)
		  
		  // using language
		  
		  'links.Value("——Using the Xojo language") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/index.html"
		  linksMisc.Value("Variables and Constants") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/variables_and_constants.html"
		  linksMisc.Value("Data Types") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/data_types.html"
		  linksMisc.Value("Comparing Values") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/comparing_values.html"
		  linksMisc.Value("Event Driven Programming") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/event_driven_programming.html"
		  linksMisc.Value("Controlling Code Flow") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/controlling_code_flow.html"
		  linksMisc.Value("Repeating Code") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/repeating_code.html"
		  linksMisc.Value("Properties") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/properties.html"
		  linksMisc.Value("Methods") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/methods.html"
		  linksMisc.Value("Collections of Data") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/collections_of_data.html"
		  linksMisc.Value("Enumerations") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/enumerations.html"
		  linksMisc.Value("Modules") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/modules.html"
		  linksMisc.Value("Advanced Language Features") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/advanced_language_features.html"
		  linksMisc.Value("Reserved Words") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/reserved_words.html"
		  
		  addSubMenuMisc (-2,13)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub populateLinks2()
		  
		  // mac os
		  
		  'links.Value("") = "https://documentation.xojo.com/api/macos/index.html"
		  links.Value("AppleEvent") = "https://documentation.xojo.com/api/macos/appleevent.html"
		  links.Value("AppleEventDescList") = "https://documentation.xojo.com/api/macos/appleeventdesclist.html"
		  links.Value("AppleEventObjectSpecifier") = "https://documentation.xojo.com/api/macos/appleeventobjectspecifier.html"
		  links.Value("AppleEventRecord") = "https://documentation.xojo.com/api/macos/appleeventrecord.html"
		  links.Value("AppleEventTemplate") = "https://documentation.xojo.com/api/macos/appleeventtemplate.html"
		  links.Value("DockItem") = "https://documentation.xojo.com/api/macos/dockitem.html"
		  links.Value("GetIndexedObjectDescriptor") = "https://documentation.xojo.com/api/macos/getindexedobjectdescriptor.html"
		  links.Value("GetNamedObjectDescriptor") = "https://documentation.xojo.com/api/macos/getnamedobjectdescriptor.html"
		  links.Value("GetOrdinalObjectDescriptor") = "https://documentation.xojo.com/api/macos/getordinalobjectdescriptor.html"
		  links.Value("GetPropertyObjectDescriptor") = "https://documentation.xojo.com/api/macos/getpropertyobjectdescriptor.html"
		  links.Value("GetRangeObjectDescriptor") = "https://documentation.xojo.com/api/macos/getrangeobjectdescriptor.html"
		  links.Value("GetStringComparisonObjectDescriptor") = "https://documentation.xojo.com/api/macos/getstringcomparisonobjectdescriptor.html"
		  links.Value("GetTestObjectDescriptor") = "https://documentation.xojo.com/api/macos/gettestobjectdescriptor.html"
		  links.Value("GetUniqueIDObjectDescriptor") = "https://documentation.xojo.com/api/macos/getuniqueidobjectdescriptor.html"
		  links.Value("Keychain") = "https://documentation.xojo.com/api/macos/keychain.html"
		  links.Value("KeychainItem") = "https://documentation.xojo.com/api/macos/keychainitem.html"
		  links.Value("ObjCBlock") = "https://documentation.xojo.com/api/macos/objcblock.html"
		  links.Value("OSType") = "https://documentation.xojo.com/api/macos/ostype.html"
		  links.Value("SpotlightItem") = "https://documentation.xojo.com/api/macos/spotlightitem.html"
		  links.Value("SpotlightQuery") = "https://documentation.xojo.com/api/macos/spotlightquery.html"
		  
		  addSubMenu (12,20)
		  addXol (20)
		  
		  
		  // math
		  
		  'links.Value("") = "https://documentation.xojo.com/api/math/index.html"
		  links.Value("*") = "https://documentation.xojo.com/api/math/x.html"
		  links.Value("/") = "https://documentation.xojo.com/api/math/division.html"
		  links.Value("+") = "https://documentation.xojo.com/api/math/+.html"
		  links.Value("-") = "https://documentation.xojo.com/api/math/-.html"
		  links.Value("=") = "https://documentation.xojo.com/api/math/equals_operator.html"
		  links.Value("Abs") = "https://documentation.xojo.com/api/math/abs.html"
		  links.Value("Acos") = "https://documentation.xojo.com/api/math/acos.html"
		  links.Value("Asc") = "https://documentation.xojo.com/api/math/asc.html"
		  links.Value("Asin") = "https://documentation.xojo.com/api/math/asin.html"
		  links.Value("Atan") = "https://documentation.xojo.com/api/math/atan.html"
		  links.Value("Atan2") = "https://documentation.xojo.com/api/math/atan2.html"
		  links.Value("Ceiling") = "https://documentation.xojo.com/api/math/ceiling.html"
		  links.Value("Cos") = "https://documentation.xojo.com/api/math/cos.html"
		  links.Value("Exp") = "https://documentation.xojo.com/api/math/exp.html"
		  links.Value("Floor") = "https://documentation.xojo.com/api/math/floor.html"
		  links.Value("Integer Division") = "https://documentation.xojo.com/api/math/integer_division.html"
		  links.Value("Log") = "https://documentation.xojo.com/api/math/log.html"
		  links.Value("Max") = "https://documentation.xojo.com/api/math/max.html"
		  links.Value("Min") = "https://documentation.xojo.com/api/math/min.html"
		  links.Value("Mod") = "https://documentation.xojo.com/api/math/mod.html"
		  links.Value("Oct") = "https://documentation.xojo.com/api/math/oct.html"
		  links.Value("Operator Add") = "https://documentation.xojo.com/api/math/operator_add.html"
		  links.Value("Operator AddRight") = "https://documentation.xojo.com/api/math/operator_addright.html"
		  links.Value("Operator And") = "https://documentation.xojo.com/api/math/operator_and.html"
		  links.Value("Operator AndRight") = "https://documentation.xojo.com/api/math/operator_andright.html"
		  links.Value("Operator Compare") = "https://documentation.xojo.com/api/math/operator_compare.html"
		  links.Value("Operator Convert") = "https://documentation.xojo.com/api/math/operator_convert.html"
		  links.Value("Operator Divide") = "https://documentation.xojo.com/api/math/operator_divide.html"
		  links.Value("Operator DivideRight") = "https://documentation.xojo.com/api/math/operator_divideright.html"
		  links.Value("Operator IntegerDivide") = "https://documentation.xojo.com/api/math/operator_integerdivide.html"
		  links.Value("Operator IntegerDivideRight") = "https://documentation.xojo.com/api/math/operator_integerdivideright.html"
		  links.Value("Operator Lookup") = "https://documentation.xojo.com/api/math/operator_lookup.html"
		  links.Value("Operator Modulo") = "https://documentation.xojo.com/api/math/operator_modulo.html"
		  links.Value("Operator ModuloRight") = "https://documentation.xojo.com/api/math/operator_moduloright.html"
		  links.Value("Operator Multiply") = "https://documentation.xojo.com/api/math/operator_multiply.html"
		  links.Value("Operator MultiplyRight") = "https://documentation.xojo.com/api/math/operator_multiplyright.html"
		  links.Value("Operator Negate") = "https://documentation.xojo.com/api/math/operator_negate.html"
		  links.Value("Operator Not") = "https://documentation.xojo.com/api/math/operator_not.html"
		  links.Value("Operator Or") = "https://documentation.xojo.com/api/math/operator_or.html"
		  links.Value("Operator OrRight") = "https://documentation.xojo.com/api/math/operator_orright.html"
		  links.Value("Operator Overloading") = "https://documentation.xojo.com/api/math/operator_overloading.html"
		  links.Value("Operator Power") = "https://documentation.xojo.com/api/math/operator_power.html"
		  links.Value("Operator PowerRight") = "https://documentation.xojo.com/api/math/operator_powerright.html"
		  links.Value("Operator Precedence") = "https://documentation.xojo.com/api/math/operator_precedence.html"
		  links.Value("Operator Redim") = "https://documentation.xojo.com/api/math/operator_redim.html"
		  links.Value("Operator Subscript") = "https://documentation.xojo.com/api/math/operator_subscript.html"
		  links.Value("Operator Subtract") = "https://documentation.xojo.com/api/math/operator_subtract.html"
		  links.Value("Operator SubtractRight") = "https://documentation.xojo.com/api/math/operator_subtractright.html"
		  links.Value("Operator XOr") = "https://documentation.xojo.com/api/math/operator_xor.html"
		  links.Value("Operator XOrRight") = "https://documentation.xojo.com/api/math/operator_xorright.html"
		  links.Value("Pow") = "https://documentation.xojo.com/api/math/pow.html"
		  links.Value("Random") = "https://documentation.xojo.com/api/math/random.html"
		  links.Value("Rnd") = "https://documentation.xojo.com/api/math/rnd.html"
		  links.Value("Round") = "https://documentation.xojo.com/api/math/round.html"
		  links.Value("Sign") = "https://documentation.xojo.com/api/math/sign.html"
		  links.Value("Sin") = "https://documentation.xojo.com/api/math/sin.html"
		  links.Value("Sqrt") = "https://documentation.xojo.com/api/math/sqrt.html"
		  links.Value("Tan") = "https://documentation.xojo.com/api/math/tan.html"
		  links.Value("^") = "https://documentation.xojo.com/api/math/%5E.html"
		  
		  addSubMenu (13,59)
		  addXol (59)
		  
		  // mobile
		  
		  '"links.Value("") = "https://documentation.xojo.com/api/mobile/index.html"
		  links.Value("DeviceData") = "https://documentation.xojo.com/api/mobile/devicedata.html"
		  links.Value("MobileApplication") = "https://documentation.xojo.com/api/mobile/mobileapplication.html"
		  links.Value("MobileLocation") = "https://documentation.xojo.com/api/mobile/mobilelocation.html"
		  links.Value("MobileMotion") = "https://documentation.xojo.com/api/mobile/mobilemotion.html"
		  links.Value("MobileNotifications") = "https://documentation.xojo.com/api/mobile/mobilenotifications.html"
		  links.Value("NotificationCenter") = "https://documentation.xojo.com/api/mobile/notificationcenter.html"
		  
		  addSubMenu (14,6)
		  addXol (6)
		  
		  // networking 19
		  
		  links.Value("AutoDiscovery") = "https://documentation.xojo.com/api/networking/autodiscovery.html"
		  links.Value("Datagram") = "https://documentation.xojo.com/api/networking/datagram.html"
		  links.Value("EasyTCPSocket") = "https://documentation.xojo.com/api/networking/easytcpsocket.html"
		  links.Value("EasyUDPSocket") = "https://documentation.xojo.com/api/networking/easyudpsocket.html"
		  links.Value("EmailAttachment") = "https://documentation.xojo.com/api/networking/emailattachment.html"
		  links.Value("EmailHeaders") = "https://documentation.xojo.com/api/networking/emailheaders.html"
		  links.Value("EmailMessage") = "https://documentation.xojo.com/api/networking/emailmessage.html"
		  links.Value("InternetHeaders") = "https://documentation.xojo.com/api/networking/internetheaders.html"
		  links.Value("IPCSocket") = "https://documentation.xojo.com/api/networking/ipcsocket.html"
		  links.Value("Network") = "https://documentation.xojo.com/api/networking/network.html"
		  links.Value("NetworkInterface") = "https://documentation.xojo.com/api/networking/networkinterface.html"
		  links.Value("POP3SecureSocket") = "https://documentation.xojo.com/api/networking/pop3securesocket.html"
		  links.Value("ServerSocket") = "https://documentation.xojo.com/api/networking/serversocket.html"
		  links.Value("SMTPSecureSocket") = "https://documentation.xojo.com/api/networking/smtpsecuresocket.html"
		  links.Value("SocketCore") = "https://documentation.xojo.com/api/networking/socketcore.html"
		  links.Value("SSLSocket") = "https://documentation.xojo.com/api/networking/sslsocket.html"
		  links.Value("TCPSocket") = "https://documentation.xojo.com/api/networking/tcpsocket.html"
		  links.Value("UDPSocket") = "https://documentation.xojo.com/api/networking/udpsocket.html"
		  links.Value("URLConnection") = "https://documentation.xojo.com/api/networking/urlconnection.html"
		  
		  addSubMenu (15,19)
		  addXol (19)
		  
		  // OS
		  
		  'links.Value("") = "https://documentation.xojo.com/api/os/index.html"
		  links.Value("Input") = "https://documentation.xojo.com/api/os/input.html"
		  links.Value("Locale") = "https://documentation.xojo.com/api/os/locale.html"
		  links.Value("OSHandle") = "https://documentation.xojo.com/api/os/oshandle.html"
		  links.Value("Shell") = "https://documentation.xojo.com/api/os/shell.html"
		  links.Value("Sound") = "https://documentation.xojo.com/api/os/sound.html"
		  links.Value("StdErr") = "https://documentation.xojo.com/api/os/stderr.html"
		  links.Value("StdIn") = "https://documentation.xojo.com/api/os/stdin.html"
		  links.Value("StdOut") = "https://documentation.xojo.com/api/os/stdout.html"
		  links.Value("System") = "https://documentation.xojo.com/api/os/system.html"
		  links.Value("System.VersionData") = "https://documentation.xojo.com/api/os/system.versiondata.html"
		  links.Value("TimeZone") = "https://documentation.xojo.com/api/os/timezone.html"
		  
		  addSubMenu (16,11)
		  addXol (11)
		  
		  // pdf
		  
		  'links.Value("") = "https://documentation.xojo.com/api/pdf/index.html"
		  links.Value("PDFAnnotation") = "https://documentation.xojo.com/api/pdf/pdfannotation.html"
		  links.Value("PDFButton") = "https://documentation.xojo.com/api/pdf/pdfbutton.html"
		  links.Value("PDFCallout") = "https://documentation.xojo.com/api/pdf/pdfcallout.html"
		  links.Value("PDFCheckBox") = "https://documentation.xojo.com/api/pdf/pdfcheckbox.html"
		  links.Value("PDFComboBox") = "https://documentation.xojo.com/api/pdf/pdfcombobox.html"
		  links.Value("PDFControl") = "https://documentation.xojo.com/api/pdf/pdfcontrol.html"
		  links.Value("PDFDocument") = "https://documentation.xojo.com/api/pdf/pdfdocument.html"
		  links.Value("PDFGraphics") = "https://documentation.xojo.com/api/pdf/pdfgraphics.html"
		  links.Value("PDFLine") = "https://documentation.xojo.com/api/pdf/pdfline.html"
		  links.Value("PDFListBox") = "https://documentation.xojo.com/api/pdf/pdflistbox.html"
		  links.Value("PDFPermissions") = "https://documentation.xojo.com/api/pdf/pdfpermissions.html"
		  links.Value("PDFPopupMenu") = "https://documentation.xojo.com/api/pdf/pdfpopupmenu.html"
		  links.Value("PDFRadioButton") = "https://documentation.xojo.com/api/pdf/pdfradiobutton.html"
		  links.Value("PDFShape") = "https://documentation.xojo.com/api/pdf/pdfshape.html"
		  links.Value("PDFSignature") = "https://documentation.xojo.com/api/pdf/pdfsignature.html"
		  links.Value("PDFTextArea") = "https://documentation.xojo.com/api/pdf/pdftextarea.html"
		  links.Value("PDFTextControl") = "https://documentation.xojo.com/api/pdf/pdftextcontrol.html"
		  links.Value("PDFTextField") = "https://documentation.xojo.com/api/pdf/pdftextfield.html"
		  links.Value("PDFTOCEntry") = "https://documentation.xojo.com/api/pdf/pdftocentry.html"
		  links.Value("PDFTransition") = "https://documentation.xojo.com/api/pdf/pdftransition.html"
		  
		  addSubMenu (17,20)
		  addXol (20)
		  
		  // printing
		  
		  'links.Value("") = "https://documentation.xojo.com/api/printing/index.html"
		  links.Value("Print") = "https://documentation.xojo.com/api/printing/print.html"
		  links.Value("PrinterSetup") = "https://documentation.xojo.com/api/printing/printersetup.html"
		  links.Value("Reporting  >>") = "https://documentation.xojo.com/api/printing/reporting/index.html"
		  links.Value("ShowPrinterDialog") = "https://documentation.xojo.com/api/printing/showprinterdialog.html"
		  links.Value("StyledTextPrinter") = "https://documentation.xojo.com/api/printing/styledtextprinter.html"
		  
		  addSubMenu (18,5)
		  addXol (5)
		  
		  // Text
		  
		  'links.Value("") = "https://documentation.xojo.com/api/text/index.html"
		  links.Value("Bin") = "https://documentation.xojo.com/api/text/bin.html"
		  links.Value("Chr") = "https://documentation.xojo.com/api/text/chr.html"
		  links.Value("CStr") = "https://documentation.xojo.com/api/text/cstr.html"
		  links.Value("DecodeBase64") = "https://documentation.xojo.com/api/text/encoding_text/decodebase64.html"
		  links.Value("EncodeBase64") = "https://documentation.xojo.com/api/text/encoding_text/encodebase64.html"
		  links.Value("Encodings") = "https://documentation.xojo.com/api/text/encoding_text/encodings.html"
		  links.Value("Encoding Text") = "https://documentation.xojo.com/api/text/encoding_text/index.html"
		  links.Value("TextEncoding") = "https://documentation.xojo.com/api/text/encoding_text/textencoding.html"
		  links.Value("EndOfLine") = "https://documentation.xojo.com/api/text/endofline.html"
		  links.Value("Format") = "https://documentation.xojo.com/api/text/format.html"
		  links.Value("Hex") = "https://documentation.xojo.com/api/text/hex.html"
		  links.Value("JSON") = "https://documentation.xojo.com/api/text/json/index.html"
		  links.Value("Left") = "https://documentation.xojo.com/api/text/left.html"
		  links.Value("Len") = "https://documentation.xojo.com/api/text/len.html"
		  links.Value("Lowercase") = "https://documentation.xojo.com/api/text/lowercase.html"
		  links.Value("Mid") = "https://documentation.xojo.com/api/text/mid.html"
		  links.Value("Paragraph") = "https://documentation.xojo.com/api/text/paragraph.html"
		  links.Value("Range") = "https://documentation.xojo.com/api/text/range.html"
		  links.Value("Regular Expressions") = "https://documentation.xojo.com/api/text/regular_expressions/index.html"
		  links.Value("Regex") = "https://documentation.xojo.com/api/text/regular_expressions/regex.html"
		  links.Value("Right") = "https://documentation.xojo.com/api/text/right.html"
		  links.Value("Str") = "https://documentation.xojo.com/api/text/str.html"
		  links.Value("StyledText") = "https://documentation.xojo.com/api/text/styledtext.html"
		  links.Value("StyleRun") = "https://documentation.xojo.com/api/text/stylerun.html"
		  links.Value("TextAlignments") = "https://documentation.xojo.com/api/text/textalignments.html"
		  links.Value("Trim") = "https://documentation.xojo.com/api/text/trim.html"
		  links.Value("Uppercase") = "https://documentation.xojo.com/api/text/uppercase.html"
		  links.Value("Val") = "https://documentation.xojo.com/api/text/val.html"
		  links.Value("XML") = "https://documentation.xojo.com/api/text/xml/index.html"
		  links.Value("XMLDocument") = "https://documentation.xojo.com/api/text/xml/xmldocument.html"
		  
		  addSubMenu (19,30)
		  addXol (30)
		  
		  // User interface
		  
		  links.Value("AppSupportsDarkMode") = "https://documentation.xojo.com/api/user_interface/appsupportsdarkmode.html"
		  links.Value("AppSupportsHiDPI") = "https://documentation.xojo.com/api/user_interface/appsupportshidpi.html"
		  links.Value("Clipboard") = "https://documentation.xojo.com/api/user_interface/clipboard.html"
		  links.Value("Controls >>") = "https://documentation.xojo.com/api/user_interface/controls/index.html"
		  links.Value("Desktop >>") = "https://documentation.xojo.com/api/user_interface/desktop/index.html"
		  links.Value("Localization") = "https://documentation.xojo.com/api/user_interface/localization.html"
		  links.Value("MessageBox") = "https://documentation.xojo.com/api/user_interface/messagebox.html"
		  links.Value("Mobile >>") = "https://documentation.xojo.com/api/user_interface/mobile/index.html"
		  links.Value("Movie") = "https://documentation.xojo.com/api/user_interface/movie.html"
		  links.Value("Notifications >>") = "https://documentation.xojo.com/api/user_interface/notifications/index.html"
		  links.Value("Web >>") = "https://documentation.xojo.com/api/user_interface/web/index.html"
		  
		  addSubMenu (20,11)
		  addXol (11)
		  
		  // interface Desktop
		  
		  links.Value("ApplicationMenuItem") = "https://documentation.xojo.com/api/user_interface/desktop/applicationmenuitem.html"
		  links.Value("ClearFocus") = "https://documentation.xojo.com/api/user_interface/desktop/clearfocus.html"
		  links.Value("Cursors") = "https://documentation.xojo.com/api/user_interface/desktop/cursors.html"
		  links.Value("DesktopApplication") = "https://documentation.xojo.com/api/user_interface/desktop/desktopapplication.html"
		  links.Value("DesktopApplicationMenuItem") = "https://documentation.xojo.com/api/user_interface/desktop/desktopapplicationmenuitem.html"
		  links.Value("DesktopBevelButton") = "https://documentation.xojo.com/api/user_interface/desktop/desktopbevelbutton.html"
		  links.Value("DesktopButton") = "https://documentation.xojo.com/api/user_interface/desktop/desktopbutton.html"
		  links.Value("DesktopCanvas") = "https://documentation.xojo.com/api/user_interface/desktop/desktopcanvas.html"
		  links.Value("DesktopCheckBox") = "https://documentation.xojo.com/api/user_interface/desktop/desktopcheckbox.html"
		  links.Value("DesktopColorPicker") = "https://documentation.xojo.com/api/user_interface/desktop/desktopcolorpicker.html"
		  links.Value("DesktopComboBox") = "https://documentation.xojo.com/api/user_interface/desktop/desktopcombobox.html"
		  links.Value("DesktopContainer") = "https://documentation.xojo.com/api/user_interface/desktop/desktopcontainer.html"
		  links.Value("DesktopControl") = "https://documentation.xojo.com/api/user_interface/desktop/desktopcontrol.html"
		  links.Value("DesktopDateTimePicker") = "https://documentation.xojo.com/api/user_interface/desktop/desktopdatetimepicker.html"
		  links.Value("DesktopDisclosureTriangle") = "https://documentation.xojo.com/api/user_interface/desktop/desktopdisclosuretriangle.html"
		  links.Value("DesktopDisplay") = "https://documentation.xojo.com/api/user_interface/desktop/desktopdisplay.html"
		  links.Value("DesktopGroupBox") = "https://documentation.xojo.com/api/user_interface/desktop/desktopgroupbox.html"
		  links.Value("DesktopHTMLViewer") = "https://documentation.xojo.com/api/user_interface/desktop/desktophtmlviewer.html"
		  links.Value("DesktopImageViewer") = "https://documentation.xojo.com/api/user_interface/desktop/desktopimageviewer.html"
		  links.Value("DesktopLabel") = "https://documentation.xojo.com/api/user_interface/desktop/desktoplabel.html"
		  links.Value("DesktopListBox") = "https://documentation.xojo.com/api/user_interface/desktop/desktoplistbox.html"
		  links.Value("DesktopListBoxCell") = "https://documentation.xojo.com/api/user_interface/desktop/desktoplistboxcell.html"
		  links.Value("DesktopListBoxCheckBoxCell") = "https://documentation.xojo.com/api/user_interface/desktop/desktoplistboxcheckboxcell.html"
		  links.Value("DesktopListBoxColumn") = "https://documentation.xojo.com/api/user_interface/desktop/desktoplistboxcolumn.html"
		  links.Value("DesktopListBoxRow") = "https://documentation.xojo.com/api/user_interface/desktop/desktoplistboxrow.html"
		  links.Value("DesktopMenuBar") = "https://documentation.xojo.com/api/user_interface/desktop/desktopmenubar.html"
		  links.Value("DesktopMenuItem") = "https://documentation.xojo.com/api/user_interface/desktop/desktopmenuitem.html"
		  links.Value("DesktopMoviePlayer") = "https://documentation.xojo.com/api/user_interface/desktop/desktopmovieplayer.html"
		  links.Value("DesktopNotePlayer") = "https://documentation.xojo.com/api/user_interface/desktop/desktopnoteplayer.html"
		  links.Value("DesktopOLEContainer") = "https://documentation.xojo.com/api/user_interface/desktop/desktopolecontainer.html"
		  links.Value("DesktopOpenGLSurface") = "https://documentation.xojo.com/api/user_interface/desktop/desktopopenglsurface.html"
		  links.Value("DesktopOval") = "https://documentation.xojo.com/api/user_interface/desktop/desktopoval.html"
		  links.Value("DesktopPopupArrow") = "https://documentation.xojo.com/api/user_interface/desktop/desktoppagepanel.html"
		  links.Value("DesktopPagePanel") = "https://documentation.xojo.com/api/user_interface/desktop/desktoppopuparrow.html"
		  links.Value("DesktopPopupMenu") = "https://documentation.xojo.com/api/user_interface/desktop/desktoppopupmenu.html"
		  links.Value("DesktopPreferencesMenuItem") = "https://documentation.xojo.com/api/user_interface/desktop/desktoppreferencesmenuitem.html"
		  links.Value("DesktopProgressBar") = "https://documentation.xojo.com/api/user_interface/desktop/desktopprogressbar.html"
		  links.Value("DesktopProgressWheel") = "https://documentation.xojo.com/api/user_interface/desktop/desktopprogresswheel.html"
		  links.Value("DesktopQuitMenuItem") = "https://documentation.xojo.com/api/user_interface/desktop/desktopquitmenuitem.html"
		  links.Value("DesktopRadioButton") = "https://documentation.xojo.com/api/user_interface/desktop/desktopradiobutton.html"
		  links.Value("DesktopRadioGroup") = "https://documentation.xojo.com/api/user_interface/desktop/desktopradiogroup.html"
		  links.Value("DesktopRectangle") = "https://documentation.xojo.com/api/user_interface/desktop/desktoprectangle.html"
		  links.Value("DesktopScrollbar") = "https://documentation.xojo.com/api/user_interface/desktop/desktopscrollbar.html"
		  links.Value("DesktopSearchField") = "https://documentation.xojo.com/api/user_interface/desktop/desktopsearchfield.html"
		  links.Value("DesktopSegmentedButton") = "https://documentation.xojo.com/api/user_interface/desktop/desktopsegmentedbutton.html"
		  links.Value("DesktopSeparator") = "https://documentation.xojo.com/api/user_interface/desktop/desktopseparator.html"
		  links.Value("DesktopSlider") = "https://documentation.xojo.com/api/user_interface/desktop/desktopslider.html"
		  links.Value("DesktopTabPanel") = "https://documentation.xojo.com/api/user_interface/desktop/desktoptabpanel.html"
		  links.Value("DesktopTextArea") = "https://documentation.xojo.com/api/user_interface/desktop/desktoptextarea.html"
		  links.Value("DesktopTextControl") = "https://documentation.xojo.com/api/user_interface/desktop/desktoptextcontrol.html"
		  links.Value("DesktopTextField") = "https://documentation.xojo.com/api/user_interface/desktop/desktoptextfield.html"
		  links.Value("DesktopToolbar") = "https://documentation.xojo.com/api/user_interface/desktop/desktoptoolbar.html"
		  links.Value("DesktopToolbarButton") = "https://documentation.xojo.com/api/user_interface/desktop/desktoptoolbarbutton.html"
		  links.Value("DesktopToolbarItem") = "https://documentation.xojo.com/api/user_interface/desktop/desktoptoolbaritem.html"
		  links.Value("DesktopUIControl") = "https://documentation.xojo.com/api/user_interface/desktop/desktopuicontrol.html"
		  links.Value("DesktopUpDownArrows") = "https://documentation.xojo.com/api/user_interface/desktop/desktopupdownarrows.html"
		  links.Value("DesktopWindow") = "https://documentation.xojo.com/api/user_interface/desktop/desktopwindow.html"
		  links.Value("DragItem") = "https://documentation.xojo.com/api/user_interface/desktop/dragitem.html"
		  links.Value("FolderItemDialog") = "https://documentation.xojo.com/api/user_interface/desktop/folderitemdialog.html"
		  links.Value("IsContextualClick") = "https://documentation.xojo.com/api/user_interface/desktop/iscontextualclick.html"
		  links.Value("MDIWindow") = "https://documentation.xojo.com/api/user_interface/desktop/mdiwindow.html"
		  links.Value("MessageDialog") = "https://documentation.xojo.com/api/user_interface/desktop/messagedialog.html"
		  links.Value("MessageDialogButton") = "https://documentation.xojo.com/api/user_interface/desktop/messagedialogbutton.html"
		  links.Value("MouseCursor") = "https://documentation.xojo.com/api/user_interface/desktop/mousecursor.html"
		  links.Value("OpenFileDialog") = "https://documentation.xojo.com/api/user_interface/desktop/openfiledialog.html"
		  links.Value("PrefsMenuItem") = "https://documentation.xojo.com/api/user_interface/desktop/prefsmenuitem.html"
		  links.Value("QuitMenuItem") = "https://documentation.xojo.com/api/user_interface/desktop/quitmenuitem.html"
		  links.Value("SaveFileDialog") = "https://documentation.xojo.com/api/user_interface/desktop/savefiledialog.html"
		  links.Value("Segment") = "https://documentation.xojo.com/api/user_interface/desktop/segment.html"
		  links.Value("SelectFolderDialog") = "https://documentation.xojo.com/api/user_interface/desktop/selectfolderdialog.html"
		  links.Value("UserCancelled") = "https://documentation.xojo.com/api/user_interface/desktop/usercancelled.html"
		  
		  addSubMenu (21,71)
		  addXol (71)
		  
		  
		  // user interface web
		  
		  links.Value("WebAudioPlayer") = "https://documentation.xojo.com/api/user_interface/web/webaudioplayer.html"
		  links.Value("WebBreadCrumb") = "https://documentation.xojo.com/api/user_interface/web/webbreadcrumb.html"
		  links.Value("WebButton") = "https://documentation.xojo.com/api/user_interface/web/webbutton.html"
		  links.Value("WebCanvas") = "https://documentation.xojo.com/api/user_interface/web/webcanvas.html"
		  links.Value("WebChart") = "https://documentation.xojo.com/api/user_interface/web/webchart.html"
		  links.Value("WebChartCircularDataset") = "https://documentation.xojo.com/api/user_interface/web/webchartcirculardataset.html"
		  links.Value("WebChartDataset") = "https://documentation.xojo.com/api/user_interface/web/webchartdataset.html"
		  links.Value("WebChartLinearDataset") = "https://documentation.xojo.com/api/user_interface/web/webchartlineardataset.html"
		  links.Value("WebChartScatterDatapoint") = "https://documentation.xojo.com/api/user_interface/web/webchartscatterdatapoint.html"
		  links.Value("WebChartScatterDataset") = "https://documentation.xojo.com/api/user_interface/web/webchartscatterdataset.html"
		  links.Value("WebCheckBox") = "https://documentation.xojo.com/api/user_interface/web/webcheckbox.html"
		  links.Value("WebComboBox") = "https://documentation.xojo.com/api/user_interface/web/webcombobox.html"
		  links.Value("WebContainer") = "https://documentation.xojo.com/api/user_interface/web/webcontainer.html"
		  links.Value("WebControl") = "https://documentation.xojo.com/api/user_interface/web/webcontrol.html"
		  links.Value("WebDatePicker") = "https://documentation.xojo.com/api/user_interface/web/webdatepicker.html"
		  links.Value("WebDialog") = "https://documentation.xojo.com/api/user_interface/web/webdialog.html"
		  links.Value("WebEntryField") = "https://documentation.xojo.com/api/user_interface/web/webentryfield.html"
		  links.Value("WebFileUploader") = "https://documentation.xojo.com/api/user_interface/web/webfileuploader.html"
		  links.Value("WebHTMLViewer") = "https://documentation.xojo.com/api/user_interface/web/webhtmlviewer.html"
		  links.Value("WebImageViewer") = "https://documentation.xojo.com/api/user_interface/web/webimageviewer.html"
		  links.Value("WebLabel") = "https://documentation.xojo.com/api/user_interface/web/weblabel.html"
		  links.Value("WebLink") = "https://documentation.xojo.com/api/user_interface/web/weblink.html"
		  links.Value("WebListBox") = "https://documentation.xojo.com/api/user_interface/web/weblistbox.html"
		  links.Value("WebMapViewer") = "https://documentation.xojo.com/api/user_interface/web/webmapviewer.html"
		  links.Value("WebMenuItem") = "https://documentation.xojo.com/api/user_interface/web/webmenuitem.html"
		  links.Value("WebMessageDialog") = "https://documentation.xojo.com/api/user_interface/web/webmessagedialog.html"
		  links.Value("WebMessageDialogButton") = "https://documentation.xojo.com/api/user_interface/web/webmessagedialogbutton.html"
		  links.Value("WebMoviePlayer") = "https://documentation.xojo.com/api/user_interface/web/webmovieplayer.html"
		  links.Value("WebPage") = "https://documentation.xojo.com/api/user_interface/web/webpage.html"
		  links.Value("WebPagePanel") = "https://documentation.xojo.com/api/user_interface/web/webpagepanel.html"
		  links.Value("WebPagination") = "https://documentation.xojo.com/api/user_interface/web/webpagination.html"
		  links.Value("WebPopupMenu") = "https://documentation.xojo.com/api/user_interface/web/webpopupmenu.html"
		  links.Value("WebProgressBar") = "https://documentation.xojo.com/api/user_interface/web/webprogressbar.html"
		  links.Value("WebProgressWheel") = "https://documentation.xojo.com/api/user_interface/web/webprogresswheel.html"
		  links.Value("WebRadioButton") = "https://documentation.xojo.com/api/user_interface/web/webradiobutton.html"
		  links.Value("WebRadioGroup") = "https://documentation.xojo.com/api/user_interface/web/webradiogroup.html"
		  links.Value("WebRectangle") = "https://documentation.xojo.com/api/user_interface/web/webrectangle.html"
		  links.Value("WebSearchField") = "https://documentation.xojo.com/api/user_interface/web/websearchfield.html"
		  links.Value("WebSegment") = "https://documentation.xojo.com/api/user_interface/web/websegment.html"
		  links.Value("WebSegmentedButton") = "https://documentation.xojo.com/api/user_interface/web/websegmentedbutton.html"
		  links.Value("WebSlider") = "https://documentation.xojo.com/api/user_interface/web/webslider.html"
		  links.Value("WebStyle") = "https://documentation.xojo.com/api/user_interface/web/webstyle.html"
		  links.Value("WebTabPanel") = "https://documentation.xojo.com/api/user_interface/web/webtabpanel.html"
		  links.Value("WebTextArea") = "https://documentation.xojo.com/api/user_interface/web/webtextarea.html"
		  links.Value("WebTextControl") = "https://documentation.xojo.com/api/user_interface/web/webtextcontrol.html"
		  links.Value("WebTextField") = "https://documentation.xojo.com/api/user_interface/web/webtextfield.html"
		  links.Value("WebToolbar") = "https://documentation.xojo.com/api/user_interface/web/webtoolbar.html"
		  links.Value("WebToolbarButton") = "https://documentation.xojo.com/api/user_interface/web/webtoolbarbutton.html"
		  links.Value("WebToolbarItem") = "https://documentation.xojo.com/api/user_interface/web/webtoolbaritem.html"
		  links.Value("WebToolTip") = "https://documentation.xojo.com/api/user_interface/web/webtooltip.html"
		  links.Value("WebUIControl") = "https://documentation.xojo.com/api/user_interface/web/webuicontrol.html"
		  links.Value("WebView") = "https://documentation.xojo.com/api/user_interface/web/webview.html"
		  
		  addSubMenu (22,52)
		  addXol (52)
		  // Web
		  
		  'links.Value("") = "https://documentation.xojo.com/api/web/index.html"
		  links.Value("Session") = "https://documentation.xojo.com/api/web/session.html"
		  links.Value("WebApplication") = "https://documentation.xojo.com/api/web/webapplication.html"
		  links.Value("WebCookieManager") = "https://documentation.xojo.com/api/web/webcookiemanager.html"
		  links.Value("WebCursors") = "https://documentation.xojo.com/api/web/webcursors.html"
		  links.Value("WebDataSource") = "https://documentation.xojo.com/api/web/webdatasource.html"
		  links.Value("WebFile") = "https://documentation.xojo.com/api/web/webfile.html"
		  links.Value("WebListBoxCellRenderer") = "https://documentation.xojo.com/api/web/weblistboxcellrenderer.html"
		  links.Value("WebListBoxColumnData") = "https://documentation.xojo.com/api/web/weblistboxcolumndata.html"
		  links.Value("WebListBoxDateTimeRenderer") = "https://documentation.xojo.com/api/web/weblistboxdatetimerenderer.html"
		  links.Value("WebListBoxImageRenderer") = "https://documentation.xojo.com/api/web/weblistboximagerenderer.html"
		  links.Value("WebListBoxRowData") = "https://documentation.xojo.com/api/web/weblistboxrowdata.html"
		  links.Value("WebListBoxStyleRenderer") = "https://documentation.xojo.com/api/web/weblistboxstylerenderer.html"
		  links.Value("WebLocation") = "https://documentation.xojo.com/api/web/weblocation.html"
		  links.Value("WebMapLocation") = "https://documentation.xojo.com/api/web/webmaplocation.html"
		  links.Value("WebObject") = "https://documentation.xojo.com/api/web/webobject.html"
		  links.Value("WebRequest") = "https://documentation.xojo.com/api/web/webrequest.html"
		  links.Value("WebResponse") = "https://documentation.xojo.com/api/web/webresponse.html"
		  links.Value("WebSession") = "https://documentation.xojo.com/api/web/websession.html"
		  links.Value("WebSessionContext") = "https://documentation.xojo.com/api/web/websessioncontext.html"
		  links.Value("WebThread") = "https://documentation.xojo.com/api/web/webthread.html"
		  links.Value("WebTimer") = "https://documentation.xojo.com/api/web/webtimer.html"
		  links.Value("WebUploadedFile") = "https://documentation.xojo.com/api/web/webuploadedfile.html"
		  
		  addSubMenu (23,22)
		  addXol (22)
		  
		  // Windows
		  
		  'links.Value("") = "https://documentation.xojo.com/api/windows/index.html"
		  links.Value("COM") = "https://documentation.xojo.com/api/windows/com.html"
		  links.Value("ExcelApplication") = "https://documentation.xojo.com/api/windows/excelapplication.html"
		  links.Value("IDispatch") = "https://documentation.xojo.com/api/windows/idispatch.html"
		  links.Value("IEnumVARIANT") = "https://documentation.xojo.com/api/windows/ienumvariant.html"
		  links.Value("IPicture") = "https://documentation.xojo.com/api/windows/ipicture.html"
		  links.Value("IUnknown") = "https://documentation.xojo.com/api/windows/iunknown.html"
		  links.Value("Office") = "https://documentation.xojo.com/api/windows/office.html"
		  links.Value("OLEContainer") = "https://documentation.xojo.com/api/windows/olecontainer.html"
		  links.Value("OLEObject") = "https://documentation.xojo.com/api/windows/oleobject.html"
		  links.Value("OLEParameter") = "https://documentation.xojo.com/api/windows/oleparameter.html"
		  links.Value("PowerPointApplication") = "https://documentation.xojo.com/api/windows/powerpointapplication.html"
		  links.Value("RegistryItem") = "https://documentation.xojo.com/api/windows/registryitem.html"
		  links.Value("TrayItem") = "https://documentation.xojo.com/api/windows/trayitem.html"
		  links.Value("WordApplication") = "https://documentation.xojo.com/api/windows/wordapplication.html"
		  
		  addSubMenu (24,14)
		  addXol (14)
		  
		  // Xojo Cloud
		  
		  'links.Value("") = "https://documentation.xojo.com/api/xojocloud/index.html"
		  links.Value("FirewallPort") = "https://documentation.xojo.com/api/xojocloud/firewallport.html"
		  links.Value("XojoCloud namespace") = "https://documentation.xojo.com/api/xojocloud/xojocloud_namespace.html"
		  links.Value("XojoCloud.RemoteNotifications") = "https://documentation.xojo.com/api/xojocloud/xojocloud.remotenotifications.html"
		  links.Value("XojoCloud.RemoteNotifications.CallbackDelegate") = "https://documentation.xojo.com/api/xojocloud/xojocloud.remotenotifications.callbackdelegate.html"
		  links.Value("XojoCloud.RemoteNotifications.DeliveryOptions") = "https://documentation.xojo.com/api/xojocloud/xojocloud.remotenotifications.deliveryoptions.html"
		  links.Value("XojoCloud.RemoteNotifications.Message") = "https://documentation.xojo.com/api/xojocloud/xojocloud.remotenotifications.message.html"
		  
		  addSubMenu (25,6)
		  addXol (6)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub populateLinks3()
		  var a,b,c,d as MyCocoaMenuItemMBS
		  
		  // 27
		  
		  b=new MyCocoaMenuItemMBS
		  b.CreateSeparator
		  items.Append b
		  m.AddItem b
		  
		  // gettin started
		  
		  linksMisc.Value("Introduction") = "https://documentation.xojo.com/getting_started/introduction/index.html"
		  linksMisc.Value("QuickStarts") = "https://documentation.xojo.com/getting_started/quickstarts/index.html"
		  linksMisc.Value("Tutorials") = "https://documentation.xojo.com/getting_started/tutorials/index.html"
		  linksMisc.Value("Creating more apps") = "https://documentation.xojo.com/getting_started/creating_more_apps/index.html"
		  linksMisc.Value("Using the IDE") = "https://documentation.xojo.com/getting_started/using_the_ide/index.html"
		  linksMisc.Value("Using the Xojo Language") = "https://documentation.xojo.com/getting_started/using_the_xojo_language/index.html"
		  linksMisc.Value("Object-Oriented Programming") = "https://documentation.xojo.com/getting_started/object-oriented_programming/index.html"
		  linksMisc.Value("Example projects") = "https://documentation.xojo.com/getting_started/example_projects/index.html"
		  linksMisc.Value("Debugging") = "https://documentation.xojo.com/getting_started/debugging/index.html"
		  
		  addSubMenuMisc (28,9)
		  
		  
		  // topics 
		  
		  'linksMisc.Value("________  Advanced features") = "https://documentation.xojo.com/topics/advanced_features/index.html"
		  'linksMisc.Value("Creating weak references to objects") = "https://documentation.xojo.com/topics/advanced_features/creating_weak_references_to_objects.html"
		  'linksMisc.Value("Inspecting your application structure from code with Introspection") = "https://documentation.xojo.com/topics/advanced_features/inspecting_your_application_structure_from_code_with_introspection.html"
		  'linksMisc.Value("Looping through your data with For Each") = "https://documentation.xojo.com/topics/advanced_features/looping_through_your_data_with_for_each.html"
		  'linksMisc.Value("Managing raw data with the MemoryBlock class") = "https://documentation.xojo.com/topics/advanced_features/managing_raw_data_with_the_memoryblock_class.html"
		  'linksMisc.Value("Setting default values for Xojo framework class properties") = "https://documentation.xojo.com/topics/advanced_features/setting_default_values_for_xojo_framework_class_properties.html"
		  'linksMisc.Value("________  API design") = "https://documentation.xojo.com/topics/api_design/index.html"
		  'linksMisc.Value("API design and naming guidelines") = "https://documentation.xojo.com/topics/api_design/api_design_and_naming_guidelines.html"
		  'linksMisc.Value("Moving to API 2.0 ") = "https://documentation.xojo.com/topics/api_design/moving_to_api_2.0.html"
		  'linksMisc.Value("________  Application deployment") = "https://documentation.xojo.com/topics/application_deployment/index.html"
		  'linksMisc.Value("Apple requirements") = "https://documentation.xojo.com/topics/application_deployment/apple_requirements/index.html"
		  'linksMisc.Value("Desktop    ") = "https://documentation.xojo.com/topics/application_deployment/desktop/index.html"
		  'linksMisc.Value("Mobile  ") = "https://documentation.xojo.com/topics/application_deployment/mobile/index.html"
		  'linksMisc.Value("Web ") = "https://documentation.xojo.com/topics/application_deployment/web/index.html"
		  'linksMisc.Value("________  Application structure") = "https://documentation.xojo.com/topics/application_structure/index.html"
		  'linksMisc.Value("App icons") = "https://documentation.xojo.com/topics/application_structure/app_icons.html"
		  'linksMisc.Value("Coding guidelines for 64-Bit apps") = "https://documentation.xojo.com/topics/application_structure/coding_guidelines_for_64-bit_apps.html"
		  'linksMisc.Value("Console apps   ") = "https://documentation.xojo.com/topics/application_structure/console_apps.html"
		  'linksMisc.Value("Desktop ") = "https://documentation.xojo.com/topics/application_structure/desktop/index.html"
		  'linksMisc.Value("iOS ") = "https://documentation.xojo.com/topics/application_structure/ios/index.html"
		  'linksMisc.Value("Web    ") = "https://documentation.xojo.com/topics/application_structure/web/index.html"
		  'linksMisc.Value("________  Build automation") = "https://documentation.xojo.com/topics/build_automation/index.html"
		  'linksMisc.Value("IDE Communicator") = "https://documentation.xojo.com/topics/build_automation/ide_communicator.html"
		  'linksMisc.Value("IDE scripting") = "https://documentation.xojo.com/topics/build_automation/ide_scripting/index.html"
		  'linksMisc.Value("Introduction  ") = "https://documentation.xojo.com/topics/build_automation/introduction.html"
		  'linksMisc.Value("________  Code management") = "https://documentation.xojo.com/topics/code_management/index.html"
		  'linksMisc.Value("Coding guidelines") = "https://documentation.xojo.com/topics/code_management/coding_guidelines.html"
		  'linksMisc.Value("Custom code reformatting") = "https://documentation.xojo.com/topics/code_management/custom_code_reformatting.html"
		  'linksMisc.Value("Sharing code among multiple projects") = "https://documentation.xojo.com/topics/code_management/sharing_code_among_multiple_projects.html"
		  'linksMisc.Value("Using source control with Xojo projects") = "https://documentation.xojo.com/topics/code_management/using_source_control_with_xojo_projects.html"
		  'linksMisc.Value("________  Communication") = "https://documentation.xojo.com/topics/communication/index.html"
		  'linksMisc.Value("Hardware ") = "https://documentation.xojo.com/topics/communication/hardware/index.html"
		  'linksMisc.Value("Internet ") = "https://documentation.xojo.com/topics/communication/internet/index.html"
		  'linksMisc.Value("________  Custom controls") = "https://documentation.xojo.com/topics/custom_controls/index.html"
		  'linksMisc.Value("Changing properties with the Inspector") = "https://documentation.xojo.com/topics/custom_controls/changing_properties_with_the_inspector.html"
		  'linksMisc.Value("Creating a color selector control") = "https://documentation.xojo.com/topics/custom_controls/creating_a_color_selector_control.html"
		  'linksMisc.Value("Plugins SDK") = "https://documentation.xojo.com/topics/custom_controls/plugins_sdk.html"
		  'linksMisc.Value("Web Control SDK") = "https://documentation.xojo.com/topics/custom_controls/web_control_sdk.html"
		  'linksMisc.Value("Web custom controls") = "https://documentation.xojo.com/topics/custom_controls/web_custom_controls.html"
		  'linksMisc.Value("________  Data processing") = "https://documentation.xojo.com/topics/data_processing/index.html"
		  'linksMisc.Value("Faster processing using the Worker class") = "https://documentation.xojo.com/topics/data_processing/faster_processing_using_the_worker_class.html"
		  'linksMisc.Value("________  Databases") = "https://documentation.xojo.com/topics/databases/index.html"
		  'linksMisc.Value("Getting started accessing databases") = "https://documentation.xojo.com/topics/databases/getting_started_accessing_databases.html"
		  'linksMisc.Value("Database basics for beginners") = "https://documentation.xojo.com/topics/databases/database_basics_for_beginners.html"
		  'linksMisc.Value("Adding, updating and deleting rows") = "https://documentation.xojo.com/topics/databases/adding-_updating_and_deleting_rows.html"
		  'linksMisc.Value("Transactions") = "https://documentation.xojo.com/topics/databases/transactions.html"
		  'linksMisc.Value("Supported engines") = "https://documentation.xojo.com/topics/databases/supported_engines/index.html"
		  'linksMisc.Value("Protecting your database from attack") = "https://documentation.xojo.com/topics/databases/protecting_your_database_from_attack.html"
		  'linksMisc.Value("Considerations when using a database with a web application") = "https://documentation.xojo.com/topics/databases/considerations_when_using_a_database_with_a_web_application.html"
		  'linksMisc.Value("________  Debugging") = "https://documentation.xojo.com/topics/debugging/index.html"
		  'linksMisc.Value("How Xojo manages memory") = "https://documentation.xojo.com/topics/debugging/how_xojo_manages_memory.html"
		  'linksMisc.Value("Testing and debugging your iOS apps") = "https://documentation.xojo.com/topics/debugging/testing_and_debugging_your_ios_apps.html"
		  'linksMisc.Value("What to do when your app is consistently crashing") = "https://documentation.xojo.com/topics/debugging/what_to_do_when_your_app_is_consistently_crashing.html"
		  'linksMisc.Value("________  Declares") = "https://documentation.xojo.com/topics/declares/index.html"
		  'linksMisc.Value("Calling native iOS APIs") = "https://documentation.xojo.com/topics/declares/calling_native_ios_apis.html"
		  'linksMisc.Value("Calling native Linux APIs") = "https://documentation.xojo.com/topics/declares/calling_native_linux_apis.html"
		  'linksMisc.Value("Calling native macOS APIs") = "https://documentation.xojo.com/topics/declares/calling_native_macos_apis.html"
		  'linksMisc.Value("Calling native Windows APIs") = "https://documentation.xojo.com/topics/declares/calling_native_windows_apis.html"
		  'linksMisc.Value("Examples for iOS") = "https://documentation.xojo.com/topics/declares/examples_for_ios.html"
		  'linksMisc.Value("Examples for macOS") = "https://documentation.xojo.com/topics/declares/examples_for_macos.html"
		  'linksMisc.Value("Examples for Windows") = "https://documentation.xojo.com/topics/declares/examples_for_windows.html"
		  'linksMisc.Value("________  File management") = "https://documentation.xojo.com/topics/file_management/index.html"
		  'linksMisc.Value("Accessing files") = "https://documentation.xojo.com/topics/file_management/accessing_files.html"
		  'linksMisc.Value("Accessing binary files") = "https://documentation.xojo.com/topics/file_management/accessing_binary_files.html"
		  'linksMisc.Value("Accessing files in a web application") = "https://documentation.xojo.com/topics/file_management/accessing_files_in_a_web_application.html"
		  'linksMisc.Value("Accessing the file system via the FolderItem class") = "https://documentation.xojo.com/topics/file_management/accessing_the_file_system_via_the_folderitem_class.html"
		  'linksMisc.Value("Accessing text files") = "https://documentation.xojo.com/topics/file_management/accessing_text_files.html"
		  'linksMisc.Value("Reading and writing data in JSON format") = "https://documentation.xojo.com/topics/file_management/reading_and_writing_data_in_json_format.html"
		  'linksMisc.Value("Reading and writing data in XML format") = "https://documentation.xojo.com/topics/file_management/reading_and_writing_data_in_xml_format.html"
		  'linksMisc.Value("Understanding File Types") = "https://documentation.xojo.com/topics/file_management/understanding_file_types.html"
		  'linksMisc.Value("Understanding Uniform Type Identifiers") = "https://documentation.xojo.com/topics/file_management/understanding_uniform_type_identifiers.html"
		  'linksMisc.Value("________  Graphics") = "https://documentation.xojo.com/topics/graphics/index.html"
		  'linksMisc.Value("Getting started with graphics") = "https://documentation.xojo.com/topics/graphics/getting_started_with_graphics.html"
		  'linksMisc.Value("Working with color") = "https://documentation.xojo.com/topics/graphics/working_with_color.html"
		  'linksMisc.Value("Drawing with vector graphics") = "https://documentation.xojo.com/topics/graphics/drawing_with_vector_graphics.html"
		  'linksMisc.Value("HiDPI support") = "https://documentation.xojo.com/topics/graphics/hidpi_support.html"
		  'linksMisc.Value("HiDPI support for web apps") = "https://documentation.xojo.com/topics/graphics/hidpi_support_for_web_apps.html"
		  'linksMisc.Value("Supporting Dark Mode and more with Color Groups") = "https://documentation.xojo.com/topics/graphics/supporting_dark_mode_and_more_with_color_groups.html"
		  'linksMisc.Value("Updating code that used the Graphics property") = "https://documentation.xojo.com/topics/graphics/updating_code_that_used_the_graphics_property.html"
		  'linksMisc.Value("________  iOS") = "https://documentation.xojo.com/topics/ios/index.html"
		  'linksMisc.Value("Getting the user's location from their mobile device") = "https://documentation.xojo.com/topics/ios/getting_the_user&#39"
		  'linksMisc.Value("How to apply a blur effect on iOS") = "https://documentation.xojo.com/topics/ios/how_to_apply_a_blur_effect_on_ios.html"
		  'linksMisc.Value("Sending and receiving mobile notifications") = "https://documentation.xojo.com/topics/ios/sending_and_receiving_mobile_notifications.html"
		  'linksMisc.Value("________  Linux") = "https://documentation.xojo.com/topics/linux/index.html"
		  'linksMisc.Value("Running apps on Linux") = "https://documentation.xojo.com/topics/linux/running_apps_on_linux.html"
		  'linksMisc.Value("________  Localizing your apps") = "https://documentation.xojo.com/topics/localizing_your_apps/index.html"
		  'linksMisc.Value("Introduction to app localization") = "https://documentation.xojo.com/topics/localizing_your_apps/introduction_to_app_localization.html"
		  'linksMisc.Value("Using the Lingua App to localize your app") = "https://documentation.xojo.com/topics/localizing_your_apps/using_the_lingua_app_to_localize_your_app.html"
		  'linksMisc.Value("________  macOS") = "https://documentation.xojo.com/topics/macos/index.html"
		  'linksMisc.Value("Accessing the Keychain") = "https://documentation.xojo.com/topics/macos/accessing_the_keychain.html"
		  'linksMisc.Value("Advanced Apple Events") = "https://documentation.xojo.com/topics/macos/advanced_apple_events.html"
		  'linksMisc.Value("Using AppleScripts in your app") = "https://documentation.xojo.com/topics/macos/using_applescripts_in_your_app.html"
		  'linksMisc.Value("________  Migrating from other development tools") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/index.html"
		  'linksMisc.Value("Migrating from FileMaker") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/migrating_from_filemaker.html"
		  'linksMisc.Value("Migrating from Microsoft Access") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/migrating_from_microsoft_access.html"
		  'linksMisc.Value("Migrating from PowerBASIC") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/migrating_from_powerbasic.html"
		  'linksMisc.Value("Migrating from Visual Basic") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/migrating_from_visual_basic.html"
		  'linksMisc.Value("Migrating from Visual FoxPro") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/migrating_from_visual_foxpro.html"
		  'linksMisc.Value("________  Office Automation") = "https://documentation.xojo.com/topics/office_automation/index.html"
		  'linksMisc.Value("Controlling Microsoft Office from your app") = "https://documentation.xojo.com/topics/office_automation/controlling_microsoft_office_from_your_app.html"
		  'linksMisc.Value("Reserved words when using Microsoft Office Automation") = "https://documentation.xojo.com/topics/office_automation/reserved_words_when_using_microsoft_office_automation.html"
		  'linksMisc.Value("________  OS information") = "https://documentation.xojo.com/topics/os_information/index.html"
		  'linksMisc.Value("Conditional compilation") = "https://documentation.xojo.com/topics/os_information/conditional_compilation.html"
		  'linksMisc.Value("Handle different operating systems") = "https://documentation.xojo.com/topics/os_information/handle_different_operating_systems.html"
		  'linksMisc.Value("________  Printing") = "https://documentation.xojo.com/topics/printing/index.html"
		  'linksMisc.Value("Creating PDF forms") = "https://documentation.xojo.com/topics/printing/creating_pdf_forms.html"
		  'linksMisc.Value("Sending data to the printer") = "https://documentation.xojo.com/topics/printing/sending_data_to_the_printer.html"
		  'linksMisc.Value("The Report Editor") = "https://documentation.xojo.com/topics/printing/the_report_editor/index.html"
		  'linksMisc.Value("Displaying Reports") = "https://documentation.xojo.com/topics/printing/the_report_editor/displaying_reports.html"
		  'linksMisc.Value("Report Editor Controls") = "https://documentation.xojo.com/topics/printing/the_report_editor/report_editor_controls.html"
		  'linksMisc.Value("________  Raspberry Pi") = "https://documentation.xojo.com/topics/raspberry_pi/index.html"
		  'linksMisc.Value("Making a LED light blink part I") = "https://documentation.xojo.com/topics/raspberry_pi/_making_a_led_light_blink_part_i.html"
		  'linksMisc.Value("Making a LED light blink part II") = "https://documentation.xojo.com/topics/raspberry_pi/_making_a_led_light_blink_part_ii.html"
		  'linksMisc.Value("Working with a LCD character display") = "https://documentation.xojo.com/topics/raspberry_pi/working_with_a_lcd_character_display.html"
		  'linksMisc.Value("Controlling a servo") = "https://documentation.xojo.com/topics/raspberry_pi/controlling_a_servo.html"
		  'linksMisc.Value("GPIO") = "https://documentation.xojo.com/topics/raspberry_pi/gpio.html"
		  'linksMisc.Value("RGB LED") = "https://documentation.xojo.com/topics/raspberry_pi/remote_debugging.html"
		  'linksMisc.Value("Remote debugging ") = "https://documentation.xojo.com/topics/raspberry_pi/rgb_led.html"
		  'linksMisc.Value("Tips") = "https://documentation.xojo.com/topics/raspberry_pi/tips.html"
		  'linksMisc.Value("Using a buzzer") = "https://documentation.xojo.com/topics/raspberry_pi/using_a_buzzer.html"
		  'linksMisc.Value("________  Text handling") = "https://documentation.xojo.com/topics/text_handling/index.html"
		  'linksMisc.Value("Accessing the clipboard") = "https://documentation.xojo.com/topics/text_handling/accessing_the_clipboard.html"
		  'linksMisc.Value("Accessing the selected text") = "https://documentation.xojo.com/topics/text_handling/accessing_the_selected_text.html"
		  'linksMisc.Value("Comparing text values") = "https://documentation.xojo.com/topics/text_handling/comparing_text_values.html"
		  'linksMisc.Value("Creating styled text") = "https://documentation.xojo.com/topics/text_handling/creating_styled_text.html"
		  'linksMisc.Value("Encrypting and decrypting data") = "https://documentation.xojo.com/topics/text_handling/encrypting_and_decrypting_data.html"
		  'linksMisc.Value("Formatting values") = "https://documentation.xojo.com/topics/text_handling/formatting_values.html"
		  'linksMisc.Value("Right-to-left text support") = "https://documentation.xojo.com/topics/text_handling/right-to-left_text_support.html"
		  'linksMisc.Value("Searching text using the SoundEx algorithm") = "https://documentation.xojo.com/topics/text_handling/searching_text_using_the_soundex_algorithm.html"
		  'linksMisc.Value("Understanding text encodings") = "https://documentation.xojo.com/topics/text_handling/understanding_text_encodings.html"
		  'linksMisc.Value("Using Regular Expressions") = "https://documentation.xojo.com/topics/text_handling/using_regular_expressions.html"
		  'linksMisc.Value("Working with fonts") = "https://documentation.xojo.com/topics/text_handling/working_with_fonts.html"
		  'linksMisc.Value("________  Threading") = "https://documentation.xojo.com/topics/threading/index.html"
		  'linksMisc.Value("Creating helper apps") = "https://documentation.xojo.com/topics/threading/creating_helper_apps.html"
		  'linksMisc.Value("Running code in a thread") = "https://documentation.xojo.com/topics/threading/running_code_in_a_thread.html"
		  'linksMisc.Value("Running code periodically with a Timer") = "https://documentation.xojo.com/topics/threading/running_code_periodically_with_a_timer.html"
		  'linksMisc.Value("________  User interface") = "https://documentation.xojo.com/topics/user_interface/index.html"
		  'linksMisc.Value("Creating your own controls") = "https://documentation.xojo.com/topics/user_interface/creating_your_own_controls.html"
		  'linksMisc.Value("Design tips") = "https://documentation.xojo.com/topics/user_interface/design_tips.html"
		  'linksMisc.Value("Desktop      ") = "https://documentation.xojo.com/topics/user_interface/desktop/index.html"
		  'linksMisc.Value("Dynamically adding and removing controls") = "https://documentation.xojo.com/topics/user_interface/dynamically_adding_and_removing_controls.html"
		  'linksMisc.Value("iOS      ") = "https://documentation.xojo.com/topics/user_interface/ios/index.html"
		  'linksMisc.Value("Playing movies and sound") = "https://documentation.xojo.com/topics/user_interface/playing_movies_and_sound.html"
		  'linksMisc.Value("Web      ") = "https://documentation.xojo.com/topics/user_interface/web/index.html"
		  'linksMisc.Value("Windows UI guidelines") = "https://documentation.xojo.com/topics/user_interface/windows_ui_guidelines.html"
		  'linksMisc.Value("________  Web") = "https://documentation.xojo.com/topics/web/index.html"
		  'linksMisc.Value("HTTP communication") = "https://documentation.xojo.com/topics/web/http_communication.html"
		  'linksMisc.Value("Porting desktop apps to web apps") = "https://documentation.xojo.com/topics/web/porting_desktop_apps_to_web_apps.html"
		  'linksMisc.Value("Pushing data to the browser") = "https://documentation.xojo.com/topics/web/pushing_data_to_the_browser.html"
		  'linksMisc.Value("Secure web login screens") = "https://documentation.xojo.com/topics/web/reconnecting_to_a_dropped_web_session.html"
		  'linksMisc.Value("SSL for web apps") = "https://documentation.xojo.com/topics/web/run_web_apps_in_the_background.html"
		  'linksMisc.Value("Reconnecting to a dropped web session") = "https://documentation.xojo.com/topics/web/secure_web_login_screens.html"
		  'linksMisc.Value("Run web apps in the background") = "https://documentation.xojo.com/topics/web/ssl_for_web_apps.html"
		  'linksMisc.Value("Web app optimization") = "https://documentation.xojo.com/topics/web/web_app_optimization.html"
		  'linksMisc.Value("Web app security") = "https://documentation.xojo.com/topics/web/web_app_security.html"
		  'linksMisc.Value("________  Windows") = "https://documentation.xojo.com/topics/windows/index.html"
		  'linksMisc.Value("ActiveX, COM and OLE") = "https://documentation.xojo.com/topics/windows/activex-_com_and_ole.html"
		  'linksMisc.Value("Creating an installer with the Inno setup script (32-bit apps)") = "https://documentation.xojo.com/topics/windows/creating_an_installer_with_the_inno_setup_script_(32-bit_apps).html"
		  'linksMisc.Value("Creating an installer with the Inno setup script (64-bit apps)") = "https://documentation.xojo.com/topics/windows/creating_an_installer_with_the_inno_setup_script_(64-bit_apps).html"
		  'linksMisc.Value("Dealing with Windows security") = "https://documentation.xojo.com/topics/windows/dealing_with_windows_security.html"
		  'linksMisc.Value("Information about the Windows Universal Runtime") = "https://documentation.xojo.com/topics/windows/information_about_the_windows_universal_runtime.html"
		  'linksMisc.Value("________  Xojo Cloud") = "https://documentation.xojo.com/topics/xojo_cloud/index.html"
		  'linksMisc.Value("Introduction to Xojo Cloud") = "https://documentation.xojo.com/topics/xojo_cloud/introduction_to_xojo_cloud.html"
		  'linksMisc.Value("The Xojo Cloud control panel") = "https://documentation.xojo.com/topics/xojo_cloud/the_xojo_cloud_control_panel.html"
		  'linksMisc.Value("Xojo Cloud details") = "https://documentation.xojo.com/topics/xojo_cloud/xojo_cloud_details.html"
		  'linksMisc.Value("Xojo Cloud troubleshooting") = "https://documentation.xojo.com/topics/xojo_cloud/xojo_cloud_troubleshooting.html"
		  'linksMisc.Value("________  XojoScript") = "https://documentation.xojo.com/topics/xojoscript/index.html"
		  'linksMisc.Value("Introduction To XojoScript") = "https://documentation.xojo.com/topics/xojoscript/introduction_to_xojoscript.html"
		  'linksMisc.Value("The XojoScript language") = "https://documentation.xojo.com/topics/xojoscript/the_xojoscript_language.html"
		  'linksMisc.Value("XojoScript functions") = "https://documentation.xojo.com/topics/xojoscript/xojoscript_functions.html"
		  
		  'addSubMenuMisc (29,170)
		  
		  linksMisc.Value("Advanced features") = "https://documentation.xojo.com/topics/advanced_features/index.html"
		  linksMisc.Value("API design") = "https://documentation.xojo.com/topics/api_design/index.html"
		  linksMisc.Value("Application deployment") = "https://documentation.xojo.com/topics/application_deployment/index.html"
		  linksMisc.Value("Application structure") = "https://documentation.xojo.com/topics/application_structure/index.html"
		  linksMisc.Value("Build automation") = "https://documentation.xojo.com/topics/build_automation/index.html"
		  linksMisc.Value("Code management") = "https://documentation.xojo.com/topics/code_management/index.html"
		  linksMisc.Value("Communication") = "https://documentation.xojo.com/topics/communication/index.html"
		  linksMisc.Value("Custom controls") = "https://documentation.xojo.com/topics/custom_controls/index.html"
		  linksMisc.Value("Data processing") = "https://documentation.xojo.com/topics/data_processing/index.html"
		  linksMisc.Value("Databases") = "https://documentation.xojo.com/topics/databases/index.html"
		  linksMisc.Value("Debugging  ") = "https://documentation.xojo.com/topics/debugging/index.html"
		  linksMisc.Value("Declares") = "https://documentation.xojo.com/topics/declares/index.html"
		  linksMisc.Value("File management") = "https://documentation.xojo.com/topics/file_management/index.html"
		  linksMisc.Value("Graphics   ") = "https://documentation.xojo.com/topics/graphics/index.html"
		  linksMisc.Value("iOS    ") = "https://documentation.xojo.com/topics/ios/index.html"
		  linksMisc.Value("Linux   ") = "https://documentation.xojo.com/topics/linux/index.html"
		  linksMisc.Value("Localizing your apps") = "https://documentation.xojo.com/topics/localizing_your_apps/index.html"
		  linksMisc.Value("macOS       ") = "https://documentation.xojo.com/topics/macos/index.html"
		  linksMisc.Value("Migrating from other development tools") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/index.html"
		  linksMisc.Value("Office Automation") = "https://documentation.xojo.com/topics/office_automation/index.html"
		  linksMisc.Value("OS information") = "https://documentation.xojo.com/topics/os_information/index.html"
		  linksMisc.Value("Printing  ") = "https://documentation.xojo.com/topics/printing/index.html"
		  linksMisc.Value("Raspberry Pi") = "https://documentation.xojo.com/topics/raspberry_pi/index.html"
		  linksMisc.Value("Text handling") = "https://documentation.xojo.com/topics/text_handling/index.html"
		  linksMisc.Value("Threading") = "https://documentation.xojo.com/topics/threading/index.html"
		  linksMisc.Value("User interface") = "https://documentation.xojo.com/topics/user_interface/index.html"
		  linksMisc.Value("Web   ") = "https://documentation.xojo.com/topics/web/index.html"
		  linksMisc.Value("Windows   ") = "https://documentation.xojo.com/topics/windows/index.html"
		  linksMisc.Value("Xojo Cloud") = "https://documentation.xojo.com/topics/xojo_cloud/index.html"
		  linksMisc.Value("XojoScript") = "https://documentation.xojo.com/topics/xojoscript/index.html"
		  
		  addSubMenuMisc (29,30)
		  
		  
		  // § Advanced features
		  linksMisc.Value("Creating weak references to objects") = "https://documentation.xojo.com/topics/advanced_features/creating_weak_references_to_objects.html"
		  linksMisc.Value("Inspecting your application structure from code with Introspection") = "https://documentation.xojo.com/topics/advanced_features/inspecting_your_application_structure_from_code_with_introspection.html"
		  linksMisc.Value("Looping through your data with For Each") = "https://documentation.xojo.com/topics/advanced_features/looping_through_your_data_with_for_each.html"
		  linksMisc.Value("Managing raw data with the MemoryBlock class") = "https://documentation.xojo.com/topics/advanced_features/managing_raw_data_with_the_memoryblock_class.html"
		  linksMisc.Value("Setting default values for Xojo framework class properties") = "https://documentation.xojo.com/topics/advanced_features/setting_default_values_for_xojo_framework_class_properties.html"
		  
		  
		  // § API design
		  linksMisc.Value("API design and naming guidelines") = "https://documentation.xojo.com/topics/api_design/api_design_and_naming_guidelines.html"
		  linksMisc.Value("Moving to API 2.0 ") = "https://documentation.xojo.com/topics/api_design/moving_to_api_2.0.html"
		  
		  // § Application deployment
		  linksMisc.Value("Apple requirements") = "https://documentation.xojo.com/topics/application_deployment/apple_requirements/index.html"
		  linksMisc.Value("Desktop    ") = "https://documentation.xojo.com/topics/application_deployment/desktop/index.html"
		  linksMisc.Value("Mobile  ") = "https://documentation.xojo.com/topics/application_deployment/mobile/index.html"
		  linksMisc.Value("Web ") = "https://documentation.xojo.com/topics/application_deployment/web/index.html"
		  
		  // § Application structure
		  linksMisc.Value("App icons") = "https://documentation.xojo.com/topics/application_structure/app_icons.html"
		  linksMisc.Value("Coding guidelines for 64-Bit apps") = "https://documentation.xojo.com/topics/application_structure/coding_guidelines_for_64-bit_apps.html"
		  linksMisc.Value("Console apps   ") = "https://documentation.xojo.com/topics/application_structure/console_apps.html"
		  linksMisc.Value("Desktop ") = "https://documentation.xojo.com/topics/application_structure/desktop/index.html"
		  linksMisc.Value("iOS ") = "https://documentation.xojo.com/topics/application_structure/ios/index.html"
		  linksMisc.Value("Web    ") = "https://documentation.xojo.com/topics/application_structure/web/index.html"
		  
		  // § Build automation
		  linksMisc.Value("IDE Communicator") = "https://documentation.xojo.com/topics/build_automation/ide_communicator.html"
		  linksMisc.Value("IDE scripting") = "https://documentation.xojo.com/topics/build_automation/ide_scripting/index.html"
		  linksMisc.Value("Introduction  ") = "https://documentation.xojo.com/topics/build_automation/introduction.html"
		  
		  //§ Code management
		  linksMisc.Value("Coding guidelines") = "https://documentation.xojo.com/topics/code_management/coding_guidelines.html"
		  linksMisc.Value("Custom code reformatting") = "https://documentation.xojo.com/topics/code_management/custom_code_reformatting.html"
		  linksMisc.Value("Sharing code among multiple projects") = "https://documentation.xojo.com/topics/code_management/sharing_code_among_multiple_projects.html"
		  linksMisc.Value("Using source control with Xojo projects") = "https://documentation.xojo.com/topics/code_management/using_source_control_with_xojo_projects.html"
		  
		  
		  //§ Communication
		  linksMisc.Value("Hardware ") = "https://documentation.xojo.com/topics/communication/hardware/index.html"
		  linksMisc.Value("Internet ") = "https://documentation.xojo.com/topics/communication/internet/index.html"
		  
		  //custom_controls
		  linksMisc.Value("Changing properties with the Inspector") = "https://documentation.xojo.com/topics/custom_controls/changing_properties_with_the_inspector.html"
		  linksMisc.Value("Creating a color selector control") = "https://documentation.xojo.com/topics/custom_controls/creating_a_color_selector_control.html"
		  linksMisc.Value("Plugins SDK") = "https://documentation.xojo.com/topics/custom_controls/plugins_sdk.html"
		  linksMisc.Value("Web Control SDK") = "https://documentation.xojo.com/topics/custom_controls/web_control_sdk.html"
		  linksMisc.Value("Web custom controls") = "https://documentation.xojo.com/topics/custom_controls/web_custom_controls.html"
		  
		  //data_processing
		  linksMisc.Value("Faster processing using the Worker class") = "https://documentation.xojo.com/topics/data_processing/faster_processing_using_the_worker_class.html"
		  
		  //databases
		  linksMisc.Value("Getting started accessing databases") = "https://documentation.xojo.com/topics/databases/getting_started_accessing_databases.html"
		  linksMisc.Value("Database basics for beginners") = "https://documentation.xojo.com/topics/databases/database_basics_for_beginners.html"
		  linksMisc.Value("Adding, updating and deleting rows") = "https://documentation.xojo.com/topics/databases/adding-_updating_and_deleting_rows.html"
		  linksMisc.Value("Transactions") = "https://documentation.xojo.com/topics/databases/transactions.html"
		  linksMisc.Value("Supported engines") = "https://documentation.xojo.com/topics/databases/supported_engines/index.html"
		  linksMisc.Value("Protecting your database from attack") = "https://documentation.xojo.com/topics/databases/protecting_your_database_from_attack.html"
		  linksMisc.Value("Considerations when using a database with a web application") = "https://documentation.xojo.com/topics/databases/considerations_when_using_a_database_with_a_web_application.html"
		  
		  //debugging
		  linksMisc.Value("How Xojo manages memory") = "https://documentation.xojo.com/topics/debugging/how_xojo_manages_memory.html"
		  linksMisc.Value("Testing and debugging your iOS apps") = "https://documentation.xojo.com/topics/debugging/testing_and_debugging_your_ios_apps.html"
		  linksMisc.Value("What to do when your app is consistently crashing") = "https://documentation.xojo.com/topics/debugging/what_to_do_when_your_app_is_consistently_crashing.html"
		  
		  //declares
		  linksMisc.Value("Calling native iOS APIs") = "https://documentation.xojo.com/topics/declares/calling_native_ios_apis.html"
		  linksMisc.Value("Calling native Linux APIs") = "https://documentation.xojo.com/topics/declares/calling_native_linux_apis.html"
		  linksMisc.Value("Calling native macOS APIs") = "https://documentation.xojo.com/topics/declares/calling_native_macos_apis.html"
		  linksMisc.Value("Calling native Windows APIs") = "https://documentation.xojo.com/topics/declares/calling_native_windows_apis.html"
		  linksMisc.Value("Examples for iOS") = "https://documentation.xojo.com/topics/declares/examples_for_ios.html"
		  linksMisc.Value("Examples for macOS") = "https://documentation.xojo.com/topics/declares/examples_for_macos.html"
		  linksMisc.Value("Examples for Windows") = "https://documentation.xojo.com/topics/declares/examples_for_windows.html"
		  
		  //file_management
		  linksMisc.Value("Accessing files") = "https://documentation.xojo.com/topics/file_management/accessing_files.html"
		  linksMisc.Value("Accessing binary files") = "https://documentation.xojo.com/topics/file_management/accessing_binary_files.html"
		  linksMisc.Value("Accessing files in a web application") = "https://documentation.xojo.com/topics/file_management/accessing_files_in_a_web_application.html"
		  linksMisc.Value("Accessing the file system via the FolderItem class") = "https://documentation.xojo.com/topics/file_management/accessing_the_file_system_via_the_folderitem_class.html"
		  linksMisc.Value("Accessing text files") = "https://documentation.xojo.com/topics/file_management/accessing_text_files.html"
		  linksMisc.Value("Reading and writing data in JSON format") = "https://documentation.xojo.com/topics/file_management/reading_and_writing_data_in_json_format.html"
		  linksMisc.Value("Reading and writing data in XML format") = "https://documentation.xojo.com/topics/file_management/reading_and_writing_data_in_xml_format.html"
		  linksMisc.Value("Understanding File Types") = "https://documentation.xojo.com/topics/file_management/understanding_file_types.html"
		  linksMisc.Value("Understanding Uniform Type Identifiers") = "https://documentation.xojo.com/topics/file_management/understanding_uniform_type_identifiers.html"
		  
		  //graphics
		  linksMisc.Value("Getting started with graphics") = "https://documentation.xojo.com/topics/graphics/getting_started_with_graphics.html"
		  linksMisc.Value("Working with color") = "https://documentation.xojo.com/topics/graphics/working_with_color.html"
		  linksMisc.Value("Drawing with vector graphics") = "https://documentation.xojo.com/topics/graphics/drawing_with_vector_graphics.html"
		  linksMisc.Value("HiDPI support") = "https://documentation.xojo.com/topics/graphics/hidpi_support.html"
		  linksMisc.Value("HiDPI support for web apps") = "https://documentation.xojo.com/topics/graphics/hidpi_support_for_web_apps.html"
		  linksMisc.Value("Supporting Dark Mode and more with Color Groups") = "https://documentation.xojo.com/topics/graphics/supporting_dark_mode_and_more_with_color_groups.html"
		  linksMisc.Value("Updating code that used the Graphics property") = "https://documentation.xojo.com/topics/graphics/updating_code_that_used_the_graphics_property.html"
		  
		  //ios
		  linksMisc.Value("Getting the user's location from their mobile device") = "https://documentation.xojo.com/topics/ios/getting_the_user&#39"
		  linksMisc.Value("How to apply a blur effect on iOS") = "https://documentation.xojo.com/topics/ios/how_to_apply_a_blur_effect_on_ios.html"
		  linksMisc.Value("Sending and receiving mobile notifications") = "https://documentation.xojo.com/topics/ios/sending_and_receiving_mobile_notifications.html"
		  
		  //linux
		  linksMisc.Value("Running apps on Linux") = "https://documentation.xojo.com/topics/linux/running_apps_on_linux.html"
		  
		  //localizing_your_apps
		  linksMisc.Value("Introduction to app localization") = "https://documentation.xojo.com/topics/localizing_your_apps/introduction_to_app_localization.html"
		  linksMisc.Value("Using the Lingua App to localize your app") = "https://documentation.xojo.com/topics/localizing_your_apps/using_the_lingua_app_to_localize_your_app.html"
		  
		  //macos
		  linksMisc.Value("Accessing the Keychain") = "https://documentation.xojo.com/topics/macos/accessing_the_keychain.html"
		  linksMisc.Value("Advanced Apple Events") = "https://documentation.xojo.com/topics/macos/advanced_apple_events.html"
		  linksMisc.Value("Using AppleScripts in your app") = "https://documentation.xojo.com/topics/macos/using_applescripts_in_your_app.html"
		  
		  //migrating_from_other_development_tools
		  linksMisc.Value("Migrating from FileMaker") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/migrating_from_filemaker.html"
		  linksMisc.Value("Migrating from Microsoft Access") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/migrating_from_microsoft_access.html"
		  linksMisc.Value("Migrating from PowerBASIC") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/migrating_from_powerbasic.html"
		  linksMisc.Value("Migrating from Visual Basic") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/migrating_from_visual_basic.html"
		  linksMisc.Value("Migrating from Visual FoxPro") = "https://documentation.xojo.com/topics/migrating_from_other_development_tools/migrating_from_visual_foxpro.html"
		  
		  //office_automation
		  linksMisc.Value("Controlling Microsoft Office from your app") = "https://documentation.xojo.com/topics/office_automation/controlling_microsoft_office_from_your_app.html"
		  linksMisc.Value("Reserved words when using Microsoft Office Automation") = "https://documentation.xojo.com/topics/office_automation/reserved_words_when_using_microsoft_office_automation.html"
		  
		  //os_information
		  linksMisc.Value("Conditional compilation") = "https://documentation.xojo.com/topics/os_information/conditional_compilation.html"
		  linksMisc.Value("Handle different operating systems") = "https://documentation.xojo.com/topics/os_information/handle_different_operating_systems.html"
		  
		  //printing
		  linksMisc.Value("Creating PDF forms") = "https://documentation.xojo.com/topics/printing/creating_pdf_forms.html"
		  linksMisc.Value("Sending data to the printer") = "https://documentation.xojo.com/topics/printing/sending_data_to_the_printer.html"
		  linksMisc.Value("The Report Editor") = "https://documentation.xojo.com/topics/printing/the_report_editor/index.html"
		  linksMisc.Value("Displaying Reports") = "https://documentation.xojo.com/topics/printing/the_report_editor/displaying_reports.html"
		  linksMisc.Value("Report Editor Controls") = "https://documentation.xojo.com/topics/printing/the_report_editor/report_editor_controls.html"
		  
		  //raspberry_pi
		  linksMisc.Value("Making a LED light blink part I") = "https://documentation.xojo.com/topics/raspberry_pi/_making_a_led_light_blink_part_i.html"
		  linksMisc.Value("Making a LED light blink part II") = "https://documentation.xojo.com/topics/raspberry_pi/_making_a_led_light_blink_part_ii.html"
		  linksMisc.Value("Working with a LCD character display") = "https://documentation.xojo.com/topics/raspberry_pi/working_with_a_lcd_character_display.html"
		  linksMisc.Value("Controlling a servo") = "https://documentation.xojo.com/topics/raspberry_pi/controlling_a_servo.html"
		  linksMisc.Value("GPIO") = "https://documentation.xojo.com/topics/raspberry_pi/gpio.html"
		  linksMisc.Value("RGB LED") = "https://documentation.xojo.com/topics/raspberry_pi/remote_debugging.html"
		  linksMisc.Value("Remote debugging ") = "https://documentation.xojo.com/topics/raspberry_pi/rgb_led.html"
		  linksMisc.Value("Tips") = "https://documentation.xojo.com/topics/raspberry_pi/tips.html"
		  linksMisc.Value("Using a buzzer") = "https://documentation.xojo.com/topics/raspberry_pi/using_a_buzzer.html"
		  
		  
		  //text_handling
		  linksMisc.Value("Accessing the clipboard") = "https://documentation.xojo.com/topics/text_handling/accessing_the_clipboard.html"
		  linksMisc.Value("Accessing the selected text") = "https://documentation.xojo.com/topics/text_handling/accessing_the_selected_text.html"
		  linksMisc.Value("Comparing text values") = "https://documentation.xojo.com/topics/text_handling/comparing_text_values.html"
		  linksMisc.Value("Creating styled text") = "https://documentation.xojo.com/topics/text_handling/creating_styled_text.html"
		  linksMisc.Value("Encrypting and decrypting data") = "https://documentation.xojo.com/topics/text_handling/encrypting_and_decrypting_data.html"
		  linksMisc.Value("Formatting values") = "https://documentation.xojo.com/topics/text_handling/formatting_values.html"
		  linksMisc.Value("Right-to-left text support") = "https://documentation.xojo.com/topics/text_handling/right-to-left_text_support.html"
		  linksMisc.Value("Searching text using the SoundEx algorithm") = "https://documentation.xojo.com/topics/text_handling/searching_text_using_the_soundex_algorithm.html"
		  linksMisc.Value("Understanding text encodings") = "https://documentation.xojo.com/topics/text_handling/understanding_text_encodings.html"
		  linksMisc.Value("Using Regular Expressions") = "https://documentation.xojo.com/topics/text_handling/using_regular_expressions.html"
		  linksMisc.Value("Working with fonts") = "https://documentation.xojo.com/topics/text_handling/working_with_fonts.html"
		  
		  //threading
		  linksMisc.Value("Creating helper apps") = "https://documentation.xojo.com/topics/threading/creating_helper_apps.html"
		  linksMisc.Value("Running code in a thread") = "https://documentation.xojo.com/topics/threading/running_code_in_a_thread.html"
		  linksMisc.Value("Running code periodically with a Timer") = "https://documentation.xojo.com/topics/threading/running_code_periodically_with_a_timer.html"
		  
		  //user_interface
		  linksMisc.Value("Creating your own controls") = "https://documentation.xojo.com/topics/user_interface/creating_your_own_controls.html"
		  linksMisc.Value("Design tips") = "https://documentation.xojo.com/topics/user_interface/design_tips.html"
		  linksMisc.Value("Desktop      ") = "https://documentation.xojo.com/topics/user_interface/desktop/index.html"
		  linksMisc.Value("Dynamically adding and removing controls") = "https://documentation.xojo.com/topics/user_interface/dynamically_adding_and_removing_controls.html"
		  linksMisc.Value("iOS      ") = "https://documentation.xojo.com/topics/user_interface/ios/index.html"
		  linksMisc.Value("Playing movies and sound") = "https://documentation.xojo.com/topics/user_interface/playing_movies_and_sound.html"
		  linksMisc.Value("Web      ") = "https://documentation.xojo.com/topics/user_interface/web/index.html"
		  linksMisc.Value("Windows UI guidelines") = "https://documentation.xojo.com/topics/user_interface/windows_ui_guidelines.html"
		  
		  //web
		  linksMisc.Value("HTTP communication") = "https://documentation.xojo.com/topics/web/http_communication.html"
		  linksMisc.Value("Porting desktop apps to web apps") = "https://documentation.xojo.com/topics/web/porting_desktop_apps_to_web_apps.html"
		  linksMisc.Value("Pushing data to the browser") = "https://documentation.xojo.com/topics/web/pushing_data_to_the_browser.html"
		  linksMisc.Value("Secure web login screens") = "https://documentation.xojo.com/topics/web/reconnecting_to_a_dropped_web_session.html"
		  linksMisc.Value("SSL for web apps") = "https://documentation.xojo.com/topics/web/run_web_apps_in_the_background.html"
		  linksMisc.Value("Reconnecting to a dropped web session") = "https://documentation.xojo.com/topics/web/secure_web_login_screens.html"
		  linksMisc.Value("Run web apps in the background") = "https://documentation.xojo.com/topics/web/ssl_for_web_apps.html"
		  linksMisc.Value("Web app optimization") = "https://documentation.xojo.com/topics/web/web_app_optimization.html"
		  linksMisc.Value("Web app security") = "https://documentation.xojo.com/topics/web/web_app_security.html"
		  
		  //§ Windows
		  linksMisc.Value("ActiveX, COM and OLE") = "https://documentation.xojo.com/topics/windows/activex-_com_and_ole.html"
		  linksMisc.Value("Creating an installer with the Inno setup script (32-bit apps)") = "https://documentation.xojo.com/topics/windows/creating_an_installer_with_the_inno_setup_script_(32-bit_apps).html"
		  linksMisc.Value("Creating an installer with the Inno setup script (64-bit apps)") = "https://documentation.xojo.com/topics/windows/creating_an_installer_with_the_inno_setup_script_(64-bit_apps).html"
		  linksMisc.Value("Dealing with Windows security") = "https://documentation.xojo.com/topics/windows/dealing_with_windows_security.html"
		  linksMisc.Value("Information about the Windows Universal Runtime") = "https://documentation.xojo.com/topics/windows/information_about_the_windows_universal_runtime.html"
		  
		  //xojo_cloud
		  linksMisc.Value("Introduction to Xojo Cloud") = "https://documentation.xojo.com/topics/xojo_cloud/introduction_to_xojo_cloud.html"
		  linksMisc.Value("The Xojo Cloud control panel") = "https://documentation.xojo.com/topics/xojo_cloud/the_xojo_cloud_control_panel.html"
		  linksMisc.Value("Xojo Cloud details") = "https://documentation.xojo.com/topics/xojo_cloud/xojo_cloud_details.html"
		  linksMisc.Value("Xojo Cloud troubleshooting") = "https://documentation.xojo.com/topics/xojo_cloud/xojo_cloud_troubleshooting.html"
		  
		  //xojoscript
		  linksMisc.Value("Introduction To XojoScript") = "https://documentation.xojo.com/topics/xojoscript/introduction_to_xojoscript.html"
		  linksMisc.Value("The XojoScript language") = "https://documentation.xojo.com/topics/xojoscript/the_xojoscript_language.html"
		  linksMisc.Value("XojoScript functions") = "https://documentation.xojo.com/topics/xojoscript/xojoscript_functions.html"
		  
		  
		  
		  
		  
		  // Resources
		  
		  linksMisc.Value("API 2 guidelines") = "https://documentation.xojo.com/resources/api_2_guidelines.html"
		  linksMisc.Value("Deprecations") = "https://documentation.xojo.com/resources/deprecations.html"
		  linksMisc.Value("iOS API 2.0 changes") = "https://documentation.xojo.com/resources/ios_api_2.0_changes.html"
		  linksMisc.Value("Learn object-oriented programming") = "https://documentation.xojo.com/resources/learn_object-oriented_programming.html"
		  linksMisc.Value("Programming the Raspberry Pi with Xojo") = "https://documentation.xojo.com/resources/programming_the_raspberry_pi_with_xojo.html"
		  linksMisc.Value("Release notes") = "https://documentation.xojo.com/resources/release_notes/index.html"
		  linksMisc.Value("Reporting bugs and making feature requests") = "https://documentation.xojo.com/resources/reporting_bugs_and_making_feature_requests.html"
		  linksMisc.Value("Roadmap") = "https://documentation.xojo.com/resources/roadmap.html"
		  linksMisc.Value("System requirements for current release") = "https://documentation.xojo.com/resources/system_requirements_for_current_release.html"
		  linksMisc.Value("System Requirements for previous releases") = "https://documentation.xojo.com/resources/system_requirements_for_previous_releases/index.html"
		  linksMisc.Value("Third party") = "https://documentation.xojo.com/resources/third_party/index.html"
		  linksMisc.Value("Videos") = "https://documentation.xojo.com/resources/videos/index.html"
		  linksMisc.Value("XojoTalk podcast") = "https://documentation.xojo.com/resources/xojotalk_podcast.html"
		  linksMisc.Value("Copyrights and trademarks") = "https://documentation.xojo.com/fine_print/copyrights_and_trademarks.html"
		  linksMisc.Value("End User License Agreement") = "https://documentation.xojo.com/fine_print/end_user_license_agreement.html"
		  
		  addSubMenuMisc (30,15)
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopulateLinksEin()
		  var wEinPath, wFoldName as string
		  var n, wCounter as integer
		  var wItem, wDoc, wParent as FolderItem
		  
		  
		  
		  linksEin = new Dictionary ()
		  
		  'linksEin.Value("Doc MBS") = "https://www.monkeybreadsoftware.net/"
		  'links.Value("cUrl MBS") = "https://www.monkeybreadsoftware.net/plugins-mbscurlplugin.shtml"
		  'links.Value("RabbitMQ MBS") = "https://www.monkeybreadsoftware.net/pluginpart-rabbit.shtml"
		  'links.Value("Json MBS") = "https://www.monkeybreadsoftware.net/class-jsonmbs.shtml"
		  'linksEin.Value("Doc Einhugur") = "https://www.einhugur.com/Html/EDNIndex.html"
		  
		  
		  
		  'if app.searchEin then addXolEin (2842)
		  
		  if app.folderEin <> nil then
		    
		    'Var f As New FolderItem
		    app.folderEin = FolderItem.ShowSelectFolderDialog
		    if app.folderEin <> nil then
		      wEinPath = app.folderEin.URLPath
		      'MessageBox (app.folderEin.URLPath)
		      wFoldName = app.folderEin.Name
		      wCounter=  app.folderEin.Count
		      
		      'file:///Users/dalu/Desktop/Einhugur%20docs/
		      
		      'app.folderEin.Children
		      
		      for n = 1 to wCounter-1
		        wItem = app.folderEin.ChildAt(n)
		        if wItem.Visible then
		          wDoc = wItem.child ("Documentation")
		          linksEin.Value (wItem.name) = wDoc.URLPath+"/index.html"
		          'msgbox (wDoc.URLPath+"/index.html")
		        end if
		      next
		      
		      
		      
		      
		      
		      
		      var mm,wm as NSMenuMBS
		      var f as NSMenuItemMBS
		      var a as MyCocoaMenuItemMBS
		      var nn as integer
		      
		      
		      wm=new NSMenuMBS
		      mm=new NSMenuMBS
		      f = new NSMenuItemMBS
		      
		      mm=app.e.menu
		      'wm=mm.Item(3).submenu
		      'wm=mm.Item(3).submenu
		      
		      // rebuild plugin menu
		      
		      nn = 0
		      wCounter = (linksEin.KeyCount )
		      var wCounterEin as integer
		      wCounterEin = integer(wCounter)
		      var weinfolditem() as string 
		      'wCounter
		      // count language entries
		      
		      for nn = 0 to wCounterEin-1
		        
		        weinfolditem.Add linksEin.Key(nn)
		        
		      next
		      weinfolditem.Sort
		      
		      
		      
		      
		      a=new MyCocoaMenuItemMBS
		      a.CreateMenuItem ("Doc MBS")
		      a.Enabled=true
		      a.tag=88001
		      app.items.Append a
		      wm.AddItem a
		      
		      a=new MyCocoaMenuItemMBS
		      a.CreateMenuItem ("Doc Einhugur")
		      a.Enabled=true
		      a.tag=8802
		      app.items.Append a
		      wm.AddItem a
		      
		      
		      
		      nn = 0
		      for nn =  0 to wCounter-1
		        'var menuItem As DictionaryEntry 
		        'links.Key(i)
		        a=new MyCocoaMenuItemMBS
		        a.CreateMenuItem (weinfolditem(nn))
		        'a.CreateMenuItem (linksEin.Key(nn))
		        'a.CreateMenuItem menuItem.Key
		        'links.Key(i) menuItem.
		        a.Enabled=true
		        a.tag=nn+9000
		        app.items.Append a
		        wm.AddItem a
		        
		      next
		      
		      
		      mm=app.e.menu
		      f=mm.Item(3)
		      f.Submenu=wm
		      
		      
		      winPref.close
		      
		    end if // cancel dialog
		    
		    
		  end if // app.folderEin nil
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopulateLinksMBS()
		  linksMBS.Value("ACAccountCredentialMBS")="https://www.monkeybreadsoftware.net/class-acaccountcredentialmbs.shtml"
		  linksMBS.Value("ACAccountMBS")="https://www.monkeybreadsoftware.net/class-acaccountmbs.shtml"
		  linksMBS.Value("ACAccountStoreMBS")="https://www.monkeybreadsoftware.net/class-acaccountstorembs.shtml"
		  linksMBS.Value("ACAccountTypeMBS")="https://www.monkeybreadsoftware.net/class-acaccounttypembs.shtml"
		  linksMBS.Value("ACLEntryMBS")="https://www.monkeybreadsoftware.net/class-aclentrymbs.shtml"
		  linksMBS.Value("ACLFlagSetMBS")="https://www.monkeybreadsoftware.net/class-aclflagsetmbs.shtml"
		  linksMBS.Value("ACLPermSetMBS")="https://www.monkeybreadsoftware.net/class-aclpermsetmbs.shtml"
		  linksMBS.Value("ACLRightMBS")="https://www.monkeybreadsoftware.net/class-aclrightmbs.shtml"
		  linksMBS.Value("AppleRemoteMBS")="https://www.monkeybreadsoftware.net/class-appleremotembs.shtml"
		  linksMBS.Value("AppleScriptErrorMBS")="https://www.monkeybreadsoftware.net/class-applescripterrormbs.shtml"
		  linksMBS.Value("AppleScriptMBS")="https://www.monkeybreadsoftware.net/class-applescriptmbs.shtml"
		  linksMBS.Value("Application")="https://www.monkeybreadsoftware.net/class-application.shtml"
		  linksMBS.Value("AppReceiptIAPMBS")="https://www.monkeybreadsoftware.net/class-appreceiptiapmbs.shtml"
		  linksMBS.Value("AppReceiptMBS")="https://www.monkeybreadsoftware.net/class-appreceiptmbs.shtml"
		  linksMBS.Value("AppReceiptVerificatorMBS")="https://www.monkeybreadsoftware.net/class-appreceiptverificatormbs.shtml"
		  linksMBS.Value("ArchiveEntryMBS")="https://www.monkeybreadsoftware.net/class-archiveentrymbs.shtml"
		  linksMBS.Value("ArchiveReadDiskMBS")="https://www.monkeybreadsoftware.net/class-archivereaddiskmbs.shtml"
		  linksMBS.Value("ArchiveReaderMBS")="https://www.monkeybreadsoftware.net/class-archivereadermbs.shtml"
		  linksMBS.Value("ArchiverMBS")="https://www.monkeybreadsoftware.net/class-archivermbs.shtml"
		  linksMBS.Value("ArchiveWriteDiskMBS")="https://www.monkeybreadsoftware.net/class-archivewritediskmbs.shtml"
		  linksMBS.Value("ArchiveWriterMBS")="https://www.monkeybreadsoftware.net/class-archivewritermbs.shtml"
		  linksMBS.Value("Argon2MBS")="https://www.monkeybreadsoftware.net/class-argon2mbs.shtml"
		  linksMBS.Value("AudioPlayThruMBS")="https://www.monkeybreadsoftware.net/class-audioplaythrumbs.shtml"
		  linksMBS.Value("AUPlayerMBS")="https://www.monkeybreadsoftware.net/class-auplayermbs.shtml"
		  linksMBS.Value("AuthorizationItemMBS")="https://www.monkeybreadsoftware.net/class-authorizationitemmbs.shtml"
		  linksMBS.Value("AuthorizationItemSetMBS")="https://www.monkeybreadsoftware.net/class-authorizationitemsetmbs.shtml"
		  linksMBS.Value("AuthorizationMBS")="https://www.monkeybreadsoftware.net/class-authorizationmbs.shtml"
		  linksMBS.Value("AvahiBrowserMBS")="https://www.monkeybreadsoftware.net/class-avahibrowsermbs.shtml"
		  linksMBS.Value("AvahiClientMBS")="https://www.monkeybreadsoftware.net/class-avahiclientmbs.shtml"
		  linksMBS.Value("AvahiDomainBrowserMBS")="https://www.monkeybreadsoftware.net/class-avahidomainbrowsermbs.shtml"
		  linksMBS.Value("AvahiResolverMBS")="https://www.monkeybreadsoftware.net/class-avahiresolvermbs.shtml"
		  linksMBS.Value("AvahiTypeBrowserMBS")="https://www.monkeybreadsoftware.net/class-avahitypebrowsermbs.shtml"
		  linksMBS.Value("AVAssetExportSessionMBS")="https://www.monkeybreadsoftware.net/class-avassetexportsessionmbs.shtml"
		  linksMBS.Value("AVAssetImageGeneratorMBS")="https://www.monkeybreadsoftware.net/class-avassetimagegeneratormbs.shtml"
		  linksMBS.Value("AVAssetMBS")="https://www.monkeybreadsoftware.net/class-avassetmbs.shtml"
		  linksMBS.Value("AVAssetReaderAudioMixOutputMBS")="https://www.monkeybreadsoftware.net/class-avassetreaderaudiomixoutputmbs.shtml"
		  linksMBS.Value("AVAssetReaderMBS")="https://www.monkeybreadsoftware.net/class-avassetreadermbs.shtml"
		  linksMBS.Value("AVAssetReaderOutputMBS")="https://www.monkeybreadsoftware.net/class-avassetreaderoutputmbs.shtml"
		  linksMBS.Value("AVAssetReaderOutputMetadataAdaptorMBS")="https://www.monkeybreadsoftware.net/class-avassetreaderoutputmetadataadaptormbs.shtml"
		  linksMBS.Value("AVAssetReaderSampleReferenceOutputMBS")="https://www.monkeybreadsoftware.net/class-avassetreadersamplereferenceoutputmbs.shtml"
		  linksMBS.Value("AVAssetReaderTrackOutputMBS")="https://www.monkeybreadsoftware.net/class-avassetreadertrackoutputmbs.shtml"
		  linksMBS.Value("AVAssetReaderVideoCompositionOutputMBS")="https://www.monkeybreadsoftware.net/class-avassetreadervideocompositionoutputmbs.shtml"
		  linksMBS.Value("AVAssetResourceLoaderMBS")="https://www.monkeybreadsoftware.net/class-avassetresourceloadermbs.shtml"
		  linksMBS.Value("AVAssetResourceLoadingContentInformationRequestMBS")="https://www.monkeybreadsoftware.net/class-avassetresourceloadingcontentinformationrequestmbs.shtml"
		  linksMBS.Value("AVAssetResourceLoadingDataRequestMBS")="https://www.monkeybreadsoftware.net/class-avassetresourceloadingdatarequestmbs.shtml"
		  linksMBS.Value("AVAssetResourceLoadingRequestMBS")="https://www.monkeybreadsoftware.net/class-avassetresourceloadingrequestmbs.shtml"
		  linksMBS.Value("AVAssetTrackGroupMBS")="https://www.monkeybreadsoftware.net/class-avassettrackgroupmbs.shtml"
		  linksMBS.Value("AVAssetTrackMBS")="https://www.monkeybreadsoftware.net/class-avassettrackmbs.shtml"
		  linksMBS.Value("AVAssetTrackSegmentMBS")="https://www.monkeybreadsoftware.net/class-avassettracksegmentmbs.shtml"
		  linksMBS.Value("AVAssetWriterInputGroupMBS")="https://www.monkeybreadsoftware.net/class-avassetwriterinputgroupmbs.shtml"
		  linksMBS.Value("AVAssetWriterInputMBS")="https://www.monkeybreadsoftware.net/class-avassetwriterinputmbs.shtml"
		  linksMBS.Value("AVAssetWriterInputPixelBufferAdaptorMBS")="https://www.monkeybreadsoftware.net/class-avassetwriterinputpixelbufferadaptormbs.shtml"
		  linksMBS.Value("AVAssetWriterMBS")="https://www.monkeybreadsoftware.net/class-avassetwritermbs.shtml"
		  linksMBS.Value("AVAsynchronousVideoCompositionRequestMBS")="https://www.monkeybreadsoftware.net/class-avasynchronousvideocompositionrequestmbs.shtml"
		  linksMBS.Value("AVAudio3DPointMBS")="https://www.monkeybreadsoftware.net/class-avaudio3dpointmbs.shtml"
		  linksMBS.Value("AVAudioBufferMBS")="https://www.monkeybreadsoftware.net/class-avaudiobuffermbs.shtml"
		  linksMBS.Value("AVAudioChannelLayoutMBS")="https://www.monkeybreadsoftware.net/class-avaudiochannellayoutmbs.shtml"
		  linksMBS.Value("AVAudioComponentDescriptionMBS")="https://www.monkeybreadsoftware.net/class-avaudiocomponentdescriptionmbs.shtml"
		  linksMBS.Value("AVAudioEngineMBS")="https://www.monkeybreadsoftware.net/class-avaudioenginembs.shtml"
		  linksMBS.Value("AVAudioEnvironmentDistanceAttenuationParametersMBS")="https://www.monkeybreadsoftware.net/class-avaudioenvironmentdistanceattenuationparametersmbs.shtml"
		  linksMBS.Value("AVAudioEnvironmentNodeMBS")="https://www.monkeybreadsoftware.net/class-avaudioenvironmentnodembs.shtml"
		  linksMBS.Value("AVAudioEnvironmentReverbParametersMBS")="https://www.monkeybreadsoftware.net/class-avaudioenvironmentreverbparametersmbs.shtml"
		  linksMBS.Value("AVAudioFileMBS")="https://www.monkeybreadsoftware.net/class-avaudiofilembs.shtml"
		  linksMBS.Value("AVAudioFormatMBS")="https://www.monkeybreadsoftware.net/class-avaudioformatmbs.shtml"
		  linksMBS.Value("AVAudioInputNodeMBS")="https://www.monkeybreadsoftware.net/class-avaudioinputnodembs.shtml"
		  linksMBS.Value("AVAudioIONodeMBS")="https://www.monkeybreadsoftware.net/class-avaudioionodembs.shtml"
		  linksMBS.Value("AVAudioMixerNodeMBS")="https://www.monkeybreadsoftware.net/class-avaudiomixernodembs.shtml"
		  linksMBS.Value("AVAudioMixInputParametersMBS")="https://www.monkeybreadsoftware.net/class-avaudiomixinputparametersmbs.shtml"
		  linksMBS.Value("AVAudioMixMBS")="https://www.monkeybreadsoftware.net/class-avaudiomixmbs.shtml"
		  linksMBS.Value("AVAudioNodeMBS")="https://www.monkeybreadsoftware.net/class-avaudionodembs.shtml"
		  linksMBS.Value("AVAudioOutputNodeMBS")="https://www.monkeybreadsoftware.net/class-avaudiooutputnodembs.shtml"
		  linksMBS.Value("AVAudioPCMBufferMBS")="https://www.monkeybreadsoftware.net/class-avaudiopcmbuffermbs.shtml"
		  linksMBS.Value("AVAudioPlayerMBS")="https://www.monkeybreadsoftware.net/class-avaudioplayermbs.shtml"
		  linksMBS.Value("AVAudioPlayerNodeMBS")="https://www.monkeybreadsoftware.net/class-avaudioplayernodembs.shtml"
		  linksMBS.Value("AVAudioRecorderMBS")="https://www.monkeybreadsoftware.net/class-avaudiorecordermbs.shtml"
		  linksMBS.Value("AVAudioTimeMBS")="https://www.monkeybreadsoftware.net/class-avaudiotimembs.shtml"
		  linksMBS.Value("AVAudioUnitComponentManagerMBS")="https://www.monkeybreadsoftware.net/class-avaudiounitcomponentmanagermbs.shtml"
		  linksMBS.Value("AVAudioUnitComponentMBS")="https://www.monkeybreadsoftware.net/class-avaudiounitcomponentmbs.shtml"
		  linksMBS.Value("AVAudioUnitDelayMBS")="https://www.monkeybreadsoftware.net/class-avaudiounitdelaymbs.shtml"
		  linksMBS.Value("AVAudioUnitDistortionMBS")="https://www.monkeybreadsoftware.net/class-avaudiounitdistortionmbs.shtml"
		  linksMBS.Value("AVAudioUnitEffectMBS")="https://www.monkeybreadsoftware.net/class-avaudiouniteffectmbs.shtml"
		  linksMBS.Value("AVAudioUnitEQFilterParametersMBS")="https://www.monkeybreadsoftware.net/class-avaudiouniteqfilterparametersmbs.shtml"
		  linksMBS.Value("AVAudioUnitEQMBS")="https://www.monkeybreadsoftware.net/class-avaudiouniteqmbs.shtml"
		  linksMBS.Value("AVAudioUnitGeneratorMBS")="https://www.monkeybreadsoftware.net/class-avaudiounitgeneratormbs.shtml"
		  linksMBS.Value("AVAudioUnitMBS")="https://www.monkeybreadsoftware.net/class-avaudiounitmbs.shtml"
		  linksMBS.Value("AVAudioUnitMIDIInstrumentMBS")="https://www.monkeybreadsoftware.net/class-avaudiounitmidiinstrumentmbs.shtml"
		  linksMBS.Value("AVAudioUnitReverbMBS")="https://www.monkeybreadsoftware.net/class-avaudiounitreverbmbs.shtml"
		  linksMBS.Value("AVAudioUnitSamplerMBS")="https://www.monkeybreadsoftware.net/class-avaudiounitsamplermbs.shtml"
		  linksMBS.Value("AVAudioUnitTimeEffectMBS")="https://www.monkeybreadsoftware.net/class-avaudiounittimeeffectmbs.shtml"
		  linksMBS.Value("AVAudioUnitTimePitchMBS")="https://www.monkeybreadsoftware.net/class-avaudiounittimepitchmbs.shtml"
		  linksMBS.Value("AVAudioUnitVarispeedMBS")="https://www.monkeybreadsoftware.net/class-avaudiounitvarispeedmbs.shtml"
		  linksMBS.Value("AVCaptureAudioChannelMBS")="https://www.monkeybreadsoftware.net/class-avcaptureaudiochannelmbs.shtml"
		  linksMBS.Value("AVCaptureAudioDataOutputMBS")="https://www.monkeybreadsoftware.net/class-avcaptureaudiodataoutputmbs.shtml"
		  linksMBS.Value("AVCaptureAudioFileOutputMBS")="https://www.monkeybreadsoftware.net/class-avcaptureaudiofileoutputmbs.shtml"
		  linksMBS.Value("AVCaptureAudioPreviewOutputMBS")="https://www.monkeybreadsoftware.net/class-avcaptureaudiopreviewoutputmbs.shtml"
		  linksMBS.Value("AVCaptureConnectionMBS")="https://www.monkeybreadsoftware.net/class-avcaptureconnectionmbs.shtml"
		  linksMBS.Value("AVCaptureDeviceFormatMBS")="https://www.monkeybreadsoftware.net/class-avcapturedeviceformatmbs.shtml"
		  linksMBS.Value("AVCaptureDeviceInputMBS")="https://www.monkeybreadsoftware.net/class-avcapturedeviceinputmbs.shtml"
		  linksMBS.Value("AVCaptureDeviceInputSourceMBS")="https://www.monkeybreadsoftware.net/class-avcapturedeviceinputsourcembs.shtml"
		  linksMBS.Value("AVCaptureDeviceMBS")="https://www.monkeybreadsoftware.net/class-avcapturedevicembs.shtml"
		  linksMBS.Value("AVCaptureFileOutputMBS")="https://www.monkeybreadsoftware.net/class-avcapturefileoutputmbs.shtml"
		  linksMBS.Value("AVCaptureInputMBS")="https://www.monkeybreadsoftware.net/class-avcaptureinputmbs.shtml"
		  linksMBS.Value("AVCaptureInputPortMBS")="https://www.monkeybreadsoftware.net/class-avcaptureinputportmbs.shtml"
		  linksMBS.Value("AVCaptureMetadataOutputMBS")="https://www.monkeybreadsoftware.net/class-avcapturemetadataoutputmbs.shtml"
		  linksMBS.Value("AVCaptureMovieFileOutputMBS")="https://www.monkeybreadsoftware.net/class-avcapturemoviefileoutputmbs.shtml"
		  linksMBS.Value("AVCaptureOutputMBS")="https://www.monkeybreadsoftware.net/class-avcaptureoutputmbs.shtml"
		  linksMBS.Value("AVCaptureScreenInputMBS")="https://www.monkeybreadsoftware.net/class-avcapturescreeninputmbs.shtml"
		  linksMBS.Value("AVCaptureSessionMBS")="https://www.monkeybreadsoftware.net/class-avcapturesessionmbs.shtml"
		  linksMBS.Value("AVCaptureStillImageOutputMBS")="https://www.monkeybreadsoftware.net/class-avcapturestillimageoutputmbs.shtml"
		  linksMBS.Value("AVCaptureVideoDataOutputMBS")="https://www.monkeybreadsoftware.net/class-avcapturevideodataoutputmbs.shtml"
		  linksMBS.Value("AVCaptureVideoPreviewLayerMBS")="https://www.monkeybreadsoftware.net/class-avcapturevideopreviewlayermbs.shtml"
		  linksMBS.Value("AVCompositionMBS")="https://www.monkeybreadsoftware.net/class-avcompositionmbs.shtml"
		  linksMBS.Value("AVCompositionTrackMBS")="https://www.monkeybreadsoftware.net/class-avcompositiontrackmbs.shtml"
		  linksMBS.Value("AVCompositionTrackSegmentMBS")="https://www.monkeybreadsoftware.net/class-avcompositiontracksegmentmbs.shtml"
		  linksMBS.Value("AVEdgeWidthsMBS")="https://www.monkeybreadsoftware.net/class-avedgewidthsmbs.shtml"
		  linksMBS.Value("AVFoundationMBS")="https://www.monkeybreadsoftware.net/class-avfoundationmbs.shtml"
		  linksMBS.Value("AVFragmentedMovieMBS")="https://www.monkeybreadsoftware.net/class-avfragmentedmoviembs.shtml"
		  linksMBS.Value("AVFragmentedMovieTrackMBS")="https://www.monkeybreadsoftware.net/class-avfragmentedmovietrackmbs.shtml"
		  linksMBS.Value("AVFrameRateRangeMBS")="https://www.monkeybreadsoftware.net/class-avframeraterangembs.shtml"
		  linksMBS.Value("AVMediaDataStorageMBS")="https://www.monkeybreadsoftware.net/class-avmediadatastoragembs.shtml"
		  linksMBS.Value("AVMediaSelectionGroupMBS")="https://www.monkeybreadsoftware.net/class-avmediaselectiongroupmbs.shtml"
		  linksMBS.Value("AVMediaSelectionOptionMBS")="https://www.monkeybreadsoftware.net/class-avmediaselectionoptionmbs.shtml"
		  linksMBS.Value("AVMetadataItemFilterMBS")="https://www.monkeybreadsoftware.net/class-avmetadataitemfiltermbs.shtml"
		  linksMBS.Value("AVMetadataItemMBS")="https://www.monkeybreadsoftware.net/class-avmetadataitemmbs.shtml"
		  linksMBS.Value("AVMetadataObjectMBS")="https://www.monkeybreadsoftware.net/class-avmetadataobjectmbs.shtml"
		  linksMBS.Value("AVMIDIPlayerMBS")="https://www.monkeybreadsoftware.net/class-avmidiplayermbs.shtml"
		  linksMBS.Value("AVMovieMBS")="https://www.monkeybreadsoftware.net/class-avmoviembs.shtml"
		  linksMBS.Value("AVMovieTrackMBS")="https://www.monkeybreadsoftware.net/class-avmovietrackmbs.shtml"
		  linksMBS.Value("AVMutableAudioMixInputParametersMBS")="https://www.monkeybreadsoftware.net/class-avmutableaudiomixinputparametersmbs.shtml"
		  linksMBS.Value("AVMutableAudioMixMBS")="https://www.monkeybreadsoftware.net/class-avmutableaudiomixmbs.shtml"
		  linksMBS.Value("AVMutableCompositionMBS")="https://www.monkeybreadsoftware.net/class-avmutablecompositionmbs.shtml"
		  linksMBS.Value("AVMutableCompositionTrackMBS")="https://www.monkeybreadsoftware.net/class-avmutablecompositiontrackmbs.shtml"
		  linksMBS.Value("AVMutableMetadataItemMBS")="https://www.monkeybreadsoftware.net/class-avmutablemetadataitemmbs.shtml"
		  linksMBS.Value("AVMutableMovieMBS")="https://www.monkeybreadsoftware.net/class-avmutablemoviembs.shtml"
		  linksMBS.Value("AVMutableMovieTrackMBS")="https://www.monkeybreadsoftware.net/class-avmutablemovietrackmbs.shtml"
		  linksMBS.Value("AVMutableTimedMetadataGroupMBS")="https://www.monkeybreadsoftware.net/class-avmutabletimedmetadatagroupmbs.shtml"
		  linksMBS.Value("AVMutableVideoCompositionInstructionMBS")="https://www.monkeybreadsoftware.net/class-avmutablevideocompositioninstructionmbs.shtml"
		  linksMBS.Value("AVMutableVideoCompositionLayerInstructionMBS")="https://www.monkeybreadsoftware.net/class-avmutablevideocompositionlayerinstructionmbs.shtml"
		  linksMBS.Value("AVMutableVideoCompositionMBS")="https://www.monkeybreadsoftware.net/class-avmutablevideocompositionmbs.shtml"
		  linksMBS.Value("AVOutputSettingsAssistantMBS")="https://www.monkeybreadsoftware.net/class-avoutputsettingsassistantmbs.shtml"
		  linksMBS.Value("AVPixelAspectRatioMBS")="https://www.monkeybreadsoftware.net/class-avpixelaspectratiombs.shtml"
		  linksMBS.Value("AVPlayerItemAccessLogEventMBS")="https://www.monkeybreadsoftware.net/class-avplayeritemaccesslogeventmbs.shtml"
		  linksMBS.Value("AVPlayerItemAccessLogMBS")="https://www.monkeybreadsoftware.net/class-avplayeritemaccesslogmbs.shtml"
		  linksMBS.Value("AVPlayerItemErrorLogEventMBS")="https://www.monkeybreadsoftware.net/class-avplayeritemerrorlogeventmbs.shtml"
		  linksMBS.Value("AVPlayerItemErrorLogMBS")="https://www.monkeybreadsoftware.net/class-avplayeritemerrorlogmbs.shtml"
		  linksMBS.Value("AVPlayerItemLegibleOutputMBS")="https://www.monkeybreadsoftware.net/class-avplayeritemlegibleoutputmbs.shtml"
		  linksMBS.Value("AVPlayerItemMBS")="https://www.monkeybreadsoftware.net/class-avplayeritemmbs.shtml"
		  linksMBS.Value("AVPlayerItemOutputMBS")="https://www.monkeybreadsoftware.net/class-avplayeritemoutputmbs.shtml"
		  linksMBS.Value("AVPlayerItemTrackMBS")="https://www.monkeybreadsoftware.net/class-avplayeritemtrackmbs.shtml"
		  linksMBS.Value("AVPlayerItemVideoOutputMBS")="https://www.monkeybreadsoftware.net/class-avplayeritemvideooutputmbs.shtml"
		  linksMBS.Value("AVPlayerLayerMBS")="https://www.monkeybreadsoftware.net/class-avplayerlayermbs.shtml"
		  linksMBS.Value("AVPlayerLooperMBS")="https://www.monkeybreadsoftware.net/class-avplayerloopermbs.shtml"
		  linksMBS.Value("AVPlayerMBS")="https://www.monkeybreadsoftware.net/class-avplayermbs.shtml"
		  linksMBS.Value("AVPlayerMediaSelectionCriteriaMBS")="https://www.monkeybreadsoftware.net/class-avplayermediaselectioncriteriambs.shtml"
		  linksMBS.Value("AVPlayerTimeObserverMBS")="https://www.monkeybreadsoftware.net/class-avplayertimeobservermbs.shtml"
		  linksMBS.Value("AVQueuePlayerMBS")="https://www.monkeybreadsoftware.net/class-avqueueplayermbs.shtml"
		  linksMBS.Value("AVRouteDetectorMBS")="https://www.monkeybreadsoftware.net/class-avroutedetectormbs.shtml"
		  linksMBS.Value("AVSampleBufferDisplayLayerMBS")="https://www.monkeybreadsoftware.net/class-avsamplebufferdisplaylayermbs.shtml"
		  linksMBS.Value("AVSynchronizedLayerMBS")="https://www.monkeybreadsoftware.net/class-avsynchronizedlayermbs.shtml"
		  linksMBS.Value("AVTextStyleRuleMBS")="https://www.monkeybreadsoftware.net/class-avtextstylerulembs.shtml"
		  linksMBS.Value("AVTimeCodeMBS")="https://www.monkeybreadsoftware.net/class-avtimecodembs.shtml"
		  linksMBS.Value("AVTimedMetadataGroupMBS")="https://www.monkeybreadsoftware.net/class-avtimedmetadatagroupmbs.shtml"
		  linksMBS.Value("AVURLAssetMBS")="https://www.monkeybreadsoftware.net/class-avurlassetmbs.shtml"
		  linksMBS.Value("AVVideoCompositingMBS")="https://www.monkeybreadsoftware.net/class-avvideocompositingmbs.shtml"
		  linksMBS.Value("AVVideoCompositionCoreAnimationToolMBS")="https://www.monkeybreadsoftware.net/class-avvideocompositioncoreanimationtoolmbs.shtml"
		  linksMBS.Value("AVVideoCompositionInstructionMBS")="https://www.monkeybreadsoftware.net/class-avvideocompositioninstructionmbs.shtml"
		  linksMBS.Value("AVVideoCompositionLayerInstructionMBS")="https://www.monkeybreadsoftware.net/class-avvideocompositionlayerinstructionmbs.shtml"
		  linksMBS.Value("AVVideoCompositionMBS")="https://www.monkeybreadsoftware.net/class-avvideocompositionmbs.shtml"
		  linksMBS.Value("AVVideoCompositionRenderContextMBS")="https://www.monkeybreadsoftware.net/class-avvideocompositionrendercontextmbs.shtml"
		  linksMBS.Value("AXObserverMBS")="https://www.monkeybreadsoftware.net/class-axobservermbs.shtml"
		  linksMBS.Value("AXUIElementMBS")="https://www.monkeybreadsoftware.net/class-axuielementmbs.shtml"
		  linksMBS.Value("AXValueMBS")="https://www.monkeybreadsoftware.net/class-axvaluembs.shtml"
		  linksMBS.Value("BarcodeGeneratorMBS")="https://www.monkeybreadsoftware.net/class-barcodegeneratormbs.shtml"
		  linksMBS.Value("Base64MBS")="https://www.monkeybreadsoftware.net/class-base64mbs.shtml"
		  linksMBS.Value("BevelButton")="https://www.monkeybreadsoftware.net/class-bevelbutton.shtml"
		  linksMBS.Value("BiggerNumberMBS")="https://www.monkeybreadsoftware.net/class-biggernumbermbs.shtml"
		  linksMBS.Value("BigNumberErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-bignumbererrorexceptionmbs.shtml"
		  linksMBS.Value("BigNumberMBS")="https://www.monkeybreadsoftware.net/class-bignumbermbs.shtml"
		  linksMBS.Value("BlockMBS")="https://www.monkeybreadsoftware.net/class-blockmbs.shtml"
		  linksMBS.Value("BlowfishMBS")="https://www.monkeybreadsoftware.net/class-blowfishmbs.shtml"
		  linksMBS.Value("BZip2CompressMBS")="https://www.monkeybreadsoftware.net/class-bzip2compressmbs.shtml"
		  linksMBS.Value("BZip2DecompressMBS")="https://www.monkeybreadsoftware.net/class-bzip2decompressmbs.shtml"
		  linksMBS.Value("BZip2FileMBS")="https://www.monkeybreadsoftware.net/class-bzip2filembs.shtml"
		  linksMBS.Value("CALayerMBS")="https://www.monkeybreadsoftware.net/class-calayermbs.shtml"
		  linksMBS.Value("CanvasGesturesMBS")="https://www.monkeybreadsoftware.net/class-canvasgesturesmbs.shtml"
		  linksMBS.Value("CAPlayThroughMBS")="https://www.monkeybreadsoftware.net/class-caplaythroughmbs.shtml"
		  linksMBS.Value("CarbonEventsIdleTimerMBS")="https://www.monkeybreadsoftware.net/class-carboneventsidletimermbs.shtml"
		  linksMBS.Value("CarbonEventsTabletPointMBS")="https://www.monkeybreadsoftware.net/class-carboneventstabletpointmbs.shtml"
		  linksMBS.Value("CarbonEventsTabletProximityMBS")="https://www.monkeybreadsoftware.net/class-carboneventstabletproximitymbs.shtml"
		  linksMBS.Value("CarbonEventsTimerMBS")="https://www.monkeybreadsoftware.net/class-carboneventstimermbs.shtml"
		  linksMBS.Value("CarbonHotKeyMBS")="https://www.monkeybreadsoftware.net/class-carbonhotkeymbs.shtml"
		  linksMBS.Value("CarbonMonitorEventsMBS")="https://www.monkeybreadsoftware.net/class-carbonmonitoreventsmbs.shtml"
		  linksMBS.Value("CarbonSystemEventsMBS")="https://www.monkeybreadsoftware.net/class-carbonsystemeventsmbs.shtml"
		  linksMBS.Value("CATextLayerMBS")="https://www.monkeybreadsoftware.net/class-catextlayermbs.shtml"
		  linksMBS.Value("CATransactionMBS")="https://www.monkeybreadsoftware.net/class-catransactionmbs.shtml"
		  linksMBS.Value("CatSearchMBS")="https://www.monkeybreadsoftware.net/class-catsearchmbs.shtml"
		  linksMBS.Value("CBATTRequestMBS")="https://www.monkeybreadsoftware.net/class-cbattrequestmbs.shtml"
		  linksMBS.Value("CBAttributeMBS")="https://www.monkeybreadsoftware.net/class-cbattributembs.shtml"
		  linksMBS.Value("CBCentralManagerMBS")="https://www.monkeybreadsoftware.net/class-cbcentralmanagermbs.shtml"
		  linksMBS.Value("CBCentralMBS")="https://www.monkeybreadsoftware.net/class-cbcentralmbs.shtml"
		  linksMBS.Value("CBCharacteristicMBS")="https://www.monkeybreadsoftware.net/class-cbcharacteristicmbs.shtml"
		  linksMBS.Value("CBDescriptorMBS")="https://www.monkeybreadsoftware.net/class-cbdescriptormbs.shtml"
		  linksMBS.Value("CBGroupIdentityMBS")="https://www.monkeybreadsoftware.net/class-cbgroupidentitymbs.shtml"
		  linksMBS.Value("CBIdentityAuthorityMBS")="https://www.monkeybreadsoftware.net/class-cbidentityauthoritymbs.shtml"
		  linksMBS.Value("CBIdentityMBS")="https://www.monkeybreadsoftware.net/class-cbidentitymbs.shtml"
		  linksMBS.Value("CBIdentityPickerMBS")="https://www.monkeybreadsoftware.net/class-cbidentitypickermbs.shtml"
		  linksMBS.Value("CBL2CAPChannelMBS")="https://www.monkeybreadsoftware.net/class-cbl2capchannelmbs.shtml"
		  linksMBS.Value("CBManagerMBS")="https://www.monkeybreadsoftware.net/class-cbmanagermbs.shtml"
		  linksMBS.Value("CBMutableCharacteristicMBS")="https://www.monkeybreadsoftware.net/class-cbmutablecharacteristicmbs.shtml"
		  linksMBS.Value("CBMutableDescriptorMBS")="https://www.monkeybreadsoftware.net/class-cbmutabledescriptormbs.shtml"
		  linksMBS.Value("CBMutableServiceMBS")="https://www.monkeybreadsoftware.net/class-cbmutableservicembs.shtml"
		  linksMBS.Value("CBPeerMBS")="https://www.monkeybreadsoftware.net/class-cbpeermbs.shtml"
		  linksMBS.Value("CBPeripheralManagerMBS")="https://www.monkeybreadsoftware.net/class-cbperipheralmanagermbs.shtml"
		  linksMBS.Value("CBPeripheralMBS")="https://www.monkeybreadsoftware.net/class-cbperipheralmbs.shtml"
		  linksMBS.Value("CBServiceMBS")="https://www.monkeybreadsoftware.net/class-cbservicembs.shtml"
		  linksMBS.Value("CBUserIdentityMBS")="https://www.monkeybreadsoftware.net/class-cbuseridentitymbs.shtml"
		  linksMBS.Value("CBUUIDMBS")="https://www.monkeybreadsoftware.net/class-cbuuidmbs.shtml"
		  linksMBS.Value("CCCryptorMBS")="https://www.monkeybreadsoftware.net/class-cccryptormbs.shtml"
		  linksMBS.Value("CCHMacMBS")="https://www.monkeybreadsoftware.net/class-cchmacmbs.shtml"
		  linksMBS.Value("CCMD2MBS")="https://www.monkeybreadsoftware.net/class-ccmd2mbs.shtml"
		  linksMBS.Value("CCMD4MBS")="https://www.monkeybreadsoftware.net/class-ccmd4mbs.shtml"
		  linksMBS.Value("CCMD5MBS")="https://www.monkeybreadsoftware.net/class-ccmd5mbs.shtml"
		  linksMBS.Value("CCSHA1MBS")="https://www.monkeybreadsoftware.net/class-ccsha1mbs.shtml"
		  linksMBS.Value("CCSHA224MBS")="https://www.monkeybreadsoftware.net/class-ccsha224mbs.shtml"
		  linksMBS.Value("CCSHA256MBS")="https://www.monkeybreadsoftware.net/class-ccsha256mbs.shtml"
		  linksMBS.Value("CCSHA384MBS")="https://www.monkeybreadsoftware.net/class-ccsha384mbs.shtml"
		  linksMBS.Value("CCSHA512MBS")="https://www.monkeybreadsoftware.net/class-ccsha512mbs.shtml"
		  linksMBS.Value("CDAngularAxisMBS")="https://www.monkeybreadsoftware.net/class-cdangularaxismbs.shtml"
		  linksMBS.Value("CDAngularMeterMBS")="https://www.monkeybreadsoftware.net/class-cdangularmetermbs.shtml"
		  linksMBS.Value("CDAreaLayerMBS")="https://www.monkeybreadsoftware.net/class-cdarealayermbs.shtml"
		  linksMBS.Value("CDArrayMBS")="https://www.monkeybreadsoftware.net/class-cdarraymbs.shtml"
		  linksMBS.Value("CDAxisMBS")="https://www.monkeybreadsoftware.net/class-cdaxismbs.shtml"
		  linksMBS.Value("CDBarLayerMBS")="https://www.monkeybreadsoftware.net/class-cdbarlayermbs.shtml"
		  linksMBS.Value("CDBaseBoxLayerMBS")="https://www.monkeybreadsoftware.net/class-cdbaseboxlayermbs.shtml"
		  linksMBS.Value("CDBaseChartMBS")="https://www.monkeybreadsoftware.net/class-cdbasechartmbs.shtml"
		  linksMBS.Value("CDBaseMeterMBS")="https://www.monkeybreadsoftware.net/class-cdbasemetermbs.shtml"
		  linksMBS.Value("CDBoxMBS")="https://www.monkeybreadsoftware.net/class-cdboxmbs.shtml"
		  linksMBS.Value("CDBoxWhiskerLayerMBS")="https://www.monkeybreadsoftware.net/class-cdboxwhiskerlayermbs.shtml"
		  linksMBS.Value("CDCandleStickLayerMBS")="https://www.monkeybreadsoftware.net/class-cdcandlesticklayermbs.shtml"
		  linksMBS.Value("CDColorAxisMBS")="https://www.monkeybreadsoftware.net/class-cdcoloraxismbs.shtml"
		  linksMBS.Value("CDContourLayerMBS")="https://www.monkeybreadsoftware.net/class-cdcontourlayermbs.shtml"
		  linksMBS.Value("CDDataAcceleratorMBS")="https://www.monkeybreadsoftware.net/class-cddataacceleratormbs.shtml"
		  linksMBS.Value("CDDataSetMBS")="https://www.monkeybreadsoftware.net/class-cddatasetmbs.shtml"
		  linksMBS.Value("CDDiscreteHeatMapLayerMBS")="https://www.monkeybreadsoftware.net/class-cddiscreteheatmaplayermbs.shtml"
		  linksMBS.Value("CDDrawAreaMBS")="https://www.monkeybreadsoftware.net/class-cddrawareambs.shtml"
		  linksMBS.Value("CDDrawObjMBS")="https://www.monkeybreadsoftware.net/class-cddrawobjmbs.shtml"
		  linksMBS.Value("CDFinanceChartMBS")="https://www.monkeybreadsoftware.net/class-cdfinancechartmbs.shtml"
		  linksMBS.Value("CDFinanceSimulatorMBS")="https://www.monkeybreadsoftware.net/class-cdfinancesimulatormbs.shtml"
		  linksMBS.Value("CDHLOCLayerMBS")="https://www.monkeybreadsoftware.net/class-cdhloclayermbs.shtml"
		  linksMBS.Value("CDImageMapHandlerMBS")="https://www.monkeybreadsoftware.net/class-cdimagemaphandlermbs.shtml"
		  linksMBS.Value("CDInterLineLayerMBS")="https://www.monkeybreadsoftware.net/class-cdinterlinelayermbs.shtml"
		  linksMBS.Value("CDLayerMBS")="https://www.monkeybreadsoftware.net/class-cdlayermbs.shtml"
		  linksMBS.Value("CDLegendBoxMBS")="https://www.monkeybreadsoftware.net/class-cdlegendboxmbs.shtml"
		  linksMBS.Value("CDLinearMeterMBS")="https://www.monkeybreadsoftware.net/class-cdlinearmetermbs.shtml"
		  linksMBS.Value("CDLineLayerMBS")="https://www.monkeybreadsoftware.net/class-cdlinelayermbs.shtml"
		  linksMBS.Value("CDLineMBS")="https://www.monkeybreadsoftware.net/class-cdlinembs.shtml"
		  linksMBS.Value("CDLineObjMBS")="https://www.monkeybreadsoftware.net/class-cdlineobjmbs.shtml"
		  linksMBS.Value("CDMarkMBS")="https://www.monkeybreadsoftware.net/class-cdmarkmbs.shtml"
		  linksMBS.Value("CDMeterPointerMBS")="https://www.monkeybreadsoftware.net/class-cdmeterpointermbs.shtml"
		  linksMBS.Value("CDMLTableMBS")="https://www.monkeybreadsoftware.net/class-cdmltablembs.shtml"
		  linksMBS.Value("CDMultiChartMBS")="https://www.monkeybreadsoftware.net/class-cdmultichartmbs.shtml"
		  linksMBS.Value("CDMultiPagePDFMBS")="https://www.monkeybreadsoftware.net/class-cdmultipagepdfmbs.shtml"
		  linksMBS.Value("CDNotInitialzedExceptionMBS")="https://www.monkeybreadsoftware.net/class-cdnotinitialzedexceptionmbs.shtml"
		  linksMBS.Value("CDPieChartMBS")="https://www.monkeybreadsoftware.net/class-cdpiechartmbs.shtml"
		  linksMBS.Value("CDPlotAreaMBS")="https://www.monkeybreadsoftware.net/class-cdplotareambs.shtml"
		  linksMBS.Value("CDPolarAreaLayerMBS")="https://www.monkeybreadsoftware.net/class-cdpolararealayermbs.shtml"
		  linksMBS.Value("CDPolarChartMBS")="https://www.monkeybreadsoftware.net/class-cdpolarchartmbs.shtml"
		  linksMBS.Value("CDPolarLayerMBS")="https://www.monkeybreadsoftware.net/class-cdpolarlayermbs.shtml"
		  linksMBS.Value("CDPolarLineLayerMBS")="https://www.monkeybreadsoftware.net/class-cdpolarlinelayermbs.shtml"
		  linksMBS.Value("CDPolarSplineAreaLayerMBS")="https://www.monkeybreadsoftware.net/class-cdpolarsplinearealayermbs.shtml"
		  linksMBS.Value("CDPolarSplineLineLayerMBS")="https://www.monkeybreadsoftware.net/class-cdpolarsplinelinelayermbs.shtml"
		  linksMBS.Value("CDPolarVectorLayerMBS")="https://www.monkeybreadsoftware.net/class-cdpolarvectorlayermbs.shtml"
		  linksMBS.Value("CDPyramidChartMBS")="https://www.monkeybreadsoftware.net/class-cdpyramidchartmbs.shtml"
		  linksMBS.Value("CDPyramidLayerMBS")="https://www.monkeybreadsoftware.net/class-cdpyramidlayermbs.shtml"
		  linksMBS.Value("CDRadialAxisMBS")="https://www.monkeybreadsoftware.net/class-cdradialaxismbs.shtml"
		  linksMBS.Value("CDRanSeriesMBS")="https://www.monkeybreadsoftware.net/class-cdranseriesmbs.shtml"
		  linksMBS.Value("CDRanTableMBS")="https://www.monkeybreadsoftware.net/class-cdrantablembs.shtml"
		  linksMBS.Value("CDScatterLayerMBS")="https://www.monkeybreadsoftware.net/class-cdscatterlayermbs.shtml"
		  linksMBS.Value("CDSectorMBS")="https://www.monkeybreadsoftware.net/class-cdsectormbs.shtml"
		  linksMBS.Value("CDSplineLayerMBS")="https://www.monkeybreadsoftware.net/class-cdsplinelayermbs.shtml"
		  linksMBS.Value("CDStepLineLayerMBS")="https://www.monkeybreadsoftware.net/class-cdsteplinelayermbs.shtml"
		  linksMBS.Value("CDSurfaceChartMBS")="https://www.monkeybreadsoftware.net/class-cdsurfacechartmbs.shtml"
		  linksMBS.Value("CDTextBoxMBS")="https://www.monkeybreadsoftware.net/class-cdtextboxmbs.shtml"
		  linksMBS.Value("CDThreeDChartMBS")="https://www.monkeybreadsoftware.net/class-cdthreedchartmbs.shtml"
		  linksMBS.Value("CDThreeDScatterChartMBS")="https://www.monkeybreadsoftware.net/class-cdthreedscatterchartmbs.shtml"
		  linksMBS.Value("CDThreeDScatterGroupMBS")="https://www.monkeybreadsoftware.net/class-cdthreedscattergroupmbs.shtml"
		  linksMBS.Value("CDTreeMapChartMBS")="https://www.monkeybreadsoftware.net/class-cdtreemapchartmbs.shtml"
		  linksMBS.Value("CDTreeMapNodeMBS")="https://www.monkeybreadsoftware.net/class-cdtreemapnodembs.shtml"
		  linksMBS.Value("CDTrendLayerMBS")="https://www.monkeybreadsoftware.net/class-cdtrendlayermbs.shtml"
		  linksMBS.Value("CDTTFTextMBS")="https://www.monkeybreadsoftware.net/class-cdttftextmbs.shtml"
		  linksMBS.Value("CDVectorLayerMBS")="https://www.monkeybreadsoftware.net/class-cdvectorlayermbs.shtml"
		  linksMBS.Value("CDViewPortControlBaseMBS")="https://www.monkeybreadsoftware.net/class-cdviewportcontrolbasembs.shtml"
		  linksMBS.Value("CDViewPortManagerMBS")="https://www.monkeybreadsoftware.net/class-cdviewportmanagermbs.shtml"
		  linksMBS.Value("CDXYChartMBS")="https://www.monkeybreadsoftware.net/class-cdxychartmbs.shtml"
		  linksMBS.Value("CFAbsoluteTimeMBS")="https://www.monkeybreadsoftware.net/class-cfabsolutetimembs.shtml"
		  linksMBS.Value("CFArrayMBS")="https://www.monkeybreadsoftware.net/class-cfarraymbs.shtml"
		  linksMBS.Value("CFAttributedStringMBS")="https://www.monkeybreadsoftware.net/class-cfattributedstringmbs.shtml"
		  linksMBS.Value("CFBagListMBS")="https://www.monkeybreadsoftware.net/class-cfbaglistmbs.shtml"
		  linksMBS.Value("CFBagMBS")="https://www.monkeybreadsoftware.net/class-cfbagmbs.shtml"
		  linksMBS.Value("CFBinaryDataMBS")="https://www.monkeybreadsoftware.net/class-cfbinarydatambs.shtml"
		  linksMBS.Value("CFBooleanMBS")="https://www.monkeybreadsoftware.net/class-cfbooleanmbs.shtml"
		  linksMBS.Value("CFBundleMBS")="https://www.monkeybreadsoftware.net/class-cfbundlembs.shtml"
		  linksMBS.Value("CFCharacterSetMBS")="https://www.monkeybreadsoftware.net/class-cfcharactersetmbs.shtml"
		  linksMBS.Value("CFDateMBS")="https://www.monkeybreadsoftware.net/class-cfdatembs.shtml"
		  linksMBS.Value("CFDictionaryListMBS")="https://www.monkeybreadsoftware.net/class-cfdictionarylistmbs.shtml"
		  linksMBS.Value("CFDictionaryMBS")="https://www.monkeybreadsoftware.net/class-cfdictionarymbs.shtml"
		  linksMBS.Value("CFErrorMBS")="https://www.monkeybreadsoftware.net/class-cferrormbs.shtml"
		  linksMBS.Value("CFGregorianDateMBS")="https://www.monkeybreadsoftware.net/class-cfgregoriandatembs.shtml"
		  linksMBS.Value("CFGregorianUnitsMBS")="https://www.monkeybreadsoftware.net/class-cfgregorianunitsmbs.shtml"
		  linksMBS.Value("CFHostMBS")="https://www.monkeybreadsoftware.net/class-cfhostmbs.shtml"
		  linksMBS.Value("CFHTTPMessageMBS")="https://www.monkeybreadsoftware.net/class-cfhttpmessagembs.shtml"
		  linksMBS.Value("CFMutableArrayMBS")="https://www.monkeybreadsoftware.net/class-cfmutablearraymbs.shtml"
		  linksMBS.Value("CFMutableAttributedStringMBS")="https://www.monkeybreadsoftware.net/class-cfmutableattributedstringmbs.shtml"
		  linksMBS.Value("CFMutableBagMBS")="https://www.monkeybreadsoftware.net/class-cfmutablebagmbs.shtml"
		  linksMBS.Value("CFMutableBinaryDataMBS")="https://www.monkeybreadsoftware.net/class-cfmutablebinarydatambs.shtml"
		  linksMBS.Value("CFMutableCharacterSetMBS")="https://www.monkeybreadsoftware.net/class-cfmutablecharactersetmbs.shtml"
		  linksMBS.Value("CFMutableDictionaryMBS")="https://www.monkeybreadsoftware.net/class-cfmutabledictionarymbs.shtml"
		  linksMBS.Value("CFMutableSetMBS")="https://www.monkeybreadsoftware.net/class-cfmutablesetmbs.shtml"
		  linksMBS.Value("CFMutableStringMBS")="https://www.monkeybreadsoftware.net/class-cfmutablestringmbs.shtml"
		  linksMBS.Value("CFNumberMBS")="https://www.monkeybreadsoftware.net/class-cfnumbermbs.shtml"
		  linksMBS.Value("CFObjectMBS")="https://www.monkeybreadsoftware.net/class-cfobjectmbs.shtml"
		  linksMBS.Value("CFPreferencesMBS")="https://www.monkeybreadsoftware.net/class-cfpreferencesmbs.shtml"
		  linksMBS.Value("CFProxyMBS")="https://www.monkeybreadsoftware.net/class-cfproxymbs.shtml"
		  linksMBS.Value("CFRangeMBS")="https://www.monkeybreadsoftware.net/class-cfrangembs.shtml"
		  linksMBS.Value("CFReadStreamMBS")="https://www.monkeybreadsoftware.net/class-cfreadstreammbs.shtml"
		  linksMBS.Value("CFSetListMBS")="https://www.monkeybreadsoftware.net/class-cfsetlistmbs.shtml"
		  linksMBS.Value("CFSetMBS")="https://www.monkeybreadsoftware.net/class-cfsetmbs.shtml"
		  linksMBS.Value("CFSocketMBS")="https://www.monkeybreadsoftware.net/class-cfsocketmbs.shtml"
		  linksMBS.Value("CFStreamMBS")="https://www.monkeybreadsoftware.net/class-cfstreammbs.shtml"
		  linksMBS.Value("CFStringMBS")="https://www.monkeybreadsoftware.net/class-cfstringmbs.shtml"
		  linksMBS.Value("CFTimeIntervalMBS")="https://www.monkeybreadsoftware.net/class-cftimeintervalmbs.shtml"
		  linksMBS.Value("CFTimeZoneMBS")="https://www.monkeybreadsoftware.net/class-cftimezonembs.shtml"
		  linksMBS.Value("CFTreeMBS")="https://www.monkeybreadsoftware.net/class-cftreembs.shtml"
		  linksMBS.Value("CFURLMBS")="https://www.monkeybreadsoftware.net/class-cfurlmbs.shtml"
		  linksMBS.Value("CFUUIDMBS")="https://www.monkeybreadsoftware.net/class-cfuuidmbs.shtml"
		  linksMBS.Value("CFWriteStreamMBS")="https://www.monkeybreadsoftware.net/class-cfwritestreammbs.shtml"
		  linksMBS.Value("CGAffineTransformMBS")="https://www.monkeybreadsoftware.net/class-cgaffinetransformmbs.shtml"
		  linksMBS.Value("CGBitmapContextMBS")="https://www.monkeybreadsoftware.net/class-cgbitmapcontextmbs.shtml"
		  linksMBS.Value("CGColorMBS")="https://www.monkeybreadsoftware.net/class-cgcolormbs.shtml"
		  linksMBS.Value("CGColorSpaceMBS")="https://www.monkeybreadsoftware.net/class-cgcolorspacembs.shtml"
		  linksMBS.Value("CGContextMBS")="https://www.monkeybreadsoftware.net/class-cgcontextmbs.shtml"
		  linksMBS.Value("CGDataConsumerMBS")="https://www.monkeybreadsoftware.net/class-cgdataconsumermbs.shtml"
		  linksMBS.Value("CGDataProviderMBS")="https://www.monkeybreadsoftware.net/class-cgdataprovidermbs.shtml"
		  linksMBS.Value("CGDisplayConfigMBS")="https://www.monkeybreadsoftware.net/class-cgdisplayconfigmbs.shtml"
		  linksMBS.Value("CGDisplayMBS")="https://www.monkeybreadsoftware.net/class-cgdisplaymbs.shtml"
		  linksMBS.Value("CGDisplayModeMBS")="https://www.monkeybreadsoftware.net/class-cgdisplaymodembs.shtml"
		  linksMBS.Value("CGDisplayReconfigurationEventMBS")="https://www.monkeybreadsoftware.net/class-cgdisplayreconfigurationeventmbs.shtml"
		  linksMBS.Value("CGDisplayStreamEventMBS")="https://www.monkeybreadsoftware.net/class-cgdisplaystreameventmbs.shtml"
		  linksMBS.Value("CGDisplayStreamUpdateMBS")="https://www.monkeybreadsoftware.net/class-cgdisplaystreamupdatembs.shtml"
		  linksMBS.Value("CGDisplayTransferFormulaMBS")="https://www.monkeybreadsoftware.net/class-cgdisplaytransferformulambs.shtml"
		  linksMBS.Value("CGEventMBS")="https://www.monkeybreadsoftware.net/class-cgeventmbs.shtml"
		  linksMBS.Value("CGEventSourceMBS")="https://www.monkeybreadsoftware.net/class-cgeventsourcembs.shtml"
		  linksMBS.Value("CGEventTapMBS")="https://www.monkeybreadsoftware.net/class-cgeventtapmbs.shtml"
		  linksMBS.Value("CGFontMBS")="https://www.monkeybreadsoftware.net/class-cgfontmbs.shtml"
		  linksMBS.Value("CGFunctionMBS")="https://www.monkeybreadsoftware.net/class-cgfunctionmbs.shtml"
		  linksMBS.Value("CGGradientMBS")="https://www.monkeybreadsoftware.net/class-cggradientmbs.shtml"
		  linksMBS.Value("CGImageDestinationMBS")="https://www.monkeybreadsoftware.net/class-cgimagedestinationmbs.shtml"
		  linksMBS.Value("CGImageMBS")="https://www.monkeybreadsoftware.net/class-cgimagembs.shtml"
		  linksMBS.Value("CGImageMetadataMBS")="https://www.monkeybreadsoftware.net/class-cgimagemetadatambs.shtml"
		  linksMBS.Value("CGImageMetadataTagMBS")="https://www.monkeybreadsoftware.net/class-cgimagemetadatatagmbs.shtml"
		  linksMBS.Value("CGImageSourceMBS")="https://www.monkeybreadsoftware.net/class-cgimagesourcembs.shtml"
		  linksMBS.Value("CGLayerMBS")="https://www.monkeybreadsoftware.net/class-cglayermbs.shtml"
		  linksMBS.Value("CGMutableImageMetadataMBS")="https://www.monkeybreadsoftware.net/class-cgmutableimagemetadatambs.shtml"
		  linksMBS.Value("CGMutablePathMBS")="https://www.monkeybreadsoftware.net/class-cgmutablepathmbs.shtml"
		  linksMBS.Value("CGPathElementMBS")="https://www.monkeybreadsoftware.net/class-cgpathelementmbs.shtml"
		  linksMBS.Value("CGPathMBS")="https://www.monkeybreadsoftware.net/class-cgpathmbs.shtml"
		  linksMBS.Value("CGPDFArrayMBS")="https://www.monkeybreadsoftware.net/class-cgpdfarraymbs.shtml"
		  linksMBS.Value("CGPDFContextMBS")="https://www.monkeybreadsoftware.net/class-cgpdfcontextmbs.shtml"
		  linksMBS.Value("CGPDFDictionaryListMBS")="https://www.monkeybreadsoftware.net/class-cgpdfdictionarylistmbs.shtml"
		  linksMBS.Value("CGPDFDictionaryMBS")="https://www.monkeybreadsoftware.net/class-cgpdfdictionarymbs.shtml"
		  linksMBS.Value("CGPDFDocumentMBS")="https://www.monkeybreadsoftware.net/class-cgpdfdocumentmbs.shtml"
		  linksMBS.Value("CGPDFObjectMBS")="https://www.monkeybreadsoftware.net/class-cgpdfobjectmbs.shtml"
		  linksMBS.Value("CGPDFPageMBS")="https://www.monkeybreadsoftware.net/class-cgpdfpagembs.shtml"
		  linksMBS.Value("CGPDFStreamMBS")="https://www.monkeybreadsoftware.net/class-cgpdfstreammbs.shtml"
		  linksMBS.Value("CGPDFStringMBS")="https://www.monkeybreadsoftware.net/class-cgpdfstringmbs.shtml"
		  linksMBS.Value("CGPointMBS")="https://www.monkeybreadsoftware.net/class-cgpointmbs.shtml"
		  linksMBS.Value("CGPSConverterMBS")="https://www.monkeybreadsoftware.net/class-cgpsconvertermbs.shtml"
		  linksMBS.Value("CGRectMBS")="https://www.monkeybreadsoftware.net/class-cgrectmbs.shtml"
		  linksMBS.Value("CGSConnectionMBS")="https://www.monkeybreadsoftware.net/class-cgsconnectionmbs.shtml"
		  linksMBS.Value("CGScreenRefreshEventMBS")="https://www.monkeybreadsoftware.net/class-cgscreenrefresheventmbs.shtml"
		  linksMBS.Value("CGScreenUpdateMoveEventMBS")="https://www.monkeybreadsoftware.net/class-cgscreenupdatemoveeventmbs.shtml"
		  linksMBS.Value("CGSessionMBS")="https://www.monkeybreadsoftware.net/class-cgsessionmbs.shtml"
		  linksMBS.Value("CGShadingMBS")="https://www.monkeybreadsoftware.net/class-cgshadingmbs.shtml"
		  linksMBS.Value("CGSizeMBS")="https://www.monkeybreadsoftware.net/class-cgsizembs.shtml"
		  linksMBS.Value("CGSTransitionMBS")="https://www.monkeybreadsoftware.net/class-cgstransitionmbs.shtml"
		  linksMBS.Value("CGSTransitionRequestMBS")="https://www.monkeybreadsoftware.net/class-cgstransitionrequestmbs.shtml"
		  linksMBS.Value("CGSValueMBS")="https://www.monkeybreadsoftware.net/class-cgsvaluembs.shtml"
		  linksMBS.Value("CGSWindowListMBS")="https://www.monkeybreadsoftware.net/class-cgswindowlistmbs.shtml"
		  linksMBS.Value("CGSWindowMBS")="https://www.monkeybreadsoftware.net/class-cgswindowmbs.shtml"
		  linksMBS.Value("CGSWorkspaceMBS")="https://www.monkeybreadsoftware.net/class-cgsworkspacembs.shtml"
		  linksMBS.Value("Checkbox")="https://www.monkeybreadsoftware.net/class-checkbox.shtml"
		  linksMBS.Value("ChromiumBrowserMBS")="https://www.monkeybreadsoftware.net/class-chromiumbrowsermbs.shtml"
		  linksMBS.Value("ChromiumCookieManagerMBS")="https://www.monkeybreadsoftware.net/class-chromiumcookiemanagermbs.shtml"
		  linksMBS.Value("ChromiumCookieMBS")="https://www.monkeybreadsoftware.net/class-chromiumcookiembs.shtml"
		  linksMBS.Value("ChromiumFrameMBS")="https://www.monkeybreadsoftware.net/class-chromiumframembs.shtml"
		  linksMBS.Value("ChromiumWebPluginInfoMBS")="https://www.monkeybreadsoftware.net/class-chromiumwebplugininfombs.shtml"
		  linksMBS.Value("CIAttributeMBS")="https://www.monkeybreadsoftware.net/class-ciattributembs.shtml"
		  linksMBS.Value("CIAztecCodeDescriptorMBS")="https://www.monkeybreadsoftware.net/class-ciazteccodedescriptormbs.shtml"
		  linksMBS.Value("CIBarcodeDescriptorMBS")="https://www.monkeybreadsoftware.net/class-cibarcodedescriptormbs.shtml"
		  linksMBS.Value("CIColorMBS")="https://www.monkeybreadsoftware.net/class-cicolormbs.shtml"
		  linksMBS.Value("CIContextMBS")="https://www.monkeybreadsoftware.net/class-cicontextmbs.shtml"
		  linksMBS.Value("CIDataMatrixCodeDescriptorMBS")="https://www.monkeybreadsoftware.net/class-cidatamatrixcodedescriptormbs.shtml"
		  linksMBS.Value("CIDetectorMBS")="https://www.monkeybreadsoftware.net/class-cidetectormbs.shtml"
		  linksMBS.Value("CIFaceFeatureMBS")="https://www.monkeybreadsoftware.net/class-cifacefeaturembs.shtml"
		  linksMBS.Value("CIFeatureMBS")="https://www.monkeybreadsoftware.net/class-cifeaturembs.shtml"
		  linksMBS.Value("CIFilterAccordionFoldTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifilteraccordionfoldtransitionmbs.shtml"
		  linksMBS.Value("CIFilterAdditionCompositingMBS")="https://www.monkeybreadsoftware.net/class-cifilteradditioncompositingmbs.shtml"
		  linksMBS.Value("CIFilterAffineClampMBS")="https://www.monkeybreadsoftware.net/class-cifilteraffineclampmbs.shtml"
		  linksMBS.Value("CIFilterAffineTileMBS")="https://www.monkeybreadsoftware.net/class-cifilteraffinetilembs.shtml"
		  linksMBS.Value("CIFilterAffineTransformMBS")="https://www.monkeybreadsoftware.net/class-cifilteraffinetransformmbs.shtml"
		  linksMBS.Value("CIFilterAreaAverageMBS")="https://www.monkeybreadsoftware.net/class-cifilterareaaveragembs.shtml"
		  linksMBS.Value("CIFilterAreaHistogramMBS")="https://www.monkeybreadsoftware.net/class-cifilterareahistogrammbs.shtml"
		  linksMBS.Value("CIFilterAreaMaximumAlphaMBS")="https://www.monkeybreadsoftware.net/class-cifilterareamaximumalphambs.shtml"
		  linksMBS.Value("CIFilterAreaMaximumMBS")="https://www.monkeybreadsoftware.net/class-cifilterareamaximummbs.shtml"
		  linksMBS.Value("CIFilterAreaMinimumAlphaMBS")="https://www.monkeybreadsoftware.net/class-cifilterareaminimumalphambs.shtml"
		  linksMBS.Value("CIFilterAreaMinimumMBS")="https://www.monkeybreadsoftware.net/class-cifilterareaminimummbs.shtml"
		  linksMBS.Value("CIFilterAreaMinMaxMBS")="https://www.monkeybreadsoftware.net/class-cifilterareaminmaxmbs.shtml"
		  linksMBS.Value("CIFilterAreaMinMaxRedMBS")="https://www.monkeybreadsoftware.net/class-cifilterareaminmaxredmbs.shtml"
		  linksMBS.Value("CIFilterAttributedTextImageGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifilterattributedtextimagegeneratormbs.shtml"
		  linksMBS.Value("CIFilterAztecCodeGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifilterazteccodegeneratormbs.shtml"
		  linksMBS.Value("CIFilterBarcodeGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifilterbarcodegeneratormbs.shtml"
		  linksMBS.Value("CIFilterBarsSwipeTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifilterbarsswipetransitionmbs.shtml"
		  linksMBS.Value("CIFilterBicubicScaleTransformMBS")="https://www.monkeybreadsoftware.net/class-cifilterbicubicscaletransformmbs.shtml"
		  linksMBS.Value("CIFilterBlendWithAlphaMaskMBS")="https://www.monkeybreadsoftware.net/class-cifilterblendwithalphamaskmbs.shtml"
		  linksMBS.Value("CIFilterBlendWithBlueMaskMBS")="https://www.monkeybreadsoftware.net/class-cifilterblendwithbluemaskmbs.shtml"
		  linksMBS.Value("CIFilterBlendWithMaskMBS")="https://www.monkeybreadsoftware.net/class-cifilterblendwithmaskmbs.shtml"
		  linksMBS.Value("CIFilterBlendWithRedMaskMBS")="https://www.monkeybreadsoftware.net/class-cifilterblendwithredmaskmbs.shtml"
		  linksMBS.Value("CIFilterBloomMBS")="https://www.monkeybreadsoftware.net/class-cifilterbloommbs.shtml"
		  linksMBS.Value("CIFilterBokehBlurMBS")="https://www.monkeybreadsoftware.net/class-cifilterbokehblurmbs.shtml"
		  linksMBS.Value("CIFilterBoxBlurMBS")="https://www.monkeybreadsoftware.net/class-cifilterboxblurmbs.shtml"
		  linksMBS.Value("CIFilterBumpDistortionLinearMBS")="https://www.monkeybreadsoftware.net/class-cifilterbumpdistortionlinearmbs.shtml"
		  linksMBS.Value("CIFilterBumpDistortionMBS")="https://www.monkeybreadsoftware.net/class-cifilterbumpdistortionmbs.shtml"
		  linksMBS.Value("CIFilterCameraCalibrationLensCorrectionMBS")="https://www.monkeybreadsoftware.net/class-cifiltercameracalibrationlenscorrectionmbs.shtml"
		  linksMBS.Value("CIFilterCheckerboardGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifiltercheckerboardgeneratormbs.shtml"
		  linksMBS.Value("CIFilterCircleSplashDistortionMBS")="https://www.monkeybreadsoftware.net/class-cifiltercirclesplashdistortionmbs.shtml"
		  linksMBS.Value("CIFilterCircularScreenMBS")="https://www.monkeybreadsoftware.net/class-cifiltercircularscreenmbs.shtml"
		  linksMBS.Value("CIFilterCircularWrapMBS")="https://www.monkeybreadsoftware.net/class-cifiltercircularwrapmbs.shtml"
		  linksMBS.Value("CIFilterClampMBS")="https://www.monkeybreadsoftware.net/class-cifilterclampmbs.shtml"
		  linksMBS.Value("CIFilterCMYKHalftoneMBS")="https://www.monkeybreadsoftware.net/class-cifiltercmykhalftonembs.shtml"
		  linksMBS.Value("CIFilterCode128BarcodeGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifiltercode128barcodegeneratormbs.shtml"
		  linksMBS.Value("CIFilterColorBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorblendmodembs.shtml"
		  linksMBS.Value("CIFilterColorBurnBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorburnblendmodembs.shtml"
		  linksMBS.Value("CIFilterColorClampMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorclampmbs.shtml"
		  linksMBS.Value("CIFilterColorControlsMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorcontrolsmbs.shtml"
		  linksMBS.Value("CIFilterColorCrossPolynomialMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorcrosspolynomialmbs.shtml"
		  linksMBS.Value("CIFilterColorCubeMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorcubembs.shtml"
		  linksMBS.Value("CIFilterColorCubesMixedWithMaskMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorcubesmixedwithmaskmbs.shtml"
		  linksMBS.Value("CIFilterColorCubeWithColorSpaceMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorcubewithcolorspacembs.shtml"
		  linksMBS.Value("CIFilterColorCurvesMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorcurvesmbs.shtml"
		  linksMBS.Value("CIFilterColorDodgeBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolordodgeblendmodembs.shtml"
		  linksMBS.Value("CIFilterColorInvertMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorinvertmbs.shtml"
		  linksMBS.Value("CIFilterColorMapMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolormapmbs.shtml"
		  linksMBS.Value("CIFilterColorMatrixMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolormatrixmbs.shtml"
		  linksMBS.Value("CIFilterColorMonochromeMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolormonochromembs.shtml"
		  linksMBS.Value("CIFilterColorPolynomialMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorpolynomialmbs.shtml"
		  linksMBS.Value("CIFilterColorPosterizeMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolorposterizembs.shtml"
		  linksMBS.Value("CIFilterColumnAverageMBS")="https://www.monkeybreadsoftware.net/class-cifiltercolumnaveragembs.shtml"
		  linksMBS.Value("CIFilterComicEffectMBS")="https://www.monkeybreadsoftware.net/class-cifiltercomiceffectmbs.shtml"
		  linksMBS.Value("CIFilterConstantColorGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifilterconstantcolorgeneratormbs.shtml"
		  linksMBS.Value("CIFilterConvolution3X3MBS")="https://www.monkeybreadsoftware.net/class-cifilterconvolution3x3mbs.shtml"
		  linksMBS.Value("CIFilterConvolution5X5MBS")="https://www.monkeybreadsoftware.net/class-cifilterconvolution5x5mbs.shtml"
		  linksMBS.Value("CIFilterConvolution7X7MBS")="https://www.monkeybreadsoftware.net/class-cifilterconvolution7x7mbs.shtml"
		  linksMBS.Value("CIFilterConvolution9HorizontalMBS")="https://www.monkeybreadsoftware.net/class-cifilterconvolution9horizontalmbs.shtml"
		  linksMBS.Value("CIFilterConvolution9VerticalMBS")="https://www.monkeybreadsoftware.net/class-cifilterconvolution9verticalmbs.shtml"
		  linksMBS.Value("CIFilterCopyMachineTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifiltercopymachinetransitionmbs.shtml"
		  linksMBS.Value("CIFilterCropMBS")="https://www.monkeybreadsoftware.net/class-cifiltercropmbs.shtml"
		  linksMBS.Value("CIFilterCrystallizeMBS")="https://www.monkeybreadsoftware.net/class-cifiltercrystallizembs.shtml"
		  linksMBS.Value("CIFilterDarkenBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterdarkenblendmodembs.shtml"
		  linksMBS.Value("CIFilterDepthBlurEffectMBS")="https://www.monkeybreadsoftware.net/class-cifilterdepthblureffectmbs.shtml"
		  linksMBS.Value("CIFilterDepthOfFieldMBS")="https://www.monkeybreadsoftware.net/class-cifilterdepthoffieldmbs.shtml"
		  linksMBS.Value("CIFilterDepthToDisparityMBS")="https://www.monkeybreadsoftware.net/class-cifilterdepthtodisparitymbs.shtml"
		  linksMBS.Value("CIFilterDifferenceBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterdifferenceblendmodembs.shtml"
		  linksMBS.Value("CIFilterDiscBlurMBS")="https://www.monkeybreadsoftware.net/class-cifilterdiscblurmbs.shtml"
		  linksMBS.Value("CIFilterDisintegrateWithMaskTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifilterdisintegratewithmasktransitionmbs.shtml"
		  linksMBS.Value("CIFilterDisparityToDepthMBS")="https://www.monkeybreadsoftware.net/class-cifilterdisparitytodepthmbs.shtml"
		  linksMBS.Value("CIFilterDisplacementDistortionMBS")="https://www.monkeybreadsoftware.net/class-cifilterdisplacementdistortionmbs.shtml"
		  linksMBS.Value("CIFilterDissolveTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifilterdissolvetransitionmbs.shtml"
		  linksMBS.Value("CIFilterDitherMBS")="https://www.monkeybreadsoftware.net/class-cifilterdithermbs.shtml"
		  linksMBS.Value("CIFilterDivideBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterdivideblendmodembs.shtml"
		  linksMBS.Value("CIFilterDotScreenMBS")="https://www.monkeybreadsoftware.net/class-cifilterdotscreenmbs.shtml"
		  linksMBS.Value("CIFilterDrosteMBS")="https://www.monkeybreadsoftware.net/class-cifilterdrostembs.shtml"
		  linksMBS.Value("CIFilterEdgePreserveUpsampleFilterMBS")="https://www.monkeybreadsoftware.net/class-cifilteredgepreserveupsamplefiltermbs.shtml"
		  linksMBS.Value("CIFilterEdgesMBS")="https://www.monkeybreadsoftware.net/class-cifilteredgesmbs.shtml"
		  linksMBS.Value("CIFilterEdgeWorkMBS")="https://www.monkeybreadsoftware.net/class-cifilteredgeworkmbs.shtml"
		  linksMBS.Value("CIFilterEightfoldReflectedTileMBS")="https://www.monkeybreadsoftware.net/class-cifiltereightfoldreflectedtilembs.shtml"
		  linksMBS.Value("CIFilterExclusionBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterexclusionblendmodembs.shtml"
		  linksMBS.Value("CIFilterExposureAdjustMBS")="https://www.monkeybreadsoftware.net/class-cifilterexposureadjustmbs.shtml"
		  linksMBS.Value("CIFilterFalseColorMBS")="https://www.monkeybreadsoftware.net/class-cifilterfalsecolormbs.shtml"
		  linksMBS.Value("CIFilterFlashTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifilterflashtransitionmbs.shtml"
		  linksMBS.Value("CIFilterFourfoldReflectedTileMBS")="https://www.monkeybreadsoftware.net/class-cifilterfourfoldreflectedtilembs.shtml"
		  linksMBS.Value("CIFilterFourfoldRotatedTileMBS")="https://www.monkeybreadsoftware.net/class-cifilterfourfoldrotatedtilembs.shtml"
		  linksMBS.Value("CIFilterFourfoldTranslatedTileMBS")="https://www.monkeybreadsoftware.net/class-cifilterfourfoldtranslatedtilembs.shtml"
		  linksMBS.Value("CIFilterGammaAdjustMBS")="https://www.monkeybreadsoftware.net/class-cifiltergammaadjustmbs.shtml"
		  linksMBS.Value("CIFilterGaussianBlurMBS")="https://www.monkeybreadsoftware.net/class-cifiltergaussianblurmbs.shtml"
		  linksMBS.Value("CIFilterGaussianGradientMBS")="https://www.monkeybreadsoftware.net/class-cifiltergaussiangradientmbs.shtml"
		  linksMBS.Value("CIFilterGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifiltergeneratormbs.shtml"
		  linksMBS.Value("CIFilterGlassDistortionMBS")="https://www.monkeybreadsoftware.net/class-cifilterglassdistortionmbs.shtml"
		  linksMBS.Value("CIFilterGlassLozengeMBS")="https://www.monkeybreadsoftware.net/class-cifilterglasslozengembs.shtml"
		  linksMBS.Value("CIFilterGlideReflectedTileMBS")="https://www.monkeybreadsoftware.net/class-cifilterglidereflectedtilembs.shtml"
		  linksMBS.Value("CIFilterGloomMBS")="https://www.monkeybreadsoftware.net/class-cifiltergloommbs.shtml"
		  linksMBS.Value("CIFilterGuidedFilterMBS")="https://www.monkeybreadsoftware.net/class-cifilterguidedfiltermbs.shtml"
		  linksMBS.Value("CIFilterHardLightBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterhardlightblendmodembs.shtml"
		  linksMBS.Value("CIFilterHatchedScreenMBS")="https://www.monkeybreadsoftware.net/class-cifilterhatchedscreenmbs.shtml"
		  linksMBS.Value("CIFilterHeightFieldFromMaskMBS")="https://www.monkeybreadsoftware.net/class-cifilterheightfieldfrommaskmbs.shtml"
		  linksMBS.Value("CIFilterHexagonalPixellateMBS")="https://www.monkeybreadsoftware.net/class-cifilterhexagonalpixellatembs.shtml"
		  linksMBS.Value("CIFilterHighlightShadowAdjustMBS")="https://www.monkeybreadsoftware.net/class-cifilterhighlightshadowadjustmbs.shtml"
		  linksMBS.Value("CIFilterHistogramDisplayFilterMBS")="https://www.monkeybreadsoftware.net/class-cifilterhistogramdisplayfiltermbs.shtml"
		  linksMBS.Value("CIFilterHoleDistortionMBS")="https://www.monkeybreadsoftware.net/class-cifilterholedistortionmbs.shtml"
		  linksMBS.Value("CIFilterHueAdjustMBS")="https://www.monkeybreadsoftware.net/class-cifilterhueadjustmbs.shtml"
		  linksMBS.Value("CIFilterHueBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterhueblendmodembs.shtml"
		  linksMBS.Value("CIFilterHueSaturationValueGradientMBS")="https://www.monkeybreadsoftware.net/class-cifilterhuesaturationvaluegradientmbs.shtml"
		  linksMBS.Value("CIFilterKaleidoscopeMBS")="https://www.monkeybreadsoftware.net/class-cifilterkaleidoscopembs.shtml"
		  linksMBS.Value("CIFilterLabDeltaEMBS")="https://www.monkeybreadsoftware.net/class-cifilterlabdeltaembs.shtml"
		  linksMBS.Value("CIFilterLanczosScaleTransformMBS")="https://www.monkeybreadsoftware.net/class-cifilterlanczosscaletransformmbs.shtml"
		  linksMBS.Value("CIFilterLenticularHaloGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifilterlenticularhalogeneratormbs.shtml"
		  linksMBS.Value("CIFilterLightenBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterlightenblendmodembs.shtml"
		  linksMBS.Value("CIFilterLightTunnelMBS")="https://www.monkeybreadsoftware.net/class-cifilterlighttunnelmbs.shtml"
		  linksMBS.Value("CIFilterLinearBurnBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterlinearburnblendmodembs.shtml"
		  linksMBS.Value("CIFilterLinearDodgeBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterlineardodgeblendmodembs.shtml"
		  linksMBS.Value("CIFilterLinearGradientMBS")="https://www.monkeybreadsoftware.net/class-cifilterlineargradientmbs.shtml"
		  linksMBS.Value("CIFilterLinearToSRGBToneCurveMBS")="https://www.monkeybreadsoftware.net/class-cifilterlineartosrgbtonecurvembs.shtml"
		  linksMBS.Value("CIFilterLineOverlayMBS")="https://www.monkeybreadsoftware.net/class-cifilterlineoverlaymbs.shtml"
		  linksMBS.Value("CIFilterLineScreenMBS")="https://www.monkeybreadsoftware.net/class-cifilterlinescreenmbs.shtml"
		  linksMBS.Value("CIFilterLuminosityBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterluminosityblendmodembs.shtml"
		  linksMBS.Value("CIFilterMaskedVariableBlurMBS")="https://www.monkeybreadsoftware.net/class-cifiltermaskedvariableblurmbs.shtml"
		  linksMBS.Value("CIFilterMaskToAlphaMBS")="https://www.monkeybreadsoftware.net/class-cifiltermasktoalphambs.shtml"
		  linksMBS.Value("CIFilterMaximumComponentMBS")="https://www.monkeybreadsoftware.net/class-cifiltermaximumcomponentmbs.shtml"
		  linksMBS.Value("CIFilterMaximumCompositingMBS")="https://www.monkeybreadsoftware.net/class-cifiltermaximumcompositingmbs.shtml"
		  linksMBS.Value("CIFilterMBS")="https://www.monkeybreadsoftware.net/class-cifiltermbs.shtml"
		  linksMBS.Value("CIFilterMedianFilterMBS")="https://www.monkeybreadsoftware.net/class-cifiltermedianfiltermbs.shtml"
		  linksMBS.Value("CIFilterMeshGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifiltermeshgeneratormbs.shtml"
		  linksMBS.Value("CIFilterMinimumComponentMBS")="https://www.monkeybreadsoftware.net/class-cifilterminimumcomponentmbs.shtml"
		  linksMBS.Value("CIFilterMinimumCompositingMBS")="https://www.monkeybreadsoftware.net/class-cifilterminimumcompositingmbs.shtml"
		  linksMBS.Value("CIFilterMixMBS")="https://www.monkeybreadsoftware.net/class-cifiltermixmbs.shtml"
		  linksMBS.Value("CIFilterModTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifiltermodtransitionmbs.shtml"
		  linksMBS.Value("CIFilterMorphologyGradientMBS")="https://www.monkeybreadsoftware.net/class-cifiltermorphologygradientmbs.shtml"
		  linksMBS.Value("CIFilterMorphologyMaximumMBS")="https://www.monkeybreadsoftware.net/class-cifiltermorphologymaximummbs.shtml"
		  linksMBS.Value("CIFilterMorphologyMinimumMBS")="https://www.monkeybreadsoftware.net/class-cifiltermorphologyminimummbs.shtml"
		  linksMBS.Value("CIFilterMotionBlurMBS")="https://www.monkeybreadsoftware.net/class-cifiltermotionblurmbs.shtml"
		  linksMBS.Value("CIFilterMultiplyBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifiltermultiplyblendmodembs.shtml"
		  linksMBS.Value("CIFilterMultiplyCompositingMBS")="https://www.monkeybreadsoftware.net/class-cifiltermultiplycompositingmbs.shtml"
		  linksMBS.Value("CIFilterNinePartStretchedMBS")="https://www.monkeybreadsoftware.net/class-cifilterninepartstretchedmbs.shtml"
		  linksMBS.Value("CIFilterNinePartTiledMBS")="https://www.monkeybreadsoftware.net/class-cifilternineparttiledmbs.shtml"
		  linksMBS.Value("CIFilterNoiseReductionMBS")="https://www.monkeybreadsoftware.net/class-cifilternoisereductionmbs.shtml"
		  linksMBS.Value("CIFilterOpTileMBS")="https://www.monkeybreadsoftware.net/class-cifilteroptilembs.shtml"
		  linksMBS.Value("CIFilterOverlayBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilteroverlayblendmodembs.shtml"
		  linksMBS.Value("CIFilterPageCurlTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifilterpagecurltransitionmbs.shtml"
		  linksMBS.Value("CIFilterPageCurlWithShadowTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifilterpagecurlwithshadowtransitionmbs.shtml"
		  linksMBS.Value("CIFilterParallelogramTileMBS")="https://www.monkeybreadsoftware.net/class-cifilterparallelogramtilembs.shtml"
		  linksMBS.Value("CIFilterPDF417BarcodeGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifilterpdf417barcodegeneratormbs.shtml"
		  linksMBS.Value("CIFilterPerspectiveCorrectionMBS")="https://www.monkeybreadsoftware.net/class-cifilterperspectivecorrectionmbs.shtml"
		  linksMBS.Value("CIFilterPerspectiveTileMBS")="https://www.monkeybreadsoftware.net/class-cifilterperspectivetilembs.shtml"
		  linksMBS.Value("CIFilterPerspectiveTransformMBS")="https://www.monkeybreadsoftware.net/class-cifilterperspectivetransformmbs.shtml"
		  linksMBS.Value("CIFilterPerspectiveTransformWithExtentMBS")="https://www.monkeybreadsoftware.net/class-cifilterperspectivetransformwithextentmbs.shtml"
		  linksMBS.Value("CIFilterPhotoEffectChromeMBS")="https://www.monkeybreadsoftware.net/class-cifilterphotoeffectchromembs.shtml"
		  linksMBS.Value("CIFilterPhotoEffectFadeMBS")="https://www.monkeybreadsoftware.net/class-cifilterphotoeffectfadembs.shtml"
		  linksMBS.Value("CIFilterPhotoEffectInstantMBS")="https://www.monkeybreadsoftware.net/class-cifilterphotoeffectinstantmbs.shtml"
		  linksMBS.Value("CIFilterPhotoEffectMonoMBS")="https://www.monkeybreadsoftware.net/class-cifilterphotoeffectmonombs.shtml"
		  linksMBS.Value("CIFilterPhotoEffectNoirMBS")="https://www.monkeybreadsoftware.net/class-cifilterphotoeffectnoirmbs.shtml"
		  linksMBS.Value("CIFilterPhotoEffectProcessMBS")="https://www.monkeybreadsoftware.net/class-cifilterphotoeffectprocessmbs.shtml"
		  linksMBS.Value("CIFilterPhotoEffectTonalMBS")="https://www.monkeybreadsoftware.net/class-cifilterphotoeffecttonalmbs.shtml"
		  linksMBS.Value("CIFilterPhotoEffectTransferMBS")="https://www.monkeybreadsoftware.net/class-cifilterphotoeffecttransfermbs.shtml"
		  linksMBS.Value("CIFilterPinchDistortionMBS")="https://www.monkeybreadsoftware.net/class-cifilterpinchdistortionmbs.shtml"
		  linksMBS.Value("CIFilterPinLightBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterpinlightblendmodembs.shtml"
		  linksMBS.Value("CIFilterPixellateMBS")="https://www.monkeybreadsoftware.net/class-cifilterpixellatembs.shtml"
		  linksMBS.Value("CIFilterPointillizeMBS")="https://www.monkeybreadsoftware.net/class-cifilterpointillizembs.shtml"
		  linksMBS.Value("CIFilterQRCodeGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifilterqrcodegeneratormbs.shtml"
		  linksMBS.Value("CIFilterRadialGradientMBS")="https://www.monkeybreadsoftware.net/class-cifilterradialgradientmbs.shtml"
		  linksMBS.Value("CIFilterRandomGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifilterrandomgeneratormbs.shtml"
		  linksMBS.Value("CIFilterRippleTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifilterrippletransitionmbs.shtml"
		  linksMBS.Value("CIFilterRowAverageMBS")="https://www.monkeybreadsoftware.net/class-cifilterrowaveragembs.shtml"
		  linksMBS.Value("CIFilterSampleNearestMBS")="https://www.monkeybreadsoftware.net/class-cifiltersamplenearestmbs.shtml"
		  linksMBS.Value("CIFilterSaturationBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifiltersaturationblendmodembs.shtml"
		  linksMBS.Value("CIFilterScreenBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifilterscreenblendmodembs.shtml"
		  linksMBS.Value("CIFilterSepiaToneMBS")="https://www.monkeybreadsoftware.net/class-cifiltersepiatonembs.shtml"
		  linksMBS.Value("CIFilterShadedMaterialMBS")="https://www.monkeybreadsoftware.net/class-cifiltershadedmaterialmbs.shtml"
		  linksMBS.Value("CIFilterShapeMBS")="https://www.monkeybreadsoftware.net/class-cifiltershapembs.shtml"
		  linksMBS.Value("CIFilterSharpenLuminanceMBS")="https://www.monkeybreadsoftware.net/class-cifiltersharpenluminancembs.shtml"
		  linksMBS.Value("CIFilterSixfoldReflectedTileMBS")="https://www.monkeybreadsoftware.net/class-cifiltersixfoldreflectedtilembs.shtml"
		  linksMBS.Value("CIFilterSixfoldRotatedTileMBS")="https://www.monkeybreadsoftware.net/class-cifiltersixfoldrotatedtilembs.shtml"
		  linksMBS.Value("CIFilterSmoothLinearGradientMBS")="https://www.monkeybreadsoftware.net/class-cifiltersmoothlineargradientmbs.shtml"
		  linksMBS.Value("CIFilterSoftLightBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifiltersoftlightblendmodembs.shtml"
		  linksMBS.Value("CIFilterSourceAtopCompositingMBS")="https://www.monkeybreadsoftware.net/class-cifiltersourceatopcompositingmbs.shtml"
		  linksMBS.Value("CIFilterSourceInCompositingMBS")="https://www.monkeybreadsoftware.net/class-cifiltersourceincompositingmbs.shtml"
		  linksMBS.Value("CIFilterSourceOutCompositingMBS")="https://www.monkeybreadsoftware.net/class-cifiltersourceoutcompositingmbs.shtml"
		  linksMBS.Value("CIFilterSourceOverCompositingMBS")="https://www.monkeybreadsoftware.net/class-cifiltersourceovercompositingmbs.shtml"
		  linksMBS.Value("CIFilterSpotColorMBS")="https://www.monkeybreadsoftware.net/class-cifilterspotcolormbs.shtml"
		  linksMBS.Value("CIFilterSpotLightMBS")="https://www.monkeybreadsoftware.net/class-cifilterspotlightmbs.shtml"
		  linksMBS.Value("CIFilterSRGBToneCurveToLinearMBS")="https://www.monkeybreadsoftware.net/class-cifiltersrgbtonecurvetolinearmbs.shtml"
		  linksMBS.Value("CIFilterStarShineGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifilterstarshinegeneratormbs.shtml"
		  linksMBS.Value("CIFilterStraightenFilterMBS")="https://www.monkeybreadsoftware.net/class-cifilterstraightenfiltermbs.shtml"
		  linksMBS.Value("CIFilterStretchCropMBS")="https://www.monkeybreadsoftware.net/class-cifilterstretchcropmbs.shtml"
		  linksMBS.Value("CIFilterStripesGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifilterstripesgeneratormbs.shtml"
		  linksMBS.Value("CIFilterSubtractBlendModeMBS")="https://www.monkeybreadsoftware.net/class-cifiltersubtractblendmodembs.shtml"
		  linksMBS.Value("CIFilterSunbeamsGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifiltersunbeamsgeneratormbs.shtml"
		  linksMBS.Value("CIFilterSwipeTransitionMBS")="https://www.monkeybreadsoftware.net/class-cifilterswipetransitionmbs.shtml"
		  linksMBS.Value("CIFilterTemperatureAndTintMBS")="https://www.monkeybreadsoftware.net/class-cifiltertemperatureandtintmbs.shtml"
		  linksMBS.Value("CIFilterTextImageGeneratorMBS")="https://www.monkeybreadsoftware.net/class-cifiltertextimagegeneratormbs.shtml"
		  linksMBS.Value("CIFilterThermalMBS")="https://www.monkeybreadsoftware.net/class-cifilterthermalmbs.shtml"
		  linksMBS.Value("CIFilterToneCurveMBS")="https://www.monkeybreadsoftware.net/class-cifiltertonecurvembs.shtml"
		  linksMBS.Value("CIFilterTorusLensDistortionMBS")="https://www.monkeybreadsoftware.net/class-cifiltertoruslensdistortionmbs.shtml"
		  linksMBS.Value("CIFilterTriangleKaleidoscopeMBS")="https://www.monkeybreadsoftware.net/class-cifiltertrianglekaleidoscopembs.shtml"
		  linksMBS.Value("CIFilterTriangleTileMBS")="https://www.monkeybreadsoftware.net/class-cifiltertriangletilembs.shtml"
		  linksMBS.Value("CIFilterTwelvefoldReflectedTileMBS")="https://www.monkeybreadsoftware.net/class-cifiltertwelvefoldreflectedtilembs.shtml"
		  linksMBS.Value("CIFilterTwirlDistortionMBS")="https://www.monkeybreadsoftware.net/class-cifiltertwirldistortionmbs.shtml"
		  linksMBS.Value("CIFilterUnsharpMaskMBS")="https://www.monkeybreadsoftware.net/class-cifilterunsharpmaskmbs.shtml"
		  linksMBS.Value("CIFilterVibranceMBS")="https://www.monkeybreadsoftware.net/class-cifiltervibrancembs.shtml"
		  linksMBS.Value("CIFilterVignetteEffectMBS")="https://www.monkeybreadsoftware.net/class-cifiltervignetteeffectmbs.shtml"
		  linksMBS.Value("CIFilterVignetteMBS")="https://www.monkeybreadsoftware.net/class-cifiltervignettembs.shtml"
		  linksMBS.Value("CIFilterVortexDistortionMBS")="https://www.monkeybreadsoftware.net/class-cifiltervortexdistortionmbs.shtml"
		  linksMBS.Value("CIFilterWhitePointAdjustMBS")="https://www.monkeybreadsoftware.net/class-cifilterwhitepointadjustmbs.shtml"
		  linksMBS.Value("CIFilterXRayMBS")="https://www.monkeybreadsoftware.net/class-cifilterxraymbs.shtml"
		  linksMBS.Value("CIFilterZoomBlurMBS")="https://www.monkeybreadsoftware.net/class-cifilterzoomblurmbs.shtml"
		  linksMBS.Value("CIImageMBS")="https://www.monkeybreadsoftware.net/class-ciimagembs.shtml"
		  linksMBS.Value("CIPDF417CodeDescriptorMBS")="https://www.monkeybreadsoftware.net/class-cipdf417codedescriptormbs.shtml"
		  linksMBS.Value("CipherMBS")="https://www.monkeybreadsoftware.net/class-ciphermbs.shtml"
		  linksMBS.Value("CIQRCodeDescriptorMBS")="https://www.monkeybreadsoftware.net/class-ciqrcodedescriptormbs.shtml"
		  linksMBS.Value("CIQRCodeFeatureMBS")="https://www.monkeybreadsoftware.net/class-ciqrcodefeaturembs.shtml"
		  linksMBS.Value("CIRectangleFeatureMBS")="https://www.monkeybreadsoftware.net/class-cirectanglefeaturembs.shtml"
		  linksMBS.Value("CISamplerMBS")="https://www.monkeybreadsoftware.net/class-cisamplermbs.shtml"
		  linksMBS.Value("CITextFeatureMBS")="https://www.monkeybreadsoftware.net/class-citextfeaturembs.shtml"
		  linksMBS.Value("CIVectorMBS")="https://www.monkeybreadsoftware.net/class-civectormbs.shtml"
		  linksMBS.Value("CKAcceptSharesOperationMBS")="https://www.monkeybreadsoftware.net/class-ckacceptsharesoperationmbs.shtml"
		  linksMBS.Value("CKAssetMBS")="https://www.monkeybreadsoftware.net/class-ckassetmbs.shtml"
		  linksMBS.Value("CKContainerMBS")="https://www.monkeybreadsoftware.net/class-ckcontainermbs.shtml"
		  linksMBS.Value("CKDatabaseMBS")="https://www.monkeybreadsoftware.net/class-ckdatabasembs.shtml"
		  linksMBS.Value("CKDatabaseNotificationMBS")="https://www.monkeybreadsoftware.net/class-ckdatabasenotificationmbs.shtml"
		  linksMBS.Value("CKDatabaseOperationMBS")="https://www.monkeybreadsoftware.net/class-ckdatabaseoperationmbs.shtml"
		  linksMBS.Value("CKDatabaseSubscriptionMBS")="https://www.monkeybreadsoftware.net/class-ckdatabasesubscriptionmbs.shtml"
		  linksMBS.Value("CKDiscoverAllUserIdentitiesOperationMBS")="https://www.monkeybreadsoftware.net/class-ckdiscoveralluseridentitiesoperationmbs.shtml"
		  linksMBS.Value("CKDiscoverUserIdentitiesOperationMBS")="https://www.monkeybreadsoftware.net/class-ckdiscoveruseridentitiesoperationmbs.shtml"
		  linksMBS.Value("CKFetchDatabaseChangesOperationMBS")="https://www.monkeybreadsoftware.net/class-ckfetchdatabasechangesoperationmbs.shtml"
		  linksMBS.Value("CKFetchNotificationChangesOperationMBS")="https://www.monkeybreadsoftware.net/class-ckfetchnotificationchangesoperationmbs.shtml"
		  linksMBS.Value("CKFetchRecordChangesOperationMBS")="https://www.monkeybreadsoftware.net/class-ckfetchrecordchangesoperationmbs.shtml"
		  linksMBS.Value("CKFetchRecordsOperationMBS")="https://www.monkeybreadsoftware.net/class-ckfetchrecordsoperationmbs.shtml"
		  linksMBS.Value("CKFetchRecordZoneChangesOperationMBS")="https://www.monkeybreadsoftware.net/class-ckfetchrecordzonechangesoperationmbs.shtml"
		  linksMBS.Value("CKFetchRecordZoneChangesOptionsMBS")="https://www.monkeybreadsoftware.net/class-ckfetchrecordzonechangesoptionsmbs.shtml"
		  linksMBS.Value("CKFetchRecordZonesOperationMBS")="https://www.monkeybreadsoftware.net/class-ckfetchrecordzonesoperationmbs.shtml"
		  linksMBS.Value("CKFetchShareMetadataOperationMBS")="https://www.monkeybreadsoftware.net/class-ckfetchsharemetadataoperationmbs.shtml"
		  linksMBS.Value("CKFetchShareParticipantsOperationMBS")="https://www.monkeybreadsoftware.net/class-ckfetchshareparticipantsoperationmbs.shtml"
		  linksMBS.Value("CKFetchSubscriptionsOperationMBS")="https://www.monkeybreadsoftware.net/class-ckfetchsubscriptionsoperationmbs.shtml"
		  linksMBS.Value("CKFetchWebAuthTokenOperationMBS")="https://www.monkeybreadsoftware.net/class-ckfetchwebauthtokenoperationmbs.shtml"
		  linksMBS.Value("CKLocationSortDescriptorMBS")="https://www.monkeybreadsoftware.net/class-cklocationsortdescriptormbs.shtml"
		  linksMBS.Value("CKMarkNotificationsReadOperationMBS")="https://www.monkeybreadsoftware.net/class-ckmarknotificationsreadoperationmbs.shtml"
		  linksMBS.Value("CKModifyBadgeOperationMBS")="https://www.monkeybreadsoftware.net/class-ckmodifybadgeoperationmbs.shtml"
		  linksMBS.Value("CKModifyRecordsOperationMBS")="https://www.monkeybreadsoftware.net/class-ckmodifyrecordsoperationmbs.shtml"
		  linksMBS.Value("CKModifyRecordZonesOperationMBS")="https://www.monkeybreadsoftware.net/class-ckmodifyrecordzonesoperationmbs.shtml"
		  linksMBS.Value("CKModifySubscriptionsOperationMBS")="https://www.monkeybreadsoftware.net/class-ckmodifysubscriptionsoperationmbs.shtml"
		  linksMBS.Value("CKNotificationIDMBS")="https://www.monkeybreadsoftware.net/class-cknotificationidmbs.shtml"
		  linksMBS.Value("CKNotificationInfoMBS")="https://www.monkeybreadsoftware.net/class-cknotificationinfombs.shtml"
		  linksMBS.Value("CKNotificationMBS")="https://www.monkeybreadsoftware.net/class-cknotificationmbs.shtml"
		  linksMBS.Value("CKOperationConfigurationMBS")="https://www.monkeybreadsoftware.net/class-ckoperationconfigurationmbs.shtml"
		  linksMBS.Value("CKOperationMBS")="https://www.monkeybreadsoftware.net/class-ckoperationmbs.shtml"
		  linksMBS.Value("CKQueryCursorMBS")="https://www.monkeybreadsoftware.net/class-ckquerycursormbs.shtml"
		  linksMBS.Value("CKQueryMBS")="https://www.monkeybreadsoftware.net/class-ckquerymbs.shtml"
		  linksMBS.Value("CKQueryNotificationMBS")="https://www.monkeybreadsoftware.net/class-ckquerynotificationmbs.shtml"
		  linksMBS.Value("CKQueryOperationMBS")="https://www.monkeybreadsoftware.net/class-ckqueryoperationmbs.shtml"
		  linksMBS.Value("CKQuerySubscriptionMBS")="https://www.monkeybreadsoftware.net/class-ckquerysubscriptionmbs.shtml"
		  linksMBS.Value("CKRecordIDMBS")="https://www.monkeybreadsoftware.net/class-ckrecordidmbs.shtml"
		  linksMBS.Value("CKRecordMBS")="https://www.monkeybreadsoftware.net/class-ckrecordmbs.shtml"
		  linksMBS.Value("CKRecordZoneIDMBS")="https://www.monkeybreadsoftware.net/class-ckrecordzoneidmbs.shtml"
		  linksMBS.Value("CKRecordZoneMBS")="https://www.monkeybreadsoftware.net/class-ckrecordzonembs.shtml"
		  linksMBS.Value("CKRecordZoneNotificationMBS")="https://www.monkeybreadsoftware.net/class-ckrecordzonenotificationmbs.shtml"
		  linksMBS.Value("CKRecordZoneSubscriptionMBS")="https://www.monkeybreadsoftware.net/class-ckrecordzonesubscriptionmbs.shtml"
		  linksMBS.Value("CKReferenceMBS")="https://www.monkeybreadsoftware.net/class-ckreferencembs.shtml"
		  linksMBS.Value("CKServerChangeTokenMBS")="https://www.monkeybreadsoftware.net/class-ckserverchangetokenmbs.shtml"
		  linksMBS.Value("CKShareMBS")="https://www.monkeybreadsoftware.net/class-cksharembs.shtml"
		  linksMBS.Value("CKShareMetadataMBS")="https://www.monkeybreadsoftware.net/class-cksharemetadatambs.shtml"
		  linksMBS.Value("CKShareParticipantMBS")="https://www.monkeybreadsoftware.net/class-ckshareparticipantmbs.shtml"
		  linksMBS.Value("CKSubscriptionMBS")="https://www.monkeybreadsoftware.net/class-cksubscriptionmbs.shtml"
		  linksMBS.Value("CKUserIdentityLookupInfoMBS")="https://www.monkeybreadsoftware.net/class-ckuseridentitylookupinfombs.shtml"
		  linksMBS.Value("CKUserIdentityMBS")="https://www.monkeybreadsoftware.net/class-ckuseridentitymbs.shtml"
		  linksMBS.Value("CLCommandQueueMBS")="https://www.monkeybreadsoftware.net/class-clcommandqueuembs.shtml"
		  linksMBS.Value("CLContextMBS")="https://www.monkeybreadsoftware.net/class-clcontextmbs.shtml"
		  linksMBS.Value("CLDeviceMBS")="https://www.monkeybreadsoftware.net/class-cldevicembs.shtml"
		  linksMBS.Value("CLEventMBS")="https://www.monkeybreadsoftware.net/class-cleventmbs.shtml"
		  linksMBS.Value("CLGeocodeCompletionHandlerMBS")="https://www.monkeybreadsoftware.net/class-clgeocodecompletionhandlermbs.shtml"
		  linksMBS.Value("CLGeocoderMBS")="https://www.monkeybreadsoftware.net/class-clgeocodermbs.shtml"
		  linksMBS.Value("CLHeadingMBS")="https://www.monkeybreadsoftware.net/class-clheadingmbs.shtml"
		  linksMBS.Value("CLImageFormatMBS")="https://www.monkeybreadsoftware.net/class-climageformatmbs.shtml"
		  linksMBS.Value("ClipboardMBS")="https://www.monkeybreadsoftware.net/class-clipboardmbs.shtml"
		  linksMBS.Value("ClipperEngineMBS")="https://www.monkeybreadsoftware.net/class-clipperenginembs.shtml"
		  linksMBS.Value("ClipperExceptionMBS")="https://www.monkeybreadsoftware.net/class-clipperexceptionmbs.shtml"
		  linksMBS.Value("ClipperOffsetMBS")="https://www.monkeybreadsoftware.net/class-clipperoffsetmbs.shtml"
		  linksMBS.Value("ClipperPathMBS")="https://www.monkeybreadsoftware.net/class-clipperpathmbs.shtml"
		  linksMBS.Value("ClipperPathsMBS")="https://www.monkeybreadsoftware.net/class-clipperpathsmbs.shtml"
		  linksMBS.Value("ClipperPointMBS")="https://www.monkeybreadsoftware.net/class-clipperpointmbs.shtml"
		  linksMBS.Value("ClipperPolyNodeMBS")="https://www.monkeybreadsoftware.net/class-clipperpolynodembs.shtml"
		  linksMBS.Value("ClipperPolyNodesMBS")="https://www.monkeybreadsoftware.net/class-clipperpolynodesmbs.shtml"
		  linksMBS.Value("ClipperPolyTreeMBS")="https://www.monkeybreadsoftware.net/class-clipperpolytreembs.shtml"
		  linksMBS.Value("CLKernelMBS")="https://www.monkeybreadsoftware.net/class-clkernelmbs.shtml"
		  linksMBS.Value("CLLocationCoordinate2DMBS")="https://www.monkeybreadsoftware.net/class-cllocationcoordinate2dmbs.shtml"
		  linksMBS.Value("CLLocationManagerMBS")="https://www.monkeybreadsoftware.net/class-cllocationmanagermbs.shtml"
		  linksMBS.Value("CLLocationMBS")="https://www.monkeybreadsoftware.net/class-cllocationmbs.shtml"
		  linksMBS.Value("CLMemMBS")="https://www.monkeybreadsoftware.net/class-clmemmbs.shtml"
		  linksMBS.Value("CLPlacemarkMBS")="https://www.monkeybreadsoftware.net/class-clplacemarkmbs.shtml"
		  linksMBS.Value("CLPlatformMBS")="https://www.monkeybreadsoftware.net/class-clplatformmbs.shtml"
		  linksMBS.Value("CLProgramMBS")="https://www.monkeybreadsoftware.net/class-clprogrammbs.shtml"
		  linksMBS.Value("CLRegionMBS")="https://www.monkeybreadsoftware.net/class-clregionmbs.shtml"
		  linksMBS.Value("CLSamplerMBS")="https://www.monkeybreadsoftware.net/class-clsamplermbs.shtml"
		  linksMBS.Value("CMFormatDescriptionMBS")="https://www.monkeybreadsoftware.net/class-cmformatdescriptionmbs.shtml"
		  linksMBS.Value("CMSampleBufferMBS")="https://www.monkeybreadsoftware.net/class-cmsamplebuffermbs.shtml"
		  linksMBS.Value("CMTimeMappingMBS")="https://www.monkeybreadsoftware.net/class-cmtimemappingmbs.shtml"
		  linksMBS.Value("CMTimeMBS")="https://www.monkeybreadsoftware.net/class-cmtimembs.shtml"
		  linksMBS.Value("CMTimeRangeMBS")="https://www.monkeybreadsoftware.net/class-cmtimerangembs.shtml"
		  linksMBS.Value("CNChangeHistoryAddContactEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistoryaddcontacteventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryAddGroupEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistoryaddgroupeventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryAddMemberToGroupEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistoryaddmembertogroupeventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryAddSubgroupToGroupEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistoryaddsubgrouptogroupeventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryDeleteContactEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistorydeletecontacteventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryDeleteGroupEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistorydeletegroupeventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryDropEverythingEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistorydropeverythingeventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistoryeventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryFetchRequestMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistoryfetchrequestmbs.shtml"
		  linksMBS.Value("CNChangeHistoryRemoveMemberFromGroupEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistoryremovememberfromgroupeventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryRemoveSubgroupFromGroupEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistoryremovesubgroupfromgroupeventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryUpdateContactEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistoryupdatecontacteventmbs.shtml"
		  linksMBS.Value("CNChangeHistoryUpdateGroupEventMBS")="https://www.monkeybreadsoftware.net/class-cnchangehistoryupdategroupeventmbs.shtml"
		  linksMBS.Value("CNContactFetchRequestMBS")="https://www.monkeybreadsoftware.net/class-cncontactfetchrequestmbs.shtml"
		  linksMBS.Value("CNContactFormatterMBS")="https://www.monkeybreadsoftware.net/class-cncontactformattermbs.shtml"
		  linksMBS.Value("CNContactMBS")="https://www.monkeybreadsoftware.net/class-cncontactmbs.shtml"
		  linksMBS.Value("CNContactPickerMBS")="https://www.monkeybreadsoftware.net/class-cncontactpickermbs.shtml"
		  linksMBS.Value("CNContactPickerViewControllerMBS")="https://www.monkeybreadsoftware.net/class-cncontactpickerviewcontrollermbs.shtml"
		  linksMBS.Value("CNContactPropertyMBS")="https://www.monkeybreadsoftware.net/class-cncontactpropertymbs.shtml"
		  linksMBS.Value("CNContactRelationMBS")="https://www.monkeybreadsoftware.net/class-cncontactrelationmbs.shtml"
		  linksMBS.Value("CNContactStoreMBS")="https://www.monkeybreadsoftware.net/class-cncontactstorembs.shtml"
		  linksMBS.Value("CNContactsUserDefaultsMBS")="https://www.monkeybreadsoftware.net/class-cncontactsuserdefaultsmbs.shtml"
		  linksMBS.Value("CNContactVCardSerializationMBS")="https://www.monkeybreadsoftware.net/class-cncontactvcardserializationmbs.shtml"
		  linksMBS.Value("CNContactViewControllerMBS")="https://www.monkeybreadsoftware.net/class-cncontactviewcontrollermbs.shtml"
		  linksMBS.Value("CNContainerMBS")="https://www.monkeybreadsoftware.net/class-cncontainermbs.shtml"
		  linksMBS.Value("CNFetchResultMBS")="https://www.monkeybreadsoftware.net/class-cnfetchresultmbs.shtml"
		  linksMBS.Value("CNGroupMBS")="https://www.monkeybreadsoftware.net/class-cngroupmbs.shtml"
		  linksMBS.Value("CNInstantMessageAddressMBS")="https://www.monkeybreadsoftware.net/class-cninstantmessageaddressmbs.shtml"
		  linksMBS.Value("CNKeyDescriptorMBS")="https://www.monkeybreadsoftware.net/class-cnkeydescriptormbs.shtml"
		  linksMBS.Value("CNLabeledValueMBS")="https://www.monkeybreadsoftware.net/class-cnlabeledvaluembs.shtml"
		  linksMBS.Value("CNMutableContactMBS")="https://www.monkeybreadsoftware.net/class-cnmutablecontactmbs.shtml"
		  linksMBS.Value("CNMutableGroupMBS")="https://www.monkeybreadsoftware.net/class-cnmutablegroupmbs.shtml"
		  linksMBS.Value("CNMutablePostalAddressMBS")="https://www.monkeybreadsoftware.net/class-cnmutablepostaladdressmbs.shtml"
		  linksMBS.Value("CNPhoneNumberMBS")="https://www.monkeybreadsoftware.net/class-cnphonenumbermbs.shtml"
		  linksMBS.Value("CNPostalAddressFormatterMBS")="https://www.monkeybreadsoftware.net/class-cnpostaladdressformattermbs.shtml"
		  linksMBS.Value("CNPostalAddressMBS")="https://www.monkeybreadsoftware.net/class-cnpostaladdressmbs.shtml"
		  linksMBS.Value("CNSaveRequestMBS")="https://www.monkeybreadsoftware.net/class-cnsaverequestmbs.shtml"
		  linksMBS.Value("CNSocialProfileMBS")="https://www.monkeybreadsoftware.net/class-cnsocialprofilembs.shtml"
		  linksMBS.Value("ComboBox")="https://www.monkeybreadsoftware.net/class-combobox.shtml"
		  linksMBS.Value("ComplexDoubleMBS")="https://www.monkeybreadsoftware.net/class-complexdoublembs.shtml"
		  linksMBS.Value("ComplexSingleMBS")="https://www.monkeybreadsoftware.net/class-complexsinglembs.shtml"
		  linksMBS.Value("ConsoleApplication")="https://www.monkeybreadsoftware.net/class-consoleapplication.shtml"
		  linksMBS.Value("ConsoleStateMBS")="https://www.monkeybreadsoftware.net/class-consolestatembs.shtml"
		  linksMBS.Value("ContainerControl")="https://www.monkeybreadsoftware.net/class-containercontrol.shtml"
		  linksMBS.Value("ContinuityCameraMBS")="https://www.monkeybreadsoftware.net/class-continuitycamerambs.shtml"
		  linksMBS.Value("Control")="https://www.monkeybreadsoftware.net/class-control.shtml"
		  linksMBS.Value("CopyFileMBS")="https://www.monkeybreadsoftware.net/class-copyfilembs.shtml"
		  linksMBS.Value("CoreAudioListenerMBS")="https://www.monkeybreadsoftware.net/class-coreaudiolistenermbs.shtml"
		  linksMBS.Value("CoreAudioMBS")="https://www.monkeybreadsoftware.net/class-coreaudiombs.shtml"
		  linksMBS.Value("CoreAudioPlayerMBS")="https://www.monkeybreadsoftware.net/class-coreaudioplayermbs.shtml"
		  linksMBS.Value("CoreTextMBS")="https://www.monkeybreadsoftware.net/class-coretextmbs.shtml"
		  linksMBS.Value("CPMLanguageInfoMBS")="https://www.monkeybreadsoftware.net/class-cpmlanguageinfombs.shtml"
		  linksMBS.Value("CPMPageFormatMBS")="https://www.monkeybreadsoftware.net/class-cpmpageformatmbs.shtml"
		  linksMBS.Value("CPMPrinterMBS")="https://www.monkeybreadsoftware.net/class-cpmprintermbs.shtml"
		  linksMBS.Value("CPMPrintSessionMBS")="https://www.monkeybreadsoftware.net/class-cpmprintsessionmbs.shtml"
		  linksMBS.Value("CPMPrintSettingsMBS")="https://www.monkeybreadsoftware.net/class-cpmprintsettingsmbs.shtml"
		  linksMBS.Value("CPMRectMBS")="https://www.monkeybreadsoftware.net/class-cpmrectmbs.shtml"
		  linksMBS.Value("CPMResolutionMBS")="https://www.monkeybreadsoftware.net/class-cpmresolutionmbs.shtml"
		  linksMBS.Value("CPMVersionMBS")="https://www.monkeybreadsoftware.net/class-cpmversionmbs.shtml"
		  linksMBS.Value("CPUIDMBS")="https://www.monkeybreadsoftware.net/class-cpuidmbs.shtml"
		  linksMBS.Value("CSIdentityAuthorityMBS")="https://www.monkeybreadsoftware.net/class-csidentityauthoritymbs.shtml"
		  linksMBS.Value("CSIdentityMBS")="https://www.monkeybreadsoftware.net/class-csidentitymbs.shtml"
		  linksMBS.Value("CSIdentityQueryMBS")="https://www.monkeybreadsoftware.net/class-csidentityquerymbs.shtml"
		  linksMBS.Value("CSManagementModuleMBS")="https://www.monkeybreadsoftware.net/class-csmanagementmodulembs.shtml"
		  linksMBS.Value("CSMutableProfileMBS")="https://www.monkeybreadsoftware.net/class-csmutableprofilembs.shtml"
		  linksMBS.Value("CSProfileMBS")="https://www.monkeybreadsoftware.net/class-csprofilembs.shtml"
		  linksMBS.Value("CSTransformMBS")="https://www.monkeybreadsoftware.net/class-cstransformmbs.shtml"
		  linksMBS.Value("CTFontCollectionMBS")="https://www.monkeybreadsoftware.net/class-ctfontcollectionmbs.shtml"
		  linksMBS.Value("CTFontDescriptorMBS")="https://www.monkeybreadsoftware.net/class-ctfontdescriptormbs.shtml"
		  linksMBS.Value("CTFontMBS")="https://www.monkeybreadsoftware.net/class-ctfontmbs.shtml"
		  linksMBS.Value("CTFrameMBS")="https://www.monkeybreadsoftware.net/class-ctframembs.shtml"
		  linksMBS.Value("CTFramesetterMBS")="https://www.monkeybreadsoftware.net/class-ctframesettermbs.shtml"
		  linksMBS.Value("CTGlyphInfoMBS")="https://www.monkeybreadsoftware.net/class-ctglyphinfombs.shtml"
		  linksMBS.Value("CTLineMBS")="https://www.monkeybreadsoftware.net/class-ctlinembs.shtml"
		  linksMBS.Value("CTMutableFontCollectionMBS")="https://www.monkeybreadsoftware.net/class-ctmutablefontcollectionmbs.shtml"
		  linksMBS.Value("CTParagraphStyleMBS")="https://www.monkeybreadsoftware.net/class-ctparagraphstylembs.shtml"
		  linksMBS.Value("CTParagraphStyleSettingMBS")="https://www.monkeybreadsoftware.net/class-ctparagraphstylesettingmbs.shtml"
		  linksMBS.Value("CTRunDelegateMBS")="https://www.monkeybreadsoftware.net/class-ctrundelegatembs.shtml"
		  linksMBS.Value("CTRunMBS")="https://www.monkeybreadsoftware.net/class-ctrunmbs.shtml"
		  linksMBS.Value("CTTextTabMBS")="https://www.monkeybreadsoftware.net/class-cttexttabmbs.shtml"
		  linksMBS.Value("CTTypesetterMBS")="https://www.monkeybreadsoftware.net/class-cttypesettermbs.shtml"
		  linksMBS.Value("CUPSDestinationMBS")="https://www.monkeybreadsoftware.net/class-cupsdestinationmbs.shtml"
		  linksMBS.Value("CUPSErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-cupserrorexceptionmbs.shtml"
		  linksMBS.Value("CUPSJobMBS")="https://www.monkeybreadsoftware.net/class-cupsjobmbs.shtml"
		  linksMBS.Value("CUPSMissingFunctionExceptionMBS")="https://www.monkeybreadsoftware.net/class-cupsmissingfunctionexceptionmbs.shtml"
		  linksMBS.Value("CUPSOptionMBS")="https://www.monkeybreadsoftware.net/class-cupsoptionmbs.shtml"
		  linksMBS.Value("CURLEmailMBS")="https://www.monkeybreadsoftware.net/class-curlemailmbs.shtml"
		  linksMBS.Value("CURLFileInfoMBS")="https://www.monkeybreadsoftware.net/class-curlfileinfombs.shtml"
		  linksMBS.Value("CURLListMBS")="https://www.monkeybreadsoftware.net/class-curllistmbs.shtml"
		  linksMBS.Value("CURLMBS")="https://www.monkeybreadsoftware.net/class-curlmbs.shtml"
		  linksMBS.Value("CURLMimePartMBS")="https://www.monkeybreadsoftware.net/class-curlmimepartmbs.shtml"
		  linksMBS.Value("CURLMissingFunctionExceptionMBS")="https://www.monkeybreadsoftware.net/class-curlmissingfunctionexceptionmbs.shtml"
		  linksMBS.Value("CURLMultiMBS")="https://www.monkeybreadsoftware.net/class-curlmultimbs.shtml"
		  linksMBS.Value("CURLNFileInfoMBS")="https://www.monkeybreadsoftware.net/class-curlnfileinfombs.shtml"
		  linksMBS.Value("CURLNListMBS")="https://www.monkeybreadsoftware.net/class-curlnlistmbs.shtml"
		  linksMBS.Value("CURLNMBS")="https://www.monkeybreadsoftware.net/class-curlnmbs.shtml"
		  linksMBS.Value("CURLNMimePartMBS")="https://www.monkeybreadsoftware.net/class-curlnmimepartmbs.shtml"
		  linksMBS.Value("CURLNMissingFunctionExceptionMBS")="https://www.monkeybreadsoftware.net/class-curlnmissingfunctionexceptionmbs.shtml"
		  linksMBS.Value("CURLNMultiMBS")="https://www.monkeybreadsoftware.net/class-curlnmultimbs.shtml"
		  linksMBS.Value("CURLNNotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-curlnnotinitializedexceptionmbs.shtml"
		  linksMBS.Value("CURLNotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-curlnotinitializedexceptionmbs.shtml"
		  linksMBS.Value("CURLNSSLBackendMBS")="https://www.monkeybreadsoftware.net/class-curlnsslbackendmbs.shtml"
		  linksMBS.Value("CURLNURLMBS")="https://www.monkeybreadsoftware.net/class-curlnurlmbs.shtml"
		  linksMBS.Value("CURLNVersionMBS")="https://www.monkeybreadsoftware.net/class-curlnversionmbs.shtml"
		  linksMBS.Value("CURLSFileInfoMBS")="https://www.monkeybreadsoftware.net/class-curlsfileinfombs.shtml"
		  linksMBS.Value("CURLSListMBS")="https://www.monkeybreadsoftware.net/class-curlslistmbs.shtml"
		  linksMBS.Value("CURLSMBS")="https://www.monkeybreadsoftware.net/class-curlsmbs.shtml"
		  linksMBS.Value("CURLSMimePartMBS")="https://www.monkeybreadsoftware.net/class-curlsmimepartmbs.shtml"
		  linksMBS.Value("CURLSMissingFunctionExceptionMBS")="https://www.monkeybreadsoftware.net/class-curlsmissingfunctionexceptionmbs.shtml"
		  linksMBS.Value("CURLSMultiMBS")="https://www.monkeybreadsoftware.net/class-curlsmultimbs.shtml"
		  linksMBS.Value("CURLSNotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-curlsnotinitializedexceptionmbs.shtml"
		  linksMBS.Value("CURLSSLBackendMBS")="https://www.monkeybreadsoftware.net/class-curlsslbackendmbs.shtml"
		  linksMBS.Value("CURLSSSLBackendMBS")="https://www.monkeybreadsoftware.net/class-curlssslbackendmbs.shtml"
		  linksMBS.Value("CURLSURLMBS")="https://www.monkeybreadsoftware.net/class-curlsurlmbs.shtml"
		  linksMBS.Value("CURLSVersionMBS")="https://www.monkeybreadsoftware.net/class-curlsversionmbs.shtml"
		  linksMBS.Value("CURLURLMBS")="https://www.monkeybreadsoftware.net/class-curlurlmbs.shtml"
		  linksMBS.Value("CURLVersionMBS")="https://www.monkeybreadsoftware.net/class-curlversionmbs.shtml"
		  linksMBS.Value("CustomNSScrollerMBS")="https://www.monkeybreadsoftware.net/class-customnsscrollermbs.shtml"
		  linksMBS.Value("CustomNSSearchFieldMBS")="https://www.monkeybreadsoftware.net/class-customnssearchfieldmbs.shtml"
		  linksMBS.Value("CustomNSSharingServiceMBS")="https://www.monkeybreadsoftware.net/class-customnssharingservicembs.shtml"
		  linksMBS.Value("CustomNSTextFieldCellMBS")="https://www.monkeybreadsoftware.net/class-customnstextfieldcellmbs.shtml"
		  linksMBS.Value("CustomNSTextFieldMBS")="https://www.monkeybreadsoftware.net/class-customnstextfieldmbs.shtml"
		  linksMBS.Value("CustomNSTextViewMBS")="https://www.monkeybreadsoftware.net/class-customnstextviewmbs.shtml"
		  linksMBS.Value("CustomNSTokenFieldMBS")="https://www.monkeybreadsoftware.net/class-customnstokenfieldmbs.shtml"
		  linksMBS.Value("CustomNSToolbarItemMBS")="https://www.monkeybreadsoftware.net/class-customnstoolbaritemmbs.shtml"
		  linksMBS.Value("CustomNSToolbarMBS")="https://www.monkeybreadsoftware.net/class-customnstoolbarmbs.shtml"
		  linksMBS.Value("CustomNSViewMBS")="https://www.monkeybreadsoftware.net/class-customnsviewmbs.shtml"
		  linksMBS.Value("CustomPDFViewMBS")="https://www.monkeybreadsoftware.net/class-custompdfviewmbs.shtml"
		  linksMBS.Value("CVImageBufferMBS")="https://www.monkeybreadsoftware.net/class-cvimagebuffermbs.shtml"
		  linksMBS.Value("CVPixelBufferMBS")="https://www.monkeybreadsoftware.net/class-cvpixelbuffermbs.shtml"
		  linksMBS.Value("CWChannelMBS")="https://www.monkeybreadsoftware.net/class-cwchannelmbs.shtml"
		  linksMBS.Value("CWConfigurationMBS")="https://www.monkeybreadsoftware.net/class-cwconfigurationmbs.shtml"
		  linksMBS.Value("CWInterfaceMBS")="https://www.monkeybreadsoftware.net/class-cwinterfacembs.shtml"
		  linksMBS.Value("CWMutableConfigurationMBS")="https://www.monkeybreadsoftware.net/class-cwmutableconfigurationmbs.shtml"
		  linksMBS.Value("CWMutableNetworkProfileMBS")="https://www.monkeybreadsoftware.net/class-cwmutablenetworkprofilembs.shtml"
		  linksMBS.Value("CWNetworkMBS")="https://www.monkeybreadsoftware.net/class-cwnetworkmbs.shtml"
		  linksMBS.Value("CWNetworkProfileMBS")="https://www.monkeybreadsoftware.net/class-cwnetworkprofilembs.shtml"
		  linksMBS.Value("CWWiFiClientMBS")="https://www.monkeybreadsoftware.net/class-cwwificlientmbs.shtml"
		  linksMBS.Value("DADiskMBS")="https://www.monkeybreadsoftware.net/class-dadiskmbs.shtml"
		  linksMBS.Value("DADissenterMBS")="https://www.monkeybreadsoftware.net/class-dadissentermbs.shtml"
		  linksMBS.Value("DarwinChmodMBS")="https://www.monkeybreadsoftware.net/class-darwinchmodmbs.shtml"
		  linksMBS.Value("DarwinDriveStatisticsMBS")="https://www.monkeybreadsoftware.net/class-darwindrivestatisticsmbs.shtml"
		  linksMBS.Value("DarwinGroupListMBS")="https://www.monkeybreadsoftware.net/class-darwingrouplistmbs.shtml"
		  linksMBS.Value("DarwinGroupMBS")="https://www.monkeybreadsoftware.net/class-darwingroupmbs.shtml"
		  linksMBS.Value("DarwinIFStatInterfaceMBS")="https://www.monkeybreadsoftware.net/class-darwinifstatinterfacembs.shtml"
		  linksMBS.Value("DarwinIFStatMBS")="https://www.monkeybreadsoftware.net/class-darwinifstatmbs.shtml"
		  linksMBS.Value("DarwinResourceUsageMBS")="https://www.monkeybreadsoftware.net/class-darwinresourceusagembs.shtml"
		  linksMBS.Value("DarwinTaskInfoMBS")="https://www.monkeybreadsoftware.net/class-darwintaskinfombs.shtml"
		  linksMBS.Value("DarwinUserListMBS")="https://www.monkeybreadsoftware.net/class-darwinuserlistmbs.shtml"
		  linksMBS.Value("DarwinUserMBS")="https://www.monkeybreadsoftware.net/class-darwinusermbs.shtml"
		  linksMBS.Value("DarwinVMStatisticsMBS")="https://www.monkeybreadsoftware.net/class-darwinvmstatisticsmbs.shtml"
		  linksMBS.Value("DASessionMBS")="https://www.monkeybreadsoftware.net/class-dasessionmbs.shtml"
		  linksMBS.Value("Database")="https://www.monkeybreadsoftware.net/class-database.shtml"
		  linksMBS.Value("DatagramMBS")="https://www.monkeybreadsoftware.net/class-datagrammbs.shtml"
		  linksMBS.Value("DateDifferenceMBS")="https://www.monkeybreadsoftware.net/class-datedifferencembs.shtml"
		  linksMBS.Value("DateTimePicker")="https://www.monkeybreadsoftware.net/class-datetimepicker.shtml"
		  linksMBS.Value("DDEBinaryDataMBS")="https://www.monkeybreadsoftware.net/class-ddebinarydatambs.shtml"
		  linksMBS.Value("DDEContextInfoMBS")="https://www.monkeybreadsoftware.net/class-ddecontextinfombs.shtml"
		  linksMBS.Value("DDEMBS")="https://www.monkeybreadsoftware.net/class-ddembs.shtml"
		  linksMBS.Value("DDEStringMBS")="https://www.monkeybreadsoftware.net/class-ddestringmbs.shtml"
		  linksMBS.Value("DDEStringPairListMBS")="https://www.monkeybreadsoftware.net/class-ddestringpairlistmbs.shtml"
		  linksMBS.Value("DDEStringPairMBS")="https://www.monkeybreadsoftware.net/class-ddestringpairmbs.shtml"
		  linksMBS.Value("DeclareCallBackMBS")="https://www.monkeybreadsoftware.net/class-declarecallbackmbs.shtml"
		  linksMBS.Value("DeclareFunctionMBS")="https://www.monkeybreadsoftware.net/class-declarefunctionmbs.shtml"
		  linksMBS.Value("DeclareLibraryMBS")="https://www.monkeybreadsoftware.net/class-declarelibrarymbs.shtml"
		  linksMBS.Value("DesktopApplication")="https://www.monkeybreadsoftware.net/class-desktopapplication.shtml"
		  linksMBS.Value("DesktopBevelButton")="https://www.monkeybreadsoftware.net/class-desktopbevelbutton.shtml"
		  linksMBS.Value("DesktopButton")="https://www.monkeybreadsoftware.net/class-desktopbutton.shtml"
		  linksMBS.Value("DesktopCheckBox")="https://www.monkeybreadsoftware.net/class-desktopcheckbox.shtml"
		  linksMBS.Value("DesktopComboBox")="https://www.monkeybreadsoftware.net/class-desktopcombobox.shtml"
		  linksMBS.Value("DesktopContainer")="https://www.monkeybreadsoftware.net/class-desktopcontainer.shtml"
		  linksMBS.Value("DesktopControl")="https://www.monkeybreadsoftware.net/class-desktopcontrol.shtml"
		  linksMBS.Value("DesktopDateTimePicker")="https://www.monkeybreadsoftware.net/class-desktopdatetimepicker.shtml"
		  linksMBS.Value("DesktopDisclosureTriangle")="https://www.monkeybreadsoftware.net/class-desktopdisclosuretriangle.shtml"
		  linksMBS.Value("DesktopGroupBox")="https://www.monkeybreadsoftware.net/class-desktopgroupbox.shtml"
		  linksMBS.Value("DesktopHTMLViewer")="https://www.monkeybreadsoftware.net/class-desktophtmlviewer.shtml"
		  linksMBS.Value("DesktopImageViewer")="https://www.monkeybreadsoftware.net/class-desktopimageviewer.shtml"
		  linksMBS.Value("DesktopLabel")="https://www.monkeybreadsoftware.net/class-desktoplabel.shtml"
		  linksMBS.Value("DesktopListbox")="https://www.monkeybreadsoftware.net/class-desktoplistbox.shtml"
		  linksMBS.Value("DesktopMoviePlayer")="https://www.monkeybreadsoftware.net/class-desktopmovieplayer.shtml"
		  linksMBS.Value("DesktopPopupMenu")="https://www.monkeybreadsoftware.net/class-desktoppopupmenu.shtml"
		  linksMBS.Value("DesktopProgressbar")="https://www.monkeybreadsoftware.net/class-desktopprogressbar.shtml"
		  linksMBS.Value("DesktopProgressWheel")="https://www.monkeybreadsoftware.net/class-desktopprogresswheel.shtml"
		  linksMBS.Value("DesktopRadioButton")="https://www.monkeybreadsoftware.net/class-desktopradiobutton.shtml"
		  linksMBS.Value("DesktopRadioGroup")="https://www.monkeybreadsoftware.net/class-desktopradiogroup.shtml"
		  linksMBS.Value("DesktopScrollBar")="https://www.monkeybreadsoftware.net/class-desktopscrollbar.shtml"
		  linksMBS.Value("DesktopSearchField")="https://www.monkeybreadsoftware.net/class-desktopsearchfield.shtml"
		  linksMBS.Value("DesktopSegmentedButton")="https://www.monkeybreadsoftware.net/class-desktopsegmentedbutton.shtml"
		  linksMBS.Value("DesktopSeparator")="https://www.monkeybreadsoftware.net/class-desktopseparator.shtml"
		  linksMBS.Value("DesktopSlider")="https://www.monkeybreadsoftware.net/class-desktopslider.shtml"
		  linksMBS.Value("DesktopTabPanel")="https://www.monkeybreadsoftware.net/class-desktoptabpanel.shtml"
		  linksMBS.Value("DesktopTextArea")="https://www.monkeybreadsoftware.net/class-desktoptextarea.shtml"
		  linksMBS.Value("DesktopTextField")="https://www.monkeybreadsoftware.net/class-desktoptextfield.shtml"
		  linksMBS.Value("DesktopUIControl")="https://www.monkeybreadsoftware.net/class-desktopuicontrol.shtml"
		  linksMBS.Value("DesktopUpDownArrows")="https://www.monkeybreadsoftware.net/class-desktopupdownarrows.shtml"
		  linksMBS.Value("DesktopWindow")="https://www.monkeybreadsoftware.net/class-desktopwindow.shtml"
		  linksMBS.Value("DigestMBS")="https://www.monkeybreadsoftware.net/class-digestmbs.shtml"
		  linksMBS.Value("DirectDrawGraphicsMBS")="https://www.monkeybreadsoftware.net/class-directdrawgraphicsmbs.shtml"
		  linksMBS.Value("DirectorySizeMBS")="https://www.monkeybreadsoftware.net/class-directorysizembs.shtml"
		  linksMBS.Value("DirectShowAMCameraControlMBS")="https://www.monkeybreadsoftware.net/class-directshowamcameracontrolmbs.shtml"
		  linksMBS.Value("DirectShowAMCrossbarMBS")="https://www.monkeybreadsoftware.net/class-directshowamcrossbarmbs.shtml"
		  linksMBS.Value("DirectShowAMStreamConfigMBS")="https://www.monkeybreadsoftware.net/class-directshowamstreamconfigmbs.shtml"
		  linksMBS.Value("DirectShowAMVideoCompressionMBS")="https://www.monkeybreadsoftware.net/class-directshowamvideocompressionmbs.shtml"
		  linksMBS.Value("DirectShowAMVideoControlMBS")="https://www.monkeybreadsoftware.net/class-directshowamvideocontrolmbs.shtml"
		  linksMBS.Value("DirectShowAMVideoProcAmpMBS")="https://www.monkeybreadsoftware.net/class-directshowamvideoprocampmbs.shtml"
		  linksMBS.Value("DirectShowAudioStreamConfigCapsMBS")="https://www.monkeybreadsoftware.net/class-directshowaudiostreamconfigcapsmbs.shtml"
		  linksMBS.Value("DirectShowBaseFilterMBS")="https://www.monkeybreadsoftware.net/class-directshowbasefiltermbs.shtml"
		  linksMBS.Value("DirectShowBindContextMBS")="https://www.monkeybreadsoftware.net/class-directshowbindcontextmbs.shtml"
		  linksMBS.Value("DirectShowCaptureGraphBuilderMBS")="https://www.monkeybreadsoftware.net/class-directshowcapturegraphbuildermbs.shtml"
		  linksMBS.Value("DirectShowConfigAviMuxMBS")="https://www.monkeybreadsoftware.net/class-directshowconfigavimuxmbs.shtml"
		  linksMBS.Value("DirectShowConfigInterleavingMBS")="https://www.monkeybreadsoftware.net/class-directshowconfiginterleavingmbs.shtml"
		  linksMBS.Value("DirectShowDVInfoMBS")="https://www.monkeybreadsoftware.net/class-directshowdvinfombs.shtml"
		  linksMBS.Value("DirectShowEnumMonikerMBS")="https://www.monkeybreadsoftware.net/class-directshowenummonikermbs.shtml"
		  linksMBS.Value("DirectShowEnumPinsMBS")="https://www.monkeybreadsoftware.net/class-directshowenumpinsmbs.shtml"
		  linksMBS.Value("DirectShowFileSinkFilterMBS")="https://www.monkeybreadsoftware.net/class-directshowfilesinkfiltermbs.shtml"
		  linksMBS.Value("DirectShowFilterGraphMBS")="https://www.monkeybreadsoftware.net/class-directshowfiltergraphmbs.shtml"
		  linksMBS.Value("DirectShowFilterInfoMBS")="https://www.monkeybreadsoftware.net/class-directshowfilterinfombs.shtml"
		  linksMBS.Value("DirectShowGraphBuilderMBS")="https://www.monkeybreadsoftware.net/class-directshowgraphbuildermbs.shtml"
		  linksMBS.Value("DirectShowGUIDMBS")="https://www.monkeybreadsoftware.net/class-directshowguidmbs.shtml"
		  linksMBS.Value("DirectShowMediaControlMBS")="https://www.monkeybreadsoftware.net/class-directshowmediacontrolmbs.shtml"
		  linksMBS.Value("DirectShowMediaEventExMBS")="https://www.monkeybreadsoftware.net/class-directshowmediaeventexmbs.shtml"
		  linksMBS.Value("DirectShowMediaEventMBS")="https://www.monkeybreadsoftware.net/class-directshowmediaeventmbs.shtml"
		  linksMBS.Value("DirectShowMediaFilterMBS")="https://www.monkeybreadsoftware.net/class-directshowmediafiltermbs.shtml"
		  linksMBS.Value("DirectShowMediaTypeMBS")="https://www.monkeybreadsoftware.net/class-directshowmediatypembs.shtml"
		  linksMBS.Value("DirectShowMonikerMBS")="https://www.monkeybreadsoftware.net/class-directshowmonikermbs.shtml"
		  linksMBS.Value("DirectShowNullRendererMBS")="https://www.monkeybreadsoftware.net/class-directshownullrenderermbs.shtml"
		  linksMBS.Value("DirectShowPinMBS")="https://www.monkeybreadsoftware.net/class-directshowpinmbs.shtml"
		  linksMBS.Value("DirectShowPropertyBagMBS")="https://www.monkeybreadsoftware.net/class-directshowpropertybagmbs.shtml"
		  linksMBS.Value("DirectShowSampleGrabberMBS")="https://www.monkeybreadsoftware.net/class-directshowsamplegrabbermbs.shtml"
		  linksMBS.Value("DirectShowVideoInfoHeader2MBS")="https://www.monkeybreadsoftware.net/class-directshowvideoinfoheader2mbs.shtml"
		  linksMBS.Value("DirectShowVideoInfoHeaderMBS")="https://www.monkeybreadsoftware.net/class-directshowvideoinfoheadermbs.shtml"
		  linksMBS.Value("DirectShowVideoStreamConfigCapsMBS")="https://www.monkeybreadsoftware.net/class-directshowvideostreamconfigcapsmbs.shtml"
		  linksMBS.Value("DirectShowVideoWindowMBS")="https://www.monkeybreadsoftware.net/class-directshowvideowindowmbs.shtml"
		  linksMBS.Value("DirectShowWaveFormatMBS")="https://www.monkeybreadsoftware.net/class-directshowwaveformatmbs.shtml"
		  linksMBS.Value("DisclosureTriangle")="https://www.monkeybreadsoftware.net/class-disclosuretriangle.shtml"
		  linksMBS.Value("DisplayMBS")="https://www.monkeybreadsoftware.net/class-displaymbs.shtml"
		  linksMBS.Value("DNSAddressRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsaddressrecordmbs.shtml"
		  linksMBS.Value("DNSAFSDBRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsafsdbrecordmbs.shtml"
		  linksMBS.Value("DNSDomainNameRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsdomainnamerecordmbs.shtml"
		  linksMBS.Value("DNSHeaderMBS")="https://www.monkeybreadsoftware.net/class-dnsheadermbs.shtml"
		  linksMBS.Value("DNSHINFORecordMBS")="https://www.monkeybreadsoftware.net/class-dnshinforecordmbs.shtml"
		  linksMBS.Value("DNSIN6AddressRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsin6addressrecordmbs.shtml"
		  linksMBS.Value("DNSISDNRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsisdnrecordmbs.shtml"
		  linksMBS.Value("DNSLocRecordMBS")="https://www.monkeybreadsoftware.net/class-dnslocrecordmbs.shtml"
		  linksMBS.Value("DNSLookupMBS")="https://www.monkeybreadsoftware.net/class-dnslookupmbs.shtml"
		  linksMBS.Value("DNSMINFORecordMBS")="https://www.monkeybreadsoftware.net/class-dnsminforecordmbs.shtml"
		  linksMBS.Value("DNSMXRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsmxrecordmbs.shtml"
		  linksMBS.Value("DNSQuestionMBS")="https://www.monkeybreadsoftware.net/class-dnsquestionmbs.shtml"
		  linksMBS.Value("DNSRawResourceRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsrawresourcerecordmbs.shtml"
		  linksMBS.Value("DNSReplyMBS")="https://www.monkeybreadsoftware.net/class-dnsreplymbs.shtml"
		  linksMBS.Value("DNSResourceRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsresourcerecordmbs.shtml"
		  linksMBS.Value("DNSRPRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsrprecordmbs.shtml"
		  linksMBS.Value("DNSRTRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsrtrecordmbs.shtml"
		  linksMBS.Value("DNSServiceAddrInfoMBS")="https://www.monkeybreadsoftware.net/class-dnsserviceaddrinfombs.shtml"
		  linksMBS.Value("DNSServiceBaseMBS")="https://www.monkeybreadsoftware.net/class-dnsservicebasembs.shtml"
		  linksMBS.Value("DNSServiceBrowseMBS")="https://www.monkeybreadsoftware.net/class-dnsservicebrowsembs.shtml"
		  linksMBS.Value("DNSServiceDomainEnumerationMBS")="https://www.monkeybreadsoftware.net/class-dnsservicedomainenumerationmbs.shtml"
		  linksMBS.Value("DNSServiceMetaQueryMBS")="https://www.monkeybreadsoftware.net/class-dnsservicemetaquerymbs.shtml"
		  linksMBS.Value("DNSServiceQueryRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsservicequeryrecordmbs.shtml"
		  linksMBS.Value("DNSServiceRegisterMBS")="https://www.monkeybreadsoftware.net/class-dnsserviceregistermbs.shtml"
		  linksMBS.Value("DNSServiceRegisterRecordMBS")="https://www.monkeybreadsoftware.net/class-dnsserviceregisterrecordmbs.shtml"
		  linksMBS.Value("DNSServiceResolveMBS")="https://www.monkeybreadsoftware.net/class-dnsserviceresolvembs.shtml"
		  linksMBS.Value("DNSSOARecordMBS")="https://www.monkeybreadsoftware.net/class-dnssoarecordmbs.shtml"
		  linksMBS.Value("DNSSocketAddressMBS")="https://www.monkeybreadsoftware.net/class-dnssocketaddressmbs.shtml"
		  linksMBS.Value("DNSSRVRecordMBS")="https://www.monkeybreadsoftware.net/class-dnssrvrecordmbs.shtml"
		  linksMBS.Value("DNSTXTRecordMBS")="https://www.monkeybreadsoftware.net/class-dnstxtrecordmbs.shtml"
		  linksMBS.Value("DNSWKSRecordMBS")="https://www.monkeybreadsoftware.net/class-dnswksrecordmbs.shtml"
		  linksMBS.Value("DNSX25RecordMBS")="https://www.monkeybreadsoftware.net/class-dnsx25recordmbs.shtml"
		  linksMBS.Value("DoublePointMBS")="https://www.monkeybreadsoftware.net/class-doublepointmbs.shtml"
		  linksMBS.Value("DoubleRectMBS")="https://www.monkeybreadsoftware.net/class-doublerectmbs.shtml"
		  linksMBS.Value("DragItem")="https://www.monkeybreadsoftware.net/class-dragitem.shtml"
		  linksMBS.Value("DRBurnMBS")="https://www.monkeybreadsoftware.net/class-drburnmbs.shtml"
		  linksMBS.Value("DRBurnProgressPanelMBS")="https://www.monkeybreadsoftware.net/class-drburnprogresspanelmbs.shtml"
		  linksMBS.Value("DRBurnSetupPanelMBS")="https://www.monkeybreadsoftware.net/class-drburnsetuppanelmbs.shtml"
		  linksMBS.Value("DRCDTextBlockMBS")="https://www.monkeybreadsoftware.net/class-drcdtextblockmbs.shtml"
		  linksMBS.Value("DRDeviceMBS")="https://www.monkeybreadsoftware.net/class-drdevicembs.shtml"
		  linksMBS.Value("DREraseMBS")="https://www.monkeybreadsoftware.net/class-drerasembs.shtml"
		  linksMBS.Value("DREraseProgressPanelMBS")="https://www.monkeybreadsoftware.net/class-dreraseprogresspanelmbs.shtml"
		  linksMBS.Value("DREraseSetupPanelMBS")="https://www.monkeybreadsoftware.net/class-drerasesetuppanelmbs.shtml"
		  linksMBS.Value("DRFileMBS")="https://www.monkeybreadsoftware.net/class-drfilembs.shtml"
		  linksMBS.Value("DRFolderMBS")="https://www.monkeybreadsoftware.net/class-drfoldermbs.shtml"
		  linksMBS.Value("DRFSObjectMBS")="https://www.monkeybreadsoftware.net/class-drfsobjectmbs.shtml"
		  linksMBS.Value("DRMSFMBS")="https://www.monkeybreadsoftware.net/class-drmsfmbs.shtml"
		  linksMBS.Value("DRNotificationCenterMBS")="https://www.monkeybreadsoftware.net/class-drnotificationcentermbs.shtml"
		  linksMBS.Value("DRSetupPanelMBS")="https://www.monkeybreadsoftware.net/class-drsetuppanelmbs.shtml"
		  linksMBS.Value("DRTrackMBS")="https://www.monkeybreadsoftware.net/class-drtrackmbs.shtml"
		  linksMBS.Value("DVDPlaybackMBS")="https://www.monkeybreadsoftware.net/class-dvdplaybackmbs.shtml"
		  linksMBS.Value("DVDPlaybackMissingFunctionExceptionMBS")="https://www.monkeybreadsoftware.net/class-dvdplaybackmissingfunctionexceptionmbs.shtml"
		  linksMBS.Value("DVDPlaybackNotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-dvdplaybacknotinitializedexceptionmbs.shtml"
		  linksMBS.Value("DynaPDFAnnotationExMBS")="https://www.monkeybreadsoftware.net/class-dynapdfannotationexmbs.shtml"
		  linksMBS.Value("DynaPDFAnnotationMBS")="https://www.monkeybreadsoftware.net/class-dynapdfannotationmbs.shtml"
		  linksMBS.Value("DynaPDFBarcode2MBS")="https://www.monkeybreadsoftware.net/class-dynapdfbarcode2mbs.shtml"
		  linksMBS.Value("DynaPDFBarcodeMBS")="https://www.monkeybreadsoftware.net/class-dynapdfbarcodembs.shtml"
		  linksMBS.Value("DynaPDFBitmapMBS")="https://www.monkeybreadsoftware.net/class-dynapdfbitmapmbs.shtml"
		  linksMBS.Value("DynaPDFBookmarkMBS")="https://www.monkeybreadsoftware.net/class-dynapdfbookmarkmbs.shtml"
		  linksMBS.Value("DynaPDFChoiceValueMBS")="https://www.monkeybreadsoftware.net/class-dynapdfchoicevaluembs.shtml"
		  linksMBS.Value("DynaPDFCIDMetricMBS")="https://www.monkeybreadsoftware.net/class-dynapdfcidmetricmbs.shtml"
		  linksMBS.Value("DynaPDFCMapMBS")="https://www.monkeybreadsoftware.net/class-dynapdfcmapmbs.shtml"
		  linksMBS.Value("DynaPDFColorProfilesExMBS")="https://www.monkeybreadsoftware.net/class-dynapdfcolorprofilesexmbs.shtml"
		  linksMBS.Value("DynaPDFColorProfilesMBS")="https://www.monkeybreadsoftware.net/class-dynapdfcolorprofilesmbs.shtml"
		  linksMBS.Value("DynaPDFColorSpaceMBS")="https://www.monkeybreadsoftware.net/class-dynapdfcolorspacembs.shtml"
		  linksMBS.Value("DynaPDFDeviceNAttributesMBS")="https://www.monkeybreadsoftware.net/class-dynapdfdevicenattributesmbs.shtml"
		  linksMBS.Value("DynaPDFEditTextMBS")="https://www.monkeybreadsoftware.net/class-dynapdfedittextmbs.shtml"
		  linksMBS.Value("DynaPDFEmbFileNodeMBS")="https://www.monkeybreadsoftware.net/class-dynapdfembfilenodembs.shtml"
		  linksMBS.Value("DynaPDFErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-dynapdferrorexceptionmbs.shtml"
		  linksMBS.Value("DynaPDFErrorMBS")="https://www.monkeybreadsoftware.net/class-dynapdferrormbs.shtml"
		  linksMBS.Value("DynaPDFExtGState2MBS")="https://www.monkeybreadsoftware.net/class-dynapdfextgstate2mbs.shtml"
		  linksMBS.Value("DynaPDFExtGStateMBS")="https://www.monkeybreadsoftware.net/class-dynapdfextgstatembs.shtml"
		  linksMBS.Value("DynaPDFFieldExMBS")="https://www.monkeybreadsoftware.net/class-dynapdffieldexmbs.shtml"
		  linksMBS.Value("DynaPDFFileSpecExMBS")="https://www.monkeybreadsoftware.net/class-dynapdffilespecexmbs.shtml"
		  linksMBS.Value("DynaPDFFileSpecMBS")="https://www.monkeybreadsoftware.net/class-dynapdffilespecmbs.shtml"
		  linksMBS.Value("DynaPDFFontInfoMBS")="https://www.monkeybreadsoftware.net/class-dynapdffontinfombs.shtml"
		  linksMBS.Value("DynaPDFFontMBS")="https://www.monkeybreadsoftware.net/class-dynapdffontmbs.shtml"
		  linksMBS.Value("DynaPDFFontMetricsMBS")="https://www.monkeybreadsoftware.net/class-dynapdffontmetricsmbs.shtml"
		  linksMBS.Value("DynaPDFGlyphOutlineMBS")="https://www.monkeybreadsoftware.net/class-dynapdfglyphoutlinembs.shtml"
		  linksMBS.Value("DynaPDFGoToActionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfgotoactionmbs.shtml"
		  linksMBS.Value("DynapdfGraphicsPathItemMBS")="https://www.monkeybreadsoftware.net/class-dynapdfgraphicspathitemmbs.shtml"
		  linksMBS.Value("DynapdfGraphicsPathMBS")="https://www.monkeybreadsoftware.net/class-dynapdfgraphicspathmbs.shtml"
		  linksMBS.Value("DynaPDFHideActionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfhideactionmbs.shtml"
		  linksMBS.Value("DynaPDFImageMBS")="https://www.monkeybreadsoftware.net/class-dynapdfimagembs.shtml"
		  linksMBS.Value("DynaPDFImportDataActionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfimportdataactionmbs.shtml"
		  linksMBS.Value("DynaPDFJavaScriptActionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfjavascriptactionmbs.shtml"
		  linksMBS.Value("DynaPDFLaunchActionMBS")="https://www.monkeybreadsoftware.net/class-dynapdflaunchactionmbs.shtml"
		  linksMBS.Value("DynaPDFLayerGroupMBS")="https://www.monkeybreadsoftware.net/class-dynapdflayergroupmbs.shtml"
		  linksMBS.Value("DynaPDFLineAnnotParameterMBS")="https://www.monkeybreadsoftware.net/class-dynapdflineannotparametermbs.shtml"
		  linksMBS.Value("DynaPDFMatrixMBS")="https://www.monkeybreadsoftware.net/class-dynapdfmatrixmbs.shtml"
		  linksMBS.Value("DynaPDFMBS")="https://www.monkeybreadsoftware.net/class-dynapdfmbs.shtml"
		  linksMBS.Value("DynaPDFMeasureMBS")="https://www.monkeybreadsoftware.net/class-dynapdfmeasurembs.shtml"
		  linksMBS.Value("DynaPDFMissingFunctionExceptionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfmissingfunctionexceptionmbs.shtml"
		  linksMBS.Value("DynaPDFMovieActionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfmovieactionmbs.shtml"
		  linksMBS.Value("DynaPDFNamedActionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfnamedactionmbs.shtml"
		  linksMBS.Value("DynaPDFNamedDestMBS")="https://www.monkeybreadsoftware.net/class-dynapdfnameddestmbs.shtml"
		  linksMBS.Value("DynaPDFNotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfnotinitializedexceptionmbs.shtml"
		  linksMBS.Value("DynaPDFNumberFormatMBS")="https://www.monkeybreadsoftware.net/class-dynapdfnumberformatmbs.shtml"
		  linksMBS.Value("DynaPDFObjActionsMBS")="https://www.monkeybreadsoftware.net/class-dynapdfobjactionsmbs.shtml"
		  linksMBS.Value("DynaPDFObjEventMBS")="https://www.monkeybreadsoftware.net/class-dynapdfobjeventmbs.shtml"
		  linksMBS.Value("DynaPDFOCGContUsageMBS")="https://www.monkeybreadsoftware.net/class-dynapdfocgcontusagembs.shtml"
		  linksMBS.Value("DynaPDFOCGMBS")="https://www.monkeybreadsoftware.net/class-dynapdfocgmbs.shtml"
		  linksMBS.Value("DynaPDFOCLayerConfigMBS")="https://www.monkeybreadsoftware.net/class-dynapdfoclayerconfigmbs.shtml"
		  linksMBS.Value("DynaPDFOCUINodeMBS")="https://www.monkeybreadsoftware.net/class-dynapdfocuinodembs.shtml"
		  linksMBS.Value("DynaPDFOptimizeParamsMBS")="https://www.monkeybreadsoftware.net/class-dynapdfoptimizeparamsmbs.shtml"
		  linksMBS.Value("DynaPDFOutputIntentMBS")="https://www.monkeybreadsoftware.net/class-dynapdfoutputintentmbs.shtml"
		  linksMBS.Value("DynaPDFPageLabelMBS")="https://www.monkeybreadsoftware.net/class-dynapdfpagelabelmbs.shtml"
		  linksMBS.Value("DynaPDFPageMBS")="https://www.monkeybreadsoftware.net/class-dynapdfpagembs.shtml"
		  linksMBS.Value("DynaPDFPageStatisticMBS")="https://www.monkeybreadsoftware.net/class-dynapdfpagestatisticmbs.shtml"
		  linksMBS.Value("DynaPDFParseInterfaceMBS")="https://www.monkeybreadsoftware.net/class-dynapdfparseinterfacembs.shtml"
		  linksMBS.Value("DynaPDFPointDataDictionaryMBS")="https://www.monkeybreadsoftware.net/class-dynapdfpointdatadictionarymbs.shtml"
		  linksMBS.Value("DynaPDFPointDataMBS")="https://www.monkeybreadsoftware.net/class-dynapdfpointdatambs.shtml"
		  linksMBS.Value("DynaPDFPointMBS")="https://www.monkeybreadsoftware.net/class-dynapdfpointmbs.shtml"
		  linksMBS.Value("DynaPDFPrintParamsMBS")="https://www.monkeybreadsoftware.net/class-dynapdfprintparamsmbs.shtml"
		  linksMBS.Value("DynaPDFPrintSettingsMBS")="https://www.monkeybreadsoftware.net/class-dynapdfprintsettingsmbs.shtml"
		  linksMBS.Value("DynaPDFRasterImageMBS")="https://www.monkeybreadsoftware.net/class-dynapdfrasterimagembs.shtml"
		  linksMBS.Value("DynaPDFRasterizerMBS")="https://www.monkeybreadsoftware.net/class-dynapdfrasterizermbs.shtml"
		  linksMBS.Value("DynaPDFRawImageMBS")="https://www.monkeybreadsoftware.net/class-dynapdfrawimagembs.shtml"
		  linksMBS.Value("DynaPDFRectMBS")="https://www.monkeybreadsoftware.net/class-dynapdfrectmbs.shtml"
		  linksMBS.Value("DynaPDFRelFileNodeMBS")="https://www.monkeybreadsoftware.net/class-dynapdfrelfilenodembs.shtml"
		  linksMBS.Value("DynaPDFResetFormActionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfresetformactionmbs.shtml"
		  linksMBS.Value("DynaPDFSigDictMBS")="https://www.monkeybreadsoftware.net/class-dynapdfsigdictmbs.shtml"
		  linksMBS.Value("DynaPDFSigParmsMBS")="https://www.monkeybreadsoftware.net/class-dynapdfsigparmsmbs.shtml"
		  linksMBS.Value("DynaPDFStackMBS")="https://www.monkeybreadsoftware.net/class-dynapdfstackmbs.shtml"
		  linksMBS.Value("DynaPDFSubmitFormActionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfsubmitformactionmbs.shtml"
		  linksMBS.Value("DynaPDFSysFontMBS")="https://www.monkeybreadsoftware.net/class-dynapdfsysfontmbs.shtml"
		  linksMBS.Value("DynaPDFTableMBS")="https://www.monkeybreadsoftware.net/class-dynapdftablembs.shtml"
		  linksMBS.Value("DynaPDFTextRecordAMBS")="https://www.monkeybreadsoftware.net/class-dynapdftextrecordambs.shtml"
		  linksMBS.Value("DynaPDFTextRecordWMBS")="https://www.monkeybreadsoftware.net/class-dynapdftextrecordwmbs.shtml"
		  linksMBS.Value("DynaPDFURIActionMBS")="https://www.monkeybreadsoftware.net/class-dynapdfuriactionmbs.shtml"
		  linksMBS.Value("DynaPDFVersionInfoMBS")="https://www.monkeybreadsoftware.net/class-dynapdfversioninfombs.shtml"
		  linksMBS.Value("DynaPDFViewportMBS")="https://www.monkeybreadsoftware.net/class-dynapdfviewportmbs.shtml"
		  linksMBS.Value("DynaPDFXFAStreamMBS")="https://www.monkeybreadsoftware.net/class-dynapdfxfastreammbs.shtml"
		  linksMBS.Value("ECDHEMBS")="https://www.monkeybreadsoftware.net/class-ecdhembs.shtml"
		  linksMBS.Value("ECKeyMBS")="https://www.monkeybreadsoftware.net/class-eckeymbs.shtml"
		  linksMBS.Value("EdsBaseMBS")="https://www.monkeybreadsoftware.net/class-edsbasembs.shtml"
		  linksMBS.Value("EdsCameraAddedHandlerMBS")="https://www.monkeybreadsoftware.net/class-edscameraaddedhandlermbs.shtml"
		  linksMBS.Value("EdsCameraListMBS")="https://www.monkeybreadsoftware.net/class-edscameralistmbs.shtml"
		  linksMBS.Value("EdsCameraMBS")="https://www.monkeybreadsoftware.net/class-edscamerambs.shtml"
		  linksMBS.Value("EdsCameraStateEventHandlerMBS")="https://www.monkeybreadsoftware.net/class-edscamerastateeventhandlermbs.shtml"
		  linksMBS.Value("EdsDeviceInfoMBS")="https://www.monkeybreadsoftware.net/class-edsdeviceinfombs.shtml"
		  linksMBS.Value("EdsDirectoryItemInfoMBS")="https://www.monkeybreadsoftware.net/class-edsdirectoryiteminfombs.shtml"
		  linksMBS.Value("EdsDirectoryItemMBS")="https://www.monkeybreadsoftware.net/class-edsdirectoryitemmbs.shtml"
		  linksMBS.Value("EdsEvfImageMBS")="https://www.monkeybreadsoftware.net/class-edsevfimagembs.shtml"
		  linksMBS.Value("EdsFocusInfoMBS")="https://www.monkeybreadsoftware.net/class-edsfocusinfombs.shtml"
		  linksMBS.Value("EdsFocusPointMBS")="https://www.monkeybreadsoftware.net/class-edsfocuspointmbs.shtml"
		  linksMBS.Value("EdsImageInfoMBS")="https://www.monkeybreadsoftware.net/class-edsimageinfombs.shtml"
		  linksMBS.Value("EdsImageMBS")="https://www.monkeybreadsoftware.net/class-edsimagembs.shtml"
		  linksMBS.Value("EdsObjectEventHandlerMBS")="https://www.monkeybreadsoftware.net/class-edsobjecteventhandlermbs.shtml"
		  linksMBS.Value("EdsPictureStyleDescMBS")="https://www.monkeybreadsoftware.net/class-edspicturestyledescmbs.shtml"
		  linksMBS.Value("EdsPointMBS")="https://www.monkeybreadsoftware.net/class-edspointmbs.shtml"
		  linksMBS.Value("EdsProgressMBS")="https://www.monkeybreadsoftware.net/class-edsprogressmbs.shtml"
		  linksMBS.Value("EdsPropertyEventHandlerMBS")="https://www.monkeybreadsoftware.net/class-edspropertyeventhandlermbs.shtml"
		  linksMBS.Value("EdsRationalMBS")="https://www.monkeybreadsoftware.net/class-edsrationalmbs.shtml"
		  linksMBS.Value("EdsRectMBS")="https://www.monkeybreadsoftware.net/class-edsrectmbs.shtml"
		  linksMBS.Value("EdsSizeMBS")="https://www.monkeybreadsoftware.net/class-edssizembs.shtml"
		  linksMBS.Value("EdsStreamMBS")="https://www.monkeybreadsoftware.net/class-edsstreammbs.shtml"
		  linksMBS.Value("EdsTimeMBS")="https://www.monkeybreadsoftware.net/class-edstimembs.shtml"
		  linksMBS.Value("EdsVolumeInfoMBS")="https://www.monkeybreadsoftware.net/class-edsvolumeinfombs.shtml"
		  linksMBS.Value("EdsVolumeMBS")="https://www.monkeybreadsoftware.net/class-edsvolumembs.shtml"
		  linksMBS.Value("EKAlarmMBS")="https://www.monkeybreadsoftware.net/class-ekalarmmbs.shtml"
		  linksMBS.Value("EKCalendarItemMBS")="https://www.monkeybreadsoftware.net/class-ekcalendaritemmbs.shtml"
		  linksMBS.Value("EKCalendarMBS")="https://www.monkeybreadsoftware.net/class-ekcalendarmbs.shtml"
		  linksMBS.Value("EKEventMBS")="https://www.monkeybreadsoftware.net/class-ekeventmbs.shtml"
		  linksMBS.Value("EKEventStoreMBS")="https://www.monkeybreadsoftware.net/class-ekeventstorembs.shtml"
		  linksMBS.Value("EKFetchRequestMBS")="https://www.monkeybreadsoftware.net/class-ekfetchrequestmbs.shtml"
		  linksMBS.Value("EKObjectMBS")="https://www.monkeybreadsoftware.net/class-ekobjectmbs.shtml"
		  linksMBS.Value("EKParticipantMBS")="https://www.monkeybreadsoftware.net/class-ekparticipantmbs.shtml"
		  linksMBS.Value("EKRecurrenceDayOfWeekMBS")="https://www.monkeybreadsoftware.net/class-ekrecurrencedayofweekmbs.shtml"
		  linksMBS.Value("EKRecurrenceEndMBS")="https://www.monkeybreadsoftware.net/class-ekrecurrenceendmbs.shtml"
		  linksMBS.Value("EKRecurrenceRuleMBS")="https://www.monkeybreadsoftware.net/class-ekrecurrencerulembs.shtml"
		  linksMBS.Value("EKReminderMBS")="https://www.monkeybreadsoftware.net/class-ekremindermbs.shtml"
		  linksMBS.Value("EKSourceMBS")="https://www.monkeybreadsoftware.net/class-eksourcembs.shtml"
		  linksMBS.Value("EKStructuredLocationMBS")="https://www.monkeybreadsoftware.net/class-ekstructuredlocationmbs.shtml"
		  linksMBS.Value("EnvironmentMBS")="https://www.monkeybreadsoftware.net/class-environmentmbs.shtml"
		  linksMBS.Value("ExifTagMBS")="https://www.monkeybreadsoftware.net/class-exiftagmbs.shtml"
		  linksMBS.Value("ExifTagsMBS")="https://www.monkeybreadsoftware.net/class-exiftagsmbs.shtml"
		  linksMBS.Value("FileListMBS")="https://www.monkeybreadsoftware.net/class-filelistmbs.shtml"
		  linksMBS.Value("FileMappingMBS")="https://www.monkeybreadsoftware.net/class-filemappingmbs.shtml"
		  linksMBS.Value("FileMappingViewMBS")="https://www.monkeybreadsoftware.net/class-filemappingviewmbs.shtml"
		  linksMBS.Value("FinderSelectionMBS")="https://www.monkeybreadsoftware.net/class-finderselectionmbs.shtml"
		  linksMBS.Value("FMAdminMBS")="https://www.monkeybreadsoftware.net/class-fmadminmbs.shtml"
		  linksMBS.Value("FMConnectionMBS")="https://www.monkeybreadsoftware.net/class-fmconnectionmbs.shtml"
		  linksMBS.Value("FMContainerUploadMBS")="https://www.monkeybreadsoftware.net/class-fmcontaineruploadmbs.shtml"
		  linksMBS.Value("FMDataMBS")="https://www.monkeybreadsoftware.net/class-fmdatambs.shtml"
		  linksMBS.Value("FMDataSourceMBS")="https://www.monkeybreadsoftware.net/class-fmdatasourcembs.shtml"
		  linksMBS.Value("FMRequestMBS")="https://www.monkeybreadsoftware.net/class-fmrequestmbs.shtml"
		  linksMBS.Value("FMResponseMBS")="https://www.monkeybreadsoftware.net/class-fmresponsembs.shtml"
		  linksMBS.Value("FolderItem")="https://www.monkeybreadsoftware.net/class-folderitem.shtml"
		  linksMBS.Value("FSEventsMBS")="https://www.monkeybreadsoftware.net/class-fseventsmbs.shtml"
		  linksMBS.Value("GameKitMBS")="https://www.monkeybreadsoftware.net/class-gamekitmbs.shtml"
		  linksMBS.Value("GammaFadeMBS")="https://www.monkeybreadsoftware.net/class-gammafadembs.shtml"
		  linksMBS.Value("GammaMBS")="https://www.monkeybreadsoftware.net/class-gammambs.shtml"
		  linksMBS.Value("GifBlockMBS")="https://www.monkeybreadsoftware.net/class-gifblockmbs.shtml"
		  linksMBS.Value("GifDataMBS")="https://www.monkeybreadsoftware.net/class-gifdatambs.shtml"
		  linksMBS.Value("GifExtensionMBS")="https://www.monkeybreadsoftware.net/class-gifextensionmbs.shtml"
		  linksMBS.Value("GIFMBS")="https://www.monkeybreadsoftware.net/class-gifmbs.shtml"
		  linksMBS.Value("GifPaletteMBS")="https://www.monkeybreadsoftware.net/class-gifpalettembs.shtml"
		  linksMBS.Value("GIFPictureMBS")="https://www.monkeybreadsoftware.net/class-gifpicturembs.shtml"
		  linksMBS.Value("GifScreenMBS")="https://www.monkeybreadsoftware.net/class-gifscreenmbs.shtml"
		  linksMBS.Value("GKAchievementChallengeMBS")="https://www.monkeybreadsoftware.net/class-gkachievementchallengembs.shtml"
		  linksMBS.Value("GKAchievementDescriptionMBS")="https://www.monkeybreadsoftware.net/class-gkachievementdescriptionmbs.shtml"
		  linksMBS.Value("GKAchievementMBS")="https://www.monkeybreadsoftware.net/class-gkachievementmbs.shtml"
		  linksMBS.Value("GKAchievementViewControllerMBS")="https://www.monkeybreadsoftware.net/class-gkachievementviewcontrollermbs.shtml"
		  linksMBS.Value("GKChallengeMBS")="https://www.monkeybreadsoftware.net/class-gkchallengembs.shtml"
		  linksMBS.Value("GKChallengesViewControllerMBS")="https://www.monkeybreadsoftware.net/class-gkchallengesviewcontrollermbs.shtml"
		  linksMBS.Value("GKDialogControllerMBS")="https://www.monkeybreadsoftware.net/class-gkdialogcontrollermbs.shtml"
		  linksMBS.Value("GKFriendRequestComposeViewControllerMBS")="https://www.monkeybreadsoftware.net/class-gkfriendrequestcomposeviewcontrollermbs.shtml"
		  linksMBS.Value("GKGameCenterViewControllerMBS")="https://www.monkeybreadsoftware.net/class-gkgamecenterviewcontrollermbs.shtml"
		  linksMBS.Value("GKInviteMBS")="https://www.monkeybreadsoftware.net/class-gkinvitembs.shtml"
		  linksMBS.Value("GKLeaderboardMBS")="https://www.monkeybreadsoftware.net/class-gkleaderboardmbs.shtml"
		  linksMBS.Value("GKLeaderboardViewControllerMBS")="https://www.monkeybreadsoftware.net/class-gkleaderboardviewcontrollermbs.shtml"
		  linksMBS.Value("GKLocalPlayerMBS")="https://www.monkeybreadsoftware.net/class-gklocalplayermbs.shtml"
		  linksMBS.Value("GKMatchmakerMBS")="https://www.monkeybreadsoftware.net/class-gkmatchmakermbs.shtml"
		  linksMBS.Value("GKMatchmakerViewControllerMBS")="https://www.monkeybreadsoftware.net/class-gkmatchmakerviewcontrollermbs.shtml"
		  linksMBS.Value("GKMatchMBS")="https://www.monkeybreadsoftware.net/class-gkmatchmbs.shtml"
		  linksMBS.Value("GKMatchRequestMBS")="https://www.monkeybreadsoftware.net/class-gkmatchrequestmbs.shtml"
		  linksMBS.Value("GKPlayerMBS")="https://www.monkeybreadsoftware.net/class-gkplayermbs.shtml"
		  linksMBS.Value("GKScoreChallengeMBS")="https://www.monkeybreadsoftware.net/class-gkscorechallengembs.shtml"
		  linksMBS.Value("GKScoreMBS")="https://www.monkeybreadsoftware.net/class-gkscorembs.shtml"
		  linksMBS.Value("GKTurnBasedMatchmakerViewControllerMBS")="https://www.monkeybreadsoftware.net/class-gkturnbasedmatchmakerviewcontrollermbs.shtml"
		  linksMBS.Value("GKTurnBasedMatchMBS")="https://www.monkeybreadsoftware.net/class-gkturnbasedmatchmbs.shtml"
		  linksMBS.Value("GKTurnBasedParticipantMBS")="https://www.monkeybreadsoftware.net/class-gkturnbasedparticipantmbs.shtml"
		  linksMBS.Value("GKVoiceChatMBS")="https://www.monkeybreadsoftware.net/class-gkvoicechatmbs.shtml"
		  linksMBS.Value("GlobalExceptionHandlerMBS")="https://www.monkeybreadsoftware.net/class-globalexceptionhandlermbs.shtml"
		  linksMBS.Value("GM16BlobMBS")="https://www.monkeybreadsoftware.net/class-gm16blobmbs.shtml"
		  linksMBS.Value("GM16CoderInfoMBS")="https://www.monkeybreadsoftware.net/class-gm16coderinfombs.shtml"
		  linksMBS.Value("GM16ColorGrayMBS")="https://www.monkeybreadsoftware.net/class-gm16colorgraymbs.shtml"
		  linksMBS.Value("GM16ColorHSLMBS")="https://www.monkeybreadsoftware.net/class-gm16colorhslmbs.shtml"
		  linksMBS.Value("GM16ColorMBS")="https://www.monkeybreadsoftware.net/class-gm16colormbs.shtml"
		  linksMBS.Value("GM16ColorMonoMBS")="https://www.monkeybreadsoftware.net/class-gm16colormonombs.shtml"
		  linksMBS.Value("GM16ColorRGBMBS")="https://www.monkeybreadsoftware.net/class-gm16colorrgbmbs.shtml"
		  linksMBS.Value("GM16ColorYUVMBS")="https://www.monkeybreadsoftware.net/class-gm16coloryuvmbs.shtml"
		  linksMBS.Value("GM16ConvertMBS")="https://www.monkeybreadsoftware.net/class-gm16convertmbs.shtml"
		  linksMBS.Value("GM16CoordinateMBS")="https://www.monkeybreadsoftware.net/class-gm16coordinatembs.shtml"
		  linksMBS.Value("GM16ErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-gm16errorexceptionmbs.shtml"
		  linksMBS.Value("GM16GeometryMBS")="https://www.monkeybreadsoftware.net/class-gm16geometrymbs.shtml"
		  linksMBS.Value("GM16GraphicsMBS")="https://www.monkeybreadsoftware.net/class-gm16graphicsmbs.shtml"
		  linksMBS.Value("GM16ImageArrayMBS")="https://www.monkeybreadsoftware.net/class-gm16imagearraymbs.shtml"
		  linksMBS.Value("GM16ImageChannelStatisticsMBS")="https://www.monkeybreadsoftware.net/class-gm16imagechannelstatisticsmbs.shtml"
		  linksMBS.Value("GM16ImageMBS")="https://www.monkeybreadsoftware.net/class-gm16imagembs.shtml"
		  linksMBS.Value("GM16ImageStatisticsMBS")="https://www.monkeybreadsoftware.net/class-gm16imagestatisticsmbs.shtml"
		  linksMBS.Value("GM16LockMBS")="https://www.monkeybreadsoftware.net/class-gm16lockmbs.shtml"
		  linksMBS.Value("GM16MontageFramedMBS")="https://www.monkeybreadsoftware.net/class-gm16montageframedmbs.shtml"
		  linksMBS.Value("GM16MontageMBS")="https://www.monkeybreadsoftware.net/class-gm16montagembs.shtml"
		  linksMBS.Value("GM16MutexLockMBS")="https://www.monkeybreadsoftware.net/class-gm16mutexlockmbs.shtml"
		  linksMBS.Value("GM16NotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-gm16notinitializedexceptionmbs.shtml"
		  linksMBS.Value("GM16PathArgsMBS")="https://www.monkeybreadsoftware.net/class-gm16pathargsmbs.shtml"
		  linksMBS.Value("GM16PixelsMBS")="https://www.monkeybreadsoftware.net/class-gm16pixelsmbs.shtml"
		  linksMBS.Value("GM16TypeMetricMBS")="https://www.monkeybreadsoftware.net/class-gm16typemetricmbs.shtml"
		  linksMBS.Value("GM16UnsupportedExceptionMBS")="https://www.monkeybreadsoftware.net/class-gm16unsupportedexceptionmbs.shtml"
		  linksMBS.Value("GMBlobMBS")="https://www.monkeybreadsoftware.net/class-gmblobmbs.shtml"
		  linksMBS.Value("GMCoderInfoMBS")="https://www.monkeybreadsoftware.net/class-gmcoderinfombs.shtml"
		  linksMBS.Value("GMColorGrayMBS")="https://www.monkeybreadsoftware.net/class-gmcolorgraymbs.shtml"
		  linksMBS.Value("GMColorHSLMBS")="https://www.monkeybreadsoftware.net/class-gmcolorhslmbs.shtml"
		  linksMBS.Value("GMColorMBS")="https://www.monkeybreadsoftware.net/class-gmcolormbs.shtml"
		  linksMBS.Value("GMColorMonoMBS")="https://www.monkeybreadsoftware.net/class-gmcolormonombs.shtml"
		  linksMBS.Value("GMColorRGBMBS")="https://www.monkeybreadsoftware.net/class-gmcolorrgbmbs.shtml"
		  linksMBS.Value("GMColorYUVMBS")="https://www.monkeybreadsoftware.net/class-gmcoloryuvmbs.shtml"
		  linksMBS.Value("GMConvertMBS")="https://www.monkeybreadsoftware.net/class-gmconvertmbs.shtml"
		  linksMBS.Value("GMCoordinateMBS")="https://www.monkeybreadsoftware.net/class-gmcoordinatembs.shtml"
		  linksMBS.Value("GMErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-gmerrorexceptionmbs.shtml"
		  linksMBS.Value("GMGeometryMBS")="https://www.monkeybreadsoftware.net/class-gmgeometrymbs.shtml"
		  linksMBS.Value("GMGraphicsMBS")="https://www.monkeybreadsoftware.net/class-gmgraphicsmbs.shtml"
		  linksMBS.Value("GMImageArrayMBS")="https://www.monkeybreadsoftware.net/class-gmimagearraymbs.shtml"
		  linksMBS.Value("GMImageChannelStatisticsMBS")="https://www.monkeybreadsoftware.net/class-gmimagechannelstatisticsmbs.shtml"
		  linksMBS.Value("GMImageMBS")="https://www.monkeybreadsoftware.net/class-gmimagembs.shtml"
		  linksMBS.Value("GMImageStatisticsMBS")="https://www.monkeybreadsoftware.net/class-gmimagestatisticsmbs.shtml"
		  linksMBS.Value("GMLockMBS")="https://www.monkeybreadsoftware.net/class-gmlockmbs.shtml"
		  linksMBS.Value("GMMontageFramedMBS")="https://www.monkeybreadsoftware.net/class-gmmontageframedmbs.shtml"
		  linksMBS.Value("GMMontageMBS")="https://www.monkeybreadsoftware.net/class-gmmontagembs.shtml"
		  linksMBS.Value("GMMutexLockMBS")="https://www.monkeybreadsoftware.net/class-gmmutexlockmbs.shtml"
		  linksMBS.Value("GMNotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-gmnotinitializedexceptionmbs.shtml"
		  linksMBS.Value("GMPathArgsMBS")="https://www.monkeybreadsoftware.net/class-gmpathargsmbs.shtml"
		  linksMBS.Value("GMPixelsMBS")="https://www.monkeybreadsoftware.net/class-gmpixelsmbs.shtml"
		  linksMBS.Value("GMTypeMetricMBS")="https://www.monkeybreadsoftware.net/class-gmtypemetricmbs.shtml"
		  linksMBS.Value("GMUnsupportedExceptionMBS")="https://www.monkeybreadsoftware.net/class-gmunsupportedexceptionmbs.shtml"
		  linksMBS.Value("Graphics")="https://www.monkeybreadsoftware.net/class-graphics.shtml"
		  linksMBS.Value("Groupbox")="https://www.monkeybreadsoftware.net/class-groupbox.shtml"
		  linksMBS.Value("GTKWindowMBS")="https://www.monkeybreadsoftware.net/class-gtkwindowmbs.shtml"
		  linksMBS.Value("GZipFileMBS")="https://www.monkeybreadsoftware.net/class-gzipfilembs.shtml"
		  linksMBS.Value("HASPHLDMBS")="https://www.monkeybreadsoftware.net/class-hasphldmbs.shtml"
		  linksMBS.Value("HIDAPIDeviceInfoMBS")="https://www.monkeybreadsoftware.net/class-hidapideviceinfombs.shtml"
		  linksMBS.Value("HIDAPIDeviceMBS")="https://www.monkeybreadsoftware.net/class-hidapidevicembs.shtml"
		  linksMBS.Value("HotKeyMBS")="https://www.monkeybreadsoftware.net/class-hotkeymbs.shtml"
		  linksMBS.Value("HTMLViewer")="https://www.monkeybreadsoftware.net/class-htmlviewer.shtml"
		  linksMBS.Value("ICCameraDeviceMBS")="https://www.monkeybreadsoftware.net/class-iccameradevicembs.shtml"
		  linksMBS.Value("ICCameraFileMBS")="https://www.monkeybreadsoftware.net/class-iccamerafilembs.shtml"
		  linksMBS.Value("ICCameraFolderMBS")="https://www.monkeybreadsoftware.net/class-iccamerafoldermbs.shtml"
		  linksMBS.Value("ICCameraItemMBS")="https://www.monkeybreadsoftware.net/class-iccameraitemmbs.shtml"
		  linksMBS.Value("ICDeviceBrowserMBS")="https://www.monkeybreadsoftware.net/class-icdevicebrowsermbs.shtml"
		  linksMBS.Value("ICDeviceMBS")="https://www.monkeybreadsoftware.net/class-icdevicembs.shtml"
		  linksMBS.Value("IconMBS")="https://www.monkeybreadsoftware.net/class-iconmbs.shtml"
		  linksMBS.Value("ICScannerBandDataMBS")="https://www.monkeybreadsoftware.net/class-icscannerbanddatambs.shtml"
		  linksMBS.Value("ICScannerDeviceMBS")="https://www.monkeybreadsoftware.net/class-icscannerdevicembs.shtml"
		  linksMBS.Value("ICScannerFeatureBooleanMBS")="https://www.monkeybreadsoftware.net/class-icscannerfeaturebooleanmbs.shtml"
		  linksMBS.Value("ICScannerFeatureEnumerationMBS")="https://www.monkeybreadsoftware.net/class-icscannerfeatureenumerationmbs.shtml"
		  linksMBS.Value("ICScannerFeatureMBS")="https://www.monkeybreadsoftware.net/class-icscannerfeaturembs.shtml"
		  linksMBS.Value("ICScannerFeatureRangeMBS")="https://www.monkeybreadsoftware.net/class-icscannerfeaturerangembs.shtml"
		  linksMBS.Value("ICScannerFeatureTemplateMBS")="https://www.monkeybreadsoftware.net/class-icscannerfeaturetemplatembs.shtml"
		  linksMBS.Value("ICScannerFunctionalUnitDocumentFeederMBS")="https://www.monkeybreadsoftware.net/class-icscannerfunctionalunitdocumentfeedermbs.shtml"
		  linksMBS.Value("ICScannerFunctionalUnitFlatbedMBS")="https://www.monkeybreadsoftware.net/class-icscannerfunctionalunitflatbedmbs.shtml"
		  linksMBS.Value("ICScannerFunctionalUnitMBS")="https://www.monkeybreadsoftware.net/class-icscannerfunctionalunitmbs.shtml"
		  linksMBS.Value("ICScannerFunctionalUnitNegativeTransparencyMBS")="https://www.monkeybreadsoftware.net/class-icscannerfunctionalunitnegativetransparencymbs.shtml"
		  linksMBS.Value("ICScannerFunctionalUnitPositiveTransparencyMBS")="https://www.monkeybreadsoftware.net/class-icscannerfunctionalunitpositivetransparencymbs.shtml"
		  linksMBS.Value("IEDocumentMBS")="https://www.monkeybreadsoftware.net/class-iedocumentmbs.shtml"
		  linksMBS.Value("IEExceptionMBS")="https://www.monkeybreadsoftware.net/class-ieexceptionmbs.shtml"
		  linksMBS.Value("IEHistoryMBS")="https://www.monkeybreadsoftware.net/class-iehistorymbs.shtml"
		  linksMBS.Value("IENavigatorMBS")="https://www.monkeybreadsoftware.net/class-ienavigatormbs.shtml"
		  linksMBS.Value("IEWebBrowserMBS")="https://www.monkeybreadsoftware.net/class-iewebbrowsermbs.shtml"
		  linksMBS.Value("IEWindowMBS")="https://www.monkeybreadsoftware.net/class-iewindowmbs.shtml"
		  linksMBS.Value("IKCameraDeviceViewMBS")="https://www.monkeybreadsoftware.net/class-ikcameradeviceviewmbs.shtml"
		  linksMBS.Value("IKDeviceBrowserViewMBS")="https://www.monkeybreadsoftware.net/class-ikdevicebrowserviewmbs.shtml"
		  linksMBS.Value("IKImageBrowserCellMBS")="https://www.monkeybreadsoftware.net/class-ikimagebrowsercellmbs.shtml"
		  linksMBS.Value("IKImageBrowserItemMBS")="https://www.monkeybreadsoftware.net/class-ikimagebrowseritemmbs.shtml"
		  linksMBS.Value("IKImageBrowserViewMBS")="https://www.monkeybreadsoftware.net/class-ikimagebrowserviewmbs.shtml"
		  linksMBS.Value("IKImageEditPanelMBS")="https://www.monkeybreadsoftware.net/class-ikimageeditpanelmbs.shtml"
		  linksMBS.Value("IKImageViewMBS")="https://www.monkeybreadsoftware.net/class-ikimageviewmbs.shtml"
		  linksMBS.Value("IKPictureTakerMBS")="https://www.monkeybreadsoftware.net/class-ikpicturetakermbs.shtml"
		  linksMBS.Value("IKScannerDeviceViewMBS")="https://www.monkeybreadsoftware.net/class-ikscannerdeviceviewmbs.shtml"
		  linksMBS.Value("IKSlideshowMBS")="https://www.monkeybreadsoftware.net/class-ikslideshowmbs.shtml"
		  linksMBS.Value("ImageCaptureEventsMBS")="https://www.monkeybreadsoftware.net/class-imagecaptureeventsmbs.shtml"
		  linksMBS.Value("ImageMagickQ16MBS")="https://www.monkeybreadsoftware.net/class-imagemagickq16mbs.shtml"
		  linksMBS.Value("ImageMagickQ32MBS")="https://www.monkeybreadsoftware.net/class-imagemagickq32mbs.shtml"
		  linksMBS.Value("ImageMagickQ8MBS")="https://www.monkeybreadsoftware.net/class-imagemagickq8mbs.shtml"
		  linksMBS.Value("ImageWell")="https://www.monkeybreadsoftware.net/class-imagewell.shtml"
		  linksMBS.Value("IMChannelStatistics7MBS")="https://www.monkeybreadsoftware.net/class-imchannelstatistics7mbs.shtml"
		  linksMBS.Value("IMColorQ16MBS")="https://www.monkeybreadsoftware.net/class-imcolorq16mbs.shtml"
		  linksMBS.Value("IMColorQ32MBS")="https://www.monkeybreadsoftware.net/class-imcolorq32mbs.shtml"
		  linksMBS.Value("IMColorQ8MBS")="https://www.monkeybreadsoftware.net/class-imcolorq8mbs.shtml"
		  linksMBS.Value("IMException7MBS")="https://www.monkeybreadsoftware.net/class-imexception7mbs.shtml"
		  linksMBS.Value("IMExceptionQ16MBS")="https://www.monkeybreadsoftware.net/class-imexceptionq16mbs.shtml"
		  linksMBS.Value("IMExceptionQ32MBS")="https://www.monkeybreadsoftware.net/class-imexceptionq32mbs.shtml"
		  linksMBS.Value("IMExceptionQ8MBS")="https://www.monkeybreadsoftware.net/class-imexceptionq8mbs.shtml"
		  linksMBS.Value("IMFrameInfo7MBS")="https://www.monkeybreadsoftware.net/class-imframeinfo7mbs.shtml"
		  linksMBS.Value("IMGeometryInfo7MBS")="https://www.monkeybreadsoftware.net/class-imgeometryinfo7mbs.shtml"
		  linksMBS.Value("IMImage7MBS")="https://www.monkeybreadsoftware.net/class-imimage7mbs.shtml"
		  linksMBS.Value("IMImageAffineMatrix7MBS")="https://www.monkeybreadsoftware.net/class-imimageaffinematrix7mbs.shtml"
		  linksMBS.Value("IMImageAffineMatrixQ16MBS")="https://www.monkeybreadsoftware.net/class-imimageaffinematrixq16mbs.shtml"
		  linksMBS.Value("IMImageAffineMatrixQ32MBS")="https://www.monkeybreadsoftware.net/class-imimageaffinematrixq32mbs.shtml"
		  linksMBS.Value("IMImageAffineMatrixQ8MBS")="https://www.monkeybreadsoftware.net/class-imimageaffinematrixq8mbs.shtml"
		  linksMBS.Value("IMImageAttributeQ16MBS")="https://www.monkeybreadsoftware.net/class-imimageattributeq16mbs.shtml"
		  linksMBS.Value("IMImageAttributeQ32MBS")="https://www.monkeybreadsoftware.net/class-imimageattributeq32mbs.shtml"
		  linksMBS.Value("IMImageAttributeQ8MBS")="https://www.monkeybreadsoftware.net/class-imimageattributeq8mbs.shtml"
		  linksMBS.Value("IMImageInfo7MBS")="https://www.monkeybreadsoftware.net/class-imimageinfo7mbs.shtml"
		  linksMBS.Value("IMImageInfoQ16MBS")="https://www.monkeybreadsoftware.net/class-imimageinfoq16mbs.shtml"
		  linksMBS.Value("IMImageInfoQ32MBS")="https://www.monkeybreadsoftware.net/class-imimageinfoq32mbs.shtml"
		  linksMBS.Value("IMImageInfoQ8MBS")="https://www.monkeybreadsoftware.net/class-imimageinfoq8mbs.shtml"
		  linksMBS.Value("IMImageQ16MBS")="https://www.monkeybreadsoftware.net/class-imimageq16mbs.shtml"
		  linksMBS.Value("IMImageQ32MBS")="https://www.monkeybreadsoftware.net/class-imimageq32mbs.shtml"
		  linksMBS.Value("IMImageQ8MBS")="https://www.monkeybreadsoftware.net/class-imimageq8mbs.shtml"
		  linksMBS.Value("IMKernelInfo7MBS")="https://www.monkeybreadsoftware.net/class-imkernelinfo7mbs.shtml"
		  linksMBS.Value("IMMagickInfo7MBS")="https://www.monkeybreadsoftware.net/class-immagickinfo7mbs.shtml"
		  linksMBS.Value("IMMagickInfoList7MBS")="https://www.monkeybreadsoftware.net/class-immagickinfolist7mbs.shtml"
		  linksMBS.Value("IMMagickInfoListQ16MBS")="https://www.monkeybreadsoftware.net/class-immagickinfolistq16mbs.shtml"
		  linksMBS.Value("IMMagickInfoListQ32MBS")="https://www.monkeybreadsoftware.net/class-immagickinfolistq32mbs.shtml"
		  linksMBS.Value("IMMagickInfoListQ8MBS")="https://www.monkeybreadsoftware.net/class-immagickinfolistq8mbs.shtml"
		  linksMBS.Value("IMMagickInfoQ16MBS")="https://www.monkeybreadsoftware.net/class-immagickinfoq16mbs.shtml"
		  linksMBS.Value("IMMagickInfoQ32MBS")="https://www.monkeybreadsoftware.net/class-immagickinfoq32mbs.shtml"
		  linksMBS.Value("IMMagickInfoQ8MBS")="https://www.monkeybreadsoftware.net/class-immagickinfoq8mbs.shtml"
		  linksMBS.Value("IMMagickPixelPacketQ16MBS")="https://www.monkeybreadsoftware.net/class-immagickpixelpacketq16mbs.shtml"
		  linksMBS.Value("IMMagickPixelPacketQ32MBS")="https://www.monkeybreadsoftware.net/class-immagickpixelpacketq32mbs.shtml"
		  linksMBS.Value("IMMagickPixelPacketQ8MBS")="https://www.monkeybreadsoftware.net/class-immagickpixelpacketq8mbs.shtml"
		  linksMBS.Value("IMMissingFunctionException7MBS")="https://www.monkeybreadsoftware.net/class-immissingfunctionexception7mbs.shtml"
		  linksMBS.Value("IMMissingFunctionExceptionQ16MBS")="https://www.monkeybreadsoftware.net/class-immissingfunctionexceptionq16mbs.shtml"
		  linksMBS.Value("IMMissingFunctionExceptionQ32MBS")="https://www.monkeybreadsoftware.net/class-immissingfunctionexceptionq32mbs.shtml"
		  linksMBS.Value("IMMissingFunctionExceptionQ8MBS")="https://www.monkeybreadsoftware.net/class-immissingfunctionexceptionq8mbs.shtml"
		  linksMBS.Value("IMMontageInfo7MBS")="https://www.monkeybreadsoftware.net/class-immontageinfo7mbs.shtml"
		  linksMBS.Value("IMOptionInfo7MBS")="https://www.monkeybreadsoftware.net/class-imoptioninfo7mbs.shtml"
		  linksMBS.Value("IMPixelInfo7MBS")="https://www.monkeybreadsoftware.net/class-impixelinfo7mbs.shtml"
		  linksMBS.Value("IMPointInfo7MBS")="https://www.monkeybreadsoftware.net/class-impointinfo7mbs.shtml"
		  linksMBS.Value("IMQuantizeInfo7MBS")="https://www.monkeybreadsoftware.net/class-imquantizeinfo7mbs.shtml"
		  linksMBS.Value("IMRectangleInfo7MBS")="https://www.monkeybreadsoftware.net/class-imrectangleinfo7mbs.shtml"
		  linksMBS.Value("InstantMessageMBS")="https://www.monkeybreadsoftware.net/class-instantmessagembs.shtml"
		  linksMBS.Value("IntegerHashSetIteratorMBS")="https://www.monkeybreadsoftware.net/class-integerhashsetiteratormbs.shtml"
		  linksMBS.Value("IntegerHashSetMBS")="https://www.monkeybreadsoftware.net/class-integerhashsetmbs.shtml"
		  linksMBS.Value("IntegerOrderedSetIteratorMBS")="https://www.monkeybreadsoftware.net/class-integerorderedsetiteratormbs.shtml"
		  linksMBS.Value("IntegerOrderedSetMBS")="https://www.monkeybreadsoftware.net/class-integerorderedsetmbs.shtml"
		  linksMBS.Value("IntegerPointMBS")="https://www.monkeybreadsoftware.net/class-integerpointmbs.shtml"
		  linksMBS.Value("IntegerRectMBS")="https://www.monkeybreadsoftware.net/class-integerrectmbs.shtml"
		  linksMBS.Value("IntegerToIntegerHashMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-integertointegerhashmapiteratormbs.shtml"
		  linksMBS.Value("IntegerToIntegerHashMapMBS")="https://www.monkeybreadsoftware.net/class-integertointegerhashmapmbs.shtml"
		  linksMBS.Value("IntegerToIntegerOrderedMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-integertointegerorderedmapiteratormbs.shtml"
		  linksMBS.Value("IntegerToIntegerOrderedMapMBS")="https://www.monkeybreadsoftware.net/class-integertointegerorderedmapmbs.shtml"
		  linksMBS.Value("IntegerToStringHashMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-integertostringhashmapiteratormbs.shtml"
		  linksMBS.Value("IntegerToStringHashMapMBS")="https://www.monkeybreadsoftware.net/class-integertostringhashmapmbs.shtml"
		  linksMBS.Value("IntegerToStringOrderedMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-integertostringorderedmapiteratormbs.shtml"
		  linksMBS.Value("IntegerToStringOrderedMapMBS")="https://www.monkeybreadsoftware.net/class-integertostringorderedmapmbs.shtml"
		  linksMBS.Value("IntegerToVariantHashMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-integertovarianthashmapiteratormbs.shtml"
		  linksMBS.Value("IntegerToVariantHashMapMBS")="https://www.monkeybreadsoftware.net/class-integertovarianthashmapmbs.shtml"
		  linksMBS.Value("IntegerToVariantOrderedMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-integertovariantorderedmapiteratormbs.shtml"
		  linksMBS.Value("IntegerToVariantOrderedMapMBS")="https://www.monkeybreadsoftware.net/class-integertovariantorderedmapmbs.shtml"
		  linksMBS.Value("IOBluetoothDeviceInquiryMBS")="https://www.monkeybreadsoftware.net/class-iobluetoothdeviceinquirymbs.shtml"
		  linksMBS.Value("IOBluetoothDeviceMBS")="https://www.monkeybreadsoftware.net/class-iobluetoothdevicembs.shtml"
		  linksMBS.Value("IOBluetoothDeviceSelectorControllerMBS")="https://www.monkeybreadsoftware.net/class-iobluetoothdeviceselectorcontrollermbs.shtml"
		  linksMBS.Value("IOBluetoothHostControllerMBS")="https://www.monkeybreadsoftware.net/class-iobluetoothhostcontrollermbs.shtml"
		  linksMBS.Value("IOBluetoothRFCOMMChannelMBS")="https://www.monkeybreadsoftware.net/class-iobluetoothrfcommchannelmbs.shtml"
		  linksMBS.Value("IOBluetoothSDPDataElementMBS")="https://www.monkeybreadsoftware.net/class-iobluetoothsdpdataelementmbs.shtml"
		  linksMBS.Value("IOBluetoothSDPServiceAttributeMBS")="https://www.monkeybreadsoftware.net/class-iobluetoothsdpserviceattributembs.shtml"
		  linksMBS.Value("IOBluetoothSDPServiceRecordMBS")="https://www.monkeybreadsoftware.net/class-iobluetoothsdpservicerecordmbs.shtml"
		  linksMBS.Value("IOBluetoothSDPUUIDMBS")="https://www.monkeybreadsoftware.net/class-iobluetoothsdpuuidmbs.shtml"
		  linksMBS.Value("IOBluetoothServiceBrowserControllerMBS")="https://www.monkeybreadsoftware.net/class-iobluetoothservicebrowsercontrollermbs.shtml"
		  linksMBS.Value("IOPMAssertionMBS")="https://www.monkeybreadsoftware.net/class-iopmassertionmbs.shtml"
		  linksMBS.Value("IOPMMBS")="https://www.monkeybreadsoftware.net/class-iopmmbs.shtml"
		  linksMBS.Value("IOPowerSourcesMBS")="https://www.monkeybreadsoftware.net/class-iopowersourcesmbs.shtml"
		  linksMBS.Value("IORegistryNodeMBS")="https://www.monkeybreadsoftware.net/class-ioregistrynodembs.shtml"
		  linksMBS.Value("IOWarriorCarbonDeviceMBS")="https://www.monkeybreadsoftware.net/class-iowarriorcarbondevicembs.shtml"
		  linksMBS.Value("IOWarriorCarbonMBS")="https://www.monkeybreadsoftware.net/class-iowarriorcarbonmbs.shtml"
		  linksMBS.Value("IOWarriorWindowsMBS")="https://www.monkeybreadsoftware.net/class-iowarriorwindowsmbs.shtml"
		  linksMBS.Value("ITAddressMBS")="https://www.monkeybreadsoftware.net/class-itaddressmbs.shtml"
		  linksMBS.Value("ITCallInfoMBS")="https://www.monkeybreadsoftware.net/class-itcallinfombs.shtml"
		  linksMBS.Value("iTunesLibraryAlbumMBS")="https://www.monkeybreadsoftware.net/class-ituneslibraryalbummbs.shtml"
		  linksMBS.Value("iTunesLibraryArtistMBS")="https://www.monkeybreadsoftware.net/class-ituneslibraryartistmbs.shtml"
		  linksMBS.Value("iTunesLibraryArtworkMBS")="https://www.monkeybreadsoftware.net/class-ituneslibraryartworkmbs.shtml"
		  linksMBS.Value("iTunesLibraryMBS")="https://www.monkeybreadsoftware.net/class-ituneslibrarymbs.shtml"
		  linksMBS.Value("iTunesLibraryMediaEntityMBS")="https://www.monkeybreadsoftware.net/class-ituneslibrarymediaentitymbs.shtml"
		  linksMBS.Value("iTunesLibraryMediaItemMBS")="https://www.monkeybreadsoftware.net/class-ituneslibrarymediaitemmbs.shtml"
		  linksMBS.Value("iTunesLibraryMediaItemVideoInfoMBS")="https://www.monkeybreadsoftware.net/class-ituneslibrarymediaitemvideoinfombs.shtml"
		  linksMBS.Value("iTunesLibraryPlaylistMBS")="https://www.monkeybreadsoftware.net/class-ituneslibraryplaylistmbs.shtml"
		  linksMBS.Value("JavaArrayMBS")="https://www.monkeybreadsoftware.net/class-javaarraymbs.shtml"
		  linksMBS.Value("JavaBlobMBS")="https://www.monkeybreadsoftware.net/class-javablobmbs.shtml"
		  linksMBS.Value("JavaBooleanArrayMBS")="https://www.monkeybreadsoftware.net/class-javabooleanarraymbs.shtml"
		  linksMBS.Value("JavaByteArrayMBS")="https://www.monkeybreadsoftware.net/class-javabytearraymbs.shtml"
		  linksMBS.Value("JavaCallableStatementMBS")="https://www.monkeybreadsoftware.net/class-javacallablestatementmbs.shtml"
		  linksMBS.Value("JavaCharArrayMBS")="https://www.monkeybreadsoftware.net/class-javachararraymbs.shtml"
		  linksMBS.Value("JavaClassMBS")="https://www.monkeybreadsoftware.net/class-javaclassmbs.shtml"
		  linksMBS.Value("JavaClobMBS")="https://www.monkeybreadsoftware.net/class-javaclobmbs.shtml"
		  linksMBS.Value("JavaConnectionMBS")="https://www.monkeybreadsoftware.net/class-javaconnectionmbs.shtml"
		  linksMBS.Value("JavaDatabaseMBS")="https://www.monkeybreadsoftware.net/class-javadatabasembs.shtml"
		  linksMBS.Value("JavaDatabaseMetaDataMBS")="https://www.monkeybreadsoftware.net/class-javadatabasemetadatambs.shtml"
		  linksMBS.Value("JavaDoubleArrayMBS")="https://www.monkeybreadsoftware.net/class-javadoublearraymbs.shtml"
		  linksMBS.Value("JavaExceptionMBS")="https://www.monkeybreadsoftware.net/class-javaexceptionmbs.shtml"
		  linksMBS.Value("JavaFieldMBS")="https://www.monkeybreadsoftware.net/class-javafieldmbs.shtml"
		  linksMBS.Value("JavaFloatArrayMBS")="https://www.monkeybreadsoftware.net/class-javafloatarraymbs.shtml"
		  linksMBS.Value("JavaHandleNilExceptionMBS")="https://www.monkeybreadsoftware.net/class-javahandlenilexceptionmbs.shtml"
		  linksMBS.Value("JavaInputStreamMBS")="https://www.monkeybreadsoftware.net/class-javainputstreammbs.shtml"
		  linksMBS.Value("JavaIntArrayMBS")="https://www.monkeybreadsoftware.net/class-javaintarraymbs.shtml"
		  linksMBS.Value("JavaLongArrayMBS")="https://www.monkeybreadsoftware.net/class-javalongarraymbs.shtml"
		  linksMBS.Value("JavaMethodMBS")="https://www.monkeybreadsoftware.net/class-javamethodmbs.shtml"
		  linksMBS.Value("JavaNotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-javanotinitializedexceptionmbs.shtml"
		  linksMBS.Value("JavaObjectArrayMBS")="https://www.monkeybreadsoftware.net/class-javaobjectarraymbs.shtml"
		  linksMBS.Value("JavaObjectMBS")="https://www.monkeybreadsoftware.net/class-javaobjectmbs.shtml"
		  linksMBS.Value("JavaParameterMetaDataMBS")="https://www.monkeybreadsoftware.net/class-javaparametermetadatambs.shtml"
		  linksMBS.Value("JavaPreparedStatementMBS")="https://www.monkeybreadsoftware.net/class-javapreparedstatementmbs.shtml"
		  linksMBS.Value("JavaResultSetMBS")="https://www.monkeybreadsoftware.net/class-javaresultsetmbs.shtml"
		  linksMBS.Value("JavaResultSetMetaDataMBS")="https://www.monkeybreadsoftware.net/class-javaresultsetmetadatambs.shtml"
		  linksMBS.Value("JavaRuntimeMBS")="https://www.monkeybreadsoftware.net/class-javaruntimembs.shtml"
		  linksMBS.Value("JavaSavepointMBS")="https://www.monkeybreadsoftware.net/class-javasavepointmbs.shtml"
		  linksMBS.Value("JavaScriptDateComponentsMBS")="https://www.monkeybreadsoftware.net/class-javascriptdatecomponentsmbs.shtml"
		  linksMBS.Value("JavaScriptEngineExceptionMBS")="https://www.monkeybreadsoftware.net/class-javascriptengineexceptionmbs.shtml"
		  linksMBS.Value("JavaScriptEngineMBS")="https://www.monkeybreadsoftware.net/class-javascriptenginembs.shtml"
		  linksMBS.Value("JavaShortArrayMBS")="https://www.monkeybreadsoftware.net/class-javashortarraymbs.shtml"
		  linksMBS.Value("JavaStatementMBS")="https://www.monkeybreadsoftware.net/class-javastatementmbs.shtml"
		  linksMBS.Value("JavaStringMBS")="https://www.monkeybreadsoftware.net/class-javastringmbs.shtml"
		  linksMBS.Value("JavaThrowableMBS")="https://www.monkeybreadsoftware.net/class-javathrowablembs.shtml"
		  linksMBS.Value("JavaVMMBS")="https://www.monkeybreadsoftware.net/class-javavmmbs.shtml"
		  linksMBS.Value("JPEG2000MBS")="https://www.monkeybreadsoftware.net/class-jpeg2000mbs.shtml"
		  linksMBS.Value("JPEGExporterMBS")="https://www.monkeybreadsoftware.net/class-jpegexportermbs.shtml"
		  linksMBS.Value("JPEGImporterMarkerMBS")="https://www.monkeybreadsoftware.net/class-jpegimportermarkermbs.shtml"
		  linksMBS.Value("JPEGImporterMBS")="https://www.monkeybreadsoftware.net/class-jpegimportermbs.shtml"
		  linksMBS.Value("JPEGMovieMBS")="https://www.monkeybreadsoftware.net/class-jpegmoviembs.shtml"
		  linksMBS.Value("JPEGTransformationMBS")="https://www.monkeybreadsoftware.net/class-jpegtransformationmbs.shtml"
		  linksMBS.Value("JSClassMBS")="https://www.monkeybreadsoftware.net/class-jsclassmbs.shtml"
		  linksMBS.Value("JSContextMBS")="https://www.monkeybreadsoftware.net/class-jscontextmbs.shtml"
		  linksMBS.Value("JSObjectMBS")="https://www.monkeybreadsoftware.net/class-jsobjectmbs.shtml"
		  linksMBS.Value("JSONMBS")="https://www.monkeybreadsoftware.net/class-jsonmbs.shtml"
		  linksMBS.Value("JSValueMBS")="https://www.monkeybreadsoftware.net/class-jsvaluembs.shtml"
		  linksMBS.Value("KeychainAccessControlMBS")="https://www.monkeybreadsoftware.net/class-keychainaccesscontrolmbs.shtml"
		  linksMBS.Value("KeychainItemMBS")="https://www.monkeybreadsoftware.net/class-keychainitemmbs.shtml"
		  linksMBS.Value("KeychainMBS")="https://www.monkeybreadsoftware.net/class-keychainmbs.shtml"
		  linksMBS.Value("KeychainSearchMBS")="https://www.monkeybreadsoftware.net/class-keychainsearchmbs.shtml"
		  linksMBS.Value("KeychainSettingsMBS")="https://www.monkeybreadsoftware.net/class-keychainsettingsmbs.shtml"
		  linksMBS.Value("KeyCodesMBS")="https://www.monkeybreadsoftware.net/class-keycodesmbs.shtml"
		  linksMBS.Value("KeyValueCodingMBS")="https://www.monkeybreadsoftware.net/class-keyvaluecodingmbs.shtml"
		  linksMBS.Value("Label")="https://www.monkeybreadsoftware.net/class-label.shtml"
		  linksMBS.Value("LAContextMBS")="https://www.monkeybreadsoftware.net/class-lacontextmbs.shtml"
		  linksMBS.Value("LargeBinaryStreamMBS")="https://www.monkeybreadsoftware.net/class-largebinarystreammbs.shtml"
		  linksMBS.Value("LargeNumberErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-largenumbererrorexceptionmbs.shtml"
		  linksMBS.Value("LargeNumberMBS")="https://www.monkeybreadsoftware.net/class-largenumbermbs.shtml"
		  linksMBS.Value("LaunchServicesApplicationListMBS")="https://www.monkeybreadsoftware.net/class-launchservicesapplicationlistmbs.shtml"
		  linksMBS.Value("LaunchServicesItemInfoMBS")="https://www.monkeybreadsoftware.net/class-launchservicesiteminfombs.shtml"
		  linksMBS.Value("LaunchServicesLaunchParameterMBS")="https://www.monkeybreadsoftware.net/class-launchserviceslaunchparametermbs.shtml"
		  linksMBS.Value("LaunchServicesStringListMBS")="https://www.monkeybreadsoftware.net/class-launchservicesstringlistmbs.shtml"
		  linksMBS.Value("LCMS2BitmapMBS")="https://www.monkeybreadsoftware.net/class-lcms2bitmapmbs.shtml"
		  linksMBS.Value("LCMS2CIECAM02MBS")="https://www.monkeybreadsoftware.net/class-lcms2ciecam02mbs.shtml"
		  linksMBS.Value("LCMS2CIELabMBS")="https://www.monkeybreadsoftware.net/class-lcms2cielabmbs.shtml"
		  linksMBS.Value("LCMS2CIELChMBS")="https://www.monkeybreadsoftware.net/class-lcms2cielchmbs.shtml"
		  linksMBS.Value("LCMS2CIExyYMBS")="https://www.monkeybreadsoftware.net/class-lcms2ciexyymbs.shtml"
		  linksMBS.Value("LCMS2CIExyYTripleMBS")="https://www.monkeybreadsoftware.net/class-lcms2ciexyytriplembs.shtml"
		  linksMBS.Value("LCMS2CIEXYZMBS")="https://www.monkeybreadsoftware.net/class-lcms2ciexyzmbs.shtml"
		  linksMBS.Value("LCMS2CIEXYZTripleMBS")="https://www.monkeybreadsoftware.net/class-lcms2ciexyztriplembs.shtml"
		  linksMBS.Value("LCMS2ContextMBS")="https://www.monkeybreadsoftware.net/class-lcms2contextmbs.shtml"
		  linksMBS.Value("LCMS2CurveSegmentMBS")="https://www.monkeybreadsoftware.net/class-lcms2curvesegmentmbs.shtml"
		  linksMBS.Value("LCMS2DateMBS")="https://www.monkeybreadsoftware.net/class-lcms2datembs.shtml"
		  linksMBS.Value("LCMS2DictionaryEntryMBS")="https://www.monkeybreadsoftware.net/class-lcms2dictionaryentrymbs.shtml"
		  linksMBS.Value("LCMS2DictionaryMBS")="https://www.monkeybreadsoftware.net/class-lcms2dictionarymbs.shtml"
		  linksMBS.Value("LCMS2GamutBoundaryDescriptionMBS")="https://www.monkeybreadsoftware.net/class-lcms2gamutboundarydescriptionmbs.shtml"
		  linksMBS.Value("LCMS2ICCDataMBS")="https://www.monkeybreadsoftware.net/class-lcms2iccdatambs.shtml"
		  linksMBS.Value("LCMS2ICCMeasurementConditionsMBS")="https://www.monkeybreadsoftware.net/class-lcms2iccmeasurementconditionsmbs.shtml"
		  linksMBS.Value("LCMS2ICCViewingConditionsMBS")="https://www.monkeybreadsoftware.net/class-lcms2iccviewingconditionsmbs.shtml"
		  linksMBS.Value("LCMS2IT8MBS")="https://www.monkeybreadsoftware.net/class-lcms2it8mbs.shtml"
		  linksMBS.Value("LCMS2JChMBS")="https://www.monkeybreadsoftware.net/class-lcms2jchmbs.shtml"
		  linksMBS.Value("LCMS2Mat3MBS")="https://www.monkeybreadsoftware.net/class-lcms2mat3mbs.shtml"
		  linksMBS.Value("LCMS2MLUMBS")="https://www.monkeybreadsoftware.net/class-lcms2mlumbs.shtml"
		  linksMBS.Value("LCMS2NamedColorListMBS")="https://www.monkeybreadsoftware.net/class-lcms2namedcolorlistmbs.shtml"
		  linksMBS.Value("LCMS2PipelineMBS")="https://www.monkeybreadsoftware.net/class-lcms2pipelinembs.shtml"
		  linksMBS.Value("LCMS2ProfileMBS")="https://www.monkeybreadsoftware.net/class-lcms2profilembs.shtml"
		  linksMBS.Value("LCMS2ScreeningChannelMBS")="https://www.monkeybreadsoftware.net/class-lcms2screeningchannelmbs.shtml"
		  linksMBS.Value("LCMS2ScreeningMBS")="https://www.monkeybreadsoftware.net/class-lcms2screeningmbs.shtml"
		  linksMBS.Value("LCMS2SequenceDescriptionMBS")="https://www.monkeybreadsoftware.net/class-lcms2sequencedescriptionmbs.shtml"
		  linksMBS.Value("LCMS2SequenceMBS")="https://www.monkeybreadsoftware.net/class-lcms2sequencembs.shtml"
		  linksMBS.Value("LCMS2StageMBS")="https://www.monkeybreadsoftware.net/class-lcms2stagembs.shtml"
		  linksMBS.Value("LCMS2StageSamplerMBS")="https://www.monkeybreadsoftware.net/class-lcms2stagesamplermbs.shtml"
		  linksMBS.Value("LCMS2ToneCurveMBS")="https://www.monkeybreadsoftware.net/class-lcms2tonecurvembs.shtml"
		  linksMBS.Value("LCMS2TransformMBS")="https://www.monkeybreadsoftware.net/class-lcms2transformmbs.shtml"
		  linksMBS.Value("LCMS2UcrBgMBS")="https://www.monkeybreadsoftware.net/class-lcms2ucrbgmbs.shtml"
		  linksMBS.Value("LCMS2Vec3MBS")="https://www.monkeybreadsoftware.net/class-lcms2vec3mbs.shtml"
		  linksMBS.Value("LCMS2ViewingConditionsMBS")="https://www.monkeybreadsoftware.net/class-lcms2viewingconditionsmbs.shtml"
		  linksMBS.Value("LDAPMBS")="https://www.monkeybreadsoftware.net/class-ldapmbs.shtml"
		  linksMBS.Value("LDAPModMBS")="https://www.monkeybreadsoftware.net/class-ldapmodmbs.shtml"
		  linksMBS.Value("LGLAbortedExceptionMBS")="https://www.monkeybreadsoftware.net/class-lglabortedexceptionmbs.shtml"
		  linksMBS.Value("LGLMBS")="https://www.monkeybreadsoftware.net/class-lglmbs.shtml"
		  linksMBS.Value("LibUSBConfigDescriptorMBS")="https://www.monkeybreadsoftware.net/class-libusbconfigdescriptormbs.shtml"
		  linksMBS.Value("LibUSBDeviceDescriptorMBS")="https://www.monkeybreadsoftware.net/class-libusbdevicedescriptormbs.shtml"
		  linksMBS.Value("LibUSBDeviceMBS")="https://www.monkeybreadsoftware.net/class-libusbdevicembs.shtml"
		  linksMBS.Value("LibUSBEndpointDescriptorMBS")="https://www.monkeybreadsoftware.net/class-libusbendpointdescriptormbs.shtml"
		  linksMBS.Value("LibUSBInterfaceDescriptorMBS")="https://www.monkeybreadsoftware.net/class-libusbinterfacedescriptormbs.shtml"
		  linksMBS.Value("LibUSBInterfaceMBS")="https://www.monkeybreadsoftware.net/class-libusbinterfacembs.shtml"
		  linksMBS.Value("LibUSBISOPacketDescriptorMBS")="https://www.monkeybreadsoftware.net/class-libusbisopacketdescriptormbs.shtml"
		  linksMBS.Value("LibUSBTransferMBS")="https://www.monkeybreadsoftware.net/class-libusbtransfermbs.shtml"
		  linksMBS.Value("LibUSBVersionMBS")="https://www.monkeybreadsoftware.net/class-libusbversionmbs.shtml"
		  linksMBS.Value("LinuxHIDInterfaceMBS")="https://www.monkeybreadsoftware.net/class-linuxhidinterfacembs.shtml"
		  linksMBS.Value("LinuxJavaScriptContextMBS")="https://www.monkeybreadsoftware.net/class-linuxjavascriptcontextmbs.shtml"
		  linksMBS.Value("LinuxProcessMBS")="https://www.monkeybreadsoftware.net/class-linuxprocessmbs.shtml"
		  linksMBS.Value("LinuxSuMBS")="https://www.monkeybreadsoftware.net/class-linuxsumbs.shtml"
		  linksMBS.Value("LinuxSysInfoMBS")="https://www.monkeybreadsoftware.net/class-linuxsysinfombs.shtml"
		  linksMBS.Value("LinuxUSBBusMBS")="https://www.monkeybreadsoftware.net/class-linuxusbbusmbs.shtml"
		  linksMBS.Value("LinuxUSBDeviceDescriptionMBS")="https://www.monkeybreadsoftware.net/class-linuxusbdevicedescriptionmbs.shtml"
		  linksMBS.Value("LinuxUSBDeviceHandleMBS")="https://www.monkeybreadsoftware.net/class-linuxusbdevicehandlembs.shtml"
		  linksMBS.Value("LinuxUSBDeviceMBS")="https://www.monkeybreadsoftware.net/class-linuxusbdevicembs.shtml"
		  linksMBS.Value("LinuxWebBackForwardListMBS")="https://www.monkeybreadsoftware.net/class-linuxwebbackforwardlistmbs.shtml"
		  linksMBS.Value("LinuxWebCookieMBS")="https://www.monkeybreadsoftware.net/class-linuxwebcookiembs.shtml"
		  linksMBS.Value("LinuxWebCookieStoreMBS")="https://www.monkeybreadsoftware.net/class-linuxwebcookiestorembs.shtml"
		  linksMBS.Value("LinuxWebDataSourceMBS")="https://www.monkeybreadsoftware.net/class-linuxwebdatasourcembs.shtml"
		  linksMBS.Value("LinuxWebFrameMBS")="https://www.monkeybreadsoftware.net/class-linuxwebframembs.shtml"
		  linksMBS.Value("LinuxWebHistoryItemMBS")="https://www.monkeybreadsoftware.net/class-linuxwebhistoryitemmbs.shtml"
		  linksMBS.Value("LinuxWebInspectorMBS")="https://www.monkeybreadsoftware.net/class-linuxwebinspectormbs.shtml"
		  linksMBS.Value("LinuxWebNetworkRequestMBS")="https://www.monkeybreadsoftware.net/class-linuxwebnetworkrequestmbs.shtml"
		  linksMBS.Value("LinuxWebNetworkResponseMBS")="https://www.monkeybreadsoftware.net/class-linuxwebnetworkresponsembs.shtml"
		  linksMBS.Value("LinuxWebResourceMBS")="https://www.monkeybreadsoftware.net/class-linuxwebresourcembs.shtml"
		  linksMBS.Value("LinuxWebSettingsMBS")="https://www.monkeybreadsoftware.net/class-linuxwebsettingsmbs.shtml"
		  linksMBS.Value("LinuxWebViewMBS")="https://www.monkeybreadsoftware.net/class-linuxwebviewmbs.shtml"
		  linksMBS.Value("Listbox")="https://www.monkeybreadsoftware.net/class-listbox.shtml"
		  linksMBS.Value("LMFitControlMBS")="https://www.monkeybreadsoftware.net/class-lmfitcontrolmbs.shtml"
		  linksMBS.Value("LMFitMBS")="https://www.monkeybreadsoftware.net/class-lmfitmbs.shtml"
		  linksMBS.Value("LMFitStatusMBS")="https://www.monkeybreadsoftware.net/class-lmfitstatusmbs.shtml"
		  linksMBS.Value("LocaleMBS")="https://www.monkeybreadsoftware.net/class-localembs.shtml"
		  linksMBS.Value("LoginItemsMBS")="https://www.monkeybreadsoftware.net/class-loginitemsmbs.shtml"
		  linksMBS.Value("LSSharedFileListItemMBS")="https://www.monkeybreadsoftware.net/class-lssharedfilelistitemmbs.shtml"
		  linksMBS.Value("LSSharedFileListMBS")="https://www.monkeybreadsoftware.net/class-lssharedfilelistmbs.shtml"
		  linksMBS.Value("LTCDecoderMBS")="https://www.monkeybreadsoftware.net/class-ltcdecodermbs.shtml"
		  linksMBS.Value("LTCEncoderMBS")="https://www.monkeybreadsoftware.net/class-ltcencodermbs.shtml"
		  linksMBS.Value("LTCFrameExtMBS")="https://www.monkeybreadsoftware.net/class-ltcframeextmbs.shtml"
		  linksMBS.Value("LTCFrameMBS")="https://www.monkeybreadsoftware.net/class-ltcframembs.shtml"
		  linksMBS.Value("LTCSMPTETimecodeMBS")="https://www.monkeybreadsoftware.net/class-ltcsmptetimecodembs.shtml"
		  linksMBS.Value("MAAttachedWindowMBS")="https://www.monkeybreadsoftware.net/class-maattachedwindowmbs.shtml"
		  linksMBS.Value("MacFileOperationMBS")="https://www.monkeybreadsoftware.net/class-macfileoperationmbs.shtml"
		  linksMBS.Value("MacFileOperationStatusMBS")="https://www.monkeybreadsoftware.net/class-macfileoperationstatusmbs.shtml"
		  linksMBS.Value("MacHIDMBS")="https://www.monkeybreadsoftware.net/class-machidmbs.shtml"
		  linksMBS.Value("MacQuarantinePropertiesMBS")="https://www.monkeybreadsoftware.net/class-macquarantinepropertiesmbs.shtml"
		  linksMBS.Value("MacUSBDeviceMBS")="https://www.monkeybreadsoftware.net/class-macusbdevicembs.shtml"
		  linksMBS.Value("MacUSBMBS")="https://www.monkeybreadsoftware.net/class-macusbmbs.shtml"
		  linksMBS.Value("MacUSBNotificationMBS")="https://www.monkeybreadsoftware.net/class-macusbnotificationmbs.shtml"
		  linksMBS.Value("MapiFileMBS")="https://www.monkeybreadsoftware.net/class-mapifilembs.shtml"
		  linksMBS.Value("MapiMessageMBS")="https://www.monkeybreadsoftware.net/class-mapimessagembs.shtml"
		  linksMBS.Value("MapiRecipientMBS")="https://www.monkeybreadsoftware.net/class-mapirecipientmbs.shtml"
		  linksMBS.Value("MarkdownDocumentMBS")="https://www.monkeybreadsoftware.net/class-markdowndocumentmbs.shtml"
		  linksMBS.Value("MarkdownFootnoteMBS")="https://www.monkeybreadsoftware.net/class-markdownfootnotembs.shtml"
		  linksMBS.Value("MarkdownLineMBS")="https://www.monkeybreadsoftware.net/class-markdownlinembs.shtml"
		  linksMBS.Value("MarkdownParagraphMBS")="https://www.monkeybreadsoftware.net/class-markdownparagraphmbs.shtml"
		  linksMBS.Value("MD5DigestMBS")="https://www.monkeybreadsoftware.net/class-md5digestmbs.shtml"
		  linksMBS.Value("MDItemMBS")="https://www.monkeybreadsoftware.net/class-mditemmbs.shtml"
		  linksMBS.Value("MDQueryBatchingParamsMBS")="https://www.monkeybreadsoftware.net/class-mdquerybatchingparamsmbs.shtml"
		  linksMBS.Value("MDQueryMBS")="https://www.monkeybreadsoftware.net/class-mdquerymbs.shtml"
		  linksMBS.Value("MediaKeysMBS")="https://www.monkeybreadsoftware.net/class-mediakeysmbs.shtml"
		  linksMBS.Value("Memoryblock")="https://www.monkeybreadsoftware.net/class-memoryblock.shtml"
		  linksMBS.Value("MemoryBlockMBS")="https://www.monkeybreadsoftware.net/class-memoryblockmbs.shtml"
		  linksMBS.Value("MemoryStatisticsMBS")="https://www.monkeybreadsoftware.net/class-memorystatisticsmbs.shtml"
		  linksMBS.Value("MemoryStorageMBS")="https://www.monkeybreadsoftware.net/class-memorystoragembs.shtml"
		  linksMBS.Value("MFPMediaItemMBS")="https://www.monkeybreadsoftware.net/class-mfpmediaitemmbs.shtml"
		  linksMBS.Value("MFPMediaPlayerExceptionMBS")="https://www.monkeybreadsoftware.net/class-mfpmediaplayerexceptionmbs.shtml"
		  linksMBS.Value("MFPMediaPlayerMBS")="https://www.monkeybreadsoftware.net/class-mfpmediaplayermbs.shtml"
		  linksMBS.Value("MidiClientMBS")="https://www.monkeybreadsoftware.net/class-midiclientmbs.shtml"
		  linksMBS.Value("MidiDeviceMBS")="https://www.monkeybreadsoftware.net/class-mididevicembs.shtml"
		  linksMBS.Value("MidiEndpointMBS")="https://www.monkeybreadsoftware.net/class-midiendpointmbs.shtml"
		  linksMBS.Value("MidiEntityMBS")="https://www.monkeybreadsoftware.net/class-midientitymbs.shtml"
		  linksMBS.Value("MidiObjectMBS")="https://www.monkeybreadsoftware.net/class-midiobjectmbs.shtml"
		  linksMBS.Value("MidiPacketListMBS")="https://www.monkeybreadsoftware.net/class-midipacketlistmbs.shtml"
		  linksMBS.Value("MidiPacketMBS")="https://www.monkeybreadsoftware.net/class-midipacketmbs.shtml"
		  linksMBS.Value("MidiPlaybackMBS")="https://www.monkeybreadsoftware.net/class-midiplaybackmbs.shtml"
		  linksMBS.Value("MidiPortMBS")="https://www.monkeybreadsoftware.net/class-midiportmbs.shtml"
		  linksMBS.Value("MIDISysexSendRequestMBS")="https://www.monkeybreadsoftware.net/class-midisysexsendrequestmbs.shtml"
		  linksMBS.Value("MidiThruConnectionControlTransformMBS")="https://www.monkeybreadsoftware.net/class-midithruconnectioncontroltransformmbs.shtml"
		  linksMBS.Value("MidiThruConnectionEndpointMBS")="https://www.monkeybreadsoftware.net/class-midithruconnectionendpointmbs.shtml"
		  linksMBS.Value("MidiThruConnectionMBS")="https://www.monkeybreadsoftware.net/class-midithruconnectionmbs.shtml"
		  linksMBS.Value("MidiThruConnectionParamsMBS")="https://www.monkeybreadsoftware.net/class-midithruconnectionparamsmbs.shtml"
		  linksMBS.Value("MidiThruConnectionTransformMBS")="https://www.monkeybreadsoftware.net/class-midithruconnectiontransformmbs.shtml"
		  linksMBS.Value("MidiThruConnectionValueMapMBS")="https://www.monkeybreadsoftware.net/class-midithruconnectionvaluemapmbs.shtml"
		  linksMBS.Value("MimeAddressListMBS")="https://www.monkeybreadsoftware.net/class-mimeaddresslistmbs.shtml"
		  linksMBS.Value("MimeAddressMBS")="https://www.monkeybreadsoftware.net/class-mimeaddressmbs.shtml"
		  linksMBS.Value("MimeAttachmentMBS")="https://www.monkeybreadsoftware.net/class-mimeattachmentmbs.shtml"
		  linksMBS.Value("MimeBodyMBS")="https://www.monkeybreadsoftware.net/class-mimebodymbs.shtml"
		  linksMBS.Value("MimeEmailMBS")="https://www.monkeybreadsoftware.net/class-mimeemailmbs.shtml"
		  linksMBS.Value("MimeEntityMBS")="https://www.monkeybreadsoftware.net/class-mimeentitymbs.shtml"
		  linksMBS.Value("MimeFieldMBS")="https://www.monkeybreadsoftware.net/class-mimefieldmbs.shtml"
		  linksMBS.Value("MimeGroupMBS")="https://www.monkeybreadsoftware.net/class-mimegroupmbs.shtml"
		  linksMBS.Value("MimeHeaderMBS")="https://www.monkeybreadsoftware.net/class-mimeheadermbs.shtml"
		  linksMBS.Value("MimeMailboxListMBS")="https://www.monkeybreadsoftware.net/class-mimemailboxlistmbs.shtml"
		  linksMBS.Value("MimeMailboxMBS")="https://www.monkeybreadsoftware.net/class-mimemailboxmbs.shtml"
		  linksMBS.Value("MKAnnotationViewMBS")="https://www.monkeybreadsoftware.net/class-mkannotationviewmbs.shtml"
		  linksMBS.Value("MKCircleMBS")="https://www.monkeybreadsoftware.net/class-mkcirclembs.shtml"
		  linksMBS.Value("MKCircleRendererMBS")="https://www.monkeybreadsoftware.net/class-mkcirclerenderermbs.shtml"
		  linksMBS.Value("MKClusterAnnotationMBS")="https://www.monkeybreadsoftware.net/class-mkclusterannotationmbs.shtml"
		  linksMBS.Value("MKCoordinateRegionMBS")="https://www.monkeybreadsoftware.net/class-mkcoordinateregionmbs.shtml"
		  linksMBS.Value("MKCoordinateSpanMBS")="https://www.monkeybreadsoftware.net/class-mkcoordinatespanmbs.shtml"
		  linksMBS.Value("MKCustomAnnotationMBS")="https://www.monkeybreadsoftware.net/class-mkcustomannotationmbs.shtml"
		  linksMBS.Value("MKCustomOverlayMBS")="https://www.monkeybreadsoftware.net/class-mkcustomoverlaymbs.shtml"
		  linksMBS.Value("MKCustomOverlayRendererMBS")="https://www.monkeybreadsoftware.net/class-mkcustomoverlayrenderermbs.shtml"
		  linksMBS.Value("MKDirectionsMBS")="https://www.monkeybreadsoftware.net/class-mkdirectionsmbs.shtml"
		  linksMBS.Value("MKDirectionsRequestMBS")="https://www.monkeybreadsoftware.net/class-mkdirectionsrequestmbs.shtml"
		  linksMBS.Value("MKDirectionsResponseMBS")="https://www.monkeybreadsoftware.net/class-mkdirectionsresponsembs.shtml"
		  linksMBS.Value("MKDistanceFormatterMBS")="https://www.monkeybreadsoftware.net/class-mkdistanceformattermbs.shtml"
		  linksMBS.Value("MKETAResponseMBS")="https://www.monkeybreadsoftware.net/class-mketaresponsembs.shtml"
		  linksMBS.Value("MKGeodesicPolylineMBS")="https://www.monkeybreadsoftware.net/class-mkgeodesicpolylinembs.shtml"
		  linksMBS.Value("MKLocalSearchCompleterMBS")="https://www.monkeybreadsoftware.net/class-mklocalsearchcompletermbs.shtml"
		  linksMBS.Value("MKLocalSearchCompletionMBS")="https://www.monkeybreadsoftware.net/class-mklocalsearchcompletionmbs.shtml"
		  linksMBS.Value("MKLocalSearchMBS")="https://www.monkeybreadsoftware.net/class-mklocalsearchmbs.shtml"
		  linksMBS.Value("MKLocalSearchRequestMBS")="https://www.monkeybreadsoftware.net/class-mklocalsearchrequestmbs.shtml"
		  linksMBS.Value("MKLocalSearchResponseMBS")="https://www.monkeybreadsoftware.net/class-mklocalsearchresponsembs.shtml"
		  linksMBS.Value("MKMapCameraMBS")="https://www.monkeybreadsoftware.net/class-mkmapcamerambs.shtml"
		  linksMBS.Value("MKMapItemMBS")="https://www.monkeybreadsoftware.net/class-mkmapitemmbs.shtml"
		  linksMBS.Value("MKMapPointMBS")="https://www.monkeybreadsoftware.net/class-mkmappointmbs.shtml"
		  linksMBS.Value("MKMapRectMBS")="https://www.monkeybreadsoftware.net/class-mkmaprectmbs.shtml"
		  linksMBS.Value("MKMapSizeMBS")="https://www.monkeybreadsoftware.net/class-mkmapsizembs.shtml"
		  linksMBS.Value("MKMapSnapshotMBS")="https://www.monkeybreadsoftware.net/class-mkmapsnapshotmbs.shtml"
		  linksMBS.Value("MKMapSnapshotOptionsMBS")="https://www.monkeybreadsoftware.net/class-mkmapsnapshotoptionsmbs.shtml"
		  linksMBS.Value("MKMapSnapshotterMBS")="https://www.monkeybreadsoftware.net/class-mkmapsnapshottermbs.shtml"
		  linksMBS.Value("MKMapViewMBS")="https://www.monkeybreadsoftware.net/class-mkmapviewmbs.shtml"
		  linksMBS.Value("MKMarkerAnnotationViewMBS")="https://www.monkeybreadsoftware.net/class-mkmarkerannotationviewmbs.shtml"
		  linksMBS.Value("MKMultiPointMBS")="https://www.monkeybreadsoftware.net/class-mkmultipointmbs.shtml"
		  linksMBS.Value("MKMultiPolygonMBS")="https://www.monkeybreadsoftware.net/class-mkmultipolygonmbs.shtml"
		  linksMBS.Value("MKMultiPolygonRendererMBS")="https://www.monkeybreadsoftware.net/class-mkmultipolygonrenderermbs.shtml"
		  linksMBS.Value("MKMultiPolylineMBS")="https://www.monkeybreadsoftware.net/class-mkmultipolylinembs.shtml"
		  linksMBS.Value("MKMultiPolylineRendererMBS")="https://www.monkeybreadsoftware.net/class-mkmultipolylinerenderermbs.shtml"
		  linksMBS.Value("MKOverlayPathRendererMBS")="https://www.monkeybreadsoftware.net/class-mkoverlaypathrenderermbs.shtml"
		  linksMBS.Value("MKOverlayRendererMBS")="https://www.monkeybreadsoftware.net/class-mkoverlayrenderermbs.shtml"
		  linksMBS.Value("MKPinAnnotationViewMBS")="https://www.monkeybreadsoftware.net/class-mkpinannotationviewmbs.shtml"
		  linksMBS.Value("MKPlacemarkMBS")="https://www.monkeybreadsoftware.net/class-mkplacemarkmbs.shtml"
		  linksMBS.Value("MKPointAnnotationMBS")="https://www.monkeybreadsoftware.net/class-mkpointannotationmbs.shtml"
		  linksMBS.Value("MKPolygonMBS")="https://www.monkeybreadsoftware.net/class-mkpolygonmbs.shtml"
		  linksMBS.Value("MKPolygonRendererMBS")="https://www.monkeybreadsoftware.net/class-mkpolygonrenderermbs.shtml"
		  linksMBS.Value("MKPolylineMBS")="https://www.monkeybreadsoftware.net/class-mkpolylinembs.shtml"
		  linksMBS.Value("MKPolylineRendererMBS")="https://www.monkeybreadsoftware.net/class-mkpolylinerenderermbs.shtml"
		  linksMBS.Value("MKRouteMBS")="https://www.monkeybreadsoftware.net/class-mkroutembs.shtml"
		  linksMBS.Value("MKRouteStepMBS")="https://www.monkeybreadsoftware.net/class-mkroutestepmbs.shtml"
		  linksMBS.Value("MKShapeMBS")="https://www.monkeybreadsoftware.net/class-mkshapembs.shtml"
		  linksMBS.Value("MKTileOverlayMBS")="https://www.monkeybreadsoftware.net/class-mktileoverlaymbs.shtml"
		  linksMBS.Value("MKTileOverlayPathMBS")="https://www.monkeybreadsoftware.net/class-mktileoverlaypathmbs.shtml"
		  linksMBS.Value("MKTileOverlayRendererMBS")="https://www.monkeybreadsoftware.net/class-mktileoverlayrenderermbs.shtml"
		  linksMBS.Value("MKUserLocationMBS")="https://www.monkeybreadsoftware.net/class-mkuserlocationmbs.shtml"
		  linksMBS.Value("MLArrayBatchProviderMBS")="https://www.monkeybreadsoftware.net/class-mlarraybatchprovidermbs.shtml"
		  linksMBS.Value("MLBatchProviderMBS")="https://www.monkeybreadsoftware.net/class-mlbatchprovidermbs.shtml"
		  linksMBS.Value("MLDictionaryConstraintMBS")="https://www.monkeybreadsoftware.net/class-mldictionaryconstraintmbs.shtml"
		  linksMBS.Value("MLDictionaryFeatureProviderMBS")="https://www.monkeybreadsoftware.net/class-mldictionaryfeatureprovidermbs.shtml"
		  linksMBS.Value("MLFeatureDescriptionMBS")="https://www.monkeybreadsoftware.net/class-mlfeaturedescriptionmbs.shtml"
		  linksMBS.Value("MLFeatureProviderMBS")="https://www.monkeybreadsoftware.net/class-mlfeatureprovidermbs.shtml"
		  linksMBS.Value("MLFeatureValueMBS")="https://www.monkeybreadsoftware.net/class-mlfeaturevaluembs.shtml"
		  linksMBS.Value("MLImageConstraintMBS")="https://www.monkeybreadsoftware.net/class-mlimageconstraintmbs.shtml"
		  linksMBS.Value("MLImageSizeConstraintMBS")="https://www.monkeybreadsoftware.net/class-mlimagesizeconstraintmbs.shtml"
		  linksMBS.Value("MLImageSizeMBS")="https://www.monkeybreadsoftware.net/class-mlimagesizembs.shtml"
		  linksMBS.Value("MLKeyMBS")="https://www.monkeybreadsoftware.net/class-mlkeymbs.shtml"
		  linksMBS.Value("MLMediaGroupMBS")="https://www.monkeybreadsoftware.net/class-mlmediagroupmbs.shtml"
		  linksMBS.Value("MLMediaLibraryMBS")="https://www.monkeybreadsoftware.net/class-mlmedialibrarymbs.shtml"
		  linksMBS.Value("MLMediaObjectMBS")="https://www.monkeybreadsoftware.net/class-mlmediaobjectmbs.shtml"
		  linksMBS.Value("MLMediaSourceMBS")="https://www.monkeybreadsoftware.net/class-mlmediasourcembs.shtml"
		  linksMBS.Value("MLMetricKeyMBS")="https://www.monkeybreadsoftware.net/class-mlmetrickeymbs.shtml"
		  linksMBS.Value("MLModelConfigurationMBS")="https://www.monkeybreadsoftware.net/class-mlmodelconfigurationmbs.shtml"
		  linksMBS.Value("MLModelDescriptionMBS")="https://www.monkeybreadsoftware.net/class-mlmodeldescriptionmbs.shtml"
		  linksMBS.Value("MLModelMBS")="https://www.monkeybreadsoftware.net/class-mlmodelmbs.shtml"
		  linksMBS.Value("MLMultiArrayConstraintMBS")="https://www.monkeybreadsoftware.net/class-mlmultiarrayconstraintmbs.shtml"
		  linksMBS.Value("MLMultiArrayMBS")="https://www.monkeybreadsoftware.net/class-mlmultiarraymbs.shtml"
		  linksMBS.Value("MLMultiArrayShapeConstraintMBS")="https://www.monkeybreadsoftware.net/class-mlmultiarrayshapeconstraintmbs.shtml"
		  linksMBS.Value("MLNumericConstraintMBS")="https://www.monkeybreadsoftware.net/class-mlnumericconstraintmbs.shtml"
		  linksMBS.Value("MLParameterDescriptionMBS")="https://www.monkeybreadsoftware.net/class-mlparameterdescriptionmbs.shtml"
		  linksMBS.Value("MLParameterKeyMBS")="https://www.monkeybreadsoftware.net/class-mlparameterkeymbs.shtml"
		  linksMBS.Value("MLPredictionOptionsMBS")="https://www.monkeybreadsoftware.net/class-mlpredictionoptionsmbs.shtml"
		  linksMBS.Value("MLSequenceConstraintMBS")="https://www.monkeybreadsoftware.net/class-mlsequenceconstraintmbs.shtml"
		  linksMBS.Value("MLSequenceMBS")="https://www.monkeybreadsoftware.net/class-mlsequencembs.shtml"
		  linksMBS.Value("MLTaskMBS")="https://www.monkeybreadsoftware.net/class-mltaskmbs.shtml"
		  linksMBS.Value("MLUpdateContextMBS")="https://www.monkeybreadsoftware.net/class-mlupdatecontextmbs.shtml"
		  linksMBS.Value("MLUpdateProgressHandlersMBS")="https://www.monkeybreadsoftware.net/class-mlupdateprogresshandlersmbs.shtml"
		  linksMBS.Value("MLUpdateTaskMBS")="https://www.monkeybreadsoftware.net/class-mlupdatetaskmbs.shtml"
		  linksMBS.Value("MongoClientMBS")="https://www.monkeybreadsoftware.net/class-mongoclientmbs.shtml"
		  linksMBS.Value("MongoCollectionMBS")="https://www.monkeybreadsoftware.net/class-mongocollectionmbs.shtml"
		  linksMBS.Value("MongoCursorMBS")="https://www.monkeybreadsoftware.net/class-mongocursormbs.shtml"
		  linksMBS.Value("MongoDatabaseMBS")="https://www.monkeybreadsoftware.net/class-mongodatabasembs.shtml"
		  linksMBS.Value("MongoExceptionMBS")="https://www.monkeybreadsoftware.net/class-mongoexceptionmbs.shtml"
		  linksMBS.Value("MongoHostListMBS")="https://www.monkeybreadsoftware.net/class-mongohostlistmbs.shtml"
		  linksMBS.Value("MongoServerDescriptionMBS")="https://www.monkeybreadsoftware.net/class-mongoserverdescriptionmbs.shtml"
		  linksMBS.Value("MongoURIMBS")="https://www.monkeybreadsoftware.net/class-mongourimbs.shtml"
		  linksMBS.Value("Movie")="https://www.monkeybreadsoftware.net/class-movie.shtml"
		  linksMBS.Value("MoviePlayer")="https://www.monkeybreadsoftware.net/class-movieplayer.shtml"
		  linksMBS.Value("MutexMBS")="https://www.monkeybreadsoftware.net/class-mutexmbs.shtml"
		  linksMBS.Value("NamedMutexMBS")="https://www.monkeybreadsoftware.net/class-namedmutexmbs.shtml"
		  linksMBS.Value("NetFSMountMBS")="https://www.monkeybreadsoftware.net/class-netfsmountmbs.shtml"
		  linksMBS.Value("NetSNMPMBS")="https://www.monkeybreadsoftware.net/class-netsnmpmbs.shtml"
		  linksMBS.Value("NetworkInterfaceMBS")="https://www.monkeybreadsoftware.net/class-networkinterfacembs.shtml"
		  linksMBS.Value("NikonCapInfoMBS")="https://www.monkeybreadsoftware.net/class-nikoncapinfombs.shtml"
		  linksMBS.Value("NikonFileInfoMBS")="https://www.monkeybreadsoftware.net/class-nikonfileinfombs.shtml"
		  linksMBS.Value("NikonImageInfoMBS")="https://www.monkeybreadsoftware.net/class-nikonimageinfombs.shtml"
		  linksMBS.Value("NikonLiveImageMBS")="https://www.monkeybreadsoftware.net/class-nikonliveimagembs.shtml"
		  linksMBS.Value("NikonMBS")="https://www.monkeybreadsoftware.net/class-nikonmbs.shtml"
		  linksMBS.Value("NikonPointMBS")="https://www.monkeybreadsoftware.net/class-nikonpointmbs.shtml"
		  linksMBS.Value("NikonRectMBS")="https://www.monkeybreadsoftware.net/class-nikonrectmbs.shtml"
		  linksMBS.Value("NikonSizeMBS")="https://www.monkeybreadsoftware.net/class-nikonsizembs.shtml"
		  linksMBS.Value("NotificationCenterMBS")="https://www.monkeybreadsoftware.net/class-notificationcentermbs.shtml"
		  linksMBS.Value("NotificationMBS")="https://www.monkeybreadsoftware.net/class-notificationmbs.shtml"
		  linksMBS.Value("NotificationObserverMBS")="https://www.monkeybreadsoftware.net/class-notificationobservermbs.shtml"
		  linksMBS.Value("NSActionCellMBS")="https://www.monkeybreadsoftware.net/class-nsactioncellmbs.shtml"
		  linksMBS.Value("NSAffineTransformMBS")="https://www.monkeybreadsoftware.net/class-nsaffinetransformmbs.shtml"
		  linksMBS.Value("NSAlertMBS")="https://www.monkeybreadsoftware.net/class-nsalertmbs.shtml"
		  linksMBS.Value("NSAnimationContextMBS")="https://www.monkeybreadsoftware.net/class-nsanimationcontextmbs.shtml"
		  linksMBS.Value("NSAnimationMBS")="https://www.monkeybreadsoftware.net/class-nsanimationmbs.shtml"
		  linksMBS.Value("NSAppearanceMBS")="https://www.monkeybreadsoftware.net/class-nsappearancembs.shtml"
		  linksMBS.Value("NSAppleEventDescriptorMBS")="https://www.monkeybreadsoftware.net/class-nsappleeventdescriptormbs.shtml"
		  linksMBS.Value("NSAppleEventHandlerMBS")="https://www.monkeybreadsoftware.net/class-nsappleeventhandlermbs.shtml"
		  linksMBS.Value("NSAppleEventManagerMBS")="https://www.monkeybreadsoftware.net/class-nsappleeventmanagermbs.shtml"
		  linksMBS.Value("NSAppleEventManagerSuspensionIDMBS")="https://www.monkeybreadsoftware.net/class-nsappleeventmanagersuspensionidmbs.shtml"
		  linksMBS.Value("NSAppleScriptMBS")="https://www.monkeybreadsoftware.net/class-nsapplescriptmbs.shtml"
		  linksMBS.Value("NSApplicationDelegateMBS")="https://www.monkeybreadsoftware.net/class-nsapplicationdelegatembs.shtml"
		  linksMBS.Value("NSApplicationMBS")="https://www.monkeybreadsoftware.net/class-nsapplicationmbs.shtml"
		  linksMBS.Value("NSAttributedStringMBS")="https://www.monkeybreadsoftware.net/class-nsattributedstringmbs.shtml"
		  linksMBS.Value("NSAutoreleasePoolMBS")="https://www.monkeybreadsoftware.net/class-nsautoreleasepoolmbs.shtml"
		  linksMBS.Value("NSBezierPathMBS")="https://www.monkeybreadsoftware.net/class-nsbezierpathmbs.shtml"
		  linksMBS.Value("NSBitmapImageRepMBS")="https://www.monkeybreadsoftware.net/class-nsbitmapimagerepmbs.shtml"
		  linksMBS.Value("NSBoxMBS")="https://www.monkeybreadsoftware.net/class-nsboxmbs.shtml"
		  linksMBS.Value("NSBundleMBS")="https://www.monkeybreadsoftware.net/class-nsbundlembs.shtml"
		  linksMBS.Value("NSButtonCellMBS")="https://www.monkeybreadsoftware.net/class-nsbuttoncellmbs.shtml"
		  linksMBS.Value("NSButtonMBS")="https://www.monkeybreadsoftware.net/class-nsbuttonmbs.shtml"
		  linksMBS.Value("NSCachedURLResponseMBS")="https://www.monkeybreadsoftware.net/class-nscachedurlresponsembs.shtml"
		  linksMBS.Value("NSCalendarMBS")="https://www.monkeybreadsoftware.net/class-nscalendarmbs.shtml"
		  linksMBS.Value("NSCellMBS")="https://www.monkeybreadsoftware.net/class-nscellmbs.shtml"
		  linksMBS.Value("NSCharacterSetMBS")="https://www.monkeybreadsoftware.net/class-nscharactersetmbs.shtml"
		  linksMBS.Value("NSClipViewMBS")="https://www.monkeybreadsoftware.net/class-nsclipviewmbs.shtml"
		  linksMBS.Value("NSCoderMBS")="https://www.monkeybreadsoftware.net/class-nscodermbs.shtml"
		  linksMBS.Value("NSCollectionViewFlowLayoutInvalidationContextMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewflowlayoutinvalidationcontextmbs.shtml"
		  linksMBS.Value("NSCollectionViewFlowLayoutMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewflowlayoutmbs.shtml"
		  linksMBS.Value("NSCollectionViewGridLayoutMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewgridlayoutmbs.shtml"
		  linksMBS.Value("NSCollectionViewItemMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewitemmbs.shtml"
		  linksMBS.Value("NSCollectionViewLayoutAttributesMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewlayoutattributesmbs.shtml"
		  linksMBS.Value("NSCollectionViewLayoutInvalidationContextMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewlayoutinvalidationcontextmbs.shtml"
		  linksMBS.Value("NSCollectionViewLayoutMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewlayoutmbs.shtml"
		  linksMBS.Value("NSCollectionViewMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewmbs.shtml"
		  linksMBS.Value("NSCollectionViewSectionHeaderViewMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewsectionheaderviewmbs.shtml"
		  linksMBS.Value("NSCollectionViewTransitionLayoutMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewtransitionlayoutmbs.shtml"
		  linksMBS.Value("NSCollectionViewUpdateItemMBS")="https://www.monkeybreadsoftware.net/class-nscollectionviewupdateitemmbs.shtml"
		  linksMBS.Value("NSColorListMBS")="https://www.monkeybreadsoftware.net/class-nscolorlistmbs.shtml"
		  linksMBS.Value("NSColorMBS")="https://www.monkeybreadsoftware.net/class-nscolormbs.shtml"
		  linksMBS.Value("NSColorPanelMBS")="https://www.monkeybreadsoftware.net/class-nscolorpanelmbs.shtml"
		  linksMBS.Value("NSColorPickerTouchBarItemMBS")="https://www.monkeybreadsoftware.net/class-nscolorpickertouchbaritemmbs.shtml"
		  linksMBS.Value("NSColorSamplerMBS")="https://www.monkeybreadsoftware.net/class-nscolorsamplermbs.shtml"
		  linksMBS.Value("NSColorSpaceMBS")="https://www.monkeybreadsoftware.net/class-nscolorspacembs.shtml"
		  linksMBS.Value("NSComboBoxMBS")="https://www.monkeybreadsoftware.net/class-nscomboboxmbs.shtml"
		  linksMBS.Value("NSComparisonPredicateMBS")="https://www.monkeybreadsoftware.net/class-nscomparisonpredicatembs.shtml"
		  linksMBS.Value("NSCompoundPredicateMBS")="https://www.monkeybreadsoftware.net/class-nscompoundpredicatembs.shtml"
		  linksMBS.Value("NSControlMBS")="https://www.monkeybreadsoftware.net/class-nscontrolmbs.shtml"
		  linksMBS.Value("NSCursorMBS")="https://www.monkeybreadsoftware.net/class-nscursormbs.shtml"
		  linksMBS.Value("NSCustomTouchBarItemMBS")="https://www.monkeybreadsoftware.net/class-nscustomtouchbaritemmbs.shtml"
		  linksMBS.Value("NSDataDetectorMBS")="https://www.monkeybreadsoftware.net/class-nsdatadetectormbs.shtml"
		  linksMBS.Value("NSDateComponentsMBS")="https://www.monkeybreadsoftware.net/class-nsdatecomponentsmbs.shtml"
		  linksMBS.Value("NSDateIntervalMBS")="https://www.monkeybreadsoftware.net/class-nsdateintervalmbs.shtml"
		  linksMBS.Value("NSDatePickerMBS")="https://www.monkeybreadsoftware.net/class-nsdatepickermbs.shtml"
		  linksMBS.Value("NSDirectoryEnumeratorMBS")="https://www.monkeybreadsoftware.net/class-nsdirectoryenumeratormbs.shtml"
		  linksMBS.Value("NSDistributedNotificationCenterMBS")="https://www.monkeybreadsoftware.net/class-nsdistributednotificationcentermbs.shtml"
		  linksMBS.Value("NSDockTileMBS")="https://www.monkeybreadsoftware.net/class-nsdocktilembs.shtml"
		  linksMBS.Value("NSDraggingImageComponentMBS")="https://www.monkeybreadsoftware.net/class-nsdraggingimagecomponentmbs.shtml"
		  linksMBS.Value("NSDraggingInfoMBS")="https://www.monkeybreadsoftware.net/class-nsdragginginfombs.shtml"
		  linksMBS.Value("NSDraggingItemMBS")="https://www.monkeybreadsoftware.net/class-nsdraggingitemmbs.shtml"
		  linksMBS.Value("NSDraggingSessionMBS")="https://www.monkeybreadsoftware.net/class-nsdraggingsessionmbs.shtml"
		  linksMBS.Value("NSEdgeInsetsMBS")="https://www.monkeybreadsoftware.net/class-nsedgeinsetsmbs.shtml"
		  linksMBS.Value("NSEnumeratorMBS")="https://www.monkeybreadsoftware.net/class-nsenumeratormbs.shtml"
		  linksMBS.Value("NSEPSImageRepMBS")="https://www.monkeybreadsoftware.net/class-nsepsimagerepmbs.shtml"
		  linksMBS.Value("NSErrorMBS")="https://www.monkeybreadsoftware.net/class-nserrormbs.shtml"
		  linksMBS.Value("NSEventMBS")="https://www.monkeybreadsoftware.net/class-nseventmbs.shtml"
		  linksMBS.Value("NSEventMonitorMBS")="https://www.monkeybreadsoftware.net/class-nseventmonitormbs.shtml"
		  linksMBS.Value("NSExceptionHandlerMBS")="https://www.monkeybreadsoftware.net/class-nsexceptionhandlermbs.shtml"
		  linksMBS.Value("NSExceptionMBS")="https://www.monkeybreadsoftware.net/class-nsexceptionmbs.shtml"
		  linksMBS.Value("NSExpressionMBS")="https://www.monkeybreadsoftware.net/class-nsexpressionmbs.shtml"
		  linksMBS.Value("NSFileCoordinatorMBS")="https://www.monkeybreadsoftware.net/class-nsfilecoordinatormbs.shtml"
		  linksMBS.Value("NSFileHandleMBS")="https://www.monkeybreadsoftware.net/class-nsfilehandlembs.shtml"
		  linksMBS.Value("NSFileManagerMBS")="https://www.monkeybreadsoftware.net/class-nsfilemanagermbs.shtml"
		  linksMBS.Value("NSFilePresenterHandlerMBS")="https://www.monkeybreadsoftware.net/class-nsfilepresenterhandlermbs.shtml"
		  linksMBS.Value("NSFilePresenterMBS")="https://www.monkeybreadsoftware.net/class-nsfilepresentermbs.shtml"
		  linksMBS.Value("NSFileVersionMBS")="https://www.monkeybreadsoftware.net/class-nsfileversionmbs.shtml"
		  linksMBS.Value("NSFileWrapperMBS")="https://www.monkeybreadsoftware.net/class-nsfilewrappermbs.shtml"
		  linksMBS.Value("NSFontDescriptorMBS")="https://www.monkeybreadsoftware.net/class-nsfontdescriptormbs.shtml"
		  linksMBS.Value("NSFontManagerMBS")="https://www.monkeybreadsoftware.net/class-nsfontmanagermbs.shtml"
		  linksMBS.Value("NSFontMBS")="https://www.monkeybreadsoftware.net/class-nsfontmbs.shtml"
		  linksMBS.Value("NSFontPanelMBS")="https://www.monkeybreadsoftware.net/class-nsfontpanelmbs.shtml"
		  linksMBS.Value("NSGraphicsMBS")="https://www.monkeybreadsoftware.net/class-nsgraphicsmbs.shtml"
		  linksMBS.Value("NSGroupTouchBarItemMBS")="https://www.monkeybreadsoftware.net/class-nsgrouptouchbaritemmbs.shtml"
		  linksMBS.Value("NSHelpManagerMBS")="https://www.monkeybreadsoftware.net/class-nshelpmanagermbs.shtml"
		  linksMBS.Value("NSHTTPCookieMBS")="https://www.monkeybreadsoftware.net/class-nshttpcookiembs.shtml"
		  linksMBS.Value("NSHTTPCookieStorageMBS")="https://www.monkeybreadsoftware.net/class-nshttpcookiestoragembs.shtml"
		  linksMBS.Value("NSImageCellMBS")="https://www.monkeybreadsoftware.net/class-nsimagecellmbs.shtml"
		  linksMBS.Value("NSImageMBS")="https://www.monkeybreadsoftware.net/class-nsimagembs.shtml"
		  linksMBS.Value("NSImageRepMBS")="https://www.monkeybreadsoftware.net/class-nsimagerepmbs.shtml"
		  linksMBS.Value("NSImageSymbolConfigurationMBS")="https://www.monkeybreadsoftware.net/class-nsimagesymbolconfigurationmbs.shtml"
		  linksMBS.Value("NSImageViewMBS")="https://www.monkeybreadsoftware.net/class-nsimageviewmbs.shtml"
		  linksMBS.Value("NSIndexPathMBS")="https://www.monkeybreadsoftware.net/class-nsindexpathmbs.shtml"
		  linksMBS.Value("NSIndexSetMBS")="https://www.monkeybreadsoftware.net/class-nsindexsetmbs.shtml"
		  linksMBS.Value("NSInputStreamMBS")="https://www.monkeybreadsoftware.net/class-nsinputstreammbs.shtml"
		  linksMBS.Value("NSKeyedArchiverMBS")="https://www.monkeybreadsoftware.net/class-nskeyedarchivermbs.shtml"
		  linksMBS.Value("NSKeyedUnarchiverMBS")="https://www.monkeybreadsoftware.net/class-nskeyedunarchivermbs.shtml"
		  linksMBS.Value("NSKeyValueObserverMBS")="https://www.monkeybreadsoftware.net/class-nskeyvalueobservermbs.shtml"
		  linksMBS.Value("NSLayoutManagerMBS")="https://www.monkeybreadsoftware.net/class-nslayoutmanagermbs.shtml"
		  linksMBS.Value("NSLevelIndicatorMBS")="https://www.monkeybreadsoftware.net/class-nslevelindicatormbs.shtml"
		  linksMBS.Value("NSLinguisticTaggerMBS")="https://www.monkeybreadsoftware.net/class-nslinguistictaggermbs.shtml"
		  linksMBS.Value("NSLinguisticValueMBS")="https://www.monkeybreadsoftware.net/class-nslinguisticvaluembs.shtml"
		  linksMBS.Value("NSLocaleDateMBS")="https://www.monkeybreadsoftware.net/class-nslocaledatembs.shtml"
		  linksMBS.Value("NSLocaleMBS")="https://www.monkeybreadsoftware.net/class-nslocalembs.shtml"
		  linksMBS.Value("NSLocaleNumberMBS")="https://www.monkeybreadsoftware.net/class-nslocalenumbermbs.shtml"
		  linksMBS.Value("NSMediaLibraryBrowserControllerMBS")="https://www.monkeybreadsoftware.net/class-nsmedialibrarybrowsercontrollermbs.shtml"
		  linksMBS.Value("NSMenuItemCellMBS")="https://www.monkeybreadsoftware.net/class-nsmenuitemcellmbs.shtml"
		  linksMBS.Value("NSMenuItemMBS")="https://www.monkeybreadsoftware.net/class-nsmenuitemmbs.shtml"
		  linksMBS.Value("NSMenuMBS")="https://www.monkeybreadsoftware.net/class-nsmenumbs.shtml"
		  linksMBS.Value("NSMetadataItemMBS")="https://www.monkeybreadsoftware.net/class-nsmetadataitemmbs.shtml"
		  linksMBS.Value("NSMetadataQueryMBS")="https://www.monkeybreadsoftware.net/class-nsmetadataquerymbs.shtml"
		  linksMBS.Value("NSMetadataQueryResultGroupMBS")="https://www.monkeybreadsoftware.net/class-nsmetadataqueryresultgroupmbs.shtml"
		  linksMBS.Value("NSMutableAttributedStringMBS")="https://www.monkeybreadsoftware.net/class-nsmutableattributedstringmbs.shtml"
		  linksMBS.Value("NSMutableCharacterSetMBS")="https://www.monkeybreadsoftware.net/class-nsmutablecharactersetmbs.shtml"
		  linksMBS.Value("NSMutableIndexSetMBS")="https://www.monkeybreadsoftware.net/class-nsmutableindexsetmbs.shtml"
		  linksMBS.Value("NSMutableParagraphStyleMBS")="https://www.monkeybreadsoftware.net/class-nsmutableparagraphstylembs.shtml"
		  linksMBS.Value("NSMutableURLRequestMBS")="https://www.monkeybreadsoftware.net/class-nsmutableurlrequestmbs.shtml"
		  linksMBS.Value("NSNetServiceBrowserMBS")="https://www.monkeybreadsoftware.net/class-nsnetservicebrowsermbs.shtml"
		  linksMBS.Value("NSNetServiceMBS")="https://www.monkeybreadsoftware.net/class-nsnetservicembs.shtml"
		  linksMBS.Value("NSNotificationCenterMBS")="https://www.monkeybreadsoftware.net/class-nsnotificationcentermbs.shtml"
		  linksMBS.Value("NSNotificationMBS")="https://www.monkeybreadsoftware.net/class-nsnotificationmbs.shtml"
		  linksMBS.Value("NSNotificationObserverMBS")="https://www.monkeybreadsoftware.net/class-nsnotificationobservermbs.shtml"
		  linksMBS.Value("NSOpenPanelMBS")="https://www.monkeybreadsoftware.net/class-nsopenpanelmbs.shtml"
		  linksMBS.Value("NSOperationMBS")="https://www.monkeybreadsoftware.net/class-nsoperationmbs.shtml"
		  linksMBS.Value("NSOperationQueueMBS")="https://www.monkeybreadsoftware.net/class-nsoperationqueuembs.shtml"
		  linksMBS.Value("NSOrthographyMBS")="https://www.monkeybreadsoftware.net/class-nsorthographymbs.shtml"
		  linksMBS.Value("NSOutlineViewItemMBS")="https://www.monkeybreadsoftware.net/class-nsoutlineviewitemmbs.shtml"
		  linksMBS.Value("NSOutlineViewMBS")="https://www.monkeybreadsoftware.net/class-nsoutlineviewmbs.shtml"
		  linksMBS.Value("NSOutputStreamMBS")="https://www.monkeybreadsoftware.net/class-nsoutputstreammbs.shtml"
		  linksMBS.Value("NSPageLayoutMBS")="https://www.monkeybreadsoftware.net/class-nspagelayoutmbs.shtml"
		  linksMBS.Value("NSPanelMBS")="https://www.monkeybreadsoftware.net/class-nspanelmbs.shtml"
		  linksMBS.Value("NSParagraphStyleMBS")="https://www.monkeybreadsoftware.net/class-nsparagraphstylembs.shtml"
		  linksMBS.Value("NSPasteboardItemDataProviderMBS")="https://www.monkeybreadsoftware.net/class-nspasteboarditemdataprovidermbs.shtml"
		  linksMBS.Value("NSPasteboardItemMBS")="https://www.monkeybreadsoftware.net/class-nspasteboarditemmbs.shtml"
		  linksMBS.Value("NSPasteboardMBS")="https://www.monkeybreadsoftware.net/class-nspasteboardmbs.shtml"
		  linksMBS.Value("NSPathComponentCellMBS")="https://www.monkeybreadsoftware.net/class-nspathcomponentcellmbs.shtml"
		  linksMBS.Value("NSPathControlMBS")="https://www.monkeybreadsoftware.net/class-nspathcontrolmbs.shtml"
		  linksMBS.Value("NSPDFImageRepMBS")="https://www.monkeybreadsoftware.net/class-nspdfimagerepmbs.shtml"
		  linksMBS.Value("NSPersonNameComponentsMBS")="https://www.monkeybreadsoftware.net/class-nspersonnamecomponentsmbs.shtml"
		  linksMBS.Value("NSPICTImageRepMBS")="https://www.monkeybreadsoftware.net/class-nspictimagerepmbs.shtml"
		  linksMBS.Value("NSPipeMBS")="https://www.monkeybreadsoftware.net/class-nspipembs.shtml"
		  linksMBS.Value("NSPointMBS")="https://www.monkeybreadsoftware.net/class-nspointmbs.shtml"
		  linksMBS.Value("NSPopoverMBS")="https://www.monkeybreadsoftware.net/class-nspopovermbs.shtml"
		  linksMBS.Value("NSPopoverTouchBarItemMBS")="https://www.monkeybreadsoftware.net/class-nspopovertouchbaritemmbs.shtml"
		  linksMBS.Value("NSPopUpButtonCellMBS")="https://www.monkeybreadsoftware.net/class-nspopupbuttoncellmbs.shtml"
		  linksMBS.Value("NSPopUpButtonMBS")="https://www.monkeybreadsoftware.net/class-nspopupbuttonmbs.shtml"
		  linksMBS.Value("NSPredicateMBS")="https://www.monkeybreadsoftware.net/class-nspredicatembs.shtml"
		  linksMBS.Value("NSPrinterMBS")="https://www.monkeybreadsoftware.net/class-nsprintermbs.shtml"
		  linksMBS.Value("NSPrintInfoMBS")="https://www.monkeybreadsoftware.net/class-nsprintinfombs.shtml"
		  linksMBS.Value("NSPrintOperationMBS")="https://www.monkeybreadsoftware.net/class-nsprintoperationmbs.shtml"
		  linksMBS.Value("NSPrintPanelMBS")="https://www.monkeybreadsoftware.net/class-nsprintpanelmbs.shtml"
		  linksMBS.Value("NSProcessInfoActivityMBS")="https://www.monkeybreadsoftware.net/class-nsprocessinfoactivitymbs.shtml"
		  linksMBS.Value("NSProcessInfoMBS")="https://www.monkeybreadsoftware.net/class-nsprocessinfombs.shtml"
		  linksMBS.Value("NSProgressIndicatorMBS")="https://www.monkeybreadsoftware.net/class-nsprogressindicatormbs.shtml"
		  linksMBS.Value("NSRangeMBS")="https://www.monkeybreadsoftware.net/class-nsrangembs.shtml"
		  linksMBS.Value("NSRectMBS")="https://www.monkeybreadsoftware.net/class-nsrectmbs.shtml"
		  linksMBS.Value("NSRegularExpressionMBS")="https://www.monkeybreadsoftware.net/class-nsregularexpressionmbs.shtml"
		  linksMBS.Value("NSResponderMBS")="https://www.monkeybreadsoftware.net/class-nsrespondermbs.shtml"
		  linksMBS.Value("NSRunLoopMBS")="https://www.monkeybreadsoftware.net/class-nsrunloopmbs.shtml"
		  linksMBS.Value("NSRunningApplicationMBS")="https://www.monkeybreadsoftware.net/class-nsrunningapplicationmbs.shtml"
		  linksMBS.Value("NSSavePanelMBS")="https://www.monkeybreadsoftware.net/class-nssavepanelmbs.shtml"
		  linksMBS.Value("NSSavePanelObserverMBS")="https://www.monkeybreadsoftware.net/class-nssavepanelobservermbs.shtml"
		  linksMBS.Value("NSScreenMBS")="https://www.monkeybreadsoftware.net/class-nsscreenmbs.shtml"
		  linksMBS.Value("NSScrollerMBS")="https://www.monkeybreadsoftware.net/class-nsscrollermbs.shtml"
		  linksMBS.Value("NSScrollViewMBS")="https://www.monkeybreadsoftware.net/class-nsscrollviewmbs.shtml"
		  linksMBS.Value("NSSearchFieldCellMBS")="https://www.monkeybreadsoftware.net/class-nssearchfieldcellmbs.shtml"
		  linksMBS.Value("NSSearchFieldMBS")="https://www.monkeybreadsoftware.net/class-nssearchfieldmbs.shtml"
		  linksMBS.Value("NSSecureTextFieldMBS")="https://www.monkeybreadsoftware.net/class-nssecuretextfieldmbs.shtml"
		  linksMBS.Value("NSSegmentedControlMBS")="https://www.monkeybreadsoftware.net/class-nssegmentedcontrolmbs.shtml"
		  linksMBS.Value("NSServiceProviderMBS")="https://www.monkeybreadsoftware.net/class-nsserviceprovidermbs.shtml"
		  linksMBS.Value("NSShadowMBS")="https://www.monkeybreadsoftware.net/class-nsshadowmbs.shtml"
		  linksMBS.Value("NSSharingServiceDelegateMBS")="https://www.monkeybreadsoftware.net/class-nssharingservicedelegatembs.shtml"
		  linksMBS.Value("NSSharingServiceItemsMBS")="https://www.monkeybreadsoftware.net/class-nssharingserviceitemsmbs.shtml"
		  linksMBS.Value("NSSharingServiceMBS")="https://www.monkeybreadsoftware.net/class-nssharingservicembs.shtml"
		  linksMBS.Value("NSSharingServicePickerMBS")="https://www.monkeybreadsoftware.net/class-nssharingservicepickermbs.shtml"
		  linksMBS.Value("NSSizeMBS")="https://www.monkeybreadsoftware.net/class-nssizembs.shtml"
		  linksMBS.Value("NSSliderMBS")="https://www.monkeybreadsoftware.net/class-nsslidermbs.shtml"
		  linksMBS.Value("NSSliderTouchBarItemMBS")="https://www.monkeybreadsoftware.net/class-nsslidertouchbaritemmbs.shtml"
		  linksMBS.Value("NSSortDescriptorMBS")="https://www.monkeybreadsoftware.net/class-nssortdescriptormbs.shtml"
		  linksMBS.Value("NSSoundDelegateMBS")="https://www.monkeybreadsoftware.net/class-nssounddelegatembs.shtml"
		  linksMBS.Value("NSSoundMBS")="https://www.monkeybreadsoftware.net/class-nssoundmbs.shtml"
		  linksMBS.Value("NSSpeechRecognizerMBS")="https://www.monkeybreadsoftware.net/class-nsspeechrecognizermbs.shtml"
		  linksMBS.Value("NSSpeechSynthesizerMBS")="https://www.monkeybreadsoftware.net/class-nsspeechsynthesizermbs.shtml"
		  linksMBS.Value("NSSpellCheckerMBS")="https://www.monkeybreadsoftware.net/class-nsspellcheckermbs.shtml"
		  linksMBS.Value("NSStatusBarButtonMBS")="https://www.monkeybreadsoftware.net/class-nsstatusbarbuttonmbs.shtml"
		  linksMBS.Value("NSStatusItemMBS")="https://www.monkeybreadsoftware.net/class-nsstatusitemmbs.shtml"
		  linksMBS.Value("NSStepperMBS")="https://www.monkeybreadsoftware.net/class-nssteppermbs.shtml"
		  linksMBS.Value("NSStreamMBS")="https://www.monkeybreadsoftware.net/class-nsstreammbs.shtml"
		  linksMBS.Value("NSSwitchMBS")="https://www.monkeybreadsoftware.net/class-nsswitchmbs.shtml"
		  linksMBS.Value("NSTableColumnMBS")="https://www.monkeybreadsoftware.net/class-nstablecolumnmbs.shtml"
		  linksMBS.Value("NSTableDataSourceMBS")="https://www.monkeybreadsoftware.net/class-nstabledatasourcembs.shtml"
		  linksMBS.Value("NSTableHeaderCellMBS")="https://www.monkeybreadsoftware.net/class-nstableheadercellmbs.shtml"
		  linksMBS.Value("NSTableHeaderViewMBS")="https://www.monkeybreadsoftware.net/class-nstableheaderviewmbs.shtml"
		  linksMBS.Value("NSTableRowViewMBS")="https://www.monkeybreadsoftware.net/class-nstablerowviewmbs.shtml"
		  linksMBS.Value("NSTableViewMBS")="https://www.monkeybreadsoftware.net/class-nstableviewmbs.shtml"
		  linksMBS.Value("NSTableViewRowActionMBS")="https://www.monkeybreadsoftware.net/class-nstableviewrowactionmbs.shtml"
		  linksMBS.Value("NSTabViewItemMBS")="https://www.monkeybreadsoftware.net/class-nstabviewitemmbs.shtml"
		  linksMBS.Value("NSTabViewMBS")="https://www.monkeybreadsoftware.net/class-nstabviewmbs.shtml"
		  linksMBS.Value("NSTaskMBS")="https://www.monkeybreadsoftware.net/class-nstaskmbs.shtml"
		  linksMBS.Value("NSTextAttachmentMBS")="https://www.monkeybreadsoftware.net/class-nstextattachmentmbs.shtml"
		  linksMBS.Value("NSTextBlockMBS")="https://www.monkeybreadsoftware.net/class-nstextblockmbs.shtml"
		  linksMBS.Value("NSTextCheckingResultMBS")="https://www.monkeybreadsoftware.net/class-nstextcheckingresultmbs.shtml"
		  linksMBS.Value("NSTextContainerMBS")="https://www.monkeybreadsoftware.net/class-nstextcontainermbs.shtml"
		  linksMBS.Value("NSTextFieldCellMBS")="https://www.monkeybreadsoftware.net/class-nstextfieldcellmbs.shtml"
		  linksMBS.Value("NSTextFieldMBS")="https://www.monkeybreadsoftware.net/class-nstextfieldmbs.shtml"
		  linksMBS.Value("NSTextFinderMBS")="https://www.monkeybreadsoftware.net/class-nstextfindermbs.shtml"
		  linksMBS.Value("NSTextListMBS")="https://www.monkeybreadsoftware.net/class-nstextlistmbs.shtml"
		  linksMBS.Value("NSTextMBS")="https://www.monkeybreadsoftware.net/class-nstextmbs.shtml"
		  linksMBS.Value("NSTextStorageMBS")="https://www.monkeybreadsoftware.net/class-nstextstoragembs.shtml"
		  linksMBS.Value("NSTextTableBlockMBS")="https://www.monkeybreadsoftware.net/class-nstexttableblockmbs.shtml"
		  linksMBS.Value("NSTextTableMBS")="https://www.monkeybreadsoftware.net/class-nstexttablembs.shtml"
		  linksMBS.Value("NSTextTabMBS")="https://www.monkeybreadsoftware.net/class-nstexttabmbs.shtml"
		  linksMBS.Value("NSTextViewMBS")="https://www.monkeybreadsoftware.net/class-nstextviewmbs.shtml"
		  linksMBS.Value("NSTimerMBS")="https://www.monkeybreadsoftware.net/class-nstimermbs.shtml"
		  linksMBS.Value("NSTimeZoneMBS")="https://www.monkeybreadsoftware.net/class-nstimezonembs.shtml"
		  linksMBS.Value("NSTokenFieldMBS")="https://www.monkeybreadsoftware.net/class-nstokenfieldmbs.shtml"
		  linksMBS.Value("NSToolbarItemGroupMBS")="https://www.monkeybreadsoftware.net/class-nstoolbaritemgroupmbs.shtml"
		  linksMBS.Value("NSToolbarItemMBS")="https://www.monkeybreadsoftware.net/class-nstoolbaritemmbs.shtml"
		  linksMBS.Value("NSToolbarMBS")="https://www.monkeybreadsoftware.net/class-nstoolbarmbs.shtml"
		  linksMBS.Value("NSTouchBarItemMBS")="https://www.monkeybreadsoftware.net/class-nstouchbaritemmbs.shtml"
		  linksMBS.Value("NSTouchBarMBS")="https://www.monkeybreadsoftware.net/class-nstouchbarmbs.shtml"
		  linksMBS.Value("NSUbiquitousKeyValueStoreMBS")="https://www.monkeybreadsoftware.net/class-nsubiquitouskeyvaluestorembs.shtml"
		  linksMBS.Value("NSUndoManagerMBS")="https://www.monkeybreadsoftware.net/class-nsundomanagermbs.shtml"
		  linksMBS.Value("NSURLAuthenticationChallengeMBS")="https://www.monkeybreadsoftware.net/class-nsurlauthenticationchallengembs.shtml"
		  linksMBS.Value("NSURLCacheMBS")="https://www.monkeybreadsoftware.net/class-nsurlcachembs.shtml"
		  linksMBS.Value("NSURLConnectionFilterMBS")="https://www.monkeybreadsoftware.net/class-nsurlconnectionfiltermbs.shtml"
		  linksMBS.Value("NSURLCredentialMBS")="https://www.monkeybreadsoftware.net/class-nsurlcredentialmbs.shtml"
		  linksMBS.Value("NSURLCredentialStorageMBS")="https://www.monkeybreadsoftware.net/class-nsurlcredentialstoragembs.shtml"
		  linksMBS.Value("NSURLDownloadMBS")="https://www.monkeybreadsoftware.net/class-nsurldownloadmbs.shtml"
		  linksMBS.Value("NSURLMBS")="https://www.monkeybreadsoftware.net/class-nsurlmbs.shtml"
		  linksMBS.Value("NSURLProtectionSpaceMBS")="https://www.monkeybreadsoftware.net/class-nsurlprotectionspacembs.shtml"
		  linksMBS.Value("NSURLRequestCertificateFilterMBS")="https://www.monkeybreadsoftware.net/class-nsurlrequestcertificatefiltermbs.shtml"
		  linksMBS.Value("NSURLRequestMBS")="https://www.monkeybreadsoftware.net/class-nsurlrequestmbs.shtml"
		  linksMBS.Value("NSURLResponseMBS")="https://www.monkeybreadsoftware.net/class-nsurlresponsembs.shtml"
		  linksMBS.Value("NSURLSessionConfigurationMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessionconfigurationmbs.shtml"
		  linksMBS.Value("NSURLSessionDataTaskMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessiondatataskmbs.shtml"
		  linksMBS.Value("NSURLSessionDownloadTaskMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessiondownloadtaskmbs.shtml"
		  linksMBS.Value("NSURLSessionMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessionmbs.shtml"
		  linksMBS.Value("NSURLSessionStreamTaskMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessionstreamtaskmbs.shtml"
		  linksMBS.Value("NSURLSessionTaskMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessiontaskmbs.shtml"
		  linksMBS.Value("NSURLSessionTaskMetricsMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessiontaskmetricsmbs.shtml"
		  linksMBS.Value("NSURLSessionTaskTransactionMetricsMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessiontasktransactionmetricsmbs.shtml"
		  linksMBS.Value("NSURLSessionUploadTaskMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessionuploadtaskmbs.shtml"
		  linksMBS.Value("NSURLSessionWebSocketMessageMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessionwebsocketmessagembs.shtml"
		  linksMBS.Value("NSURLSessionWebSocketTaskMBS")="https://www.monkeybreadsoftware.net/class-nsurlsessionwebsockettaskmbs.shtml"
		  linksMBS.Value("NSUserAppleScriptTaskMBS")="https://www.monkeybreadsoftware.net/class-nsuserapplescripttaskmbs.shtml"
		  linksMBS.Value("NSUserAutomatorTaskMBS")="https://www.monkeybreadsoftware.net/class-nsuserautomatortaskmbs.shtml"
		  linksMBS.Value("NSUserDefaultsMBS")="https://www.monkeybreadsoftware.net/class-nsuserdefaultsmbs.shtml"
		  linksMBS.Value("NSUserScriptTaskMBS")="https://www.monkeybreadsoftware.net/class-nsuserscripttaskmbs.shtml"
		  linksMBS.Value("NSUserUnixTaskMBS")="https://www.monkeybreadsoftware.net/class-nsuserunixtaskmbs.shtml"
		  linksMBS.Value("NSUUIDMBS")="https://www.monkeybreadsoftware.net/class-nsuuidmbs.shtml"
		  linksMBS.Value("NSViewControllerMBS")="https://www.monkeybreadsoftware.net/class-nsviewcontrollermbs.shtml"
		  linksMBS.Value("NSViewMBS")="https://www.monkeybreadsoftware.net/class-nsviewmbs.shtml"
		  linksMBS.Value("NSViewTooltipMBS")="https://www.monkeybreadsoftware.net/class-nsviewtooltipmbs.shtml"
		  linksMBS.Value("NSVisualEffectViewMBS")="https://www.monkeybreadsoftware.net/class-nsvisualeffectviewmbs.shtml"
		  linksMBS.Value("NSVoiceMBS")="https://www.monkeybreadsoftware.net/class-nsvoicembs.shtml"
		  linksMBS.Value("NSWindowControllerMBS")="https://www.monkeybreadsoftware.net/class-nswindowcontrollermbs.shtml"
		  linksMBS.Value("NSWindowDelegateMBS")="https://www.monkeybreadsoftware.net/class-nswindowdelegatembs.shtml"
		  linksMBS.Value("NSWindowMBS")="https://www.monkeybreadsoftware.net/class-nswindowmbs.shtml"
		  linksMBS.Value("NSWindowRestoreHandlerMBS")="https://www.monkeybreadsoftware.net/class-nswindowrestorehandlermbs.shtml"
		  linksMBS.Value("NSWorkspaceAuthorizationMBS")="https://www.monkeybreadsoftware.net/class-nsworkspaceauthorizationmbs.shtml"
		  linksMBS.Value("NSWorkspaceMBS")="https://www.monkeybreadsoftware.net/class-nsworkspacembs.shtml"
		  linksMBS.Value("NSXPCConnectionMBS")="https://www.monkeybreadsoftware.net/class-nsxpcconnectionmbs.shtml"
		  linksMBS.Value("NSXPCListenerEndpointMBS")="https://www.monkeybreadsoftware.net/class-nsxpclistenerendpointmbs.shtml"
		  linksMBS.Value("NSXPCListenerMBS")="https://www.monkeybreadsoftware.net/class-nsxpclistenermbs.shtml"
		  linksMBS.Value("ODNodeMBS")="https://www.monkeybreadsoftware.net/class-odnodembs.shtml"
		  linksMBS.Value("ODQueryMBS")="https://www.monkeybreadsoftware.net/class-odquerymbs.shtml"
		  linksMBS.Value("ODRecordMBS")="https://www.monkeybreadsoftware.net/class-odrecordmbs.shtml"
		  linksMBS.Value("ODSessionMBS")="https://www.monkeybreadsoftware.net/class-odsessionmbs.shtml"
		  linksMBS.Value("OldPhidgetAccelerometerMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetaccelerometermbs.shtml"
		  linksMBS.Value("OldPhidgetAdvancedServoMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetadvancedservombs.shtml"
		  linksMBS.Value("OldPhidgetAnalogMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetanalogmbs.shtml"
		  linksMBS.Value("OldPhidgetBridgeMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetbridgembs.shtml"
		  linksMBS.Value("OldPhidgetDictionaryMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetdictionarymbs.shtml"
		  linksMBS.Value("OldPhidgetEncoderMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetencodermbs.shtml"
		  linksMBS.Value("OldPhidgetFrequencyCounterMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetfrequencycountermbs.shtml"
		  linksMBS.Value("OldPhidgetGPGGAMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetgpggambs.shtml"
		  linksMBS.Value("OldPhidgetGPGSAMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetgpgsambs.shtml"
		  linksMBS.Value("OldPhidgetGPGSVMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetgpgsvmbs.shtml"
		  linksMBS.Value("OldPhidgetGPRMCMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetgprmcmbs.shtml"
		  linksMBS.Value("OldPhidgetGPSDateMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetgpsdatembs.shtml"
		  linksMBS.Value("OldPhidgetGPSMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetgpsmbs.shtml"
		  linksMBS.Value("OldPhidgetGPSSatInfoMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetgpssatinfombs.shtml"
		  linksMBS.Value("OldPhidgetGPSTimeMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetgpstimembs.shtml"
		  linksMBS.Value("OldPhidgetGPVTGMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetgpvtgmbs.shtml"
		  linksMBS.Value("OldPhidgetInterfaceKitMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetinterfacekitmbs.shtml"
		  linksMBS.Value("OldPhidgetIRCodeInfoMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetircodeinfombs.shtml"
		  linksMBS.Value("OldPhidgetIRMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetirmbs.shtml"
		  linksMBS.Value("OldPhidgetLEDMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetledmbs.shtml"
		  linksMBS.Value("OldPhidgetManagerMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetmanagermbs.shtml"
		  linksMBS.Value("OldPhidgetMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetmbs.shtml"
		  linksMBS.Value("OldPhidgetMissingFunctionExceptionMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetmissingfunctionexceptionmbs.shtml"
		  linksMBS.Value("OldPhidgetMotorControlMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetmotorcontrolmbs.shtml"
		  linksMBS.Value("OldPhidgetNMEADataMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetnmeadatambs.shtml"
		  linksMBS.Value("OldPhidgetNotInitialzedExceptionMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetnotinitialzedexceptionmbs.shtml"
		  linksMBS.Value("OldPhidgetPHSensorMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetphsensormbs.shtml"
		  linksMBS.Value("OldPhidgetRFIDMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetrfidmbs.shtml"
		  linksMBS.Value("OldPhidgetServoMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetservombs.shtml"
		  linksMBS.Value("OldPhidgetSpatialEventDataMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetspatialeventdatambs.shtml"
		  linksMBS.Value("OldPhidgetSpatialMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetspatialmbs.shtml"
		  linksMBS.Value("OldPhidgetStepperMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetsteppermbs.shtml"
		  linksMBS.Value("OldPhidgetTemperatureSensorMBS")="https://www.monkeybreadsoftware.net/class-oldphidgettemperaturesensormbs.shtml"
		  linksMBS.Value("OldPhidgetTextLCDMBS")="https://www.monkeybreadsoftware.net/class-oldphidgettextlcdmbs.shtml"
		  linksMBS.Value("OldPhidgetTextLEDMBS")="https://www.monkeybreadsoftware.net/class-oldphidgettextledmbs.shtml"
		  linksMBS.Value("OldPhidgetWeightSensorMBS")="https://www.monkeybreadsoftware.net/class-oldphidgetweightsensormbs.shtml"
		  linksMBS.Value("OpenDialogFileTypeMBS")="https://www.monkeybreadsoftware.net/class-opendialogfiletypembs.shtml"
		  linksMBS.Value("OpenDialogItemMBS")="https://www.monkeybreadsoftware.net/class-opendialogitemmbs.shtml"
		  linksMBS.Value("OpenDialogMBS")="https://www.monkeybreadsoftware.net/class-opendialogmbs.shtml"
		  linksMBS.Value("OpenSSLExceptionMBS")="https://www.monkeybreadsoftware.net/class-opensslexceptionmbs.shtml"
		  linksMBS.Value("OSALanguageInstanceMBS")="https://www.monkeybreadsoftware.net/class-osalanguageinstancembs.shtml"
		  linksMBS.Value("OSALanguageMBS")="https://www.monkeybreadsoftware.net/class-osalanguagembs.shtml"
		  linksMBS.Value("OSAScriptControllerMBS")="https://www.monkeybreadsoftware.net/class-osascriptcontrollermbs.shtml"
		  linksMBS.Value("OSAScriptMBS")="https://www.monkeybreadsoftware.net/class-osascriptmbs.shtml"
		  linksMBS.Value("OSAScriptViewMBS")="https://www.monkeybreadsoftware.net/class-osascriptviewmbs.shtml"
		  linksMBS.Value("OverlayMBS")="https://www.monkeybreadsoftware.net/class-overlaymbs.shtml"
		  linksMBS.Value("PacketSocketMBS")="https://www.monkeybreadsoftware.net/class-packetsocketmbs.shtml"
		  linksMBS.Value("PaletteCalculatorMBS")="https://www.monkeybreadsoftware.net/class-palettecalculatormbs.shtml"
		  linksMBS.Value("PCRE2CodeInfoMBS")="https://www.monkeybreadsoftware.net/class-pcre2codeinfombs.shtml"
		  linksMBS.Value("PCRE2CodeMBS")="https://www.monkeybreadsoftware.net/class-pcre2codembs.shtml"
		  linksMBS.Value("PCRE2CompilerMBS")="https://www.monkeybreadsoftware.net/class-pcre2compilermbs.shtml"
		  linksMBS.Value("PCRE2ExceptionMBS")="https://www.monkeybreadsoftware.net/class-pcre2exceptionmbs.shtml"
		  linksMBS.Value("PCRE2IteratorMBS")="https://www.monkeybreadsoftware.net/class-pcre2iteratormbs.shtml"
		  linksMBS.Value("PCRE2MatchContextMBS")="https://www.monkeybreadsoftware.net/class-pcre2matchcontextmbs.shtml"
		  linksMBS.Value("PCRE2MatchDataMBS")="https://www.monkeybreadsoftware.net/class-pcre2matchdatambs.shtml"
		  linksMBS.Value("PDFActionGoToMBS")="https://www.monkeybreadsoftware.net/class-pdfactiongotombs.shtml"
		  linksMBS.Value("PDFActionMBS")="https://www.monkeybreadsoftware.net/class-pdfactionmbs.shtml"
		  linksMBS.Value("PDFActionNamedMBS")="https://www.monkeybreadsoftware.net/class-pdfactionnamedmbs.shtml"
		  linksMBS.Value("PDFActionRemoteGoToMBS")="https://www.monkeybreadsoftware.net/class-pdfactionremotegotombs.shtml"
		  linksMBS.Value("PDFActionResetFormMBS")="https://www.monkeybreadsoftware.net/class-pdfactionresetformmbs.shtml"
		  linksMBS.Value("PDFActionURLMBS")="https://www.monkeybreadsoftware.net/class-pdfactionurlmbs.shtml"
		  linksMBS.Value("PDFAnnotationButtonWidgetMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationbuttonwidgetmbs.shtml"
		  linksMBS.Value("PDFAnnotationChoiceWidgetMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationchoicewidgetmbs.shtml"
		  linksMBS.Value("PDFAnnotationCircleMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationcirclembs.shtml"
		  linksMBS.Value("PDFAnnotationFreeTextMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationfreetextmbs.shtml"
		  linksMBS.Value("PDFAnnotationInkMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationinkmbs.shtml"
		  linksMBS.Value("PDFAnnotationLineMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationlinembs.shtml"
		  linksMBS.Value("PDFAnnotationLinkMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationlinkmbs.shtml"
		  linksMBS.Value("PDFAnnotationMarkupMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationmarkupmbs.shtml"
		  linksMBS.Value("PDFAnnotationMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationmbs.shtml"
		  linksMBS.Value("PDFAnnotationPopupMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationpopupmbs.shtml"
		  linksMBS.Value("PDFAnnotationSquareMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationsquarembs.shtml"
		  linksMBS.Value("PDFAnnotationStampMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationstampmbs.shtml"
		  linksMBS.Value("PDFAnnotationTextMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationtextmbs.shtml"
		  linksMBS.Value("PDFAnnotationTextWidgetMBS")="https://www.monkeybreadsoftware.net/class-pdfannotationtextwidgetmbs.shtml"
		  linksMBS.Value("PDFAppearanceCharacteristicsMBS")="https://www.monkeybreadsoftware.net/class-pdfappearancecharacteristicsmbs.shtml"
		  linksMBS.Value("PDFBorderMBS")="https://www.monkeybreadsoftware.net/class-pdfbordermbs.shtml"
		  linksMBS.Value("PDFDestinationMBS")="https://www.monkeybreadsoftware.net/class-pdfdestinationmbs.shtml"
		  linksMBS.Value("PDFDocumentDelegateMBS")="https://www.monkeybreadsoftware.net/class-pdfdocumentdelegatembs.shtml"
		  linksMBS.Value("PDFDocumentMBS")="https://www.monkeybreadsoftware.net/class-pdfdocumentmbs.shtml"
		  linksMBS.Value("PDFOutlineMBS")="https://www.monkeybreadsoftware.net/class-pdfoutlinembs.shtml"
		  linksMBS.Value("PDFPageMBS")="https://www.monkeybreadsoftware.net/class-pdfpagembs.shtml"
		  linksMBS.Value("PDFSelectionMBS")="https://www.monkeybreadsoftware.net/class-pdfselectionmbs.shtml"
		  linksMBS.Value("PDFThumbnailViewMBS")="https://www.monkeybreadsoftware.net/class-pdfthumbnailviewmbs.shtml"
		  linksMBS.Value("PDFViewMBS")="https://www.monkeybreadsoftware.net/class-pdfviewmbs.shtml"
		  linksMBS.Value("PermissionsMBS")="https://www.monkeybreadsoftware.net/class-permissionsmbs.shtml"
		  linksMBS.Value("PHAdjustmentDataMBS")="https://www.monkeybreadsoftware.net/class-phadjustmentdatambs.shtml"
		  linksMBS.Value("PHAssetChangeRequestMBS")="https://www.monkeybreadsoftware.net/class-phassetchangerequestmbs.shtml"
		  linksMBS.Value("PHAssetCollectionChangeRequestMBS")="https://www.monkeybreadsoftware.net/class-phassetcollectionchangerequestmbs.shtml"
		  linksMBS.Value("PHAssetCollectionMBS")="https://www.monkeybreadsoftware.net/class-phassetcollectionmbs.shtml"
		  linksMBS.Value("PHAssetCreationRequestMBS")="https://www.monkeybreadsoftware.net/class-phassetcreationrequestmbs.shtml"
		  linksMBS.Value("PHAssetMBS")="https://www.monkeybreadsoftware.net/class-phassetmbs.shtml"
		  linksMBS.Value("PHAssetResourceCreationOptionsMBS")="https://www.monkeybreadsoftware.net/class-phassetresourcecreationoptionsmbs.shtml"
		  linksMBS.Value("PHAssetResourceManagerMBS")="https://www.monkeybreadsoftware.net/class-phassetresourcemanagermbs.shtml"
		  linksMBS.Value("PHAssetResourceMBS")="https://www.monkeybreadsoftware.net/class-phassetresourcembs.shtml"
		  linksMBS.Value("PHAssetResourceRequestOptionsMBS")="https://www.monkeybreadsoftware.net/class-phassetresourcerequestoptionsmbs.shtml"
		  linksMBS.Value("PHCachingImageManagerMBS")="https://www.monkeybreadsoftware.net/class-phcachingimagemanagermbs.shtml"
		  linksMBS.Value("PHChangeMBS")="https://www.monkeybreadsoftware.net/class-phchangembs.shtml"
		  linksMBS.Value("PHChangeRequestMBS")="https://www.monkeybreadsoftware.net/class-phchangerequestmbs.shtml"
		  linksMBS.Value("PHCloudIdentifierMBS")="https://www.monkeybreadsoftware.net/class-phcloudidentifiermbs.shtml"
		  linksMBS.Value("PHCollectionListChangeRequestMBS")="https://www.monkeybreadsoftware.net/class-phcollectionlistchangerequestmbs.shtml"
		  linksMBS.Value("PHCollectionListMBS")="https://www.monkeybreadsoftware.net/class-phcollectionlistmbs.shtml"
		  linksMBS.Value("PHCollectionMBS")="https://www.monkeybreadsoftware.net/class-phcollectionmbs.shtml"
		  linksMBS.Value("PHContentEditingInputMBS")="https://www.monkeybreadsoftware.net/class-phcontenteditinginputmbs.shtml"
		  linksMBS.Value("PHContentEditingInputRequestOptionsMBS")="https://www.monkeybreadsoftware.net/class-phcontenteditinginputrequestoptionsmbs.shtml"
		  linksMBS.Value("PHContentEditingOutputMBS")="https://www.monkeybreadsoftware.net/class-phcontenteditingoutputmbs.shtml"
		  linksMBS.Value("PHFetchOptionsMBS")="https://www.monkeybreadsoftware.net/class-phfetchoptionsmbs.shtml"
		  linksMBS.Value("PHFetchResultChangeDetailsMBS")="https://www.monkeybreadsoftware.net/class-phfetchresultchangedetailsmbs.shtml"
		  linksMBS.Value("PHFetchResultMBS")="https://www.monkeybreadsoftware.net/class-phfetchresultmbs.shtml"
		  linksMBS.Value("PhidgetAccelerometerMBS")="https://www.monkeybreadsoftware.net/class-phidgetaccelerometermbs.shtml"
		  linksMBS.Value("PhidgetBLDCMotorMBS")="https://www.monkeybreadsoftware.net/class-phidgetbldcmotormbs.shtml"
		  linksMBS.Value("PhidgetCapacitiveTouchMBS")="https://www.monkeybreadsoftware.net/class-phidgetcapacitivetouchmbs.shtml"
		  linksMBS.Value("PhidgetCurrentInputMBS")="https://www.monkeybreadsoftware.net/class-phidgetcurrentinputmbs.shtml"
		  linksMBS.Value("PhidgetDCMotorMBS")="https://www.monkeybreadsoftware.net/class-phidgetdcmotormbs.shtml"
		  linksMBS.Value("PhidgetDictionaryMBS")="https://www.monkeybreadsoftware.net/class-phidgetdictionarymbs.shtml"
		  linksMBS.Value("PhidgetDigitalInputMBS")="https://www.monkeybreadsoftware.net/class-phidgetdigitalinputmbs.shtml"
		  linksMBS.Value("PhidgetDigitalOutputMBS")="https://www.monkeybreadsoftware.net/class-phidgetdigitaloutputmbs.shtml"
		  linksMBS.Value("PhidgetDistanceSensorMBS")="https://www.monkeybreadsoftware.net/class-phidgetdistancesensormbs.shtml"
		  linksMBS.Value("PhidgetEncoderMBS")="https://www.monkeybreadsoftware.net/class-phidgetencodermbs.shtml"
		  linksMBS.Value("PhidgetErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-phidgeterrorexceptionmbs.shtml"
		  linksMBS.Value("PhidgetFrequencyCounterMBS")="https://www.monkeybreadsoftware.net/class-phidgetfrequencycountermbs.shtml"
		  linksMBS.Value("PhidgetGPGGAMBS")="https://www.monkeybreadsoftware.net/class-phidgetgpggambs.shtml"
		  linksMBS.Value("PhidgetGPGSAMBS")="https://www.monkeybreadsoftware.net/class-phidgetgpgsambs.shtml"
		  linksMBS.Value("PhidgetGPRMCMBS")="https://www.monkeybreadsoftware.net/class-phidgetgprmcmbs.shtml"
		  linksMBS.Value("PhidgetGPSMBS")="https://www.monkeybreadsoftware.net/class-phidgetgpsmbs.shtml"
		  linksMBS.Value("PhidgetGPSNMEAMBS")="https://www.monkeybreadsoftware.net/class-phidgetgpsnmeambs.shtml"
		  linksMBS.Value("PhidgetGPVTGMBS")="https://www.monkeybreadsoftware.net/class-phidgetgpvtgmbs.shtml"
		  linksMBS.Value("PhidgetGyroscopeMBS")="https://www.monkeybreadsoftware.net/class-phidgetgyroscopembs.shtml"
		  linksMBS.Value("PhidgetHubMBS")="https://www.monkeybreadsoftware.net/class-phidgethubmbs.shtml"
		  linksMBS.Value("PhidgetHumiditySensorMBS")="https://www.monkeybreadsoftware.net/class-phidgethumiditysensormbs.shtml"
		  linksMBS.Value("PhidgetIRCodeInfoMBS")="https://www.monkeybreadsoftware.net/class-phidgetircodeinfombs.shtml"
		  linksMBS.Value("PhidgetIRMBS")="https://www.monkeybreadsoftware.net/class-phidgetirmbs.shtml"
		  linksMBS.Value("PhidgetLCDMBS")="https://www.monkeybreadsoftware.net/class-phidgetlcdmbs.shtml"
		  linksMBS.Value("PhidgetLightSensorMBS")="https://www.monkeybreadsoftware.net/class-phidgetlightsensormbs.shtml"
		  linksMBS.Value("PhidgetLogMBS")="https://www.monkeybreadsoftware.net/class-phidgetlogmbs.shtml"
		  linksMBS.Value("PhidgetMagnetometerMBS")="https://www.monkeybreadsoftware.net/class-phidgetmagnetometermbs.shtml"
		  linksMBS.Value("PhidgetManagerMBS")="https://www.monkeybreadsoftware.net/class-phidgetmanagermbs.shtml"
		  linksMBS.Value("PhidgetMBS")="https://www.monkeybreadsoftware.net/class-phidgetmbs.shtml"
		  linksMBS.Value("PhidgetMissingFunctionExceptionMBS")="https://www.monkeybreadsoftware.net/class-phidgetmissingfunctionexceptionmbs.shtml"
		  linksMBS.Value("PhidgetMotorPositionControllerMBS")="https://www.monkeybreadsoftware.net/class-phidgetmotorpositioncontrollermbs.shtml"
		  linksMBS.Value("PhidgetNetMBS")="https://www.monkeybreadsoftware.net/class-phidgetnetmbs.shtml"
		  linksMBS.Value("PhidgetNotInitialzedExceptionMBS")="https://www.monkeybreadsoftware.net/class-phidgetnotinitialzedexceptionmbs.shtml"
		  linksMBS.Value("PhidgetPHSensorMBS")="https://www.monkeybreadsoftware.net/class-phidgetphsensormbs.shtml"
		  linksMBS.Value("PhidgetPowerGuardMBS")="https://www.monkeybreadsoftware.net/class-phidgetpowerguardmbs.shtml"
		  linksMBS.Value("PhidgetPressureSensorMBS")="https://www.monkeybreadsoftware.net/class-phidgetpressuresensormbs.shtml"
		  linksMBS.Value("PhidgetRCServoMBS")="https://www.monkeybreadsoftware.net/class-phidgetrcservombs.shtml"
		  linksMBS.Value("PhidgetResistanceInputMBS")="https://www.monkeybreadsoftware.net/class-phidgetresistanceinputmbs.shtml"
		  linksMBS.Value("PhidgetRFIDMBS")="https://www.monkeybreadsoftware.net/class-phidgetrfidmbs.shtml"
		  linksMBS.Value("PhidgetServerMBS")="https://www.monkeybreadsoftware.net/class-phidgetservermbs.shtml"
		  linksMBS.Value("PhidgetSoundSensorMBS")="https://www.monkeybreadsoftware.net/class-phidgetsoundsensormbs.shtml"
		  linksMBS.Value("PhidgetSpatialMBS")="https://www.monkeybreadsoftware.net/class-phidgetspatialmbs.shtml"
		  linksMBS.Value("PhidgetStepperMBS")="https://www.monkeybreadsoftware.net/class-phidgetsteppermbs.shtml"
		  linksMBS.Value("PhidgetTemperatureSensorMBS")="https://www.monkeybreadsoftware.net/class-phidgettemperaturesensormbs.shtml"
		  linksMBS.Value("PhidgetUnitInfoMBS")="https://www.monkeybreadsoftware.net/class-phidgetunitinfombs.shtml"
		  linksMBS.Value("PhidgetVoltageInputMBS")="https://www.monkeybreadsoftware.net/class-phidgetvoltageinputmbs.shtml"
		  linksMBS.Value("PhidgetVoltageOutputMBS")="https://www.monkeybreadsoftware.net/class-phidgetvoltageoutputmbs.shtml"
		  linksMBS.Value("PhidgetVoltageRatioInputMBS")="https://www.monkeybreadsoftware.net/class-phidgetvoltageratioinputmbs.shtml"
		  linksMBS.Value("PHImageManagerMBS")="https://www.monkeybreadsoftware.net/class-phimagemanagermbs.shtml"
		  linksMBS.Value("PHImageRequestOptionsMBS")="https://www.monkeybreadsoftware.net/class-phimagerequestoptionsmbs.shtml"
		  linksMBS.Value("PHLivePhotoEditingContextMBS")="https://www.monkeybreadsoftware.net/class-phlivephotoeditingcontextmbs.shtml"
		  linksMBS.Value("PHLivePhotoFrameMBS")="https://www.monkeybreadsoftware.net/class-phlivephotoframembs.shtml"
		  linksMBS.Value("PHLivePhotoMBS")="https://www.monkeybreadsoftware.net/class-phlivephotombs.shtml"
		  linksMBS.Value("PHLivePhotoRequestOptionsMBS")="https://www.monkeybreadsoftware.net/class-phlivephotorequestoptionsmbs.shtml"
		  linksMBS.Value("PHObjectChangeDetailsMBS")="https://www.monkeybreadsoftware.net/class-phobjectchangedetailsmbs.shtml"
		  linksMBS.Value("PHObjectMBS")="https://www.monkeybreadsoftware.net/class-phobjectmbs.shtml"
		  linksMBS.Value("PHObjectPlaceholderMBS")="https://www.monkeybreadsoftware.net/class-phobjectplaceholdermbs.shtml"
		  linksMBS.Value("PHPhotoLibraryMBS")="https://www.monkeybreadsoftware.net/class-phphotolibrarymbs.shtml"
		  linksMBS.Value("PHPMBS")="https://www.monkeybreadsoftware.net/class-phpmbs.shtml"
		  linksMBS.Value("PHProjectChangeRequestMBS")="https://www.monkeybreadsoftware.net/class-phprojectchangerequestmbs.shtml"
		  linksMBS.Value("PHProjectMBS")="https://www.monkeybreadsoftware.net/class-phprojectmbs.shtml"
		  linksMBS.Value("PHVideoRequestOptionsMBS")="https://www.monkeybreadsoftware.net/class-phvideorequestoptionsmbs.shtml"
		  linksMBS.Value("Picture")="https://www.monkeybreadsoftware.net/class-picture.shtml"
		  linksMBS.Value("PictureConvolutionMBS")="https://www.monkeybreadsoftware.net/class-pictureconvolutionmbs.shtml"
		  linksMBS.Value("PictureEditorMBS")="https://www.monkeybreadsoftware.net/class-pictureeditormbs.shtml"
		  linksMBS.Value("PictureFactoryMBS")="https://www.monkeybreadsoftware.net/class-picturefactorymbs.shtml"
		  linksMBS.Value("PictureLut3DMBS")="https://www.monkeybreadsoftware.net/class-picturelut3dmbs.shtml"
		  linksMBS.Value("PictureMatrix3DMBS")="https://www.monkeybreadsoftware.net/class-picturematrix3dmbs.shtml"
		  linksMBS.Value("PictureMatrixMBS")="https://www.monkeybreadsoftware.net/class-picturematrixmbs.shtml"
		  linksMBS.Value("PictureMBS")="https://www.monkeybreadsoftware.net/class-picturembs.shtml"
		  linksMBS.Value("PictureMinMaxMBS")="https://www.monkeybreadsoftware.net/class-pictureminmaxmbs.shtml"
		  linksMBS.Value("PictureReaderMBS")="https://www.monkeybreadsoftware.net/class-picturereadermbs.shtml"
		  linksMBS.Value("PictureSepiaMBS")="https://www.monkeybreadsoftware.net/class-picturesepiambs.shtml"
		  linksMBS.Value("PictureWriterMBS")="https://www.monkeybreadsoftware.net/class-picturewritermbs.shtml"
		  linksMBS.Value("PKeyMBS")="https://www.monkeybreadsoftware.net/class-pkeymbs.shtml"
		  linksMBS.Value("PNGOptimizerMBS")="https://www.monkeybreadsoftware.net/class-pngoptimizermbs.shtml"
		  linksMBS.Value("PNGpictureMBS")="https://www.monkeybreadsoftware.net/class-pngpicturembs.shtml"
		  linksMBS.Value("PNGReaderMBS")="https://www.monkeybreadsoftware.net/class-pngreadermbs.shtml"
		  linksMBS.Value("PNGWriterMBS")="https://www.monkeybreadsoftware.net/class-pngwritermbs.shtml"
		  linksMBS.Value("PopupMenu")="https://www.monkeybreadsoftware.net/class-popupmenu.shtml"
		  linksMBS.Value("PortAudioDeviceInfoMBS")="https://www.monkeybreadsoftware.net/class-portaudiodeviceinfombs.shtml"
		  linksMBS.Value("PortAudioHostApiInfoMBS")="https://www.monkeybreadsoftware.net/class-portaudiohostapiinfombs.shtml"
		  linksMBS.Value("PortAudioHostErrorInfoMBS")="https://www.monkeybreadsoftware.net/class-portaudiohosterrorinfombs.shtml"
		  linksMBS.Value("PortAudioMBS")="https://www.monkeybreadsoftware.net/class-portaudiombs.shtml"
		  linksMBS.Value("PortAudioStreamBaseMBS")="https://www.monkeybreadsoftware.net/class-portaudiostreambasembs.shtml"
		  linksMBS.Value("PortAudioStreamBufferedMBS")="https://www.monkeybreadsoftware.net/class-portaudiostreambufferedmbs.shtml"
		  linksMBS.Value("PortAudioStreamInfoMBS")="https://www.monkeybreadsoftware.net/class-portaudiostreaminfombs.shtml"
		  linksMBS.Value("PortAudioStreamMBS")="https://www.monkeybreadsoftware.net/class-portaudiostreammbs.shtml"
		  linksMBS.Value("PortAudioStreamParametersMBS")="https://www.monkeybreadsoftware.net/class-portaudiostreamparametersmbs.shtml"
		  linksMBS.Value("PortAudioStreamRecorderMBS")="https://www.monkeybreadsoftware.net/class-portaudiostreamrecordermbs.shtml"
		  linksMBS.Value("PortMidiDeviceInfoMBS")="https://www.monkeybreadsoftware.net/class-portmidideviceinfombs.shtml"
		  linksMBS.Value("PortMidiEventMBS")="https://www.monkeybreadsoftware.net/class-portmidieventmbs.shtml"
		  linksMBS.Value("PortMidiMBS")="https://www.monkeybreadsoftware.net/class-portmidimbs.shtml"
		  linksMBS.Value("PortMidiStreamMBS")="https://www.monkeybreadsoftware.net/class-portmidistreammbs.shtml"
		  linksMBS.Value("ProcessMBS")="https://www.monkeybreadsoftware.net/class-processmbs.shtml"
		  linksMBS.Value("ProgressBar")="https://www.monkeybreadsoftware.net/class-progressbar.shtml"
		  linksMBS.Value("ProgressWheel")="https://www.monkeybreadsoftware.net/class-progresswheel.shtml"
		  linksMBS.Value("PushButton")="https://www.monkeybreadsoftware.net/class-pushbutton.shtml"
		  linksMBS.Value("QCCompositionMBS")="https://www.monkeybreadsoftware.net/class-qccompositionmbs.shtml"
		  linksMBS.Value("QCCompositionRepositoryMBS")="https://www.monkeybreadsoftware.net/class-qccompositionrepositorymbs.shtml"
		  linksMBS.Value("QCViewMBS")="https://www.monkeybreadsoftware.net/class-qcviewmbs.shtml"
		  linksMBS.Value("QLPreviewPanelMBS")="https://www.monkeybreadsoftware.net/class-qlpreviewpanelmbs.shtml"
		  linksMBS.Value("QLPreviewViewMBS")="https://www.monkeybreadsoftware.net/class-qlpreviewviewmbs.shtml"
		  linksMBS.Value("QTAudioChannelDescriptionMBS")="https://www.monkeybreadsoftware.net/class-qtaudiochanneldescriptionmbs.shtml"
		  linksMBS.Value("QTAudioChannelLayoutMBS")="https://www.monkeybreadsoftware.net/class-qtaudiochannellayoutmbs.shtml"
		  linksMBS.Value("QTSoundStreamMBS")="https://www.monkeybreadsoftware.net/class-qtsoundstreammbs.shtml"
		  linksMBS.Value("QuartzFilterManagerMBS")="https://www.monkeybreadsoftware.net/class-quartzfiltermanagermbs.shtml"
		  linksMBS.Value("QuartzFilterMBS")="https://www.monkeybreadsoftware.net/class-quartzfiltermbs.shtml"
		  linksMBS.Value("QuartzFilterViewMBS")="https://www.monkeybreadsoftware.net/class-quartzfilterviewmbs.shtml"
		  linksMBS.Value("RabbitMQBasicPropertiesMBS")="https://www.monkeybreadsoftware.net/class-rabbitmqbasicpropertiesmbs.shtml"
		  linksMBS.Value("RabbitMQConnectionInfoMBS")="https://www.monkeybreadsoftware.net/class-rabbitmqconnectioninfombs.shtml"
		  linksMBS.Value("RabbitMQConnectionMBS")="https://www.monkeybreadsoftware.net/class-rabbitmqconnectionmbs.shtml"
		  linksMBS.Value("RabbitMQEnvelopeMBS")="https://www.monkeybreadsoftware.net/class-rabbitmqenvelopembs.shtml"
		  linksMBS.Value("RabbitMQFrameMBS")="https://www.monkeybreadsoftware.net/class-rabbitmqframembs.shtml"
		  linksMBS.Value("RabbitMQMessageMBS")="https://www.monkeybreadsoftware.net/class-rabbitmqmessagembs.shtml"
		  linksMBS.Value("RabbitMQRPCReplyMBS")="https://www.monkeybreadsoftware.net/class-rabbitmqrpcreplymbs.shtml"
		  linksMBS.Value("Radiobutton")="https://www.monkeybreadsoftware.net/class-radiobutton.shtml"
		  linksMBS.Value("RAMStreamMBS")="https://www.monkeybreadsoftware.net/class-ramstreammbs.shtml"
		  linksMBS.Value("RaspberryPiCameraFormatDescriptionMBS")="https://www.monkeybreadsoftware.net/class-raspberrypicameraformatdescriptionmbs.shtml"
		  linksMBS.Value("RaspberryPiCameraFormatMBS")="https://www.monkeybreadsoftware.net/class-raspberrypicameraformatmbs.shtml"
		  linksMBS.Value("RaspberryPiCameraMBS")="https://www.monkeybreadsoftware.net/class-raspberrypicamerambs.shtml"
		  linksMBS.Value("RAWSocketMBS")="https://www.monkeybreadsoftware.net/class-rawsocketmbs.shtml"
		  linksMBS.Value("RC4MBS")="https://www.monkeybreadsoftware.net/class-rc4mbs.shtml"
		  linksMBS.Value("RC5MBS")="https://www.monkeybreadsoftware.net/class-rc5mbs.shtml"
		  linksMBS.Value("RecordSet")="https://www.monkeybreadsoftware.net/class-recordset.shtml"
		  linksMBS.Value("RectControl")="https://www.monkeybreadsoftware.net/class-rectcontrol.shtml"
		  linksMBS.Value("RegExMBS")="https://www.monkeybreadsoftware.net/class-regexmbs.shtml"
		  linksMBS.Value("RegistrationEngineMBS")="https://www.monkeybreadsoftware.net/class-registrationenginembs.shtml"
		  linksMBS.Value("RegistryFileTypeMBS")="https://www.monkeybreadsoftware.net/class-registryfiletypembs.shtml"
		  linksMBS.Value("RegistryKeyMBS")="https://www.monkeybreadsoftware.net/class-registrykeymbs.shtml"
		  linksMBS.Value("RegistryMBS")="https://www.monkeybreadsoftware.net/class-registrymbs.shtml"
		  linksMBS.Value("RegistryValueMBS")="https://www.monkeybreadsoftware.net/class-registryvaluembs.shtml"
		  linksMBS.Value("ResolutionMBS")="https://www.monkeybreadsoftware.net/class-resolutionmbs.shtml"
		  linksMBS.Value("ResourceForkMBS")="https://www.monkeybreadsoftware.net/class-resourceforkmbs.shtml"
		  linksMBS.Value("ResStreamMBS")="https://www.monkeybreadsoftware.net/class-resstreammbs.shtml"
		  linksMBS.Value("RFCClassDescriptionMBS")="https://www.monkeybreadsoftware.net/class-rfcclassdescriptionmbs.shtml"
		  linksMBS.Value("RFCConnectionAttributesMBS")="https://www.monkeybreadsoftware.net/class-rfcconnectionattributesmbs.shtml"
		  linksMBS.Value("RFCConnectionMBS")="https://www.monkeybreadsoftware.net/class-rfcconnectionmbs.shtml"
		  linksMBS.Value("RFCContainerMBS")="https://www.monkeybreadsoftware.net/class-rfccontainermbs.shtml"
		  linksMBS.Value("RFCErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-rfcerrorexceptionmbs.shtml"
		  linksMBS.Value("RFCExceptionDescriptionMBS")="https://www.monkeybreadsoftware.net/class-rfcexceptiondescriptionmbs.shtml"
		  linksMBS.Value("RFCFieldDescriptionMBS")="https://www.monkeybreadsoftware.net/class-rfcfielddescriptionmbs.shtml"
		  linksMBS.Value("RFCFunctionDescriptionMBS")="https://www.monkeybreadsoftware.net/class-rfcfunctiondescriptionmbs.shtml"
		  linksMBS.Value("RFCFunctionMBS")="https://www.monkeybreadsoftware.net/class-rfcfunctionmbs.shtml"
		  linksMBS.Value("RFCParameterDescriptionMBS")="https://www.monkeybreadsoftware.net/class-rfcparameterdescriptionmbs.shtml"
		  linksMBS.Value("RFCStructureMBS")="https://www.monkeybreadsoftware.net/class-rfcstructurembs.shtml"
		  linksMBS.Value("RFCTableMBS")="https://www.monkeybreadsoftware.net/class-rfctablembs.shtml"
		  linksMBS.Value("RFCTransactionMBS")="https://www.monkeybreadsoftware.net/class-rfctransactionmbs.shtml"
		  linksMBS.Value("RFCTypeDescriptionMBS")="https://www.monkeybreadsoftware.net/class-rfctypedescriptionmbs.shtml"
		  linksMBS.Value("Rockey4NDMBS")="https://www.monkeybreadsoftware.net/class-rockey4ndmbs.shtml"
		  linksMBS.Value("ScintillaFailureExceptionMBS")="https://www.monkeybreadsoftware.net/class-scintillafailureexceptionmbs.shtml"
		  linksMBS.Value("ScintillaIndicatorMBS")="https://www.monkeybreadsoftware.net/class-scintillaindicatormbs.shtml"
		  linksMBS.Value("ScintillaLoaderMBS")="https://www.monkeybreadsoftware.net/class-scintillaloadermbs.shtml"
		  linksMBS.Value("ScintillaMarginMBS")="https://www.monkeybreadsoftware.net/class-scintillamarginmbs.shtml"
		  linksMBS.Value("ScintillaMarkerMBS")="https://www.monkeybreadsoftware.net/class-scintillamarkermbs.shtml"
		  linksMBS.Value("ScintillaSpanMBS")="https://www.monkeybreadsoftware.net/class-scintillaspanmbs.shtml"
		  linksMBS.Value("ScintillaStyleMBS")="https://www.monkeybreadsoftware.net/class-scintillastylembs.shtml"
		  linksMBS.Value("SCNAccelerationConstraintMBS")="https://www.monkeybreadsoftware.net/class-scnaccelerationconstraintmbs.shtml"
		  linksMBS.Value("SCNActionMBS")="https://www.monkeybreadsoftware.net/class-scnactionmbs.shtml"
		  linksMBS.Value("SCNAudioPlayerMBS")="https://www.monkeybreadsoftware.net/class-scnaudioplayermbs.shtml"
		  linksMBS.Value("SCNAudioSourceMBS")="https://www.monkeybreadsoftware.net/class-scnaudiosourcembs.shtml"
		  linksMBS.Value("SCNAvoidOccluderConstraintMBS")="https://www.monkeybreadsoftware.net/class-scnavoidoccluderconstraintmbs.shtml"
		  linksMBS.Value("SCNBillboardConstraintMBS")="https://www.monkeybreadsoftware.net/class-scnbillboardconstraintmbs.shtml"
		  linksMBS.Value("SCNBoxMBS")="https://www.monkeybreadsoftware.net/class-scnboxmbs.shtml"
		  linksMBS.Value("SCNCameraControllerMBS")="https://www.monkeybreadsoftware.net/class-scncameracontrollermbs.shtml"
		  linksMBS.Value("SCNCameraMBS")="https://www.monkeybreadsoftware.net/class-scncamerambs.shtml"
		  linksMBS.Value("SCNCapsuleMBS")="https://www.monkeybreadsoftware.net/class-scncapsulembs.shtml"
		  linksMBS.Value("SCNConeMBS")="https://www.monkeybreadsoftware.net/class-scnconembs.shtml"
		  linksMBS.Value("SCNConstraintMBS")="https://www.monkeybreadsoftware.net/class-scnconstraintmbs.shtml"
		  linksMBS.Value("SCNCylinderMBS")="https://www.monkeybreadsoftware.net/class-scncylindermbs.shtml"
		  linksMBS.Value("SCNDistanceConstraintMBS")="https://www.monkeybreadsoftware.net/class-scndistanceconstraintmbs.shtml"
		  linksMBS.Value("SCNetworkReachabilityMBS")="https://www.monkeybreadsoftware.net/class-scnetworkreachabilitymbs.shtml"
		  linksMBS.Value("SCNFloorMBS")="https://www.monkeybreadsoftware.net/class-scnfloormbs.shtml"
		  linksMBS.Value("SCNGeometryElementMBS")="https://www.monkeybreadsoftware.net/class-scngeometryelementmbs.shtml"
		  linksMBS.Value("SCNGeometryMBS")="https://www.monkeybreadsoftware.net/class-scngeometrymbs.shtml"
		  linksMBS.Value("SCNGeometrySourceMBS")="https://www.monkeybreadsoftware.net/class-scngeometrysourcembs.shtml"
		  linksMBS.Value("SCNGeometryTessellatorMBS")="https://www.monkeybreadsoftware.net/class-scngeometrytessellatormbs.shtml"
		  linksMBS.Value("SCNHitTestResultMBS")="https://www.monkeybreadsoftware.net/class-scnhittestresultmbs.shtml"
		  linksMBS.Value("SCNIKConstraintMBS")="https://www.monkeybreadsoftware.net/class-scnikconstraintmbs.shtml"
		  linksMBS.Value("SCNLevelOfDetailMBS")="https://www.monkeybreadsoftware.net/class-scnlevelofdetailmbs.shtml"
		  linksMBS.Value("SCNLightMBS")="https://www.monkeybreadsoftware.net/class-scnlightmbs.shtml"
		  linksMBS.Value("SCNLookAtConstraintMBS")="https://www.monkeybreadsoftware.net/class-scnlookatconstraintmbs.shtml"
		  linksMBS.Value("SCNMaterialMBS")="https://www.monkeybreadsoftware.net/class-scnmaterialmbs.shtml"
		  linksMBS.Value("SCNMaterialPropertyMBS")="https://www.monkeybreadsoftware.net/class-scnmaterialpropertymbs.shtml"
		  linksMBS.Value("SCNMatrix4MBS")="https://www.monkeybreadsoftware.net/class-scnmatrix4mbs.shtml"
		  linksMBS.Value("SCNNodeMBS")="https://www.monkeybreadsoftware.net/class-scnnodembs.shtml"
		  linksMBS.Value("SCNPhysicsBallSocketJointMBS")="https://www.monkeybreadsoftware.net/class-scnphysicsballsocketjointmbs.shtml"
		  linksMBS.Value("SCNPhysicsBehaviorMBS")="https://www.monkeybreadsoftware.net/class-scnphysicsbehaviormbs.shtml"
		  linksMBS.Value("SCNPhysicsBodyMBS")="https://www.monkeybreadsoftware.net/class-scnphysicsbodymbs.shtml"
		  linksMBS.Value("SCNPhysicsConeTwistJointMBS")="https://www.monkeybreadsoftware.net/class-scnphysicsconetwistjointmbs.shtml"
		  linksMBS.Value("SCNPhysicsContactMBS")="https://www.monkeybreadsoftware.net/class-scnphysicscontactmbs.shtml"
		  linksMBS.Value("SCNPhysicsFieldMBS")="https://www.monkeybreadsoftware.net/class-scnphysicsfieldmbs.shtml"
		  linksMBS.Value("SCNPhysicsHingeJointMBS")="https://www.monkeybreadsoftware.net/class-scnphysicshingejointmbs.shtml"
		  linksMBS.Value("SCNPhysicsShapeMBS")="https://www.monkeybreadsoftware.net/class-scnphysicsshapembs.shtml"
		  linksMBS.Value("SCNPhysicsSliderJointMBS")="https://www.monkeybreadsoftware.net/class-scnphysicssliderjointmbs.shtml"
		  linksMBS.Value("SCNPhysicsVehicleMBS")="https://www.monkeybreadsoftware.net/class-scnphysicsvehiclembs.shtml"
		  linksMBS.Value("SCNPhysicsVehicleWheelMBS")="https://www.monkeybreadsoftware.net/class-scnphysicsvehiclewheelmbs.shtml"
		  linksMBS.Value("SCNPhysicsWorldMBS")="https://www.monkeybreadsoftware.net/class-scnphysicsworldmbs.shtml"
		  linksMBS.Value("SCNPlaneMBS")="https://www.monkeybreadsoftware.net/class-scnplanembs.shtml"
		  linksMBS.Value("SCNPyramidMBS")="https://www.monkeybreadsoftware.net/class-scnpyramidmbs.shtml"
		  linksMBS.Value("SCNReplicatorConstraintMBS")="https://www.monkeybreadsoftware.net/class-scnreplicatorconstraintmbs.shtml"
		  linksMBS.Value("SCNSceneMBS")="https://www.monkeybreadsoftware.net/class-scnscenembs.shtml"
		  linksMBS.Value("SCNShapeMBS")="https://www.monkeybreadsoftware.net/class-scnshapembs.shtml"
		  linksMBS.Value("SCNSliderConstraintMBS")="https://www.monkeybreadsoftware.net/class-scnsliderconstraintmbs.shtml"
		  linksMBS.Value("SCNSphereMBS")="https://www.monkeybreadsoftware.net/class-scnspherembs.shtml"
		  linksMBS.Value("SCNTextMBS")="https://www.monkeybreadsoftware.net/class-scntextmbs.shtml"
		  linksMBS.Value("SCNTorusMBS")="https://www.monkeybreadsoftware.net/class-scntorusmbs.shtml"
		  linksMBS.Value("SCNTransformConstraintMBS")="https://www.monkeybreadsoftware.net/class-scntransformconstraintmbs.shtml"
		  linksMBS.Value("SCNTubeMBS")="https://www.monkeybreadsoftware.net/class-scntubembs.shtml"
		  linksMBS.Value("SCNVector3MBS")="https://www.monkeybreadsoftware.net/class-scnvector3mbs.shtml"
		  linksMBS.Value("SCNVector4MBS")="https://www.monkeybreadsoftware.net/class-scnvector4mbs.shtml"
		  linksMBS.Value("SCNViewMBS")="https://www.monkeybreadsoftware.net/class-scnviewmbs.shtml"
		  linksMBS.Value("SCPreferencesMBS")="https://www.monkeybreadsoftware.net/class-scpreferencesmbs.shtml"
		  linksMBS.Value("ScrollBar")="https://www.monkeybreadsoftware.net/class-scrollbar.shtml"
		  linksMBS.Value("SDAVAssetExportSessionMBS")="https://www.monkeybreadsoftware.net/class-sdavassetexportsessionmbs.shtml"
		  linksMBS.Value("SearchField")="https://www.monkeybreadsoftware.net/class-searchfield.shtml"
		  linksMBS.Value("SegmentedControl")="https://www.monkeybreadsoftware.net/class-segmentedcontrol.shtml"
		  linksMBS.Value("Separator")="https://www.monkeybreadsoftware.net/class-separator.shtml"
		  linksMBS.Value("SerialPortMBS")="https://www.monkeybreadsoftware.net/class-serialportmbs.shtml"
		  linksMBS.Value("SFAcousticFeatureMBS")="https://www.monkeybreadsoftware.net/class-sfacousticfeaturembs.shtml"
		  linksMBS.Value("SFPasswordAssistantMBS")="https://www.monkeybreadsoftware.net/class-sfpasswordassistantmbs.shtml"
		  linksMBS.Value("SFSpeechAudioBufferRecognitionRequestMBS")="https://www.monkeybreadsoftware.net/class-sfspeechaudiobufferrecognitionrequestmbs.shtml"
		  linksMBS.Value("SFSpeechRecognitionRequestMBS")="https://www.monkeybreadsoftware.net/class-sfspeechrecognitionrequestmbs.shtml"
		  linksMBS.Value("SFSpeechRecognitionResultMBS")="https://www.monkeybreadsoftware.net/class-sfspeechrecognitionresultmbs.shtml"
		  linksMBS.Value("SFSpeechRecognitionTaskMBS")="https://www.monkeybreadsoftware.net/class-sfspeechrecognitiontaskmbs.shtml"
		  linksMBS.Value("SFSpeechRecognizerMBS")="https://www.monkeybreadsoftware.net/class-sfspeechrecognizermbs.shtml"
		  linksMBS.Value("SFSpeechURLRecognitionRequestMBS")="https://www.monkeybreadsoftware.net/class-sfspeechurlrecognitionrequestmbs.shtml"
		  linksMBS.Value("SFTranscriptionMBS")="https://www.monkeybreadsoftware.net/class-sftranscriptionmbs.shtml"
		  linksMBS.Value("SFTranscriptionSegmentMBS")="https://www.monkeybreadsoftware.net/class-sftranscriptionsegmentmbs.shtml"
		  linksMBS.Value("SFVoiceAnalyticsMBS")="https://www.monkeybreadsoftware.net/class-sfvoiceanalyticsmbs.shtml"
		  linksMBS.Value("SHA1MBS")="https://www.monkeybreadsoftware.net/class-sha1mbs.shtml"
		  linksMBS.Value("SHA256MBS")="https://www.monkeybreadsoftware.net/class-sha256mbs.shtml"
		  linksMBS.Value("SHA3MBS")="https://www.monkeybreadsoftware.net/class-sha3mbs.shtml"
		  linksMBS.Value("SHA512MBS")="https://www.monkeybreadsoftware.net/class-sha512mbs.shtml"
		  linksMBS.Value("SharingPanelMBS")="https://www.monkeybreadsoftware.net/class-sharingpanelmbs.shtml"
		  linksMBS.Value("ShellMBS")="https://www.monkeybreadsoftware.net/class-shellmbs.shtml"
		  linksMBS.Value("SignalHandlerMBS")="https://www.monkeybreadsoftware.net/class-signalhandlermbs.shtml"
		  linksMBS.Value("SKDownloadMBS")="https://www.monkeybreadsoftware.net/class-skdownloadmbs.shtml"
		  linksMBS.Value("SKMutablePaymentMBS")="https://www.monkeybreadsoftware.net/class-skmutablepaymentmbs.shtml"
		  linksMBS.Value("SKPaymentMBS")="https://www.monkeybreadsoftware.net/class-skpaymentmbs.shtml"
		  linksMBS.Value("SKPaymentQueueMBS")="https://www.monkeybreadsoftware.net/class-skpaymentqueuembs.shtml"
		  linksMBS.Value("SKPaymentTransactionMBS")="https://www.monkeybreadsoftware.net/class-skpaymenttransactionmbs.shtml"
		  linksMBS.Value("SKProductDiscountMBS")="https://www.monkeybreadsoftware.net/class-skproductdiscountmbs.shtml"
		  linksMBS.Value("SKProductMBS")="https://www.monkeybreadsoftware.net/class-skproductmbs.shtml"
		  linksMBS.Value("SKProductsRequestMBS")="https://www.monkeybreadsoftware.net/class-skproductsrequestmbs.shtml"
		  linksMBS.Value("SKProductSubscriptionPeriodMBS")="https://www.monkeybreadsoftware.net/class-skproductsubscriptionperiodmbs.shtml"
		  linksMBS.Value("SKReceiptRefreshRequestMBS")="https://www.monkeybreadsoftware.net/class-skreceiptrefreshrequestmbs.shtml"
		  linksMBS.Value("SleepNotificationMBS")="https://www.monkeybreadsoftware.net/class-sleepnotificationmbs.shtml"
		  linksMBS.Value("Slider")="https://www.monkeybreadsoftware.net/class-slider.shtml"
		  linksMBS.Value("SLRequestMBS")="https://www.monkeybreadsoftware.net/class-slrequestmbs.shtml"
		  linksMBS.Value("SmartCardContextMBS")="https://www.monkeybreadsoftware.net/class-smartcardcontextmbs.shtml"
		  linksMBS.Value("SmartCardMBS")="https://www.monkeybreadsoftware.net/class-smartcardmbs.shtml"
		  linksMBS.Value("SoftDeclareMBS")="https://www.monkeybreadsoftware.net/class-softdeclarembs.shtml"
		  linksMBS.Value("Sound")="https://www.monkeybreadsoftware.net/class-sound.shtml"
		  linksMBS.Value("SoundFileInfoMBS")="https://www.monkeybreadsoftware.net/class-soundfileinfombs.shtml"
		  linksMBS.Value("SoundFileMBS")="https://www.monkeybreadsoftware.net/class-soundfilembs.shtml"
		  linksMBS.Value("SpamSumMBS")="https://www.monkeybreadsoftware.net/class-spamsummbs.shtml"
		  linksMBS.Value("SpinningProgressIndicatorMBS")="https://www.monkeybreadsoftware.net/class-spinningprogressindicatormbs.shtml"
		  linksMBS.Value("SplineMBS")="https://www.monkeybreadsoftware.net/class-splinembs.shtml"
		  linksMBS.Value("SQLBLobMBS")="https://www.monkeybreadsoftware.net/class-sqlblobmbs.shtml"
		  linksMBS.Value("SQLBytesMBS")="https://www.monkeybreadsoftware.net/class-sqlbytesmbs.shtml"
		  linksMBS.Value("SQLCLobMBS")="https://www.monkeybreadsoftware.net/class-sqlclobmbs.shtml"
		  linksMBS.Value("SQLCommandMBS")="https://www.monkeybreadsoftware.net/class-sqlcommandmbs.shtml"
		  linksMBS.Value("SQLConnectionMBS")="https://www.monkeybreadsoftware.net/class-sqlconnectionmbs.shtml"
		  linksMBS.Value("SQLDatabaseMBS")="https://www.monkeybreadsoftware.net/class-sqldatabasembs.shtml"
		  linksMBS.Value("SQLDataConsumerMBS")="https://www.monkeybreadsoftware.net/class-sqldataconsumermbs.shtml"
		  linksMBS.Value("SQLDataProviderMBS")="https://www.monkeybreadsoftware.net/class-sqldataprovidermbs.shtml"
		  linksMBS.Value("SQLDateTimeMBS")="https://www.monkeybreadsoftware.net/class-sqldatetimembs.shtml"
		  linksMBS.Value("SQLErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-sqlerrorexceptionmbs.shtml"
		  linksMBS.Value("SQLFieldMBS")="https://www.monkeybreadsoftware.net/class-sqlfieldmbs.shtml"
		  linksMBS.Value("SQLGlobalsMBS")="https://www.monkeybreadsoftware.net/class-sqlglobalsmbs.shtml"
		  linksMBS.Value("SQLIntervalMBS")="https://www.monkeybreadsoftware.net/class-sqlintervalmbs.shtml"
		  linksMBS.Value("SQLite3BackupMBS")="https://www.monkeybreadsoftware.net/class-sqlite3backupmbs.shtml"
		  linksMBS.Value("SQLLongBinaryMBS")="https://www.monkeybreadsoftware.net/class-sqllongbinarymbs.shtml"
		  linksMBS.Value("SQLLongCharMBS")="https://www.monkeybreadsoftware.net/class-sqllongcharmbs.shtml"
		  linksMBS.Value("SQLLongOrLobMBS")="https://www.monkeybreadsoftware.net/class-sqllongorlobmbs.shtml"
		  linksMBS.Value("SQLNotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-sqlnotinitializedexceptionmbs.shtml"
		  linksMBS.Value("SQLNullMBS")="https://www.monkeybreadsoftware.net/class-sqlnullmbs.shtml"
		  linksMBS.Value("SQLNumericMBS")="https://www.monkeybreadsoftware.net/class-sqlnumericmbs.shtml"
		  linksMBS.Value("SQLParamMBS")="https://www.monkeybreadsoftware.net/class-sqlparammbs.shtml"
		  linksMBS.Value("SQLPositionMBS")="https://www.monkeybreadsoftware.net/class-sqlpositionmbs.shtml"
		  linksMBS.Value("SQLPreparedStatementMBS")="https://www.monkeybreadsoftware.net/class-sqlpreparedstatementmbs.shtml"
		  linksMBS.Value("SQLStringMBS")="https://www.monkeybreadsoftware.net/class-sqlstringmbs.shtml"
		  linksMBS.Value("SQLUnsupportedExceptionMBS")="https://www.monkeybreadsoftware.net/class-sqlunsupportedexceptionmbs.shtml"
		  linksMBS.Value("SQLValueMBS")="https://www.monkeybreadsoftware.net/class-sqlvaluembs.shtml"
		  linksMBS.Value("SQLValueReadMBS")="https://www.monkeybreadsoftware.net/class-sqlvaluereadmbs.shtml"
		  linksMBS.Value("SSH2ChannelMBS")="https://www.monkeybreadsoftware.net/class-ssh2channelmbs.shtml"
		  linksMBS.Value("SSH2ConnectFailedExceptionMBS")="https://www.monkeybreadsoftware.net/class-ssh2connectfailedexceptionmbs.shtml"
		  linksMBS.Value("SSH2SessionMBS")="https://www.monkeybreadsoftware.net/class-ssh2sessionmbs.shtml"
		  linksMBS.Value("SSH2TunnelMBS")="https://www.monkeybreadsoftware.net/class-ssh2tunnelmbs.shtml"
		  linksMBS.Value("SSH2UserAuthKeyboardInteractivePromptMBS")="https://www.monkeybreadsoftware.net/class-ssh2userauthkeyboardinteractivepromptmbs.shtml"
		  linksMBS.Value("SSH2UserAuthKeyboardInteractiveResponseMBS")="https://www.monkeybreadsoftware.net/class-ssh2userauthkeyboardinteractiveresponsembs.shtml"
		  linksMBS.Value("StackDoubleMBS")="https://www.monkeybreadsoftware.net/class-stackdoublembs.shtml"
		  linksMBS.Value("StackIntegerMBS")="https://www.monkeybreadsoftware.net/class-stackintegermbs.shtml"
		  linksMBS.Value("StackObjectMBS")="https://www.monkeybreadsoftware.net/class-stackobjectmbs.shtml"
		  linksMBS.Value("StackSingleMBS")="https://www.monkeybreadsoftware.net/class-stacksinglembs.shtml"
		  linksMBS.Value("StackStringMBS")="https://www.monkeybreadsoftware.net/class-stackstringmbs.shtml"
		  linksMBS.Value("StackVariantMBS")="https://www.monkeybreadsoftware.net/class-stackvariantmbs.shtml"
		  linksMBS.Value("Statictext")="https://www.monkeybreadsoftware.net/class-statictext.shtml"
		  linksMBS.Value("StdinMBS")="https://www.monkeybreadsoftware.net/class-stdinmbs.shtml"
		  linksMBS.Value("StdoutMBS")="https://www.monkeybreadsoftware.net/class-stdoutmbs.shtml"
		  linksMBS.Value("StringHandleMBS")="https://www.monkeybreadsoftware.net/class-stringhandlembs.shtml"
		  linksMBS.Value("StringHashSetIteratorMBS")="https://www.monkeybreadsoftware.net/class-stringhashsetiteratormbs.shtml"
		  linksMBS.Value("StringHashSetMBS")="https://www.monkeybreadsoftware.net/class-stringhashsetmbs.shtml"
		  linksMBS.Value("StringOrderedSetIteratorMBS")="https://www.monkeybreadsoftware.net/class-stringorderedsetiteratormbs.shtml"
		  linksMBS.Value("StringOrderedSetMBS")="https://www.monkeybreadsoftware.net/class-stringorderedsetmbs.shtml"
		  linksMBS.Value("StringToStringHashMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-stringtostringhashmapiteratormbs.shtml"
		  linksMBS.Value("StringToStringHashMapMBS")="https://www.monkeybreadsoftware.net/class-stringtostringhashmapmbs.shtml"
		  linksMBS.Value("StringToStringOrderedMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-stringtostringorderedmapiteratormbs.shtml"
		  linksMBS.Value("StringToStringOrderedMapMBS")="https://www.monkeybreadsoftware.net/class-stringtostringorderedmapmbs.shtml"
		  linksMBS.Value("StringToVariantHashMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-stringtovarianthashmapiteratormbs.shtml"
		  linksMBS.Value("StringToVariantHashMapMBS")="https://www.monkeybreadsoftware.net/class-stringtovarianthashmapmbs.shtml"
		  linksMBS.Value("StringToVariantOrderedMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-stringtovariantorderedmapiteratormbs.shtml"
		  linksMBS.Value("StringToVariantOrderedMapMBS")="https://www.monkeybreadsoftware.net/class-stringtovariantorderedmapmbs.shtml"
		  linksMBS.Value("StyledText")="https://www.monkeybreadsoftware.net/class-styledtext.shtml"
		  linksMBS.Value("SUAppcastItemMBS")="https://www.monkeybreadsoftware.net/class-suappcastitemmbs.shtml"
		  linksMBS.Value("SUAppcastMBS")="https://www.monkeybreadsoftware.net/class-suappcastmbs.shtml"
		  linksMBS.Value("SummaryMBS")="https://www.monkeybreadsoftware.net/class-summarymbs.shtml"
		  linksMBS.Value("SUUpdaterMBS")="https://www.monkeybreadsoftware.net/class-suupdatermbs.shtml"
		  linksMBS.Value("SUVersionComparisonMBS")="https://www.monkeybreadsoftware.net/class-suversioncomparisonmbs.shtml"
		  linksMBS.Value("SystemConfigurationMBS")="https://www.monkeybreadsoftware.net/class-systemconfigurationmbs.shtml"
		  linksMBS.Value("TabPanel")="https://www.monkeybreadsoftware.net/class-tabpanel.shtml"
		  linksMBS.Value("TagLibAudioPropertiesMBS")="https://www.monkeybreadsoftware.net/class-taglibaudiopropertiesmbs.shtml"
		  linksMBS.Value("TagLibFileRefMBS")="https://www.monkeybreadsoftware.net/class-taglibfilerefmbs.shtml"
		  linksMBS.Value("TagLibTagMBS")="https://www.monkeybreadsoftware.net/class-taglibtagmbs.shtml"
		  linksMBS.Value("TAPICallControlMBS")="https://www.monkeybreadsoftware.net/class-tapicallcontrolmbs.shtml"
		  linksMBS.Value("TAPIMBS")="https://www.monkeybreadsoftware.net/class-tapimbs.shtml"
		  linksMBS.Value("TaskDialogButtonMBS")="https://www.monkeybreadsoftware.net/class-taskdialogbuttonmbs.shtml"
		  linksMBS.Value("TaskDialogMBS")="https://www.monkeybreadsoftware.net/class-taskdialogmbs.shtml"
		  linksMBS.Value("TCPSocket")="https://www.monkeybreadsoftware.net/class-tcpsocket.shtml"
		  linksMBS.Value("TessChoiceIteratorMBS")="https://www.monkeybreadsoftware.net/class-tesschoiceiteratormbs.shtml"
		  linksMBS.Value("TessEngineMBS")="https://www.monkeybreadsoftware.net/class-tessenginembs.shtml"
		  linksMBS.Value("TesseractChoiceIteratorMBS")="https://www.monkeybreadsoftware.net/class-tesseractchoiceiteratormbs.shtml"
		  linksMBS.Value("TesseractErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-tesseracterrorexceptionmbs.shtml"
		  linksMBS.Value("TesseractMBS")="https://www.monkeybreadsoftware.net/class-tesseractmbs.shtml"
		  linksMBS.Value("TesseractNotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-tesseractnotinitializedexceptionmbs.shtml"
		  linksMBS.Value("TesseractResultIteratorMBS")="https://www.monkeybreadsoftware.net/class-tesseractresultiteratormbs.shtml"
		  linksMBS.Value("TessPageIteratorMBS")="https://www.monkeybreadsoftware.net/class-tesspageiteratormbs.shtml"
		  linksMBS.Value("TessResultIteratorMBS")="https://www.monkeybreadsoftware.net/class-tessresultiteratormbs.shtml"
		  linksMBS.Value("TextArea")="https://www.monkeybreadsoftware.net/class-textarea.shtml"
		  linksMBS.Value("TextConverterMBS")="https://www.monkeybreadsoftware.net/class-textconvertermbs.shtml"
		  linksMBS.Value("TextEncoding")="https://www.monkeybreadsoftware.net/class-textencoding.shtml"
		  linksMBS.Value("TextField")="https://www.monkeybreadsoftware.net/class-textfield.shtml"
		  linksMBS.Value("TextInputSourceMBS")="https://www.monkeybreadsoftware.net/class-textinputsourcembs.shtml"
		  linksMBS.Value("TidyAttributeMBS")="https://www.monkeybreadsoftware.net/class-tidyattributembs.shtml"
		  linksMBS.Value("TidyDocumentMBS")="https://www.monkeybreadsoftware.net/class-tidydocumentmbs.shtml"
		  linksMBS.Value("TidyInputMBS")="https://www.monkeybreadsoftware.net/class-tidyinputmbs.shtml"
		  linksMBS.Value("TidyIteratorMBS")="https://www.monkeybreadsoftware.net/class-tidyiteratormbs.shtml"
		  linksMBS.Value("TidyNodeMBS")="https://www.monkeybreadsoftware.net/class-tidynodembs.shtml"
		  linksMBS.Value("TidyOptionMBS")="https://www.monkeybreadsoftware.net/class-tidyoptionmbs.shtml"
		  linksMBS.Value("TidyOutputMBS")="https://www.monkeybreadsoftware.net/class-tidyoutputmbs.shtml"
		  linksMBS.Value("TiffPictureMBS")="https://www.monkeybreadsoftware.net/class-tiffpicturembs.shtml"
		  linksMBS.Value("TimerMBS")="https://www.monkeybreadsoftware.net/class-timermbs.shtml"
		  linksMBS.Value("TKBERTLVRecordMBS")="https://www.monkeybreadsoftware.net/class-tkbertlvrecordmbs.shtml"
		  linksMBS.Value("TKCompactTLVRecordMBS")="https://www.monkeybreadsoftware.net/class-tkcompacttlvrecordmbs.shtml"
		  linksMBS.Value("TKSimpleTLVRecordMBS")="https://www.monkeybreadsoftware.net/class-tksimpletlvrecordmbs.shtml"
		  linksMBS.Value("TKSmartCardATRInterfaceGroupMBS")="https://www.monkeybreadsoftware.net/class-tksmartcardatrinterfacegroupmbs.shtml"
		  linksMBS.Value("TKSmartCardATRMBS")="https://www.monkeybreadsoftware.net/class-tksmartcardatrmbs.shtml"
		  linksMBS.Value("TKSmartCardMBS")="https://www.monkeybreadsoftware.net/class-tksmartcardmbs.shtml"
		  linksMBS.Value("TKSmartCardPINFormatMBS")="https://www.monkeybreadsoftware.net/class-tksmartcardpinformatmbs.shtml"
		  linksMBS.Value("TKSmartCardSlotManagerMBS")="https://www.monkeybreadsoftware.net/class-tksmartcardslotmanagermbs.shtml"
		  linksMBS.Value("TKSmartCardSlotMBS")="https://www.monkeybreadsoftware.net/class-tksmartcardslotmbs.shtml"
		  linksMBS.Value("TKSmartCardTokenDriverMBS")="https://www.monkeybreadsoftware.net/class-tksmartcardtokendrivermbs.shtml"
		  linksMBS.Value("TKSmartCardTokenMBS")="https://www.monkeybreadsoftware.net/class-tksmartcardtokenmbs.shtml"
		  linksMBS.Value("TKSmartCardTokenSessionMBS")="https://www.monkeybreadsoftware.net/class-tksmartcardtokensessionmbs.shtml"
		  linksMBS.Value("TKSmartCardUserInteractionForPINOperationMBS")="https://www.monkeybreadsoftware.net/class-tksmartcarduserinteractionforpinoperationmbs.shtml"
		  linksMBS.Value("TKSmartCardUserInteractionForSecurePINChangeMBS")="https://www.monkeybreadsoftware.net/class-tksmartcarduserinteractionforsecurepinchangembs.shtml"
		  linksMBS.Value("TKSmartCardUserInteractionForSecurePINVerificationMBS")="https://www.monkeybreadsoftware.net/class-tksmartcarduserinteractionforsecurepinverificationmbs.shtml"
		  linksMBS.Value("TKSmartCardUserInteractionMBS")="https://www.monkeybreadsoftware.net/class-tksmartcarduserinteractionmbs.shtml"
		  linksMBS.Value("TKTLVRecordMBS")="https://www.monkeybreadsoftware.net/class-tktlvrecordmbs.shtml"
		  linksMBS.Value("TKTokenAuthOperationMBS")="https://www.monkeybreadsoftware.net/class-tktokenauthoperationmbs.shtml"
		  linksMBS.Value("TKTokenDriverMBS")="https://www.monkeybreadsoftware.net/class-tktokendrivermbs.shtml"
		  linksMBS.Value("TKTokenKeyAlgorithmMBS")="https://www.monkeybreadsoftware.net/class-tktokenkeyalgorithmmbs.shtml"
		  linksMBS.Value("TKTokenKeychainCertificateMBS")="https://www.monkeybreadsoftware.net/class-tktokenkeychaincertificatembs.shtml"
		  linksMBS.Value("TKTokenKeychainContentsMBS")="https://www.monkeybreadsoftware.net/class-tktokenkeychaincontentsmbs.shtml"
		  linksMBS.Value("TKTokenKeychainItemMBS")="https://www.monkeybreadsoftware.net/class-tktokenkeychainitemmbs.shtml"
		  linksMBS.Value("TKTokenKeychainKeyMBS")="https://www.monkeybreadsoftware.net/class-tktokenkeychainkeymbs.shtml"
		  linksMBS.Value("TKTokenKeyExchangeParametersMBS")="https://www.monkeybreadsoftware.net/class-tktokenkeyexchangeparametersmbs.shtml"
		  linksMBS.Value("TKTokenMBS")="https://www.monkeybreadsoftware.net/class-tktokenmbs.shtml"
		  linksMBS.Value("TKTokenPasswordAuthOperationMBS")="https://www.monkeybreadsoftware.net/class-tktokenpasswordauthoperationmbs.shtml"
		  linksMBS.Value("TKTokenSessionMBS")="https://www.monkeybreadsoftware.net/class-tktokensessionmbs.shtml"
		  linksMBS.Value("TKTokenSmartCardPINAuthOperationMBS")="https://www.monkeybreadsoftware.net/class-tktokensmartcardpinauthoperationmbs.shtml"
		  linksMBS.Value("TKTokenWatcherMBS")="https://www.monkeybreadsoftware.net/class-tktokenwatchermbs.shtml"
		  linksMBS.Value("TwainIdentityMBS")="https://www.monkeybreadsoftware.net/class-twainidentitymbs.shtml"
		  linksMBS.Value("TwainImageInfoMBS")="https://www.monkeybreadsoftware.net/class-twainimageinfombs.shtml"
		  linksMBS.Value("TwainImageLayoutMBS")="https://www.monkeybreadsoftware.net/class-twainimagelayoutmbs.shtml"
		  linksMBS.Value("TwainMBS")="https://www.monkeybreadsoftware.net/class-twainmbs.shtml"
		  linksMBS.Value("TwainVersionMBS")="https://www.monkeybreadsoftware.net/class-twainversionmbs.shtml"
		  linksMBS.Value("TXTRecordMBS")="https://www.monkeybreadsoftware.net/class-txtrecordmbs.shtml"
		  linksMBS.Value("UDPSocketMBS")="https://www.monkeybreadsoftware.net/class-udpsocketmbs.shtml"
		  linksMBS.Value("UIDocumentPickerMBS")="https://www.monkeybreadsoftware.net/class-uidocumentpickermbs.shtml"
		  linksMBS.Value("UNCalendarNotificationTriggerMBS")="https://www.monkeybreadsoftware.net/class-uncalendarnotificationtriggermbs.shtml"
		  linksMBS.Value("UnikeyMBS")="https://www.monkeybreadsoftware.net/class-unikeymbs.shtml"
		  linksMBS.Value("UniversalCharacterDetectionMBS")="https://www.monkeybreadsoftware.net/class-universalcharacterdetectionmbs.shtml"
		  linksMBS.Value("UNMutableNotificationContentMBS")="https://www.monkeybreadsoftware.net/class-unmutablenotificationcontentmbs.shtml"
		  linksMBS.Value("UNNotificationActionMBS")="https://www.monkeybreadsoftware.net/class-unnotificationactionmbs.shtml"
		  linksMBS.Value("UNNotificationAttachmentMBS")="https://www.monkeybreadsoftware.net/class-unnotificationattachmentmbs.shtml"
		  linksMBS.Value("UNNotificationCategoryMBS")="https://www.monkeybreadsoftware.net/class-unnotificationcategorymbs.shtml"
		  linksMBS.Value("UNNotificationContentMBS")="https://www.monkeybreadsoftware.net/class-unnotificationcontentmbs.shtml"
		  linksMBS.Value("UNNotificationMBS")="https://www.monkeybreadsoftware.net/class-unnotificationmbs.shtml"
		  linksMBS.Value("UNNotificationRequestMBS")="https://www.monkeybreadsoftware.net/class-unnotificationrequestmbs.shtml"
		  linksMBS.Value("UNNotificationResponseMBS")="https://www.monkeybreadsoftware.net/class-unnotificationresponsembs.shtml"
		  linksMBS.Value("UNNotificationSettingsMBS")="https://www.monkeybreadsoftware.net/class-unnotificationsettingsmbs.shtml"
		  linksMBS.Value("UNNotificationSoundMBS")="https://www.monkeybreadsoftware.net/class-unnotificationsoundmbs.shtml"
		  linksMBS.Value("UNNotificationTriggerMBS")="https://www.monkeybreadsoftware.net/class-unnotificationtriggermbs.shtml"
		  linksMBS.Value("UNPushNotificationTriggerMBS")="https://www.monkeybreadsoftware.net/class-unpushnotificationtriggermbs.shtml"
		  linksMBS.Value("UNTextInputNotificationActionMBS")="https://www.monkeybreadsoftware.net/class-untextinputnotificationactionmbs.shtml"
		  linksMBS.Value("UNTextInputNotificationResponseMBS")="https://www.monkeybreadsoftware.net/class-untextinputnotificationresponsembs.shtml"
		  linksMBS.Value("UNTimeIntervalNotificationTriggerMBS")="https://www.monkeybreadsoftware.net/class-untimeintervalnotificationtriggermbs.shtml"
		  linksMBS.Value("UNUserNotificationCenterMBS")="https://www.monkeybreadsoftware.net/class-unusernotificationcentermbs.shtml"
		  linksMBS.Value("UnZipFileInfoMBS")="https://www.monkeybreadsoftware.net/class-unzipfileinfombs.shtml"
		  linksMBS.Value("UnZipFilePositionMBS")="https://www.monkeybreadsoftware.net/class-unzipfilepositionmbs.shtml"
		  linksMBS.Value("UnZipMBS")="https://www.monkeybreadsoftware.net/class-unzipmbs.shtml"
		  linksMBS.Value("UpDownArrows")="https://www.monkeybreadsoftware.net/class-updownarrows.shtml"
		  linksMBS.Value("UUIDMBS")="https://www.monkeybreadsoftware.net/class-uuidmbs.shtml"
		  linksMBS.Value("VariantHashSetIteratorMBS")="https://www.monkeybreadsoftware.net/class-varianthashsetiteratormbs.shtml"
		  linksMBS.Value("VariantHashSetMBS")="https://www.monkeybreadsoftware.net/class-varianthashsetmbs.shtml"
		  linksMBS.Value("VariantOrderedSetIteratorMBS")="https://www.monkeybreadsoftware.net/class-variantorderedsetiteratormbs.shtml"
		  linksMBS.Value("VariantOrderedSetMBS")="https://www.monkeybreadsoftware.net/class-variantorderedsetmbs.shtml"
		  linksMBS.Value("VariantToVariantHashMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-varianttovarianthashmapiteratormbs.shtml"
		  linksMBS.Value("VariantToVariantHashMapMBS")="https://www.monkeybreadsoftware.net/class-varianttovarianthashmapmbs.shtml"
		  linksMBS.Value("VariantToVariantMapIteratorMBS")="https://www.monkeybreadsoftware.net/class-varianttovariantmapiteratormbs.shtml"
		  linksMBS.Value("VariantToVariantOrderedMapMBS")="https://www.monkeybreadsoftware.net/class-varianttovariantorderedmapmbs.shtml"
		  linksMBS.Value("VLCAudioOutputDeviceMBS")="https://www.monkeybreadsoftware.net/class-vlcaudiooutputdevicembs.shtml"
		  linksMBS.Value("VLCAudioOutputMBS")="https://www.monkeybreadsoftware.net/class-vlcaudiooutputmbs.shtml"
		  linksMBS.Value("VLCEqualizerMBS")="https://www.monkeybreadsoftware.net/class-vlcequalizermbs.shtml"
		  linksMBS.Value("VLCEventManagerMBS")="https://www.monkeybreadsoftware.net/class-vlceventmanagermbs.shtml"
		  linksMBS.Value("VLCExitHandlerMBS")="https://www.monkeybreadsoftware.net/class-vlcexithandlermbs.shtml"
		  linksMBS.Value("VLCInstanceMBS")="https://www.monkeybreadsoftware.net/class-vlcinstancembs.shtml"
		  linksMBS.Value("VLCMediaDiscovererMBS")="https://www.monkeybreadsoftware.net/class-vlcmediadiscoverermbs.shtml"
		  linksMBS.Value("VLCMediaLibraryMBS")="https://www.monkeybreadsoftware.net/class-vlcmedialibrarymbs.shtml"
		  linksMBS.Value("VLCMediaListMBS")="https://www.monkeybreadsoftware.net/class-vlcmedialistmbs.shtml"
		  linksMBS.Value("VLCMediaListPlayerMBS")="https://www.monkeybreadsoftware.net/class-vlcmedialistplayermbs.shtml"
		  linksMBS.Value("VLCMediaMBS")="https://www.monkeybreadsoftware.net/class-vlcmediambs.shtml"
		  linksMBS.Value("VLCMediaPlayerMBS")="https://www.monkeybreadsoftware.net/class-vlcmediaplayermbs.shtml"
		  linksMBS.Value("VLCMediaStatsMBS")="https://www.monkeybreadsoftware.net/class-vlcmediastatsmbs.shtml"
		  linksMBS.Value("VLCMediaTrackInfoMBS")="https://www.monkeybreadsoftware.net/class-vlcmediatrackinfombs.shtml"
		  linksMBS.Value("VLCMediaTrackMBS")="https://www.monkeybreadsoftware.net/class-vlcmediatrackmbs.shtml"
		  linksMBS.Value("VLCMissingFunctionExceptionMBS")="https://www.monkeybreadsoftware.net/class-vlcmissingfunctionexceptionmbs.shtml"
		  linksMBS.Value("VLCModuleDescriptionMBS")="https://www.monkeybreadsoftware.net/class-vlcmoduledescriptionmbs.shtml"
		  linksMBS.Value("VLCNotInitializedExceptionMBS")="https://www.monkeybreadsoftware.net/class-vlcnotinitializedexceptionmbs.shtml"
		  linksMBS.Value("VLCTrackDescriptionMBS")="https://www.monkeybreadsoftware.net/class-vlctrackdescriptionmbs.shtml"
		  linksMBS.Value("VNBarcodeObservationMBS")="https://www.monkeybreadsoftware.net/class-vnbarcodeobservationmbs.shtml"
		  linksMBS.Value("VNClassificationObservationMBS")="https://www.monkeybreadsoftware.net/class-vnclassificationobservationmbs.shtml"
		  linksMBS.Value("VNClassifyImageRequestMBS")="https://www.monkeybreadsoftware.net/class-vnclassifyimagerequestmbs.shtml"
		  linksMBS.Value("VNCoreMLFeatureValueObservationMBS")="https://www.monkeybreadsoftware.net/class-vncoremlfeaturevalueobservationmbs.shtml"
		  linksMBS.Value("VNCoreMLModelMBS")="https://www.monkeybreadsoftware.net/class-vncoremlmodelmbs.shtml"
		  linksMBS.Value("VNCoreMLRequestMBS")="https://www.monkeybreadsoftware.net/class-vncoremlrequestmbs.shtml"
		  linksMBS.Value("VNDetectBarcodesRequestMBS")="https://www.monkeybreadsoftware.net/class-vndetectbarcodesrequestmbs.shtml"
		  linksMBS.Value("VNDetectedObjectObservationMBS")="https://www.monkeybreadsoftware.net/class-vndetectedobjectobservationmbs.shtml"
		  linksMBS.Value("VNDetectFaceCaptureQualityRequestMBS")="https://www.monkeybreadsoftware.net/class-vndetectfacecapturequalityrequestmbs.shtml"
		  linksMBS.Value("VNDetectFaceLandmarksRequestMBS")="https://www.monkeybreadsoftware.net/class-vndetectfacelandmarksrequestmbs.shtml"
		  linksMBS.Value("VNDetectFaceRectanglesRequestMBS")="https://www.monkeybreadsoftware.net/class-vndetectfacerectanglesrequestmbs.shtml"
		  linksMBS.Value("VNDetectHorizonRequestMBS")="https://www.monkeybreadsoftware.net/class-vndetecthorizonrequestmbs.shtml"
		  linksMBS.Value("VNDetectHumanRectanglesRequestMBS")="https://www.monkeybreadsoftware.net/class-vndetecthumanrectanglesrequestmbs.shtml"
		  linksMBS.Value("VNDetectRectanglesRequestMBS")="https://www.monkeybreadsoftware.net/class-vndetectrectanglesrequestmbs.shtml"
		  linksMBS.Value("VNDetectTextRectanglesRequestMBS")="https://www.monkeybreadsoftware.net/class-vndetecttextrectanglesrequestmbs.shtml"
		  linksMBS.Value("VNFaceLandmarkRegion2DMBS")="https://www.monkeybreadsoftware.net/class-vnfacelandmarkregion2dmbs.shtml"
		  linksMBS.Value("VNFaceLandmarkRegionMBS")="https://www.monkeybreadsoftware.net/class-vnfacelandmarkregionmbs.shtml"
		  linksMBS.Value("VNFaceLandmarks2DMBS")="https://www.monkeybreadsoftware.net/class-vnfacelandmarks2dmbs.shtml"
		  linksMBS.Value("VNFaceLandmarksMBS")="https://www.monkeybreadsoftware.net/class-vnfacelandmarksmbs.shtml"
		  linksMBS.Value("VNFaceObservationMBS")="https://www.monkeybreadsoftware.net/class-vnfaceobservationmbs.shtml"
		  linksMBS.Value("VNFeaturePrintObservationMBS")="https://www.monkeybreadsoftware.net/class-vnfeatureprintobservationmbs.shtml"
		  linksMBS.Value("VNGenerateAttentionBasedSaliencyImageRequestMBS")="https://www.monkeybreadsoftware.net/class-vngenerateattentionbasedsaliencyimagerequestmbs.shtml"
		  linksMBS.Value("VNGenerateImageFeaturePrintRequestMBS")="https://www.monkeybreadsoftware.net/class-vngenerateimagefeatureprintrequestmbs.shtml"
		  linksMBS.Value("VNGenerateObjectnessBasedSaliencyImageRequestMBS")="https://www.monkeybreadsoftware.net/class-vngenerateobjectnessbasedsaliencyimagerequestmbs.shtml"
		  linksMBS.Value("VNHomographicImageRegistrationRequestMBS")="https://www.monkeybreadsoftware.net/class-vnhomographicimageregistrationrequestmbs.shtml"
		  linksMBS.Value("VNHorizonObservationMBS")="https://www.monkeybreadsoftware.net/class-vnhorizonobservationmbs.shtml"
		  linksMBS.Value("VNImageAlignmentObservationMBS")="https://www.monkeybreadsoftware.net/class-vnimagealignmentobservationmbs.shtml"
		  linksMBS.Value("VNImageBasedRequestMBS")="https://www.monkeybreadsoftware.net/class-vnimagebasedrequestmbs.shtml"
		  linksMBS.Value("VNImageHomographicAlignmentObservationMBS")="https://www.monkeybreadsoftware.net/class-vnimagehomographicalignmentobservationmbs.shtml"
		  linksMBS.Value("VNImageRegistrationRequestMBS")="https://www.monkeybreadsoftware.net/class-vnimageregistrationrequestmbs.shtml"
		  linksMBS.Value("VNImageRequestHandlerMBS")="https://www.monkeybreadsoftware.net/class-vnimagerequesthandlermbs.shtml"
		  linksMBS.Value("VNImageTranslationAlignmentObservationMBS")="https://www.monkeybreadsoftware.net/class-vnimagetranslationalignmentobservationmbs.shtml"
		  linksMBS.Value("VNObservationMBS")="https://www.monkeybreadsoftware.net/class-vnobservationmbs.shtml"
		  linksMBS.Value("VNPixelBufferObservationMBS")="https://www.monkeybreadsoftware.net/class-vnpixelbufferobservationmbs.shtml"
		  linksMBS.Value("VNRecognizeAnimalsRequestMBS")="https://www.monkeybreadsoftware.net/class-vnrecognizeanimalsrequestmbs.shtml"
		  linksMBS.Value("VNRecognizedObjectObservationMBS")="https://www.monkeybreadsoftware.net/class-vnrecognizedobjectobservationmbs.shtml"
		  linksMBS.Value("VNRecognizedTextMBS")="https://www.monkeybreadsoftware.net/class-vnrecognizedtextmbs.shtml"
		  linksMBS.Value("VNRecognizedTextObservationMBS")="https://www.monkeybreadsoftware.net/class-vnrecognizedtextobservationmbs.shtml"
		  linksMBS.Value("VNRecognizeTextRequestMBS")="https://www.monkeybreadsoftware.net/class-vnrecognizetextrequestmbs.shtml"
		  linksMBS.Value("VNRectangleObservationMBS")="https://www.monkeybreadsoftware.net/class-vnrectangleobservationmbs.shtml"
		  linksMBS.Value("VNRequestMBS")="https://www.monkeybreadsoftware.net/class-vnrequestmbs.shtml"
		  linksMBS.Value("VNSaliencyImageObservationMBS")="https://www.monkeybreadsoftware.net/class-vnsaliencyimageobservationmbs.shtml"
		  linksMBS.Value("VNSequenceRequestHandlerMBS")="https://www.monkeybreadsoftware.net/class-vnsequencerequesthandlermbs.shtml"
		  linksMBS.Value("VNTargetedImageRequestMBS")="https://www.monkeybreadsoftware.net/class-vntargetedimagerequestmbs.shtml"
		  linksMBS.Value("VNTextObservationMBS")="https://www.monkeybreadsoftware.net/class-vntextobservationmbs.shtml"
		  linksMBS.Value("VNTrackingRequestMBS")="https://www.monkeybreadsoftware.net/class-vntrackingrequestmbs.shtml"
		  linksMBS.Value("VNTrackObjectRequestMBS")="https://www.monkeybreadsoftware.net/class-vntrackobjectrequestmbs.shtml"
		  linksMBS.Value("VNTrackRectangleRequestMBS")="https://www.monkeybreadsoftware.net/class-vntrackrectanglerequestmbs.shtml"
		  linksMBS.Value("VNTranslationalImageRegistrationRequestMBS")="https://www.monkeybreadsoftware.net/class-vntranslationalimageregistrationrequestmbs.shtml"
		  linksMBS.Value("VolumeInformationMBS")="https://www.monkeybreadsoftware.net/class-volumeinformationmbs.shtml"
		  linksMBS.Value("WakeNotifierMBS")="https://www.monkeybreadsoftware.net/class-wakenotifiermbs.shtml"
		  linksMBS.Value("WebScriptCallbackMBS")="https://www.monkeybreadsoftware.net/class-webscriptcallbackmbs.shtml"
		  linksMBS.Value("WebScriptObjectMBS")="https://www.monkeybreadsoftware.net/class-webscriptobjectmbs.shtml"
		  linksMBS.Value("WebView2ExceptionMBS")="https://www.monkeybreadsoftware.net/class-webview2exceptionmbs.shtml"
		  linksMBS.Value("WebView2WindowFeaturesMBS")="https://www.monkeybreadsoftware.net/class-webview2windowfeaturesmbs.shtml"
		  linksMBS.Value("WIADataCallbackMBS")="https://www.monkeybreadsoftware.net/class-wiadatacallbackmbs.shtml"
		  linksMBS.Value("WIADataTransferInfoMBS")="https://www.monkeybreadsoftware.net/class-wiadatatransferinfombs.shtml"
		  linksMBS.Value("WIADataTransferMBS")="https://www.monkeybreadsoftware.net/class-wiadatatransfermbs.shtml"
		  linksMBS.Value("WIADeviceCapabilitiesEnumeratorMBS")="https://www.monkeybreadsoftware.net/class-wiadevicecapabilitiesenumeratormbs.shtml"
		  linksMBS.Value("WIADeviceCapabilitiesMBS")="https://www.monkeybreadsoftware.net/class-wiadevicecapabilitiesmbs.shtml"
		  linksMBS.Value("WIADeviceInfoEnumeratorMBS")="https://www.monkeybreadsoftware.net/class-wiadeviceinfoenumeratormbs.shtml"
		  linksMBS.Value("WIADeviceManager1MBS")="https://www.monkeybreadsoftware.net/class-wiadevicemanager1mbs.shtml"
		  linksMBS.Value("WIADeviceManager2MBS")="https://www.monkeybreadsoftware.net/class-wiadevicemanager2mbs.shtml"
		  linksMBS.Value("WIAExtendedTransferInfoMBS")="https://www.monkeybreadsoftware.net/class-wiaextendedtransferinfombs.shtml"
		  linksMBS.Value("WIAFormatInfoEnumeratorMBS")="https://www.monkeybreadsoftware.net/class-wiaformatinfoenumeratormbs.shtml"
		  linksMBS.Value("WIAFormatInfoMBS")="https://www.monkeybreadsoftware.net/class-wiaformatinfombs.shtml"
		  linksMBS.Value("WIAGUIDMBS")="https://www.monkeybreadsoftware.net/class-wiaguidmbs.shtml"
		  linksMBS.Value("WIAItemEnumeratorMBS")="https://www.monkeybreadsoftware.net/class-wiaitemenumeratormbs.shtml"
		  linksMBS.Value("WIAItemMBS")="https://www.monkeybreadsoftware.net/class-wiaitemmbs.shtml"
		  linksMBS.Value("WIAPropertyEnumeratorMBS")="https://www.monkeybreadsoftware.net/class-wiapropertyenumeratormbs.shtml"
		  linksMBS.Value("WIAPropertyMBS")="https://www.monkeybreadsoftware.net/class-wiapropertymbs.shtml"
		  linksMBS.Value("WIAPropertyStorageMBS")="https://www.monkeybreadsoftware.net/class-wiapropertystoragembs.shtml"
		  linksMBS.Value("WIAStreamMBS")="https://www.monkeybreadsoftware.net/class-wiastreammbs.shtml"
		  linksMBS.Value("WIATransferCallbackMBS")="https://www.monkeybreadsoftware.net/class-wiatransfercallbackmbs.shtml"
		  linksMBS.Value("WIATransferMBS")="https://www.monkeybreadsoftware.net/class-wiatransfermbs.shtml"
		  linksMBS.Value("WIATransferParamsMBS")="https://www.monkeybreadsoftware.net/class-wiatransferparamsmbs.shtml"
		  linksMBS.Value("WIAVideoMBS")="https://www.monkeybreadsoftware.net/class-wiavideombs.shtml"
		  linksMBS.Value("WinDataObjectMBS")="https://www.monkeybreadsoftware.net/class-windataobjectmbs.shtml"
		  linksMBS.Value("Window")="https://www.monkeybreadsoftware.net/class-window.shtml"
		  linksMBS.Value("WindowsAddPrintJobMBS")="https://www.monkeybreadsoftware.net/class-windowsaddprintjobmbs.shtml"
		  linksMBS.Value("WindowsADSystemInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsadsysteminfombs.shtml"
		  linksMBS.Value("WindowsAudioMixerMBS")="https://www.monkeybreadsoftware.net/class-windowsaudiomixermbs.shtml"
		  linksMBS.Value("WindowsBluetoothDeviceIdMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothdeviceidmbs.shtml"
		  linksMBS.Value("WindowsBlueToothDeviceInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothdeviceinfombs.shtml"
		  linksMBS.Value("WindowsBlueToothDeviceMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothdevicembs.shtml"
		  linksMBS.Value("WindowsBlueToothDeviceSearchParameterMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothdevicesearchparametermbs.shtml"
		  linksMBS.Value("WindowsBluetoothLEAdvertisementMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothleadvertisementmbs.shtml"
		  linksMBS.Value("WindowsBluetoothLEAdvertisementReceivedEventArgsMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothleadvertisementreceivedeventargsmbs.shtml"
		  linksMBS.Value("WindowsBluetoothLEAdvertisementWatcherMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothleadvertisementwatchermbs.shtml"
		  linksMBS.Value("WindowsBluetoothLEAppearanceMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothleappearancembs.shtml"
		  linksMBS.Value("WindowsBlueToothLECharacteristicMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothlecharacteristicmbs.shtml"
		  linksMBS.Value("WindowsBlueToothLEDescriptorMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothledescriptormbs.shtml"
		  linksMBS.Value("WindowsBlueToothLEDescriptorValueMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothledescriptorvaluembs.shtml"
		  linksMBS.Value("WindowsBluetoothLEDeviceMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothledevicembs.shtml"
		  linksMBS.Value("WindowsBluetoothLEExceptionMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothleexceptionmbs.shtml"
		  linksMBS.Value("WindowsBluetoothLEManufacturerDataMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothlemanufacturerdatambs.shtml"
		  linksMBS.Value("WindowsBlueToothLEMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothlembs.shtml"
		  linksMBS.Value("WindowsBlueToothLEServiceMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothleservicembs.shtml"
		  linksMBS.Value("WindowsBlueToothRadioInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothradioinfombs.shtml"
		  linksMBS.Value("WindowsBlueToothRadioMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothradiombs.shtml"
		  linksMBS.Value("WindowsBlueToothSelectDeviceDialogMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothselectdevicedialogmbs.shtml"
		  linksMBS.Value("WindowsBlueToothServiceMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothservicembs.shtml"
		  linksMBS.Value("WindowsBlueToothSocketMBS")="https://www.monkeybreadsoftware.net/class-windowsbluetoothsocketmbs.shtml"
		  linksMBS.Value("WindowsBurnMBS")="https://www.monkeybreadsoftware.net/class-windowsburnmbs.shtml"
		  linksMBS.Value("WindowsClipboardMBS")="https://www.monkeybreadsoftware.net/class-windowsclipboardmbs.shtml"
		  linksMBS.Value("WindowsConsoleMBS")="https://www.monkeybreadsoftware.net/class-windowsconsolembs.shtml"
		  linksMBS.Value("WindowsDeviceMBS")="https://www.monkeybreadsoftware.net/class-windowsdevicembs.shtml"
		  linksMBS.Value("WindowsDeviceModeMBS")="https://www.monkeybreadsoftware.net/class-windowsdevicemodembs.shtml"
		  linksMBS.Value("WindowsDirectoryChangeMBS")="https://www.monkeybreadsoftware.net/class-windowsdirectorychangembs.shtml"
		  linksMBS.Value("WindowsDirectoryWatcherMBS")="https://www.monkeybreadsoftware.net/class-windowsdirectorywatchermbs.shtml"
		  linksMBS.Value("WindowsDiscInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsdiscinfombs.shtml"
		  linksMBS.Value("WindowsDiskChangeMBS")="https://www.monkeybreadsoftware.net/class-windowsdiskchangembs.shtml"
		  linksMBS.Value("WindowsDisplayMBS")="https://www.monkeybreadsoftware.net/class-windowsdisplaymbs.shtml"
		  linksMBS.Value("WindowsDNSRecordAAAAMBS")="https://www.monkeybreadsoftware.net/class-windowsdnsrecordaaaambs.shtml"
		  linksMBS.Value("WindowsDNSRecordAMBS")="https://www.monkeybreadsoftware.net/class-windowsdnsrecordambs.shtml"
		  linksMBS.Value("WindowsDNSRecordMBS")="https://www.monkeybreadsoftware.net/class-windowsdnsrecordmbs.shtml"
		  linksMBS.Value("WindowsDNSRecordMInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsdnsrecordminfombs.shtml"
		  linksMBS.Value("WindowsDNSRecordMXMBS")="https://www.monkeybreadsoftware.net/class-windowsdnsrecordmxmbs.shtml"
		  linksMBS.Value("WindowsDNSRecordNullMBS")="https://www.monkeybreadsoftware.net/class-windowsdnsrecordnullmbs.shtml"
		  linksMBS.Value("WindowsDNSRecordPTRMBS")="https://www.monkeybreadsoftware.net/class-windowsdnsrecordptrmbs.shtml"
		  linksMBS.Value("WindowsDNSRecordSOAMBS")="https://www.monkeybreadsoftware.net/class-windowsdnsrecordsoambs.shtml"
		  linksMBS.Value("WindowsDNSRecordTXTMBS")="https://www.monkeybreadsoftware.net/class-windowsdnsrecordtxtmbs.shtml"
		  linksMBS.Value("WindowsDragSourceMBS")="https://www.monkeybreadsoftware.net/class-windowsdragsourcembs.shtml"
		  linksMBS.Value("WindowsDriveNotificationMBS")="https://www.monkeybreadsoftware.net/class-windowsdrivenotificationmbs.shtml"
		  linksMBS.Value("WindowsDropTargetMBS")="https://www.monkeybreadsoftware.net/class-windowsdroptargetmbs.shtml"
		  linksMBS.Value("WindowsEthernetAdapterMBS")="https://www.monkeybreadsoftware.net/class-windowsethernetadaptermbs.shtml"
		  linksMBS.Value("WindowsEthernetMBS")="https://www.monkeybreadsoftware.net/class-windowsethernetmbs.shtml"
		  linksMBS.Value("WindowsFileCopyMBS")="https://www.monkeybreadsoftware.net/class-windowsfilecopymbs.shtml"
		  linksMBS.Value("WindowsFileDescriptorMBS")="https://www.monkeybreadsoftware.net/class-windowsfiledescriptormbs.shtml"
		  linksMBS.Value("WindowsFileInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsfileinfombs.shtml"
		  linksMBS.Value("WindowsFileStreamMBS")="https://www.monkeybreadsoftware.net/class-windowsfilestreammbs.shtml"
		  linksMBS.Value("WindowsFileVersionMBS")="https://www.monkeybreadsoftware.net/class-windowsfileversionmbs.shtml"
		  linksMBS.Value("WindowsFolderChangeMBS")="https://www.monkeybreadsoftware.net/class-windowsfolderchangembs.shtml"
		  linksMBS.Value("WindowsFontDialogMBS")="https://www.monkeybreadsoftware.net/class-windowsfontdialogmbs.shtml"
		  linksMBS.Value("WindowsFontFamilyMBS")="https://www.monkeybreadsoftware.net/class-windowsfontfamilymbs.shtml"
		  linksMBS.Value("WindowsGattCharacteristicMBS")="https://www.monkeybreadsoftware.net/class-windowsgattcharacteristicmbs.shtml"
		  linksMBS.Value("WindowsGattCharacteristicsResultMBS")="https://www.monkeybreadsoftware.net/class-windowsgattcharacteristicsresultmbs.shtml"
		  linksMBS.Value("WindowsGattDescriptorMBS")="https://www.monkeybreadsoftware.net/class-windowsgattdescriptormbs.shtml"
		  linksMBS.Value("WindowsGattDescriptorsResultMBS")="https://www.monkeybreadsoftware.net/class-windowsgattdescriptorsresultmbs.shtml"
		  linksMBS.Value("WindowsGattDeviceServiceMBS")="https://www.monkeybreadsoftware.net/class-windowsgattdeviceservicembs.shtml"
		  linksMBS.Value("WindowsGattDeviceServicesResultMBS")="https://www.monkeybreadsoftware.net/class-windowsgattdeviceservicesresultmbs.shtml"
		  linksMBS.Value("WindowsGattReadRequestMBS")="https://www.monkeybreadsoftware.net/class-windowsgattreadrequestmbs.shtml"
		  linksMBS.Value("WindowsGattReadResultMBS")="https://www.monkeybreadsoftware.net/class-windowsgattreadresultmbs.shtml"
		  linksMBS.Value("WindowsGattWriteRequestMBS")="https://www.monkeybreadsoftware.net/class-windowsgattwriterequestmbs.shtml"
		  linksMBS.Value("WindowsGattWriteResultMBS")="https://www.monkeybreadsoftware.net/class-windowsgattwriteresultmbs.shtml"
		  linksMBS.Value("WindowsGraphicsDeviceContextMBS")="https://www.monkeybreadsoftware.net/class-windowsgraphicsdevicecontextmbs.shtml"
		  linksMBS.Value("WindowsGraphicsInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsgraphicsinfombs.shtml"
		  linksMBS.Value("WindowsGUIResourcesMBS")="https://www.monkeybreadsoftware.net/class-windowsguiresourcesmbs.shtml"
		  linksMBS.Value("WindowsICMColorMBS")="https://www.monkeybreadsoftware.net/class-windowsicmcolormbs.shtml"
		  linksMBS.Value("WindowsICMEnumMBS")="https://www.monkeybreadsoftware.net/class-windowsicmenummbs.shtml"
		  linksMBS.Value("WindowsICMLogColorSpaceMBS")="https://www.monkeybreadsoftware.net/class-windowsicmlogcolorspacembs.shtml"
		  linksMBS.Value("WindowsICMNamedProfileInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsicmnamedprofileinfombs.shtml"
		  linksMBS.Value("WindowsICMProfileHeaderMBS")="https://www.monkeybreadsoftware.net/class-windowsicmprofileheadermbs.shtml"
		  linksMBS.Value("WindowsICMProfileMBS")="https://www.monkeybreadsoftware.net/class-windowsicmprofilembs.shtml"
		  linksMBS.Value("WindowsICMSetupMBS")="https://www.monkeybreadsoftware.net/class-windowsicmsetupmbs.shtml"
		  linksMBS.Value("WindowsICMTransformMBS")="https://www.monkeybreadsoftware.net/class-windowsicmtransformmbs.shtml"
		  linksMBS.Value("WindowsIniMBS")="https://www.monkeybreadsoftware.net/class-windowsinimbs.shtml"
		  linksMBS.Value("WindowsInternetShortcutMBS")="https://www.monkeybreadsoftware.net/class-windowsinternetshortcutmbs.shtml"
		  linksMBS.Value("WindowsIPAddressMBS")="https://www.monkeybreadsoftware.net/class-windowsipaddressmbs.shtml"
		  linksMBS.Value("WindowsKeyboardLayoutMBS")="https://www.monkeybreadsoftware.net/class-windowskeyboardlayoutmbs.shtml"
		  linksMBS.Value("WindowsKeyFilterMBS")="https://www.monkeybreadsoftware.net/class-windowskeyfiltermbs.shtml"
		  linksMBS.Value("WindowsListMBS")="https://www.monkeybreadsoftware.net/class-windowslistmbs.shtml"
		  linksMBS.Value("WindowsLocationExceptionMBS")="https://www.monkeybreadsoftware.net/class-windowslocationexceptionmbs.shtml"
		  linksMBS.Value("WindowsLocationManagerMBS")="https://www.monkeybreadsoftware.net/class-windowslocationmanagermbs.shtml"
		  linksMBS.Value("WindowsLocationMBS")="https://www.monkeybreadsoftware.net/class-windowslocationmbs.shtml"
		  linksMBS.Value("WindowsMCIMBS")="https://www.monkeybreadsoftware.net/class-windowsmcimbs.shtml"
		  linksMBS.Value("WindowsMidiInputInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsmidiinputinfombs.shtml"
		  linksMBS.Value("WindowsMidiInputMBS")="https://www.monkeybreadsoftware.net/class-windowsmidiinputmbs.shtml"
		  linksMBS.Value("WindowsMidiMBS")="https://www.monkeybreadsoftware.net/class-windowsmidimbs.shtml"
		  linksMBS.Value("WindowsMidiOutputInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsmidioutputinfombs.shtml"
		  linksMBS.Value("WindowsMidiOutputMBS")="https://www.monkeybreadsoftware.net/class-windowsmidioutputmbs.shtml"
		  linksMBS.Value("WindowsMidiStreamMBS")="https://www.monkeybreadsoftware.net/class-windowsmidistreammbs.shtml"
		  linksMBS.Value("WindowsMLExceptionMBS")="https://www.monkeybreadsoftware.net/class-windowsmlexceptionmbs.shtml"
		  linksMBS.Value("WindowsMonitorMBS")="https://www.monkeybreadsoftware.net/class-windowsmonitormbs.shtml"
		  linksMBS.Value("WindowsMutexMBS")="https://www.monkeybreadsoftware.net/class-windowsmutexmbs.shtml"
		  linksMBS.Value("WindowsPageFormatMBS")="https://www.monkeybreadsoftware.net/class-windowspageformatmbs.shtml"
		  linksMBS.Value("WindowsPageSetupDialogMBS")="https://www.monkeybreadsoftware.net/class-windowspagesetupdialogmbs.shtml"
		  linksMBS.Value("WindowsPipeMBS")="https://www.monkeybreadsoftware.net/class-windowspipembs.shtml"
		  linksMBS.Value("WindowsPlayerDeviceMBS")="https://www.monkeybreadsoftware.net/class-windowsplayerdevicembs.shtml"
		  linksMBS.Value("WindowsPlayerMBS")="https://www.monkeybreadsoftware.net/class-windowsplayermbs.shtml"
		  linksMBS.Value("WindowsPowerStateMBS")="https://www.monkeybreadsoftware.net/class-windowspowerstatembs.shtml"
		  linksMBS.Value("WindowsPreviewHandlerMBS")="https://www.monkeybreadsoftware.net/class-windowspreviewhandlermbs.shtml"
		  linksMBS.Value("WindowsPrintDialogMBS")="https://www.monkeybreadsoftware.net/class-windowsprintdialogmbs.shtml"
		  linksMBS.Value("WindowsPrinterInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsprinterinfombs.shtml"
		  linksMBS.Value("WindowsPrinterJobMBS")="https://www.monkeybreadsoftware.net/class-windowsprinterjobmbs.shtml"
		  linksMBS.Value("WindowsPrinterMBS")="https://www.monkeybreadsoftware.net/class-windowsprintermbs.shtml"
		  linksMBS.Value("WindowsProcessMBS")="https://www.monkeybreadsoftware.net/class-windowsprocessmbs.shtml"
		  linksMBS.Value("WindowsProcessMemoryInfoMBS")="https://www.monkeybreadsoftware.net/class-windowsprocessmemoryinfombs.shtml"
		  linksMBS.Value("WindowsProcessStatisticsMBS")="https://www.monkeybreadsoftware.net/class-windowsprocessstatisticsmbs.shtml"
		  linksMBS.Value("WindowsPropertiesMBS")="https://www.monkeybreadsoftware.net/class-windowspropertiesmbs.shtml"
		  linksMBS.Value("WindowsProxyMBS")="https://www.monkeybreadsoftware.net/class-windowsproxymbs.shtml"
		  linksMBS.Value("WindowsQOSMBS")="https://www.monkeybreadsoftware.net/class-windowsqosmbs.shtml"
		  linksMBS.Value("WindowsReportErrorMBS")="https://www.monkeybreadsoftware.net/class-windowsreporterrormbs.shtml"
		  linksMBS.Value("WindowsScriptErrorExceptionMBS")="https://www.monkeybreadsoftware.net/class-windowsscripterrorexceptionmbs.shtml"
		  linksMBS.Value("WindowsScriptErrorMBS")="https://www.monkeybreadsoftware.net/class-windowsscripterrormbs.shtml"
		  linksMBS.Value("WindowsScriptMBS")="https://www.monkeybreadsoftware.net/class-windowsscriptmbs.shtml"
		  linksMBS.Value("WindowsSerialPortsMBS")="https://www.monkeybreadsoftware.net/class-windowsserialportsmbs.shtml"
		  linksMBS.Value("WindowsShortCutMBS")="https://www.monkeybreadsoftware.net/class-windowsshortcutmbs.shtml"
		  linksMBS.Value("WindowsStoreAppLicenseMBS")="https://www.monkeybreadsoftware.net/class-windowsstoreapplicensembs.shtml"
		  linksMBS.Value("WindowsStoreContextMBS")="https://www.monkeybreadsoftware.net/class-windowsstorecontextmbs.shtml"
		  linksMBS.Value("WindowsStoreExceptionMBS")="https://www.monkeybreadsoftware.net/class-windowsstoreexceptionmbs.shtml"
		  linksMBS.Value("WindowsStorePriceMBS")="https://www.monkeybreadsoftware.net/class-windowsstorepricembs.shtml"
		  linksMBS.Value("WindowsStoreProductMBS")="https://www.monkeybreadsoftware.net/class-windowsstoreproductmbs.shtml"
		  linksMBS.Value("WindowsStoreProductQueryResultMBS")="https://www.monkeybreadsoftware.net/class-windowsstoreproductqueryresultmbs.shtml"
		  linksMBS.Value("WindowsStoreProductResultMBS")="https://www.monkeybreadsoftware.net/class-windowsstoreproductresultmbs.shtml"
		  linksMBS.Value("WindowsStorePurchasePropertiesMBS")="https://www.monkeybreadsoftware.net/class-windowsstorepurchasepropertiesmbs.shtml"
		  linksMBS.Value("WindowsStorePurchaseResultMBS")="https://www.monkeybreadsoftware.net/class-windowsstorepurchaseresultmbs.shtml"
		  linksMBS.Value("WindowsStoreRateAndReviewResultMBS")="https://www.monkeybreadsoftware.net/class-windowsstorerateandreviewresultmbs.shtml"
		  linksMBS.Value("WindowsStoreSKUMBS")="https://www.monkeybreadsoftware.net/class-windowsstoreskumbs.shtml"
		  linksMBS.Value("WindowsSystemTrayMBS")="https://www.monkeybreadsoftware.net/class-windowssystemtraymbs.shtml"
		  linksMBS.Value("WindowsTaskbarListMBS")="https://www.monkeybreadsoftware.net/class-windowstaskbarlistmbs.shtml"
		  linksMBS.Value("WindowsTaskbarStateMBS")="https://www.monkeybreadsoftware.net/class-windowstaskbarstatembs.shtml"
		  linksMBS.Value("WindowsVerticalBlankMBS")="https://www.monkeybreadsoftware.net/class-windowsverticalblankmbs.shtml"
		  linksMBS.Value("WindowsVMStatisticsMBS")="https://www.monkeybreadsoftware.net/class-windowsvmstatisticsmbs.shtml"
		  linksMBS.Value("WindowsVolumeInformationMBS")="https://www.monkeybreadsoftware.net/class-windowsvolumeinformationmbs.shtml"
		  linksMBS.Value("WindowsWMIMBS")="https://www.monkeybreadsoftware.net/class-windowswmimbs.shtml"
		  linksMBS.Value("WinExceptionMBS")="https://www.monkeybreadsoftware.net/class-winexceptionmbs.shtml"
		  linksMBS.Value("WinFileDialogExceptionMBS")="https://www.monkeybreadsoftware.net/class-winfiledialogexceptionmbs.shtml"
		  linksMBS.Value("WinFileDialogMBS")="https://www.monkeybreadsoftware.net/class-winfiledialogmbs.shtml"
		  linksMBS.Value("WinFileDialogObserverMBS")="https://www.monkeybreadsoftware.net/class-winfiledialogobservermbs.shtml"
		  linksMBS.Value("WinFileOpenDialogMBS")="https://www.monkeybreadsoftware.net/class-winfileopendialogmbs.shtml"
		  linksMBS.Value("WinFileSaveDialogMBS")="https://www.monkeybreadsoftware.net/class-winfilesavedialogmbs.shtml"
		  linksMBS.Value("WinFileTypeMBS")="https://www.monkeybreadsoftware.net/class-winfiletypembs.shtml"
		  linksMBS.Value("WinGestureConfigMBS")="https://www.monkeybreadsoftware.net/class-wingestureconfigmbs.shtml"
		  linksMBS.Value("WinGestureInfoMBS")="https://www.monkeybreadsoftware.net/class-wingestureinfombs.shtml"
		  linksMBS.Value("WinHIDMBS")="https://www.monkeybreadsoftware.net/class-winhidmbs.shtml"
		  linksMBS.Value("WinHTTPClientAutoProxyOptionsMBS")="https://www.monkeybreadsoftware.net/class-winhttpclientautoproxyoptionsmbs.shtml"
		  linksMBS.Value("WinHTTPClientCurrentUserIEProxyConfigMBS")="https://www.monkeybreadsoftware.net/class-winhttpclientcurrentuserieproxyconfigmbs.shtml"
		  linksMBS.Value("WinHTTPClientMBS")="https://www.monkeybreadsoftware.net/class-winhttpclientmbs.shtml"
		  linksMBS.Value("WinHTTPClientProxyInfoMBS")="https://www.monkeybreadsoftware.net/class-winhttpclientproxyinfombs.shtml"
		  linksMBS.Value("WinHTTPClientURLComponentsMBS")="https://www.monkeybreadsoftware.net/class-winhttpclienturlcomponentsmbs.shtml"
		  linksMBS.Value("WinLearningModelBindingMBS")="https://www.monkeybreadsoftware.net/class-winlearningmodelbindingmbs.shtml"
		  linksMBS.Value("WinLearningModelEvaluationResultMBS")="https://www.monkeybreadsoftware.net/class-winlearningmodelevaluationresultmbs.shtml"
		  linksMBS.Value("WinLearningModelFeatureDescriptorMBS")="https://www.monkeybreadsoftware.net/class-winlearningmodelfeaturedescriptormbs.shtml"
		  linksMBS.Value("WinLearningModelImageFeatureDescriptorMBS")="https://www.monkeybreadsoftware.net/class-winlearningmodelimagefeaturedescriptormbs.shtml"
		  linksMBS.Value("WinLearningModelMapFeatureDescriptorMBS")="https://www.monkeybreadsoftware.net/class-winlearningmodelmapfeaturedescriptormbs.shtml"
		  linksMBS.Value("WinLearningModelMBS")="https://www.monkeybreadsoftware.net/class-winlearningmodelmbs.shtml"
		  linksMBS.Value("WinLearningModelSequenceFeatureDescriptorMBS")="https://www.monkeybreadsoftware.net/class-winlearningmodelsequencefeaturedescriptormbs.shtml"
		  linksMBS.Value("WinLearningModelSessionMBS")="https://www.monkeybreadsoftware.net/class-winlearningmodelsessionmbs.shtml"
		  linksMBS.Value("WinLearningModelTensorFeatureDescriptorMBS")="https://www.monkeybreadsoftware.net/class-winlearningmodeltensorfeaturedescriptormbs.shtml"
		  linksMBS.Value("WinLocalizationMBS")="https://www.monkeybreadsoftware.net/class-winlocalizationmbs.shtml"
		  linksMBS.Value("WinMouseFilterMBS")="https://www.monkeybreadsoftware.net/class-winmousefiltermbs.shtml"
		  linksMBS.Value("WinNotificationMBS")="https://www.monkeybreadsoftware.net/class-winnotificationmbs.shtml"
		  linksMBS.Value("WinPhotoAcquireDeviceSelectionDialogMBS")="https://www.monkeybreadsoftware.net/class-winphotoacquiredeviceselectiondialogmbs.shtml"
		  linksMBS.Value("WinPhotoAcquireItemMBS")="https://www.monkeybreadsoftware.net/class-winphotoacquireitemmbs.shtml"
		  linksMBS.Value("WinPhotoAcquireMBS")="https://www.monkeybreadsoftware.net/class-winphotoacquirembs.shtml"
		  linksMBS.Value("WinPhotoAcquireOptionsDialogMBS")="https://www.monkeybreadsoftware.net/class-winphotoacquireoptionsdialogmbs.shtml"
		  linksMBS.Value("WinPhotoAcquireProgressCallBackMBS")="https://www.monkeybreadsoftware.net/class-winphotoacquireprogresscallbackmbs.shtml"
		  linksMBS.Value("WinPhotoAcquireSettingsMBS")="https://www.monkeybreadsoftware.net/class-winphotoacquiresettingsmbs.shtml"
		  linksMBS.Value("WinPhotoAcquireSourceMBS")="https://www.monkeybreadsoftware.net/class-winphotoacquiresourcembs.shtml"
		  linksMBS.Value("WinPhotoExceptionMBS")="https://www.monkeybreadsoftware.net/class-winphotoexceptionmbs.shtml"
		  linksMBS.Value("WinPhotoProgressActionCallbackMBS")="https://www.monkeybreadsoftware.net/class-winphotoprogressactioncallbackmbs.shtml"
		  linksMBS.Value("WinPhotoProgressDialogMBS")="https://www.monkeybreadsoftware.net/class-winphotoprogressdialogmbs.shtml"
		  linksMBS.Value("WinPointerEventsMBS")="https://www.monkeybreadsoftware.net/class-winpointereventsmbs.shtml"
		  linksMBS.Value("WinPointerInfoMBS")="https://www.monkeybreadsoftware.net/class-winpointerinfombs.shtml"
		  linksMBS.Value("WinShellItemArrayMBS")="https://www.monkeybreadsoftware.net/class-winshellitemarraymbs.shtml"
		  linksMBS.Value("WinShellItemMBS")="https://www.monkeybreadsoftware.net/class-winshellitemmbs.shtml"
		  linksMBS.Value("WinSparkleMBS")="https://www.monkeybreadsoftware.net/class-winsparklembs.shtml"
		  linksMBS.Value("WinSpeechMBS")="https://www.monkeybreadsoftware.net/class-winspeechmbs.shtml"
		  linksMBS.Value("WinSpellCheckerExceptionMBS")="https://www.monkeybreadsoftware.net/class-winspellcheckerexceptionmbs.shtml"
		  linksMBS.Value("WinSpellCheckerMBS")="https://www.monkeybreadsoftware.net/class-winspellcheckermbs.shtml"
		  linksMBS.Value("WinSpellCheckerOptionDescriptionMBS")="https://www.monkeybreadsoftware.net/class-winspellcheckeroptiondescriptionmbs.shtml"
		  linksMBS.Value("WinSpellingErrorMBS")="https://www.monkeybreadsoftware.net/class-winspellingerrormbs.shtml"
		  linksMBS.Value("WinThreadPoolMBS")="https://www.monkeybreadsoftware.net/class-winthreadpoolmbs.shtml"
		  linksMBS.Value("WinUSBDeviceMBS")="https://www.monkeybreadsoftware.net/class-winusbdevicembs.shtml"
		  linksMBS.Value("WinUSBInterfaceDescriptionMBS")="https://www.monkeybreadsoftware.net/class-winusbinterfacedescriptionmbs.shtml"
		  linksMBS.Value("WinUSBMBS")="https://www.monkeybreadsoftware.net/class-winusbmbs.shtml"
		  linksMBS.Value("WinUSBNotificationMBS")="https://www.monkeybreadsoftware.net/class-winusbnotificationmbs.shtml"
		  linksMBS.Value("WinUSBPipeInformationMBS")="https://www.monkeybreadsoftware.net/class-winusbpipeinformationmbs.shtml"
		  linksMBS.Value("WinUSBSetupPacketMBS")="https://www.monkeybreadsoftware.net/class-winusbsetuppacketmbs.shtml"
		  linksMBS.Value("WinUserInputStringMBS")="https://www.monkeybreadsoftware.net/class-winuserinputstringmbs.shtml"
		  linksMBS.Value("WinUserNotificationCenterMBS")="https://www.monkeybreadsoftware.net/class-winusernotificationcentermbs.shtml"
		  linksMBS.Value("WinUserNotificationExceptionMBS")="https://www.monkeybreadsoftware.net/class-winusernotificationexceptionmbs.shtml"
		  linksMBS.Value("WinUserNotificationMBS")="https://www.monkeybreadsoftware.net/class-winusernotificationmbs.shtml"
		  linksMBS.Value("WinVoiceMBS")="https://www.monkeybreadsoftware.net/class-winvoicembs.shtml"
		  linksMBS.Value("WKBackForwardListItemMBS")="https://www.monkeybreadsoftware.net/class-wkbackforwardlistitemmbs.shtml"
		  linksMBS.Value("WKBackForwardListMBS")="https://www.monkeybreadsoftware.net/class-wkbackforwardlistmbs.shtml"
		  linksMBS.Value("WKDownloadMBS")="https://www.monkeybreadsoftware.net/class-wkdownloadmbs.shtml"
		  linksMBS.Value("WKFrameInfoMBS")="https://www.monkeybreadsoftware.net/class-wkframeinfombs.shtml"
		  linksMBS.Value("WKHTTPCookieStoreMBS")="https://www.monkeybreadsoftware.net/class-wkhttpcookiestorembs.shtml"
		  linksMBS.Value("WKNavigationActionMBS")="https://www.monkeybreadsoftware.net/class-wknavigationactionmbs.shtml"
		  linksMBS.Value("WKNavigationMBS")="https://www.monkeybreadsoftware.net/class-wknavigationmbs.shtml"
		  linksMBS.Value("WKNavigationResponseMBS")="https://www.monkeybreadsoftware.net/class-wknavigationresponsembs.shtml"
		  linksMBS.Value("WKPolicyForNavigationActionDecisionHandlerMBS")="https://www.monkeybreadsoftware.net/class-wkpolicyfornavigationactiondecisionhandlermbs.shtml"
		  linksMBS.Value("WKPolicyForNavigationResponseDecisionHandlerMBS")="https://www.monkeybreadsoftware.net/class-wkpolicyfornavigationresponsedecisionhandlermbs.shtml"
		  linksMBS.Value("WKPreferencesMBS")="https://www.monkeybreadsoftware.net/class-wkpreferencesmbs.shtml"
		  linksMBS.Value("WKUserScriptMBS")="https://www.monkeybreadsoftware.net/class-wkuserscriptmbs.shtml"
		  linksMBS.Value("WKWebViewConfigurationMBS")="https://www.monkeybreadsoftware.net/class-wkwebviewconfigurationmbs.shtml"
		  linksMBS.Value("WKWebViewMBS")="https://www.monkeybreadsoftware.net/class-wkwebviewmbs.shtml"
		  linksMBS.Value("WMIObjectMBS")="https://www.monkeybreadsoftware.net/class-wmiobjectmbs.shtml"
		  linksMBS.Value("WordFileMBS")="https://www.monkeybreadsoftware.net/class-wordfilembs.shtml"
		  linksMBS.Value("X509MBS")="https://www.monkeybreadsoftware.net/class-x509mbs.shtml"
		  linksMBS.Value("XLAutoFilterMBS")="https://www.monkeybreadsoftware.net/class-xlautofiltermbs.shtml"
		  linksMBS.Value("XLBookMBS")="https://www.monkeybreadsoftware.net/class-xlbookmbs.shtml"
		  linksMBS.Value("XLCopyOptionsMBS")="https://www.monkeybreadsoftware.net/class-xlcopyoptionsmbs.shtml"
		  linksMBS.Value("XLFilterColumnMBS")="https://www.monkeybreadsoftware.net/class-xlfiltercolumnmbs.shtml"
		  linksMBS.Value("XLFontMBS")="https://www.monkeybreadsoftware.net/class-xlfontmbs.shtml"
		  linksMBS.Value("XLFormatMBS")="https://www.monkeybreadsoftware.net/class-xlformatmbs.shtml"
		  linksMBS.Value("XLFormControlMBS")="https://www.monkeybreadsoftware.net/class-xlformcontrolmbs.shtml"
		  linksMBS.Value("XLRichStringMBS")="https://www.monkeybreadsoftware.net/class-xlrichstringmbs.shtml"
		  linksMBS.Value("XLSheetMBS")="https://www.monkeybreadsoftware.net/class-xlsheetmbs.shtml"
		  linksMBS.Value("XMLAttributeMBS")="https://www.monkeybreadsoftware.net/class-xmlattributembs.shtml"
		  linksMBS.Value("XMLCDATASectionMBS")="https://www.monkeybreadsoftware.net/class-xmlcdatasectionmbs.shtml"
		  linksMBS.Value("XMLCharacterDataMBS")="https://www.monkeybreadsoftware.net/class-xmlcharacterdatambs.shtml"
		  linksMBS.Value("XMLCommentMBS")="https://www.monkeybreadsoftware.net/class-xmlcommentmbs.shtml"
		  linksMBS.Value("XMLConfigurationMBS")="https://www.monkeybreadsoftware.net/class-xmlconfigurationmbs.shtml"
		  linksMBS.Value("XMLDocumentFragmentMBS")="https://www.monkeybreadsoftware.net/class-xmldocumentfragmentmbs.shtml"
		  linksMBS.Value("XMLDocumentMBS")="https://www.monkeybreadsoftware.net/class-xmldocumentmbs.shtml"
		  linksMBS.Value("XMLDocumentTypeMBS")="https://www.monkeybreadsoftware.net/class-xmldocumenttypembs.shtml"
		  linksMBS.Value("XMLElementMBS")="https://www.monkeybreadsoftware.net/class-xmlelementmbs.shtml"
		  linksMBS.Value("XMLEntityMBS")="https://www.monkeybreadsoftware.net/class-xmlentitymbs.shtml"
		  linksMBS.Value("XMLEntityReferenceMBS")="https://www.monkeybreadsoftware.net/class-xmlentityreferencembs.shtml"
		  linksMBS.Value("XMLExceptionMBS")="https://www.monkeybreadsoftware.net/class-xmlexceptionmbs.shtml"
		  linksMBS.Value("XMLInputMBS")="https://www.monkeybreadsoftware.net/class-xmlinputmbs.shtml"
		  linksMBS.Value("XMLIterateAttributeNodesMBS")="https://www.monkeybreadsoftware.net/class-xmliterateattributenodesmbs.shtml"
		  linksMBS.Value("XMLIterateChildNodesMBS")="https://www.monkeybreadsoftware.net/class-xmliteratechildnodesmbs.shtml"
		  linksMBS.Value("XMLIterateElementsMBS")="https://www.monkeybreadsoftware.net/class-xmliterateelementsmbs.shtml"
		  linksMBS.Value("XMLNodeFilterMBS")="https://www.monkeybreadsoftware.net/class-xmlnodefiltermbs.shtml"
		  linksMBS.Value("XMLNodeIteratorMBS")="https://www.monkeybreadsoftware.net/class-xmlnodeiteratormbs.shtml"
		  linksMBS.Value("XMLNodeMBS")="https://www.monkeybreadsoftware.net/class-xmlnodembs.shtml"
		  linksMBS.Value("XMLNotationMBS")="https://www.monkeybreadsoftware.net/class-xmlnotationmbs.shtml"
		  linksMBS.Value("XMLOutputMBS")="https://www.monkeybreadsoftware.net/class-xmloutputmbs.shtml"
		  linksMBS.Value("XMLParserFilterMBS")="https://www.monkeybreadsoftware.net/class-xmlparserfiltermbs.shtml"
		  linksMBS.Value("XMLParserMBS")="https://www.monkeybreadsoftware.net/class-xmlparsermbs.shtml"
		  linksMBS.Value("XMLProcessingInstructionMBS")="https://www.monkeybreadsoftware.net/class-xmlprocessinginstructionmbs.shtml"
		  linksMBS.Value("XMLSerializerFilterMBS")="https://www.monkeybreadsoftware.net/class-xmlserializerfiltermbs.shtml"
		  linksMBS.Value("XMLSerializerMBS")="https://www.monkeybreadsoftware.net/class-xmlserializermbs.shtml"
		  linksMBS.Value("XMLTextMBS")="https://www.monkeybreadsoftware.net/class-xmltextmbs.shtml"
		  linksMBS.Value("XMLTreeWalkerMBS")="https://www.monkeybreadsoftware.net/class-xmltreewalkermbs.shtml"
		  linksMBS.Value("XMLTypeInfoMBS")="https://www.monkeybreadsoftware.net/class-xmltypeinfombs.shtml"
		  linksMBS.Value("XMLValidatorMBS")="https://www.monkeybreadsoftware.net/class-xmlvalidatormbs.shtml"
		  linksMBS.Value("XMLValidatorMessageMBS")="https://www.monkeybreadsoftware.net/class-xmlvalidatormessagembs.shtml"
		  linksMBS.Value("XMPAssertNotifyMBS")="https://www.monkeybreadsoftware.net/class-xmpassertnotifymbs.shtml"
		  linksMBS.Value("XMPDateTimeMBS")="https://www.monkeybreadsoftware.net/class-xmpdatetimembs.shtml"
		  linksMBS.Value("XMPExceptionMBS")="https://www.monkeybreadsoftware.net/class-xmpexceptionmbs.shtml"
		  linksMBS.Value("XMPFilesMBS")="https://www.monkeybreadsoftware.net/class-xmpfilesmbs.shtml"
		  linksMBS.Value("XMPIteratorMBS")="https://www.monkeybreadsoftware.net/class-xmpiteratormbs.shtml"
		  linksMBS.Value("XMPMetaMBS")="https://www.monkeybreadsoftware.net/class-xmpmetambs.shtml"
		  linksMBS.Value("XMPPacketInfoMBS")="https://www.monkeybreadsoftware.net/class-xmppacketinfombs.shtml"
		  linksMBS.Value("XMPScannerMBS")="https://www.monkeybreadsoftware.net/class-xmpscannermbs.shtml"
		  linksMBS.Value("XMPSnipMBS")="https://www.monkeybreadsoftware.net/class-xmpsnipmbs.shtml"
		  linksMBS.Value("XMPTextOutputMBS")="https://www.monkeybreadsoftware.net/class-xmptextoutputmbs.shtml"
		  linksMBS.Value("XMPVersionInfoMBS")="https://www.monkeybreadsoftware.net/class-xmpversioninfombs.shtml"
		  linksMBS.Value("ZBarMBS")="https://www.monkeybreadsoftware.net/class-zbarmbs.shtml"
		  linksMBS.Value("ZintVectorCircleMBS")="https://www.monkeybreadsoftware.net/class-zintvectorcirclembs.shtml"
		  linksMBS.Value("ZintVectorHexagonMBS")="https://www.monkeybreadsoftware.net/class-zintvectorhexagonmbs.shtml"
		  linksMBS.Value("ZintVectorMBS")="https://www.monkeybreadsoftware.net/class-zintvectormbs.shtml"
		  linksMBS.Value("ZintVectorRectMBS")="https://www.monkeybreadsoftware.net/class-zintvectorrectmbs.shtml"
		  linksMBS.Value("ZintVectorStringMBS")="https://www.monkeybreadsoftware.net/class-zintvectorstringmbs.shtml"
		  linksMBS.Value("ZipFileInfoMBS")="https://www.monkeybreadsoftware.net/class-zipfileinfombs.shtml"
		  linksMBS.Value("ZipMBS")="https://www.monkeybreadsoftware.net/class-zipmbs.shtml"
		  linksMBS.Value("ZLibCompressMBS")="https://www.monkeybreadsoftware.net/class-zlibcompressmbs.shtml"
		  linksMBS.Value("ZLibDecompressMBS")="https://www.monkeybreadsoftware.net/class-zlibdecompressmbs.shtml"
		  linksMBS.Value("ZStdMBS")="https://www.monkeybreadsoftware.net/class-zstdmbs.shtml"
		  
		  addXolMBS (2842)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopulateMain()
		  var n as integer
		  
		  var f as NSMenuItemMBS
		  var a,aa,b,bb, c,d,g,h ,k, p, qq, r, rr, TxtMenu as MyCocoaMenuItemMBS
		  'var m,mm as NSMenuMBS
		  
		  links = new Dictionary ()
		  
		  
		  wLink = "https://documentation.xojo.com/index.html"
		  
		  m = new MyCocoaMenuMBS
		  
		  mHistory = new MyCocoaMenuMBS
		  
		  
		  myview = new NSViewMBS(0,0,150,20)
		  mytext = new MyNSTextFieldMBS(20, 0, 110, 20)
		  mytext.StringValue = "" 
		  myview.addSubview mytext
		  
		  TxtMenu=new MyCocoaMenuItemMBS
		  TxtMenu.CreateMenuItem "Search"
		  TxtMenu.view = myview
		  TxtMenu.tag = 1
		  
		  m.AddItem TxtMenu
		  
		  
		  b=new MyCocoaMenuItemMBS
		  b.CreateMenuItem "Language"
		  b.Enabled=true
		  b.state=0
		  b.Tag=2
		  items.Append b 
		  m.AddItem b
		  
		  bb=new MyCocoaMenuItemMBS
		  bb.CreateMenuItem "Using Language"
		  bb.Enabled=true
		  bb.state=0
		  bb.Tag=3
		  items.Append bb 
		  m.AddItem bb
		  
		  c=new MyCocoaMenuItemMBS
		  c.CreateMenuItem "Plugins"
		  c.Enabled=true
		  c.state=0
		  c.Tag=4
		  items.Append c 
		  m.AddItem c
		  
		  p=new MyCocoaMenuItemMBS
		  p.CreateMenuItem "History"
		  p.Enabled=true
		  p.state=0
		  p.Tag=5
		  items.Append p
		  m.AddItem p
		  
		  d=new MyCocoaMenuItemMBS
		  d.CreateMenuItem "                API     "
		  d.Enabled=false
		  d.state=0
		  d.Tag=6
		  items.Append d 
		  m.AddItem d
		  
		  
		  // main menu
		  
		  links.Value("Code execution") = "https://documentation.xojo.com/api/code_execution/index.html"
		  links.Value("Compiler directives") = "https://documentation.xojo.com/api/compiler_directives/index.html"
		  links.Value("Cryptography") = "https://documentation.xojo.com/api/cryptography/index.html"
		  links.Value("Data types") = "https://documentation.xojo.com/api/data_types/index.html"
		  links.Value("Databases") = "https://documentation.xojo.com/api/databases/index.html"
		  links.Value("Deprecated") = "https://documentation.xojo.com/api/deprecated/index.html"
		  links.Value("Exceptions") = "https://documentation.xojo.com/api/exceptions/index.html"
		  links.Value("Files") = "https://documentation.xojo.com/api/files/index.html"
		  links.Value("Graphics") = "https://documentation.xojo.com/api/graphics/index.html"
		  links.Value("Hardware") = "https://documentation.xojo.com/api/hardware/index.html"
		  links.Value("iOS") = "https://documentation.xojo.com/api/ios/index.html"
		  
		  links.Value("macOS") = "https://documentation.xojo.com/api/macos/index.html"
		  links.Value("Math") = "https://documentation.xojo.com/api/math/index.html"
		  links.Value("Mobile") = "https://documentation.xojo.com/api/mobile/index.html"
		  links.Value("Networking") = "https://documentation.xojo.com/api/networking/index.html"
		  links.Value("OS") = "https://documentation.xojo.com/api/os/index.html"
		  links.Value("PDF") = "https://documentation.xojo.com/api/pdf/index.html"
		  links.Value("Printing") = "https://documentation.xojo.com/api/printing/index.html"
		  links.Value("Text") = "https://documentation.xojo.com/api/text/index.html"
		  links.Value("User interface") = "https://documentation.xojo.com/api/user_interface/index.html"
		  links.Value("User interface Desktop") = "https://documentation.xojo.com/api/user_interface/index.html"
		  links.Value("User interface Web") = "https://documentation.xojo.com/api/user_interface/index.html"
		  links.Value("Web") = "https://documentation.xojo.com/api/web/index.html"
		  links.Value("Windows") = "https://documentation.xojo.com/api/windows/index.html"
		  links.Value("Xojo Cloud") = "https://documentation.xojo.com/api/xojocloud/index.html"
		  
		  'linksMisc.Value("Debugging") = "https://documentation.xojo.com/getting_started/debugging/index.html"
		  'linksMisc.Value("Debugging") = "https://documentation.xojo.com/getting_started/debugging/index.html"
		  'linksMisc.Value("Debugging") = "https://documentation.xojo.com/getting_started/debugging/index.html"
		  
		  
		  n = 6
		  For Each menuItem As DictionaryEntry In links
		    
		    'Var numDays As string = menuItem.Value
		    b=new MyCocoaMenuItemMBS
		    b.CreateMenuItem menuItem.Key
		    b.Enabled=true
		    b.Tag=n+20
		    items.Append b 
		    m.AddItem b
		  Next
		  
		  links.Value("Language") = "https://documentation.xojo.com/api/language/index.html"
		  
		  g=new MyCocoaMenuItemMBS
		  g.CreateSeparator
		  g.Tag=8
		  items.Append g
		  m.AddItem g
		  
		  h=new MyCocoaMenuItemMBS
		  h.CreateMenuItem "Getting Started"
		  h.Enabled=true
		  h.state=0
		  h.Tag=9
		  items.Append h 
		  m.AddItem h
		  
		  k=new MyCocoaMenuItemMBS
		  k.CreateMenuItem "Topics"
		  k.Enabled=true
		  k.state=0
		  k.Tag=10
		  items.Append k
		  m.AddItem k
		  
		  p=new MyCocoaMenuItemMBS
		  p.CreateMenuItem "Resources"
		  p.Enabled=true
		  p.state=0
		  p.Tag=11
		  items.Append p
		  m.AddItem p
		  
		  g=new MyCocoaMenuItemMBS
		  g.CreateSeparator
		  items.Append g
		  g.Tag=12
		  m.AddItem g
		  
		  
		  
		  p=new MyCocoaMenuItemMBS
		  p.CreateMenuItem "About Preferences..."
		  p.Enabled=true
		  p.state=0
		  p.Tag=13
		  items.Append p
		  m.AddItem p
		  
		  g=new MyCocoaMenuItemMBS
		  g.CreateSeparator
		  g.Tag=14
		  items.Append g
		  m.AddItem g
		  
		  qq=new MyCocoaMenuItemMBS
		  qq.CreateMenuItem "Quit"
		  qq.Enabled=true
		  qq.state=0
		  qq.Tag=15
		  items.Append qq
		  m.AddItem qq
		  
		  e.Menu=m
		  
		  links.Value("Doc MBS") = "https://www.monkeybreadsoftware.net/"
		  'links.Value("cUrl MBS") = "https://www.monkeybreadsoftware.net/plugins-mbscurlplugin.shtml"
		  'links.Value("RabbitMQ MBS") = "https://www.monkeybreadsoftware.net/pluginpart-rabbit.shtml"
		  'links.Value("Json MBS") = "https://www.monkeybreadsoftware.net/class-jsonmbs.shtml"
		  links.Value("Doc Einhugur") = "https://www.einhugur.com/Html/EDNIndex.html"
		  
		  addSubMenu (-2,2)
		  
		  
		  
		  
		  'menus.tags 
		  
		  'xol system  0-20
		  'main api menu 21-100
		  'language 1000-4000
		  'history 4000-5000
		  ' misc 5000-6000
		  'mbs 7000-9000
		  'Einhugur 9000- 12000
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		counter As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		counterMisc As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		defaultURL As String
	#tag EndProperty

	#tag Property, Flags = &h0
		e As MyCocoaStatusItemMBS
	#tag EndProperty

	#tag Property, Flags = &h0
		folderEin As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		folderXojo As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		i As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		items(0) As NSMenuitemMBS
	#tag EndProperty

	#tag Property, Flags = &h0
		itemsHistory(0) As NSMenuitemMBS
	#tag EndProperty

	#tag Property, Flags = &h0
		links As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		linksEin As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		linksMBS As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		linksMisc As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		linksTopics As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		m As MyCocoaMenuMBS
	#tag EndProperty

	#tag Property, Flags = &h0
		mHistory As MyCocoaMenuMBS
	#tag EndProperty

	#tag Property, Flags = &h0
		mytext As MyNSTextFieldMBS
	#tag EndProperty

	#tag Property, Flags = &h0
		myview As NSViewMBS
	#tag EndProperty

	#tag Property, Flags = &h0
		searchEin As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		searchMBS As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		showDocXol As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		wChars As String
	#tag EndProperty

	#tag Property, Flags = &h0
		wLink As string
	#tag EndProperty

	#tag Property, Flags = &h0
		wordList() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		wSearch As string
	#tag EndProperty

	#tag Property, Flags = &h0
		xol As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		xolMin As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="counter"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="i"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="wLink"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="wSearch"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="counterMisc"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="showDocXol"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="wChars"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="searchMBS"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="searchEin"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultURL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
