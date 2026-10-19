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
      - string
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
  - id: output_path
    type:
      - 'null'
      - string
    doc: path+prefix of the report file, the file will be suffixed by the trait name and .txt
    inputBinding:
      position: 102
      prefix: --output-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: report_files
    type:
      type: array
      items: File
    doc: Report files written with the output path prefix (suffixed by the trait name and .txt)
    outputBinding:
      glob: $(inputs.output_path || '__none__')*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raiss:4.0.1--pyhdfd78af_0
stdout: raiss_sanity-check.out
