cwlVersion: v1.2
class: CommandLineTool
baseCommand: juicebox_scripts_degap_assembly.py
label: juicebox_scripts_degap_assembly.py
doc: "A script from the juicebox_scripts suite, likely used for degapping genome assemblies.
  Note: The provided text contains container runtime error messages rather than tool
  help documentation.\n\nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
stdout: juicebox_scripts_degap_assembly.py.out
