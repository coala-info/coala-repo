cwlVersion: v1.2
class: CommandLineTool
baseCommand: samclip
label: samclip
doc: "Filter SAM file for soft & hard clipped alignments\n\nTool homepage: https://github.com/tseemann/samclip"
inputs:
  - id: input_sam
    type: File
    doc: Input SAM file
    inputBinding:
      position: 200
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print verbose debug info to stderr
    inputBinding:
      position: 101
      prefix: --debug
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Output rejected SAM lines and ignore good ones
    inputBinding:
      position: 101
      prefix: --invert
  - id: max_clip_length
    type:
      - 'null'
      - int
    doc: Maximum clip length to allow (default=5)
    inputBinding:
      position: 101
      prefix: --max
  - id: progress
    type:
      - 'null'
      - int
    doc: Print progress every NUM records (default=100000,none=0)
    inputBinding:
      position: 101
      prefix: --progress
  - id: reference_genome
    type: File
    secondaryFiles:
      - pattern: .fai
    doc: Reference genome - needs FASTA.fai index
    inputBinding:
      position: 101
      prefix: --ref
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the filtered SAM)
  - id: stderr
    type: stderr
    doc: Standard error (clipping statistics)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samclip:0.4.0--hdfd78af_1
stdout: samclip.out
stderr: samclip.err
