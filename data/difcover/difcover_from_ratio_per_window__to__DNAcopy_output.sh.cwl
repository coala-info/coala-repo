cwlVersion: v1.2
class: CommandLineTool
baseCommand: from_ratio_per_window__to__DNAcopy_output.sh
label: difcover_from_ratio_per_window__to__DNAcopy_output.sh
doc: "Converts ratio per window files to DNAcopy output format.\n\nTool homepage:
  https://github.com/timnat/DifCover"
inputs:
  - id: ratio_per_windows_file
    type: File
    doc: Input file containing ratio per windows data (e.g., 
      *.ratio_per_windows)
    inputBinding:
      position: 1
  - id: adj_coef
    type: float
    doc: Adjustment coefficient, recommended to be 
      (modal_cov_sample2/modal_cov_sample1)
    inputBinding:
      position: 2
outputs:
  - id: log2adj
    type: File
    doc: DNAcopy input with adj_coef*log2(ratio) per window (<input>.log2adj_<adj_coef>).
    outputBinding:
      glob: $(inputs.ratio_per_windows_file.basename).log2adj_*[0-9]
  - id: dnacopy_out
    type: File
    doc: DNAcopy segmentation (<input>.log2adj_<adj_coef>.DNAcopyout).
    outputBinding:
      glob: $(inputs.ratio_per_windows_file.basename).log2adj_*.DNAcopyout
  - id: dnacopy_pdf
    type:
      - 'null'
      - File
    doc: DNAcopy plot.
    outputBinding:
      glob: $(inputs.ratio_per_windows_file.basename).log2adj_*.pdf
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.ratio_per_windows_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover_from_ratio_per_window__to__DNAcopy_output.sh.out
