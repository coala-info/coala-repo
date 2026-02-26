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
    doc: Input file; can be used multiple times. REQUIRED.
    inputBinding:
      position: 101
      prefix: -i
  - id: patterns
    type:
      type: array
      items: string
    doc: Sequence pattern to search for; can be used multiple times. REQUIRED.
    inputBinding:
      position: 101
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress summary report.
    inputBinding:
      position: 101
      prefix: -quiet
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for search results. If none given, output goes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
