cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - cmd
  - merge-cov
label: cnvetti_cmd_merge-cov
doc: "Merge the coverage information for multiple samples. This command merges multiple coverage BCF files with non-overlapping sample sets into one multi-sample coverage BCF file.\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    secondaryFiles:
      - .csi
    doc: "Path to indexed input BCF or VCF file from `cnvetti cmd coverage` output."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Path to output BCF file (will also write .csi file)"
    inputBinding:
      position: 101
      prefix: --output
  - id: io_threads
    type:
      - 'null'
      - int
    doc: "Number of additional threads to use for (de)compression in I/O."
    inputBinding:
      position: 101
      prefix: --io-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Decrease verbosity"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Path to output BCF file (will also write .csi file)"
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - .csi
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
