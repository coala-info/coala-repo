cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - fasta
label: ska_fasta
doc: "Create a split kmer file from fasta file(s)\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: 'Input fasta file(s)'
    inputBinding:
      position: 1
  - id: circular
    type:
      - 'null'
      - boolean
    doc: 'Treat all contigs as circular.'
    inputBinding:
      position: 101
      prefix: -c
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'Split kmer size. The kmer used for searches will be twice this length, with the variable base in the middle. Must be divisible by 3. [Default = 15]'
    inputBinding:
      position: 101
      prefix: -k
  - id: output_prefix
    type:
      - 'null'
      - string
    default: fasta
    doc: 'Output file prefix. [Default = fasta]'
    inputBinding:
      position: 101
      prefix: -o
  - id: file_list
    type:
      - 'null'
      - File
    doc: 'File of split kmer file names. These will be added to or used as an alternative input to the list provided on the command line. Give the listed files in list_files so that the plain names in the list resolve.'
    inputBinding:
      position: 101
      prefix: -f
  - id: list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Files named in the file list; they are staged in the working directory so that the plain names in the list resolve'
outputs:
  - id: skf_file
    type: File
    doc: 'Split kmer file'
    outputBinding:
      glob: '$(inputs.output_prefix).skf'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '${ return inputs.list_files ? inputs.list_files : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska:1.0--h077b44d_7
