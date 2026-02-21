cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-storage-plugin-http_snakemake
doc: "Snakemake storage plugin for HTTP support. (Note: The provided text appears
  to be an execution log/error message rather than a help menu; no arguments could
  be extracted from the input.)\n\nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-http"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-http:0.3.0--pyhdfd78af_0
stdout: snakemake-storage-plugin-http_snakemake.out
