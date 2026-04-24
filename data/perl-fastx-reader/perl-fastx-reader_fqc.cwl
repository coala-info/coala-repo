cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqc
label: perl-fastx-reader_fqc
doc: "A FASTA/FASTQ sequence counter that parses a list of files and prints the number
  of sequences found in each.\n\nTool homepage: https://github.com/telatin/FASTQ-Parser"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA/FASTQ files (supports uncompressed and GZipped)
    inputBinding:
      position: 1
  - id: abspath
    type:
      - 'null'
      - boolean
    doc: Print the absolute path of the filename
    inputBinding:
      position: 102
      prefix: --abspath
  - id: basename
    type:
      - 'null'
      - boolean
    doc: Print the filename without the path
    inputBinding:
      position: 102
      prefix: --basename
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Print a tabular output comma separated
    inputBinding:
      position: 102
      prefix: --csv
  - id: fastx
    type:
      - 'null'
      - boolean
    doc: Force FASTX reader also for files ending by .fastq or .fq
    inputBinding:
      position: 102
      prefix: --fastx
  - id: json
    type:
      - 'null'
      - boolean
    doc: Print full output in JSON format
    inputBinding:
      position: 102
      prefix: --json
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: Same as JSON but in "pretty" format
    inputBinding:
      position: 102
      prefix: --pretty
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse the sorting order
    inputBinding:
      position: 102
      prefix: --reverse
  - id: screen
    type:
      - 'null'
      - boolean
    doc: Print an ASCII-art table (requires Term::ASCIITable)
    inputBinding:
      position: 102
      prefix: --screen
  - id: sortby
    type:
      - 'null'
      - string
    doc: "Sort by field: 'order', 'count', or 'name'"
    inputBinding:
      position: 102
      prefix: --sortby
  - id: thousandsep
    type:
      - 'null'
      - boolean
    doc: Print reads number with a "," used as thousand separator
    inputBinding:
      position: 102
      prefix: --thousandsep
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Print a tabular output tab separated
    inputBinding:
      position: 102
      prefix: --tsv
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fastx-reader:1.12.0--pl5321hdfd78af_0
stdout: perl-fastx-reader_fqc.out
