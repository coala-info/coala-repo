cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellprofiler
label: cellprofiler
doc: "CellProfiler is a free open-source software for measuring and analyzing cell
  images. (Note: The provided text is a container build error log and does not contain
  CLI help information; therefore, no arguments could be extracted).\n\nTool homepage:
  https://github.com/CellProfiler/CellProfiler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellprofiler:4.2.8--pyhdfd78af_0
stdout: cellprofiler.out
