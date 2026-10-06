cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-unclustered-recruitment
label: autometa_autometa-unclustered-recruitment
doc: "Recruit unclustered contigs given metagenome annotations and Autometa binning results. All tables must contain a 'contig' column.\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: kmers
    type: File
    doc: "Path to normalized kmer frequencies table."
    inputBinding:
      position: 1
      prefix: --kmers
  - id: coverage
    type: File
    doc: "Path to coverage table."
    inputBinding:
      position: 1
      prefix: --coverage
  - id: binning
    type: File
    doc: "Path to autometa binning output [will look for col='cluster']"
    inputBinding:
      position: 1
      prefix: --binning
  - id: markers
    type: File
    doc: "Path to domain-specific markers table."
    inputBinding:
      position: 1
      prefix: --markers
  - id: output_binning
    type: string
    doc: "Path to output unclustered recruitment table."
    inputBinding:
      position: 1
      prefix: --output-binning
  - id: output_main
    type:
      - 'null'
      - string
    doc: "Path to write Autometa main table used during/after unclustered recruitment."
    inputBinding:
      position: 1
      prefix: --output-main
  - id: output_features
    type:
      - 'null'
      - string
    doc: "Path to write Autometa features table used during unclustered recruitment."
    inputBinding:
      position: 1
      prefix: --output-features
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: "Path to taxonomy table."
    inputBinding:
      position: 1
      prefix: --taxonomy
  - id: taxa_dimensions
    type:
      - 'null'
      - int
    doc: "Num of dimensions to reduce taxonomy encodings"
    inputBinding:
      position: 1
      prefix: --taxa-dimensions
  - id: additional_features
    type:
      - 'null'
      - type: array
        items: File
    doc: "Path to additional features with which to add to classifier training data."
    inputBinding:
      position: 1
      prefix: --additional-features
  - id: confidence
    type:
      - 'null'
      - float
    doc: "Percent confidence to allow classification (default: 1.0)"
    inputBinding:
      position: 1
      prefix: --confidence
  - id: num_classifications
    type:
      - 'null'
      - int
    doc: "Num classifications for predicting/validating contig cluster recruitment (default: 10)"
    inputBinding:
      position: 1
      prefix: --num-classifications
  - id: classifier
    type:
      - 'null'
      - string
    doc: "classifier to use for recruitment of contigs (decision_tree, random_forest) (default: decision_tree)"
    inputBinding:
      position: 1
      prefix: --classifier
  - id: kmer_dimensions
    type:
      - 'null'
      - int
    doc: "Num of dimensions to reduce normalized k-mer frequencies (default: 50)"
    inputBinding:
      position: 1
      prefix: --kmer-dimensions
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed to use for RandomState when initializing classifiers. (default: 42)"
    inputBinding:
      position: 1
      prefix: --seed
outputs:
  - id: binning_out
    type: File
    doc: "Unclustered recruitment table"
    outputBinding:
      glob: "$(inputs.output_binning)"
  - id: main_out
    type: File?
    doc: "Autometa main table"
    outputBinding:
      glob: "${ return inputs.output_main ? inputs.output_main : []; }"
  - id: features_out
    type: File?
    doc: "Autometa features table"
    outputBinding:
      glob: "${ return inputs.output_features ? inputs.output_features : []; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
