cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - revert
label: bamtools_revert
doc: "removes duplicate marks and restores original (non-recalibrated) base qualities.\n\
  \ \nTool homepage: https://github.com/pezmaster31/bamtools"
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
  - id: input_file
    type:
      - 'null'
      - type: array
        items: File
    doc: the input BAM file [stdin]
    inputBinding:
      position: 101
      prefix: -in
  - id: keep_duplicate
    type:
      - 'null'
      - boolean
    doc: keep duplicates marked
    inputBinding:
      position: 101
      prefix: -keepDuplicate
  - id: keep_qualities
    type:
      - 'null'
      - boolean
    doc: keep base qualities (do not replace with OQ contents)
    inputBinding:
      position: 101
      prefix: -keepQualities
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
    doc: the output BAM file [stdout]
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
