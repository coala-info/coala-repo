cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - alleles
label: ska_alleles
doc: "Create a merged split kmer file for all sequences in one or more multifasta files\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: 'Input multifasta file(s); the split kmer file is written beside each input as <input>.skf'
    inputBinding:
      position: 1
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'Split kmer size. The kmer used for searches will be twice this length, with the variable base in the middle. Must be divisible by 3. [Default = 15]'
    inputBinding:
      position: 101
      prefix: -k
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
  - id: skf_files
    type:
      type: array
      items: File
    doc: 'Split kmer files written for the input multifasta files'
    outputBinding:
      glob: '*.skf'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '${ return inputs.list_files ? inputs.list_files : []; }'
      - entry: $(inputs.fasta_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska:1.0--h077b44d_7
