cwlVersion: v1.2
class: CommandLineTool
baseCommand: 'TreeTime: Maximum Likelihood Phylodynamics homoplasy'
label: treetime_homoplasy
doc: "Reconstructs ancestral sequences and maps mutations to the tree. The tree is
  then scanned for homoplasies. An excess number of homoplasies might suggest contamination,
  recombination, culture adaptation or similar.\n\nTool homepage: https://github.com/neherlab/treetime"
inputs:
  - id: alignment_file
    type: File
    doc: alignment file (fasta)
    inputBinding:
      position: 101
      prefix: --aln
  - id: aminoacid_alphabet
    type:
      - 'null'
      - boolean
    doc: use aminoacid alphabet
    inputBinding:
      position: 101
      prefix: --aa
  - id: constant_sites
    type:
      - 'null'
      - int
    doc: number of constant sites not included in alignment
    inputBinding:
      position: 101
      prefix: --const
  - id: custom_gtr_file
    type:
      - 'null'
      - File
    doc: filename of pre-defined custom GTR model in standard TreeTime format
    inputBinding:
      position: 101
      prefix: --custom-gtr
  - id: detailed_report
    type:
      - 'null'
      - boolean
    doc: generate a more detailed report
    inputBinding:
      position: 101
      prefix: --detailed
  - id: drms_file
    type:
      - 'null'
      - File
    doc: 'TSV file containing DRM info. columns headers: GENOMIC_POSITION, ALT_BASE,
      DRUG, GENE, SUBSTITUTION'
    inputBinding:
      position: 101
      prefix: --drms
  - id: gtr_model
    type:
      - 'null'
      - string
    doc: GTR model to use. '--gtr infer' will infer a model from the data. 
      Alternatively, specify the model type. If the specified model requires 
      additional options, use '--gtr-params' to specify those.
    inputBinding:
      position: 101
      prefix: --gtr
  - id: gtr_params
    type:
      - 'null'
      - type: array
        items: string
    doc: "GTR parameters for the model specified by the --gtr argument. The parameters
      should be feed as 'key=value' list of parameters. Example: '--gtr K80 --gtr-params
      kappa=0.2 pis=0.25,0.25,0.25,0.25'. See the exact definitions of the parameters
      in the GTR creation methods in treetime/nuc_models.py or treetime/aa_models.py"
    inputBinding:
      position: 101
      prefix: --gtr-params
  - id: num_mutations_nodes
    type:
      - 'null'
      - int
    doc: number of mutations/nodes that are printed to screen
    inputBinding:
      position: 101
      prefix: -n
  - id: rescale
    type:
      - 'null'
      - float
    doc: rescale branch lengths
    inputBinding:
      position: 101
      prefix: --rescale
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: random number generator seed for treetime
    inputBinding:
      position: 101
      prefix: --rng-seed
  - id: tree
    type:
      - 'null'
      - File
    doc: Name of file containing the tree in newick, nexus, or phylip format, 
      the branch length of the tree should be in units of average number of 
      nucleotide or protein substitutions per site. If no file is provided, 
      treetime will attempt to build a tree from the alignment using fasttree, 
      iqtree, or raxml (assuming they are installed).
    inputBinding:
      position: 101
      prefix: --tree
  - id: vcf_reference
    type:
      - 'null'
      - File
    doc: 'only for vcf input: fasta file of the sequence the VCF was mapped to.'
    inputBinding:
      position: 101
      prefix: --vcf-reference
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity of output 0-6
    inputBinding:
      position: 101
      prefix: --verbose
  - id: zero_based_indexing
    type:
      - 'null'
      - boolean
    doc: zero based mutation indexing
    inputBinding:
      position: 101
      prefix: --zero-based
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: directory to write the output to
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
