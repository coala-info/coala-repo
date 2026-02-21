cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioblend
label: bioblend
doc: "The provided text is a system error log from a container build process (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions for the bioblend
  tool.\n\nTool homepage: https://github.com/galaxyproject/bioblend"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioblend:1.7.0--pyhdfd78af_0
stdout: bioblend.out
