cwlVersion: v1.2
class: CommandLineTool
baseCommand: malva-geno
label: malva_malva-geno
doc: "Top notch description of this tool\n\nTool homepage: https://algolab.github.io/malva/"
inputs:
  - id: reference_fa
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: variants_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 2
  - id: kmc_output_prefix
    type: string
    doc: Prefix for KMC output files
    inputBinding:
      position: 3
  - id: bf_size
    type:
      - 'null'
      - int
    doc: bloom filter size in GB
    default: 4
    inputBinding:
      position: 104
      prefix: --bf-size
  - id: error_rate
    type:
      - 'null'
      - float
    doc: expected sample error rate
    default: 0.001
    inputBinding:
      position: 104
      prefix: --error-rate
  - id: freq_key
    type:
      - 'null'
      - string
    doc: a priori frequency key in the INFO column of the input VCF
    default: AF
    inputBinding:
      position: 104
      prefix: --freq-key
  - id: haploid
    type:
      - 'null'
      - boolean
    doc: run MALVA in haploid mode
    default: false
    inputBinding:
      position: 104
      prefix: --haploid
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of the kmers to index
    default: 35
    inputBinding:
      position: 104
      prefix: --kmer-size
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: maximum coverage for variant alleles
    default: 200
    inputBinding:
      position: 104
      prefix: --max-coverage
  - id: ref_kmer_size
    type:
      - 'null'
      - int
    doc: size of the reference kmers to index
    default: 43
    inputBinding:
      position: 104
      prefix: --ref-kmer-size
  - id: samples
    type:
      - 'null'
      - File
    doc: file containing the list of (VCF) samples to consider
    default: '-'
    inputBinding:
      position: 104
      prefix: --samples
  - id: strip_chr
    type:
      - 'null'
      - boolean
    doc: strip "chr" from sequence names
    default: false
    inputBinding:
      position: 104
      prefix: --strip-chr
  - id: uniform
    type:
      - 'null'
      - boolean
    doc: use uniform a priori probabilities
    default: false
    inputBinding:
      position: 104
      prefix: --uniform
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: output COVS and GTS in INFO column
    default: false
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malva:2.0.0--h7071971_4
stdout: malva_malva-geno.out
