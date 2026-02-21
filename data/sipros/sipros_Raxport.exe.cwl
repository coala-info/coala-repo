cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_Raxport.exe
label: sipros_Raxport.exe
doc: "The provided text does not contain help information or a description for the
  tool; it contains container runtime (Apptainer/Singularity) error logs.\n\nTool
  homepage: https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_Raxport.exe.out
