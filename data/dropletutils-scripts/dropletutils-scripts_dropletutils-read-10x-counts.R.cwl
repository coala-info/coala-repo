cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropletutils-read-10x-counts.R
label: dropletutils-scripts_dropletutils-read-10x-counts.R
doc: "The provided text does not contain help documentation for the tool; it contains
  container runtime error messages regarding disk space and image conversion.\n\n
  Tool homepage: https://github.com/ebi-gene-expression-group/dropletutils-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropletutils-scripts:0.0.5--hdfd78af_1
stdout: dropletutils-scripts_dropletutils-read-10x-counts.R.out
