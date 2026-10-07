cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - build_tree
label: cressent_build_tree
doc: "Build phylogenetic tree using IQ-TREE.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input_fasta
    type: File
    doc: "Input FASTA file with sequences."
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: "Number of bootstrap iterations (default: 1000)"
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: threads
    type:
      - 'null'
      - string
    doc: "Number of threads to use (default: AUTO)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: model
    type:
      - 'null'
      - string
    doc: "Substitution models (default: MFP - ModelFinder)"
    inputBinding:
      position: 101
      prefix: --model
  - id: keep_names
    type:
      - 'null'
      - boolean
    doc: "Keep only the first word of sequence IDs, otherwise it replaces space with _"
    inputBinding:
      position: 101
      prefix: --keep_names
  - id: extra_args
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --extra_args
    doc: "Extra arguments to pass directly to IQ-TREE (can be specified multiple times)"
    inputBinding:
      position: 101
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
