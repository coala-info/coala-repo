cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - splitMSE.py
label: msproteomicstools_splitMSE.py
doc: "Split a MassLynx MSE text export into one file per FUNCTION block (files MSE_0.txt, MSE_1.txt, ... under the given output prefix).\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_file
    type: File
    doc: "MSE text file"
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: "Output path prefix; the files are named <prefix>MSE_<n>.txt"
    inputBinding:
      position: 2
outputs:
  - id: output_files
    type: 'File[]'
    doc: "Split text files"
    outputBinding:
      glob: "$(inputs.output_prefix)MSE_*.txt"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_splitMSE.py.out
