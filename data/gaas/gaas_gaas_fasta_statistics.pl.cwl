cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaas_fasta_statistics.pl
label: gaas_gaas_fasta_statistics.pl
doc: "Get some basic statistics about a nucleotide fasta file. e.g Number of\n   \
  \ sequence, Number of nucleotide, N50, GC-content, etc. It can also create\n   \
  \ R plots about contig size distribution. The plots are performed only if\n    an
  output is given. This script is not designed for AA/Protein\n    sequences.\n\n\
  Tool homepage: https://github.com/NBISweden/GAAS"
inputs:
  - id: infile
    type: File
    doc: Input fasta file containing DNA sequences.
    inputBinding:
      position: 101
      prefix: --f
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: "Output directory where diffrent output files will be\n            written.
      If no output is specified, the result will written to\n            STDOUT."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaas:1.2.0--pl5321r42hdfd78af_1
