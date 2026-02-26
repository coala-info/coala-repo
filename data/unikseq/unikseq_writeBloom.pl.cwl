cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikseq_writeBloom.pl
label: unikseq_writeBloom.pl
doc: "Writes a bloom filter from sequences.\n\nTool homepage: https://github.com/bcgsc/unikseq"
inputs:
  - id: kmer_value
    type:
      - 'null'
      - int
    doc: k-mer value (default -k 25, optional)
    default: 25
    inputBinding:
      position: 101
      prefix: -k
  - id: sequences
    type: File
    doc: sequences to scaffold (Multi-FASTA format, required)
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikseq:2.0.1--hdfd78af_0
stdout: unikseq_writeBloom.pl.out
