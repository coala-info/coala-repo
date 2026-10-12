cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PanACoTA
  - tree
label: panacota_tree
doc: "Infer a phylogenetic tree from the core or persistent genome alignment with FastTree, FastME, QuickTree, IQ-TREE or IQ-TREE 2.

Tool homepage: https://github.com/gem-pasteur/PanACoTA"
inputs:
  - id: alignment
    type: File
    doc: "Alignment file in multi-fasta: each header is a leaf of the tree."
    inputBinding:
      prefix: -a
  - id: outdir
    type: string
    doc: "Directory where the tree results are saved."
    inputBinding:
      prefix: -o
  - id: soft
    type:
      - 'null'
      - string
    doc: "Software to infer the tree: fasttree, fastme, quicktree, iqtree or iqtree2 (default iqtree2)."
    inputBinding:
      prefix: --soft
  - id: boot
    type:
      - 'null'
      - int
    doc: "Number of bootstraps (default: none). With IQ-TREE it uses ultrafast bootstrap (1000 or more)."
    inputBinding:
      prefix: --boot
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default 1). Use 0 for all threads. Not available with quicktree."
    inputBinding:
      prefix: --threads
  - id: model
    type:
      - 'null'
      - string
    doc: "DNA substitution model. Default GTR for FastTree and IQ-TREE, F84 for FastME."
    inputBinding:
      prefix: --model
  - id: write_boot
    type:
      - 'null'
      - boolean
    doc: "Write all bootstrap pseudo-trees (FastME and IQ-TREE only)."
    inputBinding:
      prefix: -B
  - id: dist_matrix
    type:
      - 'null'
      - boolean
    doc: "Write the distance matrix (FastME only)."
    inputBinding:
      prefix: -M
  - id: memory
    type:
      - 'null'
      - string
    doc: "Maximal RAM usage in GB or MB (IQ-TREE only)."
    inputBinding:
      prefix: --mem
  - id: fast
    type:
      - 'null'
      - boolean
    doc: "Use the -fast option of IQ-TREE."
    inputBinding:
      prefix: -fast
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity in stdout/stderr and log files."
    inputBinding:
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not display anything to stdout/stderr. Log files are still created."
    inputBinding:
      prefix: --quiet
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with the tree file and logs."
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
stdout: panacota_tree.out
