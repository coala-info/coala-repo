cwlVersion: v1.2
class: CommandLineTool
baseCommand: migraine
label: migraine
doc: "The provided text does not contain help information for the tool 'migraine'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the image due to lack of disk space.\n\nTool homepage: http://kimura.univ-montp2.fr/~rousset/Migraine.htm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/migraine:0.6.0--h9948957_4
stdout: migraine.out
