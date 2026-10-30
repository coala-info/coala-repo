cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - convertFromPeakview.py
label: msproteomicstools_convertFromPeakview.py
doc: "Convert a Peakview library (tab-delimited) to the OpenSWATH format.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: peakview_library
    type: File
    doc: "Peakview library file"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output OpenSWATH library file"
    inputBinding:
      position: 2
outputs:
  - id: openswath_library
    type: File
    doc: "OpenSWATH library"
    outputBinding:
      glob: "$(inputs.output_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
