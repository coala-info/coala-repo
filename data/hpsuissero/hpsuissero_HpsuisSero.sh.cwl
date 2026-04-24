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
outputs:
  - id: output_directory
    type: Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hpsuissero:1.0.1--hdfd78af_0
