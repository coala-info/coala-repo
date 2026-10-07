cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - visualize
  - cov-to-igv
label: cnvetti_visualize_cov-to-igv
doc: "Build `.igv` visualization tracks from coverage BCF files. These files can then be converted into TDF format using `igvtools totdf FILE GENOME`.\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - .csi
    doc: "Path to indexed input BCF file."
    inputBinding:
      position: 1
  - id: output_igv_cov
    type: string
    doc: "Path to IGV coverage file writing out the raw coverage signal."
    inputBinding:
      position: 101
      prefix: --output-igv-cov
  - id: output_igv_cov2
    type: string
    doc: "Path to IGV coverage file writing out the log2-transformed coverage signal."
    inputBinding:
      position: 101
      prefix: --output-igv-cov2
  - id: output_igv_covz
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write coverage Z-score to."
    inputBinding:
      position: 101
      prefix: --output-igv-covz
  - id: output_igv_scov
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write (linear relative) smoothed coverage to."
    inputBinding:
      position: 101
      prefix: --output-igv-scov
  - id: output_igv_scov2
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write log2-scaled smoothed coverage to."
    inputBinding:
      position: 101
      prefix: --output-igv-scov2
  - id: output_igv_seg
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write (linear relative) segmented coverage to."
    inputBinding:
      position: 101
      prefix: --output-igv-seg
  - id: output_igv_seg2
    type:
      - 'null'
      - string
    doc: "Optional path to IGV file to write log2-scaled segmented coverage to."
    inputBinding:
      position: 101
      prefix: --output-igv-seg2
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
  - id: output_igv_cov_file
    type:
      - 'null'
      - File
    doc: "Path to IGV coverage file writing out the raw coverage signal."
    outputBinding:
      glob: $(inputs.output_igv_cov)
  - id: output_igv_cov2_file
    type:
      - 'null'
      - File
    doc: "Path to IGV coverage file writing out the log2-transformed coverage signal."
    outputBinding:
      glob: $(inputs.output_igv_cov2)
  - id: output_igv_covz_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write coverage Z-score to."
    outputBinding:
      glob: $(inputs.output_igv_covz)
  - id: output_igv_scov_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write (linear relative) smoothed coverage to."
    outputBinding:
      glob: $(inputs.output_igv_scov)
  - id: output_igv_scov2_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write log2-scaled smoothed coverage to."
    outputBinding:
      glob: $(inputs.output_igv_scov2)
  - id: output_igv_seg_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write (linear relative) segmented coverage to."
    outputBinding:
      glob: $(inputs.output_igv_seg)
  - id: output_igv_seg2_file
    type:
      - 'null'
      - File
    doc: "Optional path to IGV file to write log2-scaled segmented coverage to."
    outputBinding:
      glob: $(inputs.output_igv_seg2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
