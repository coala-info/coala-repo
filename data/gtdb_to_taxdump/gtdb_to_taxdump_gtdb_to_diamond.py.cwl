cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdb_to_diamond.py
label: gtdb_to_taxdump_gtdb_to_diamond.py
doc: "Convert GTDB taxonomy to input for \"diamond makedb --taxonmap\"\n\nTool homepage:
  https://github.com/nick-youngblut/gtdb_to_taxdump"
inputs:
  - id: faa_tarball
    type: File
    doc: tarball of GTDB ref genome gene animo acid data files
    inputBinding:
      position: 1
  - id: names_dmp
    type: File
    doc: taxdump names.dmp file (eg., from gtdb_to_taxdump.py)
    inputBinding:
      position: 2
  - id: nodes_dmp
    type: File
    doc: taxdump nodes.dmp file (eg., from gtdb_to_taxdump.py)
    inputBinding:
      position: 3
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: gzip output fasta?
    inputBinding:
      position: 104
      prefix: --gzip
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep temporary output?
    inputBinding:
      position: 104
      prefix: --keep-temp
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 104
      prefix: --outdir
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory
    inputBinding:
      position: 104
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
stdout: gtdb_to_taxdump_gtdb_to_diamond.py.out
