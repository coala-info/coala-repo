cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_quality_filter
label: fasten_fasten_quality_filter
doc: "A tool from the fasten suite to filter FASTQ reads based on quality scores.
  (Note: The provided help text contains system error messages and does not list specific
  arguments.)\n\nTool homepage: https://github.com/lskatz/fasten"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_quality_filter.out
