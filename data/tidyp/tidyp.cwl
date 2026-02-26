cwlVersion: v1.2
class: CommandLineTool
baseCommand: tidyp
label: tidyp
doc: "Utility to clean up and pretty print HTML/XHTML/XML\n\nTool homepage: https://github.com/jbengler/tidyplots"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: accessibility_level
    type:
      - 'null'
      - int
    doc: do additional accessibility checks (<level> = 0, 1, 2, 3). 0 is assumed
      if <level> is missing.
    default: 0
    inputBinding:
      position: 102
      prefix: -access
  - id: ascii_encoding
    type:
      - 'null'
      - boolean
    doc: use ISO-8859-1 for input, US-ASCII for output
    inputBinding:
      position: 102
      prefix: -ascii
  - id: big5_encoding
    type:
      - 'null'
      - boolean
    doc: use Big5 for both input and output
    inputBinding:
      position: 102
      prefix: -big5
  - id: clean
    type:
      - 'null'
      - boolean
    doc: replace FONT, NOBR and CENTER tags by CSS
    inputBinding:
      position: 102
      prefix: -clean
  - id: config_file
    type:
      - 'null'
      - File
    doc: set configuration options from the specified <file>
    inputBinding:
      position: 102
      prefix: -config
  - id: convert_to_xhtml
    type:
      - 'null'
      - boolean
    doc: convert HTML to well formed XHTML
    inputBinding:
      position: 102
      prefix: -asxhtml
  - id: convert_to_xml
    type:
      - 'null'
      - boolean
    doc: convert HTML to well formed XML
    inputBinding:
      position: 102
      prefix: -asxml
  - id: error_file
    type:
      - 'null'
      - File
    doc: write errors and warnings to the specified <file>
    inputBinding:
      position: 102
      prefix: -file
  - id: force_to_html
    type:
      - 'null'
      - boolean
    doc: force XHTML to well formed HTML
    inputBinding:
      position: 102
      prefix: -ashtml
  - id: force_upper_case
    type:
      - 'null'
      - boolean
    doc: force tags to upper case
    inputBinding:
      position: 102
      prefix: -upper
  - id: ibm858_encoding
    type:
      - 'null'
      - boolean
    doc: use IBM-858 (CP850+Euro) for input, US-ASCII for output
    inputBinding:
      position: 102
      prefix: -ibm858
  - id: indent
    type:
      - 'null'
      - boolean
    doc: indent element content
    inputBinding:
      position: 102
      prefix: -indent
  - id: input_xml
    type:
      - 'null'
      - boolean
    doc: specify the input is well formed XML
    inputBinding:
      position: 102
      prefix: -xml
  - id: iso2022_encoding
    type:
      - 'null'
      - boolean
    doc: use ISO-2022 for both input and output
    inputBinding:
      position: 102
      prefix: -iso2022
  - id: language
    type:
      - 'null'
      - string
    doc: set the two-letter language code <lang> (for future use)
    inputBinding:
      position: 102
      prefix: -language
  - id: latin0_encoding
    type:
      - 'null'
      - boolean
    doc: use ISO-8859-15 for input, US-ASCII for output
    inputBinding:
      position: 102
      prefix: -latin0
  - id: latin1_encoding
    type:
      - 'null'
      - boolean
    doc: use ISO-8859-1 for both input and output
    inputBinding:
      position: 102
      prefix: -latin1
  - id: macroman_encoding
    type:
      - 'null'
      - boolean
    doc: use MacRoman for input, US-ASCII for output
    inputBinding:
      position: 102
      prefix: -mac
  - id: modify
    type:
      - 'null'
      - boolean
    doc: modify the original input files
    inputBinding:
      position: 102
      prefix: -modify
  - id: numeric_entities
    type:
      - 'null'
      - boolean
    doc: output numeric rather than named entities
    inputBinding:
      position: 102
      prefix: -numeric
  - id: omit_end_tags
    type:
      - 'null'
      - boolean
    doc: omit optional end tags
    inputBinding:
      position: 102
      prefix: -omit
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress nonessential output
    inputBinding:
      position: 102
      prefix: -quiet
  - id: raw_output
    type:
      - 'null'
      - boolean
    doc: output values above 127 without conversion to entities
    inputBinding:
      position: 102
      prefix: -raw
  - id: shiftjis_encoding
    type:
      - 'null'
      - boolean
    doc: use Shift_JIS for both input and output
    inputBinding:
      position: 102
      prefix: -shiftjis
  - id: show_config
    type:
      - 'null'
      - boolean
    doc: list the current configuration settings
    inputBinding:
      position: 102
      prefix: -show-config
  - id: show_config_help
    type:
      - 'null'
      - boolean
    doc: list all configuration options
    inputBinding:
      position: 102
      prefix: -help-config
  - id: show_errors_only
    type:
      - 'null'
      - boolean
    doc: show only errors and warnings
    inputBinding:
      position: 102
      prefix: -errors
  - id: show_version
    type:
      - 'null'
      - boolean
    doc: show the version of Tidy
    inputBinding:
      position: 102
      prefix: -version
  - id: strip_smart_quotes
    type:
      - 'null'
      - boolean
    doc: strip out smart quotes and em dashes, etc.
    inputBinding:
      position: 102
      prefix: -bare
  - id: utf16_encoding
    type:
      - 'null'
      - boolean
    doc: use UTF-16 for both input and output
    inputBinding:
      position: 102
      prefix: -utf16
  - id: utf16be_encoding
    type:
      - 'null'
      - boolean
    doc: use UTF-16BE for both input and output
    inputBinding:
      position: 102
      prefix: -utf16be
  - id: utf16le_encoding
    type:
      - 'null'
      - boolean
    doc: use UTF-16LE for both input and output
    inputBinding:
      position: 102
      prefix: -utf16le
  - id: utf8_encoding
    type:
      - 'null'
      - boolean
    doc: use UTF-8 for both input and output
    inputBinding:
      position: 102
      prefix: -utf8
  - id: win1252_encoding
    type:
      - 'null'
      - boolean
    doc: use Windows-1252 for input, US-ASCII for output
    inputBinding:
      position: 102
      prefix: -win1252
  - id: wrap_column
    type:
      - 'null'
      - int
    doc: wrap text at the specified <column>. 0 is assumed if <column> is 
      missing. When this option is omitted, the default of the configuration 
      option "wrap" applies.
    inputBinding:
      position: 102
      prefix: -wrap
  - id: xml_config_help
    type:
      - 'null'
      - boolean
    doc: list all configuration options in XML format
    inputBinding:
      position: 102
      prefix: -xml-config
  - id: xml_help
    type:
      - 'null'
      - boolean
    doc: list the command line options in XML format
    inputBinding:
      position: 102
      prefix: -xml-help
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output to the specified <file>
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidyp:1.04--h7b50bb2_9
