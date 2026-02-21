cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitofinder
label: mitofinder
doc: "MitoFinder is a pipeline to assemble and annotate mitochondrial genomes from
  NGS data.\n\nTool homepage: https://github.com/parklab/xTea"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitofinder:1.4.1--py27h9801fc8_1
stdout: mitofinder.out
