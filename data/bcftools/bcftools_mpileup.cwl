cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - mpileup
label: bcftools_mpileup
doc: "Generate VCF or BCF containing genotype likelihoods for one or multiple BAM
  files\n\nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_bams
    type:
      type: array
      items: File
    doc: Input BAM/CRAM files
    inputBinding:
      position: 1
  - id: adjust_mq
    type:
      - 'null'
      - int
    doc: Adjust mapping quality
    default: 0
    inputBinding:
      position: 102
      prefix: --adjust-MQ
  - id: ambig_reads
    type:
      - 'null'
      - string
    doc: 'What to do with ambiguous indel reads: drop,incAD,incAD0'
    default: drop
    inputBinding:
      position: 102
      prefix: --ambig-reads
  - id: annotate
    type:
      - 'null'
      - string
    doc: Optional tags to output
    inputBinding:
      position: 102
      prefix: --annotate
  - id: bam_list
    type:
      - 'null'
      - File
    doc: List of input BAM filenames, one per line
    inputBinding:
      position: 102
      prefix: --bam-list
  - id: config
    type:
      - 'null'
      - string
    doc: Specify platform profile
    inputBinding:
      position: 102
      prefix: --config
  - id: count_orphans
    type:
      - 'null'
      - boolean
    doc: Include anomalous read pairs, with flag PAIRED but not PROPER_PAIR set
    inputBinding:
      position: 102
      prefix: --count-orphans
  - id: del_bias
    type:
      - 'null'
      - float
    doc: Relative likelihood of insertion to deletion
    default: 0.0
    inputBinding:
      position: 102
      prefix: --del-bias
  - id: delta_bq
    type:
      - 'null'
      - int
    doc: Use neighbour_qual + INT if less than qual
    default: 30
    inputBinding:
      position: 102
      prefix: --delta-BQ
  - id: ext_prob
    type:
      - 'null'
      - int
    doc: Phred-scaled gap extension seq error probability
    default: 20
    inputBinding:
      position: 102
      prefix: --ext-prob
  - id: fasta_ref
    type:
      - 'null'
      - File
    doc: Faidx indexed reference sequence file
    inputBinding:
      position: 102
      prefix: --fasta-ref
  - id: full_baq
    type:
      - 'null'
      - boolean
    doc: Apply BAQ everywhere, not just in problematic regions
    inputBinding:
      position: 102
      prefix: --full-BAQ
  - id: gap_frac
    type:
      - 'null'
      - float
    doc: Minimum fraction of gapped reads
    default: 0.05
    inputBinding:
      position: 102
      prefix: --gap-frac
  - id: gvcf
    type:
      - 'null'
      - type: array
        items: int
    doc: Group non-variant sites into gVCF blocks according to minimum 
      per-sample DP
    inputBinding:
      position: 102
      prefix: --gvcf
  - id: ignore_overlaps
    type:
      - 'null'
      - boolean
    doc: Disable read-pair overlap detection
    inputBinding:
      position: 102
      prefix: --ignore-overlaps
  - id: ignore_rg
    type:
      - 'null'
      - boolean
    doc: Ignore RG tags (one BAM = one sample)
    inputBinding:
      position: 102
      prefix: --ignore-RG
  - id: illumina_encoding
    type:
      - 'null'
      - boolean
    doc: Quality is in the Illumina-1.3+ encoding
    inputBinding:
      position: 102
      prefix: --illumina1.3+
  - id: indel_bias
    type:
      - 'null'
      - float
    doc: Raise to favour recall over precision
    default: 1.0
    inputBinding:
      position: 102
      prefix: --indel-bias
  - id: indel_size
    type:
      - 'null'
      - int
    doc: Approximate maximum indel size considered
    default: 110
    inputBinding:
      position: 102
      prefix: --indel-size
  - id: indels_2_0
    type:
      - 'null'
      - boolean
    doc: New EXPERIMENTAL indel calling model (diploid reference consensus)
    inputBinding:
      position: 102
      prefix: --indels-2.0
  - id: indels_cns
    type:
      - 'null'
      - boolean
    doc: New EXPERIMENTAL indel calling model with edlib
    inputBinding:
      position: 102
      prefix: --indels-cns
  - id: max_bq
    type:
      - 'null'
      - int
    doc: Limit baseQ/BAQ to no more than INT
    default: 60
    inputBinding:
      position: 102
      prefix: --max-BQ
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Max raw per-file depth; avoids excessive memory usage
    default: 250
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: max_idepth
    type:
      - 'null'
      - int
    doc: Maximum per-file depth for INDEL calling
    default: 250
    inputBinding:
      position: 102
      prefix: --max-idepth
  - id: max_read_len
    type:
      - 'null'
      - int
    doc: Maximum length of read to pass to BAQ algorithm
    default: 500
    inputBinding:
      position: 102
      prefix: --max-read-len
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Skip bases with baseQ/BAQ smaller than INT
    default: 1
    inputBinding:
      position: 102
      prefix: --min-BQ
  - id: min_ireads
    type:
      - 'null'
      - int
    doc: Minimum number gapped reads for indel candidates
    default: 2
    inputBinding:
      position: 102
      prefix: --min-ireads
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Skip alignments with mapQ smaller than INT
    default: 0
    inputBinding:
      position: 102
      prefix: --min-MQ
  - id: no_baq
    type:
      - 'null'
      - boolean
    doc: Disable BAQ (per-Base Alignment Quality)
    inputBinding:
      position: 102
      prefix: --no-BAQ
  - id: no_indels_cns
    type:
      - 'null'
      - boolean
    doc: Disable CNS mode, to use after a -X profile
    inputBinding:
      position: 102
      prefix: --no-indels-cns
  - id: no_reference
    type:
      - 'null'
      - boolean
    doc: Do not require fasta reference file
    inputBinding:
      position: 102
      prefix: --no-reference
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 102
      prefix: --no-version
  - id: open_prob
    type:
      - 'null'
      - int
    doc: Phred-scaled gap open seq error probability
    default: 40
    inputBinding:
      position: 102
      prefix: --open-prob
  - id: output_type
    type:
      - 'null'
      - string
    doc: "'b' compressed BCF; 'u' uncompressed BCF; 'z' compressed VCF; 'v' uncompressed
      VCF; 0-9 compression level"
    default: v
    inputBinding:
      position: 102
      prefix: --output-type
  - id: per_sample_mf
    type:
      - 'null'
      - boolean
    doc: Apply -m and -F per-sample for increased sensitivity
    inputBinding:
      position: 102
      prefix: --per-sample-mF
  - id: platforms
    type:
      - 'null'
      - string
    doc: Comma separated list of platforms for indels
    default: all
    inputBinding:
      position: 102
      prefix: --platforms
  - id: poly_mqual
    type:
      - 'null'
      - boolean
    doc: (Edlib mode) Use minimum quality within homopolymers
    inputBinding:
      position: 102
      prefix: --poly-mqual
  - id: read_groups
    type:
      - 'null'
      - File
    doc: Select or exclude read groups listed in the file
    inputBinding:
      position: 102
      prefix: --read-groups
  - id: redo_baq
    type:
      - 'null'
      - boolean
    doc: Recalculate BAQ on the fly, ignore existing BQs
    inputBinding:
      position: 102
      prefix: --redo-BAQ
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of regions in which pileup is generated
    inputBinding:
      position: 102
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Restrict to regions listed in a file
    inputBinding:
      position: 102
      prefix: --regions-file
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of samples to include
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File of samples to include
    inputBinding:
      position: 102
      prefix: --samples-file
  - id: score_vs_ref
    type:
      - 'null'
      - float
    doc: Ratio of score vs ref (1) or 2nd-best allele (0)
    default: 0.0
    inputBinding:
      position: 102
      prefix: --score-vs-ref
  - id: seed
    type:
      - 'null'
      - int
    doc: Random number seed used for sampling deep regions
    default: 0
    inputBinding:
      position: 102
      prefix: --seed
  - id: seqq_offset
    type:
      - 'null'
      - int
    doc: Indel-cns tuning for indel seq-qual scores
    default: 120
    inputBinding:
      position: 102
      prefix: --seqq-offset
  - id: skip_all_set
    type:
      - 'null'
      - string
    doc: Skip reads with all of the bits set
    inputBinding:
      position: 102
      prefix: --skip-all-set
  - id: skip_all_unset
    type:
      - 'null'
      - string
    doc: Skip reads with all of the bits unset
    inputBinding:
      position: 102
      prefix: --skip-all-unset
  - id: skip_any_set
    type:
      - 'null'
      - string
    doc: Skip reads with any of the bits set
    default: UNMAP,SECONDARY,QCFAIL,DUP
    inputBinding:
      position: 102
      prefix: --skip-any-set
  - id: skip_any_unset
    type:
      - 'null'
      - string
    doc: Skip reads with any of the bits unset
    inputBinding:
      position: 102
      prefix: --skip-any-unset
  - id: skip_indels
    type:
      - 'null'
      - boolean
    doc: Do not perform indel calling
    inputBinding:
      position: 102
      prefix: --skip-indels
  - id: tandem_qual
    type:
      - 'null'
      - int
    doc: Coefficient for homopolymer errors
    default: 500
    inputBinding:
      position: 102
      prefix: --tandem-qual
  - id: targets
    type:
      - 'null'
      - type: array
        items: string
    doc: Similar to -r but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: Similar to -R but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets-file
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with INT worker threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: write_index
    type:
      - 'null'
      - string
    doc: Automatically index the output files
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to FILE
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
