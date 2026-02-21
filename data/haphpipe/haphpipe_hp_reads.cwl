cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe_hp_reads
label: haphpipe_hp_reads
doc: "The provided text does not contain help information for the tool, but rather
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_hp_reads.out
