cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedLiftOver
label: ngs-bits_BedLiftOver
doc: "Lift-over of regions in a BED file to a different genome build.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: "Input BED file with the regions to lift."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "The file where the lifted regions will be written to."
    inputBinding:
      position: 102
      prefix: -out
  - id: unmapped_path
    type:
      - 'null'
      - string
    doc: "The file where the unmappable regions will be written to."
    inputBinding:
      position: 102
      prefix: -unmapped
  - id: chain
    type:
      - 'null'
      - File
      - string
    doc: "Input Chain file in .chain/.chain.gz format or \"hg19_hg38\" / \"hg38_hg19\" to read from settings file. Default value: 'hg19_hg38' (Give a chain file (File) or one of the names hg19_hg38 / hg38_hg19, which need a settings file.)"
    inputBinding:
      position: 101
      prefix: -chain
  - id: max_deletion
    type:
      - 'null'
      - int
    doc: "Allowed percentage of deleted/unmapped bases in each region. Default value: '5'"
    inputBinding:
      position: 101
      prefix: -max_deletion
  - id: max_increase
    type:
      - 'null'
      - int
    doc: "Allowed percentage size increase of a region. Default value: '10'"
    inputBinding:
      position: 101
      prefix: -max_increase
  - id: remove_special_chr
    type:
      - 'null'
      - boolean
    doc: "Removes regions that are mapped to special chromosomes. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -remove_special_chr
  - id: merged_output
    type:
      - 'null'
      - boolean
    doc: "Output lifted and unlifted regions in the output file, keeping the order of the input regions. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -merged_output
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 101
      prefix: --settings
outputs:
  - id: output_file
    type: File
    doc: "The file where the lifted regions will be written to."
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: unmapped
    type:
      - 'null'
      - File
    doc: "The file where the unmappable regions will be written to."
    outputBinding:
      glob: $(inputs.unmapped_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
