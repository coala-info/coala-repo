cwlVersion: v1.2
class: CommandLineTool
baseCommand: [LRez, extract]
label: mtglink_LRez_extract
doc: "Extract the list of barcodes in a given region of a BAM file.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: bam
    type: File
    doc: "BAM file to extract barcodes from"
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      prefix: -b
  - id: region
    type: ['null', string]
    doc: "Region of interest in format chromosome:startPosition-endPosition"
    inputBinding:
      prefix: -r
  - id: all
    type: ['null', boolean]
    doc: "Extract all barcodes"
    inputBinding:
      prefix: -a
  - id: output
    type: string
    doc: "File where to output the extracted barcodes"
    inputBinding:
      prefix: -o
  - id: duplicates
    type: ['null', boolean]
    doc: "Include duplicate barcodes (default: false)"
    inputBinding:
      prefix: -d
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use (default: 1)"
    inputBinding:
      prefix: -t
outputs:
  - id: result
    type: File
    doc: Extracted barcodes
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
