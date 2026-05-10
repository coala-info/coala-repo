cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg build-pairs
label: hicberg_build-pairs
doc: "Create pair files from a pair of alignment files.\n\nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: recover
    type:
      - 'null'
      - boolean
    doc: Set if pairs are built after reads reassignment. Therefore alignment 
      files of group2 will be used.
    inputBinding:
      position: 101
      prefix: --recover
  - id: output_folder_path
    type: Directory
    doc: Output or path parameter `output_folder_path`
    inputBinding:
      position: 102
      prefix: --output-folder
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder to save results.
    outputBinding:
      glob: $(inputs.output_folder_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
