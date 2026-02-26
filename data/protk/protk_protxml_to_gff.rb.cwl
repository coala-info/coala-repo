cwlVersion: v1.2
class: CommandLineTool
baseCommand: protxml_to_gff.rb
label: protk_protxml_to_gff.rb
doc: "Map proteins and peptides to genomic coordinates.\n\nTool homepage: https://github.com/iracooke/protk"
inputs:
  - id: protxml_file
    type: File
    doc: Input proteins.protXML file
    inputBinding:
      position: 1
  - id: coords_file
    type: File
    doc: A file containing genomic coordinates for predicted proteins and/or 
      6-frame translations
    inputBinding:
      position: 102
      prefix: --coords-file
  - id: database
    type: File
    doc: Database used for ms/ms searches (Fasta Format)
    inputBinding:
      position: 102
      prefix: --database
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: genome_idregex
    type:
      - 'null'
      - string
    doc: Regex with capture group for parsing genomic ids from protein ids
    inputBinding:
      position: 102
      prefix: --genome-idregex
  - id: gff_idregex
    type:
      - 'null'
      - string
    doc: Regex with capture group for parsing gff ids from protein ids
    inputBinding:
      position: 102
      prefix: --gff-idregex
  - id: ignore_regex
    type:
      - 'null'
      - string
    doc: Regex to match protein ids that we should ignore completely
    inputBinding:
      position: 102
      prefix: --ignore-regex
  - id: include_mods
    type:
      - 'null'
      - boolean
    doc: Output gff entries for peptide modification sites
    default: false
    inputBinding:
      position: 102
      prefix: --include-mods
  - id: prot_threshold
    type:
      - 'null'
      - float
    doc: Protein Probability Threshold
    default: 0.99
    inputBinding:
      position: 102
      prefix: --prot-threshold
  - id: stack_charge_states
    type:
      - 'null'
      - boolean
    doc: Different peptide charge states get separate gff entries
    default: false
    inputBinding:
      position: 102
      prefix: --stack-charge-states
  - id: threshold
    type:
      - 'null'
      - float
    doc: Peptide Probability Threshold
    default: 0.95
    inputBinding:
      position: 102
      prefix: --threshold
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
