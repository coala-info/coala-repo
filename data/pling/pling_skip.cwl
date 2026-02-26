cwlVersion: v1.2
class: CommandLineTool
baseCommand: pling
label: pling_skip
doc: "Integerisation method: \"align\" for alignment, \"skip\" to skip integerisation
  altogether. Make sure to input a unimog file if skipping integerisation.\n\nTool
  homepage: https://github.com/iqbal-lab-org/pling"
inputs:
  - id: genomes_list
    type: File
    doc: Path to list of fasta file paths.
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: Path to output directory.
    inputBinding:
      position: 2
  - id: method
    type: string
    doc: 'Integerisation method: "align" for alignment, "skip" to skip integerisation
      altogether. Make sure to input a unimog file if skipping integerisation.'
    inputBinding:
      position: 3
  - id: batch_size
    type:
      - 'null'
      - int
    doc: How many pairs of genomes to run together in one go (for integerisation
      from alignment and DCJ calculation steps).
    default: 200
    inputBinding:
      position: 104
      prefix: --batch_size
  - id: bh_connectivity
    type:
      - 'null'
      - int
    doc: Minimum number of connections a plasmid need to be considered a hub 
      plasmid.
    default: 10
    inputBinding:
      position: 104
      prefix: --bh_connectivity
  - id: bh_neighbours_edge_density
    type:
      - 'null'
      - float
    doc: Maximum number of edge density between hub plasmid neighbours to label 
      the plasmid as hub.
    default: 0.2
    inputBinding:
      position: 104
      prefix: --bh_neighbours_edge_density
  - id: containment_distance
    type:
      - 'null'
      - float
    doc: Threshold for initial containment network.
    default: 0.5
    inputBinding:
      position: 104
      prefix: --containment_distance
  - id: cores
    type:
      - 'null'
      - int
    doc: Total number of cores/threads. Put the maximum number of threads you 
      request in the resources tsv here. (This argument is passed on to 
      snakemake's --cores argument.)
    default: 1
    inputBinding:
      position: 104
      prefix: --cores
  - id: dcj
    type:
      - 'null'
      - int
    doc: Threshold for final DCJ-Indel network.
    default: 4
    inputBinding:
      position: 104
      prefix: --dcj
  - id: forceall
    type:
      - 'null'
      - boolean
    doc: Force snakemake to rerun everything.
    default: false
    inputBinding:
      position: 104
      prefix: --forceall
  - id: identity
    type:
      - 'null'
      - int
    doc: Threshold for percentage of shared sequence between blocks (for 
      integerisation from alignment and for containment calculation).
    default: 80
    inputBinding:
      position: 104
      prefix: --identity
  - id: ilp_solver
    type:
      - 'null'
      - string
    doc: ILP solver to use. Default is GLPK, which is slower but is bundled with
      pling and is free. If using gurobi, make sure you have a valid license and
      gurobi_cl is in your PATH.
    default: GLPK
    inputBinding:
      position: 104
      prefix: --ilp_solver
  - id: min_indel_size
    type:
      - 'null'
      - int
    doc: Minimum size for an indel to be treated as a block (for integerisation 
      from alignment).
    default: 200
    inputBinding:
      position: 104
      prefix: --min_indel_size
  - id: output_type
    type:
      - 'null'
      - string
    doc: Whether to output networks as html visualisations, cytoscape formatted 
      json, or both.
    default: html
    inputBinding:
      position: 104
      prefix: --output_type
  - id: plasmid_metadata
    type:
      - 'null'
      - File
    doc: Metadata to add beside plasmid ID on the visualisation graph. Must be a
      tsv with a single column, with data in the same order as in genomes_list.
    default: None
    inputBinding:
      position: 104
      prefix: --plasmid_metadata
  - id: profile
    type:
      - 'null'
      - string
    doc: To run on a cluster with corresponding snakemake profile.
    default: None
    inputBinding:
      position: 104
      prefix: --profile
  - id: regions
    type:
      - 'null'
      - boolean
    doc: Cluster regions rather than complete genomes. Assumes regions are taken
      from circular plasmids.
    default: false
    inputBinding:
      position: 104
      prefix: --regions
  - id: resources
    type:
      - 'null'
      - File
    doc: tsv stating number of threads and memory to use for each rule.
    default: None
    inputBinding:
      position: 104
      prefix: --resources
  - id: small_subcommunity_size_threshold
    type:
      - 'null'
      - int
    doc: Communities with size up to this parameter will be joined to 
      neighbouring larger subcommunities.
    default: 4
    inputBinding:
      position: 104
      prefix: --small_subcommunity_size_threshold
  - id: sourmash
    type:
      - 'null'
      - boolean
    doc: Run sourmash as first filter on which pairs to calculate DCJ on. 
      Recommended for large and very diverse datasets.
    default: false
    inputBinding:
      position: 104
      prefix: --sourmash
  - id: sourmash_threshold
    type:
      - 'null'
      - float
    doc: Threshold for filtering with sourmash.
    default: 0.85
    inputBinding:
      position: 104
      prefix: --sourmash_threshold
  - id: timelimit
    type:
      - 'null'
      - int
    doc: Time limit in seconds for ILP solver.
    default: None
    inputBinding:
      position: 104
      prefix: --timelimit
  - id: topology
    type:
      - 'null'
      - File
    doc: File stating whether plasmids are circular or linear. Must be a tsv 
      with two columns, one with plasmid IDs under "plasmid" and one with 
      "linear" or "circular" as entries under "topology". Without this file, 
      pling will asume all plasmids are circular.
    default: None
    inputBinding:
      position: 104
      prefix: --topology
  - id: unimog
    type:
      - 'null'
      - File
    doc: Path to unimog file. Required input if skipping integerisation.
    default: None
    inputBinding:
      position: 104
      prefix: --unimog
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pling:2.0.1--pyhdfd78af_0
stdout: pling_skip.out
