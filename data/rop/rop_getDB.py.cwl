cwlVersion: v1.2
class: CommandLineTool
baseCommand: rop_getDB.py
label: rop_getDB.py
doc: "The provided text does not contain help information or usage instructions for
  rop_getDB.py. It appears to be a system log showing a fatal error during a Singularity/Apptainer
  container build process.\n\nTool homepage: https://github.com/smangul1/rop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rop:1.1.2--py27h516909a_0
stdout: rop_getDB.py.out
