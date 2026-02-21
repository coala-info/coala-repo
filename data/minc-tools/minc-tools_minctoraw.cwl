cwlVersion: v1.2
class: CommandLineTool
baseCommand: minctoraw
label: minc-tools_minctoraw
doc: "A tool from the minc-tools suite (description unavailable due to execution error
  in provided text).\n\nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_minctoraw.out
