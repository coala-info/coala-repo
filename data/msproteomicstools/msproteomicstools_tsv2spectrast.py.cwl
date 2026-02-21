cwlVersion: v1.2
class: CommandLineTool
baseCommand: msproteomicstools_tsv2spectrast.py
label: msproteomicstools_tsv2spectrast.py
doc: "A tool for converting TSV files to SpectraST format. (Note: The provided help
  text contains system error messages regarding container execution and does not list
  specific command-line arguments.)\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h8b767f7_4
stdout: msproteomicstools_tsv2spectrast.py.out
