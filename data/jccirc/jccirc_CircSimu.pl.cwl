cwlVersion: v1.2
class: CommandLineTool
baseCommand: jccirc_CircSimu.pl
label: jccirc_CircSimu.pl
doc: "a simulation tool for circRNAs.\n\nTool homepage: https://github.com/cbbzhang/JCcirc"
inputs:
  - id: annotation_file
    type: File
    doc: input gtf formatted annotation file name
    inputBinding:
      position: 101
      prefix: -G
  - id: circrna_coverage
    type: string
    doc: set coverage or max coverage (when choosing -R 2) for circRNAs
    inputBinding:
      position: 101
      prefix: -C
  - id: circrna_random_mode
    type: int
    doc: 'set random mode for circRNAs: 1 for constant coverage; 2 for random coverage'
    inputBinding:
      position: 101
      prefix: -R
  - id: insert_length_avg_major
    type: int
    doc: average(mu/bp) of insert length (major normal distribution) (e.g. 320)
    inputBinding:
      position: 101
      prefix: -M
  - id: insert_length_avg_minor
    type: int
    doc: average(mu/bp) of insert length (minor normal distribution) (e.g. 550)
    inputBinding:
      position: 101
      prefix: -M2
  - id: insert_length_std_dev_major
    type: int
    doc: standard deviation(sigma/bp) of insert length (e.g. 70)
    inputBinding:
      position: 101
      prefix: -S
  - id: insert_length_std_dev_minor
    type: int
    doc: standard deviation(sigma/bp) of insert length (e.g. 70)
    inputBinding:
      position: 101
      prefix: -S2
  - id: linear_transcript_coverage
    type: string
    doc: set coverage or max coverage (when choosing -LR 2) for linear 
      transcripts
    inputBinding:
      position: 101
      prefix: -LC
  - id: linear_transcript_random_mode
    type: int
    doc: 'set random mode for linear transcripts: 1 for constant coverage; 2 for random
      coverage'
    inputBinding:
      position: 101
      prefix: -LR
  - id: minor_distribution_percentage
    type: int
    doc: percentage of minor normal distribution in total distribution (e.g. 10;
      0 for no minor distribution)
    inputBinding:
      position: 101
      prefix: -PM
  - id: output_prefix
    type: string
    doc: prefix of output files
    inputBinding:
      position: 101
      prefix: -O
  - id: read_length
    type: int
    doc: read length(/bp) of simulated reads (e.g. 100)
    inputBinding:
      position: 101
      prefix: -L
  - id: reference_sequences_directory
    type: Directory
    doc: directory of reference sequence(s) (please make sure all references 
      referred in gtf file are included in the directory)
    inputBinding:
      position: 101
      prefix: -D
  - id: sequencing_error_percentage
    type: float
    doc: percentage of sequencing error (e.g. 2)
    inputBinding:
      position: 101
      prefix: -E
  - id: simulate_chr1_only
    type: int
    doc: 'if only choose chr1 to simulate sequencing reads: 1 for yes; 0 for no'
    inputBinding:
      position: 101
      prefix: -CHR1
  - id: simulate_exon_skipping
    type: int
    doc: 'whether simulate exon skipping: 1 for yes; 0 for no'
    inputBinding:
      position: 101
      prefix: -SE
  - id: splice_in_percentage_for_skipping_exon
    type: float
    doc: percentage of splice in for skipping exon(-SE should be 1)
    inputBinding:
      position: 101
      prefix: -PSI
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jccirc:1.0.0--hdfd78af_1
stdout: jccirc_CircSimu.pl.out
