cwlVersion: v1.2
class: CommandLineTool
baseCommand: integron-finder
label: integron-finder
doc: "Integron Finder is a tool to detect integrons in bacterial genomes. (Note: The
  provided text contains container runtime error logs rather than CLI help documentation,
  so no arguments could be extracted).\n\nTool homepage: https://github.com/movingpictures83/IntegronFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/integron-finder:v1.5.1_cv2
stdout: integron-finder.out
