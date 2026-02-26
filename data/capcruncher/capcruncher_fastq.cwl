cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - fastq
label: capcruncher_fastq
doc: "Fastq splitting, deduplication and digestion.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: deduplicate
    type:
      - 'null'
      - boolean
    doc: Identifies PCR duplicate fragments from Fastq files.
    inputBinding:
      position: 101
  - id: digest
    type:
      - 'null'
      - boolean
    doc: Performs in silico digestion of one or a pair of fastq files.
    inputBinding:
      position: 101
  - id: split
    type:
      - 'null'
      - boolean
    doc: Splits fastq file(s) into equal chunks of n reads.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
stdout: capcruncher_fastq.out
