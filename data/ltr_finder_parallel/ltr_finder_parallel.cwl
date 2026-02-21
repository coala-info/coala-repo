cwlVersion: v1.2
class: CommandLineTool
baseCommand: ltr_finder_parallel
label: ltr_finder_parallel
doc: "A tool for parallel execution of LTR_Finder. (Note: The provided help text contains
  only system error messages and no usage information.)\n\nTool homepage: https://github.com/oushujun/LTR_FINDER_parallel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ltr_harvest_parallel:1.2--hdfd78af_2
stdout: ltr_finder_parallel.out
