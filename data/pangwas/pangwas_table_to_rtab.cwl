cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - table_to_rtab
label: pangwas_table_to_rtab
doc: "Convert a TSV/CSV table to an Rtab file based on regex filters.\n\nTakes as
  input a TSV/CSV table to convert, and a TSV/CSV of regex filters.\nThe filter table
  should have the header: column, regex, name. Where column\nis the 'column' to search,
  'regex' is the regular expression pattern, and\n'name' is how the output variant
  should be named in the Rtab.\n\nAn example `filter.tsv` might look like this:\n\n\
  column    regex         name\nassembly  .*sample2.*   sample2\nlineage   .*2.* \
  \        lineage_2\n\nWhere the goal is to filter the assembly and lineage columns
  for particular values.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: filter
    type: File
    doc: TSV or CSV filter table.
    inputBinding:
      position: 101
      prefix: --filter
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: table
    type: File
    doc: TSV or CSV table.
    inputBinding:
      position: 101
      prefix: --table
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas_table_to_rtab.out
