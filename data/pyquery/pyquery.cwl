cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyquery
label: pyquery
doc: "The provided text does not contain help information for the tool 'pyquery'.
  It appears to be a log from a failed container build process (Singularity/Apptainer)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/gawel/pyquery"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyquery:1.2.9--py27_0
stdout: pyquery.out
