cwlVersion: v1.2
class: CommandLineTool
baseCommand: transposonPSI.pl
label: transposonpsi
doc: "TransposonPSI is a tool used to identify transposable elements in genomic sequences
  (nucleotide) or protein sequences by searching against a database of transposon-specific
  profiles.\n\nTool homepage: http://transposonpsi.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transposonpsi:1.0.0--hdfd78af_3
stdout: transposonpsi.out
