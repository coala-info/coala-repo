cwlVersion: v1.2
class: CommandLineTool
baseCommand: kssd shuffle
label: kssd_shuffle
doc: "The shuffle doc prefix.\n\nTool homepage: https://github.com/yhg926/public_kssd"
inputs:
  - id: half_kmer_len
    type:
      - 'null'
      - int
    doc: "a half of the length of k-mer. For proyakat\ngenome, k = 8 is suggested;
      for mammals, k = 10 or\n11 is suggested."
    inputBinding:
      position: 101
      prefix: --halfKmerLen
  - id: half_substr_len
    type:
      - 'null'
      - int
    doc: a half of the length of k-mer substring.
    inputBinding:
      position: 101
      prefix: --halfSubstrLen
  - id: level
    type:
      - 'null'
      - int
    doc: "the level of dimensionality reduction, the\nexpectation dimensionality reduction
      rate is 16^n\nif set -l = n."
    inputBinding:
      position: 101
      prefix: --level
  - id: outfile
    type:
      - 'null'
      - string
    doc: "specify the output file name prefix, if not\nspecify default shuffle named
      'default.shuf\ngenerated'"
    inputBinding:
      position: 101
      prefix: --outfile
  - id: use_default
    type:
      - 'null'
      - boolean
    doc: "All options use default value, which assuming\nprokaryote genomes, k=8,
      s=5, and l=2."
    inputBinding:
      position: 101
      prefix: --usedefault
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kssd:2.21--h577a1d6_3
stdout: kssd_shuffle.out
