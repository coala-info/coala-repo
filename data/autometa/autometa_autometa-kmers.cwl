cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-kmers
label: autometa_autometa-kmers
doc: "Count k-mer frequencies of given `fasta`, then optionally normalize and embed them\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Metagenomic assembly fasta file"
    inputBinding:
      position: 1
      prefix: --fasta
  - id: kmers
    type:
      - 'null'
      - string
    doc: "K-mers frequency tab-delimited table to write"
    inputBinding:
      position: 1
      prefix: --kmers
  - id: size
    type:
      - 'null'
      - int
    doc: "k-mer size in bp (default: 5)"
    inputBinding:
      position: 1
      prefix: --size
  - id: norm_output
    type:
      - 'null'
      - string
    doc: "Path to normalized kmers table to write"
    inputBinding:
      position: 1
      prefix: --norm-output
  - id: norm_method
    type:
      - 'null'
      - string
    doc: "Normalization method prior to PCA and embedding (ilr, clr, am_clr) (default: am_clr)"
    inputBinding:
      position: 1
      prefix: --norm-method
  - id: pca_dimensions
    type:
      - 'null'
      - int
    doc: "Number of PCA dimensions after normalization and prior to embedding; 0 skips PCA (default: 50)"
    inputBinding:
      position: 1
      prefix: --pca-dimensions
  - id: embedding_output
    type:
      - 'null'
      - string
    doc: "Path to write embedded kmers table"
    inputBinding:
      position: 1
      prefix: --embedding-output
  - id: embedding_method
    type:
      - 'null'
      - string
    doc: "embedding method (sksne, bhsne, umap, densmap, trimap) (default: bhsne)"
    inputBinding:
      position: 1
      prefix: --embedding-method
  - id: embedding_dimensions
    type:
      - 'null'
      - int
    doc: "Number of dimensions of which to reduce k-mer frequencies (default: 2)"
    inputBinding:
      position: 1
      prefix: --embedding-dimensions
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Whether to overwrite existing annotations"
    inputBinding:
      position: 1
      prefix: --force
  - id: cpus
    type:
      - 'null'
      - int
    doc: "num. processors to use"
    inputBinding:
      position: 1
      prefix: --cpus
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed to set random state for dimension reduction determinism (default: 42)"
    inputBinding:
      position: 1
      prefix: --seed
outputs:
  - id: kmers_out
    type: File?
    doc: "K-mer counts table"
    outputBinding:
      glob: "${ return inputs.kmers ? inputs.kmers : []; }"
  - id: norm_out
    type: File?
    doc: "Normalized k-mer table"
    outputBinding:
      glob: "${ return inputs.norm_output ? inputs.norm_output : []; }"
  - id: embedding_out
    type: File?
    doc: "Embedded k-mer table"
    outputBinding:
      glob: "${ return inputs.embedding_output ? inputs.embedding_output : []; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
