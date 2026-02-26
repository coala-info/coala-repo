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
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    outputBinding:
      glob: $(inputs.output_directory)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
