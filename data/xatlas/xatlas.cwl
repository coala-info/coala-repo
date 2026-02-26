cwlVersion: v1.2
class: CommandLineTool
baseCommand: xatlas
label: xatlas
doc: "v0.3\n\nTool homepage: https://github.com/jfarek/xatlas"
inputs:
  - id: bgzf
    type:
      - 'null'
      - boolean
    doc: Write output in bgzip-compressed VCF format
    inputBinding:
      position: 101
      prefix: --bgzf
  - id: block_abs_lim
    type:
      - 'null'
      - string
    doc: gVCF non-variant block absolute range limit
    inputBinding:
      position: 101
      prefix: --block-abs-lim
  - id: block_rel_lim
    type:
      - 'null'
      - string
    doc: gVCF non-variant block relative range limit coefficient
    inputBinding:
      position: 101
      prefix: --block-rel-lim
  - id: capture_bed
    type:
      - 'null'
      - File
    doc: BED file of regions to process
    inputBinding:
      position: 101
      prefix: --capture-bed
  - id: enable_strand_filter
    type:
      - 'null'
      - boolean
    doc: Enable SNP filter for single-strandedness
    inputBinding:
      position: 101
      prefix: --enable-strand-filter
  - id: gvcf
    type:
      - 'null'
      - boolean
    doc: Include non-variant gVCF blocks in output VCF file
    inputBinding:
      position: 101
      prefix: --gvcf
  - id: in
    type: File
    doc: Sorted and indexed input BAM or CRAM file
    inputBinding:
      position: 101
      prefix: --in
  - id: indel_logit_params
    type:
      - 'null'
      - File
    doc: File with intercept and coefficients for indel logit model
    inputBinding:
      position: 101
      prefix: --indel-logit-params
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: High variant coverage cutoff for filtering variants
    inputBinding:
      position: 101
      prefix: --max-coverage
  - id: min_indel_mapq
    type:
      - 'null'
      - int
    doc: Minimum read mapping quality for calling indels
    inputBinding:
      position: 101
      prefix: --min-indel-mapq
  - id: min_p_value
    type:
      - 'null'
      - boolean
    doc: Minimum logit P-value to report variants
    inputBinding:
      position: 101
      prefix: --min-p-value
  - id: min_snp_mapq
    type:
      - 'null'
      - int
    doc: Minimum read mapping quality for calling SNPs
    inputBinding:
      position: 101
      prefix: --min-snp-mapq
  - id: multithread
    type:
      - 'null'
      - boolean
    doc: Read alignment file and process records in separate threads
    inputBinding:
      position: 101
      prefix: --multithread
  - id: num_hts_threads
    type:
      - 'null'
      - int
    doc: Number of HTSlib decompression threads to spawn
    inputBinding:
      position: 101
      prefix: --num-hts-threads
  - id: prefix
    type: string
    doc: Output VCF file prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ref
    type: File
    doc: Reference genome in FASTA format
    inputBinding:
      position: 101
      prefix: --ref
  - id: sample_name
    type: string
    doc: Sample name to use in the output VCF file
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: snp_logit_params
    type:
      - 'null'
      - File
    doc: File with intercept and coefficients for SNP logit model
    inputBinding:
      position: 101
      prefix: --snp-logit-params
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xatlas:0.3--he565470_0
stdout: xatlas.out
