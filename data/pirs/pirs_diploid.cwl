cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pirs
  - diploid
label: pirs_diploid
doc: "Simulate a diploid genome by creating a copy of a haploid genome with heterozygosity
  introduced. REFERENCE specifies a FASTA file containing the reference genome. It
  may be compressed (gzip). It may contain multiple sequences (scaffolds or chromosomes),
  each marked with a separate FASTA tag line. The introduced heterozygosity takes
  the form of SNPs, indels, and large-scale structural variation (insertions, deletions
  and inversions). If REFERENCE is '-', the reference sequence is read from stdin,
  but it must be uncompressed.\n\nTool homepage: https://github.com/galaxy001/pirs"
inputs:
  - id: reference
    type: File
    doc: FASTA file containing the reference genome. It may be compressed 
      (gzip). It may contain multiple sequences (scaffolds or chromosomes), each
      marked with a separate FASTA tag line. If '-' is specified, the reference 
      sequence is read from stdin, but it must be uncompressed.
    inputBinding:
      position: 1
  - id: indel_rate
    type:
      - 'null'
      - float
    doc: A floating-point number in the interval [0, 1] that specifies the 
      heterozygous indel rate.
    default: 0.0001
    inputBinding:
      position: 102
      prefix: --indel-rate
  - id: no_logs
    type:
      - 'null'
      - boolean
    doc: Do not write the log files.
    inputBinding:
      position: 102
      prefix: --no-logs
  - id: output_file_type
    type:
      - 'null'
      - string
    doc: The string "text" or "gzip" to specify the type of the output FASTA 
      file containing the diploid copy of the genome, as well as the log files.
    default: text
    inputBinding:
      position: 102
      prefix: --output-file-type
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Use PREFIX as the prefix of the output file and logs.
    default: pirs_diploid
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print informational messages.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Use SEED as the random seed. Default: time(NULL) * getpid()'
    inputBinding:
      position: 102
      prefix: --random-seed
  - id: snp_rate
    type:
      - 'null'
      - float
    doc: A floating-point number in the interval [0, 1] that specifies the 
      heterozygous SNP rate.
    default: 0.001
    inputBinding:
      position: 102
      prefix: --snp-rate
  - id: sv_rate
    type:
      - 'null'
      - float
    doc: A floating-point number in the interval [0, 1] that specifies the 
      large-scale structural variation (insertion, deletion, inversion) rate in 
      the diploid genome.
    default: 1e-06
    inputBinding:
      position: 102
      prefix: --sv-rate
  - id: transition_to_transversion_ratio
    type:
      - 'null'
      - float
    doc: In a SNP, a transition is when a purine or pyrimidine is changed to one
      of the same (A <=> G, C <=> T) while a transversion is when a purine is 
      changed into a pyrimidine or vice-versa. This option specifies a 
      floating-point number RATIO that gives the ratio of the transition 
      probability to the transversion probability for simulated SNPs.
    default: 2.0
    inputBinding:
      position: 102
      prefix: --transition-to-transversion-ratio
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Use FILE as the name of the output file. Use '-' for standard output; 
      this also moves the informational messages from stdout to stderr.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pirs:2.0.2--pl5.22.0_1
