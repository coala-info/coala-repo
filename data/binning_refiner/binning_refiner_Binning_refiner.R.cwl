cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binning_refiner.R
label: binning_refiner_Binning_refiner.R
doc: "A tool for refining metagenomic bins (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/songweizhi/Binning_refiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binning_refiner:1.4.3
stdout: binning_refiner_Binning_refiner.R.out
