cwlVersion: v1.2
class: CommandLineTool
baseCommand: gvcf_regions.py
label: gvcf-regions_gvcf_regions.py
doc: "A tool for processing gVCF regions (Note: The provided help text contains only
  system error messages regarding container execution and does not list specific arguments).\n
  \nTool homepage: https://github.com/lijiayong/gvcf_regions"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gvcf-regions:2016.06.23--py35_0
stdout: gvcf-regions_gvcf_regions.py.out
