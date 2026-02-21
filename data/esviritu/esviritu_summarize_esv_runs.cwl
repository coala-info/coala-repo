cwlVersion: v1.2
class: CommandLineTool
baseCommand: esviritu_summarize_esv_runs
label: esviritu_summarize_esv_runs
doc: "Summarize ESV runs (Note: The provided help text contains only system error
  messages and no usage information).\n\nTool homepage: https://github.com/cmmr/EsViritu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esviritu:1.1.6--pyhdfd78af_0
stdout: esviritu_summarize_esv_runs.out
