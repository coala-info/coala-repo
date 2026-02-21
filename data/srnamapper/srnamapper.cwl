cwlVersion: v1.2
class: CommandLineTool
baseCommand: srnamapper
label: srnamapper
doc: "A tool for specifically mapping small RNA reads to a reference genome, allowing
  for a user-defined number of mismatches.\n\nTool homepage: https://github.com/mzytnicki/srnaMapper"
inputs:
  - id: all_matches
    type:
      - 'null'
      - boolean
    doc: Report all matches for each read
    inputBinding:
      position: 101
      prefix: -a
  - id: best_match
    type:
      - 'null'
      - boolean
    doc: Report only the best matches for each read
    inputBinding:
      position: 101
      prefix: -b
  - id: input_file
    type: File
    doc: Input file containing small RNA reads (FASTA/FASTQ format)
    inputBinding:
      position: 101
      prefix: -i
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Number of allowed mismatches
    default: 0
    inputBinding:
      position: 101
      prefix: -m
  - id: reference_file
    type: File
    doc: Reference genome file (FASTA format)
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name (SAM format)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srnamapper:1.0.12--h577a1d6_0
