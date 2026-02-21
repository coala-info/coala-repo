cwlVersion: v1.2
class: CommandLineTool
baseCommand: speaq_train_iterative_model.py
label: speaq_train_iterative_model.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains container build logs and a fatal error message.\n\nTool homepage:
  https://github.com/mlvlab/SpeaQ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/speaq:phenomenal-v2.3.1_cv1.0.1.13
stdout: speaq_train_iterative_model.py.out
