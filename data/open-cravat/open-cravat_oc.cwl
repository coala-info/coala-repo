cwlVersion: v1.2
class: CommandLineTool
baseCommand: oc
label: open-cravat_oc
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to build a Singularity/Apptainer container
  due to insufficient disk space.\n\nTool homepage: http://www.opencravat.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/open-cravat:2.16.0--pyhdfd78af_0
stdout: open-cravat_oc.out
