cwlVersion: v1.2
class: CommandLineTool
baseCommand: mob_typer
label: mob_suite_mob_typer
doc: "Plasmid typing and mobility prediction\n\nTool homepage: https://github.com/phac-nml/mob-suite"
inputs:
  - id: analysis_dir
    type:
      - 'null'
      - Directory
    doc: Working directory for storing temporary results
    inputBinding:
      position: 101
      prefix: --analysis_dir
  - id: biomarker_report_file
    type:
      - 'null'
      - File
    doc: Output file for biomarker blast results
    inputBinding:
      position: 101
      prefix: --biomarker_report_file
  - id: database_directory
    type:
      - 'null'
      - Directory
    doc: Directory you want to use for your databases. If the databases are not 
      already downloaded, they will be downloaded automatically.
    default: /usr/local/lib/python3.11/site-packages/mob_suite/databases
    inputBinding:
      position: 101
      prefix: --database_directory
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debug information
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: infile
    type: File
    doc: Input assembly fasta file to process
    inputBinding:
      position: 101
      prefix: --infile
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Do not delete temporary file directory
    default: false
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: mge_report_file
    type:
      - 'null'
      - File
    doc: Output file for MGE results
    inputBinding:
      position: 101
      prefix: --mge_report_file
  - id: min_con_cov
    type:
      - 'null'
      - int
    doc: Minimum percentage coverage of assembly contig by the plasmid reference
      database to be considered
    default: 70
    inputBinding:
      position: 101
      prefix: --min_con_cov
  - id: min_con_evalue
    type:
      - 'null'
      - float
    doc: Minimum evalue threshold for contig blastn
    default: '1e-05'
    inputBinding:
      position: 101
      prefix: --min_con_evalue
  - id: min_con_ident
    type:
      - 'null'
      - int
    doc: Minimum sequence identity for contigs
    default: 80
    inputBinding:
      position: 101
      prefix: --min_con_ident
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of blast hits
    default: 500
    inputBinding:
      position: 101
      prefix: --min_length
  - id: min_mob_cov
    type:
      - 'null'
      - int
    doc: Minimum percentage coverage of relaxase query by input assembly
    default: 80
    inputBinding:
      position: 101
      prefix: --min_mob_cov
  - id: min_mob_evalue
    type:
      - 'null'
      - float
    doc: Minimum evalue threshold for relaxase tblastn
    default: '1e-05'
    inputBinding:
      position: 101
      prefix: --min_mob_evalue
  - id: min_mob_ident
    type:
      - 'null'
      - int
    doc: Minimum sequence identity for relaxases
    default: 80
    inputBinding:
      position: 101
      prefix: --min_mob_ident
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap of fragments
    default: 10
    inputBinding:
      position: 101
      prefix: --min_overlap
  - id: min_rep_cov
    type:
      - 'null'
      - int
    doc: Minimum percentage coverage of replicon query by input assembly
    default: 80
    inputBinding:
      position: 101
      prefix: --min_rep_cov
  - id: min_rep_evalue
    type:
      - 'null'
      - float
    doc: Minimum evalue threshold for replicon blastn
    default: '1e-05'
    inputBinding:
      position: 101
      prefix: --min_rep_evalue
  - id: min_rep_ident
    type:
      - 'null'
      - int
    doc: Minimum sequence identity for replicons
    default: 80
    inputBinding:
      position: 101
      prefix: --min_rep_ident
  - id: min_rpp_cov
    type:
      - 'null'
      - int
    doc: Minimum percentage coverage of MGE
    default: 80
    inputBinding:
      position: 101
      prefix: --min_rpp_cov
  - id: min_rpp_evalue
    type:
      - 'null'
      - float
    doc: Minimum evalue threshold for repetitve elements blastn
    default: '1e-05'
    inputBinding:
      position: 101
      prefix: --min_rpp_evalue
  - id: min_rpp_ident
    type:
      - 'null'
      - int
    doc: Minimum sequence identity for MGE
    default: 80
    inputBinding:
      position: 101
      prefix: --min_rpp_ident
  - id: multi
    type:
      - 'null'
      - boolean
    doc: Treat each sequence as an independant plasmid
    default: false
    inputBinding:
      position: 101
      prefix: --multi
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to be used
    default: 1
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: plasmid_db_type
    type:
      - 'null'
      - string
    doc: Blast database type of reference database
    default: blastn
    inputBinding:
      position: 101
      prefix: --plasmid_db_type
  - id: plasmid_mash_db
    type:
      - 'null'
      - File
    doc: Companion Mash database of reference database
    default: 
      /usr/local/lib/python3.11/site-packages/mob_suite/databases/ncbi_plasmid_full_seqs.fas.msh
    inputBinding:
      position: 101
      prefix: --plasmid_mash_db
  - id: plasmid_meta
    type:
      - 'null'
      - File
    doc: MOB-cluster plasmid cluster formatted file matched to the reference 
      plasmid db
    default: 
      /usr/local/lib/python3.11/site-packages/mob_suite/databases/clusters.txt
    inputBinding:
      position: 101
      prefix: --plasmid_meta
  - id: plasmid_mob
    type:
      - 'null'
      - File
    doc: Fasta of plasmid relaxases
    default: 
      /usr/local/lib/python3.11/site-packages/mob_suite/databases/mob.proteins.faa
    inputBinding:
      position: 101
      prefix: --plasmid_mob
  - id: plasmid_mpf
    type:
      - 'null'
      - File
    doc: Fasta of known plasmid mate-pair proteins
    default: 
      /usr/local/lib/python3.11/site-packages/mob_suite/databases/mpf.proteins.faa
    inputBinding:
      position: 101
      prefix: --plasmid_mpf
  - id: plasmid_orit
    type:
      - 'null'
      - File
    doc: Fasta of known plasmid oriT dna sequences
    default: 
      /usr/local/lib/python3.11/site-packages/mob_suite/databases/orit.fas
    inputBinding:
      position: 101
      prefix: --plasmid_orit
  - id: plasmid_replicons
    type:
      - 'null'
      - File
    doc: Fasta of plasmid replicons
    default: 
      /usr/local/lib/python3.11/site-packages/mob_suite/databases/rep.dna.fas
    inputBinding:
      position: 101
      prefix: --plasmid_replicons
  - id: primary_cluster_dist
    type:
      - 'null'
      - float
    doc: Mash distance for assigning primary cluster id 0 - 1
    default: 0.06
    inputBinding:
      position: 101
      prefix: --primary_cluster_dist
  - id: repetitive_mask
    type:
      - 'null'
      - File
    doc: Fasta of known repetitive elements
    default: 
      /usr/local/lib/python3.11/site-packages/mob_suite/databases/repetitive.dna.fas
    inputBinding:
      position: 101
      prefix: --repetitive_mask
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Sample Prefix for reports
    inputBinding:
      position: 101
      prefix: --sample_id
outputs:
  - id: out_file
    type: File
    doc: Output file to write results
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mob_suite:3.1.9--pyhdfd78af_1
