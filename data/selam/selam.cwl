cwlVersion: v1.2
class: CommandLineTool
baseCommand: selam
label: selam
doc: "The provided text does not contain help information or usage instructions for
  the tool 'selam'. It appears to be an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure.\n\nTool homepage: https://github.com/russcd/SELAM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selam:0.9--h3053a90_4
stdout: selam.out
