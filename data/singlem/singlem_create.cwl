cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem create
label: singlem_create
doc: "Create a SingleM package.\n\nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: target_domains
    type:
      type: array
      items: string
    doc: "Input domains targeted by this package e.g. 'Archaea',\n               \
      \         'Bacteria', 'Eukaryota' or 'Viruses'. Input with\n               \
      \         multiple domains must be space separated."
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 102
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite output path if it already exists [default:\n                 \
      \       false]"
    default: false
    inputBinding:
      position: 102
      prefix: --force
  - id: gene_description
    type: string
    doc: "Input free form text description of this marker\n                      \
      \  package, for use with 'singlem metapackage\n                        --describe'."
    inputBinding:
      position: 102
      prefix: --gene-description
  - id: hmm_position
    type: int
    doc: "Position in the GraftM alignment HMM where the SingleM\n               \
      \         window starts. To choose the best position, use\n                \
      \        'singlem seqs'. Note that this position (both the one\n           \
      \             output by 'seqs' and the one specified here) is a\n          \
      \              1-based index, but this positions stored within the\n       \
      \                 SingleM package as a 0-based index."
    inputBinding:
      position: 102
      prefix: --hmm-position
  - id: input_graftm_package
    type: File
    doc: "Input GraftM package underlying the new SingleM\n                      \
      \  package. The GraftM package is usually made with\n                      \
      \  'graftM create --no_tree --hmm <your.hmm>' where\n                      \
      \  <your.hmm> is the one provided to 'singlem seqs'."
    inputBinding:
      position: 102
      prefix: --input-graftm-package
  - id: input_taxonomy
    type: File
    doc: "Input taxonomy file in GreenGenes format (2 column tab\n               \
      \         separated, ID then taxonomy with taxonomy separated by\n         \
      \               ';' or '; '."
    inputBinding:
      position: 102
      prefix: --input-taxonomy
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 102
      prefix: --quiet
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Length of NUCLEOTIDE residues in the window, counting\n                \
      \        only those that match the HMM [default: 60]"
    default: 60
    inputBinding:
      position: 102
      prefix: --window-size
outputs:
  - id: output_singlem_package
    type: File
    doc: Output package path
    outputBinding:
      glob: $(inputs.output_singlem_package)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
