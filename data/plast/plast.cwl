cwlVersion: v1.2
class: CommandLineTool
baseCommand: plast
label: plast
doc: "Parallel Local Alignment Search Tool (PLAST) is a high-performance sequence
  comparison tool. (Note: The provided text is an error log and does not contain CLI
  help information; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/nkallen/plasticity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plast:v2.3.1dfsg-4-deb_cv1
stdout: plast.out
