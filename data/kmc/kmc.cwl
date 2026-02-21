cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc
label: kmc
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the kmc tool.\n\nTool
  homepage: https://github.com/refresh-bio/kmc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4
stdout: kmc.out
