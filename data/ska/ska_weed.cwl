cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - weed
label: ska_weed
doc: "Weed kmers from a split kmer file\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: skf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Split kmer files to weed'
    inputBinding:
      position: 1
  - id: weed_set
    type: File
    doc: 'Name of kmer file containing kmers to be weeded. [Required]'
    inputBinding:
      position: 101
      prefix: -i
  - id: min_samples
    type:
      - 'null'
      - int
    doc: 'Minimum number of samples required to possess a split kmer for that kmer to be retained. [Default = 0]'
    inputBinding:
      position: 101
      prefix: -m
  - id: max_samples
    type:
      - 'null'
      - int
    doc: 'Maximum number of samples required to possess a split kmer for that kmer to be retained. 0 = No maximum. [Default = 0]'
    inputBinding:
      position: 101
      prefix: -M
  - id: min_proportion
    type:
      - 'null'
      - float
    doc: 'Minimum proportion of samples required to possess a split kmer for that kmer to be retained. [Default = 0.0]'
    inputBinding:
      position: 101
      prefix: -p
  - id: max_proportion
    type:
      - 'null'
      - float
    doc: 'Maximum proportion of samples required to possess a split kmer for that kmer to be retained. [Default = 1.0]'
    inputBinding:
      position: 101
      prefix: -P
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
  - id: weeded_files
    type:
      type: array
      items: File
    doc: 'Weeded split kmer files (<input>.weeded.skf)'
    outputBinding:
      glob: '*.weeded.skf'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '${ return inputs.list_files ? inputs.list_files : []; }'
      - entry: '${ return inputs.skf_files ? inputs.skf_files : []; }'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska:1.0--h077b44d_7
