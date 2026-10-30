cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - preprocess_peakview.py
label: msproteomicstools_preprocess_peakview.py
doc: "Add a preprocess_id column (row number) to a Peakview file.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_file
    type: File
    doc: "Peakview file"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output file"
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: "Output file with preprocess_id column"
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
stdout: msproteomicstools_preprocess_peakview.py.out
