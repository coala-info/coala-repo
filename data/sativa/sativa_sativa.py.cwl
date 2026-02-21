cwlVersion: v1.2
class: CommandLineTool
baseCommand: sativa_sativa.py
label: sativa_sativa.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a fatal error log from a container build process (Singularity/Apptainer) attempting
  to fetch the Sativa image.\n\nTool homepage: https://github.com/amkozlov/sativa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sativa:0.9.3--py312h031d066_0
stdout: sativa_sativa.py.out
