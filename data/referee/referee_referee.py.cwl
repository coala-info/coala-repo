cwlVersion: v1.2
class: CommandLineTool
baseCommand: referee.py
label: referee_referee.py
doc: "Reference genome quality score calculator.\n       Pseudo assembly by iterative
  mapping.\n\nTool homepage: https://github.com/gwct/referee"
inputs:
  - id: bed
    type:
      - 'null'
      - boolean
    doc: "Set this option to output in BED format in addition to\n               \
      \      the default tab delimited format. BED files can be viewed\n         \
      \            as tracks in genome browsers."
    inputBinding:
      position: 101
      prefix: --bed
  - id: correct
    type:
      - 'null'
      - boolean
    doc: "Set this option to allow Referee to suggest alternate\n                \
      \     reference bases for sites that score 0."
    inputBinding:
      position: 101
      prefix: --correct
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Set this option to output in FASTQ format in addition to\n             \
      \        the default tab delimited format."
    inputBinding:
      position: 101
      prefix: --fastq
  - id: gl_file
    type:
      - 'null'
      - File
    doc: "The file containing the genotype likelihood calculations\nor a pileup file
      (be sure to set --pileup!)."
    inputBinding:
      position: 101
      prefix: -gl
  - id: haploid
    type:
      - 'null'
      - boolean
    doc: "Set this option if your input data are from a haploid\n                \
      \     species. Referee will limit its likelihood calculations\n            \
      \         to the four haploid genotypes. Can only be used with\n           \
      \          --pileup."
    inputBinding:
      position: 101
      prefix: --haploid
  - id: lines_per_proc
    type:
      - 'null'
      - int
    doc: "The number of lines to be read per process. Decreasing\n               \
      \      may reduce memory usage at the cost of slightly higher\n            \
      \         run times."
    inputBinding:
      position: 101
      prefix: -l
  - id: mapped
    type:
      - 'null'
      - boolean
    doc: "Set this to calculate scores only for positions that have\n            \
      \         reads mapped to them."
    inputBinding:
      position: 101
      prefix: --mapped
  - id: mapq
    type:
      - 'null'
      - boolean
    doc: "Set with --pileup to indicate whether to consider mapping\n            \
      \         quality scores in the final score calculation. These\n           \
      \          should be in the seventh column of the pileup file."
    inputBinding:
      position: 101
      prefix: --mapq
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "An output directory for all files associated with this\n               \
      \      run. Will be created if it doesn't exist."
    inputBinding:
      position: 101
      prefix: -d
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Set this option to explicitly overwrite files within a\n               \
      \      previous output directory."
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: pileup
    type:
      - 'null'
      - boolean
    doc: "Set this option if your input file(s) are in pileup\n                  \
      \   format and Referee will calculate genotype likelihoods\n               \
      \      for you."
    inputBinding:
      position: 101
      prefix: --pileup
  - id: prefix
    type:
      - 'null'
      - string
    doc: A prefix for all files associated with this run.
    inputBinding:
      position: 101
      prefix: -prefix
  - id: processes
    type:
      - 'null'
      - int
    doc: The number of processes Referee should use.
    inputBinding:
      position: 101
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Set this flag to prevent Referee from reporting detailed\n             \
      \        information about each step."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: raw
    type:
      - 'null'
      - boolean
    doc: "Set this flag to output the raw score as the fourth\n                  \
      \   column in the tabbed output."
    inputBinding:
      position: 101
      prefix: --raw
  - id: reference_file
    type:
      - 'null'
      - File
    doc: The FASTA assembly to which you have mapped your reads.
    inputBinding:
      position: 101
      prefix: -ref
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/referee:1.2--hdfd78af_0
stdout: referee_referee.py.out
