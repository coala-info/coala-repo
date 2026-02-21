cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_SiprosEnsembleOMP
label: sipros_SiprosEnsembleOMP
doc: "The provided text does not contain help information for the tool; it is a container
  runtime error log indicating a failure to fetch the OCI image.\n\nTool homepage:
  https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_SiprosEnsembleOMP.out
