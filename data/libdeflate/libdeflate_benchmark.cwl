cwlVersion: v1.2
class: CommandLineTool
baseCommand: libdeflate_benchmark
label: libdeflate_benchmark
doc: "Benchmark program for libdeflate (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/ebiggers/libdeflate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libdeflate:1.2--h14c3975_0
stdout: libdeflate_benchmark.out
