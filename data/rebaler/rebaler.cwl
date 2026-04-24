cwlVersion: v1.2
class: CommandLineTool
baseCommand: rebaler
label: rebaler
doc: "reference-based long read assemblies of bacterial genomes\n\nTool homepage:
  https://github.com/rrwick/Rebaler"
inputs:
  - id: reference
    type: File
    doc: FASTA file of reference assembly
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: FASTA/FASTQ file of long reads
    inputBinding:
      position: 2
  - id: direct
    type:
      - 'null'
      - boolean
    doc: If set, Rebaler will polish the given genome without first producing an
      unpolished version
    inputBinding:
      position: 103
      prefix: --direct
  - id: random
    type:
      - 'null'
      - boolean
    doc: If a part of the reference is missing, replace it with random sequence
    inputBinding:
      position: 103
      prefix: --random
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for alignment and polishing
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rebaler:0.2.0--py_0
stdout: rebaler.out
