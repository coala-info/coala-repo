cwlVersion: v1.2
class: CommandLineTool
baseCommand: selene_sdk
label: selene-sdk_selene_sdk
doc: "Build the model and train it using user-specified input data. Selene runs the
  operations (train, evaluate, analyze sequences) set in a YAML configuration file.\n\nTool
  homepage: https://github.com/FunctionLab/selene"
inputs:
  - id: config_file
    type: File
    doc: Path to the YAML configuration file
    inputBinding:
      position: 1
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the configuration file (model Python file, .mat, FASTA,
      BED, weights ...), staged into the working directory so that relative
      paths such as ./train.mat resolve
  - id: lr
    type:
      - 'null'
      - float
    doc: If training, the optimizer learning rate
    inputBinding:
      position: 102
      prefix: --lr
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directories
    type:
      type: array
      items: Directory
    doc: Directories created in the working directory (the output_dir set in the
      configuration file)
    outputBinding:
      glob: '*'
      outputEval: "$(self.filter(function(f) { return f.class == 'Directory'; }))"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.support_files ? inputs.support_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selene-sdk:0.6.0--py312h0fa9677_2
stdout: selene-sdk_selene_sdk.out
