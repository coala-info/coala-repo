cwlVersion: v1.2
class: CommandLineTool
baseCommand: LABRAT.py
label: labrat_LABRAT.py
doc: "LABRAT.py\n\nTool homepage: https://github.com/TaliaferroLab/LABRAT"
inputs:
  - id: conditiona
    type:
      - 'null'
      - string
    doc: Condition A. deltapsi will be calculated as B-A. Must be a value in the
      'condition' column of the sampconds file.
    inputBinding:
      position: 101
      prefix: --conditionA
  - id: conditionb
    type:
      - 'null'
      - string
    doc: Condition B. deltapsi will be calculated as B-A. Must be a value in the
      'condition' column of the sampconds file.
    inputBinding:
      position: 101
      prefix: --conditionB
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
  - id: librarytype
    type:
      - 'null'
      - string
    doc: Is this RNAseq data or 3' seq data? Needed for makeTFfasta and 
      calculatepsi.
    inputBinding:
      position: 101
      prefix: --librarytype
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode of operation
    inputBinding:
      position: 101
      prefix: --mode
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
      Omit for single end data.
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
    doc: File relating sample names and conditions. See README for details.
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
stdout: labrat_LABRAT.py.out
