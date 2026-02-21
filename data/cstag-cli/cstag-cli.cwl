cwlVersion: v1.2
class: CommandLineTool
baseCommand: cstag-cli
label: cstag-cli
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure.\n\nTool homepage: https://github.com/akikuno/cstag-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cstag-cli:1.0.0--pyhdfd78af_1
stdout: cstag-cli.out
