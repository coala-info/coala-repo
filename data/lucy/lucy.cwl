cwlVersion: v1.2
class: CommandLineTool
baseCommand: lucy
label: lucy
doc: "A tool for DNA sequence quality trimming and vector removal.\n\nTool homepage:
  https://github.com/DecartAI/Lucy-Edit-ComfyUI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lucy:v1.20-1-deb_cv1
stdout: lucy.out
