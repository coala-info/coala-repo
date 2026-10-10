cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mitoz-tools
  - group_seq_by_gene
label: mitoz_tools_group_seq_by_gene
doc: "Group the gene sequences of different samples into different files by genes. The gene file list has one line per sample: 'Abbreviation geneFilePath'; the abbreviation is added to the seqid.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: gene_file_list
    type:
      - 'null'
      - File
    doc: "the gene file list. Per-line format: Abbreviation geneFilePath. The abbreviation will be added to the seqid to indicate different samples."
    inputBinding:
      position: 1
      prefix: -r
  - id: gene_files
    type: File[]
    doc: "The gene files named in the list (staged into the working directory so the names resolve)."
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "the delimiter between the abbreviation and the seqid [;]"
    inputBinding:
      position: 2
      prefix: -d
  - id: prefix
    type:
      - 'null'
      - string
    doc: "the prefix of all result files [MitoZ]"
    inputBinding:
      position: 3
      prefix: -p
  - id: clean_header
    type:
      - 'null'
      - boolean
    doc: "Only shows the 'Abbreviation' in the sequence header [False]"
    inputBinding:
      position: 4
      prefix: -clean_header
outputs:
  - id: grouped
    type:
      type: array
      items: File
    doc: "One FASTA file per gene."
    outputBinding:
      glob: '$((inputs.prefix ? inputs.prefix : "MitoZ") + "*")'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.gene_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
