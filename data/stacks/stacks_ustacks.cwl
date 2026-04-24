cwlVersion: v1.2
class: CommandLineTool
baseCommand: ustacks
label: stacks_ustacks
doc: "ustacks -f in_path -o out_path [-M max_dist] [-m min_reads] [-t num_threads]\n\
  \nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: chi square significance level required to call a heterozygote or 
      homozygote, either 0.1, 0.05 (default), 0.01, or 0.001.
    inputBinding:
      position: 101
  - id: bc_err_freq
    type:
      - 'null'
      - float
    doc: specify the barcode error frequency, between 0 and 1.0.
    inputBinding:
      position: 101
  - id: bound_high
    type:
      - 'null'
      - float
    doc: upper bound for epsilon, the error rate, between 0 and 1.0
    inputBinding:
      position: 101
  - id: bound_low
    type:
      - 'null'
      - float
    doc: lower bound for epsilon, the error rate, between 0 and 1.0
    inputBinding:
      position: 101
  - id: deleverage
    type:
      - 'null'
      - boolean
    doc: enable the Deleveraging algorithm, used for resolving over merged tags.
    inputBinding:
      position: 101
  - id: disable_gapped
    type:
      - 'null'
      - boolean
    doc: 'do not preform gapped alignments between stacks (default: gapped alignements
      enabled).'
    inputBinding:
      position: 101
  - id: disable_haplotype_calling
    type:
      - 'null'
      - boolean
    doc: disable calling haplotypes from secondary reads.
    inputBinding:
      position: 101
      prefix: -H
  - id: force_diff_len
    type:
      - 'null'
      - boolean
    doc: 'allow raw input reads of different lengths, e.g. after trimming (default:
      ustacks perfers raw input reads of uniform length).'
    inputBinding:
      position: 101
  - id: high_cov_thres
    type:
      - 'null'
      - float
    doc: highly-repetitive stacks threshold, in standard deviation units
    inputBinding:
      position: 101
      prefix: --high-cov-thres
  - id: input_file
    type: File
    doc: input file path.
    inputBinding:
      position: 101
      prefix: --file
  - id: input_type
    type:
      - 'null'
      - string
    doc: 'input file type. Supported types: fasta, fastq, gzfasta, or gzfastq (default:
      guess).'
    inputBinding:
      position: 101
      prefix: --in-type
  - id: k_len
    type:
      - 'null'
      - int
    doc: specify k-mer size for matching between alleles and loci (automatically
      calculated by default).
    inputBinding:
      position: 101
  - id: keep_high_cov
    type:
      - 'null'
      - boolean
    doc: disable the algorithm that removes highly-repetitive stacks and nearby 
      errors.
    inputBinding:
      position: 101
  - id: max_dist
    type:
      - 'null'
      - int
    doc: Maximum distance (in nucleotides) allowed between stacks
    inputBinding:
      position: 101
      prefix: -M
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: number of gaps allowed between stacks before merging
    inputBinding:
      position: 101
  - id: max_locus_stacks
    type:
      - 'null'
      - int
    doc: maximum number of stacks at a single de novo locus
    inputBinding:
      position: 101
  - id: max_secondary_align_dist
    type:
      - 'null'
      - int
    doc: Maximum distance allowed to align secondary reads to primary stacks
    inputBinding:
      position: 101
      prefix: -N
  - id: min_aln_len
    type:
      - 'null'
      - float
    doc: minimum length of aligned sequence in a gapped alignment
    inputBinding:
      position: 101
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads to seed a new stack
    inputBinding:
      position: 101
      prefix: -m
  - id: model_type
    type:
      - 'null'
      - string
    doc: either 'snp' (default), 'bounded', or 'fixed'
    inputBinding:
      position: 101
  - id: num_threads
    type:
      - 'null'
      - int
    doc: enable parallel execution with num_threads threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: retain_unused_reads
    type:
      - 'null'
      - boolean
    doc: retain unused reads.
    inputBinding:
      position: 101
      prefix: -R
  - id: sample_name
    type:
      - 'null'
      - string
    doc: 'a name for the sample (default: input file name minus the suffix).'
    inputBinding:
      position: 101
      prefix: --name
outputs:
  - id: out_path
    type: Directory
    doc: output path to write results.
    outputBinding:
      glob: $(inputs.out_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
