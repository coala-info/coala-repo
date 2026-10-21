cwlVersion: v1.2
class: CommandLineTool
baseCommand: [SatsumaToFASTA]
label: satsuma2_SatsumaToFASTA
doc: "Generates a FASTA file from a satsuma summary file.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: input_file
    type: File
    doc: "satsuma file"
    inputBinding:
      position: 1
      prefix: -i
  - id: fasta_file
    type: File
    doc: "fasta file to get sequence from"
    inputBinding:
      position: 2
      prefix: -f
  - id: output_target
    type: ['null', boolean]
    doc: "output target sequence (def=0)"
    inputBinding:
      position: 3
      prefix: -t
  - id: flank
    type: ['null', int]
    doc: "flanks on each side (def=0)"
    inputBinding:
      position: 4
      prefix: -s
outputs:
  - id: fasta
    type: stdout
    doc: "FASTA file of the aligned blocks, written to standard output"
stdout: $(inputs.input_file.nameroot).blocks.fa
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
