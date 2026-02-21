cwlVersion: v1.2
class: CommandLineTool
baseCommand: sdeper
label: sdeper
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure during the extraction of the OCI
  image.\n\nTool homepage: https://az7jh2.github.io/SDePER/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sdeper:2.0.0--pyhdfd78af_0
stdout: sdeper.out
