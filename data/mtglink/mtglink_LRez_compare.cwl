cwlVersion: v1.2
class: CommandLineTool
baseCommand: [LRez, compare]
label: mtglink_LRez_compare
doc: "Compute the number of common barcodes between all possible pairs of a list of regions, or between a contig's extremities and all other contigs' extremities.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: bam
    type: File
    doc: "BAM file containing the alignments"
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      prefix: -b
  - id: index
    type: File
    doc: "Barcodes offsets index built with the index bam subcommand"
    inputBinding:
      prefix: -i
  - id: regions
    type: ['null', File]
    doc: "File containing regions of interest in format chromosome:startPosition-endPosition"
    inputBinding:
      prefix: -r
  - id: contig
    type: ['null', string]
    doc: "Contig of interest"
    inputBinding:
      prefix: -c
  - id: contigs
    type: ['null', File]
    doc: "File containing a list of contigs of interest"
    inputBinding:
      prefix: -C
  - id: size
    type: ['null', int]
    doc: "Size of contigs' extremities to consider (default: 1000)"
    inputBinding:
      prefix: -s
  - id: output
    type: string
    doc: "File where to output the results"
    inputBinding:
      prefix: -o
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use when comparing a list of contigs (default: 1)"
    inputBinding:
      prefix: -t
outputs:
  - id: result
    type: File
    doc: Barcode-sharing results table
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
