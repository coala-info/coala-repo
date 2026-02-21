cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyseer_annotate_hits_pyseer-runner.py
label: pyseer_annotate_hits_pyseer-runner.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or execution attempt.\n\nTool homepage:
  https://github.com/mgalardini/pyseer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
stdout: pyseer_annotate_hits_pyseer-runner.py.out
