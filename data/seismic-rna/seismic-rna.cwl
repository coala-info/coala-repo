cwlVersion: v1.2
class: CommandLineTool
baseCommand: seismic-rna
label: seismic-rna
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or usage instructions for the seismic-rna tool. As a
  result, no arguments could be extracted.\n\nTool homepage: https://github.com/rouskinlab/seismic-rna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
stdout: seismic-rna.out
