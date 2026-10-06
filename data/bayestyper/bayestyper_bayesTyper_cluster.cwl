cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bayesTyper, cluster]
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.kmer_files)
label: bayestyper_bayesTyper_cluster
doc: "BayesTyper cluster: create variant clusters\n\nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
inputs:
  - id: variant_file
    type: File
    doc: variant file (vcf format)
    inputBinding:
      position: 1
      prefix: -v
  - id: samples_file
    type: File
    doc: samples file (<sample_id> <sex> <kmc_output_prefix> per line, no header)
    inputBinding:
      position: 1
      prefix: -s
  - id: kmer_files
    type:
      - 'null'
      - File[]
    doc: KMC3 tables and bloom filters (<prefix>.kmc_pre, .kmc_suf, .bloomMeta, .bloomData) named in the
      samples file; staged in the working directory so the samples file can name them by basename
  - id: genome_file
    type: File
    doc: reference genome file (fasta format)
    inputBinding:
      position: 1
      prefix: -g
  - id: decoy_file
    type:
      - 'null'
      - File
    doc: decoy sequences file (fasta format)
    inputBinding:
      position: 1
      prefix: -d
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 1
      prefix: -o
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'seed for pseudo-random number generator (default: unix time)'
    inputBinding:
      position: 1
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads used (+= 2 I/O threads) (default: 1)'
    inputBinding:
      position: 1
      prefix: -p
  - id: min_number_of_unit_variants
    type:
      - 'null'
      - int
    doc: 'minimum number of variants per inference unit (default: 5000000)'
    inputBinding:
      position: 1
      prefix: -u
  - id: max_allele_length
    type:
      - 'null'
      - int
    doc: 'exclude alleles (reference and alternative) longer than <length> (default: 500000)'
    inputBinding:
      position: 1
      prefix: --max-allele-length
  - id: copy_number_variant_threshold
    type:
      - 'null'
      - float
    doc: 'minimum fraction of identical kmers required between an allele and the downstream reference
      sequence to classify it as a copy number (default: 0.5)'
    inputBinding:
      position: 1
      prefix: --copy-number-variant-threshold
  - id: max_number_of_sample_haplotypes
    type:
      - 'null'
      - int
    doc: 'maximum number of haplotype candidates per sample (default: 32)'
    inputBinding:
      position: 1
      prefix: --max-number-of-sample-haplotypes
outputs:
  - id: units
    type: Directory[]
    doc: Inference unit directories, each with variant_clusters.bin
    outputBinding:
      glob: $(inputs.output_prefix || 'bayestyper')_unit_*
  - id: cluster_data
    type: Directory
    doc: Cluster data directory used by bayesTyper genotype
    outputBinding:
      glob: $(inputs.output_prefix || 'bayestyper')_cluster_data
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
