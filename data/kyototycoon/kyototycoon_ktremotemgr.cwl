cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktremotemgr
label: kyototycoon_ktremotemgr
doc: "The provided text does not contain help information for ktremotemgr; it contains
  error messages from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/alticelabs/kyoto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kyototycoon:20170410--hbed32c3_5
stdout: kyototycoon_ktremotemgr.out
