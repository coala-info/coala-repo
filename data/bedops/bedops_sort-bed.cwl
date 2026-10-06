cwlVersion: v1.2
class: CommandLineTool
baseCommand: sort-bed
label: bedops_sort-bed
doc: Sort BED file(s). May use '-' to indicate stdin. Results are sent to 
  stdout.
inputs:
  - id: bed_files
    type:
      type: array
      items: File
    doc: Input BED file(s). May use '-' to indicate stdin.
    inputBinding:
      position: 201
  - id: check_sort
    type:
      - 'null'
      - boolean
    doc: Check if file(s) are sorted.
    inputBinding:
      position: 102
      prefix: --check-sort
  - id: max_mem
    type:
      - 'null'
      - string
    doc: <val> for --max-mem may be 8G, 8000M, or 8000000000 to specify 8 GB of 
      memory.
    inputBinding:
      position: 102
      prefix: --max-mem
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Temporary directory, useful only with --max-mem.
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Print only unique BED elements (similar to 'sort -u'). Cannot be used 
      with --duplicates.
    inputBinding:
      position: 102
      prefix: --unique
  - id: duplicates
    type:
      - 'null'
      - boolean
    doc: Print only duplicated or repeated elements (similar to 'uniq -d'). 
      Cannot be used with --unique.
    inputBinding:
      position: 102
      prefix: --duplicates
outputs:
  - id: stdout
    type: stdout
    doc: Sorted BED written to standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: sort-bed.out
s:url: http://bedops.readthedocs.io
$namespaces:
  s: https://schema.org/
