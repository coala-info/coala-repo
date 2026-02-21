cwlVersion: v1.2
class: CommandLineTool
baseCommand: chemfp_fps2fpb
label: chemfp_fps2fpb
doc: "Convert a fingerprint file in FPS format to the FPB format. FPB files are a
  binary format for fingerprints that allow for fast loading and memory-mapped access.\n
  \nTool homepage: https://chemfp.com"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input FPS file. If not specified, stdin is used.
    inputBinding:
      position: 1
  - id: hex_column
    type:
      - 'null'
      - string
    doc: Column name or index for the hex-encoded fingerprint.
    inputBinding:
      position: 102
      prefix: --hex-column
  - id: id_column
    type:
      - 'null'
      - string
    doc: Column name or index for the identifier.
    inputBinding:
      position: 102
      prefix: --id-column
  - id: metadata
    type:
      - 'null'
      - File
    doc: Use the metadata from this file instead of the input file.
    inputBinding:
      position: 102
      prefix: --metadata
  - id: no_reorder
    type:
      - 'null'
      - boolean
    doc: Do not reorder the fingerprints.
    inputBinding:
      position: 102
      prefix: --no-reorder
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: Reorder the fingerprints by population count (default).
    inputBinding:
      position: 102
      prefix: --reorder
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output FPB file name.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
