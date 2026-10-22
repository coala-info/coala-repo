cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - distance
label: ska_distance
doc: "Pairwise distance calculation and clustering from split kmer files\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: skf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Split kmer file(s)'
    inputBinding:
      position: 1
  - id: no_clusters
    type:
      - 'null'
      - boolean
    doc: 'Do not print clusters files.'
    inputBinding:
      position: 101
      prefix: -c
  - id: no_distances
    type:
      - 'null'
      - boolean
    doc: 'Do not print distances file.'
    inputBinding:
      position: 101
      prefix: -d
  - id: identity_cutoff
    type:
      - 'null'
      - float
    doc: 'Identity cutoff for defining clusters. Isolates will be clustered if they share at least this proportion of the split kmers in the file with fewer kmers and pass the SNP cutoff. [Default = 0.9]'
    inputBinding:
      position: 101
      prefix: -i
  - id: snp_cutoff
    type:
      - 'null'
      - int
    doc: 'SNP cutoff for defining clusters. Isolates will be clustered if they are separated by fewer than this number of SNPs and pass the identity cutoff. [Default = 20]'
    inputBinding:
      position: 101
      prefix: -s
  - id: include_singletons
    type:
      - 'null'
      - boolean
    doc: 'Include singletons in dot file'
    inputBinding:
      position: 101
      prefix: -S
  - id: output_prefix
    type:
      - 'null'
      - string
    default: distances
    doc: 'Output file prefix. [Default = distances]'
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
  - id: distance_files
    type:
      type: array
      items: File
    doc: 'Distance and cluster files'
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
