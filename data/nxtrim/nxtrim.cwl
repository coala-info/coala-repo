cwlVersion: v1.2
class: CommandLineTool
baseCommand: nxtrim
label: nxtrim
doc: "Trims adapter sequences from FASTQ files.\n\nTool homepage: https://github.com/sequencing/NxTrim"
inputs:
  - id: aggressive
    type:
      - 'null'
      - boolean
    doc: more aggressive adapter search (see docs/adapter.md)
    inputBinding:
      position: 101
      prefix: --aggressive
  - id: ignorePF
    type:
      - 'null'
      - boolean
    doc: ignore chastity/purity filters in read headers
    inputBinding:
      position: 101
      prefix: --ignorePF
  - id: justmp
    type:
      - 'null'
      - boolean
    doc: just creates a the mp/unknown libraries (reads with adapter at the 
      start will be completely N masked)
    inputBinding:
      position: 101
      prefix: --justmp
  - id: minlength
    type:
      - 'null'
      - int
    doc: The minimum read length to output (smaller reads will be filtered)
    inputBinding:
      position: 101
      prefix: --minlength
  - id: minoverlap
    type:
      - 'null'
      - int
    doc: The minimum overlap to be considered for matching
    inputBinding:
      position: 101
      prefix: --minoverlap
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: preserve_mp
    type:
      - 'null'
      - boolean
    doc: preserve MPs even when the corresponding PE has longer reads
    inputBinding:
      position: 101
      prefix: --preserve-mp
  - id: r1
    type: File
    doc: read 1 in fastq format (gzip allowed)
    inputBinding:
      position: 101
      prefix: --r1
  - id: r2
    type: File
    doc: read 2 in fastq format (gzip allowed)
    inputBinding:
      position: 101
      prefix: --r2
  - id: rf
    type:
      - 'null'
      - boolean
    doc: leave mate pair reads in RF orientation [by default are flipped into 
      FR]
    inputBinding:
      position: 101
      prefix: --rf
  - id: separate
    type:
      - 'null'
      - boolean
    doc: output paired reads in separate files (prefix_R1/prefix_r2). Default is
      interleaved.
    inputBinding:
      position: 101
      prefix: --separate
  - id: similarity
    type:
      - 'null'
      - float
    doc: The minimum similarity between strings to be considered a match 
      (Hamming distance divided by string length)
    inputBinding:
      position: 101
      prefix: --similarity
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: print trimmed reads to stdout (equivalent to justmp)
    inputBinding:
      position: 101
      prefix: --stdout
  - id: stdout_mp
    type:
      - 'null'
      - boolean
    doc: print only known MP reads to stdout (good for scaffolding)
    inputBinding:
      position: 101
      prefix: --stdout-mp
  - id: stdout_un
    type:
      - 'null'
      - boolean
    doc: print only unknown reads to stdout
    inputBinding:
      position: 101
      prefix: --stdout-un
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nxtrim:0.4.3--he513fc3_0
stdout: nxtrim.out
