cwlVersion: v1.2
class: CommandLineTool
baseCommand: starchcat
label: bedops_starchcat
doc: Concatenate, update metadata, or recompress lexicographically-sorted, 
  headerless starch archives, performing a multiset union operation and sending 
  compressed data to standard output.
inputs:
  - id: starch_files
    type:
      type: array
      items: File
    doc: Lexicographically-sorted, headerless starch archive(s). At least one is
      required.
    inputBinding:
      position: 1
  - id: note
    type:
      - 'null'
      - string
    doc: Append note to output archive metadata (optional).
    inputBinding:
      position: 102
      prefix: --note
  - id: bzip2
    type:
      - 'null'
      - boolean
    doc: Specify backend compression type (optional, default is bzip2).
    inputBinding:
      position: 102
      prefix: --bzip2
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Specify backend compression type.
    inputBinding:
      position: 102
      prefix: --gzip
  - id: omit_signature
    type:
      - 'null'
      - boolean
    doc: Skip generating per-chromosome data integrity signature (optional, 
      default is to generate signature).
    inputBinding:
      position: 102
      prefix: --omit-signature
  - id: report_progress
    type:
      - 'null'
      - int
    doc: Report compression progress every N elements per chromosome to standard
      error stream (optional)
    inputBinding:
      position: 102
      prefix: --report-progress
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: starchcat.out
s:url: http://bedops.readthedocs.io
$namespaces:
  s: https://schema.org/
