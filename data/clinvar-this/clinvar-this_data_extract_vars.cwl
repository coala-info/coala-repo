cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clinvar-this
  - data
  - extract-vars
label: clinvar-this_data_extract_vars
doc: "Write out variants from RCV records.\n\nTool homepage: https://github.com/bihealth/clinvar-this"
inputs:
  - id: path_input
    type: File
    doc: ClinVar records in JSONL format (as written by xml-to-jsonl)
    inputBinding:
      position: 1
  - id: path_output_dir
    type: string
    doc: Output directory; it is created if missing
    inputBinding:
      position: 2
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: 'Whether to gzip output (default: true)'
    inputBinding:
      position: 101
      prefix: --gzip-output
  - id: no_gzip_output
    type:
      - 'null'
      - boolean
    doc: Write plain (not gzipped) output
    inputBinding:
      position: 101
      prefix: --no-gzip-output
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with per-assembly variant JSONL files
    outputBinding:
      glob: $(inputs.path_output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
