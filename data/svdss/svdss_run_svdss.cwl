cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_svdss
label: svdss_run_svdss
doc: "Run SVDSS for structural variant detection.\n\nTool homepage: https://github.com/Parsoa/SVDSS"
inputs:
  - id: reference_fa
    type: File
    doc: reference file in FASTA format
    inputBinding:
      position: 1
  - id: alignments_bam
    type: File
    doc: alignments in BAM format
    inputBinding:
      position: 2
  - id: accuracy_percentile
    type:
      - 'null'
      - float
    doc: accuracy percentile
    default: 0.98
    inputBinding:
      position: 103
      prefix: -p
  - id: fmd_index
    type:
      - 'null'
      - File
    doc: use this FMD index/store it here
    inputBinding:
      position: 103
      prefix: -i
  - id: kanpig_binary
    type:
      - 'null'
      - File
    doc: path to kanpig binary
    default: kanpig
    inputBinding:
      position: 103
      prefix: -k
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: mapping quality
    default: 20
    inputBinding:
      position: 103
      prefix: -q
  - id: min_support
    type:
      - 'null'
      - int
    doc: minimum support for calling
    default: 2
    inputBinding:
      position: 103
      prefix: -s
  - id: min_sv_length
    type:
      - 'null'
      - int
    doc: minimum length for SV
    default: 50
    inputBinding:
      position: 103
      prefix: -l
  - id: no_haplotagging
    type:
      - 'null'
      - boolean
    doc: do not consider haplotagging information
    inputBinding:
      position: 103
      prefix: -t
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    default: .
    inputBinding:
      position: 103
      prefix: -w
  - id: svdss_binary
    type:
      - 'null'
      - File
    doc: path to SVDSS binary
    default: SVDSS
    inputBinding:
      position: 103
      prefix: -x
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 4
    inputBinding:
      position: 103
      prefix: -@
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdss:2.1.0--h9013031_0
stdout: svdss_run_svdss.out
