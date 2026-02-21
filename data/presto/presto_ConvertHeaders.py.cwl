cwlVersion: v1.2
class: CommandLineTool
baseCommand: presto_ConvertHeaders.py
label: presto_ConvertHeaders.py
doc: "The provided text does not contain help information or usage instructions for
  presto_ConvertHeaders.py. It appears to be a container runtime error log (Singularity/Apptainer)
  indicating a failure to fetch or build the image.\n\nTool homepage: http://presto.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/presto:0.7.8--pyhdfd78af_0
stdout: presto_ConvertHeaders.py.out
