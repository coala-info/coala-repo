cwlVersion: v1.2
class: CommandLineTool
baseCommand: splash_build_lookup_table.py
label: splash_build_lookup_table.py
doc: "A tool to build lookup tables for SPLASH (Symmetric Pattern Language Analysis
  of Shotgun sequencing). Note: The provided text contains execution logs and error
  messages rather than help documentation, so no arguments could be extracted.\n\n
  Tool homepage: https://github.com/refresh-bio/splash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splash:2.11.0--py313h9ee0642_0
stdout: splash_build_lookup_table.py.out
