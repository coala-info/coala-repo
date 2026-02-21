cwlVersion: v1.2
class: CommandLineTool
baseCommand: sort-bed
label: bedops_sort-bed
doc: "Sorts BED files. The sorted BED file is sent to standard output. Sorting is
  required for many BEDOPS utilities to ensure high performance.\n\nTool homepage:
  http://bedops.readthedocs.io"
inputs:
  - id: input_file
    type: File
    doc: The BED file to be sorted.
    inputBinding:
      position: 1
  - id: duplicates
    type:
      - 'null'
      - boolean
    doc: Keep duplicate lines (default).
    inputBinding:
      position: 102
      prefix: --duplicates
  - id: max_mem
    type:
      - 'null'
      - string
    doc: Set maximum memory usage (e.g., 2G, 500M).
    inputBinding:
      position: 102
      prefix: --max-mem
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Set temporary directory for intermediate files.
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Remove duplicate lines.
    inputBinding:
      position: 102
      prefix: --unique
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: bedops_sort-bed.out
