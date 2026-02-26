cwlVersion: v1.2
class: CommandLineTool
baseCommand: psiclass
label: psiclass
doc: "A tool for transcriptome assembly and consensus transcript voting across multiple
  samples.\n\nTool homepage: https://github.com/splicebox/PsiCLASS"
inputs:
  - id: bam_files
    type:
      - 'null'
      - string
    doc: paths to the alignment BAM files. Use comma to separate multiple BAM 
      files
    inputBinding:
      position: 101
      prefix: -b
  - id: bam_group_file
    type:
      - 'null'
      - File
    doc: path to the file listing the group id of BAMs in the --lb file
    inputBinding:
      position: 101
      prefix: --bamGroup
  - id: bam_list_file
    type:
      - 'null'
      - File
    doc: path to the file listing the alignments BAM files
    inputBinding:
      position: 101
      prefix: --lb
  - id: classifier_score_threshold
    type:
      - 'null'
      - float
    doc: only use the subexons with classifier score <= than the given number
    default: 0.05
    inputBinding:
      position: 101
      prefix: -c
  - id: max_dp_constraint_size
    type:
      - 'null'
      - int
    doc: the number of subexons a constraint can cover in DP. (-1 for inf)
    default: 7
    inputBinding:
      position: 101
      prefix: --maxDpConstraintSize
  - id: min_avg_coverage_depth
    type:
      - 'null'
      - float
    doc: the minimum average coverage depth of a transcript to be reported
    default: 1.0
    inputBinding:
      position: 101
      prefix: --vd
  - id: min_avg_supported_read
    type:
      - 'null'
      - float
    doc: the minimum average number of supported read for retained introns
    default: 0.5
    inputBinding:
      position: 101
      prefix: --sa
  - id: primary_paralog
    type:
      - 'null'
      - boolean
    doc: 'use primary alignment to retain paralog genes (default: use unique alignments)'
    inputBinding:
      position: 101
      prefix: --primaryParalog
  - id: stage
    type:
      - 'null'
      - int
    doc: 0-start from beginning; 1-building subexon files; 2-combining subexon 
      files; 3-assembling transcripts; 4-voting consensus transcripts
    default: 0
    inputBinding:
      position: 101
      prefix: --stage
  - id: strandedness
    type:
      - 'null'
      - string
    doc: un/rf/fr for library unstranded/fr-firstand/fr-secondstrand
    inputBinding:
      position: 101
      prefix: --stranded
  - id: threads
    type:
      - 'null'
      - int
    doc: number of processes/threads
    default: 1
    inputBinding:
      position: 101
      prefix: -p
  - id: trusted_splice_file
    type:
      - 'null'
      - File
    doc: path to the trusted splice file
    inputBinding:
      position: 101
      prefix: -s
  - id: tss_tes_quantile
    type:
      - 'null'
      - float
    doc: the quantile for transcription start/end sites in subexon graph
    default: 0.5
    inputBinding:
      position: 101
      prefix: --tssTesQuantile
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: prefix of output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psiclass:1.0.3--h5ca1c30_6
