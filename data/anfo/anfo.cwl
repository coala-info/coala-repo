cwlVersion: v1.2
class: CommandLineTool
baseCommand: anfo
label: anfo
doc: "Align Next-generation sequencing reads to a reference genome using a probabilistic
  model.\n\nTool homepage: https://github.com/anforaProject/anfora"
inputs:
  - id: sequence_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sequence files
    inputBinding:
      position: 1
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output file
    inputBinding:
      position: 102
      prefix: --clobber
  - id: config
    type:
      - 'null'
      - File
    doc: Read config from FILE
    inputBinding:
      position: 102
      prefix: --config
  - id: fastq_origin
    type:
      - 'null'
      - int
    doc: Quality 0 encodes as ORI, not 33
    inputBinding:
      position: 102
      prefix: --fastq-origin
  - id: genome
    type:
      - 'null'
      - File
    doc: Use FILE as genome according to config
    inputBinding:
      position: 102
      prefix: --genome
  - id: housekeeping
    type:
      - 'null'
      - boolean
    doc: Perform housekeeping (e.g. trimming)
    inputBinding:
      position: 102
      prefix: --housekeeping
  - id: index
    type:
      - 'null'
      - File
    doc: Use FILE as index according to config
    inputBinding:
      position: 102
      prefix: --index
  - id: nommap
    type:
      - 'null'
      - boolean
    doc: Don't use mmap(), read() indexes instead
    inputBinding:
      position: 102
      prefix: --nommap
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress most output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: solexa_scale
    type:
      - 'null'
      - boolean
    doc: Quality scores use Solexa formula
    inputBinding:
      position: 102
      prefix: --solexa-scale
  - id: threads
    type:
      - 'null'
      - int
    doc: Run next step in N parallel worker threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Produce more output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to FILE
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anfo:v0.98-7-deb_cv1
