cwlVersion: v1.2
class: CommandLineTool
baseCommand: sensv
label: sensv
doc: "SENSV - Structural Variant caller\n\nTool homepage: https://github.com/HKU-BAL/SENSV"
inputs:
  - id: disable_dp_filter
    type:
      - 'null'
      - string
    doc: disable DP filter
    inputBinding:
      position: 101
      prefix: --disable_dp_filter
  - id: disable_gen_altref_bam
    type:
      - 'null'
      - string
    doc: disable gen altref bam
    inputBinding:
      position: 101
      prefix: --disable_gen_altref_bam
  - id: fastq_file
    type: File
    doc: fastq file
    inputBinding:
      position: 101
      prefix: --fastq_file
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: max Sv Size
    inputBinding:
      position: 101
      prefix: --max_sv_size
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: min Sv Size
    inputBinding:
      position: 101
      prefix: --min_sv_size
  - id: nprocs
    type:
      - 'null'
      - int
    doc: 'max # of processes to run sensv'
    inputBinding:
      position: 101
      prefix: --nprocs
  - id: ref
    type: File
    doc: reference fasta file absolute path
    inputBinding:
      position: 101
      prefix: --ref
  - id: ref_ver
    type:
      - 'null'
      - string
    doc: reference version (default 37)
    inputBinding:
      position: 101
      prefix: --ref_ver
  - id: sample_name
    type: string
    doc: sample name
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: target_sv_type
    type:
      - 'null'
      - string
    doc: target sv type
    inputBinding:
      position: 101
      prefix: --target_sv_type
outputs:
  - id: output_prefix
    type: File
    doc: output prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sensv:1.0.4--h43eeafb_2
