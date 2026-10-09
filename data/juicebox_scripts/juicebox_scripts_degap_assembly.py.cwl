cwlVersion: v1.2
class: CommandLineTool
baseCommand: degap_assembly.py
label: juicebox_scripts_degap_assembly.py
doc: "Removes the hic_gap entries from a Juicebox assembly file and prints the result to standard output.\n\nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs:
  - id: assembly_file
    type: File
    doc: Juicebox assembly file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Assembly without gap entries
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
stdout: degapped.assembly
