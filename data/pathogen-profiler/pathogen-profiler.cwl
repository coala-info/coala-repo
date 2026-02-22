cwlVersion: v1.2
class: CommandLineTool
baseCommand: pathogen-profiler
label: pathogen-profiler
doc: "A tool for pathogen profiling. (Note: The provided input text contains system
  error messages regarding disk space and container conversion rather than the tool's
  help documentation.)\n\nTool homepage: https://github.com/jodyphelan/pathogen-profiler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathogen-profiler:5.1.0--pyh7e72e81_0
stdout: pathogen-profiler.out
