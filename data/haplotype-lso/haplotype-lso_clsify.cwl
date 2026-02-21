cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplotype-lso_clsify
label: haplotype-lso_clsify
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/holtgrewe/haplotype-lso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
stdout: haplotype-lso_clsify.out
