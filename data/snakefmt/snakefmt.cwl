cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakefmt
label: snakefmt
doc: "A tool for formatting Snakemake files.\n\nTool homepage: https://github.com/snakemake/snakefmt"
inputs:
  - id: src
    type:
      - type: array
        items: File
    doc: The Snakemake files to format. Files are staged writable and formatted in
      place; the formatted files are returned as outputs.
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
  - id: compact_diff
    type:
      - 'null'
      - boolean
    doc: Same as --diff but only shows lines that would change plus a few lines of
      context.
    inputBinding:
      position: 102
      prefix: --compact-diff
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
    inputBinding:
      position: 102
      prefix: --exclude
  - id: include
    type:
      - 'null'
      - string
    doc: A regular expression that matches files and directories that should be included
      on recursive searches.
    inputBinding:
      position: 102
      prefix: --include
  - id: line_length
    type:
      - 'null'
      - int
    doc: 'Lines longer than INT will be wrapped. [default: 88]'
    inputBinding:
      position: 102
      prefix: --line-length
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turns on debug-level logger.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: formatted_files
    type:
      type: array
      items: File
    doc: The input files after formatting (unchanged when --check, --diff or --compact-diff
      is used).
    outputBinding:
      glob: $(inputs.src.map(function(f) { return f.basename; }))
  - id: stdout
    type: stdout
    doc: Standard output (the diff when --diff or --compact-diff is used)
  - id: stderr
    type: stderr
    doc: Standard error (snakefmt reports the files it reformatted here)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.src)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakefmt:0.11.3--pyha6daafd_0
stdout: snakefmt.out
stderr: snakefmt.err
successCodes:
  - 0
  - 1
