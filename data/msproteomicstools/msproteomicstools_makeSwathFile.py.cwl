cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - makeSwathFile.py
label: msproteomicstools_makeSwathFile.py
doc: "Write three small synthetic SWATH test files (Swath_test_osw.mzML, Swath_test_pwiz.mzML and Swath_test_missing.mzML) to the working directory.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs: []
outputs:
  - id: swath_files
    type: 'File[]'
    doc: "Synthetic SWATH mzML files"
    outputBinding:
      glob: "Swath_test_*.mzML"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_makeSwathFile.py.out
