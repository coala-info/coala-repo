cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msstitch
  - dedupperco
label: msstitch_dedupperco
doc: "When running dedupperco also remove \"duplicate\" PSMs (by PSM ID plus sequence).
  Keeps first PSM encountered of each PSM ID / sequence combination\n\nTool homepage:
  https://github.com/lehtiolab/msstitch"
inputs:
  - id: include_psms
    type:
      - 'null'
      - boolean
    doc: When running dedupperco also remove "duplicate" PSMs (by PSM ID plus 
      sequence). Keeps first PSM encountered of each PSM ID / sequence 
      combination
    inputBinding:
      position: 101
      prefix: --includepsms
  - id: input_file
    type: File
    doc: Input file of {} format
    inputBinding:
      position: 101
      prefix: -i
  - id: output_directory_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `output_directory_path`
    inputBinding:
      position: 102
      prefix: --output-directory
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    outputBinding:
      glob: $(inputs.output_directory_path)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
