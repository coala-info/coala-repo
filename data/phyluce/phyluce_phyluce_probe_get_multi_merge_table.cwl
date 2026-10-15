cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_get_multi_merge_table
label: phyluce_phyluce_probe_get_multi_merge_table
doc: "Make a table (SQLite database) of overlapping BED file matches, one column per\
  \ taxon\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: conf
    type: File
    doc: A config file mapping names to BED files.
    inputBinding:
      prefix: --conf
  - id: bed_files
    type:
      type: array
      items: File
    doc: The BED files named in the config file; they are staged in the working directory,
      so use bare file names in the config.
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
  - id: filter
    type:
      - 'null'
      - string
    doc: A file-type filter to apply to the BED directory of files
    inputBinding:
      prefix: --filter
outputs:
  - id: output
    type: File
    doc: The SQLite database.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bed_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
