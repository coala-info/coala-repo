cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit subtree
label: nwkit_subtree
doc: "Extract subtrees from a Newick file.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: dup_conf_score_threshold
    type:
      - 'null'
      - float
    doc: The threshold of duplication-confidence score for orthogroup 
      delimitation. 0 = most stringent, 1 = most relaxed. For the score, see 
      https://www.ensembl.org/info/genome/compara/homology_types.html
    inputBinding:
      position: 101
      prefix: --dup_conf_score_threshold
  - id: format
    type:
      - 'null'
      - int
    doc: ETE tree format. See here 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html
    inputBinding:
      position: 101
      prefix: --format
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
    inputBinding:
      position: 101
      prefix: --infile
  - id: leaves
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of leaves. The output subtree has their 
      most-recent common ancestor as the root. --left_leaf and --right_leaf are 
      ignored if this option is specified. Single leaf name may be specified in 
      combination with --orthogroup yes.
    inputBinding:
      position: 101
      prefix: --leaves
  - id: left_leaf
    type:
      - 'null'
      - string
    doc: Any leaf names in the left clade. For example, to extract the subtree 
      with the root node splitting Homo_sapiens and Mus_musculus, specify one of
      them (e.g., Homo_sapiens).
    inputBinding:
      position: 101
      prefix: --left_leaf
  - id: orthogroup
    type:
      - 'null'
      - string
    doc: The output subtree represents orthogroup(s) that contain all specified 
      leaves. The expected format of leaf names is "GENUS_SPECIES_OTHERINFO".
    inputBinding:
      position: 101
      prefix: --orthogroup
  - id: outformat
    type:
      - 'null'
      - int
    doc: ETE tree format for --outfile. "auto" indicates the same format as 
      --format.
    inputBinding:
      position: 101
      prefix: --outformat
  - id: quoted_node_names
    type:
      - 'null'
      - string
    doc: Whether node names are quoted in the input file.
    inputBinding:
      position: 101
      prefix: --quoted_node_names
  - id: right_leaf
    type:
      - 'null'
      - string
    doc: Any leaf names in the right clade. For example, to extract the subtree 
      with the root node splitting Homo_sapiens and Mus_musculus, specify the 
      other one that is not used as --left_leaf (e.g., Mus_musculus).
    inputBinding:
      position: 101
      prefix: --right_leaf
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
