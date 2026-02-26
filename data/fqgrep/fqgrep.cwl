cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqgrep
label: fqgrep
doc: "A tool for searching for DNA sequences in FASTQ files, supporting mismatches
  and reverse complement searches.\n\nTool homepage: https://github.com/fulcrumgenomics/fqgrep"
inputs:
  - id: pattern
    type: string
    doc: The DNA sequence pattern to search for
    inputBinding:
      position: 1
  - id: fastq_files
    type:
      type: array
      items: File
    doc: One or more FASTQ files to search in
    inputBinding:
      position: 2
  - id: count
    type:
      - 'null'
      - boolean
    doc: Only print a count of matching records
    inputBinding:
      position: 103
      prefix: --count
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case distinctions
    inputBinding:
      position: 103
      prefix: --ignore-case
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: Select non-matching records
    inputBinding:
      position: 103
      prefix: --invert-match
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Number of allowed mismatches
    default: 0
    inputBinding:
      position: 103
      prefix: --mismatches
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Search for the reverse complement of the pattern as well
    inputBinding:
      position: 103
      prefix: --reverse-complement
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqgrep:1.1.1--ha6fb395_0
stdout: fqgrep.out
