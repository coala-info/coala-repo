cwlVersion: v1.2
class: CommandLineTool
baseCommand: cagecleaner
label: cagecleaner
doc: "A tool for cleaning CAGE-seq data (Note: The provided help text contains only
  system logs and build errors; no arguments could be extracted from the source text).\n
  \nTool homepage: https://github.com/LucoDevro/CAGEcleaner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cagecleaner:1.4.5--pyhdfd78af_0
stdout: cagecleaner.out
