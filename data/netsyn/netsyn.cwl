cwlVersion: v1.2
class: CommandLineTool
baseCommand: netsyn
label: netsyn
doc: "netsyn\n\nTool homepage: https://github.com/labgem/netsyn"
inputs:
  - id: clustering_advanced_settings
    type:
      - 'null'
      - File
    doc: YAML file with the advanced clustering settings to determine synteny 
      NetSyn. Settings of clusterings methods
    inputBinding:
      position: 101
      prefix: --ClusteringAdvancedSettings
  - id: clustering_method
    type:
      - 'null'
      - string
    doc: 'Clustering method choices: MCL (small graph), Infomap (medium graph), Louvain
      (medium graph) or WalkTrap (big  graph).'
    inputBinding:
      position: 101
      prefix: --ClusteringMethod
  - id: conserve_downloaded_insdc
    type:
      - 'null'
      - boolean
    doc: Conserve the downloaded files from GetINSDC. Require of --UniProtACList
      option
    inputBinding:
      position: 101
      prefix: --conserveDownloadedINSDC
  - id: correspondences_file
    type:
      - 'null'
      - File
    doc: 'Correspondence entry file between: protein_AC/nucleic_AC/nucleic_File_Path
      (cf: wiki)'
    inputBinding:
      position: 101
      prefix: --CorrespondencesFile
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimal coverage allowed.
    inputBinding:
      position: 101
      prefix: --Coverage
  - id: grouping_on_label
    type:
      - 'null'
      - string
    doc: Label of the metadata column on which the redundancy will be computed 
      (Incompatible with --GroupingOnTaxonomy option.)
    inputBinding:
      position: 101
      prefix: --GroupingOnLabel
  - id: grouping_on_taxonomy
    type:
      - 'null'
      - string
    doc: Taxonomic rank on which the redundancy will be computed. (Incompatible 
      with --GroupingOnLabel option)
    inputBinding:
      position: 101
      prefix: --GroupingOnTaxonomy
  - id: identity
    type:
      - 'null'
      - float
    doc: Sequence identity.
    inputBinding:
      position: 101
      prefix: --Identity
  - id: included_pseudogenes
    type:
      - 'null'
      - boolean
    doc: CDS annotated as pseudogenes are considered as part of the genomic 
      context
    inputBinding:
      position: 101
      prefix: --IncludedPseudogenes
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file (use the stderr by default). Disable the log colors.
    inputBinding:
      position: 101
      prefix: --logFile
  - id: log_level
    type:
      - 'null'
      - string
    doc: log level
    inputBinding:
      position: 101
      prefix: --logLevel
  - id: metadata_file
    type:
      - 'null'
      - File
    doc: File containing metadata
    inputBinding:
      position: 101
      prefix: --MetaDataFile
  - id: mmseqs_advanced_settings
    type:
      - 'null'
      - File
    doc: YAML file with the advanced clustering settings to determine protein 
      families. Settings of MMseqs2 software
    inputBinding:
      position: 101
      prefix: --MMseqsAdvancedSettings
  - id: new_project
    type:
      - 'null'
      - boolean
    doc: Force the creation of a new projet. Overwrite the project of the same 
      name
    inputBinding:
      position: 101
      prefix: --newProject
  - id: project_description
    type:
      - 'null'
      - string
    doc: The project description
    inputBinding:
      position: 101
      prefix: --ProjectDescription
  - id: synteny_gap
    type:
      - 'null'
      - int
    doc: Number of genes allowed between two genes in synteny.
    inputBinding:
      position: 101
      prefix: --SyntenyGap
  - id: synteny_score_cutoff
    type:
      - 'null'
      - float
    doc: Define the Synteny Score Cutoff to conserved.
    inputBinding:
      position: 101
      prefix: --SyntenyScoreCutoff
  - id: uniprot_ac_list
    type:
      - 'null'
      - File
    doc: 'UniProt accession list input(cf: wiki)'
    inputBinding:
      position: 101
      prefix: --UniProtACList
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size of genomic contexts to compare (target gene included).
    inputBinding:
      position: 101
      prefix: --WindowSize
outputs:
  - id: output_dir_name
    type:
      - 'null'
      - Directory
    doc: Output directory name, used to define the project name
    outputBinding:
      glob: $(inputs.output_dir_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
