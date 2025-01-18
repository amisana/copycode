![Description of Image](copycode-banner-4x3.png)

# Text File Content Extractor

A sophisticated AppleScript utility designed for batch extraction and formatting of text-based file contents. The script provides robust error handling, UTF-8 encoding support, and intelligent content organization with syntax-aware formatting.

## Core Features

- Multi-file selection with comprehensive validation
- Support for common text file formats (txt, py, js, md, csv, json, xml, sh, rb, pl, php, html, css)
- Automatic syntax-aware code fence generation
- UTF-8 encoding management
- Graceful binary file handling
- Atomic write operations

## Technical Implementation

The script implements a resilient error handling architecture with resource cleanup guarantees:

```applescript
try
    -- Get multiple file selections
    set selectedFiles to choose file with prompt "Please select files" with multiple selections allowed
    
    -- Initialize empty content string
    set allContent to ""
    
    -- Process each file
    repeat with aFile in selectedFiles
        tell application "System Events"
            set fileExtension to name extension of aFile
        end tell
        
        -- Check if it's a text file
        if fileExtension is in {"txt", "py", "js", "md", "csv", "json", "xml", "sh", "rb", "pl", "php", "html", "css"} then
            -- Add path
            set filePath to "'" & POSIX path of aFile & "'" & return & return
            
            -- Read content with UTF-8 encoding
            set fileRef to open for access aFile
            set fileContent to (read fileRef as «class utf8»)
            close access fileRef
            
            -- Format with code fence and extension
            set formattedContent to filePath & "```" & fileExtension & return & fileContent & return & "```" & return & return
            
            -- Add to main content
            set allContent to allContent & formattedContent
        else
            -- Skip binary files but continue processing
            set allContent to allContent & "'" & POSIX path of aFile & "' (Skipped - not a text file)" & return & return
        end if
    end repeat
    
    -- Write everything to output file
    set outputFile to ((path to documents folder as text) & "selected_files_paths.txt")
    set fileRef to open for access outputFile with write permission
    write allContent to fileRef as «class utf8»
    close access fileRef
    
    -- Confirm to user
    display dialog "Files have been processed and saved to selected_files_paths.txt in your Documents folder" buttons {"OK"} default button "OK"
    
on error errMsg
    try
        close access fileRef
    end try
    display dialog "Error: " & errMsg buttons {"OK"} default button "OK"
end try
```

## Installation

1. Save the script with a `.scpt` extension
2. Ensure you have appropriate permissions for the Documents folder
3. Optional: Create a keyboard shortcut or Quick Action for the script

## Usage

1. Run the script
2. Select one or more text files when prompted
3. The formatted content will be saved to `selected_files_paths.txt` in your Documents folder

## Error Handling

The script implements a comprehensive error management strategy:
- Resource cleanup on error
- User-friendly error messages
- Graceful handling of unsupported file types
- UTF-8 encoding validation

## License

MIT License

## Contributing

Feel free to submit issues and enhancement requests.
