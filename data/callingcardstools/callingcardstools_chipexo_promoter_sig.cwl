cwlVersion: v1.2
class: CommandLineTool
baseCommand: chipexo_promoter_sig
label: callingcardstools_chipexo_promoter_sig
doc: "Compare CHIPEXO and promoter data to find significant regions.\n\nTool homepage:
  https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: chipexo_data_path
    type: File
    doc: Path to the chipexo data file.
    inputBinding:
      position: 101
      prefix: --chipexo_data_path
  - id: chipexo_orig_chr_convention
    type: string
    doc: Chromosome convention of the chipexo data file.
    inputBinding:
      position: 101
      prefix: --chipexo_orig_chr_convention
  - id: chrmap_data_path
    type: File
    doc: Path to the chromosome map file.
    inputBinding:
      position: 101
      prefix: --chrmap_data_path
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Set this flag to gzip the output file.
    inputBinding:
      position: 101
      prefix: --compress
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 101
      prefix: --log_level
  - id: promoter_data_path
    type: File
    doc: Path to the promoter data file.
    inputBinding:
      position: 101
      prefix: --promoter_data_path
  - id: promoter_orig_chr_convention
    type: string
    doc: Chromosome convention of the promoter data file.
    inputBinding:
      position: 101
      prefix: --promoter_orig_chr_convention
  - id: unified_chr_convention
    type: string
    doc: Chromosome convention to convert to.
    inputBinding:
      position: 101
      prefix: --unified_chr_convention
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
