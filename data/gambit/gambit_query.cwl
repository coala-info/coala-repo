cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gambit
label: gambit_query
doc: "Predict taxonomy of microbial samples from genome sequences.\n\nTool homepage:
  https://github.com/jlumpe/gambit"
inputs:
  - id: db
    type:
      - 'null'
      - Directory
    doc: Directory containing GAMBIT database files (global option, given before the subcommand).
    inputBinding:
      position: 1
      prefix: --db
  - id: genomes
    type:
      type: array
      items: File
    doc: Genome sequences to query
    inputBinding:
      position: 3
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use.
    inputBinding:
      position: 102
      prefix: --cores
  - id: ldir
    type:
      - 'null'
      - Directory
    doc: Parent directory of paths in LISTFILE.
    inputBinding:
      position: 102
      prefix: --ldir
  - id: listfile
    type:
      - 'null'
      - File
    doc: File containing paths to query genomes, one per line.
    inputBinding:
      position: 102
      prefix: -l
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Don't show progress meter.
    inputBinding:
      position: 102
      prefix: --no-progress
  - id: outfmt
    type:
      - 'null'
      - string
    doc: Format to output results in.
    inputBinding:
      position: 102
      prefix: --outfmt
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress meter.
    inputBinding:
      position: 102
      prefix: --progress
  - id: sigfile
    type:
      - 'null'
      - File
    doc: File containing query signatures, to use in place of GENOMES.
    inputBinding:
      position: 102
      prefix: --sigfile
  - id: output_filename_path
    type:
      - 'null'
      - string
    doc: File path to write to. If omitted will write to stdout.
    inputBinding:
      position: 103
      prefix: --output
arguments:
  - position: 2
    valueFrom: query
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (results when --output is omitted)
  - id: output_filename
    type:
      - 'null'
      - File
    doc: File path to write to. If omitted will write to stdout.
    outputBinding:
      glob: $(inputs.output_filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
stdout: gambit_query.out
