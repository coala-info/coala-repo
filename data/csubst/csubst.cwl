cwlVersion: v1.2
class: CommandLineTool
baseCommand: csubst
label: csubst
doc: "The provided text does not contain help information for the tool 'csubst'. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract the OCI image due to insufficient disk
  space ('no space left on device').\n\nTool homepage: https://github.com/kfuku52/csubst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/csubst:1.4.20--py310ha6711e0_1
stdout: csubst.out
