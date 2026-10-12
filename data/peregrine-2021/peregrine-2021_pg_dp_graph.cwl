cwlVersion: v1.2
class: CommandLineTool
baseCommand: pg_dp_graph
label: peregrine-2021_pg_dp_graph
doc: "Take overlap data files as input to generate the layout file using a polyploid aware layout algorithm (Peregrine-2021 assembler stage).\n\nTool homepage: https://github.com/cschin/peregrine-2021"
inputs:
  - id: prefix
    type: string
    doc: Path prefix for input files (the overlap files)
    inputBinding:
      position: 110
      prefix: --prefix
  - id: out_prefix
    type: string
    doc: Path prefix for output files
    inputBinding:
      position: 110
      prefix: --out_prefix
  - id: overlap_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Overlap files made by pg_ovlp; they are staged in the working directory so the prefix resolves.
  - id: bestn
    type:
      - 'null'
      - int
    doc: number of best overlaps for initial graph (default 6)
    inputBinding:
      position: 110
      prefix: --bestn
  - id: log
    type:
      - 'null'
      - string
    doc: "log level: DBBUG or INFO (default)"
    inputBinding:
      position: 110
      prefix: --log
outputs:
  - id: graph_files
    type:
      type: array
      items: File
    doc: Graph and layout files
    outputBinding:
      glob: $(inputs.out_prefix)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.overlap_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
