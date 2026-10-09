cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LRez
  - extract
label: leviathan_LRez_extract
doc: "Extract the list of barcodes in a given region of a BAM file.\n\nTool homepage: https://github.com/morispi/LEVIATHAN"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: 'BAM file to extract barcodes from'
    inputBinding:
      position: 1
      prefix: -b
  - id: region
    type:
      - 'null'
      - string
    doc: 'Region of interest in format chromosome:startPosition-endPosition'
    inputBinding:
      position: 2
      prefix: -r
  - id: all
    type:
      - 'null'
      - boolean
    doc: 'Extract all barcodes'
    inputBinding:
      position: 3
      prefix: -a
  - id: output_file
    type: string
    doc: 'File where to output the results'
    inputBinding:
      position: 4
      prefix: -o
  - id: duplicates
    type:
      - 'null'
      - boolean
    doc: 'Include duplicate barcodes (default: false)'
    inputBinding:
      position: 5
      prefix: -d
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (default: 1)'
    inputBinding:
      position: 6
      prefix: -t
outputs:
  - id: output
    type: File
    doc: 'The extracted barcodes'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
