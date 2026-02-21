cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepsirf
  - subjoin
label: pepsirf_subjoin
doc: "The subjoin module is used to manipulate matrix files. This module can create
  a subset of an existing matrix, can combine multiple matrices together or perform
  a combination of these two functions.\n\nTool homepage: https://github.com/LadnerLab/PepSIRF"
inputs:
  - id: duplicate_evaluation
    type:
      - 'null'
      - string
    doc: Defines what should be done when sample or peptide names are not unique across
      files being joined (combine, include, or ignore).
    default: include
    inputBinding:
      position: 101
      prefix: --duplicate_evaluation
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: New data file will contain all of the input samples (or peptides) except
      the ones specified in the sample names.
    inputBinding:
      position: 101
      prefix: --exclude
  - id: filter_peptide_names
    type:
      - 'null'
      - boolean
    doc: Flag to include if the name lists input to the input or multi_file options
      should be treated as peptide (i.e. row) names instead of sample (i.e. column)
      names.
    inputBinding:
      position: 101
      prefix: --filter_peptide_names
  - id: input
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Comma-separated filenames (For example: score_matrix.tsv,sample_names.txt
      ). Each of these pairs must be a score matrix and a file containing the names
      of samples (or peptides, if specified) to keep in the score matrix.'
    inputBinding:
      position: 101
      prefix: --input
  - id: multi_file
    type:
      - 'null'
      - File
    doc: The name of a tab-delimited file containing score matrix and sample name
      list filename pairs, one per line. Each of these pairs must be a score matrix
      and a file containing the names of samples (or peptides, if specified) to keep
      from the input the score matrix.
    inputBinding:
      position: 101
      prefix: --multi_file
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Name for the output score matrix file.
    outputBinding:
      glob: $(inputs.output)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Designated file to which the module's processes are logged.
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
