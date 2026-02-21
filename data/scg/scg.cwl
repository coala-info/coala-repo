cwlVersion: v1.2
class: CommandLineTool
baseCommand: scg
label: scg
doc: "The provided text does not contain help information or usage instructions for
  the tool 'scg'. It appears to be a log of a failed container build/fetch process
  using Apptainer/Singularity.\n\nTool homepage: https://bitbucket.org/aroth85/scg/wiki/Home"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scg:0.3.1--py27_0
stdout: scg.out
