cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimi_hmdb_extract
label: mimi_mimi_hmdb_extract
doc: "Extract metabolite information from an HMDB XML file.\n\nTool homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs:
  - id: id_tag
    type:
      - 'null'
      - string
    doc: 'Preferred ID tag to use: accession, kegg_id, chebi_id, pubchem_compound_id or drugbank_id.'
    inputBinding:
      position: 101
      prefix: --id-tag
  - id: xml
    type: File
    doc: Path to HMDB metabolites XML file.
    inputBinding:
      position: 101
      prefix: --xml
  - id: min_mass
    type:
      - 'null'
      - double
    doc: Lower bound of molecular weight in Da.
    inputBinding:
      position: 101
      prefix: --min-mass
  - id: max_mass
    type:
      - 'null'
      - double
    doc: Upper bound of molecular weight in Da.
    inputBinding:
      position: 101
      prefix: --max-mass
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output TSV file path (default: metabolites.tsv).'
    default: metabolites.tsv
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: metabolites
    type: File
    doc: Metabolite table.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
