cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_homologues_get_homologues.pl
label: get_homologues_get_homologues.pl
doc: "This program uses BLAST (and optionally HMMER/Pfam) to define clusters of 'orthologous'
  genomic sequences and pan/core-genome gene sets. Several algorithms are available
  and search parameters are customizable. It is designed to process (in a HPC computer
  cluster) files contained in a directory (-d), so that new .faa/.gbk files can be
  added while conserving previous BLAST results. In general the program will try to
  re-use previous results when run with the same input directory.\n\nTool homepage:
  https://github.com/eead-csic-compbio/get_homologues"
inputs:
  - id: add_soft_core
    type:
      - 'null'
      - boolean
    doc: add soft-core to genome composition analysis (optional, requires -c 
      [OMCL|COGS])
    inputBinding:
      position: 101
      prefix: -z
  - id: allow_sequences_in_multiple_cogs
    type:
      - 'null'
      - boolean
    doc: allow sequences in multiple COG clusters (by default sequences are 
      allocated to single clusters [COGS])
    inputBinding:
      position: 101
      prefix: -x
  - id: calculate_average_identity
    type:
      - 'null'
      - boolean
    doc: calculate average identity of clustered sequences, (optional, creates 
      tab-separated matrix, by default uses blastp results but can use blastn 
      with -a recommended with -t 0 [OMCL|COGS])
    inputBinding:
      position: 101
      prefix: -A
  - id: compile_core_genome
    type:
      - 'null'
      - boolean
    doc: compile core-genome with minimum BLAST searches (ignores -c [BDBH])
    inputBinding:
      position: 101
      prefix: -b
  - id: compute_pocp_af
    type:
      - 'null'
      - boolean
    doc: compute % conserved proteins (POCP) & align fraction (AF), (optional, 
      creates tab-separated matrices, by default uses blastp results but can use
      blastn with -a recommended with -t 0 [OMCL|COGS])
    inputBinding:
      position: 101
      prefix: -P
  - id: exclude_inparalogues
    type:
      - 'null'
      - boolean
    doc: exclude clusters with inparalogues (by default inparalogues are 
      included)
    inputBinding:
      position: 101
      prefix: -e
  - id: filter_length_difference
    type:
      - 'null'
      - float
    doc: filter by %length difference within clusters (range [1-100], by default
      sequence length is not checked)
    inputBinding:
      position: 101
      prefix: -f
  - id: include_files
    type:
      - 'null'
      - File
    doc: file with .faa/.gbk files in -d to be included (takes all by default, 
      requires -d)
    inputBinding:
      position: 101
      prefix: -I
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: directory with input FASTA files ( .faa / .fna ), (overrides -i, 
      GenBank files ( .gbk ), 1 per genome, or a subdirectory ( subdir.clusters 
      / subdir_ ) with pre-clustered sequences ( .faa / .fna ); allows for new 
      files to be added later; creates output folder named 
      'directory_homologues'
    inputBinding:
      position: 101
      prefix: -d
  - id: input_file
    type:
      - 'null'
      - File
    doc: input amino acid FASTA file with [taxon names] in headers, creates 
      output folder named 'file_homologues'
    inputBinding:
      position: 101
      prefix: -i
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: max E-value (default=1e-05,max=0.01)
    inputBinding:
      position: 101
      prefix: -E
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: min %coverage in BLAST pairwise alignments (range [1-100],default=75)
    inputBinding:
      position: 101
      prefix: -C
  - id: min_neighborhood_correlation
    type:
      - 'null'
      - float
    doc: min BLAST neighborhood correlation PubMed=18475320 (range 
      [0,1],default=0 [BDBH|OMCL])
    inputBinding:
      position: 101
      prefix: -N
  - id: min_sequence_identity
    type:
      - 'null'
      - float
    doc: min %sequence identity in BLAST query/subj pairs (range 
      [1-100],default=1 [BDBH|OMCL])
    inputBinding:
      position: 101
      prefix: -S
  - id: nb_threads_local
    type:
      - 'null'
      - int
    doc: nb of threads for BLAST/HMMER/MCL in 'local' runmode
    inputBinding:
      position: 101
      prefix: -n
  - id: only_blast_pfam
    type:
      - 'null'
      - boolean
    doc: only run BLAST/Pfam searches and exit (useful to pre-compute searches)
    inputBinding:
      position: 101
      prefix: -o
  - id: orthomcl_inflation
    type:
      - 'null'
      - float
    doc: orthoMCL inflation value (range [1-5], default=1.5 [OMCL])
    inputBinding:
      position: 101
      prefix: -F
  - id: random_seed_composition
    type:
      - 'null'
      - int
    doc: set random seed for genome composition analysis (optional, requires -c,
      example -R 1234, required for mixing -c with -c -a runs)
    inputBinding:
      position: 101
      prefix: -R
  - id: reference_proteome
    type:
      - 'null'
      - File
    doc: reference proteome .faa/.gbk file (by default takes file with least 
      sequences; with BDBH sets first taxa to start adding genes)
    inputBinding:
      position: 101
      prefix: -r
  - id: report_clusters_min_taxa
    type:
      - 'null'
      - int
    doc: report sequence clusters including at least t taxa (default 
      t=numberOfTaxa, t=0 reports all clusters [OMCL|COGS])
    inputBinding:
      position: 101
      prefix: -t
  - id: report_genome_composition
    type:
      - 'null'
      - boolean
    doc: report genome composition analysis (follows order in -I file if 
      enforced, ignores -r,-t,-e)
    inputBinding:
      position: 101
      prefix: -c
  - id: report_intergenic_clusters
    type:
      - 'null'
      - boolean
    doc: report clusters of intergenic sequences flanked by ORFs in addition to 
      default 'CDS' clusters (requires -d and .gbk files)
    inputBinding:
      position: 101
      prefix: -g
  - id: report_sequence_features_clusters
    type:
      - 'null'
      - string
    doc: "report clusters of sequence features in GenBank files instead of default
      'CDS' GenBank features (requires -d and .gbk files, example -a 'tRNA,rRNA',
      NOTE: uses blastn instead of blastp, ignores -g,-D)"
    inputBinding:
      position: 101
      prefix: -a
  - id: require_equal_pfam_domain_composition
    type:
      - 'null'
      - boolean
    doc: require equal Pfam domain composition (best with -m cluster or -n 
      threads) when defining similarity-based orthology
    inputBinding:
      position: 101
      prefix: -D
  - id: runmode
    type:
      - 'null'
      - string
    doc: 'runmode [local|cluster|dryrun|/path/custom/HPC.conf] (def: local, path overrides
      ./HPC.conf)'
    inputBinding:
      position: 101
      prefix: -m
  - id: use_cugtriangle
    type:
      - 'null'
      - boolean
    doc: use COGtriangle algorithm (COGS, PubMed=20439257) (requires 3+ 
      genomes|taxa)
    inputBinding:
      position: 101
      prefix: -G
  - id: use_diamond
    type:
      - 'null'
      - boolean
    doc: use diamond instead of blastp (optional, set threads with -n)
    inputBinding:
      position: 101
      prefix: -X
  - id: use_orthomcl
    type:
      - 'null'
      - boolean
    doc: use orthoMCL algorithm (OMCL, PubMed=12952885)
    inputBinding:
      position: 101
      prefix: -M
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
stdout: get_homologues_get_homologues.pl.out
