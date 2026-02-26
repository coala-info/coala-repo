cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur tree
label: augur_tree
doc: "Build a tree using a variety of methods. IQ-TREE specific: Strain names with
  spaces are modified to remove all characters after (and including) the first space.\n\
  \nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: alignment
    type: File
    doc: alignment in fasta or VCF format
    inputBinding:
      position: 101
      prefix: --alignment
  - id: exclude_sites
    type:
      - 'null'
      - File
    doc: file name of one-based sites to exclude for raw tree building (BED 
      format in .bed files, second column in tab-delimited files, or one 
      position per line)
    default: None
    inputBinding:
      position: 101
      prefix: --exclude-sites
  - id: method
    type:
      - 'null'
      - string
    doc: tree builder to use
    default: iqtree
    inputBinding:
      position: 101
      prefix: --method
  - id: nthreads
    type:
      - 'null'
      - string
    doc: maximum number of threads to use; specifying the value 'auto' will 
      cause the number of available CPU cores on your system, if determinable, 
      to be used
    default: '1'
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: override_default_args
    type:
      - 'null'
      - boolean
    doc: override default tree builder arguments with the values provided by the
      user in `--tree-builder-args` instead of augmenting the existing defaults.
    default: false
    inputBinding:
      position: 101
      prefix: --override-default-args
  - id: substitution_model
    type:
      - 'null'
      - string
    doc: substitution model to use. Specify 'auto' to run ModelTest. Currently, 
      only available for IQ-TREE.
    default: GTR
    inputBinding:
      position: 101
      prefix: --substitution-model
  - id: tree_builder_args
    type:
      - 'null'
      - string
    doc: 'arguments to pass to the tree builder either augmenting or overriding the
      default arguments (except for input alignment path, number of threads, and substitution
      model). Use the assignment operator (e.g., --tree-builder-args="--polytomy"
      for IQ-TREE) to avoid unexpected errors. FastTree defaults: "-nt -nosupport".
      RAxML defaults: "-f d -m GTRCAT -c 25 -p 235813". IQ-TREE defaults: "--ninit
      2 -n 2 --epsilon 0.05 -T AUTO --redo". Note that IQ-TREE will rewrite certain
      characters in FASTA deflines. In order to prevent this from breaking downstream
      analysis steps, `augur tree` preemptively rewrites conflicting deflines, and
      then restores them later. Unfortunately, this breaks the use of certain IQ-TREE
      options (e.g., `-g`) which rely on matching names between the FASTA and other
      input files.'
    default: None
    inputBinding:
      position: 101
      prefix: --tree-builder-args
  - id: vcf_reference
    type:
      - 'null'
      - File
    doc: fasta file of the sequence the VCF was mapped to
    default: None
    inputBinding:
      position: 101
      prefix: --vcf-reference
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: file name to write tree to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
