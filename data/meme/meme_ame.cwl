cwlVersion: v1.2
class: CommandLineTool
baseCommand: ame
label: meme_ame
doc: "AME (Analysis of Motif Enrichment) finds known motifs that are enriched in a
  set of sequences.\n\nTool homepage: https://meme-suite.org"
inputs:
  - id: sequence_file
    type: File
    doc: file of sequences in FASTA format
    inputBinding:
      position: 1
  - id: motif_files
    type:
      type: array
      items: File
    doc: file(s) of motifs in MEME format
    inputBinding:
      position: 2
  - id: bfile
    type:
      - 'null'
      - File
    doc: 'background model file; default: motif file freqs'
    inputBinding:
      position: 103
      prefix: --bfile
  - id: control_file
    type:
      - 'null'
      - string
    doc: control sequences in FASTA format or the keyword '--shuffle--' to use shuffled
      versions of the primary sequences
    inputBinding:
      position: 103
      prefix: --control
  - id: evalue_report_threshold
    type:
      - 'null'
      - float
    doc: motif significance reporting threshold
    default: 10
    inputBinding:
      position: 103
      prefix: --evalue-report-threshold
  - id: exc
    type:
      - 'null'
      - type: array
        items: string
    doc: name pattern to exclude as motif; may be repeated
    inputBinding:
      position: 103
      prefix: --exc
  - id: fasta_threshold
    type:
      - 'null'
      - float
    doc: maximum FASTA score for sequence to be positive (requires --poslist pwm)
    default: 0.001
    inputBinding:
      position: 103
      prefix: --fasta-threshold
  - id: fix_partition
    type:
      - 'null'
      - int
    doc: number of sequences in positive partition
    inputBinding:
      position: 103
      prefix: --fix-partition
  - id: hit_lo_fraction
    type:
      - 'null'
      - float
    doc: fraction of maximum log-odds for a hit
    default: 0.25
    inputBinding:
      position: 103
      prefix: --hit-lo-fraction
  - id: inc
    type:
      - 'null'
      - type: array
        items: string
    doc: name pattern to select as motif; may be repeated
    inputBinding:
      position: 103
      prefix: --inc
  - id: kmer
    type:
      - 'null'
      - int
    doc: preserve k-mer frequencies when shuffling
    default: 2
    inputBinding:
      position: 103
      prefix: --kmer
  - id: linreg_switchxy
    type:
      - 'null'
      - boolean
    doc: switch roles of X=FASTA scores and Y=PWM scores
    inputBinding:
      position: 103
      prefix: --linreg-switchxy
  - id: log_fscores
    type:
      - 'null'
      - boolean
    doc: use log of FASTA scores (pearson) or log of ranks (spearman)
    inputBinding:
      position: 103
      prefix: --log-fscores
  - id: log_pwmscores
    type:
      - 'null'
      - boolean
    doc: use log of log of PWM scores
    inputBinding:
      position: 103
      prefix: --log-pwmscores
  - id: method
    type:
      - 'null'
      - string
    doc: statistical test (fisher|3dmhg|4dmhg|ranksum|pearson|spearman)
    default: fisher
    inputBinding:
      position: 103
      prefix: --method
  - id: motif_pseudo
    type:
      - 'null'
      - float
    doc: pseudocount for creating PWMs from motifs
    default: 0.1
    inputBinding:
      position: 103
      prefix: --motif-pseudo
  - id: poslist
    type:
      - 'null'
      - string
    doc: partition on affinity (fasta) or motif (pwm) scores
    default: fasta
    inputBinding:
      position: 103
      prefix: --poslist
  - id: scoring
    type:
      - 'null'
      - string
    doc: sequence scoring method (avg|max|sum|totalhits)
    default: avg
    inputBinding:
      position: 103
      prefix: --scoring
  - id: seed
    type:
      - 'null'
      - int
    doc: random number seed (integer)
    default: 1
    inputBinding:
      position: 103
      prefix: --seed
  - id: text_output
    type:
      - 'null'
      - boolean
    doc: output TSV format to stdout; overrides --o and --oc
    inputBinding:
      position: 103
      prefix: --text
  - id: verbose
    type:
      - 'null'
      - int
    doc: controls program verbosity (1-5)
    default: 2
    inputBinding:
      position: 103
      prefix: --verbose
  - id: xalph
    type:
      - 'null'
      - File
    doc: motifs will be converted to this custom alphabet
    inputBinding:
      position: 103
      prefix: --xalph
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir_overwrite
    type:
      - 'null'
      - Directory
    doc: overwrite output directory
    outputBinding:
      glob: $(inputs.output_dir_overwrite)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
