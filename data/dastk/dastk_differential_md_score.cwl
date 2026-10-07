cwlVersion: v1.2
class: CommandLineTool
baseCommand: differential_md_score
label: dastk_differential_md_score
doc: "This script produces an MA plot of TFs from ATAC-Seq data, for DMSO vs. treatment
  conditions.\n\nTool homepage: https://github.com/Dowell-Lab/DAStk"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.output_dir, listing: []})"
        writable: true
inputs:
  - id: p_value
    type:
      - 'null'
      - float
    doc: p-value cutoff to define which motifs to label in the MA plot. Defaults
      to 0.00001.
    inputBinding:
      position: 101
      prefix: --p-value
  - id: assay_1
    type: File
    doc: Control file generated from process_atac ending in the extension 
      "md_scores.txt" (e.g. "DMSO", "control", "wildtype").
    inputBinding:
      position: 101
      prefix: --assay-1
  - id: assay_2
    type: File
    doc: Perturbation file generated from process_atac ending in the extension 
      "md_scores.txt" (e.g., "doxycyclin", "p53_knockout").
    inputBinding:
      position: 101
      prefix: --assay-2
  - id: label_1
    type:
      - 'null'
      - string
    doc: Label for the MA plot title corresponding to assay 1
    inputBinding:
      position: 101
      prefix: --label-1
  - id: label_2
    type:
      - 'null'
      - string
    doc: Label for the MA plot title corresponding to assay 2
    inputBinding:
      position: 101
      prefix: --label-2
  - id: window
    type:
      - 'null'
      - string
    doc: Label for the MA plot title corresponding to window size (str). Default
      = '3kb'
    inputBinding:
      position: 101
      prefix: --window
  - id: barcodes
    type:
      - 'null'
      - boolean
    doc: Generate a barcode plot for each significant motif
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: output_dir
    type: string
    doc: Path to where output files will be saved (created by the wrapper).
    inputBinding:
      position: 101
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for multi-processing. Defaults to 1.
    inputBinding:
      position: 101
      prefix: --threads
  - id: chip
    type:
      - 'null'
      - boolean
    doc: If the input is ChIP data, it may be useful to specify this flag as it 
      will change the variance calulation because a large difference in sites 
      between control and treatment will be expected.
    inputBinding:
      position: 101
      prefix: --chip
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Folder with <assay_1>_vs_<assay_2>_differential_md_scores.txt, the MA 
      plot and (with --barcodes) barcode plots
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk_differential_md_score.out
