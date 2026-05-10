cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProteomIQon.ProteinInference
label: proteomiqon-proteininference
doc: "Protein inference tool for ProteomIQon\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs:
  - id: gff3
    type:
      - 'null'
      - File
    doc: specify GFF3 file
    inputBinding:
      position: 101
      prefix: --gff3
  - id: input_folder
    type:
      - 'null'
      - type: array
        items: Directory
    doc: specify folder with input files
    inputBinding:
      position: 101
      prefix: --inputfolder
  - id: param_file
    type:
      - 'null'
      - File
    doc: specify param file for protein inference
    inputBinding:
      position: 101
      prefix: --paramfile
  - id: peptide_database
    type:
      - 'null'
      - File
    doc: Specify the file path of the peptide data base.
    inputBinding:
      position: 101
      prefix: --peptidedatabase
  - id: output_directory_path
    type: Directory
    doc: Output or path parameter `output_directory_path`
    inputBinding:
      position: 102
      prefix: --output-directory
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: specify output directory
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/proteomiqon-proteininference:0.0.7--hdfd78af_1
