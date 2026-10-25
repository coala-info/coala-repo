cwlVersion: v1.2
class: CommandLineTool
baseCommand: linesToRa
label: ucsc-linestora_linesToRa
doc: "Generate .ra format from lines with pipe-separated fields\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: in_txt
    type: File
    doc: Input text file, one record per line with pipe-separated fields
    inputBinding:
      position: 1
  - id: out_ra
    type: string
    doc: Output .ra file name
    inputBinding:
      position: 2
outputs:
  - id: out_out_ra
    type: File
    doc: Output .ra file
    outputBinding:
      glob: $(inputs.out_ra)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-linestora:482--h0b57e2e_0
