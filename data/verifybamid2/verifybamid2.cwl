cwlVersion: v1.2
class: CommandLineTool
baseCommand: verifybamid2
label: verifybamid2
doc: "A robust tool for DNA contamination estimation from sequence reads using ancestry-agnostic
  method.\n\nTool homepage: https://github.com/Griffan/VerifyBamID"
inputs:
  - id: adjust_mq
    type:
      - 'null'
      - int
    doc: adjust mapping quality; recommended:50, disable:0
    default: 40
    inputBinding:
      position: 101
      prefix: --adjust-MQ
  - id: bam_file
    type:
      - 'null'
      - File
    doc: Bam or Cram file for the sample[Required if --PileupFile not specified]
    inputBinding:
      position: 101
      prefix: --BamFile
  - id: bed_path
    type:
      - 'null'
      - File
    doc: "Bed file for markers used in this analysis,1 based pos(chr\tpos-1\tpos\t\
      refAllele\taltAllele)[Required]"
    inputBinding:
      position: 101
      prefix: --BedPath
  - id: disable_sanity_check
    type:
      - 'null'
      - boolean
    doc: Disable marker quality sanity check(no marker filtering)[default:false]
    inputBinding:
      position: 101
      prefix: --DisableSanityCheck
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Minimization procedure convergence threshold, usually a trade-off 
      bettween accuracy and running time[default:1e-10]
    default: 1e-08
    inputBinding:
      position: 101
      prefix: --Epsilon
  - id: excl_flags
    type:
      - 'null'
      - int
    doc: 'filter flags: skip reads with mask bits set'
    default: 1796
    inputBinding:
      position: 101
      prefix: --excl-flags
  - id: fix_alpha
    type:
      - 'null'
      - float
    doc: Input fixed Alpha to estimate PC coordinates
    default: -1.0
    inputBinding:
      position: 101
      prefix: --FixAlpha
  - id: fix_pc
    type:
      - 'null'
      - string
    doc: Input fixed PCs to estimate Alpha[format PC1:PC2:PC3...]
    inputBinding:
      position: 101
      prefix: --FixPC
  - id: incl_flags
    type:
      - 'null'
      - int
    doc: 'required flags: skip reads with mask bits unset'
    default: 1040
    inputBinding:
      position: 101
      prefix: --incl-flags
  - id: known_af
    type:
      - 'null'
      - File
    doc: "known allele frequency file (chr\tpos\tfreq)[Optional]"
    inputBinding:
      position: 101
      prefix: --KnownAF
  - id: max_depth
    type:
      - 'null'
      - int
    doc: max per-file depth
    default: 8000
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: mean_path
    type:
      - 'null'
      - File
    doc: Mean matrix file of genotype matrix
    inputBinding:
      position: 101
      prefix: --MeanPath
  - id: min_bq
    type:
      - 'null'
      - int
    doc: skip bases with baseQ/BAQ smaller than min-BQ
    default: 13
    inputBinding:
      position: 101
      prefix: --min-BQ
  - id: min_mq
    type:
      - 'null'
      - int
    doc: skip alignments with mapQ smaller than min-MQ
    default: 2
    inputBinding:
      position: 101
      prefix: --min-MQ
  - id: no_orphans
    type:
      - 'null'
      - boolean
    doc: do not use anomalous read pairs
    inputBinding:
      position: 101
      prefix: --no-orphans
  - id: num_pc
    type:
      - 'null'
      - int
    doc: Set number of PCs to infer Allele Frequency[optional]
    default: 2
    inputBinding:
      position: 101
      prefix: --NumPC
  - id: num_thread
    type:
      - 'null'
      - int
    doc: Set number of threads in likelihood calculation[default:4]
    default: 4
    inputBinding:
      position: 101
      prefix: --NumThread
  - id: output
    type:
      - 'null'
      - string
    doc: Prefix of output files[optional]
    default: result
    inputBinding:
      position: 101
      prefix: --Output
  - id: output_pileup
    type:
      - 'null'
      - boolean
    doc: If output temp pileup file
    inputBinding:
      position: 101
      prefix: --OutputPileup
  - id: pileup_file
    type:
      - 'null'
      - File
    doc: Pileup file for the sample[Required if --BamFile not specified]
    inputBinding:
      position: 101
      prefix: --PileupFile
  - id: ref_vcf
    type:
      - 'null'
      - File
    doc: VCF file from which to extract reference panel's genotype 
      matrix[Required if no SVD files available]
    inputBinding:
      position: 101
      prefix: --RefVCF
  - id: reference
    type: File
    doc: Reference file[Required]
    inputBinding:
      position: 101
      prefix: --Reference
  - id: seed
    type:
      - 'null'
      - int
    doc: Random number seed[default:12345]
    default: 12345
    inputBinding:
      position: 101
      prefix: --Seed
  - id: svd_prefix
    type: string
    doc: SVD related files prefix(normally shared by .UD, .mu and .bed 
      files)[Required]
    inputBinding:
      position: 101
      prefix: --SVDPrefix
  - id: ud_path
    type:
      - 'null'
      - File
    doc: UD matrix file from SVD result of genotype matrix
    inputBinding:
      position: 101
      prefix: --UDPath
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If print the progress of the method on the screen
    inputBinding:
      position: 101
      prefix: --Verbose
  - id: within_ancestry
    type:
      - 'null'
      - boolean
    doc: Enabling withinAncestry assume target sample and contamination source 
      are from the same populations,[default:BetweenAncestry] otherwise
    inputBinding:
      position: 101
      prefix: --WithinAncestry
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verifybamid2:2.0.1--h345183b_12
stdout: verifybamid2.out
