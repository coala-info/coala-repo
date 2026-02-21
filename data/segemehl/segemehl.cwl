cwlVersion: v1.2
class: CommandLineTool
baseCommand: segemehl.x
label: segemehl
doc: "segemehl is a software to map short sequencer reads to reference genomes. Unlike
  other methods, segemehl is able to find de novo junctions (splits) in short reads.\n
  \nTool homepage: http://www.bioinf.uni-leipzig.de/Software/segemehl/"
inputs:
  - id: accuracy
    type:
      - 'null'
      - int
    doc: min percentage of matches per read
    inputBinding:
      position: 101
      prefix: --accuracy
  - id: database
    type: File
    doc: path to the sequence database (e.g. fasta file)
    inputBinding:
      position: 101
      prefix: --database
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum E-value
    inputBinding:
      position: 101
      prefix: --evalue
  - id: index
    type:
      - 'null'
      - File
    doc: path to the index file
    inputBinding:
      position: 101
      prefix: --index
  - id: mismatches
    type:
      - 'null'
      - int
    doc: maximum number of mismatches
    inputBinding:
      position: 101
      prefix: --mismatches
  - id: query
    type: File
    doc: path to the query file (e.g. fasta or fastq file)
    inputBinding:
      position: 101
      prefix: --query
  - id: silent
    type:
      - 'null'
      - boolean
    doc: shut up!
    inputBinding:
      position: 101
      prefix: --silent
  - id: split
    type:
      - 'null'
      - boolean
    doc: detect split reads
    inputBinding:
      position: 101
      prefix: --split
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: path to the output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/segemehl:v0.3.4-1-deb_cv1
