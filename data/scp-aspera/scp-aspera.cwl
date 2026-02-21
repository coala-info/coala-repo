cwlVersion: v1.2
class: CommandLineTool
baseCommand: scp-aspera
label: scp-aspera
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a log of a failed execution or container build process.\n
  \nTool homepage: https://github.com/phnmnl/container-scp-aspera"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/scp-aspera:phenomenal-v3.7.2_cv0.3.16
stdout: scp-aspera.out
