cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varfish-server-worker
  - strucvars
  - txt-to-bin
label: varfish-server-worker_strucvars_txt-to-bin
doc: 'Convert to binary protobuf files.


  Tool homepage: https://github.com/varfish-org/varfish-server-worker'
inputs:
  - id: input_type
    type: string
    doc: Input type to convert to binary (clinvar-sv, strucvar-inhouse, strucvar-db-var,
      strucvar-dgv, strucvar-dgv-gs, strucvar-exac-cnv, strucvar-g1k, strucvar-gnomad-sv2,
      strucvar-gnomad-cnv4, strucvar-gnomad-sv4, masked-region, xlink)
    inputBinding:
      position: 102
      prefix: --input-type
  - id: path_input
    type: File
    doc: Input file to convert to binary
    inputBinding:
      position: 102
      prefix: --path-input
  - id: path_output
    type: string
    doc: Path to output BIN file
    inputBinding:
      position: 102
      prefix: --path-output
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 102
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease logging verbosity
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: output_bin
    type:
      - 'null'
      - File
    doc: Binary protobuf output file
    outputBinding:
      glob: $(inputs.path_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
