cwlVersion: v1.2
class: CommandLineTool
baseCommand: trim-low-abund.py
label: khmer-common_trim-low-abund.py
doc: "The provided text does not contain help information. It is an error log indicating
  a failure to create a Singularity/Apptainer container due to insufficient disk space
  ('no space left on device').\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/khmer-common:v2.1.2dfsg-6-deb_cv1
stdout: khmer-common_trim-low-abund.py.out
