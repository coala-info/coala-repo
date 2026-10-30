cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fix_sonar.py
label: msproteomicstools_fix_sonar.py
doc: "Fix SONAR mzML files by adding the precursor isolation window information into the file.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_mzml
    type: File
    doc: "Input SONAR mzML file"
    inputBinding:
      position: 1
  - id: param_file
    type: File
    doc: "Parameter file"
    inputBinding:
      position: 2
  - id: output_path
    type: string
    doc: "Output mzML file"
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: "Fixed mzML file"
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
stdout: msproteomicstools_fix_sonar.py.out
