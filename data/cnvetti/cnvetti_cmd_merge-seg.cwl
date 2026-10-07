cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - cmd
  - merge-seg
label: cnvetti_cmd_merge-seg
doc: "Merge segmentation result files. This command takes one or more segment BCF files with segmentation results, merges the segments based on reciprocal overlap and then writes out a BCF file that contains the segments as site list (only).\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    secondaryFiles:
      - .csi
    doc: "Path to indexed input BCF or VCF segment file from `cnvetti cmd segment` output."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Path to BCF file with merged segments (will also write .csi file)"
    inputBinding:
      position: 101
      prefix: --output
  - id: reciprocal_overlap
    type:
      - 'null'
      - float
    doc: "Reciprocal overlap to require for merging segments (default 0.8)"
    inputBinding:
      position: 101
      prefix: --reciprocal-overlap
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
    doc: "Path to BCF file with merged segments (will also write .csi file)"
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - .csi
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
