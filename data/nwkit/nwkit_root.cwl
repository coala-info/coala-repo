cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit_root
label: nwkit_root
doc: "Root a newick tree.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: format
    type:
      - 'null'
      - int
    doc: ETE tree format. See here 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html
    inputBinding:
      position: 101
      prefix: --format
  - id: format2
    type:
      - 'null'
      - int
    doc: ETE tree format for --infile2.
    inputBinding:
      position: 101
      prefix: --format2
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
    inputBinding:
      position: 101
      prefix: --infile
  - id: infile2
    type:
      - 'null'
      - File
    doc: Input newick file 2. Used when --method "transfer". Leaf labels should 
      be matched to those in --infile.
    inputBinding:
      position: 101
      prefix: --infile2
  - id: method
    type:
      - 'null'
      - string
    doc: 'midpoint: Midpoint rooting. outgroup: Outgroup rooting with --outgroup.
      transfer: Transfer the root position from --infile2 to --infile. The two trees
      should have the same bipartitions at the root node. mad: Minimal Ancestor Deviation
      rooting (Tria et al. 2017). mv: Minimum Variance rooting (Mai et al. 2017).'
    inputBinding:
      position: 101
      prefix: --method
  - id: outformat
    type:
      - 'null'
      - int
    doc: ETE tree format for --outfile. "auto" indicates the same format as 
      --format.
    inputBinding:
      position: 101
      prefix: --outformat
  - id: outgroup
    type:
      - 'null'
      - string
    doc: An outgroup label or a comma-separated list of outgroup labels. For the
      latter, the clade containing all specified labels are used as an outgroup,
      so all labels do not have to be specified for a large clade.
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: quoted_node_names
    type:
      - 'null'
      - string
    doc: Whether node names are quoted in the input file.
    inputBinding:
      position: 101
      prefix: --quoted_node_names
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output newick file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
