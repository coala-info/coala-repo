cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCheck
label: ucsc-pslcheck
doc: "Check PSL files for validity and format compliance.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_file
    type: File
    doc: The PSL file to be checked.
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all output except errors.
    inputBinding:
      position: 102
      prefix: -quiet
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level.
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Write valid PSLs to this file.
    outputBinding:
      glob: $(inputs.out)
  - id: err
    type:
      - 'null'
      - File
    doc: Write invalid PSLs to this file.
    outputBinding:
      glob: $(inputs.err)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslcheck:482--h0b57e2e_0
