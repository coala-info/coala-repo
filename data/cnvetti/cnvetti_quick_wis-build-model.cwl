cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - quick
  - wis-build-model
label: cnvetti_quick_wis-build-model
doc: "Build an within-sample model for targeted sequencing CNV calling. This call takes a list of BAM files that are aligned to the same reference and a tabix-indexed BED file with target regions, and writes a BCF file that defines a list of reference target regions for each of the input target regions.\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    secondaryFiles:
      - .bai
    doc: "Path to indexed input BAM file."
    inputBinding:
      position: 1
  - id: targets_bed
    type: File
    secondaryFiles:
      - .tbi
    doc: "Path to tabix-indexed BED file with intervals of the targets of WES."
    inputBinding:
      position: 101
      prefix: --targets-bed
  - id: output
    type: string
    doc: "Path to output model BCF file."
    inputBinding:
      position: 101
      prefix: --output
  - id: output_cov
    type:
      - 'null'
      - string
    doc: "Path to output per-sample coverage BCF file."
    inputBinding:
      position: 101
      prefix: --output-cov
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use. (default 1)"
    inputBinding:
      position: 101
      prefix: --num-threads
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
    doc: "Path to output model BCF file."
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - .csi
  - id: output_cov_file
    type:
      - 'null'
      - File
    doc: "Path to output per-sample coverage BCF file."
    outputBinding:
      glob: $(inputs.output_cov)
    secondaryFiles:
      - .csi
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
