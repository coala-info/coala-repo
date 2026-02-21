cwlVersion: v1.2
class: CommandLineTool
baseCommand: vadr_fasta-trim-terminal-ambigs.pl
label: vadr_fasta-trim-terminal-ambigs.pl
doc: "A tool from the VADR suite to trim terminal ambiguous characters from sequences
  in a FASTA file.\n\nTool homepage: https://github.com/ncbi/vadr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
stdout: vadr_fasta-trim-terminal-ambigs.pl.out
