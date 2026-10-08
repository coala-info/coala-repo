cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ExpansionHunterDenovo
  - merge
label: expansionhunterdenovo_merge
doc: "Generate multisample STR profile from single-sample profiles\n\nTool homepage: https://github.com/Illumina/ExpansionHunterDenovo"
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: FASTA file with reference assembly
    inputBinding:
      position: 101
      prefix: --reference
  - id: manifest
    type: File
    doc: TSV with sample names, case/control status and paths of the single-sample STR profiles
    inputBinding:
      position: 101
      prefix: --manifest
  - id: str_profiles
    type:
      type: array
      items: File
    doc: The *.str_profile.json files named in the manifest. They are staged in the work directory, so the manifest must name them by file name only.
  - id: min_unit_len
    type:
      - 'null'
      - int
    doc: Shortest repeat unit to consider
    inputBinding:
      position: 101
      prefix: --min-unit-len
  - id: max_unit_len
    type:
      - 'null'
      - int
    doc: Longest repeat unit to consider
    inputBinding:
      position: 101
      prefix: --max-unit-len
  - id: output_prefix
    type: string
    doc: Prefix for the output files
    inputBinding:
      position: 102
      prefix: --output-prefix
outputs:
  - id: multisample_profile
    type:
      - 'null'
      - File
    doc: Multisample STR profile in JSON format
    outputBinding:
      glob: $(inputs.output_prefix).multisample_profile.json
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.str_profiles)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
