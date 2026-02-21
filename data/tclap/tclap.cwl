cwlVersion: v1.2
class: CommandLineTool
baseCommand: tclap
label: tclap
doc: "The provided text does not contain help information or usage instructions for
  the tool 'tclap'. It appears to be a log of a failed container build/fetch process
  using Apptainer/Singularity.\n\nTool homepage: https://github.com/mirror/tclap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tclap:1.2.1--0
stdout: tclap.out
