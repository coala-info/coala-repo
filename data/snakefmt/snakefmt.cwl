cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakefmt
label: snakefmt
doc: "A tool for formatting Snakemake files.\n\nTool homepage: https://github.com/snakemake/snakefmt"
inputs:
  - id: path
    type:
      - 'null'
      - type: array
        items: File
    doc: The path to the Snakemake files or directories to format.
    inputBinding:
      position: 1
  - id: check
    type:
      - 'null'
      - boolean
    doc: Don't write the files back, just return the status. Return code 0 means nothing
      would change. Return code 1 means some files would be reformatted.
    inputBinding:
      position: 102
      prefix: --check
  - id: compact_code
    type:
      - 'null'
      - boolean
    doc: Format code in a compact way.
    inputBinding:
      position: 102
      prefix: --compact-code
  - id: config
    type:
      - 'null'
      - File
    doc: Read configuration from a file.
    inputBinding:
      position: 102
      prefix: --config
  - id: diff
    type:
      - 'null'
      - boolean
    doc: Don't write the files back, just output a diff for each file on stdout.
    inputBinding:
      position: 102
      prefix: --diff
  - id: exclude
    type:
      - 'null'
      - string
    doc: A regular expression that matches files and directories that should be excluded
      on recursive searches.
    default: (\.snakemake|\.git|\.venv)
    inputBinding:
      position: 102
      prefix: --exclude
  - id: include
    type:
      - 'null'
      - string
    doc: A regular expression that matches files and directories that should be included
      on recursive searches.
    default: \.smk$|^Snakefile
    inputBinding:
      position: 102
      prefix: --include
  - id: line_length
    type:
      - 'null'
      - int
    doc: The maximum line length.
    default: 88
    inputBinding:
      position: 102
      prefix: --line-length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakefmt:0.11.3--pyha6daafd_0
stdout: snakefmt.out
