cwlVersion: v1.2
class: CommandLineTool
baseCommand: binning_refiner
label: binning_refiner
doc: "Binning_refiner is a tool for refining metagenomic binning results. (Note: The
  provided help text contains only system error logs and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/songweizhi/Binning_refiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binning_refiner:1.4.3
stdout: binning_refiner.out
