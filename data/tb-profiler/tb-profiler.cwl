cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb-profiler
label: tb-profiler
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build/fetch process. As a result, no arguments or
  tool descriptions could be extracted from the input.\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler.out
