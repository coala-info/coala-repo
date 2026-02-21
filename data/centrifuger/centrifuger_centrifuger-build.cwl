cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuger-build
label: centrifuger_centrifuger-build
doc: "The provided text does not contain help information for centrifuger-build, but
  appears to be an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure.\n\nTool homepage: https://github.com/mourisl/centrifuger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuger:1.0.12--h077b44d_0
stdout: centrifuger_centrifuger-build.out
