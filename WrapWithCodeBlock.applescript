-- Get the selected text from PopClip
set selectedText to "{popclip text}"

-- List of code languages for the user to choose from
set languageList to {"markdown", "python", "javascript", "java", "ruby", "shell", "html", "css", "go", "csharp"}

-- Create a numbered list for display
set displayList to {}
repeat with i from 1 to length of languageList
    set end of displayList to (i as string) & ". " & (item i of languageList)
end repeat

-- Activate the script before showing the dialog
tell application "System Events" to activate

-- Display the GUI menu to select the code type
set chosenItem to choose from list displayList with prompt "Select the code type or type a number (1-" & (length of languageList as string) & "):" default items {item 1 of displayList} with title "Select Code Type"

-- If the user made a selection
if chosenItem is not false then
    set chosenText to item 1 of chosenItem
    
    -- Extract the selected code language from languageList
    set chosenNumber to (text 1 thru 1 of chosenText) as number
    set chosenLanguage to item chosenNumber of languageList
    
    -- Wrap the selected text with code block markers and the chosen language
    set finalText to "```" & chosenLanguage & linefeed & selectedText & linefeed & "```"
    
    -- Set the clipboard to the wrapped text
    set the clipboard to finalText
    display notification "The selected text has been wrapped as a " & chosenLanguage & " code block and copied to the clipboard."
else
    -- If no option was selected, notify the user
    display notification "No code type was selected."
end if
