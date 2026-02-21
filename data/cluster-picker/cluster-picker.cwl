cwlVersion: v1.2
class: CommandLineTool
baseCommand: cluster-picker
label: cluster-picker
doc: "A tool for picking clusters (description not available in provided text)\n\n
  Tool homepage: https://github.com/niemasd/ClusterPickerII"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cluster-picker:1.2.3--0
stdout: cluster-picker.out
