cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit_constrain
label: nwkit_constrain
doc: "Constrain a newick tree based on taxonomic information.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: backbone
    type:
      - 'null'
      - string
    doc: 'The backbone for tree constraint. --infile is not required except for "user".
      ncbi: Infer NCBI Taxonomy ID from species name, and generate a tree based on
      the ranks. ncbi_apgiv: Infer NCBI Taxonomy ID from species name, and match it
      with the order-level angiosperm phylogeny in APG IV (https://doi.org/10.1111/boj.12385).
      ncbi_user: Infer NCBI Taxonomy ID from species name, and match the ranks with
      the labels of the user-provided tree. user: User-provided tree in --infile.'
    default: ncbi
    inputBinding:
      position: 101
      prefix: --backbone
  - id: collapse
    type:
      - 'null'
      - string
    doc: For tip names of "GENUS_SPECIES_OTHERINFO", drop OTHERINFO and collapse
      clades if GENUS_SPECIES is identical. The output file may be used as a 
      species tree for phylogeny reconciliation.
    default: no
    inputBinding:
      position: 101
      prefix: --collapse
  - id: format
    type:
      - 'null'
      - int
    doc: ETE tree format. See here 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html
    default: auto
    inputBinding:
      position: 101
      prefix: --format
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
    default: '-'
    inputBinding:
      position: 101
      prefix: --infile
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
    default: yes
    inputBinding:
      position: 101
      prefix: --quoted_node_names
  - id: rank
    type:
      - 'null'
      - string
    doc: Constrain at a particular taxonomic rank and above. For example, if 
      "family" is specified, "genus" and "species" are not considered. This 
      option is currently compatible only with --backbone ncbi
    default: no
    inputBinding:
      position: 101
      prefix: --rank
  - id: species_list
    type:
      - 'null'
      - File
    doc: Text file containing species names, one per line. Expected formats are 
      "GENUS SPECIES", "GENUS_SPECIES", or "GENUS_SPECIES_OTHERINFO". e.g., 
      "Arabidopsis thaliana" and "Arabidopsis_thaliana_TAIR10"
    default: None
    inputBinding:
      position: 101
      prefix: --species_list
  - id: taxid_tsv
    type:
      - 'null'
      - File
    doc: TSV file containing species names in the "leaf_name" column and their 
      NCBI Taxonomy IDs in the "taxid" column. When specified, the provided NCBI
      Taxonomy IDs are used instead of inferring them from species names. Either
      --species_list or --taxid_tsv must be specified, but not both. This option
      is currently compatible only with --backbone ncbi.
    default: None
    inputBinding:
      position: 101
      prefix: --taxid_tsv
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
