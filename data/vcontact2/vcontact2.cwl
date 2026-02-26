cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcontact2
label: vcontact2
doc: "vConTACT2 (viral Contig Automatic Cluster Taxonomy) is tool to perform \"Guilt-by-contig-association\"\
  \ automatic classification of viral contigs.\n\nTool homepage: https://bitbucket.org/MAVERICLab/vcontact2"
inputs:
  - id: blast_fp
    type:
      - 'null'
      - File
    doc: Blast results file in CSV or TSV format. Used for generating the 
      protein clusters. If provided alongside --proteins-fn, vConTACT will start
      from the PC- generation step. If raw proteins are provided, THIS WILL BE 
      SKIPPED. Reference DBs CANNOT BE USED IF THIS OPTION IS ENABLED!!
    default: None
    inputBinding:
      position: 101
      prefix: --blast-fp
  - id: blastp_bin
    type:
      - 'null'
      - File
    doc: Location for BLASTP executable. Path only used if vConTACT cant find in
      $PATH.
    default: None
    inputBinding:
      position: 101
      prefix: --blastp-bin
  - id: c1_bin
    type:
      - 'null'
      - File
    doc: Location for clusterONE file. Path only used if vConTACT cant find in 
      $PATH.
    default: None
    inputBinding:
      position: 101
      prefix: --c1-bin
  - id: cluster_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Id of the clusters to export (Cytoscape export only).
    default:
      - '0'
    inputBinding:
      position: 101
      prefix: --cluster-filter
  - id: contigs
    type:
      - 'null'
      - File
    doc: Contig info file (tsv or csv)
    default: None
    inputBinding:
      position: 101
      prefix: --contigs
  - id: criterion
    type:
      - 'null'
      - string
    doc: Pooling criterion for cluster export (Cytoscape export only).
    default: predicted_family
    inputBinding:
      position: 101
      prefix: --criterion
  - id: db
    type:
      - 'null'
      - string
    doc: Select a reference database to de novo cluster proteins against. If 
      'None' selected, be aware that there will be no references included in the
      analysis.
    default: ProkaryoticViralRefSeq85-ICTV
    inputBinding:
      position: 101
      prefix: --db
  - id: diamond_bin
    type:
      - 'null'
      - File
    doc: Location for DIAMOND executable. Path only used if vConTACT cant find 
      in $PATH.
    default: None
    inputBinding:
      position: 101
      prefix: --diamond-bin
  - id: exports
    type:
      - 'null'
      - type: array
        items: string
    doc: Export backend. Suported values are "csv", "krona" and "cytoscape"
    default:
      - csv
    inputBinding:
      position: 101
      prefix: --exports
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files
    default: false
    inputBinding:
      position: 101
      prefix: --force-overwrite
  - id: haircut
    type:
      - 'null'
      - float
    doc: Apply a haircut transformation as a post-processing step on the 
      detected clusters. A haircut transformation removes dangling nodes from a 
      cluster. (ClusterONE only)
    default: 0.1
    inputBinding:
      position: 101
      prefix: --haircut
  - id: link_prop
    type:
      - 'null'
      - float
    doc: Proportion of a module's PC a contig must have to be considered as 
      displaying this module.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --link-prop
  - id: link_sig
    type:
      - 'null'
      - float
    doc: Significitaivity threshold to link a cluster and a module
    default: 1.0
    inputBinding:
      position: 101
      prefix: --link-sig
  - id: max_overlap
    type:
      - 'null'
      - float
    doc: Specifies the maximum allowed overlap between two clusters. (ClusterONE
      only)
    default: 0.8
    inputBinding:
      position: 101
      prefix: --max-overlap
  - id: max_sig
    type:
      - 'null'
      - int
    doc: Significance threshold in the contig similarity network.
    default: 300
    inputBinding:
      position: 101
      prefix: --max-sig
  - id: merge_method
    type:
      - 'null'
      - string
    doc: Specifies the method to be used to merge highly overlapping complexes. 
      (ClusterONE only)
    default: single
    inputBinding:
      position: 101
      prefix: --merge-method
  - id: min_density
    type:
      - 'null'
      - float
    doc: Sets the minimum density of predicted complexes. (ClusterONE only)
    default: 0.3
    inputBinding:
      position: 101
      prefix: --min-density
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum size for the Viral Cluster.
    default: 2
    inputBinding:
      position: 101
      prefix: --min-size
  - id: mod_inflation
    type:
      - 'null'
      - float
    doc: Inflation parameter to define protein modules with MCL.
    default: 5.0
    inputBinding:
      position: 101
      prefix: --mod-inflation
  - id: mod_shared_min
    type:
      - 'null'
      - int
    doc: Minimal number (inclusive) of contigs a PC must appear into to be taken
      into account in the modules computing.
    default: 3
    inputBinding:
      position: 101
      prefix: --mod-shared-min
  - id: mod_sig
    type:
      - 'null'
      - float
    doc: Significance threshold in the protein cluster similarity network.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --mod-sig
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: Optimize hierarchical distances during second-pass of the viral 
      clusters
    default: false
    inputBinding:
      position: 101
      prefix: --optimize
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: vContact_Output
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: pc_evalue
    type:
      - 'null'
      - float
    doc: E-value used by BLASTP or Diamond when creating the protein-protein 
      similarity network.
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --pc-evalue
  - id: pc_inflation
    type:
      - 'null'
      - float
    doc: 'Inflation value to define proteins clusters with MCL. (default: 2.0) (MCL
      only)'
    default: 2.0
    inputBinding:
      position: 101
      prefix: --pc-inflation
  - id: pc_profiles
    type:
      - 'null'
      - File
    doc: Protein cluster profiles of the contigs (tsv or csv)
    default: None
    inputBinding:
      position: 101
      prefix: --pc-profiles
  - id: pcs
    type:
      - 'null'
      - File
    doc: Protein clusters info file (tsv or csv)
    default: None
    inputBinding:
      position: 101
      prefix: --pcs
  - id: pcs_mode
    type:
      - 'null'
      - string
    doc: Whether to use ClusterONE or MCL for Protein Cluster (PC) generation.
    default: MCL
    inputBinding:
      position: 101
      prefix: --pcs-mode
  - id: penalty
    type:
      - 'null'
      - float
    doc: Sets a penalty value for the inclusion of each node. It can be used to 
      model the possibility of uncharted connections for each node, so nodes 
      with only a single weak connection to a cluster will not be added to the 
      cluster as the penalty value will outweigh the benefits of adding the 
      node. (ClusterONE only)
    default: 2.0
    inputBinding:
      position: 101
      prefix: --penalty
  - id: permissive
    type:
      - 'null'
      - boolean
    doc: Use permissive affiliation for associating VCs with reference 
      sequences.
    default: false
    inputBinding:
      position: 101
      prefix: --permissive
  - id: proteins_fp
    type:
      - 'null'
      - File
    doc: A file linking the protein name (as in the blast file) and the genome 
      names (csv or tsv). If provided alongside --blast-fp, vConTACT will start 
      from the PC-generation step. If provided alongside --raw-proteins, 
      vConTACT will start from creating the all-verses-all protein comparison 
      and then generate protein clusters.
    default: None
    inputBinding:
      position: 101
      prefix: --proteins-fp
  - id: raw_proteins
    type:
      - 'null'
      - File
    doc: FASTA-formatted proteins file. If provided alongside --proteins-fn, 
      vConTACT will start prior to PC generation.
    default: None
    inputBinding:
      position: 101
      prefix: --raw-proteins
  - id: rel_mode
    type:
      - 'null'
      - string
    doc: Method to use to create the protein-protein similarity edge file. This 
      is what the PC clustering is applied against.
    default: Diamond
    inputBinding:
      position: 101
      prefix: --rel-mode
  - id: reported_alignments
    type:
      - 'null'
      - int
    doc: Maximum number of target sequences per query to report alignments for 
      in Diamond.
    default: 25
    inputBinding:
      position: 101
      prefix: --reported-alignments
  - id: seed_method
    type:
      - 'null'
      - string
    doc: Specifies the seed generation method to use. (ClusterONE only)
    default: nodes
    inputBinding:
      position: 101
      prefix: --seed-method
  - id: sig
    type:
      - 'null'
      - float
    doc: Significance threshold in the contig similarity network.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --sig
  - id: similarity
    type:
      - 'null'
      - string
    doc: Specifies the similarity function to be used in the merging step. 
      (ClusterONE only)
    default: match
    inputBinding:
      position: 101
      prefix: --similarity
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use. If nothing is provided, vConTACT will attempt to
      identify the number of available CPUs.
    default: 14
    inputBinding:
      position: 101
      prefix: --threads
  - id: vc_haircut
    type:
      - 'null'
      - float
    doc: Apply a haircut transformation as a post-processing step on the 
      detected clusters. A haircut transformation removes dangling nodes from a 
      cluster. (ClusterONE only)
    default: 0.55
    inputBinding:
      position: 101
      prefix: --vc-haircut
  - id: vc_inflation
    type:
      - 'null'
      - float
    doc: Inflation parameter to define contig clusters with MCL. (MCL only)
    default: 2.0
    inputBinding:
      position: 101
      prefix: --vc-inflation
  - id: vc_overlap
    type:
      - 'null'
      - float
    doc: Specifies the maximum allowed overlap between two clusters. (ClusterONE
      only)
    default: 0.9
    inputBinding:
      position: 101
      prefix: --vc-overlap
  - id: vc_penalty
    type:
      - 'null'
      - float
    doc: Sets a penalty value for the inclusion of each node. It can be used to 
      model the possibility of uncharted connections for each node, so nodes 
      with only a single weak connection to a cluster will not be added to the 
      cluster as the penalty value will outweigh the benefits of adding the 
      node. (ClusterONE only)
    default: 2.0
    inputBinding:
      position: 101
      prefix: --vc-penalty
  - id: vcs_mode
    type:
      - 'null'
      - string
    doc: Whether to use ClusterONE or MCL for Viral Cluster (VC) generation.
    default: ClusterONE
    inputBinding:
      position: 101
      prefix: --vcs-mode
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbosity level : -v warning, -vv info, -vvv debug, (default info)'
    default: -2
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcontact2:0.11.3--pyhdfd78af_0
stdout: vcontact2.out
