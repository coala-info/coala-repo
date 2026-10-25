cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPosTarget
label: ucsc-pslpostarget
doc: "flip psl strands so target is positive and implicit\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: "Input PSL file."
    inputBinding:
      position: 1
  - id: out_psl
    type: string
    doc: "Output PSL file name."
    inputBinding:
      position: 2
outputs:
  - id: out_file
    type: File
    doc: "PSL with positive target strand."
    outputBinding:
      glob: $(inputs.out_psl)
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpostarget:482--h0b57e2e_0
stderr: ucsc-pslpostarget.err
