cwlVersion: v1.2
class: CommandLineTool
baseCommand: juicebox_scripts_agp2assembly.py
label: juicebox_scripts_agp2assembly.py
doc: "The provided text is an error log indicating a failure to pull or build the
  container image (no space left on device) and does not contain the tool's help documentation
  or argument definitions.\n\nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
stdout: juicebox_scripts_agp2assembly.py.out
