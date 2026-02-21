cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastagap
label: fastagap
doc: "The provided text contains system error messages from a container runtime (Apptainer/Singularity)
  and does not include the actual help documentation or usage instructions for the
  tool 'fastagap'.\n\nTool homepage: https://github.com/nylander/fastagap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastagap:1.0.1--hdfd78af_0
stdout: fastagap.out
