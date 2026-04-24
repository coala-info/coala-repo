cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./JARVIS
label: jarvis_JARVIS
doc: "extreme lossless compression of genomic sequences.\n\nTool homepage: https://github.com/cobilab/jarvis"
inputs:
  - id: file
    type: File
    doc: Input sequence filename (to compress) -- MANDATORY.
    inputBinding:
      position: 1
  - id: context_model
    type:
      - 'null'
      - type: array
        items: string
    doc: Template of a context model.
    inputBinding:
      position: 102
      prefix: -cm
  - id: estimate
    type:
      - 'null'
      - boolean
    doc: it creates a file with the extension ".iae" with the respective 
      information content. If the file is FASTA or FASTQ it will only use the 
      "ACGT" (genomic) sequence.
    inputBinding:
      position: 102
      prefix: --estimate
  - id: estimation
    type:
      - 'null'
      - boolean
    doc: creates [sequence].info with complexity profile.
    inputBinding:
      position: 102
      prefix: --estimation
  - id: force
    type:
      - 'null'
      - boolean
    doc: force mode. Overwrites old files.
    inputBinding:
      position: 102
      prefix: --force
  - id: level
    type:
      - 'null'
      - int
    doc: Compression level (integer).
    inputBinding:
      position: 102
      prefix: --level
  - id: repeat_model
    type:
      - 'null'
      - type: array
        items: string
    doc: Template of a repeat model.
    inputBinding:
      position: 102
      prefix: -rm
  - id: selection
    type:
      - 'null'
      - int
    doc: Size of the context selection model (integer).
    inputBinding:
      position: 102
      prefix: --selection
  - id: show_levels
    type:
      - 'null'
      - boolean
    doc: show pre-computed compression levels (configured).
    inputBinding:
      position: 102
      prefix: --show-levels
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode (more information).
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jarvis:1.1--h7b50bb2_6
stdout: jarvis_JARVIS.out
