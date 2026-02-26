cwlVersion: v1.2
class: CommandLineTool
baseCommand: MALVA
label: malva_MALVA
doc: "MALVA is a tool for variant calling in sequencing data.\n\nTool homepage: https://algolab.github.io/malva/"
inputs:
  - id: reference
    type: File
    doc: reference file in FASTA format
    inputBinding:
      position: 1
  - id: variants
    type: File
    doc: variants file in VCF format
    inputBinding:
      position: 2
  - id: sample
    type: File
    doc: sample file in FASTA/FASTQ format
    inputBinding:
      position: 3
  - id: bloom_filter_size_gb
    type:
      - 'null'
      - int
    doc: bloom filter size in GB
    default: 4
    inputBinding:
      position: 104
      prefix: -b
  - id: expected_error_rate
    type:
      - 'null'
      - float
    doc: expected sample error rate
    default: 0.001
    inputBinding:
      position: 104
      prefix: -e
  - id: freq_key
    type:
      - 'null'
      - string
    doc: a priori frequency key in the INFO column of the input VCF
    default: AF
    inputBinding:
      position: 104
      prefix: -f
  - id: haploid_mode
    type:
      - 'null'
      - boolean
    doc: run MALVA in haploid mode
    default: false
    inputBinding:
      position: 104
      prefix: '-1'
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of the kmers to index
    default: 35
    inputBinding:
      position: 104
      prefix: -k
  - id: max_cov
    type:
      - 'null'
      - int
    doc: maximum coverage for variant alleles
    default: 200
    inputBinding:
      position: 104
      prefix: -c
  - id: max_ram_gb
    type:
      - 'null'
      - int
    doc: max amount of RAM in GB - KMC parameter
    default: 4
    inputBinding:
      position: 104
      prefix: -m
  - id: output_covs_gts
    type:
      - 'null'
      - boolean
    doc: output COVS and GTS in INFO column
    default: false
    inputBinding:
      position: 104
      prefix: -v
  - id: ref_kmer_size
    type:
      - 'null'
      - int
    doc: size of the reference kmers to index
    default: 43
    inputBinding:
      position: 104
      prefix: -r
  - id: sample_list_file
    type:
      - 'null'
      - File
    doc: file containing the list of (VCF) samples to consider (default:-, i.e. 
      all samples)
    default: '-'
    inputBinding:
      position: 104
      prefix: -s
  - id: strip_chr
    type:
      - 'null'
      - boolean
    doc: strip "chr" from sequence names
    default: false
    inputBinding:
      position: 104
      prefix: -p
  - id: uniform_prior
    type:
      - 'null'
      - boolean
    doc: use uniform a priori probabilities
    default: false
    inputBinding:
      position: 104
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malva:2.0.0--h7071971_4
stdout: malva_MALVA.out
