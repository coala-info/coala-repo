cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - merge
label: bamtools_merge
doc: "merges multiple BAM files into one.\n\nTool homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: force_compression
    type:
      - 'null'
      - boolean
    doc: if results are sent to stdout (like when piping to another tool), 
      default behavior is to leave output uncompressed. Use this flag to 
      override and force compression
    inputBinding:
      position: 101
      prefix: -forceCompression
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: the input BAM file(s)
    inputBinding:
      position: 101
      prefix: -in
  - id: input_list
    type:
      - 'null'
      - File
    doc: the input BAM file list, one line per file
    inputBinding:
      position: 101
      prefix: -list
  - id: region
    type:
      - 'null'
      - string
    doc: genomic region. See README for more details
    inputBinding:
      position: 101
      prefix: -region
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: the output BAM file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
