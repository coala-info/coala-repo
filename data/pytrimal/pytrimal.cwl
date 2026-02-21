cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytrimal
label: pytrimal
doc: "The provided text does not contain help information for the tool, but appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) while attempting
  to fetch the pytrimal image.\n\nTool homepage: https://github.com/althonos/pytrimal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytrimal:0.8.5--py39h2de1943_0
stdout: pytrimal.out
