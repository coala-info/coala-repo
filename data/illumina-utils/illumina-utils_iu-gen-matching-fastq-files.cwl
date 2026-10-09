cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-gen-matching-fastq-files
label: illumina-utils_iu-gen-matching-fastq-files
doc: "Recover matching ids in two FASTQ files

Tool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: r1
    type: File
    doc: "R1"
    inputBinding:
      position: 1
      prefix: '--r1'
  - id: r2
    type: File
    doc: "R2"
    inputBinding:
      position: 2
      prefix: '--r2'
  - id: identifier_code
    type:
      - 'null'
      - string
    doc: "Lambda function to parse the header. Default: lambda defline: defline.split()[0]"
    inputBinding:
      position: 3
      prefix: '--identifier-code'
  - id: identifier_tested
    type:
      - 'null'
      - boolean
    doc: "Use this flag to indicate that you tested your identifier."
    inputBinding:
      position: 4
      prefix: '--identifier-tested'
  - id: sequential
    type:
      - 'null'
      - boolean
    doc: "Your identifier code parses an integer value that can link pairs, and is incremental throughout the file."
    inputBinding:
      position: 5
      prefix: '--sequential'
outputs:
  - id: matching_files
    type:
      type: array
      items: File
    doc: Matching FASTQ files written in the working directory
    outputBinding:
      glob: "*-MATCHING*"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
stdout: illumina-utils_iu-gen-matching-fastq-files.out
