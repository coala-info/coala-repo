cwlVersion: v1.2
class: CommandLineTool
baseCommand: interleafq
label: interleafq
doc: "Interleave paired-end FASTQ files. (Note: The provided help text contains only
  system error messages regarding container execution and does not list specific tool
  arguments.)\n\nTool homepage: https://github.com/quadram-institute-bioscience/interleafq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/interleafq:1.1.0--pl5321hdfd78af_2
stdout: interleafq.out
