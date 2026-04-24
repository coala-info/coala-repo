cwlVersion: v1.2
class: CommandLineTool
baseCommand: andi
label: andi
doc: "Estimate evolutionary distances between closely related genomes.\n\nTool homepage:
  https://github.com/evolbioinf/andi/"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Any sequence of FASTA files. Use '-' as file name to read from stdin.
    inputBinding:
      position: 1
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: Print additional bootstrap matrices
    inputBinding:
      position: 102
      prefix: --bootstrap
  - id: file_of_filenames
    type:
      - 'null'
      - File
    doc: Read additional filenames from FILE; one per line
    inputBinding:
      position: 102
      prefix: --file-of-filenames
  - id: join
    type:
      - 'null'
      - boolean
    doc: Treat all sequences from one file as a single genome
    inputBinding:
      position: 102
      prefix: --join
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: Use less memory at the cost of speed
    inputBinding:
      position: 102
      prefix: --low-memory
  - id: model
    type:
      - 'null'
      - string
    doc: Pick an evolutionary model of 'Raw', 'JC', 'Kimura', 'LogDet'
    inputBinding:
      position: 102
      prefix: --model
  - id: progress
    type:
      - 'null'
      - string
    doc: Print a progress bar 'always', 'never', or 'auto'
    inputBinding:
      position: 102
      prefix: --progress
  - id: significance
    type:
      - 'null'
      - float
    doc: Significance of an anchor
    inputBinding:
      position: 102
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Set the number of threads; by default, all processors are used
    inputBinding:
      position: 102
      prefix: --threads
  - id: truncate_names
    type:
      - 'null'
      - boolean
    doc: Truncate names to ten characters
    inputBinding:
      position: 102
      prefix: --truncate-names
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints additional information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/andi:0.14--hfc2f157_2
stdout: andi.out
