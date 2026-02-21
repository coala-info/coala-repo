cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqhax
label: seqhax
doc: "A tool for processing sequencing data (Note: The provided text contains only
  system error logs and no help information; arguments could not be extracted).\n\n
  Tool homepage: https://github.com/kdmurray91/seqhax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdout: seqhax.out
