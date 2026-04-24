cwlVersion: v1.2
class: CommandLineTool
baseCommand: shigatyper
label: shigatyper_shigatyper.py
doc: "Shigella serotyping from Illumina paired-end reads.\n\nTool homepage: https://github.com/CFSAN-Biostatistics/shigatyper"
inputs:
  - id: fastq_1
    type: File
    doc: Forward read file (FASTQ)
    inputBinding:
      position: 1
  - id: fastq_2
    type:
      - 'null'
      - File
    doc: Reverse read file (FASTQ)
    inputBinding:
      position: 2
  - id: msh
    type:
      - 'null'
      - boolean
    doc: Use MSH (MinHash) for identification
    inputBinding:
      position: 103
      prefix: --msh
  - id: no_clean
    type:
      - 'null'
      - boolean
    doc: Do not delete intermediate files
    inputBinding:
      position: 103
      prefix: --no-clean
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file for the results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shigatyper:2.0.5--pyhdfd78af_0
