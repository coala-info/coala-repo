cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmerstream
label: kmerstream
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to pull or build a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/pmelsted/KmerStream"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
stdout: kmerstream.out
