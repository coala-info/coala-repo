cwlVersion: v1.2
class: CommandLineTool
baseCommand: itsxpress
label: itsxpress
doc: "ITSxpress: A tool to rapidly trim ITS regions from FASTQ files.\n\nTool homepage:
  http://github.com/usda-ars-gbru/itsxpress"
inputs:
  - id: mode
    type: string
    doc: 'Analysis mode: fastq, single_end, or interleaved'
    inputBinding:
      position: 1
  - id: cluster_id
    type:
      - 'null'
      - float
    doc: The percent identity for clustering with VSEARCH
    default: 0.99
    inputBinding:
      position: 102
      prefix: --cluster_id
  - id: fastq
    type:
      - 'null'
      - File
    doc: Input FASTQ file (forward reads or single-end)
    inputBinding:
      position: 102
      prefix: --fastq
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Input FASTQ file (reverse reads)
    inputBinding:
      position: 102
      prefix: --fastq2
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 102
      prefix: --log
  - id: region
    type:
      - 'null'
      - string
    doc: 'ITS region to trim: ITS1, ITS2, or ALL'
    inputBinding:
      position: 102
      prefix: --region
  - id: taxa
    type:
      - 'null'
      - string
    doc: Taxon group (e.g., Fungi, Algae, Bryophyta, etc.)
    inputBinding:
      position: 102
      prefix: --taxa
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processor threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output trimmed FASTQ file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itsxpress:2.1.4--pyhdfd78af_0
