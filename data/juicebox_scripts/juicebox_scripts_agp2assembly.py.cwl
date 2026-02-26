cwlVersion: v1.2
class: CommandLineTool
baseCommand: agp2assembly.py
label: juicebox_scripts_agp2assembly.py
doc: "\nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs:
  - id: input_agp_file
    type: File
    inputBinding:
      position: 1
outputs:
  - id: output_assembly_file
    type: File
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
