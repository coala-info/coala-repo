cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MethylExtractBSCR.pl
label: methylextract_MethylExtractBSCR.pl
doc: "MethylExtractBSCR estimates the bisulfite conversion rate from the cytosines
  of a fully unmethylated control sequence (or of any sequence) and its alignments.
  The result is printed to standard output.\n\nTool homepage: http://bioinfo2.ugr.es/MethylExtract/"
inputs:
  - id: seq_file
    type: File
    doc: sequence file
    inputBinding:
      position: 101
      prefix: seqFile=
      separate: false
  - id: in_file
    type: File
    doc: alignments input file
    inputBinding:
      position: 101
      prefix: inFile=
      separate: false
  - id: flag_w
    type:
      type: array
      items: string
    doc: Watson FLAGs (multiple FLAGs comma separated)
    inputBinding:
      position: 101
      prefix: flagW=
      separate: false
      itemSeparator: ','
  - id: flag_c
    type:
      type: array
      items: string
    doc: Crick FLAGs (multiple FLAGs comma separated)
    inputBinding:
      position: 101
      prefix: flagC=
      separate: false
      itemSeparator: ','
  - id: qscore
    type:
      - 'null'
      - string
    doc: 'fastq quality score: phred33-quals, phred64-quals, solexa-quals, solexa1.3-quals
      or NA [default: phred33-quals]'
    inputBinding:
      position: 101
      prefix: qscore=
      separate: false
  - id: min_q
    type:
      - 'null'
      - int
    doc: 'minimun PHRED quality per sequenced nucleotide [default: 20]'
    inputBinding:
      position: 101
      prefix: minQ=
      separate: false
  - id: first_ignor
    type:
      - 'null'
      - int
    doc: 'number of first bases ignored [default: 0]'
    inputBinding:
      position: 101
      prefix: FirstIgnor=
      separate: false
  - id: last_ignor
    type:
      - 'null'
      - int
    doc: 'number of last bases ignored [default: 0]'
    inputBinding:
      position: 101
      prefix: LastIgnor=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Number of cytosines and the bisulfite conversion rate
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylextract:1.9.1--0
stdout: bscr.out
