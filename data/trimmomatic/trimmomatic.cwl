cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimmomatic
label: trimmomatic
doc: "A flexible read trimming tool for Illumina NGS data. Note: The provided text
  contains a Docker error message ('no space left on device') rather than the tool's
  help output. The following structure represents the standard Trimmomatic interface.\n\
  \nTool homepage: https://www.plabipd.de/trimmomatic_main.html"
inputs:
  - id: mode
    type: string
    doc: 'Trimming mode: PE (Paired End) or SE (Single End)'
    inputBinding:
      position: 1
  - id: inputs_and_outputs
    type:
      type: array
      items: File
    doc: Input and output files (order depends on PE/SE mode)
    inputBinding:
      position: 2
  - id: steps
    type:
      type: array
      items: string
    doc: Trimming steps (e.g., ILLUMINACLIP, SLIDINGWINDOW, MINLEN)
    inputBinding:
      position: 3
  - id: phred33
    type:
      - 'null'
      - boolean
    doc: Use Phred-33 quality scores
    inputBinding:
      position: 104
      prefix: -phred33
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: Use Phred-64 quality scores
    inputBinding:
      position: 104
      prefix: -phred64
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error messages
    inputBinding:
      position: 104
      prefix: -quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 104
      prefix: -threads
  - id: validate_pairs
    type:
      - 'null'
      - boolean
    doc: Validate that the input files contain matching pairs
    inputBinding:
      position: 104
      prefix: -validatePairs
outputs:
  - id: trimlog
    type:
      - 'null'
      - File
    doc: Log file containing details of trimming for each read
    outputBinding:
      glob: $(inputs.trimlog)
  - id: summary
    type:
      - 'null'
      - File
    doc: File to write summary statistics
    outputBinding:
      glob: $(inputs.summary)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimmomatic:0.40--hdfd78af_0
