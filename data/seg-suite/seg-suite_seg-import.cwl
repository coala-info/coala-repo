cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg-import
label: seg-suite_seg-import
doc: "Read segments or alignments in various formats, and write them in SEG format.\n\
  \nTool homepage: https://github.com/mcfrith/seg-suite"
inputs:
  - id: input_format
    type: string
    doc: Format of the input files (bed, chain, genePred, gff, gtf, lastTab, 
      maf, psl, rmsk, sam)
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: Input file(s)
    inputBinding:
      position: 2
  - id: add_alignment_info
    type:
      - 'null'
      - boolean
    doc: add alignment number and position to each seg line (for lastTab, maf, 
      psl)
    inputBinding:
      position: 103
      prefix: -a
  - id: forward_stranded_segment_index
    type:
      - 'null'
      - int
    doc: make the Nth segment in each seg line forward-stranded
    inputBinding:
      position: 103
      prefix: -f
  - id: get_3_utr
    type:
      - 'null'
      - boolean
    doc: get 3' untranslated regions (UTRs) (for bed, genePred, gtf)
    inputBinding:
      position: 103
      prefix: '-3'
  - id: get_5_utr
    type:
      - 'null'
      - boolean
    doc: get 5' untranslated regions (UTRs) (for bed, genePred, gtf)
    inputBinding:
      position: 103
      prefix: '-5'
  - id: get_cds
    type:
      - 'null'
      - boolean
    doc: get CDS (coding regions) (for bed, genePred, gtf)
    inputBinding:
      position: 103
      prefix: -c
  - id: get_introns
    type:
      - 'null'
      - boolean
    doc: get introns (for bed, genePred, gtf)
    inputBinding:
      position: 103
      prefix: -i
  - id: get_primary_transcripts
    type:
      - 'null'
      - boolean
    doc: get primary transcripts (exons plus introns) (for bed, genePred, gtf)
    inputBinding:
      position: 103
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
stdout: seg-suite_seg-import.out
