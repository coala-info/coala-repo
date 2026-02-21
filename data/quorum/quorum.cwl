cwlVersion: v1.2
class: CommandLineTool
baseCommand: quorum
label: quorum
doc: "The provided text is a container runtime error log and does not contain the
  help text or usage information for the 'quorum' tool.\n\nTool homepage: https://github.com/Consensys/quorum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/quorum:v1.1.1-2-deb_cv1
stdout: quorum.out
