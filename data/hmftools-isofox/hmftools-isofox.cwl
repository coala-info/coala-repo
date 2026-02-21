cwlVersion: v1.2
class: CommandLineTool
baseCommand: isofox
label: hmftools-isofox
doc: "Isofox is a tool for transcript quantification and fusion detection. (Note:
  The provided help text contains only container runtime error messages and does not
  list command-line arguments.)\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/isofox"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-isofox:1.7.2--hdfd78af_1
stdout: hmftools-isofox.out
