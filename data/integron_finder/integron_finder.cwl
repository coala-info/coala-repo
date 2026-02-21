cwlVersion: v1.2
class: CommandLineTool
baseCommand: integron_finder
label: integron_finder
doc: "IntegronFinder is a tool to detect integrons in DNA sequences.\n\nTool homepage:
  https://github.com/gem-pasteur/Integron_Finder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/integron-finder:v1.5.1_cv2
stdout: integron_finder.out
