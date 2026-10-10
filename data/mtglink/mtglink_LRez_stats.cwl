cwlVersion: v1.2
class: CommandLineTool
baseCommand: [LRez, stats]
label: mtglink_LRez_stats
doc: "Retrieve general stats from a BAM file.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: bam
    type: File
    doc: "BAM file to retrieve stats from"
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      prefix: -b
  - id: regions
    type: ['null', int]
    doc: "Number of regions to consider to define stats (default: 1000)"
    inputBinding:
      prefix: -r
  - id: size
    type: ['null', int]
    doc: "Size of the regions to consider (default: 1000)"
    inputBinding:
      prefix: -s
  - id: output
    type: string
    doc: "File where to output the stats"
    inputBinding:
      prefix: -o
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use (default: 1)"
    inputBinding:
      prefix: -t
outputs:
  - id: result
    type: File
    doc: BAM statistics
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
