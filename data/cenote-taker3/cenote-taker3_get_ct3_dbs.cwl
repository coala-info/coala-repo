cwlVersion: v1.2
class: CommandLineTool
baseCommand: cenote-taker3_get_ct3_dbs
label: cenote-taker3_get_ct3_dbs
doc: "A tool to download and set up databases for Cenote-Taker3. Note: The provided
  help text contains only system logs and error messages regarding a failed container
  build/extraction due to insufficient disk space.\n\nTool homepage: https://github.com/mtisza1/Cenote-Taker3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cenote-taker3:3.4.3--pyhdfd78af_0
stdout: cenote-taker3_get_ct3_dbs.out
