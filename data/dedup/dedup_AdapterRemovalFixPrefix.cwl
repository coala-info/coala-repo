cwlVersion: v1.2
class: CommandLineTool
baseCommand: dedup_AdapterRemovalFixPrefix
label: dedup_AdapterRemovalFixPrefix
doc: "A tool for deduplicating sequencing reads, often used in paleogenomics pipelines.
  Note: The provided help text contains only system error messages and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/apeltzer/dedup"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dedup:0.12.9--hdfd78af_0
stdout: dedup_AdapterRemovalFixPrefix.out
