cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phase_by_size
label: plastid_phase_by_size
doc: "The provided text does not contain help information or documentation for the
  tool. It is a log of a failed container build process (Apptainer/Singularity) due
  to insufficient disk space.\n\nTool homepage: http://plastid.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
stdout: plastid_phase_by_size.out
