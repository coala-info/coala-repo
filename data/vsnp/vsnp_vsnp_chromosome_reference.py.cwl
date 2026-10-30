cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_chromosome_reference.py
label: vsnp_vsnp_chromosome_reference.py
doc: "Read the chromosome name (first column) of the first VCF file in a folder and look up\
  \ the reference type.\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: 'Optional: absolute path to the folder with the VCF files (default: current folder)'
    inputBinding:
      position: 101
      prefix: --cwd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_chromosome_reference.py.out
