cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp2cell
label: snp2cell
doc: "The provided text is a container execution error log and does not contain help
  information or usage instructions for the tool. As a result, no arguments could
  be extracted.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
stdout: snp2cell.out
