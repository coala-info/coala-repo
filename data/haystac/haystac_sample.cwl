cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystac_sample
label: haystac_sample
doc: "Prepare a sample for analysis\n\nTool homepage: https://github.com/antonisdim/haystac"
inputs:
  - id: collapse
    type:
      - 'null'
      - boolean
    doc: Collapse overlapping paired-end reads, e.g. for aDNA
    default: false
    inputBinding:
      position: 101
      prefix: --collapse
  - id: cores
    type:
      - 'null'
      - int
    doc: Maximum number of CPU cores to use
    default: 20
    inputBinding:
      position: 101
      prefix: --cores
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging mode
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: fastq
    type:
      - 'null'
      - File
    doc: Single-end fastq input file (optionally compressed).
    inputBinding:
      position: 101
      prefix: --fastq
  - id: fastq_r1
    type:
      - 'null'
      - File
    doc: Paired-end forward strand (R1) fastq input file.
    inputBinding:
      position: 101
      prefix: --fastq-r1
  - id: fastq_r2
    type:
      - 'null'
      - File
    doc: Paired-end reverse strand (R2) fastq input file.
    inputBinding:
      position: 101
      prefix: --fastq-r2
  - id: mem
    type:
      - 'null'
      - int
    doc: Maximum memory (MB) to use
    default: 63985
    inputBinding:
      position: 101
      prefix: --mem
  - id: snakemake
    type:
      - 'null'
      - string
    doc: Pass additional flags to the `snakemake` scheduler.
    inputBinding:
      position: 101
      prefix: --snakemake
  - id: sra
    type:
      - 'null'
      - string
    doc: Download fastq input from the SRA database
    inputBinding:
      position: 101
      prefix: --sra
  - id: trim_adapters
    type:
      - 'null'
      - boolean
    doc: Automatically trim sequencing adapters from fastq input
    default: true
    inputBinding:
      position: 101
      prefix: --trim-adapters
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Unlock the output directory following a crash or hard restart
    default: false
    inputBinding:
      position: 101
      prefix: --unlock
outputs:
  - id: output
    type: Directory
    doc: Path to the sample output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
