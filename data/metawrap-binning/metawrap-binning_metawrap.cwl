cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap
label: metawrap-binning_metawrap
doc: "Please select a proper module of metaWRAP.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: module
    type: string
    doc: The metaWRAP module to run (e.g., read_qc, assembly, kraken, blobology,
      binning, bin_refinement, reassemble_bins, quant_bins, classify_bins, 
      annotate_bins)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-binning:1.3.0
stdout: metawrap-binning_metawrap.out
