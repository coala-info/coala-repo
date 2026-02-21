cwlVersion: v1.2
class: CommandLineTool
baseCommand: mist_typing
label: mist_typing
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool 'mist_typing'.\n
  \nTool homepage: https://github.com/BioinformaticsPlatformWIV-ISP/MiST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mist_typing:1.1.0--pyhdfd78af_0
stdout: mist_typing.out
