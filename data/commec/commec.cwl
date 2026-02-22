cwlVersion: v1.2
class: CommandLineTool
baseCommand: commec
label: commec
doc: "The provided text is an error log related to a container runtime (Singularity/Docker)
  failure and does not contain the help text or usage information for the 'commec'
  tool.\n\nTool homepage: https://github.com/ibbis-screening/common-mechanism"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
stdout: commec.out
