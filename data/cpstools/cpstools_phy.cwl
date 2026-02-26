cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools phy
label: cpstools_phy
doc: "Phylogenetic analysis tools\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: input_dir
    type: Directory
    doc: Input the directory of genbank files
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: mode
    type: string
    doc: 'Mode: cds for common cds sequences; pro for common protein sequences'
    inputBinding:
      position: 101
      prefix: --mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_phy.out
