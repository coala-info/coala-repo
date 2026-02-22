cwlVersion: v1.2
class: CommandLineTool
baseCommand: constax
label: constax
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a Singularity/Docker container execution
  failure (no space left on device).\n\nTool homepage: https://github.com/liberjul/CONSTAXv2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/constax:2.0.20--pyhdfd78af_0
stdout: constax.out
