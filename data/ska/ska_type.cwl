cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - type
label: ska_type
doc: "Type split kmer files using a set of allele files\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: locus_fasta_files
    type:
      type: array
      items: File
    doc: 'Locus fasta files'
    inputBinding:
      position: 1
  - id: profile
    type:
      - 'null'
      - File
    doc: 'Tab file containing profile information.'
    inputBinding:
      position: 101
      prefix: -p
  - id: query
    type:
      - 'null'
      - File
    doc: 'Query split kmer file. This can be a single kmer file.'
    inputBinding:
      position: 101
      prefix: -q
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
  - id: stdout
    type: stdout
    doc: 'Standard output'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '${ return inputs.list_files ? inputs.list_files : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska:1.0--h077b44d_7
stdout: ska_type.out
