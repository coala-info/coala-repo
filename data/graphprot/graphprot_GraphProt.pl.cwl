cwlVersion: v1.2
class: CommandLineTool
baseCommand: GraphProt.pl
label: graphprot_GraphProt.pl
doc: "GraphProt.pl -mode {regression,classification} -action {ls,cv,train,predict,predict_profile,predict_has,motif}\n\
  \nTool homepage: https://github.com/dmaticzka/graphprot"
inputs:
  - id: abstraction
    type:
      - 'null'
      - string
    doc: RNAshapes abstraction level [RNA structure graphs]
    inputBinding:
      position: 101
      prefix: -abstraction
  - id: action
    type: string
    doc: "what should GraphProt do?\n                         ls: optimize parameters\n\
      \                         cv: run a crossvalidation\n                      \
      \   train: train a model\n                         predict: predict binding
      for a whole site\n                         predict_profile: predict binding
      profiles\n                         predict_has: predict high-affinity sites\n\
      \                         motif: create sequence and structure motifs given
      a model"
    inputBinding:
      position: 101
      prefix: -action
  - id: affinities
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of affinities\n                         one value per line, same order
      as binding sites (fasta)"
    inputBinding:
      position: 101
      prefix: -affinities
  - id: bitsize
    type:
      - 'null'
      - int
    doc: GraphProt bitsize used for feature encoding
    inputBinding:
      position: 101
      prefix: -bitsize
  - id: c
    type:
      - 'null'
      - float
    doc: SVR parameter c       [regression]
    inputBinding:
      position: 101
      prefix: -c
  - id: distance
    type:
      - 'null'
      - int
    doc: GraphProt distance
    inputBinding:
      position: 101
      prefix: -D
  - id: epochs
    type:
      - 'null'
      - int
    doc: SGD parameter epochs  [classification]
    inputBinding:
      position: 101
      prefix: -epochs
  - id: epsilon
    type:
      - 'null'
      - float
    doc: SVR parameter epsilon [regression]
    inputBinding:
      position: 101
      prefix: -epsilon
  - id: fasta
    type:
      - 'null'
      - File
    doc: fasta file containing binding sites
    inputBinding:
      position: 101
      prefix: -fasta
  - id: lambda
    type:
      - 'null'
      - float
    doc: SGD parameter lambda  [classification]
    inputBinding:
      position: 101
      prefix: -lambda
  - id: mode
    type: string
    doc: "'regression' or 'classification'"
    inputBinding:
      position: 101
      prefix: -mode
  - id: model
    type:
      - 'null'
      - string
    doc: GraphProt model
    inputBinding:
      position: 101
      prefix: -model
  - id: motif_len
    type:
      - 'null'
      - int
    doc: set length of motifs
    inputBinding:
      position: 101
      prefix: -motif_len
  - id: motif_top_n
    type:
      - 'null'
      - int
    doc: use n top-scoring subsequences for motif creation
    inputBinding:
      position: 101
      prefix: -motif_top_n
  - id: negfasta
    type:
      - 'null'
      - File
    doc: fasta file containing negative class sequences
    inputBinding:
      position: 101
      prefix: -negfasta
  - id: onlyseq
    type:
      - 'null'
      - boolean
    doc: use GraphProt sequence models
    inputBinding:
      position: 101
      prefix: -onlyseq
  - id: params
    type:
      - 'null'
      - File
    doc: "parameter config file created by -action ls, alternatively\n           \
      \          use the following options to manually enter the desired\n       \
      \              parameters"
    inputBinding:
      position: 101
      prefix: -params
  - id: percentile
    type:
      - 'null'
      - int
    doc: "keep only regions with average score above a percentile\n              \
      \       as high-affinity sites"
    inputBinding:
      position: 101
      prefix: -percentile
  - id: prefix
    type:
      - 'null'
      - string
    doc: this prefix is used for all results
    inputBinding:
      position: 101
      prefix: -prefix
  - id: radius
    type:
      - 'null'
      - int
    doc: GraphProt radius
    inputBinding:
      position: 101
      prefix: -R
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphprot:1.1.7--py36_0
stdout: graphprot_GraphProt.pl.out
