cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylogenize
label: phylogenize
doc: "Phylogenize is a tool for phylogenetic analysis. (Note: The provided text contains
  system error logs regarding disk space and container conversion rather than command-line
  help documentation; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/pbradleylab/phylogenize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylogenize:2.0a0--pl5321r41hdfd78af_0
stdout: phylogenize.out
