cwlVersion: v1.2
class: CommandLineTool
baseCommand: genion
label: genion
doc: "GENe fusION\n\nTool homepage: https://github.com/vpc-ccg/genion"
inputs:
  - id: duplications
    type: File
    doc: genomicSuperDups.txt, unzipped
    inputBinding:
      position: 101
      prefix: --duplications
  - id: gpaf
    type: File
    doc: Long read whole genom e alignment paf path
    inputBinding:
      position: 101
      prefix: --gpaf
  - id: gtf
    type: File
    doc: GTF annotation path
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_file
    type: File
    doc: Input fast{a,q} file
    inputBinding:
      position: 101
      prefix: --input
  - id: log
    type:
      - 'null'
      - File
    doc: 'logfile path (default: output_path + .log)'
    inputBinding:
      position: 101
      prefix: --log
  - id: max_base_percent_in_exon
    type:
      - 'null'
      - float
    doc: Maximum ratio of a base type (AGTC) in an potential fusion exon (This 
      is used for low complexity filtering)
    default: 0.65
    inputBinding:
      position: 101
      prefix: --max-base-percent-in-exon
  - id: max_rt_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between genes for read-through events
    default: 500000
    inputBinding:
      position: 101
      prefix: --max-rt-distance
  - id: max_rt_fin
    type:
      - 'null'
      - float
    doc: Maximum value of chimeric-count / normal-count for read-through events
    default: 0.2
    inputBinding:
      position: 101
      prefix: --max-rt-fin
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum read support for fusion calls
    default: 3
    inputBinding:
      position: 101
      prefix: --min-support
  - id: non_coding
    type:
      - 'null'
      - boolean
    doc: Allow non-coding genes and transcripts while calling gene fusions
    inputBinding:
      position: 101
      prefix: --non-coding
  - id: transcriptome_self_align
    type:
      - 'null'
      - File
    doc: Self align tsv
    inputBinding:
      position: 101
      prefix: --transcriptome-self-align
outputs:
  - id: output
    type: Directory
    doc: Output path for an existing path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genion:1.2.3--h077b44d_2
