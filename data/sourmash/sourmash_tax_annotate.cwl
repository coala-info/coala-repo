cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- tax
- annotate
label: sourmash_tax_annotate
doc: 'Annotate gather results with taxonomy.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: gather_csv
  type:
  - 'null'
  - type: array
    items: File
  doc: CSV output files from sourmash gather
  inputBinding:
    position: 1
    prefix: --gather-csv
- id: from_file
  type:
  - 'null'
  - File
  doc: input many gather results as a text file, with one gather CSV per line
  inputBinding:
    position: 1
    prefix: --from-file
- id: quiet
  type:
  - 'null'
  - boolean
  doc: suppress non-error output
  inputBinding:
    position: 1
    prefix: --quiet
- id: taxonomy_csv
  type:
  - 'null'
  - type: array
    items: File
  doc: database lineages CSV
  inputBinding:
    position: 1
    prefix: --taxonomy-csv
- id: output_dir
  type: string
  doc: directory for output files
  inputBinding:
    position: 1
    prefix: --output-dir
  default: annotated
- id: keep_full_identifiers
  type:
  - 'null'
  - boolean
  doc: do not split identifiers on whitespace
  inputBinding:
    position: 1
    prefix: --keep-full-identifiers
- id: keep_identifier_versions
  type:
  - 'null'
  - boolean
  doc: after splitting identifiers, do not remove accession versions
  inputBinding:
    position: 1
    prefix: --keep-identifier-versions
- id: fail_on_missing_taxonomy
  type:
  - 'null'
  - boolean
  doc: fail quickly if taxonomy is not available for an identifier
  inputBinding:
    position: 1
    prefix: --fail-on-missing-taxonomy
- id: force
  type:
  - 'null'
  - boolean
  doc: continue past errors in file and taxonomy loading
  inputBinding:
    position: 1
    prefix: --force
- id: lins
  type:
  - 'null'
  - boolean
  doc: use LIN taxonomy in place of standard taxonomic ranks. Note that the taxonomy CSV must contain LIN lineage information.
  inputBinding:
    position: 1
    prefix: --lins
- id: ictv
  type:
  - 'null'
  - boolean
  doc: use ICTV taxonomy in place of standard taxonomic ranks. Note that the taxonomy CSV must contain ICTV ranks.
  inputBinding:
    position: 1
    prefix: --ictv
outputs:
- id: output_dir_result
  type: Directory
  doc: directory for output files
  outputBinding:
    glob: $(inputs.output_dir)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entryname: $(inputs.output_dir)
    entry: '${return {"class": "Directory", "basename": inputs.output_dir, "listing": []};}'
    writable: true
