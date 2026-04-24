cwlVersion: v1.2
class: CommandLineTool
baseCommand: miRScore
label: mirscore_miRScore
doc: "miRScore is a tool for scoring miRNA potential.\n\nTool homepage: https://github.com/Aez35/miRScore"
inputs:
  - id: autotrim
    type:
      - 'null'
      - boolean
    doc: Trim untrimmed fastq files
    inputBinding:
      position: 101
      prefix: -autotrim
  - id: fastq
    type:
      type: array
      items: File
    doc: One or more fastq alignment files
    inputBinding:
      position: 101
      prefix: -fastq
  - id: hairpin
    type: File
    doc: fasta file of hairpin precursor sequence
    inputBinding:
      position: 101
      prefix: -hairpin
  - id: kingdom
    type: string
    doc: Specify animal or plant
    inputBinding:
      position: 101
      prefix: -kingdom
  - id: mature
    type: File
    doc: fasta file of mature miRNA sequence
    inputBinding:
      position: 101
      prefix: -mature
  - id: mm
    type:
      - 'null'
      - int
    doc: Allow up to 1 mismatch in miRNA reads
    inputBinding:
      position: 101
      prefix: -mm
  - id: n
    type: string
    doc: Results file name
    inputBinding:
      position: 101
      prefix: -n
  - id: nostrucvis
    type:
      - 'null'
      - boolean
    doc: Do not include StrucVis output
    inputBinding:
      position: 101
      prefix: -nostrucvis
  - id: rescue
    type:
      - 'null'
      - boolean
    doc: Reevaluate failed miRNAs and reannotate loci with alternative miRNA 
      duplex that meets all criteria
    inputBinding:
      position: 101
      prefix: -rescue
  - id: threads
    type:
      - 'null'
      - int
    doc: Specify number of threads for samtools
    inputBinding:
      position: 101
      prefix: -threads
  - id: trimkey
    type:
      - 'null'
      - string
    doc: Abundant miRNA used to find adapters for trimming with option -autotrim
    inputBinding:
      position: 101
      prefix: -trimkey
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirscore:0.3.4--hdfd78af_0
