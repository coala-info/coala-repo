cwlVersion: v1.2
class: CommandLineTool
baseCommand: favites_lite_favites_lite.py
label: favites_lite_favites_lite.py
doc: "FAVITES (Framework for Actual Virological Informed Tool for Episodic Simulation)
  Lite version.\n\nTool homepage: https://github.com/niemasd/FAVITES-Lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/favites_lite:1.0.3--hdfd78af_0
stdout: favites_lite_favites_lite.py.out
