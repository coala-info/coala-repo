cwlVersion: v1.2
class: CommandLineTool
baseCommand: exiftool
label: perl-image-exiftool_exiftool
doc: "Read and write meta information in files. A command-line interface to Image::ExifTool, used for reading and writing meta information in a variety of file types.\n\nTool homepage: https://exiftool.org/"
inputs:
  - id: tags
    type:
      - 'null'
      - type: array
        items: string
    doc: "Tags to extract, written like -Make or -EXIF:Model (a leading dash is required; use --TAG to exclude a tag)"
    inputBinding:
      position: 102
  - id: assignments
    type:
      - 'null'
      - type: array
        items: string
    doc: "Tag assignments for writing, written like -Artist=Name (use together with output_file or a writable copy)"
    inputBinding:
      position: 103
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Use JSON formatting for output"
    inputBinding:
      position: 101
      prefix: -json
  - id: csv
    type:
      - 'null'
      - boolean
    doc: "Use CSV formatting for output"
    inputBinding:
      position: 101
      prefix: -csv
  - id: xml
    type:
      - 'null'
      - boolean
    doc: "Use RDF/XML output format"
    inputBinding:
      position: 101
      prefix: -X
  - id: html
    type:
      - 'null'
      - boolean
    doc: "Use HTML formatting for output"
    inputBinding:
      position: 101
      prefix: -h
  - id: php
    type:
      - 'null'
      - boolean
    doc: "Format output as a PHP array"
    inputBinding:
      position: 101
      prefix: -php
  - id: table
    type:
      - 'null'
      - boolean
    doc: "Output in a tabular format"
    inputBinding:
      position: 101
      prefix: -T
  - id: tab
    type:
      - 'null'
      - boolean
    doc: "Output a tab-delimited list"
    inputBinding:
      position: 101
      prefix: -t
  - id: short
    type:
      - 'null'
      - boolean
    doc: "Short output format: tag names instead of descriptions"
    inputBinding:
      position: 101
      prefix: -s
  - id: very_short
    type:
      - 'null'
      - boolean
    doc: "Very short output format: values only with tag names"
    inputBinding:
      position: 101
      prefix: -S
  - id: long
    type:
      - 'null'
      - boolean
    doc: "Long output format: show the tag description and the unconverted value"
    inputBinding:
      position: 101
      prefix: -l
  - id: group_names
    type:
      - 'null'
      - string
    doc: "Show group names for each tag (-G, optionally with family numbers, for example 1 or 0:1)"
    inputBinding:
      position: 101
      prefix: -G
      separate: false
  - id: group_headings
    type:
      - 'null'
      - string
    doc: "Organize output by tag group (-g, optionally with family numbers)"
    inputBinding:
      position: 101
      prefix: -g
      separate: false
  - id: numeric
    type:
      - 'null'
      - boolean
    doc: "Disable print conversion (show numerical values)"
    inputBinding:
      position: 101
      prefix: -n
  - id: binary
    type:
      - 'null'
      - boolean
    doc: "Output metadata in binary format"
    inputBinding:
      position: 101
      prefix: -b
  - id: duplicates
    type:
      - 'null'
      - boolean
    doc: "Allow duplicate tags to be extracted"
    inputBinding:
      position: 101
      prefix: -a
  - id: unknown
    type:
      - 'null'
      - boolean
    doc: "Extract unknown tags"
    inputBinding:
      position: 101
      prefix: -u
  - id: unknown2
    type:
      - 'null'
      - boolean
    doc: "Extract unknown binary tags too"
    inputBinding:
      position: 101
      prefix: -U
  - id: composite
    type:
      - 'null'
      - boolean
    doc: "Extract composite tags (use as --e to disable)"
    inputBinding:
      position: 101
      prefix: -e
  - id: extract_embedded
    type:
      - 'null'
      - boolean
    doc: "Extract information from embedded files"
    inputBinding:
      position: 101
      prefix: -ee
  - id: force_print
    type:
      - 'null'
      - boolean
    doc: "Force printing of tags even if their values are not found"
    inputBinding:
      position: 101
      prefix: -f
  - id: hex
    type:
      - 'null'
      - boolean
    doc: "Show numerical values in hexadecimal"
    inputBinding:
      position: 101
      prefix: -H
  - id: decimal
    type:
      - 'null'
      - boolean
    doc: "Show tag ID numbers in decimal"
    inputBinding:
      position: 101
      prefix: -D
  - id: escape_html
    type:
      - 'null'
      - boolean
    doc: "Escape characters in values for HTML"
    inputBinding:
      position: 101
      prefix: -E
  - id: struct
    type:
      - 'null'
      - boolean
    doc: "Output structured XMP information instead of flattening"
    inputBinding:
      position: 101
      prefix: -struct
  - id: sort
    type:
      - 'null'
      - boolean
    doc: "Sort output alphabetically"
    inputBinding:
      position: 101
      prefix: -sort
  - id: date_format
    type:
      - 'null'
      - string
    doc: "Set the format for date/time values (strftime format)"
    inputBinding:
      position: 101
      prefix: -d
  - id: coord_format
    type:
      - 'null'
      - string
    doc: "Set the format for GPS coordinates"
    inputBinding:
      position: 101
      prefix: -c
  - id: charset
    type:
      - 'null'
      - string
    doc: "Specify the character set for output text"
    inputBinding:
      position: 101
      prefix: -charset
  - id: lang
    type:
      - 'null'
      - string
    doc: "Set the language for tag descriptions"
    inputBinding:
      position: 101
      prefix: -lang
  - id: separator
    type:
      - 'null'
      - string
    doc: "Set the separator string for list-type tags"
    inputBinding:
      position: 101
      prefix: -sep
  - id: exclude_tags
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -x
    doc: "Exclude specified tag from the output"
    inputBinding:
      position: 101
  - id: ext
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -ext
    doc: "Process only files with this extension"
    inputBinding:
      position: 101
  - id: ignore_dir
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -i
    doc: "Ignore this directory name"
    inputBinding:
      position: 101
  - id: if_condition
    type:
      - 'null'
      - string
    doc: "Process files only if this Perl expression is true"
    inputBinding:
      position: 101
      prefix: -if
  - id: fast
    type:
      - 'null'
      - boolean
    doc: "Increase speed when extracting metadata"
    inputBinding:
      position: 101
      prefix: -fast
  - id: ignore_minor_errors
    type:
      - 'null'
      - boolean
    doc: "Ignore minor errors and warnings"
    inputBinding:
      position: 101
      prefix: -m
  - id: preserve
    type:
      - 'null'
      - boolean
    doc: "Preserve the file modification date/time"
    inputBinding:
      position: 101
      prefix: -P
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Quiet processing"
    inputBinding:
      position: 101
      prefix: -q
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: "Recursively process files in subdirectories"
    inputBinding:
      position: 101
      prefix: -r
  - id: verbose
    type:
      - 'null'
      - string
    doc: "Print verbose messages (-v with an optional level)"
    inputBinding:
      position: 101
      prefix: -v
      separate: false
  - id: zip
    type:
      - 'null'
      - boolean
    doc: "Read/write compressed information"
    inputBinding:
      position: 101
      prefix: -z
  - id: print_format
    type:
      - 'null'
      - string
    doc: "Print output in the specified format string"
    inputBinding:
      position: 101
      prefix: -p
  - id: args
    type:
      - 'null'
      - boolean
    doc: "Format metadata as exiftool argument lines"
    inputBinding:
      position: 101
      prefix: -args
  - id: list_item
    type:
      - 'null'
      - int
    doc: "Extract only this item from a list of items (index starting at 0)"
    inputBinding:
      position: 101
      prefix: -listItem
  - id: diff_file
    type:
      - 'null'
      - File
    doc: "Compare metadata with another file"
    inputBinding:
      position: 101
      prefix: -diff
  - id: config_file
    type:
      - 'null'
      - File
    doc: "Specify the configuration file name"
    inputBinding:
      position: 101
      prefix: -config
  - id: tags_from_file
    type:
      - 'null'
      - File
    doc: "Copy tag values from this file (use with output_file)"
    inputBinding:
      position: 101
      prefix: -tagsFromFile
  - id: overwrite_original
    type:
      - 'null'
      - boolean
    doc: "Overwrite the original file instead of creating a _original backup"
    inputBinding:
      position: 101
      prefix: -overwrite_original
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Name of the output file written with the metadata changes (the original is not touched)"
    inputBinding:
      position: 101
      prefix: -o
  - id: ver
    type:
      - 'null'
      - boolean
    doc: "Print the exiftool version number"
    inputBinding:
      position: 101
      prefix: -ver
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files to read or write metadata from"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Metadata printed to standard output
  - id: output_file_out
    type:
      - 'null'
      - File
    doc: File written with the output_file option
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-image-exiftool:13.44--pl5321hdfd78af_0
stdout: perl-image-exiftool_exiftool.out
