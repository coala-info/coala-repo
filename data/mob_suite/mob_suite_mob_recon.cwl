cwlVersion: v1.2
class: CommandLineTool
baseCommand: mob_recon
label: mob_suite_mob_recon
doc: "MOB-Recon: Typing and reconstruction of plasmids from draft and complete assemblies\n\
  \nTool homepage: https://github.com/phac-nml/mob-suite"
inputs:
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
  - id: filter_db
    type:
      - 'null'
      - File
    doc: Path to fasta file to mask sequences
    inputBinding:
      position: 101
      prefix: --filter_db
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing directory
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: genome_filter_db_prefix
    type:
      - 'null'
      - string
    doc: Prefix of mash sketch and blastdb of closed chromosomes to use for auto
      selection of close genomes for filtering
    inputBinding:
      position: 101
      prefix: --genome_filter_db_prefix
  - id: input_file
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
  - id: mash_genome_neighbor_threshold
    type:
      - 'null'
      - float
    doc: Mash distance selecting valid closed genomes to filter
    default: 0.002
    inputBinding:
      position: 101
      prefix: --mash_genome_neighbor_threshold
  - id: max_contig_size
    type:
      - 'null'
      - int
    doc: Maximum size of a contig to be considered a plasmid
    default: 450000
    inputBinding:
      position: 101
      prefix: --max_contig_size
  - id: max_plasmid_size
    type:
      - 'null'
      - int
    doc: Maximum size of a reconstructed plasmid
    default: 450000
    inputBinding:
      position: 101
      prefix: --max_plasmid_size
  - id: min_con_cov
    type:
      - 'null'
      - int
    doc: Minimum percentage coverage of assembly contig by the plasmid reference
      database to be considered
    default: 60
    inputBinding:
      position: 101
      prefix: --min_con_cov
  - id: min_con_evalue
    type:
      - 'null'
      - float
    doc: Minimum evalue threshold for contig blastn
    default: 1e-05
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
    doc: Minimum length of contigs to classify
    default: 1000
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
    default: 1e-05
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
    default: 1e-05
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
    doc: Minimum percentage coverage of contigs by repetitive elements
    default: 80
    inputBinding:
      position: 101
      prefix: --min_rpp_cov
  - id: min_rpp_evalue
    type:
      - 'null'
      - float
    doc: Minimum evalue threshold for repetitve elements blastn
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --min_rpp_evalue
  - id: min_rpp_ident
    type:
      - 'null'
      - int
    doc: Minimum sequence identity for repetitive elements
    default: 80
    inputBinding:
      position: 101
      prefix: --min_rpp_ident
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to be used
    default: 1
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: output_dir
    type: Directory
    doc: Output Directory to put results
    inputBinding:
      position: 101
      prefix: --outdir
  - id: plasmid_db
    type:
      - 'null'
      - File
    doc: Reference Database of complete plasmids
    default: 
      /usr/local/lib/python3.11/site-packages/mob_suite/databases/ncbi_plasmid_full_seqs.fas
    inputBinding:
      position: 101
      prefix: --plasmid_db
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
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to append to result files
    inputBinding:
      position: 101
      prefix: --prefix
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
  - id: run_overhang
    type:
      - 'null'
      - boolean
    doc: Detect circular contigs with assembly overhangs
    default: false
    inputBinding:
      position: 101
      prefix: --run_overhang
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Sample Prefix for reports
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: secondary_cluster_dist
    type:
      - 'null'
      - float
    doc: Mash distance for assigning primary cluster id 0 - 1
    default: 0.025
    inputBinding:
      position: 101
      prefix: --secondary_cluster_dist
  - id: unicycler_contigs
    type:
      - 'null'
      - boolean
    doc: Check for circularity flag generated by unicycler in fasta headers
    default: false
    inputBinding:
      position: 101
      prefix: --unicycler_contigs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mob_suite:3.1.9--pyhdfd78af_1
stdout: mob_suite_mob_recon.out
