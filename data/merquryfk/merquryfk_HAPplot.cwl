cwlVersion: v1.2
class: CommandLineTool
baseCommand: merquryfk_HAPplot
label: merquryfk_HAPplot
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages regarding disk space and environment variables.\n
  \nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
stdout: merquryfk_HAPplot.out
