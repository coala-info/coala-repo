cwlVersion: v1.2
class: CommandLineTool
baseCommand: solote_SoloTE_pipeline.py
label: solote_SoloTE_pipeline.py
doc: "SoloTE pipeline for quantifying transposable element expression from single-cell
  RNA-seq data. (Note: The provided text appears to be a container engine log rather
  than help text; no arguments could be extracted from the input.)\n\nTool homepage:
  https://github.com/bvaldebenitom/SoloTE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solote:1.09--hdfd78af_0
stdout: solote_SoloTE_pipeline.py.out
