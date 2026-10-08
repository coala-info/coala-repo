cwlVersion: v1.2
class: CommandLineTool
baseCommand: parse-examl
label: examl_parse-examl
doc: "parse-examl converts a PHYLIP alignment into the binary alignment file that ExaML reads.\n\nTool homepage: https://github.com/stamatak/ExaML"
inputs:
  - id: sequence_file
    type: File
    doc: "Alignment in relaxed PHYLIP format"
    inputBinding:
      position: 1
      prefix: -s
  - id: output_name
    type: string
    doc: "Name stem of the output files (writes <name>.binary)"
    inputBinding:
      position: 2
      prefix: -n
  - id: substitution_model
    type: string
    doc: "Substitution model: BIN for binary data, DNA for nucleotides, PROT for amino acids"
    inputBinding:
      position: 3
      prefix: -m
  - id: disable_site_pattern_compression
    type:
      - 'null'
      - boolean
    doc: "Disable site pattern compression"
    inputBinding:
      position: 4
      prefix: -c
  - id: partition_file
    type:
      - 'null'
      - File
    doc: "File with the assignment of models to alignment partitions"
    inputBinding:
      position: 5
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: binary_alignment
    type: File
    doc: "Binary alignment for ExaML"
    outputBinding:
      glob: $(inputs.output_name).binary
  - id: info_file
    type:
      - 'null'
      - File
    doc: "Information file"
    outputBinding:
      glob: RAxML_info.$(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/examl:v3.0.21-2-deb_cv1
stdout: examl_parse-examl.out
