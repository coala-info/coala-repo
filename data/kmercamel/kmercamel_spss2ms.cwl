cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - spss2ms
label: kmercamel_spss2ms
doc: "Converts a FASTA file to a masked superstring format.\n\nTool homepage: https://github.com/OndrejSladky/kmercamel/"
inputs:
  - id: fasta
    type: File
    doc: Path to the input FASTA file
    inputBinding:
      position: 1
  - id: kmer_size
    type: int
    doc: k-mer size
    inputBinding:
      position: 102
      prefix: -k
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output for the (minone) masked superstring; if not specified, printed 
      to stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
