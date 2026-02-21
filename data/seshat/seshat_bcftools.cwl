cwlVersion: v1.2
class: CommandLineTool
baseCommand: seshat_bcftools
label: seshat_bcftools
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failed container build due to insufficient disk space ('no
  space left on device').\n\nTool homepage: https://github.com/clintval/tp53"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
stdout: seshat_bcftools.out
