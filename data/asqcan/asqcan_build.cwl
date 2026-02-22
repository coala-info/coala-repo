cwlVersion: v1.2
class: CommandLineTool
baseCommand: asqcan_build
label: asqcan_build
doc: "A tool to build or fetch the asqcan OCI image and convert it to SIF format.
  Note: The provided text appears to be a log of a failed Singularity/Apptainer build
  process rather than standard help text.\n\nTool homepage: https://github.com/bogemad/asqcan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/asqcan:0.4--pyh7cba7a3_0
stdout: asqcan_build.out
