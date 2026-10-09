cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LRez
  - stats
label: leviathan_LRez_stats
doc: "Retrieve general stats from a BAM file.\n\nTool homepage: https://github.com/morispi/LEVIATHAN"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: 'BAM file to retrieve stats from'
    inputBinding:
      position: 1
      prefix: -b
  - id: regions
    type:
      - 'null'
      - int
    doc: 'Number of regions to consider to define stats (default: 1000)'
    inputBinding:
      position: 2
      prefix: -r
  - id: size
    type:
      - 'null'
      - int
    doc: 'Size of the regions to consider (default: 1000)'
    inputBinding:
      position: 3
      prefix: -s
  - id: output_file
    type: string
    doc: 'File where to output the results'
    inputBinding:
      position: 4
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (default: 1)'
    inputBinding:
      position: 5
      prefix: -t
outputs:
  - id: output
    type: File
    doc: 'The BAM file statistics'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
