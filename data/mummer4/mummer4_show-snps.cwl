cwlVersion: v1.2
class: CommandLineTool
baseCommand: show-snps
label: mummer4_show-snps
doc: "Output is to stdout, and consists of a list of SNPs (or amino acid substitutions
  for promer) with positions and other useful info.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: deltafile
    type: File
    doc: Input is the .delta output of either the nucmer or promer program 
      passed on the command line.
    inputBinding:
      position: 1
  - id: include_sequence_length
    type:
      - 'null'
      - boolean
    doc: Include sequence length information in the output
    inputBinding:
      position: 102
      prefix: -l
  - id: no_ambiguous_mapping_snps
    type:
      - 'null'
      - boolean
    doc: Do not report SNPs from alignments with an ambiguous mapping, i.e. only
      report SNPs where the [R] and [Q] columns equal 0 and do not output these 
      columns
    inputBinding:
      position: 102
      prefix: -C
  - id: no_indels
    type:
      - 'null'
      - boolean
    doc: Do not report indels
    inputBinding:
      position: 102
      prefix: -I
  - id: no_output_header
    type:
      - 'null'
      - boolean
    doc: Do not print the output header
    inputBinding:
      position: 102
      prefix: -H
  - id: snp_context_chars
    type:
      - 'null'
      - int
    doc: Include x characters of surrounding SNP context in the output, default 
      0
    inputBinding:
      position: 102
      prefix: -x
  - id: sort_by_query
    type:
      - 'null'
      - boolean
    doc: Sort output lines by query IDs and SNP positions
    inputBinding:
      position: 102
      prefix: -q
  - id: sort_by_reference
    type:
      - 'null'
      - boolean
    doc: Sort output lines by reference IDs and SNP positions
    inputBinding:
      position: 102
      prefix: -r
  - id: stdin_show_coords
    type:
      - 'null'
      - boolean
    doc: Specify which alignments to report by passing 'show-coords' lines to 
      stdin
    inputBinding:
      position: 102
      prefix: -S
  - id: tab_delimited
    type:
      - 'null'
      - boolean
    doc: Switch to tab-delimited format
    inputBinding:
      position: 102
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_show-snps.out
