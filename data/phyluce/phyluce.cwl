cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce
label: phyluce
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to pull or build a Singularity container
  due to insufficient disk space.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce.out
