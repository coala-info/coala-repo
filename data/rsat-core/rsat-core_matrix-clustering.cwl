cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - matrix-clustering
label: rsat-core_matrix-clustering
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error logs regarding the retrieval of the rsat-core image.\n\n
  Tool homepage: http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_matrix-clustering.out
