cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimi_hmdb_extract
label: mimi_mimi_hmdb_extract
doc: "Extract metabolite information from HMDB XML file\n\nTool homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs:
  - id: id_tag
    type:
      - 'null'
      - string
    doc: 'Preferred ID tag to use. Options: accession, kegg_id, chebi_id, pubchem_compound_id,
      drugbank_id'
    inputBinding:
      position: 101
      prefix: --id-tag
  - id: max_mass
    type:
      - 'null'
      - float
    doc: Upper bound of molecular weight in Da
    inputBinding:
      position: 101
      prefix: --max-mass
  - id: min_mass
    type:
      - 'null'
      - float
    doc: Lower bound of molecular weight in Da
    inputBinding:
      position: 101
      prefix: --min-mass
  - id: xml
    type: File
    doc: Path to HMDB metabolites XML file
    inputBinding:
      position: 101
      prefix: --xml
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output TSV file path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
