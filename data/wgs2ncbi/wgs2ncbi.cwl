cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgs2ncbi
label: wgs2ncbi
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log. No arguments could be parsed from the input.\n
  \nTool homepage: https://github.com/naturalis/wgs2ncbi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
stdout: wgs2ncbi.out
