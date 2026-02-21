cwlVersion: v1.2
class: CommandLineTool
baseCommand: parallel-fastq-dump
label: parallel-fastq-dump
doc: "parallel fastq-dump wrapper, extra args will be passed through\n\nTool homepage:
  https://github.com/rvalieris/parallel-fastq-dump"
inputs:
  - id: max_spot_id
    type:
      - 'null'
      - int
    doc: Maximum spot id
    inputBinding:
      position: 101
      prefix: --maxSpotId
  - id: min_spot_id
    type:
      - 'null'
      - int
    doc: Minimum spot id
    default: 1
    inputBinding:
      position: 101
      prefix: --minSpotId
  - id: sra_id
    type:
      - 'null'
      - string
    doc: SRA id
    inputBinding:
      position: 101
      prefix: --sra-id
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: temporary directory
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-fastq-dump:0.6.7--pyhdfd78af_0
