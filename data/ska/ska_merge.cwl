cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - merge
label: ska_merge
doc: "Merge split kmer file(s) into one file\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: skf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Split kmer files to merge'
    inputBinding:
      position: 1
  - id: sample_names
    type:
      - 'null'
      - File
    doc: 'File of sample names to include in the merged file. Can be used to extract samples from a merge'
    inputBinding:
      position: 101
      prefix: -s
  - id: output_prefix
    type:
      - 'null'
      - string
    default: merged
    doc: 'Output file prefix. [Default = merged]'
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
  - id: merged_skf
    type: File
    doc: 'Merged split kmer file'
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
