cwlVersion: v1.2
class: CommandLineTool
baseCommand: hap.py
label: hap.py
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/Illumina/hap.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hap.py:0.3.15--py27hcb73b3d_0
stdout: hap.py.out
