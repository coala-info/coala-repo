cwlVersion: v1.2
class: CommandLineTool
baseCommand: markitdown
label: markitdown
doc: "Convert various file formats to markdown.\n\nTool homepage: https://github.com/microsoft/markitdown"
inputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: Input file to be converted. If empty, markitdown reads from stdin.
    inputBinding:
      position: 1
  - id: charset
    type:
      - 'null'
      - string
    doc: Provide a hint about the file's charset (e.g, UTF-8).
    inputBinding:
      position: 102
      prefix: --charset
  - id: endpoint
    type:
      - 'null'
      - string
    doc: Document Intelligence Endpoint. Required if using Document 
      Intelligence.
    inputBinding:
      position: 102
      prefix: --endpoint
  - id: extension
    type:
      - 'null'
      - string
    doc: Provide a hint about the file extension (e.g., when reading from 
      stdin).
    inputBinding:
      position: 102
      prefix: --extension
  - id: keep_data_uris
    type:
      - 'null'
      - boolean
    doc: Keep data URIs (like base64-encoded images) in the output. By default, 
      data URIs are truncated.
    inputBinding:
      position: 102
      prefix: --keep-data-uris
  - id: list_plugins
    type:
      - 'null'
      - boolean
    doc: List installed 3rd-party plugins. Plugins are loaded when using the -p 
      or --use-plugin option.
    inputBinding:
      position: 102
      prefix: --list-plugins
  - id: mime_type
    type:
      - 'null'
      - string
    doc: Provide a hint about the file's MIME type.
    inputBinding:
      position: 102
      prefix: --mime-type
  - id: use_docintel
    type:
      - 'null'
      - boolean
    doc: Use Document Intelligence to extract text instead of offline 
      conversion. Requires a valid Document Intelligence Endpoint.
    inputBinding:
      position: 102
      prefix: --use-docintel
  - id: use_plugins
    type:
      - 'null'
      - boolean
    doc: Use 3rd-party plugins to convert files. Use --list-plugins to see 
      installed plugins.
    inputBinding:
      position: 102
      prefix: --use-plugins
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name. If not provided, output is written to stdout.
    outputBinding:
      glob: $(inputs.output)
