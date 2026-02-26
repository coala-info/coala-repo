cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap
label: metawrap-assembly_metawrap
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
    dockerPull: quay.io/biocontainers/metawrap-assembly:1.3.0--hdfd78af_3
stdout: metawrap-assembly_metawrap.out
