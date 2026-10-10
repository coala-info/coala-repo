cwlVersion: v1.2
class: CommandLineTool
baseCommand: findMitoReference.py
label: mitohifi_findMitoReference.py
doc: "Finds the closest complete mitochondrial (or chloroplast) genome in NCBI for a
  species, first for the same species and then along its lineage, and downloads
  it as GenBank and FASTA files for use as the MitoHiFi reference. Needs network
  access to NCBI.\n\nTool homepage: https://github.com/marcelauliano/MitoHiFi"
inputs:
  - id: species
    type: string
    doc: latin name
    inputBinding:
      position: 1
      prefix: --species
  - id: email
    type:
      - 'null'
      - string
    doc: Email address sent to NCBI Entrez with the queries.
    inputBinding:
      position: 2
      prefix: --email
  - id: outfolder
    type: string
    doc: Output folder (created if missing) for the downloaded .gb and .fasta files.
    inputBinding:
      position: 3
      prefix: --outfolder
  - id: organelle_type
    type:
      - 'null'
      - string
    doc: "specify the type of organelle: mitochondrion (default) or chloroplast"
    inputBinding:
      position: 4
      prefix: -t
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimal appropriate length
    inputBinding:
      position: 5
      prefix: --min_length
outputs:
  - id: reference_folder
    type: Directory
    doc: Folder with the downloaded reference (.gb and .fasta).
    outputBinding:
      glob: $(inputs.outfolder)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mitohifi:2.2_cv1
stdout: mitohifi_findMitoReference.py.out
