cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCheck
label: ucsc-bedtopsl_pslCheck
doc: "Check PSL files for correctness.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_file
    type: File
    doc: The PSL file to check.
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level (default 1).
    default: 1
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Write problems to specified file.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtopsl:482--h0b57e2e_0
