cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaptamer_search
label: fastaptamer_fastaptamer_search
doc: "FASTAptamer-Search allows users to search for specific patterns within one or
  more sequence files.\n\nTool homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs:
  - id: highlight
    type:
      - 'null'
      - boolean
    doc: Highlight matched portion of sequence in parentheses.
    inputBinding:
      position: 101
      prefix: -highlight
  - id: input_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: -i
        separate: true
    doc: Input file; can be used multiple times. REQUIRED.
    inputBinding:
      position: 101
  - id: patterns
    type:
      type: array
      items: string
      inputBinding:
        prefix: -p
        separate: true
    doc: Sequence pattern to search for; can be used multiple times. REQUIRED.
    inputBinding:
      position: 101
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress summary report.
    inputBinding:
      position: 101
      prefix: -q
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output file path (-o)
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for search results. If none given, output goes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
