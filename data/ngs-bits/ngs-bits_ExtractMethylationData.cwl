cwlVersion: v1.2
class: CommandLineTool
baseCommand: ExtractMethylationData
label: ngs-bits_ExtractMethylationData
doc: "Extracts the methylation state for a given set of loci\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: "Tabix indexed BED.GZ file that contains the methylation info for each base (modkit)."
    secondaryFiles:
      - pattern: .tbi
        required: true
    inputBinding:
      position: 101
      prefix: -in
  - id: loci
    type: File
    doc: "BED file containig position and strand of intrest"
    inputBinding:
      position: 101
      prefix: -loci
  - id: output_file_path
    type: string
    doc: "Output BED file containing combined methylation info of provided loci. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: -ref
  - id: add_methylation_types
    type:
      - 'null'
      - boolean
    doc: "Also report 5mC (m) and 5hmC (h) entries as separate columns Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -add_methylation_types
  - id: skip_invalid_sites
    type:
      - 'null'
      - boolean
    doc: "Skip invalid CpG sites instead of aborting. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -skip_invalid_sites
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
    doc: "Output BED file containing combined methylation info of provided loci. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
