cwlVersion: v1.2
class: CommandLineTool
baseCommand: deeparg
label: deeparg
doc: "Deep learning based Antibiotic Resistance Genes (ARG) annotation tool\n\nTool
  homepage: https://bitbucket.org/gusphdproj/deeparg-ss/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeparg:1.0.4--pyhdfd78af_0
stdout: deeparg.out
