cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtpre
label: smartdenovo_wtpre
doc: "WTPRE: Prepare raw reads for assembly (SMARTdenovo)\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: raw_reads
    type:
      type: array
      items: File
    doc: "Raw reads file(s), FASTQ or FASTA"
    inputBinding:
      position: 102
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Force overwrite output file"
    inputBinding:
      position: 101
      prefix: -f
  - id: keep_all_subreads
    type:
      - 'null'
      - boolean
    doc: "Keep all subreads in a well, default: the longest one"
    inputBinding:
      position: 101
      prefix: -L
  - id: jack_knife
    type:
      - 'null'
      - int
    doc: "Jack knife of read length, [0]"
    inputBinding:
      position: 101
      prefix: -J
  - id: clip_bases
    type:
      - 'null'
      - int
    doc: "Clip <-c> bases at both ends, [0]"
    inputBinding:
      position: 101
      prefix: -c
  - id: read_name_prefix
    type:
      - 'null'
      - string
    doc: "Change the read name into {\"%s%012d\", <-p>}, [pb]"
    inputBinding:
      position: 101
      prefix: -p
  - id: output_path
    type: string
    doc: "Output of processed reads, [-]"
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: output
    type: File
    doc: "Processed reads"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
