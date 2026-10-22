cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - annotate
label: ska_annotate
doc: "Locate/annotate split kmers in a reference fasta/gff file\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: skf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Split kmer files to annotate'
    inputBinding:
      position: 1
  - id: include_repeats
    type:
      - 'null'
      - boolean
    doc: 'Include kmers in repetitive reference regions.'
    inputBinding:
      position: 101
      prefix: -i
  - id: include_product
    type:
      - 'null'
      - boolean
    doc: 'Include product in output.'
    inputBinding:
      position: 101
      prefix: -p
  - id: reference
    type: File
    doc: 'Reference fasta/gff file name. [Required]'
    inputBinding:
      position: 101
      prefix: -r
  - id: variants_only
    type:
      - 'null'
      - boolean
    doc: 'Only output variant sites.'
    inputBinding:
      position: 101
      prefix: -v
  - id: output_prefix
    type:
      - 'null'
      - string
    default: annotation
    doc: 'Output file prefix. [Default = annotation]'
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
  - id: annotation_files
    type:
      type: array
      items: File
    doc: 'Annotation output (.vcf)'
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
