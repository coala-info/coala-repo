cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - astalavista
  - -t
  - sortGTF
label: astalavista_sortgtf
doc: "Sort a GTF file. If no output file is specified, result is printed to standard
  out.\n\nTool homepage: https://github.com/divyavewall/astalavista-frontend"
inputs:
  - id: input_gtf
    type: File
    doc: The GTF file to be sorted.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Disable interactivity. No questions will be asked
    inputBinding:
      position: 102
      prefix: --force
  - id: log_level
    type:
      - 'null'
      - string
    doc: Log level (NONE|INFO|ERROR|DEBUG)
    inputBinding:
      position: 102
      prefix: --log
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for the sorted GTF. If not specified, result is printed to 
      standard out.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astalavista:4.0--0
