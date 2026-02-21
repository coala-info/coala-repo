cwlVersion: v1.2
class: CommandLineTool
baseCommand: gs-tama_tama_remove_single_read_models_levels.py
label: gs-tama_tama_remove_single_read_models_levels.py
doc: "A tool to remove single-read models from TAMA (Transcriptome Annotation by Modular
  Algorithms) results. Note: The provided help text contains only container runtime
  error messages and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/sguizard/gs-tama"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_remove_single_read_models_levels.py.out
