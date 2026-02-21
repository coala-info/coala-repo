cwlVersion: v1.2
class: CommandLineTool
baseCommand: carp
label: carp
doc: "The provided text does not contain help information or usage instructions for
  the tool 'carp'. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/gi-bielefeld/scj-carp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carp:0.1.1--h4349ce8_0
stdout: carp.out
