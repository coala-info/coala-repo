cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - cmd
  - ratio
label: cnvetti_cmd_ratio
doc: "Compute the ratio between the coverages in two files. After computing coverage of tumor and normal samples and merging the resulting files, use this command to compute the ratio and log2-ratio between the two samples.\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - .csi
    doc: "Path to BCF or VCF file with merged coverages"
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Path to output BCF file (will also write .csi file)"
    inputBinding:
      position: 101
      prefix: --output
  - id: numerator_sample
    type: string
    doc: "Name of numerator sample name (tumor)."
    inputBinding:
      position: 101
      prefix: --numerator-sample
  - id: denominator_sample
    type: string
    doc: "Name of denominator sample name (normal)."
    inputBinding:
      position: 101
      prefix: --denominator-sample
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
