cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_get_multi_fasta_table
label: phyluce_phyluce_probe_get_multi_fasta_table
doc: "Make a table (SQLite database) of the loci found in a folder of FASTA files,\
  \ one column per taxon\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: fastas
    type: Directory
    doc: A folder of fasta files.
    inputBinding:
      prefix: --fastas
  - id: output_path
    type: string
    doc: A SQLite database to create during integration.
    inputBinding:
      prefix: --output
  - id: base_taxon
    type: string
    doc: The base taxon to use.
    inputBinding:
      prefix: --base-taxon
outputs:
  - id: output
    type: File
    doc: The SQLite database.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
