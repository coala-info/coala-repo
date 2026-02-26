cwlVersion: v1.2
class: CommandLineTool
baseCommand: forwardGenomics.R
label: forwardgenomics_forwardGenomics.R
doc: "Forward Genomics: bold [0m\n\nTool homepage: https://github.com/hillerlab/ForwardGenomics"
inputs:
  - id: element_i_ds
    type: File
    doc: File listing the ID of each element (genomic region) that should be 
      processed. If you want to process all elements, you can get this list with
      'tail -n +2 globalPercentID.file | cut -f1 -d " "
    inputBinding:
      position: 101
      prefix: --elementIDs
  - id: expected_per_i_ds
    type:
      - 'null'
      - File
    doc: "File listing the expected %id values for each branch length. Must have a
      header 'len mPid'. Default is the file for coding exons: lookUpData/expPercentID_CDS.txt.
      Use lookUpData/expPercentID_CNE.txt for non-coding genomic regions."
    inputBinding:
      position: 101
      prefix: --expectedPerIDs
  - id: global_pid
    type:
      - 'null'
      - File
    doc: "Only if you run GLS: Space-separated input file with the global %id values
      arranged in elements (row) x species (columns). First column must be the element
      ID. The first line must start with 'species'."
    inputBinding:
      position: 101
      prefix: --globalPid
  - id: list_pheno
    type: File
    doc: File listing the phenotype for all species (all leaves in the tree). 
      Must be a space-separated file the header 'species pheno', where 0 means 
      trait is lost and 1 means trait is present.
    inputBinding:
      position: 101
      prefix: --listPheno
  - id: local_pid
    type:
      - 'null'
      - File
    doc: "Only if you run the branch method: Space-separated input file with the local
      %id values. Must have the header 'branch id pid'. One line per element and per
      branch."
    inputBinding:
      position: 101
      prefix: --localPid
  - id: method
    type:
      - 'null'
      - string
    doc: Which method to run. GLS includes computing the margin of the 
      perfect-match method. Default is all.
    default: all
    inputBinding:
      position: 101
      prefix: --method
  - id: min_losses
    type:
      - 'null'
      - int
    doc: In case of missing data (no %id value for some species) only consider 
      elements where at least this many independent loss events are supported 
      with %id values. Can be used to exclude lineage-specific losses. Default 2
    default: 2
    inputBinding:
      position: 101
      prefix: --minLosses
  - id: out_path
    type:
      - 'null'
      - Directory
    doc: If verbose==TRUE, this directory will be created and will contain 
      scatter plots for each element. If verbose==FALSE, this parameter has no 
      effect. Default directory '.'
    default: .
    inputBinding:
      position: 101
      prefix: --outPath
  - id: threshold_conserved
    type:
      - 'null'
      - float
    doc: 'Some element may have large indels on internal conserved branches, but descendant
      branches are highly conserved. We reject genomic elements if a local %id value
      is lower than this threshold for a conserved branch. Set to 0 to ignore this.
      Default: 0.5'
    default: 0.5
    inputBinding:
      position: 101
      prefix: --thresholdConserved
  - id: transf
    type:
      - 'null'
      - string
    doc: Whether to use raw global %id values or normalize them for the 
      differences in evolutionary rates. Default normalized
    default: normalized
    inputBinding:
      position: 101
      prefix: --transf
  - id: tree
    type: File
    doc: Phylogenetic tree with branch lengths in newick format. The species 
      names must be identical to the names in the percent ID files. Ancestors 
      must be named (otherwise use tree_doctor -a)
    inputBinding:
      position: 101
      prefix: --tree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show much more info and create plots for each element. Default is FALSE
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
  - id: weights
    type:
      - 'null'
      - File
    doc: "File listing the weights per branch. Must have a header 'len w'. Default
      is the file for coding exons: lookUpData/branchWeights_CDS.txt. Use lookUpData/branchWeights_CNE.txt
      for non-coding genomic regions."
    inputBinding:
      position: 101
      prefix: --weights
outputs:
  - id: out_file
    type: File
    doc: Output file that will contain the element ID and the P-values from the 
      methods.
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/forwardgenomics:1.0--hdfd78af_0
