cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dfpl
  - convert
label: deepfplearn_convert
doc: "Convert known data files to pickle serialization files.\n\nTool homepage: https://github.com/yigbt/deepFPlearn"
inputs:
  - id: input_dir
    type: Directory
    doc: Input directory where your CSV/TSV files are stored.
    inputBinding:
      position: 1
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: converted_dir
    type: Directory
    doc: Input directory with the pickle (.pkl) files and convert.log added
    outputBinding:
      glob: $(inputs.input_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
stdout: deepfplearn_convert.out
