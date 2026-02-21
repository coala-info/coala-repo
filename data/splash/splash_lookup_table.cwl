cwlVersion: v1.2
class: CommandLineTool
baseCommand: splash_lookup_table
label: splash_lookup_table
doc: "The provided text does not contain help information for splash_lookup_table;
  it is a log of a failed container build process.\n\nTool homepage: https://github.com/refresh-bio/splash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splash:2.11.0--py313h9ee0642_0
stdout: splash_lookup_table.out
