cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - build
label: pastrami_build
doc: "Build reference set\n\nTool homepage: https://github.com/healthdisparities/pastrami"
inputs:
  - id: haplotypes
    type:
      - 'null'
      - File
    doc: "File of haplotype positions"
    inputBinding:
      position: 101
      prefix: --haplotypes
  - id: reference_files
    type:
      type: array
      items: File
    doc: "TPED and TFAM files of the reference individuals (they are staged in the working directory)"
  - id: reference_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for the reference TPED/TFAM input files"
    inputBinding:
      position: 101
      prefix: --reference-prefix
  - id: per_individual
    type:
      - 'null'
      - boolean
    doc: "Generate per-individual copying rather than per-population copying"
    inputBinding:
      position: 101
      prefix: --per-individual
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: "File containing log information (default: run.log)"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of concurrent threads (default: 4)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print program progress information on screen"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: reference_pickle_out_path
    type: string
    doc: "The reference pickle file output"
    inputBinding:
      position: 103
      prefix: --reference-pickle-out
  - id: reference_out_path
    type: string
    doc: "The reference copying matrix output"
    inputBinding:
      position: 104
      prefix: --reference-out
outputs:
  - id: reference_pickle_out
    type: File
    doc: "The reference pickle file"
    outputBinding:
      glob: $(inputs.reference_pickle_out_path)
  - id: reference_out
    type: File
    doc: "The reference copying matrix"
    outputBinding:
      glob: $(inputs.reference_out_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: "File containing log information"
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.reference_files)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
