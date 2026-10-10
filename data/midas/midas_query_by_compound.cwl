cwlVersion: v1.2
class: CommandLineTool
baseCommand: query_by_compound.py
label: midas_query_by_compound
doc: "Query MIDAS results for genes that produce or consume a KEGG compound.\n\nTool homepage: https://github.com/snayfach/MIDAS"
inputs:
  - id: input_dirs
    type:
      type: array
      items: Directory
    doc: Sample directories output by run_midas.py (given to -i as a comma-separated list, -t list).
    inputBinding:
      position: 101
      prefix: -i
      itemSeparator: ','
  - id: db
    type:
      - 'null'
      - Directory
    doc: Path to reference database. By default, the MIDAS_DB environmental variable is used.
    inputBinding:
      position: 101
      prefix: -d
  - id: compound
    type: string
    doc: KEGG Compound identifier.
    inputBinding:
      position: 101
      prefix: -c
  - id: out
    type:
      - 'null'
      - string
    doc: 'Path to output file (default: standard output).'
    inputBinding:
      position: 101
      prefix: -o
arguments:
  - prefix: -t
    valueFrom: list
outputs:
  - id: result
    type: stdout
    doc: Query results (standard output).
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file, when -o is given.
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
