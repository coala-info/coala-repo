cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-http
label: snakemake-storage-plugin-http
doc: "A Snakemake storage plugin that allows for interacting with files over HTTP.\n
  \nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-http"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-http:0.3.0--pyhdfd78af_0
stdout: snakemake-storage-plugin-http.out
