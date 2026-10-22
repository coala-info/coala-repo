cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - unique
label: ska_unique
doc: "Output kmers unique to a set of split kmer files\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: skf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Split kmer files'
    inputBinding:
      position: 1
  - id: ingroup_names
    type:
      - 'null'
      - File
    doc: 'File of ingroup sample names. Unique kmers found in these files will be retained.'
    inputBinding:
      position: 101
      prefix: -i
  - id: allow_ns
    type:
      - 'null'
      - boolean
    doc: 'Allow Ns as in unique split kmers.'
    inputBinding:
      position: 101
      prefix: -n
  - id: min_proportion
    type:
      - 'null'
      - float
    doc: 'Minimum proportion of ingroup isolates required to possess a split kmer for that kmer to be retained. [Default = 0.9]'
    inputBinding:
      position: 101
      prefix: -p
  - id: output_prefix
    type:
      - 'null'
      - string
    default: unique
    doc: 'Output file prefix. [Default = unique]'
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
  - id: unique_files
    type:
      type: array
      items: File
    doc: 'Split kmer file with the unique kmers'
    outputBinding:
      glob: '$(inputs.output_prefix)*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '${ return inputs.list_files ? inputs.list_files : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska:1.0--h077b44d_7
