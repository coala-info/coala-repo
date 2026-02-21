cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellprofiler-core
label: cellprofiler-core
doc: "CellProfiler-core is the engine for CellProfiler, a free open-source software
  for measuring and analyzing cell images.\n\nTool homepage: https://github.com/CellProfiler/core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellprofiler-core:4.2.8--pyhdfd78af_0
stdout: cellprofiler-core.out
