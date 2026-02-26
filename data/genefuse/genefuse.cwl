cwlVersion: v1.2
class: CommandLineTool
baseCommand: genefuse
label: genefuse
doc: "genefuse --read1=string --fusion=string --ref=string [options] ...\n\nTool homepage:
  https://github.com/OpenGene/genefuse"
inputs:
  - id: deletion
    type:
      - 'null'
      - int
    doc: specify the least deletion length of a intra-gene deletion to report
    default: 50
    inputBinding:
      position: 101
      prefix: --deletion
  - id: fusion
    type: string
    doc: fusion file name, in CSV format
    inputBinding:
      position: 101
      prefix: --fusion
  - id: output_deletions
    type:
      - 'null'
      - boolean
    doc: long deletions are not output by default, enable this option to output 
      them
    inputBinding:
      position: 101
      prefix: --output_deletions
  - id: output_untranslated_fusions
    type:
      - 'null'
      - boolean
    doc: the fusions that cannot be transcribed or translated are not output by 
      default, enable this option to output them
    inputBinding:
      position: 101
      prefix: --output_untranslated_fusions
  - id: read1
    type: string
    doc: read1 file name
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - string
    doc: read2 file name
    inputBinding:
      position: 101
      prefix: --read2
  - id: ref
    type: File
    doc: reference fasta file name
    inputBinding:
      position: 101
      prefix: --ref
  - id: thread
    type:
      - 'null'
      - int
    doc: worker thread number
    default: 4
    inputBinding:
      position: 101
      prefix: --thread
  - id: unique
    type:
      - 'null'
      - int
    doc: specify the least supporting read number is required to report a fusion
    default: 2
    inputBinding:
      position: 101
      prefix: --unique
outputs:
  - id: html
    type:
      - 'null'
      - File
    doc: file name to store HTML report
    outputBinding:
      glob: $(inputs.html)
  - id: json
    type:
      - 'null'
      - File
    doc: file name to store JSON report
    outputBinding:
      glob: $(inputs.json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genefuse:0.8.0--h5ca1c30_4
