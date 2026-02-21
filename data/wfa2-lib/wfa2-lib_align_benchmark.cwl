cwlVersion: v1.2
class: CommandLineTool
baseCommand: align_benchmark
label: wfa2-lib_align_benchmark
doc: "WFA2-lib alignment benchmark tool. (Note: The provided help text contains container
  execution errors and does not list command-line arguments.)\n\nTool homepage: https://github.com/smarco/WFA2-lib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wfa2-lib:2.3.5--h9948957_3
stdout: wfa2-lib_align_benchmark.out
