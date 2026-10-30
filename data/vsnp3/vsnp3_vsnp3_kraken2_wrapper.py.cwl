cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_kraken2_wrapper.py
label: vsnp3_vsnp3_kraken2_wrapper.py
doc: "Run kraken2 on a FASTA, single FASTQ or paired FASTQ files and make a Krona chart.\n\
  \nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Provide FASTA file
    inputBinding:
      position: 101
      prefix: -f
  - id: fastq_r1
    type:
      - 'null'
      - File
    doc: Provide R1 FASTQ gz file, or single read
    inputBinding:
      position: 101
      prefix: -r1
  - id: fastq_r2
    type:
      - 'null'
      - File
    doc: Provide R2 FASTQ gz file
    inputBinding:
      position: 101
      prefix: -r2
  - id: directory
    type:
      - 'null'
      - string
    doc: Put output to directory
    inputBinding:
      position: 101
      prefix: -d
  - id: db_contents
    type:
      - 'null'
      - boolean
    doc: Show contents of DB by printing README
    inputBinding:
      position: 101
      prefix: -c
  - id: database
    type: Directory
    doc: Absolute path to database directory
    inputBinding:
      position: 101
      prefix: --database
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: kraken2_output
    type: Directory
    doc: Kraken2 report and Krona chart
    outputBinding:
      glob: $(inputs.directory || "kraken2")
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_kraken2_wrapper.py.stdout.txt
