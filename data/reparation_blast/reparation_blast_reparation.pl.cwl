cwlVersion: v1.2
class: CommandLineTool
baseCommand: reparation.pl
label: reparation_blast_reparation.pl
doc: "Performs BLAST analysis for bacterial protein sequence identification and ORF
  prediction.\n\nTool homepage: https://github.com/RickGelhausen/REPARATION_blast"
inputs:
  - id: bam_file
    type: File
    doc: Ribosome alignment file (bam)
    inputBinding:
      position: 101
      prefix: -bam
  - id: bypass_shinedalgarno_trainer
    type:
      - 'null'
      - string
    doc: Flag to determine if prodigal should bypass Shine-Dalgarno trainer and 
      force a full motif scan (default = N). (Y = yes, N = no) Valid only for 
      -pg 1
    inputBinding:
      position: 101
      prefix: -by
  - id: curated_protein_db
    type: File
    doc: fasta database of curated bacteria protein sequences
    inputBinding:
      position: 101
      prefix: -db
  - id: experiment_name
    type:
      - 'null'
      - string
    doc: Experiment name
    inputBinding:
      position: 101
      prefix: -en
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: Genetic code to use for initail positive set generation. Valid when -pg
      is 1. (default = 11, takes value between 1-25)
    inputBinding:
      position: 101
      prefix: -gcode
  - id: genome_fasta_file
    type: File
    doc: Genome fasta file. This should be the same genome fasta file used in 
      the alignment of the Ribo-seq reads.
    inputBinding:
      position: 101
      prefix: -g
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: GTF genome annotation file
    inputBinding:
      position: 101
      prefix: -gtf
  - id: max_e_value
    type:
      - 'null'
      - float
    doc: maximum e-vlaue for BLAST protein sequence search (default = 1e-5)
    inputBinding:
      position: 101
      prefix: -ev
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: All ribosome profiling reads longerer than these values are eliminated 
      from the ananlysis (default = 40)
    inputBinding:
      position: 101
      prefix: -mx
  - id: min_identity_score
    type:
      - 'null'
      - float
    doc: Online-Ticket UNI STUTT Minimum identify score for BLAST protein 
      sequence search (default = 0.75)
    inputBinding:
      position: 101
      prefix: -id
  - id: min_orf_length
    type:
      - 'null'
      - int
    doc: Minimum length of open reading frame considered for prediction (default
      = 30 value in nucleotides)
    inputBinding:
      position: 101
      prefix: -mo
  - id: min_orf_reads
    type:
      - 'null'
      - int
    doc: Open reading frames with less than these number of ribosome profiling 
      reads are eliminated from analysis (default = 3)
    inputBinding:
      position: 101
      prefix: -mr
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: All ribosome profiling reads shorter than these values are eliminated 
      from the ananlysis (default = 22)
    inputBinding:
      position: 101
      prefix: -mn
  - id: negative_set_start_codon
    type:
      - 'null'
      - string
    doc: Start codon for negative set (default = CTG)
    inputBinding:
      position: 101
      prefix: -ncdn
  - id: orf_coding_score_threshold
    type:
      - 'null'
      - float
    doc: Random forest classification probability score threshold to define as 
      ORF are protein coding, the minimum (defualt is 0.5)
    inputBinding:
      position: 101
      prefix: -score
  - id: p_site_strategy
    type:
      - 'null'
      - string
    doc: Ribosome profiling read p site assignment strategy, 1 = plastid P-site 
      estimation ((default), 3 = 3 prime of read, 5 prime of the read
    inputBinding:
      position: 101
      prefix: -p
  - id: positive_set_program
    type:
      - 'null'
      - int
    doc: program for initial positive set generation (1 = prodigal (default), 2 
      = glimmer)
    inputBinding:
      position: 101
      prefix: -pg
  - id: positive_set_start_codon
    type:
      - 'null'
      - string
    doc: Start codon for positive set (default = ATG,GTG,TTG). Should be a 
      subset of the standard genetic code for bacteria
    inputBinding:
      position: 101
      prefix: -pcdn
  - id: scripts_directory
    type: Directory
    doc: The "scripts" directory (avialable within the REPARATION directory), 
      defaults to directory of reparation.pl script
    inputBinding:
      position: 101
      prefix: -sdir
  - id: shinedalgarno_distance
    type:
      - 'null'
      - int
    doc: Distance of Shine dalgarno sequence from start codon (defualt = 5nts).
    inputBinding:
      position: 101
      prefix: -osd
  - id: shinedalgarno_sequence
    type:
      - 'null'
      - string
    doc: Shine dalgarno sequence (default = GGAGG). The shine dalgarno sequence 
      used for Ribosome binind site energy calculation.
    inputBinding:
      position: 101
      prefix: -seed
  - id: start_codons
    type:
      - 'null'
      - string
    doc: Comma separted list of start codons (default = ATG,GTG,TTG)
    inputBinding:
      position: 101
      prefix: -cdn
  - id: start_region_length
    type:
      - 'null'
      - int
    doc: Start region length in nucleotides (default = 45nts). This value is 
      used to calculate features specific to the start region.
    inputBinding:
      position: 101
      prefix: -ost
  - id: stop_region_length
    type:
      - 'null'
      - int
    doc: Stop region length in nucleotides (default = 21nts). This value is used
      to calculate features specific to the stop region.
    inputBinding:
      position: 101
      prefix: -osp
  - id: use_rbs_energy
    type:
      - 'null'
      - string
    doc: Use ribosome binding site (RBS) energy in the open reading frame 
      prediction (Y = use RBS energy (default), N = donot use RBS engergy)
    inputBinding:
      position: 101
      prefix: -sd
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: working directory (defaults to current directory)
    inputBinding:
      position: 101
      prefix: -wdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
stdout: reparation_blast_reparation.pl.out
