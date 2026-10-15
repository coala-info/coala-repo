cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_get_clusters_from_taxa
label: phyluce_phyluce_probe_get_clusters_from_taxa
doc: "Given a directory of cluster JSON files and a SQLite database of probes, assign\
  \ probes to loci by cluster overlap (updates the database)\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: clusters
    type: Directory
    doc: The directory containing cluster files
    inputBinding:
      prefix: --clusters
  - id: db
    type: File
    doc: The database to update (a staged copy is updated and returned)
    inputBinding:
      prefix: --db
      valueFrom: $(self.basename)
  - id: taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: The taxon overlaps to use
    inputBinding:
      prefix: --taxa
outputs:
  - id: updated_db
    type: File
    doc: The updated SQLite database.
    outputBinding:
      glob: $(inputs.db.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.db)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
