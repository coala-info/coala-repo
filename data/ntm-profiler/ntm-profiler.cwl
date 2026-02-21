cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntm-profiler
label: ntm-profiler
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs regarding a container execution failure (no
  space left on device).\n\nTool homepage: https://github.com/jodyphelan/NTM-Profiler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntm-profiler:0.8.0--pyhdfd78af_0
stdout: ntm-profiler.out
