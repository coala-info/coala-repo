cwlVersion: v1.2
class: CommandLineTool
baseCommand: seidr_convert
label: seidr_convert
doc: "Convert different text based formats\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: fill
    type:
      - 'null'
      - string
    doc: Fill value for missing data (Number, NaN, Inf, -Inf)
    default: NaN
    inputBinding:
      position: 101
      prefix: --fill
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file if it exists
    inputBinding:
      position: 101
      prefix: --force
  - id: from
    type:
      - 'null'
      - string
    doc: Input file format [edge-list, sym-mat, low-tri, up-tri, low-tri-diag, 
      up-tri-diag, aracne]
    inputBinding:
      position: 101
      prefix: --from
  - id: genes
    type:
      - 'null'
      - File
    doc: Input gene file name
    inputBinding:
      position: 101
      prefix: --genes
  - id: in_separator
    type:
      - 'null'
      - string
    doc: Input separator
    default: \t
    inputBinding:
      position: 101
      prefix: --in-separator
  - id: infile
    type:
      - 'null'
      - File
    doc: Input file name ['-' for stdin]
    default: '-'
    inputBinding:
      position: 101
      prefix: --infile
  - id: out_separator
    type:
      - 'null'
      - string
    doc: Output separator
    default: \t
    inputBinding:
      position: 101
      prefix: --out-separator
  - id: precision
    type:
      - 'null'
      - int
    doc: Number of decimals to print
    default: 8
    inputBinding:
      position: 101
      prefix: --precision
  - id: to
    type:
      - 'null'
      - string
    doc: Output file format [edge-list, sym-mat, low-tri, up-tri, low-tri-diag, 
      up-tri-diag, aracne]
    inputBinding:
      position: 101
      prefix: --to
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file name ['-' for stdout]
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
