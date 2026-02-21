cwlVersion: v1.2
class: CommandLineTool
baseCommand: minys_enumerate_paths.py
label: minys_enumerate_paths.py
doc: "A tool to enumerate paths, likely within the MinYS (Mini-metagenome Assembly)
  framework. Note: The provided text contains container runtime error logs rather
  than the tool's help documentation, so no arguments could be extracted.\n\nTool
  homepage: https://github.com/cguyomar/MinYS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minys:1.1--h9948957_6
stdout: minys_enumerate_paths.py.out
