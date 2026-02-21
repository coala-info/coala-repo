cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqwin_build
label: seqwin_build
doc: "Build a sequence window index or database. (Note: The provided text contains
  execution logs and error messages rather than standard help documentation; therefore,
  no command-line arguments could be extracted.)\n\nTool homepage: https://github.com/treangenlab/seqwin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqwin:0.2.1--pyhdfd78af_0
stdout: seqwin_build.out
