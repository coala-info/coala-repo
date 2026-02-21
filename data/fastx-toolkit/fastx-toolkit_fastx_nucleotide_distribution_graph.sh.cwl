cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_nucleotide_distribution_graph.sh
label: fastx-toolkit_fastx_nucleotide_distribution_graph.sh
doc: "A tool from the FASTX-toolkit for generating nucleotide distribution graphs.
  Note: The provided help text contains system error messages and does not list specific
  arguments.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx-toolkit_fastx_nucleotide_distribution_graph.sh.out
