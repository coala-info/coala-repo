cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-storage-plugin-cached-http_snakemake
doc: "A Snakemake storage plugin for cached HTTP access. Note: The provided text contains
  execution logs and error messages rather than help documentation; therefore, no
  specific command-line arguments could be extracted.\n\nTool homepage: https://github.com/PyPSA/snakemake-storage-plugin-cached-http"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-cached-http:0.2.1--pyhdfd78af_0
stdout: snakemake-storage-plugin-cached-http_snakemake.out
