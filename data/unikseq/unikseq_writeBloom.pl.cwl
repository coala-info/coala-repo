cwlVersion: v1.2
class: CommandLineTool
baseCommand: writeBloom.pl
label: unikseq_writeBloom.pl
doc: "Writes a bloom filter from sequences.\n\nTool homepage: https://github.com/bcgsc/unikseq"
inputs:
  - id: kmer_value
    type:
      - 'null'
      - int
    doc: k-mer value (default -k 25, optional)
    inputBinding:
      position: 101
      prefix: -k
  - id: false_positive_rate
    type:
      - 'null'
      - float
    doc: Bloom filter false positive rate (default -p 0.001, optional - increase to prevent memory allocation errors)
    inputBinding:
      position: 101
      prefix: -p
  - id: sequences
    type: File
    doc: sequences to scaffold (Multi-FASTA format, required)
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: bloom_filter
    type:
      - 'null'
      - type: array
        items: File
    outputBinding:
      glob: '*.bloom'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sequences)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikseq:2.0.1--hdfd78af_0
stdout: unikseq_writeBloom.pl.out
