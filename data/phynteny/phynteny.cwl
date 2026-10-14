cwlVersion: v1.2
class: CommandLineTool
baseCommand: phynteny
label: phynteny
doc: "Phynteny: synteny-based annotation of phage genes\n\nTool homepage:
  https://github.com/susiegriggo/Phynteny"
inputs:
  - id: infile
    type: File
    doc: Input GenBank file with PHROG annotations
    inputBinding:
      position: 2
  - id: out
    type:
      - 'null'
      - string
    default: phynteny_out
    doc: output directory
    inputBinding:
      position: 1
      prefix: --out
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory
    inputBinding:
      position: 1
      prefix: --force
  - id: models
    type:
      - 'null'
      - Directory
    doc: Path to directory containing phynteny models
    inputBinding:
      position: 1
      prefix: --models
  - id: confidence_path
    type:
      - 'null'
      - File
    doc: Dictionary of kernel density estimators to use for predicting
      confidence
    inputBinding:
      position: 1
      prefix: --confidence_path
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with annotated GenBank file and prediction table
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phynteny:0.1.13--pyh7cba7a3_0
stdout: phynteny.out
