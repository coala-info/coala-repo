cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiver_shiver_align_contigs.sh
label: shiver_shiver_align_contigs.sh
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/ChrisHIV/shiver"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiver:1.7.3--hdfd78af_0
stdout: shiver_shiver_align_contigs.sh.out
