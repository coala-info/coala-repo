cwlVersion: v1.2
class: CommandLineTool
baseCommand: whatshap learn
label: whatshap_learn
doc: "Generate sequencing technology specific error profiles\n\nTool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: bam
    type: File
    doc: Read alignments
    inputBinding:
      position: 1
  - id: vcf
    type: File
    doc: List of variants
    inputBinding:
      position: 2
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 103
      prefix: --kmer
  - id: reference
    type: File
    doc: Reference genome
    inputBinding:
      position: 103
      prefix: --reference
  - id: window
    type:
      - 'null'
      - int
    doc: Ignore this many bases on the left and right of each variant position
    inputBinding:
      position: 103
      prefix: --window
outputs:
  - id: output
    type: File
    doc: Output file with kmer-pair counts
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
