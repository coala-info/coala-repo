cwlVersion: v1.2
class: CommandLineTool
baseCommand: juicebox_scripts_degap_assembly.py
label: juicebox_scripts_degap_assembly.py
doc: "Removes gaps from an assembly file.\n\nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs:
  - id: assembly_file
    type: File
    doc: Path to the assembly file.
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file. If not specified, output will be written to 
      stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
