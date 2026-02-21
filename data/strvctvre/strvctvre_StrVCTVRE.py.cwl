cwlVersion: v1.2
class: CommandLineTool
baseCommand: StrVCTVRE.py
label: strvctvre_StrVCTVRE.py
doc: "StrVCTVRE (Structural Variant Classifier Trained on Variant Rare Effects) is
  a method to predict the pathogenicity of structural variants.\n\nTool homepage:
  https://github.com/andrewSharo/StrVCTVRE/tree/master"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strvctvre:1.10--pyh7e72e81_0
stdout: strvctvre_StrVCTVRE.py.out
