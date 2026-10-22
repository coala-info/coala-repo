cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - map
label: ska_map
doc: "Align split kmer file(s) against a reference fasta file\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: skf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Split kmer file(s)'
    inputBinding:
      position: 1
  - id: map_all_bases
    type:
      - 'null'
      - boolean
    doc: 'Map all bases of kmers (Default = just map middle base).'
    inputBinding:
      position: 101
      prefix: -a
  - id: circular
    type:
      - 'null'
      - boolean
    doc: 'Treat all reference contigs as circular.'
    inputBinding:
      position: 101
      prefix: -c
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'Split kmer size. Must be the same value used to create the kmer files. [Default = 15]'
    inputBinding:
      position: 101
      prefix: -k
  - id: include_reference
    type:
      - 'null'
      - boolean
    doc: 'Include reference sequence in alignment.'
    inputBinding:
      position: 101
      prefix: -i
  - id: map_repeats
    type:
      - 'null'
      - boolean
    doc: 'Map bases to repeats rather than making them N.'
    inputBinding:
      position: 101
      prefix: -m
  - id: reference
    type: File
    doc: 'Reference fasta file name. [Required]'
    inputBinding:
      position: 101
      prefix: -r
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
    default: mappedkmers
    doc: 'Output file prefix. [Default = mappedkmers]'
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
    doc: 'Mapped alignment (.aln)'
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
