cwlVersion: v1.2
class: CommandLineTool
baseCommand: aeon
label: aeon
doc: "The provided text does not contain help information for the tool 'aeon'. It
  appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/sybila/biodivine-aeon-py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aeon:0.1.1--py39hb377b6a_2
stdout: aeon.out
