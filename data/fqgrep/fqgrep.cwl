cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqgrep
label: fqgrep
doc: "The fqgrep utility searches any given input FASTQ files, selecting records whose bases match one or more patterns. By default, a pattern matches the bases in a FASTQ record if the regular expression in the pattern matches the bases. Each FASTQ record that matches at least one of the patterns is written to the standard output.\n\nTool homepage: https://github.com/fulcrumgenomics/fqgrep"
inputs:
  - id: pattern
    type:
      - 'null'
      - string
    doc: "The pattern to match; leave it out when -e or -f gives the patterns"
    inputBinding:
      position: 1
  - id: fastq_files
    type:
      type: array
      items: File
    doc: "FASTQ files to search (gzipped files are detected automatically)"
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads to use for matching reads against pattern"
    inputBinding:
      position: 103
      prefix: --threads
  - id: color
    type:
      - 'null'
      - string
    doc: "Mark up the matching text: never, always or auto"
    inputBinding:
      position: 103
      prefix: --color
  - id: count
    type:
      - 'null'
      - boolean
    doc: "Only a count of selected lines is written to standard output"
    inputBinding:
      position: 103
      prefix: --count
  - id: regexp
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --regexp
    doc: "A pattern used during the search of the input; may be given several times (then all arguments are files)"
    inputBinding:
      position: 103
  - id: fixed_strings
    type:
      - 'null'
      - boolean
    doc: "Interpret pattern as a set of fixed strings"
    inputBinding:
      position: 103
      prefix: --fixed-strings
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: "Read one or more newline separated patterns from file"
    inputBinding:
      position: 103
      prefix: --file
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: "Selected lines are those not matching any of the specified patterns"
    inputBinding:
      position: 103
      prefix: -v
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: "Assume all unrecognized inputs are GZIP compressed"
    inputBinding:
      position: 103
      prefix: --decompress
  - id: paired
    type:
      - 'null'
      - boolean
    doc: "Treat the input files as paired (R1, R2, R1, R2, ...); if the pattern matches either read, both are output interleaved"
    inputBinding:
      position: 103
      prefix: --paired
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: "Search the reverse complement for matches"
    inputBinding:
      position: 103
      prefix: --reverse-complement
  - id: progress
    type:
      - 'null'
      - boolean
    doc: "Write progress information"
    inputBinding:
      position: 103
      prefix: --progress
outputs:
  - id: stdout
    type: stdout
    doc: "Selected FASTQ records, or the count with --count"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqgrep:1.1.1--ha6fb395_0
stdout: fqgrep.out
