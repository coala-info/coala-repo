cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgat-pipelines-nosetests
label: cgat-pipelines-nosetests
doc: "A tool for running nosetests within the CGAT pipelines environment. Note: The
  provided input text contains system error logs rather than command-line help documentation.\n
  \nTool homepage: https://www.cgat.org/downloads/public/cgatpipelines/documentation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgat-pipelines-nosetests:0.0.4--py27r3.4.1_0
stdout: cgat-pipelines-nosetests.out
