cwlVersion: v1.2
class: CommandLineTool
baseCommand: peak-motifs
label: rsat-core_peak-motifs
doc: "The provided text does not contain help information or documentation for the
  tool; it contains container runtime error logs. No arguments could be extracted.\n
  \nTool homepage: http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_peak-motifs.out
