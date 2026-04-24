cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnoise
label: dnoise
doc: "starting to denoise\n\nTool homepage: https://github.com/adriantich/DnoisE"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: alpha value, 5 by default
    inputBinding:
      position: 101
      prefix: --alpha
  - id: cores
    type:
      - 'null'
      - int
    doc: number of cores, 1 by default
    inputBinding:
      position: 101
      prefix: --cores
  - id: count_name
    type:
      - 'null'
      - string
    doc: count name column 'size' by default
    inputBinding:
      position: 101
      prefix: --count_name
  - id: csv_input
    type:
      - 'null'
      - File
    doc: input file path in csv format
    inputBinding:
      position: 101
      prefix: --csv_input
  - id: end_sample_cols
    type:
      - 'null'
      - int
    doc: last sample column (n == nst col) if not given, just one column with 
      total read counts expected (see README.md)
    inputBinding:
      position: 101
      prefix: --end_sample_cols
  - id: entropy
    type:
      - 'null'
      - string
    doc: entropy values (or any user-settable measure of variability) of the 
      different codon positions. If -y is enabled and no values are given, 
      default entropy values are computed from the data
    inputBinding:
      position: 101
      prefix: --entropy
  - id: entropy_correction
    type:
      - 'null'
      - boolean
    doc: a distance correction based on entropy is performed (see 
      https://github.com/adriantich/DnoisE). If not enabled no correction for 
      entropy is performed (corresponding to the standard Unoise formulation)
    inputBinding:
      position: 101
      prefix: --entropy_correction
  - id: fasta_input
    type:
      - 'null'
      - File
    doc: input file path in fasta format
    inputBinding:
      position: 101
      prefix: --fasta_input
  - id: fastq_input
    type:
      - 'null'
      - File
    doc: input file path in fastq format
    inputBinding:
      position: 101
      prefix: --fastq_input
  - id: first_nt_codon_position
    type:
      - 'null'
      - int
    doc: as DnoisE has been developed for COI sequences amplified with Leray-XT 
      primers, default value is 3 (i.e., the first nucleotide in the sequences 
      is a third codon position)
    inputBinding:
      position: 101
      prefix: --first_nt_codon_position
  - id: get_entropy
    type:
      - 'null'
      - boolean
    doc: get only entropy values from a dataset
    inputBinding:
      position: 101
      prefix: --get_entropy
  - id: joining_criteria
    type:
      - 'null'
      - int
    doc: "1-> will join by the lesser [abundance ratio / beta(d)] (default r_d criterion)\n\
      \t\t\t\t2-> will join by the lesser abundance ratio (r criterion)\n\t\t\t\t\
      3-> will join by the lesser distance (d) value (d criterion)\n\t\t\t\t4-> will
      provide all joining criteria in three different outputs (all)"
    inputBinding:
      position: 101
      prefix: --joining_criteria
  - id: joining_file
    type:
      - 'null'
      - File
    doc: file path of an info output from DnoisE. This option allows to use the 
      information of previous runs of DnoisE to return different joining 
      criteriaoutputs without running the program again
    inputBinding:
      position: 101
      prefix: --joining_file
  - id: min_abund
    type:
      - 'null'
      - int
    doc: minimum abundance filtering applied at the end of analysis, 1 by 
      default
    inputBinding:
      position: 101
      prefix: --min_abund
  - id: modal_length
    type:
      - 'null'
      - int
    doc: when running DnoisE with entropy correction, sequence length expected 
      can be set, if not, modal_length is used and only sequences with 
      modal_length + or - 3*n are accepted
    inputBinding:
      position: 101
      prefix: --modal_length
  - id: sep
    type:
      - 'null'
      - int
    doc: "separator in case of csv input file\n\t\t\t\t1='\\t' (tab)\n\t\t\t\t2=','\n\
      \t\t\t\t3=';'"
    inputBinding:
      position: 101
      prefix: --sep
  - id: sequence
    type:
      - 'null'
      - string
    doc: sequence column name, 'sequence' by default
    inputBinding:
      position: 101
      prefix: --sequence
  - id: start_sample_cols
    type:
      - 'null'
      - int
    doc: first sample column (1 == 1st col) if not given, just one column with 
      total read counts expected (see README.md)
    inputBinding:
      position: 101
      prefix: --start_sample_cols
  - id: unique_length
    type:
      - 'null'
      - boolean
    doc: only modal length is accepted as sequence length when running with 
      entropy correction
    inputBinding:
      position: 101
      prefix: --unique_length
  - id: within_MOTU
    type:
      - 'null'
      - string
    doc: MOTU column name. This option allows to run DnoisEwithin MOTU. Is only 
      available for --csv_input and --csv_output
    inputBinding:
      position: 101
      prefix: --within_MOTU
outputs:
  - id: csv_output
    type:
      - 'null'
      - File
    doc: common path for csv format
    outputBinding:
      glob: $(inputs.csv_output)
  - id: fasta_output
    type:
      - 'null'
      - File
    doc: common path for fasta format
    outputBinding:
      glob: $(inputs.fasta_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnoise:1.4.2--pyhdfd78af_0
