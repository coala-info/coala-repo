cwlVersion: v1.2
class: CommandLineTool
baseCommand: refseq-plasmid-dl
label: refseq-plasmid-dl
doc: "A tool for downloading RefSeq plasmid sequences. (Note: The provided text contained
  container build logs rather than help documentation; no arguments could be extracted
  from the source text.)\n\nTool homepage: https://github.com/erinyoung/refseq-plasmid-dl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refseq-plasmid-dl:0.1.0--pyhdfd78af_0
stdout: refseq-plasmid-dl.out
