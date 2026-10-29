cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - show-snps
label: mummer_show-snps
doc: "Report the SNPs (or amino acid substitutions for promer) and indels in the alignments of a delta file, with positions and other useful information.\n\nTool homepage: https://github.com/mummer4/mummer"
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
    dockerOutputDirectory: /data
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference)
      - $(inputs.query)
inputs:
  - id: unique_only
    type:
      - 'null'
      - boolean
    doc: "Do not report SNPs from alignments with an ambiguous mapping, i.e. only report SNPs where the [R] and [Q] columns equal 0 and do not output these columns"
    inputBinding:
      position: 1
      prefix: "-C"
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: "Do not print the output header"
    inputBinding:
      position: 1
      prefix: "-H"
  - id: no_indels
    type:
      - 'null'
      - boolean
    doc: "Do not report indels"
    inputBinding:
      position: 1
      prefix: "-I"
  - id: lengths
    type:
      - 'null'
      - boolean
    doc: "Include sequence length information in the output"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: sort_query
    type:
      - 'null'
      - boolean
    doc: "Sort output lines by query IDs and SNP positions"
    inputBinding:
      position: 1
      prefix: "-q"
  - id: sort_reference
    type:
      - 'null'
      - boolean
    doc: "Sort output lines by reference IDs and SNP positions"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: select_alignments
    type:
      - 'null'
      - boolean
    doc: "Specify which alignments to report by passing show-coords lines to stdin (give them in the coords_stdin input)"
    inputBinding:
      position: 1
      prefix: "-S"
  - id: tab
    type:
      - 'null'
      - boolean
    doc: "Switch to tab-delimited format"
    inputBinding:
      position: 1
      prefix: "-T"
  - id: context
    type:
      - 'null'
      - int
    doc: "Include x characters of surrounding SNP context in the output, default 0"
    inputBinding:
      position: 1
      prefix: "-x"
  - id: delta_file
    type: File
    doc: "Delta alignment file from nucmer or promer"
    inputBinding:
      position: 100
  - id: coords_stdin
    type:
      - 'null'
      - File
    doc: "show-coords output passed on stdin; use with -S to select the alignments to report"
  - id: reference
    type: File
    doc: "The delta file records the absolute path of this sequence file, so it is staged in the working directory /data, the same place nucmer or promer used. Reference sequence file named in the delta file."
  - id: query
    type: File
    doc: "The delta file records the absolute path of this sequence file, so it is staged in the working directory /data, the same place nucmer or promer used. Query sequence file named in the delta file."
outputs:
  - id: stdout_out
    type: stdout
    doc: "List of SNPs and indels"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
stdout: mummer_show-snps.snps
stderr: mummer_show-snps.log
stdin: '$(inputs.coords_stdin ? inputs.coords_stdin.path : null)'
