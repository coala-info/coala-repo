cwlVersion: v1.2
class: CommandLineTool
baseCommand: TransDecoder.Predict
label: transdecoder_TransDecoder.Predict
doc: "The provided text does not contain help information for TransDecoder.Predict;
  it contains error logs related to a container runtime failure (no space left on
  device).\n\nTool homepage: https://transdecoder.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
stdout: transdecoder_TransDecoder.Predict.out
