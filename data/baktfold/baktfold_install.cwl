cwlVersion: v1.2
class: CommandLineTool
baseCommand: baktfold install
label: baktfold_install
doc: "Installs ProstT5 model and baktfold database\n\nTool homepage: https://github.com/gbouras13/baktfold"
inputs:
  - id: database
    type:
      - 'null'
      - Directory
    doc: Specific path to install the baktfold database
    inputBinding:
      position: 101
      prefix: --database
  - id: foldseek_gpu
    type:
      - 'null'
      - boolean
    doc: Use this to enable compatibility with Foldseek-GPU acceleration
    inputBinding:
      position: 101
      prefix: --foldseek-gpu
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
stdout: baktfold_install.out
