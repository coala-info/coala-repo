cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LRez
  - compare
label: leviathan_LRez_compare
doc: "Compute the number of common barcodes between all possible pairs of a given list of regions, or between a given contig's extremities and all other contigs' extremities.\n\nTool homepage: https://github.com/morispi/LEVIATHAN"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: 'BAM file containing the alignments'
    inputBinding:
      position: 1
      prefix: -b
  - id: index
    type: File
    doc: 'Barcodes offsets index built with the index bam subcommand'
    inputBinding:
      position: 2
      prefix: -i
  - id: regions
    type:
      - 'null'
      - File
    doc: 'File containing regions of interest in format chromosome:startPosition-endPosition'
    inputBinding:
      position: 3
      prefix: -r
  - id: contig
    type:
      - 'null'
      - string
    doc: 'Contig of interest'
    inputBinding:
      position: 4
      prefix: -c
  - id: contigs
    type:
      - 'null'
      - File
    doc: 'File containing a list of contigs of interest'
    inputBinding:
      position: 5
      prefix: -C
  - id: size
    type:
      - 'null'
      - int
    doc: 'Size of contigs'' extremities to consider (default: 1000)'
    inputBinding:
      position: 6
      prefix: -s
  - id: output_file
    type: string
    doc: 'File where to output the results'
    inputBinding:
      position: 7
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use when comparing a list of contigs (default: 1)'
    inputBinding:
      position: 8
      prefix: -t
outputs:
  - id: output
    type: File
    doc: 'Number of common barcodes between the regions or contigs'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
