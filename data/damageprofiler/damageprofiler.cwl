cwlVersion: v1.2
class: CommandLineTool
baseCommand: damageprofiler
label: damageprofiler
doc: "DamageProfiler is a tool for determining damage patterns in ancient DNA. (Note:
  The provided help text contains only container build error logs and does not list
  specific CLI arguments.)\n\nTool homepage: https://github.com/Integrative-Transcriptomics/dedup"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damageprofiler:1.1--hdfd78af_2
stdout: damageprofiler.out
