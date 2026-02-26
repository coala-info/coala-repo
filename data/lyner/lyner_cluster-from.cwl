cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - cluster-from
label: lyner_cluster-from
doc: "Cluster sequences from a file.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: file
    type: File
    doc: Input file containing sequences to cluster.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_cluster-from.out
