cwlVersion: v1.2
class: CommandLineTool
baseCommand: kegalign-full_faToTwoBit
label: kegalign-full_faToTwoBit
doc: "Convert FASTA files to 2bit format. (Note: The provided input text contains
  system error messages rather than the tool's help documentation, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/galaxyproject/KegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
stdout: kegalign-full_faToTwoBit.out
