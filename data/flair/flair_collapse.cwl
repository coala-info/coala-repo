cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flair
  - collapse
label: flair_collapse
doc: "take bed file of corrected reads and generate confident collapsed isoform models\n
  \nTool homepage: https://github.com/BrooksLabUCSC/flair"
inputs:
  - id: allow_paralogs
    type:
      - 'null'
      - boolean
    doc: specify if want to allow reads to be assigned to multiple paralogs with equivalent
      alignment
    inputBinding:
      position: 101
      prefix: --allow_paralogs
  - id: annotated_bed
    type:
      - 'null'
      - File
    doc: annotation_reliant also requires a bedfile of annotated isoforms
    inputBinding:
      position: 101
      prefix: --annotated_bed
  - id: annotation_reliant
    type:
      - 'null'
      - string
    doc: specify transcript fasta that corresponds to transcripts in the gtf to run
      annotation-reliant flair collapse; to ask flair to make transcript sequences
      given the gtf and genome fa, type --annotation_reliant generate
    inputBinding:
      position: 101
      prefix: --annotation_reliant
  - id: check_splice
    type:
      - 'null'
      - boolean
    doc: enforce coverage of 4 out of 6 bp around each splice site and no insertions
      greater than 3 bp at the splice site
    inputBinding:
      position: 101
      prefix: --check_splice
  - id: end_window
    type:
      - 'null'
      - int
    doc: window size for comparing TSS/TES
    default: 100
    inputBinding:
      position: 101
      prefix: --end_window
  - id: filter
    type:
      - 'null'
      - string
    doc: 'Report options include: nosubset, default, comprehensive, ginormous'
    inputBinding:
      position: 101
      prefix: --filter
  - id: fusion_breakpoints
    type:
      - 'null'
      - File
    doc: '[OPTIONAL] fusion detection only - bed file containing locations of fusion
      breakpoints on the synthetic genome'
    inputBinding:
      position: 101
      prefix: --fusion_breakpoints
  - id: gene_tss
    type:
      - 'null'
      - boolean
    doc: when specified, TSS/TES for each isoform will be determined standardized
      at the gene level
    inputBinding:
      position: 101
      prefix: --gene_tss
  - id: generate_map
    type:
      - 'null'
      - boolean
    doc: specify this argument to generate a txt file of read-isoform assignments
    inputBinding:
      position: 101
      prefix: --generate_map
  - id: genome
    type: File
    doc: FastA of reference genome
    inputBinding:
      position: 101
      prefix: --genome
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF annotation file, used for renaming FLAIR isoforms to annotated isoforms
      and adjusting TSS/TESs
    inputBinding:
      position: 101
      prefix: --gtf
  - id: intprimingfracAs
    type:
      - 'null'
      - float
    doc: threshold for fraction of As in sequence near read end to call as internal
      priming
    inputBinding:
      position: 101
      prefix: --intprimingfracAs
  - id: intprimingthreshold
    type:
      - 'null'
      - int
    doc: number of bases that are at least intprimingfracAs% As required to call read
      as internal priming
    inputBinding:
      position: 101
      prefix: --intprimingthreshold
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: specify if intermediate and temporary files are to be kept for debugging
    inputBinding:
      position: 101
      prefix: --keep_intermediate
  - id: longshot_bam
    type:
      - 'null'
      - File
    doc: bam from longshot containing haplotype information for each read
    inputBinding:
      position: 101
      prefix: --longshot_bam
  - id: longshot_vcf
    type:
      - 'null'
      - File
    doc: vcf from longshot
    inputBinding:
      position: 101
      prefix: --longshot_vcf
  - id: max_ends
    type:
      - 'null'
      - int
    doc: maximum number of TSS/TES picked per isoform
    default: 2
    inputBinding:
      position: 101
      prefix: --max_ends
  - id: mm2_args
    type:
      - 'null'
      - string
    doc: additional minimap2 arguments when aligning reads first-pass transcripts;
      separate args by commas
    inputBinding:
      position: 101
      prefix: --mm2_args
  - id: no_gtf_end_adjustment
    type:
      - 'null'
      - boolean
    doc: when specified, TSS/TES from the gtf provided with -f will not be used to
      adjust isoform TSSs/TESs
    inputBinding:
      position: 101
      prefix: --no_gtf_end_adjustment
  - id: no_redundant
    type:
      - 'null'
      - string
    doc: 'For each unique splice junction chain, report options include: none, longest,
      best_only'
    default: none
    inputBinding:
      position: 101
      prefix: --no_redundant
  - id: predict_cds
    type:
      - 'null'
      - boolean
    doc: specify if you want to predict the CDS of the final isoforms
    inputBinding:
      position: 101
      prefix: --predictCDS
  - id: promoters
    type:
      - 'null'
      - File
    doc: promoter regions bed file to identify full-length reads
    inputBinding:
      position: 101
      prefix: --promoters
  - id: quality
    type:
      - 'null'
      - int
    doc: minimum MAPQ of read assignment to an isoform
    default: 0
    inputBinding:
      position: 101
      prefix: --quality
  - id: query
    type: File
    doc: bed file of aligned/corrected reads
    inputBinding:
      position: 101
      prefix: --query
  - id: reads
    type:
      type: array
      items: File
    doc: FastA/FastQ files of raw reads, can specify multiple files
    inputBinding:
      position: 101
      prefix: --reads
  - id: remove_internal_priming
    type:
      - 'null'
      - boolean
    doc: specify if want to remove reads with internal priming
    inputBinding:
      position: 101
      prefix: --remove_internal_priming
  - id: stringent
    type:
      - 'null'
      - boolean
    doc: specify if all supporting reads need to be full-length (80% coverage and
      spanning 25 bp of the first and last exons)
    inputBinding:
      position: 101
      prefix: --stringent
  - id: support
    type:
      - 'null'
      - float
    doc: minimum number of supporting reads for an isoform; if s < 1, it will be treated
      as a percentage of expression of the gene
    default: 3
    inputBinding:
      position: 101
      prefix: --support
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: minimap2 number of threads
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: three_prime_regions
    type:
      - 'null'
      - File
    doc: TES regions bed file to identify full-length reads
    inputBinding:
      position: 101
      prefix: --3prime_regions
  - id: trust_ends
    type:
      - 'null'
      - boolean
    doc: specify if reads are generated from a long read method with minimal fragmentation
    inputBinding:
      position: 101
      prefix: --trust_ends
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file name base for FLAIR isoforms
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
