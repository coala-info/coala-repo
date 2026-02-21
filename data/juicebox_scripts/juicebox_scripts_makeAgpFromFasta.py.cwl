cwlVersion: v1.2
class: CommandLineTool
baseCommand: juicebox_scripts_makeAgpFromFasta.py
label: juicebox_scripts_makeAgpFromFasta.py
doc: "A script to generate an AGP file from a FASTA file. (Note: The provided help
  text contains only container runtime error messages and does not list specific arguments.)\n
  \nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
stdout: juicebox_scripts_makeAgpFromFasta.py.out
