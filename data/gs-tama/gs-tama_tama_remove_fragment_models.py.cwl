cwlVersion: v1.2
class: CommandLineTool
baseCommand: gs-tama_tama_remove_fragment_models.py
label: gs-tama_tama_remove_fragment_models.py
doc: "A tool from the TAMA (Transcriptome Annotation by Modular Assembly) suite, likely
  used for removing fragment models from transcript datasets.\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_remove_fragment_models.py.out
