cwlVersion: v1.2
class: CommandLineTool
baseCommand: netSplit
label: ucsc-netsplit
doc: "Split a genome net file into chromosome net files\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_net
    type: File
    doc: Input genome net file
    inputBinding:
      position: 1
  - id: out_dir
    type: string
    doc: Output directory that receives one net file per chromosome
    inputBinding:
      position: 2
outputs:
  - id: output_directory
    type: Directory
    doc: The directory with the split chromosome net files
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-netsplit:482--h0b57e2e_0
