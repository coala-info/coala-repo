cwlVersion: v1.2
class: CommandLineTool
baseCommand: main.sh
label: excludonfinder_ExcludonFinder
doc: "ExcludonFinder main processing script\n\nTool homepage: https://github.com/Alvarosmb/ExcludonFinder"
inputs:
  - id: annotation_gff
    type: File
    doc: Annotation file in GFF format
    inputBinding:
      position: 101
      prefix: -g
  - id: coverage_threshold
    type:
      - 'null'
      - float
    doc: Coverage threshold
    default: 0.5
    inputBinding:
      position: 101
      prefix: -t
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: 'Keep intermediate files (default: remove)'
    inputBinding:
      position: 101
      prefix: -k
  - id: long_read_mode
    type:
      - 'null'
      - boolean
    doc: Use long-read mode (uses minimap2 instead of bwa-mem2)
    inputBinding:
      position: 101
      prefix: -l
  - id: quality_control
    type:
      - 'null'
      - boolean
    doc: Run quality control checks
    inputBinding:
      position: 101
      prefix: -C
  - id: reads_r1
    type: File
    doc: Input FASTQ file (Read 1 for paired-end data)
    inputBinding:
      position: 101
      prefix: '-1'
  - id: reads_r2
    type:
      - 'null'
      - File
    doc: Input FASTQ file (Read 2 for paired-end data)
    inputBinding:
      position: 101
      prefix: '-2'
  - id: reference_fasta
    type: File
    doc: Reference genome in FASTA format
    inputBinding:
      position: 101
      prefix: -f
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 8
    inputBinding:
      position: 101
      prefix: -j
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Supply a custom output dir
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/excludonfinder:0.2.0--hdfd78af_0
