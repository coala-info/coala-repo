cwlVersion: v1.2
class: CommandLineTool
baseCommand: HpsuisSero.sh
label: hpsuissero_HpsuisSero.sh
doc: "Serotyping tool for Haemophilus parasuis\n\nTool homepage: https://github.com/jimmyliu1326/HpsuisSero"
inputs:
  - id: input_file
    type: File
    doc: input file
    inputBinding:
      position: 101
      prefix: -i
  - id: input_type
    type: string
    doc: input type [fasta or fastq]
    inputBinding:
      position: 101
      prefix: -x
  - id: sample_name
    type: string
    doc: sample name
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_directory_path
    type: Directory
    doc: Output or path parameter `output_directory_path`
    inputBinding:
      position: 102
      prefix: --output-directory
outputs:
  - id: output_directory
    type: Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hpsuissero:1.0.1--hdfd78af_0
