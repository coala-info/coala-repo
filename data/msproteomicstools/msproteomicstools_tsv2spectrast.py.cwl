cwlVersion: v1.2
class: CommandLineTool
baseCommand: msproteomicstools_tsv2spectrast.py
label: msproteomicstools_tsv2spectrast.py
doc: "Converts TSV files to Spectrast format.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_tsv
    type: File
    doc: Input TSV file
    inputBinding:
      position: 1
outputs:
  - id: output_spectrast
    type: File
    doc: Output Spectrast file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
