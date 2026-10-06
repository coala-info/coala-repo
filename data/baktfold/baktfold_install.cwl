cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - baktfold
  - install
label: baktfold_install
doc: "Installs ProstT5 model and baktfold database\n\nTool homepage: https://github.com/gbouras13/baktfold"
inputs:
  - id: database
    type: string
    default: baktfold_db
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
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database_dir
    type: Directory
    doc: Installed baktfold database and ProstT5 model
    outputBinding:
      glob: $(inputs.database)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
stdout: baktfold_install.out
