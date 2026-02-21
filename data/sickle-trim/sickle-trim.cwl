cwlVersion: v1.2
class: CommandLineTool
baseCommand: sickle-trim
label: sickle-trim
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the tool image.\n\nTool homepage: https://github.com/ritah-nabunje/sickle_trim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sickle-trim:1.33--h7132678_7
stdout: sickle-trim.out
