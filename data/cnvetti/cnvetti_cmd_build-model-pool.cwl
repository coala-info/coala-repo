cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - cmd
  - build-model-pool
label: cnvetti_cmd_build-model-pool
doc: "Build model based on pooling a reference panel. This command takes a multi-sample coverage BCF file and computes per-region statistics across the cohort.\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: multicov
    type: File
    secondaryFiles:
      - .csi
    doc: "Path to indexed BCF file that was merged from multiple coverage files."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Path to output normalized counts BCF file."
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
    doc: "Path to output normalized counts BCF file."
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - .csi
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
