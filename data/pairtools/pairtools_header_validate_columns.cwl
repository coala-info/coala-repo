cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - header
  - validate-columns
label: pairtools_header_validate_columns
doc: "Validate the columns of the .pairs/pairsam file against a reference or within
  the file. If the checks pass, the full pairs file is returned; otherwise the tool
  fails.\n\nTool homepage: https://github.com/open2c/pairtools"
inputs:
  - id: pairs_path
    type: File
    doc: Input .pairs/.pairsam file
    inputBinding:
      position: 1
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Header file for comparison (optional)
    inputBinding:
      position: 102
      prefix: --reference-file
  - id: reference_columns
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of columns to check (optional), e.g.: readID,chrom1,pos1,chrom2,pos2,strand1,strand2,pair_type,sam1,sam2,walk_pair_index,walk_pair_type'
    inputBinding:
      position: 102
      prefix: --reference-columns
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed input decompressing command.
    inputBinding:
      position: 102
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed output compressing command.
    inputBinding:
      position: 102
      prefix: --nproc-out
  - id: cmd_in
    type:
      - 'null'
      - string
    doc: 'A command to decompress the input. If provided, fully overrides the auto-guessed
      command. Does not work with stdin. Must read input from stdin and print output
      into stdout. EXAMPLE: pbgzip -dc -n 3'
    inputBinding:
      position: 102
      prefix: --cmd-in
  - id: cmd_out
    type:
      - 'null'
      - string
    doc: 'A command to compress the output. If provided, fully overrides the auto-guessed
      command. Does not work with stdout. Must read input from stdin and print output
      into stdout. EXAMPLE: pbgzip -c -n 8'
    inputBinding:
      position: 102
      prefix: --cmd-out
  - id: output_path
    type: string
    doc: Output file. If the path ends with .gz or .lz4, the output is bgzip-/lz4c-compressed.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output pairs file or header
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
