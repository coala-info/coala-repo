cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - align
label: ska_align
doc: "Reference-free alignment from a set of split kmer files\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: skf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Split kmer file(s)'
    inputBinding:
      position: 1
  - id: print_kmers
    type:
      - 'null'
      - boolean
    doc: 'Print aligned split kmers to file.'
    inputBinding:
      position: 101
      prefix: -k
  - id: min_proportion
    type:
      - 'null'
      - float
    doc: 'Minimum proportion of isolates required to possess a split kmer for that kmer to be included in the alignment. [Default = 0.9]'
    inputBinding:
      position: 101
      prefix: -p
  - id: sample_names
    type:
      - 'null'
      - File
    doc: 'File of sample names to include in the alignment.'
    inputBinding:
      position: 101
      prefix: -s
  - id: variant_only
    type:
      - 'null'
      - boolean
    doc: 'Output variant only alignment. [Default = all sites]'
    inputBinding:
      position: 101
      prefix: -v
  - id: output_prefix
    type:
      - 'null'
      - string
    default: reference_free
    doc: 'Output file prefix. [Default = reference_free]'
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
  - id: alignment_files
    type:
      type: array
      items: File
    doc: 'Alignment (.aln) and, with -k, the aligned split kmers'
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
