#tag Class
Protected Class MyCocoaMenuItemMBS
Inherits NSMenuItemMBS
	#tag Event
		Sub Action()
		  'MsgBox " tag number "+str(tag)
		  
		  
		   if me.tag = 15  then //////
		    
		    quit
		    
		  elseif me.tag =13 then // "Preferences..."
		    
		    'messagebox("pref")
		    
		    winPref.Show
		    app.FrontmostMBS = True
		    'elseif me.tag =5 then // History
		    
		    'app.wLink = app.links.Lookup (me.Title, "https://documentation.xojo.com/index.html") 
		    
		    'elseif me.tag = 0 then
		    
		    'WinSearch.Show
		    
		  else /// any tag #
		    
		    app.wLink = app.links.Lookup (me.Title, app.defaultURL) 
		    
		    if app.wLink = app.defaultURL then // look other than xojo language
		      app.wLink = app.linksMisc.Lookup (me.Title, app.defaultURL) 
		      
		      if app.wLink = app.defaultURL then // look ein
		        
		        app.wLink = app.linksEin.Lookup (me.Title, "https://www.einhugur.com/Html/EDNIndex.html") 
		        'MessageBox (app.wLink)
		        'file:///Applications/Xojo%20tools/Einhugur%20Docset/JSON%20Plugin%20III.docset/Documents/index.html
		      end if
		      
		      
		    end if
		    
		    
		    if app.wLink <> app.defaultURL then 
		      App.addHistory (me.Title)
		    end if
		    
		    app.displayDoc
		    
		  end if
		  
		  
		  
		  
		  ///////////////////
		  
		  
		  
		  
		End Sub
	#tag EndEvent


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
