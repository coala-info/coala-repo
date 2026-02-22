cwlVersion: v1.2
class: CommandLineTool
baseCommand: consent
label: consent
doc: "The provided text does not contain help information for the tool 'consent'.
  It contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull or build the image due to insufficient disk space.\n\nTool homepage:
  https://github.com/morispi/CONSENT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consent:2.2.2--h3452944_6
stdout: consent.out
