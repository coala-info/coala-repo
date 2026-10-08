cwlVersion: v1.2
class: CommandLineTool
baseCommand: bed_to_gtf
label: flair_bed_to_gtf
doc: 'Convert an isoform bed file to GTF (written to standard output).


  Tool homepage: https://github.com/BrooksLabUCSC/flair'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Do not split the isoform name by underscore into isoform and gene ids
    inputBinding:
      position: 1
      prefix: --force
  - id: add_reference_transcript_id
    type:
      - 'null'
      - boolean
    doc: Add the reference_transcript_id attribute
    inputBinding:
      position: 1
      prefix: --add_reference_transcript_id
  - id: dontuse_cds
    type:
      - 'null'
      - boolean
    doc: Do not use the CDS
    inputBinding:
      position: 1
      prefix: --dontuseCDS
  - id: inputfile
    type: File
    doc: Isoforms in bed format
    inputBinding:
      position: 2
outputs:
  - id: gtf
    type: stdout
    doc: Isoforms in GTF format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
stdout: bed_to_gtf.gtf
