cwlVersion: v1.2
class: CommandLineTool
baseCommand: psortb
label: psortb
doc: "PSORTb is a tool for protein subcellular localization prediction. (Note: The
  provided text contains container runtime errors and does not include the tool's
  help documentation; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/psortb:v3.0.6dfsg-1b1-deb_cv1
stdout: psortb.out
