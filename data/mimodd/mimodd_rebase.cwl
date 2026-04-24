cwlVersion: v1.2
class: CommandLineTool
baseCommand: rebase
label: mimodd_rebase
doc: "Remaps variants from one genome assembly to another using a UCSC chain file.\n\
  \nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: input_file
    type: File
    doc: the VCF file to rebase
    inputBinding:
      position: 1
  - id: chain_file
    type: File
    doc: the UCSC chain file to calculate new coordinates from (the file may be 
      gzipped or uncompressed)
    inputBinding:
      position: 2
  - id: filter
    type:
      - 'null'
      - string
    doc: 'define which mapped variants to report: "unique": report only unambiguously
      mapped variants, "best": for ambiguously mapping variants, report the mapping
      with the highest score, "all": for ambiguously mapping variants, report all
      mappings'
    inputBinding:
      position: 103
      prefix: --filter
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: swap the genome versions specified in the chain file, i.e., assume the 
      coordinates in the input file are based on the chain file target genome 
      version and should be mapped to the source genome version
    inputBinding:
      position: 103
      prefix: --reverse
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: report remap statistics
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output to the specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
