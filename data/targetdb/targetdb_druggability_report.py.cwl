cwlVersion: v1.2
class: CommandLineTool
baseCommand: targetdb_druggability_report.py
label: targetdb_druggability_report.py
doc: "A tool to generate druggability reports for TargetDB. Note: The provided text
  appears to be a container execution error log rather than help text, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/sdecesco/targetDB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/targetdb:1.3.3--pyhdfd78af_0
stdout: targetdb_druggability_report.py.out
