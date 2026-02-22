cwlVersion: v1.2
class: CommandLineTool
baseCommand: corneto
label: corneto
doc: "The provided text does not contain help information or argument definitions
  for the tool 'corneto'. It appears to be an error log from a container runtime (Singularity/Apptainer)
  attempting to build a SIF image from a Docker URI.\n\nTool homepage: https://github.com/saezlab/corneto/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/corneto:1.0.0a0--pyhdfd78af_0
stdout: corneto.out
