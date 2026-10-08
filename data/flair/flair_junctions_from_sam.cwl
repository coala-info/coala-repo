cwlVersion: v1.2
class: CommandLineTool
baseCommand: junctions_from_sam
label: flair_junctions_from_sam
doc: 'Extract splice junctions with confidence scores from SAM/BAM alignments and
  write them as a BED file.


  Tool homepage: https://github.com/BrooksLabUCSC/flair'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: sam_file
    type: File
    doc: SAM/BAM file of read alignments to junctions and the genome
    inputBinding:
      position: 1
      prefix: -s
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Only keep uniquely aligned reads (NH tag is 1)
    inputBinding:
      position: 1
      prefix: --unique
  - id: name
    type:
      - 'null'
      - string
    doc: Name prefix used for the output BED file (default junctions_from_sam)
    inputBinding:
      position: 1
      prefix: -n
  - id: read_length
    type:
      - 'null'
      - int
    doc: Expected read length if all reads are of the same length
    inputBinding:
      position: 1
      prefix: -l
  - id: confidence_score
    type:
      - 'null'
      - float
    doc: Minimum entropy score for a confident junction (default 1.0)
    inputBinding:
      position: 1
      prefix: -c
  - id: forced_junctions
    type:
      - 'null'
      - File
    doc: File with intron coordinates of junctions that are kept regardless of the
      confidence score
    inputBinding:
      position: 1
      prefix: -j
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run with junction strand ambiguity messages
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: junction_files
    type:
      type: array
      items: File
    doc: Junction BED file(s) written with the name prefix
    outputBinding:
      glob: $(inputs.name || 'junctions_from_sam')*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
