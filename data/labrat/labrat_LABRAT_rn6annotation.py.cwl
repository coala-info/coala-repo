cwlVersion: v1.2
class: CommandLineTool
baseCommand: LABRAT_rn6annotation.py
label: labrat_LABRAT_rn6annotation.py
doc: "LABRAT_rn6annotation.py\n\nTool homepage: https://github.com/TaliaferroLab/LABRAT"
inputs:
  - id: genomefasta
    type:
      - 'null'
      - File
    doc: Genome sequence in fasta format. Needed for makeTFfasta.
    inputBinding:
      position: 101
      prefix: --genomefasta
  - id: gff
    type:
      - 'null'
      - File
    doc: GFF of transcript annotation. Needed for makeTFfasta and calculatepsi.
    inputBinding:
      position: 101
      prefix: --gff
  - id: lasttwoexons
    type:
      - 'null'
      - boolean
    doc: Used for makeTFfasta. Do you want to only use the last two exons?
    inputBinding:
      position: 101
      prefix: --lasttwoexons
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Mode of operation. Options are: makeTFfasta, runSalmon, calculatepsi, LME.'
    inputBinding:
      position: 101
      prefix: --mode
  - id: psifile
    type:
      - 'null'
      - File
    doc: Psi value table. Needed for LME.
    inputBinding:
      position: 101
      prefix: --psifile
  - id: reads1
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma separated list of forward read fastq files. Needed for runSalmon.
    inputBinding:
      position: 101
      prefix: --reads1
  - id: reads2
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma separated list of reverse read fastq files. Needed for runSalmon.
    inputBinding:
      position: 101
      prefix: --reads2
  - id: salmondir
    type:
      - 'null'
      - Directory
    doc: Salmon output directory. Needed for calculatepsi.
    inputBinding:
      position: 101
      prefix: --salmondir
  - id: sampconds
    type:
      - 'null'
      - File
    doc: File containing sample names split by condition. Two column, tab 
      delimited text file. Condition 1 samples in first column, condition2 
      samples in second column.
    inputBinding:
      position: 101
      prefix: --sampconds
  - id: samplename
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of samplenames. Needed for runSalmon.
    inputBinding:
      position: 101
      prefix: --samplename
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Needed for runSalmon.
    inputBinding:
      position: 101
      prefix: --threads
  - id: txfasta
    type:
      - 'null'
      - File
    doc: Fasta file of sequences to quantitate with salmon. Often the output of 
      makeTFfasta mode.
    inputBinding:
      position: 101
      prefix: --txfasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
stdout: labrat_LABRAT_rn6annotation.py.out
