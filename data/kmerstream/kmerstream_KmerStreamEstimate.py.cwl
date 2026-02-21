cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmerstream_KmerStreamEstimate.py
label: kmerstream_KmerStreamEstimate.py
doc: "KmerStream estimate tool (Note: The provided text contains system error messages
  and no usage information.)\n\nTool homepage: https://github.com/pmelsted/KmerStream"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
stdout: kmerstream_KmerStreamEstimate.py.out
