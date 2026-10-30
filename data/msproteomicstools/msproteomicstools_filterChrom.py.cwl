cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - filterChrom.py
label: msproteomicstools_filterChrom.py
doc: "Filter a chromatogram mzML file by native id (regular expression); with the inverse option the matching chromatograms are removed.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: infile
    type: File
    doc: "Input chromatogram mzML file"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output mzML file"
    inputBinding:
      position: 2
  - id: chrom_id
    type: string
    doc: "Native id of the chromatograms to keep (can be a regular expression)"
    inputBinding:
      position: 3
  - id: inverse
    type: ['null', boolean]
    doc: "Inverse matching: keep the chromatograms that do not match"
    inputBinding:
      position: 4
      valueFrom: "$(self ? \"True\" : null)"
outputs:
  - id: output
    type: File
    doc: "Filtered mzML file"
    outputBinding:
      glob: "$(inputs.output_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
