cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - raiss
  - sanity-check
label: raiss_sanity-check
doc: "Sanity check for RAISS imputation.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/raiss/"
inputs:
  - id: chr_list
    type:
      - 'null'
      - type: array
        items: string
    doc: List of chromosomes to check
    inputBinding:
      position: 101
      prefix: --chr-list
  - id: harmonized_folder
    type: Directory
    doc: Path to the harmonized folder
    inputBinding:
      position: 101
      prefix: --harmonized-folder
  - id: imputed_folder
    type: Directory
    doc: Path to the imputed folder
    inputBinding:
      position: 101
      prefix: --imputed-folder
  - id: trait
    type: string
    doc: Trait to check
    inputBinding:
      position: 101
      prefix: --trait
  - id: output_path_path
    type: string
    doc: Output or path parameter `output_path_path`
    inputBinding:
      position: 102
      prefix: --output-path
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Path to save the output files
    outputBinding:
      glob: $(inputs.output_path_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raiss:4.0.1--pyhdfd78af_0
