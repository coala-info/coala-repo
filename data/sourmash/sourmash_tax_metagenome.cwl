cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- tax
- metagenome
label: sourmash_tax_metagenome
doc: 'Summarize metagenome content from gather results.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: gather_csv
  type:
  - 'null'
  - type: array
    items: File
  doc: CSVs from sourmash gather
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
- id: output_base
  type:
  - 'null'
  - string
  doc: base filepath for output file(s) (default stdout)
  inputBinding:
    position: 1
    prefix: --output-base
- id: output_dir
  type: string
  doc: directory for output files
  inputBinding:
    position: 1
    prefix: --output-dir
  default: metagenome_out
- id: taxonomy_csv
  type:
  - 'null'
  - type: array
    items: File
  doc: database lineages CSV
  inputBinding:
    position: 1
    prefix: --taxonomy-csv
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
- id: output_format
  type:
  - 'null'
  - type: array
    items: string
  doc: choose output format(s)
  inputBinding:
    position: 1
    prefix: --output-format
- id: force
  type:
  - 'null'
  - boolean
  doc: continue past errors in taxonomy database loading
  inputBinding:
    position: 1
    prefix: --force
- id: lins
  type:
  - 'null'
  - boolean
  doc: use LIN taxonomy in place of standard taxonomic ranks. Note that the taxonomy CSV must contain 'lin' lineage information.
  inputBinding:
    position: 1
    prefix: --lins
- id: lingroup
  type:
  - 'null'
  - File
  doc: CSV containing 'name', 'lin' columns, where 'lin' is the lingroup prefix. For 'tax metagenome' runs with a single 'gather' file (single query), providing this file will allow us to output a 'lingroup' report containing taxonomic summarization for each group. For multiple queries, we recommend the 'csv_summary' output format.
  inputBinding:
    position: 1
    prefix: --lingroup
- id: ictv
  type:
  - 'null'
  - boolean
  doc: use ICTV taxonomy in place of standard taxonomic ranks. Note that the taxonomy CSV must contain ICTV ranks.
  inputBinding:
    position: 1
    prefix: --ictv
- id: rank
  type:
  - 'null'
  - string
  doc: 'For non-default output formats. Classify to this rank (tax genome) or summarize taxonomy at this rank and above (tax metagenome). Note that the taxonomy CSV must contain lineage information at this rank, and that LIN positions start at 0. Choices: ''strain'', ''species'', ''genus'', ''family'', ''order'', ''class'', ''phylum'', ''superkingdom'' or an integer LIN position'
  inputBinding:
    position: 1
    prefix: --rank
- id: use_abundances
  type:
  - 'null'
  - boolean
  doc: use abundances from sketches if available (for krona and lineage_summary)
  inputBinding:
    position: 1
    prefix: --use-abundances
- id: ignore_abundances
  type:
  - 'null'
  - boolean
  doc: ignore abundances from sketches even if available
  inputBinding:
    position: 1
    prefix: --ignore-abundances
- id: v4
  type:
  - 'null'
  - boolean
  doc: use sourmash v4 command-line behavior (default)
  inputBinding:
    position: 1
    prefix: --v4
- id: v5
  type:
  - 'null'
  - boolean
  doc: use sourmash v5 command-line behavior
  inputBinding:
    position: 1
    prefix: --v5
outputs:
- id: output_dir_result
  type: Directory
  doc: directory for output files
  outputBinding:
    glob: $(inputs.output_dir)
- id: stdout
  type: stdout
  doc: Standard output
stdout: sourmash_tax_metagenome.stdout.txt
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
