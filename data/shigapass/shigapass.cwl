cwlVersion: v1.2
class: CommandLineTool
baseCommand: shigapass
label: shigapass
doc: "The provided text is an error log from a container build process (Singularity/Apptainer)
  and does not contain the help text or usage instructions for the tool 'shigapass'.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/imanyass/ShigaPass/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shigapass:1.5.0--hdfd78af_0
stdout: shigapass.out
