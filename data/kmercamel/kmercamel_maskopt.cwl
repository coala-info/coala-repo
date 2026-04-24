cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmercamel maskopt
label: kmercamel_maskopt
doc: "Masks a superstring using k-mers.\n\nTool homepage: https://github.com/OndrejSladky/kmercamel/"
inputs:
  - id: ms
    type: File
    doc: Path to the masked superstring file
    inputBinding:
      position: 1
  - id: distinct_reverse_complement
    type:
      - 'null'
      - boolean
    doc: treat k-mer and its reverse complement as distinct
    inputBinding:
      position: 102
      prefix: -u
  - id: kmer_size
    type: int
    doc: k-mer size
    inputBinding:
      position: 102
      prefix: -k
  - id: target_mask_type
    type:
      - 'null'
      - string
    doc: the target mask type to be run
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output for the (minone) masked superstring; if not specified, printed 
      to stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
