cwlVersion: v1.2
class: CommandLineTool
baseCommand: hamronize
label: hamronization_hamronize interactive
doc: "hamronize: error: argument analysis_tool: invalid choice: 'interactive' (choose
  from abricate, amrfinderplus, amrplusplus, ariba, csstar, deeparg, fargene, groot,
  kmerresistance, resfams, resfinder, mykrobe, rgi, srax, srst2, staramr, tbprofiler,
  summarize)\n\nTool homepage: https://github.com/pha4ge/hAMRonization"
inputs:
  - id: tool
    type: string
    doc: The analysis tool to use
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the selected tool
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
stdout: hamronization_hamronize interactive.out
