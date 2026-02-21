cwlVersion: v1.2
class: CommandLineTool
baseCommand: neptune
label: neptune-signature_neptune
doc: "Neptune is a tool for signature discovery in genomic sequences. Note: The provided
  input text appears to be a container execution error log rather than help text,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/phac-nml/neptune"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neptune-signature:2.0.0--pyhdfd78af_0
stdout: neptune-signature_neptune.out
