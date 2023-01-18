#tag Class
Protected Class MyNSTextFieldMBS
Inherits NSTextFieldMBS
	#tag Event
		Function textShouldEndEditing(fieldEditor as NSTextMBS) As boolean
		  
		  app.wSearch = fieldEditor.Text
		  
		  app.wLink = app.links.Lookup (app.wSearch, "" ) 
		  
		  if app.wLink <> "" then
		    
		    app.displayDoc
		    'app.FrontmostMBS = True
		  else
		    
		    app.wChars = fieldEditor.text
		    
		    WinSearch.show
		    'app.FrontmostMBS = True
		    
		    WinSearch.NSSearchFieldControlMBS1.View.StringValue = app.wChars
		    
		    
		  end if
		  
		  
		  
		End Function
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
