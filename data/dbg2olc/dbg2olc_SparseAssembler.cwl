cwlVersion: v1.2
class: CommandLineTool
baseCommand: SparseAssembler
label: dbg2olc_SparseAssembler
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/yechengxi/DBG2OLC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
stdout: dbg2olc_SparseAssembler.out
