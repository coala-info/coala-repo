cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa-mem2
label: bwa-mem2
doc: "BWA-mem2 is the next version of the bwa-mem algorithm in bwa. It is highly optimized
  for modern CPUs.\n\nTool homepage: https://github.com/bwa-mem2/bwa-mem2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-mem2:2.3--he70b90d_0
stdout: bwa-mem2.out
