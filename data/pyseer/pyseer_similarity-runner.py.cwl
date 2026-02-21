cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyseer_similarity-runner.py
label: pyseer_similarity-runner.py
doc: "The provided text does not contain help information for pyseer_similarity-runner.py.
  It appears to be a log of a failed container build/fetch operation using Singularity/Apptainer.\n
  \nTool homepage: https://github.com/mgalardini/pyseer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
stdout: pyseer_similarity-runner.py.out
