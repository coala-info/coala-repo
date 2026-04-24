cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - cluster
label: hotspot3d_cluster
doc: "Cluster mutation-mutation, mutation-drug, or mutation-site pairs using network
  or density-based methods.\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: amino_acid_header
    type:
      - 'null'
      - string
    doc: .maf file column header for amino acid changes
    inputBinding:
      position: 101
      prefix: --amino-acid-header
  - id: clustering
    type:
      - 'null'
      - string
    doc: Cluster using network or density-based methods (network or density)
    inputBinding:
      position: 101
      prefix: --clustering
  - id: distance_matrix_json_file
    type:
      - 'null'
      - File
    doc: JSON encoded distance-matrix hash file produced by a previous cluster 
      run
    inputBinding:
      position: 101
      prefix: --distance-matrix-json-file
  - id: distance_measure
    type:
      - 'null'
      - string
    doc: Pair distance to use (shortest or average)
    inputBinding:
      position: 101
      prefix: --distance-measure
  - id: drug_clean_file
    type:
      - 'null'
      - File
    doc: A .drugs.*target.clean file with mutation-drug pairs (provide maf-file)
    inputBinding:
      position: 101
      prefix: --drug-clean-file
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Epsilon value
    inputBinding:
      position: 101
      prefix: --Epsilon
  - id: gene_list_file
    type:
      - 'null'
      - File
    doc: Choose mutations from the genes given in this list
    inputBinding:
      position: 101
      prefix: --gene-list-file
  - id: hup_file
    type:
      - 'null'
      - File
    doc: hugo.uniprot.pdb.csv file location (required if --vertex-type=site or 
      --clustering=density)
    inputBinding:
      position: 101
      prefix: --hup-file
  - id: length_scale
    type:
      - 'null'
      - float
    doc: Length scale used to control scoring of vertices
    inputBinding:
      position: 101
      prefix: --length-scale
  - id: linear_cutoff
    type:
      - 'null'
      - int
    doc: Linear distance cutoff (> peptides)
    inputBinding:
      position: 101
      prefix: --linear-cutoff
  - id: maf_file
    type:
      - 'null'
      - File
    doc: .maf file used in proximity search step; necessary for pairwise, 
      drug-clean, or musites pair data
    inputBinding:
      position: 101
      prefix: --maf-file
  - id: max_processes
    type:
      - 'null'
      - int
    doc: Set if using parallel type local
    inputBinding:
      position: 101
      prefix: --max-processes
  - id: max_radius
    type:
      - 'null'
      - float
    doc: Maximum cluster radius (max network geodesic from centroid, <= 
      Angstroms)
    inputBinding:
      position: 101
      prefix: --max-radius
  - id: meric_type
    type:
      - 'null'
      - string
    doc: Clusters for each intra-molecular, monomer, homomer, inter-molecular, 
      heteromer, multimer, or any *mer
    inputBinding:
      position: 101
      prefix: --meric-type
  - id: min_pts
    type:
      - 'null'
      - int
    doc: MinPts
    inputBinding:
      position: 101
      prefix: --MinPts
  - id: musites_file
    type:
      - 'null'
      - File
    doc: A .musites file with mutation-site pairs (provide maf-file and 
      site-file)
    inputBinding:
      position: 101
      prefix: --musites-file
  - id: mutations_hash_json_file
    type:
      - 'null'
      - File
    doc: JSON encoded mutations hash file produced by a previous cluster run
    inputBinding:
      position: 101
      prefix: --mutations-hash-json-file
  - id: number_of_runs
    type:
      - 'null'
      - int
    doc: Number of density clustering runs to perform before the cluster 
      membership probability being calculated
    inputBinding:
      position: 101
      prefix: --number-of-runs
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: P_value cutoff (<)
    inputBinding:
      position: 101
      prefix: --p-value-cutoff
  - id: pairwise_file
    type:
      - 'null'
      - File
    doc: A .pairwise file with mutation-mutation pairs (provide maf-file)
    inputBinding:
      position: 101
      prefix: --pairwise-file
  - id: parallel
    type:
      - 'null'
      - string
    doc: Parallelization for structure and subunit dependent runs (none or 
      local)
    inputBinding:
      position: 101
      prefix: --parallel
  - id: probability_cut_off
    type:
      - 'null'
      - float
    doc: Clusters will be formed with variants having at least this probability
    inputBinding:
      position: 101
      prefix: --probability-cut-off
  - id: site_vertex_map_json_file
    type:
      - 'null'
      - File
    doc: JSON encoded siteVertexMap hash file produced by a previous cluster run
    inputBinding:
      position: 101
      prefix: --siteVertexMap-json-file
  - id: sites_file
    type:
      - 'null'
      - File
    doc: A .sites file with site-site pairs
    inputBinding:
      position: 101
      prefix: --sites-file
  - id: structure_dependent
    type:
      - 'null'
      - boolean
    doc: Clusters for each structure or across all structures
    inputBinding:
      position: 101
      prefix: --structure-dependent
  - id: structure_list_file
    type:
      - 'null'
      - File
    doc: Choose mutations from the structures given in this list
    inputBinding:
      position: 101
      prefix: --structure-list-file
  - id: subunit_dependent
    type:
      - 'null'
      - boolean
    doc: Clusters for each subunit or across all subunits
    inputBinding:
      position: 101
      prefix: --subunit-dependent
  - id: three_d_distance_cutoff
    type:
      - 'null'
      - float
    doc: 3D distance cutoff (<)
    inputBinding:
      position: 101
      prefix: --3d-distance-cutoff
  - id: transcript_id_header
    type:
      - 'null'
      - string
    doc: .maf file column header for transcript id's
    inputBinding:
      position: 101
      prefix: --transcript-id-header
  - id: use_json
    type:
      - 'null'
      - boolean
    doc: Use pre-encoded mutations and distance-matrix hashes in json format
    inputBinding:
      position: 101
      prefix: --use-JSON
  - id: vertex_score
    type:
      - 'null'
      - string
    doc: Vertex score system to use (centrality, exponentials)
    inputBinding:
      position: 101
      prefix: --vertex-score
  - id: vertex_type
    type:
      - 'null'
      - string
    doc: Graph vertex type for network-based clustering (recurrence, unique, 
      site or weight)
    inputBinding:
      position: 101
      prefix: --vertex-type
  - id: weight_header
    type:
      - 'null'
      - string
    doc: .maf file column header for mutation weight (used if vertex-type = 
      weight)
    inputBinding:
      position: 101
      prefix: --weight-header
  - id: weight_scale
    type:
      - 'null'
      - float
    doc: Weight scale used to control scoring of vertices
    inputBinding:
      position: 101
      prefix: --weight-scale
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Output prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
