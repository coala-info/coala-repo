cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtools_find
label: fqtools_find
doc: "Find FASTQ reads containing specific sequences.\n\nTool homepage: https://github.com/alastair-droop/fqtools"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The fastq file(s) to view. If no input file is specified, input will be
      read from stdin.
    inputBinding:
      position: 1
  - id: output_stem
    type:
      - 'null'
      - string
    doc: Output file stem (default "output%"). The file stem to use for output 
      files (without file extension). Any instances of the single character 
      specified using the -p global argument will be replaced with the pair 
      number, or removed for single output files. If the -o option is not 
      specified, single file output will be written to stdout and paired file 
      output to the default stem (output%).
    inputBinding:
      position: 102
      prefix: -o
  - id: preserve_secondary_headers
    type:
      - 'null'
      - boolean
    doc: Preserve secondary headers (if present).
    inputBinding:
      position: 102
      prefix: -k
  - id: require_all_sequences
    type:
      - 'null'
      - boolean
    doc: Require all sequences for a match.
    inputBinding:
      position: 102
      prefix: -a
  - id: sequence
    type:
      - 'null'
      - type: array
        items: string
    doc: Sequence to match against. Multiple sequences are permitted. If -a is 
      specified, all specified sequences must be present for a read to match, 
      otherwise the presence of any one is sufficient. If no sequences are 
      specified, all reads are returned.
    inputBinding:
      position: 102
      prefix: -s
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: Read match sequences from file. If specified with -f, sequences are 
      read one per line from file. Empty lines are ignored.
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
stdout: fqtools_find.out
