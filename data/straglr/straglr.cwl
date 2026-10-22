cwlVersion: v1.2
class: CommandLineTool
baseCommand: straglr.py
label: straglr
doc: "A tool for Short Tandem Repeat (STR) detection and genotyping using long-read
  sequencing data (PacBio or Oxford Nanopore).\n\nTool homepage: https://github.com/bcgsc/straglr"
inputs:
  - id: input_bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    doc: bam file
    inputBinding:
      position: 1
  - id: reference
    type: File
    secondaryFiles:
      - .fai
      - pattern: .gzi
        required: false
    doc: genome_fasta
    inputBinding:
      position: 2
  - id: out_prefix
    type: string
    doc: output prefix
    inputBinding:
      position: 3
  - id: min_ins_size
    type:
      - 'null'
      - int
    doc: "minimum insertion size. Default:100"
    inputBinding:
      position: 103
      prefix: --min_ins_size
  - id: min_str_len
    type:
      - 'null'
      - int
    doc: "minimum STR length. Default:2"
    inputBinding:
      position: 103
      prefix: --min_str_len
  - id: max_str_len
    type:
      - 'null'
      - int
    doc: "maximum STR length. Default:50"
    inputBinding:
      position: 103
      prefix: --max_str_len
  - id: min_support
    type:
      - 'null'
      - int
    doc: "minimum number of supporting reads for detecting expansion. Default:2"
    inputBinding:
      position: 103
      prefix: --min_support
  - id: trf_args
    type:
      - 'null'
      - type: array
        items: int
    doc: "tandem repeat finder arguments (Match Mismatch Delta PM PI Minscore MaxPeriod). Default:2 5 5 80 10 10 500"
    inputBinding:
      position: 103
      prefix: --trf_args
  - id: chroms
    type:
      - 'null'
      - type: array
        items: string
    doc: "chromosomes"
    inputBinding:
      position: 103
      prefix: --chroms
  - id: regions
    type:
      - 'null'
      - File
    doc: "bed file for scanning only specific regions"
    inputBinding:
      position: 103
      prefix: --regions
  - id: exclude
    type:
      - 'null'
      - File
    doc: "bed file to exclude regions"
    inputBinding:
      position: 103
      prefix: --exclude
  - id: include_alt_chroms
    type:
      - 'null'
      - boolean
    doc: "include alternate chromosomes. By default, only chroms 1-22,X,Y are considered in genome scan"
    inputBinding:
      position: 103
      prefix: --include_alt_chroms
  - id: max_cov
    type:
      - 'null'
      - int
    doc: "maximum allowed coverage for ins inspection. Default:100"
    inputBinding:
      position: 103
      prefix: --max_cov
  - id: use_unpaired_clips
    type:
      - 'null'
      - boolean
    doc: "also examine unpaired clipped alignments in genome scan"
    inputBinding:
      position: 103
      prefix: --use_unpaired_clips
  - id: loci
    type:
      - 'null'
      - File
    doc: "bed file of loci for genotyping"
    inputBinding:
      position: 103
      prefix: --loci
  - id: genotype_in_size
    type:
      - 'null'
      - boolean
    doc: "report genotype in size instead of copy numbers"
    inputBinding:
      position: 103
      prefix: --genotype_in_size
  - id: include_partials
    type:
      - 'null'
      - boolean
    doc: "detect and report reads only capturing partial repeats when genotyping"
    inputBinding:
      position: 103
      prefix: --include_partials
  - id: use_mean
    type:
      - 'null'
      - boolean
    doc: "use mean instead of median cluster value for defining allele"
    inputBinding:
      position: 103
      prefix: --use_mean
  - id: flank_size
    type:
      - 'null'
      - int
    doc: "flanking sequence length to add to loci when genotyping. Default:80"
    inputBinding:
      position: 103
      prefix: --flank_size
  - id: sample
    type:
      - 'null'
      - string
    doc: "sample name for VCF output"
    inputBinding:
      position: 103
      prefix: --sample
  - id: sex
    type:
      - 'null'
      - string
    doc: "sex, m(ale) or f(emale)"
    inputBinding:
      position: 103
      prefix: --sex
  - id: reads_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: "read indexed fasta file(s)"
    inputBinding:
      position: 103
      prefix: --reads_fasta
  - id: nprocs
    type:
      - 'null'
      - int
    doc: "number of processes"
    inputBinding:
      position: 103
      prefix: --nprocs
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: "directory to use for generating tmp files instead of system TEMP"
    inputBinding:
      position: 103
      prefix: --tmpdir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "debug mode i.e. keep trf output"
    inputBinding:
      position: 103
      prefix: --debug
  - id: min_cluster_size
    type:
      - 'null'
      - float
    doc: "minimum number or fraction of supporting reads for allele clustering. Default:0.1"
    inputBinding:
      position: 103
      prefix: --min_cluster_size
  - id: max_num_clusters
    type:
      - 'null'
      - int
    doc: "maximum number of clusters to try. Default:2"
    inputBinding:
      position: 103
      prefix: --max_num_clusters
  - id: max_check_size
    type:
      - 'null'
      - int
    doc: "threshold of cluster (allele) size (median/mean) to skip filtering by --min_cluster_size. Default:5000"
    inputBinding:
      position: 103
      prefix: --max_check_size
  - id: min_cluster_d
    type:
      - 'null'
      - int
    doc: "minimum separation between clusters. Default:10"
    inputBinding:
      position: 103
      prefix: --min_cluster_d
  - id: max_bad_cluster_size
    type:
      - 'null'
      - int
    doc: "maximum cluster size for checking quality. Default:5"
    inputBinding:
      position: 103
      prefix: --max_bad_cluster_size
outputs:
  - id: tsv
    type:
      - 'null'
      - File
    doc: per-read results
    outputBinding:
      glob: $(inputs.out_prefix).tsv
  - id: bed
    type:
      - 'null'
      - File
    doc: loci summary in bed format
    outputBinding:
      glob: $(inputs.out_prefix).bed
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF output
    outputBinding:
      glob: $(inputs.out_prefix).vcf
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/straglr:1.5.6--pyhdfd78af_0
