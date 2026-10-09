cwlVersion: v1.2
class: CommandLineTool
baseCommand: gambit
label: hesslab-gambit_query
doc: "Predict taxonomy of microbial samples from genome sequences.\n\nTool homepage: https://github.com/hesslab-gambit/gambit"
arguments:
  - position: 2
    valueFrom: query
inputs:
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome sequence files (FASTA) to query.
    inputBinding:
      position: 200
  - id: db
    type:
      - 'null'
      - Directory
    doc: Directory containing GAMBIT database files (the root level --db option).
    inputBinding:
      position: 1
      prefix: --db
  - id: listfile
    type:
      - 'null'
      - File
    doc: File containing paths to genomes.
    inputBinding:
      position: 101
      prefix: -l
  - id: ldir
    type:
      - 'null'
      - Directory
    doc: Parent directory of paths in LISTFILE.
    inputBinding:
      position: 101
      prefix: --ldir
  - id: output_path
    type:
      - 'null'
      - string
    doc: File path to write to. If omitted will write to stdout.
    inputBinding:
      position: 101
      prefix: --output
  - id: outfmt
    type:
      - 'null'
      - string
    doc: 'Format to output results in: csv, json or archive.'
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: sigfile
    type:
      - 'null'
      - File
    doc: File containing query signatures, to use in place of GENOMES.
    inputBinding:
      position: 101
      prefix: --sigfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the results when output_path is not given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Results file written to output_path
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
stdout: hesslab-gambit_query.out
