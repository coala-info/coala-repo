cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastToPsl
label: ucsc-blasttopsl
doc: "Convert BLAST output to PSL format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: blast_input
    type: File
    doc: Input BLAST file
    inputBinding:
      position: 1
outputs:
  - id: psl_output
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-blasttopsl:482--h0b57e2e_0
