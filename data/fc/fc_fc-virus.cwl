cwlVersion: v1.2
class: CommandLineTool
baseCommand: fc-virus
label: fc_fc-virus
doc: "FC-Virus Usage\n\nTool homepage: https://github.com/qdu-bioinfo/fc-virus"
inputs:
  - id: file_type
    type:
      - 'null'
      - string
    doc: type of file, fa or fq
    inputBinding:
      position: 101
      prefix: -t
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length of kmer
    inputBinding:
      position: 101
      prefix: -k
  - id: left_reads_file
    type:
      - 'null'
      - File
    doc: left reads file name (.fasta or .fastq)
    inputBinding:
      position: 101
      prefix: --left
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: paired-end reads (must be the first option for the tool to accept it)
    inputBinding:
      position: 1
      prefix: -p
  - id: right_reads_file
    type:
      - 'null'
      - File
    doc: right reads file name (.fasta or .fastq)
    inputBinding:
      position: 101
      prefix: --right
  - id: single_end_file
    type:
      - 'null'
      - File
    doc: reads file name (.fasta or .fastq)
    inputBinding:
      position: 101
      prefix: --singlefile
  - id: output_directory_path
    type: string
    doc: Output directory name. The wrapper creates it and passes it with a trailing
      slash, because the tool appends FC-Virus.fa to this text.
    inputBinding:
      position: 102
      prefix: -o
      valueFrom: $(self)/
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory_path)
successCodes: [0, 1]
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_directory_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fc:1.0.1--h5ca1c30_1
