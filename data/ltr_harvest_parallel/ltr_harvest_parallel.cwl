cwlVersion: v1.2
class: CommandLineTool
baseCommand: ltr_harvest_parallel
label: ltr_harvest_parallel
doc: "A tool for parallel execution of LTRharvest (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/oushujun/EDTA/tree/8980f498f05ad63dbffa3241842d3d38e939531b/bin/LTR_HARVEST_parallel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ltr_harvest_parallel:1.2--hdfd78af_2
stdout: ltr_harvest_parallel.out
