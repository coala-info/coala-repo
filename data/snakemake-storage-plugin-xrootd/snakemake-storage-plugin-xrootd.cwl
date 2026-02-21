cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-storage-plugin-xrootd
label: snakemake-storage-plugin-xrootd
doc: "Snakemake storage plugin for XRootD (Note: The provided text appears to be a
  container execution error log rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/snakemake/snakemake-storage-plugin-xrootd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-storage-plugin-xrootd:0.4.1--pyhdfd78af_0
stdout: snakemake-storage-plugin-xrootd.out
