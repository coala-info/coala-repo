cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacedust
  - foldseek
label: spacedust_foldseek
doc: "Spacedust foldseek (Note: The provided text contains container build logs and
  error messages rather than command-line help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/soedinglab/spacedust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0
stdout: spacedust_foldseek.out
