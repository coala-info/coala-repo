cwlVersion: v1.2
class: CommandLineTool
baseCommand: restrict_repset.py
label: phylotoast_restrict_repset.py
doc: "Take a subset BIOM table (e.g. from a core calculation) and a representative
  set (repset) FASTA file and create a new repset restricted to the OTUs in the BIOM
  table.\n\nTool homepage: https://github.com/smdabdoub/phylotoast"
inputs:
  - id: biom_fp
    type: File
    doc: Path to a biom-format file with OTU-Sample abundance data.
    inputBinding:
      position: 101
      prefix: --biom_fp
  - id: repset_fp
    type: File
    doc: Path to a FASTA-format file containing the representative set of OTUs
    inputBinding:
      position: 101
      prefix: --repset_fp
outputs:
  - id: repset_out_fp
    type:
      - 'null'
      - File
    doc: Path to the new restricted repset file
    outputBinding:
      glob: $(inputs.repset_out_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
