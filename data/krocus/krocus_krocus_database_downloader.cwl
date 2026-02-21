cwlVersion: v1.2
class: CommandLineTool
baseCommand: krocus_database_downloader
label: krocus_krocus_database_downloader
doc: "A tool to download databases for Krocus (MLST tool). Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/andrewjpage/krocus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krocus:1.0.3--pyhdfd78af_0
stdout: krocus_krocus_database_downloader.out
