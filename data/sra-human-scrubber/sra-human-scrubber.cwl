cwlVersion: v1.2
class: CommandLineTool
baseCommand: sra-human-scrubber
label: sra-human-scrubber
doc: "SRA Human Scrubber (Note: The provided text contains container build logs and
  error messages rather than tool help text; no arguments could be extracted from
  the input).\n\nTool homepage: https://github.com/ncbi/sra-human-scrubber"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-human-scrubber:2.2.1--hdfd78af_0
stdout: sra-human-scrubber.out
