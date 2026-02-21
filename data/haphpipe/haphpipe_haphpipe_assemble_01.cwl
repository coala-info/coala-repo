cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haphpipe
  - assemble_01
label: haphpipe_haphpipe_assemble_01
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Singularity/Apptainer) failing to
  build an image due to insufficient disk space.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_haphpipe_assemble_01.out
