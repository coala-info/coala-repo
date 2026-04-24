cwlVersion: v1.2
class: CommandLineTool
baseCommand: 'TreeTime: Maximum Likelihood Phylodynamics ancestral'
label: treetime_ancestral
doc: "Reconstructs ancestral sequences and maps mutations to the tree. The output
  consists of a file 'ancestral.fasta' with ancestral sequences and a tree 'annotated_tree.nexus'
  with mutations added as comments like A45G,G136T,..., number in SNPs used 1-based
  index by default. The inferred GTR model is written to stdout.\n\nTool homepage:
  https://github.com/neherlab/treetime"
inputs:
  - id: alignment_file
    type: File
    doc: alignment file (fasta)
    inputBinding:
      position: 101
      prefix: --aln
  - id: aminoacid
    type:
      - 'null'
      - boolean
    doc: use aminoacid alphabet
    inputBinding:
      position: 101
      prefix: --aa
  - id: custom_gtr
    type:
      - 'null'
      - File
    doc: filename of pre-defined custom GTR model in standard TreeTime format
    inputBinding:
      position: 101
      prefix: --custom-gtr
  - id: gtr
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
  - id: keep_overhangs
    type:
      - 'null'
      - boolean
    doc: do not fill terminal gaps
    inputBinding:
      position: 101
      prefix: --keep-overhangs
  - id: marginal
    type:
      - 'null'
      - boolean
    doc: marginal reconstruction of ancestral sequences
    inputBinding:
      position: 101
      prefix: --marginal
  - id: method_anc
    type:
      - 'null'
      - string
    doc: method used for reconstructing ancestral sequences, default is 
      'probabilistic'
    inputBinding:
      position: 101
      prefix: --method-anc
  - id: reconstruct_tip_states
    type:
      - 'null'
      - boolean
    doc: overwrite ambiguous states on tips with the most likely inferred state
    inputBinding:
      position: 101
      prefix: --reconstruct-tip-states
  - id: report_ambiguous
    type:
      - 'null'
      - boolean
    doc: include transitions involving ambiguous states
    inputBinding:
      position: 101
      prefix: --report-ambiguous
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
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: zero based mutation indexing
    inputBinding:
      position: 101
      prefix: --zero-based
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: directory to write the output to
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
