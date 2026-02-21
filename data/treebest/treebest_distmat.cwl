cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - distmat
label: treebest_distmat
doc: "Calculate a distance matrix from a sequence alignment using various evolutionary
  models.\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: model
    type: string
    doc: Evolutionary model to use (dn, ds, dm, jtt, kimura, mm, or dns)
    inputBinding:
      position: 1
  - id: alignment
    type: File
    doc: Input alignment file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_distmat.out
