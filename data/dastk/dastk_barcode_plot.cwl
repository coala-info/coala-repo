cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barcode_plot
label: dastk_barcode_plot
doc: "This script generates barcodes using the output from DAStk.\n\nTool homepage:
  https://github.com/Dowell-Lab/DAStk"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.output_dir, listing: []})"
        writable: true
inputs:
  - id: scores_1
    type: File
    doc: First MD score file generated from DAStk.
    inputBinding:
      position: 101
      prefix: --scores-1
  - id: scores_2
    type:
      - 'null'
      - File
    doc: Second MD score file generated from DAStk. Not required if argument
      '-s/--single' is specified.
    inputBinding:
      position: 101
      prefix: --scores-2
  - id: assay_1
    type: string
    doc: Assay name of first MD score file.
    inputBinding:
      position: 101
      prefix: --assay-1
  - id: assay_2
    type:
      - 'null'
      - string
    doc: Assay name of second MD score file. Will be title of barcode plot. Not
      required if argument '-s/--single' is specified.
    inputBinding:
      position: 101
      prefix: --assay-2
  - id: transcription_factor
    type: string
    doc: Transcription factor you would like to plot. Should be full prefix
      before the .bed extension printed in the MD score output (e.g.
      JUND_HUMAN.H11MO.0.A).
    inputBinding:
      position: 101
      prefix: --transcription-factor
  - id: output_dir
    type: string
    doc: Folder where the plot will be saved (created by the wrapper).
    inputBinding:
      position: 101
      prefix: --output
  - id: global_normalization
    type:
      - 'null'
      - boolean
    doc: When specified, output barcodes will be normalized according to total
      number of motif hits throughout the genome (i.e. total significantly
      called regions from FIMO scan).
    inputBinding:
      position: 101
      prefix: --global-normalization
  - id: single
    type:
      - 'null'
      - boolean
    doc: Generate a single barcode rather than a side-by-side comparison.
    inputBinding:
      position: 101
      prefix: --single
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: barcode_plot
    type: File
    doc: Barcode plot (<tf>_<assay_1>_vs_<assay_2>.png, or <tf>_<assay_1>.png
      with --single)
    outputBinding:
      glob: $(inputs.output_dir)/$(inputs.transcription_factor)_*.png
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk_barcode_plot.out
