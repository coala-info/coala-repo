cwlVersion: v1.2
class: CommandLineTool
baseCommand: pipits_pipits_createreadpairslist
label: pipits_pipits_createreadpairslist
doc: "Creates a read pairs list file for PIPITS from a directory of FASTQ files.\n\
  \nTool homepage: https://github.com/hsgweon/pipits"
inputs:
  - id: extra_extensions
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional file extensions to recognize as FASTQ (e.g., .fq .FQ.GZ). 
      Case-insensitive. Include the dot if desired.
    inputBinding:
      position: 101
      prefix: --extra-extensions
  - id: ignore_missing_pairs
    type:
      - 'null'
      - boolean
    doc: Ignore prefixes with missing pairs (singletons or >2 files) and create 
      the list file using only complete pairs.
    inputBinding:
      position: 101
      prefix: --ignore-missing-pairs
  - id: inputdir
    type: Directory
    doc: Directory containing raw paired-end sequence files (FASTQ format, can 
      be .gz or .bz2 compressed). Files should be named like 'SampleID_...R1...'
      and 'SampleID_...R2...'
    inputBinding:
      position: 101
      prefix: --inputdir
  - id: label_prefix
    type:
      - 'null'
      - string
    doc: "Add a specified prefix string to the beginning of each SampleID in the output
      file. Forbidden characters: '_', ' '"
    inputBinding:
      position: 101
      prefix: --label-prefix
  - id: label_suffix
    type:
      - 'null'
      - string
    doc: "Add a specified suffix string to the end of each SampleID in the output
      file. Forbidden characters: '_', ' '"
    inputBinding:
      position: 101
      prefix: --label-suffix
  - id: relabel
    type:
      - 'null'
      - string
    doc: "Rename all samples using the given text as a base, automatically appending
      sequential numbers (e.g., 'prefix001', 'prefix002'). Forbidden characters: '_',
      ' '"
    inputBinding:
      position: 101
      prefix: --relabel
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (log debug messages).
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Name of the output list file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pipits:4.0--pyhdfd78af_0
