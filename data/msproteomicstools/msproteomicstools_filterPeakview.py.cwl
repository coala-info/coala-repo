cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - filterPeakview.py
label: msproteomicstools_filterPeakview.py
doc: "Filter Peakview csv libraries: remove transitions below 350 m/z or within 10 Da of the precursor, keep the top 6, normalize intensities to 10000 and map modifications.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_library
    type: File
    doc: "Peakview library (csv)"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output library"
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: "Filtered library"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_filterPeakview.py.out
