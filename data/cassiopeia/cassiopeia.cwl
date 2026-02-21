cwlVersion: v1.2
class: CommandLineTool
baseCommand: cassiopeia
label: cassiopeia
doc: "Cassiopeia is a toolkit for single-cell lineage reconstruction. (Note: The provided
  text is a system error log and does not contain CLI help information; arguments
  could not be extracted from the input.)\n\nTool homepage: https://github.com/YosefLab/Cassiopeia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cassiopeia:2.0.0--py311h93dcfea_2
stdout: cassiopeia.out
