cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-cached-http
label: snakemake-storage-plugin-cached-http
doc: "A Snakemake storage plugin for cached HTTP resources. Note: The provided text
  appears to be a container runtime error log rather than a help menu, so no command-line
  arguments could be extracted.\n\nTool homepage: https://github.com/PyPSA/snakemake-storage-plugin-cached-http"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-cached-http:0.2.1--pyhdfd78af_0
stdout: snakemake-storage-plugin-cached-http.out
