cwlVersion: v1.2
class: CommandLineTool
baseCommand: mob_cluster
label: mob_suite_mob_cluster
doc: "MOB-Cluster: Generate and update existing plasmid clusters' version: 3.1.9\n\
  \nTool homepage: https://github.com/phac-nml/mob-suite"
inputs:
  - id: database_directory
    type:
      - 'null'
      - Directory
    doc: Directory you want to use for your databases. If the databases are not 
      already downloaded, they will be downloaded automatically.
    inputBinding:
      position: 101
      prefix: --database_directory
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: infile
    type: File
    doc: Fasta file of sequences to cluster
    inputBinding:
      position: 101
      prefix: --infile
  - id: mob_typer_file
    type: File
    doc: MOB-typer report file for new sequences
    inputBinding:
      position: 101
      prefix: --mob_typer_file
  - id: mode
    type: string
    doc: 'Build: Create a new database from scratch, Update: Update an existing database
      with one or more sequences'
    inputBinding:
      position: 101
      prefix: --mode
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to be used
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: outdir
    type: Directory
    doc: Output Directory to put results
    inputBinding:
      position: 101
      prefix: --outdir
  - id: primary_cluster_dist
    type:
      - 'null'
      - float
    doc: Mash distance for assigning primary cluster id 0 - 1
    inputBinding:
      position: 101
      prefix: --primary_cluster_dist
  - id: ref_cluster_file
    type:
      - 'null'
      - File
    doc: Existing MOB-cluster file to add the new sequences to
    inputBinding:
      position: 101
      prefix: --ref_cluster_file
  - id: ref_fasta_file
    type:
      - 'null'
      - File
    doc: Existing MOB-cluster fasta file of sequences contained in the 
      MOB-cluster file
    inputBinding:
      position: 101
      prefix: --ref_fasta_file
  - id: secondary_cluster_dist
    type:
      - 'null'
      - float
    doc: Mash distance for assigning primary cluster id 0 - 1
    inputBinding:
      position: 101
      prefix: --secondary_cluster_dist
  - id: taxonomy
    type: File
    doc: TSV file for new sequences with the fields "id, organism"
    inputBinding:
      position: 101
      prefix: --taxonomy
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mob_suite:3.1.9--pyhdfd78af_1
stdout: mob_suite_mob_cluster.out
