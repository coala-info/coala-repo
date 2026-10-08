cwlVersion: v1.2
class: CommandLineTool
baseCommand: trainGlimmerHMM
label: glimmerhmm_trainGlimmerHMM
doc: "Train GlimmerHMM on a multi-FASTA file and a file of exon coordinates\n\nTool homepage: https://github.com/kblin/glimmerhmm"
inputs:
  - id: mfasta_file
    type: File
    doc: "Multi-FASTA file with the sequences for training"
    inputBinding:
      position: 10
  - id: exon_file
    type: File
    doc: "File with the exon coordinates relative to the sequences in the multi-FASTA file; genes are separated by a blank line"
    inputBinding:
      position: 11
  - id: isochores
    type:
      - 'null'
      - string
    doc: "isochores to be considered, e.g. 0,40,100 (default is 0,100)"
    inputBinding:
      position: 12
      prefix: -i
  - id: training_dir_name
    type: string
    doc: "name of the training directory to create"
    default: trained
    inputBinding:
      position: 12
      prefix: -d
  - id: upstream_utr
    type:
      - 'null'
      - float
    doc: "average value of upstream UTR region if known"
    inputBinding:
      position: 12
      prefix: -f
  - id: downstream_utr
    type:
      - 'null'
      - float
    doc: "average value of downstream UTR region if known"
    inputBinding:
      position: 12
      prefix: -l
  - id: intergenic
    type:
      - 'null'
      - float
    doc: "average value of intergenic region if known"
    inputBinding:
      position: 12
      prefix: -n
  - id: flanking
    type:
      - 'null'
      - int
    doc: "value of flanking region around genes (default=200)"
    inputBinding:
      position: 12
      prefix: -v
  - id: markov_order
    type:
      - 'null'
      - int
    doc: "build 1st or 2nd order markov model (default=1)"
    inputBinding:
      position: 12
      prefix: -b
  - id: decision_trees
    type:
      - 'null'
      - int
    doc: "1 when constructing decision trees from false.* files (default=0)"
    inputBinding:
      position: 12
      prefix: -t
outputs:
  - id: training_dir
    type: Directory
    doc: "Training directory for glimmerhmm"
    outputBinding:
      glob: $(inputs.training_dir_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimmerhmm:3.0.4--pl5321h503566f_10
