cwlVersion: v1.2
class: CommandLineTool
baseCommand: yanagiba
label: yanagiba
doc: "Filter and slice Nanopore reads which have been basecalled with Albacore. Takes
  fastq.gz and an Albacore summary file.\n\nTool homepage: https://github.com/Adamtaranto/Yanagiba"
inputs:
  - id: forceunique
    type:
      - 'null'
      - boolean
    doc: Enforce unique reads. Only store first instance of a read from fastq 
      input where readID occurs multiple times.
    inputBinding:
      position: 101
      prefix: --forceunique
  - id: headtrim
    type:
      - 'null'
      - int
    doc: Trim x bases from begining of each read.
    inputBinding:
      position: 101
      prefix: --headtrim
  - id: infile
    type: File
    doc: Input fastq.gz file.
    inputBinding:
      position: 101
      prefix: --infile
  - id: minlen
    type:
      - 'null'
      - int
    doc: Exclude reads shorter than this length.
    inputBinding:
      position: 101
      prefix: --minlen
  - id: minqual
    type:
      - 'null'
      - int
    doc: Minimum quality score to retain a read.
    inputBinding:
      position: 101
      prefix: --minqual
  - id: summaryfile
    type:
      - 'null'
      - File
    doc: Albacore summary file with header row.
    inputBinding:
      position: 101
      prefix: --summaryfile
  - id: tailtrim
    type:
      - 'null'
      - string
    doc: Trim x bases from end of each read.
    inputBinding:
      position: 101
      prefix: --tailtrim
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Write filtered reads to this file in .bgz format.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yanagiba:1.0.0--py36_1
