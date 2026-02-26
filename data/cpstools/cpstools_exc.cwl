cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools exc
label: cpstools_exc
doc: "Extracts gene sequences from a reference genbank file.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: gene_name
    type: string
    doc: Input path of reference genbank file
    inputBinding:
      position: 101
      prefix: --gene_name
  - id: input_file
    type: File
    doc: Input path of reference genbank file
    inputBinding:
      position: 101
      prefix: --input_file
  - id: ref_file
    type: File
    doc: Input path of reference genbank file
    inputBinding:
      position: 101
      prefix: --ref_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_exc.out
