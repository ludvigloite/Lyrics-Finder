on alfred_script(q)
	
	set timesTried to 5
	
	tell application "Safari" to activate
	if appIsRunning("Spotify") then
		tell application "Spotify"
			set track_artist to artist of current track
			set track_name to name of current track
			set theURL to "http://genius.com/search?q=" & track_name & " " & track_artist
			tell application "Safari"
				activate
				try
					tell window 1 to set current tab to (make new tab with properties {URL:theURL})
				on error
					open location theURL --run this if Safari does not have a window open
				end try
			end tell
			
			tell application "Safari"
				
				set theScript to "document.querySelector('body > routable-page > ng-outlet > search-results-page > div > div.column_layout > div.column_layout-column_span.column_layout-column_span--primary > div:nth-child(1) > search-result-section > div > div:nth-child(2) > search-result-items > div > search-result-item > div > mini-song-card > a').click();"
				
				repeat timesTried times
					delay 1
					tell document 1
						do JavaScript theScript
					end tell
				end repeat
			end tell
			
			tell application "System Events" to keystroke "r" using {command down, shift down}
			
			tell application "Safari" to tell document 1
				do JavaScript "window.scroll(0,1)"
			end tell
			
		end tell
	end if
end alfred_script


on appIsRunning(appName)
	tell application "System Events" to (name of processes) contains appName
end appIsRunning