cwlVersion: v1.2
class: CommandLineTool
baseCommand: agp2assembly.py
label: juicebox_scripts_agp2assembly.py
doc: "Converts an AGP file to a Juicebox assembly file.\n\nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs:
  - id: input_agp_file
    type: File
    doc: Input AGP file
    inputBinding:
      position: 1
  - id: output_assembly_file
    type: string
    doc: Output assembly file name
    inputBinding:
      position: 2
outputs:
  - id: assembly_output
    type: File
    doc: Juicebox assembly file written to the path given in output_assembly_file
    outputBinding:
      glob: $(inputs.output_assembly_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
