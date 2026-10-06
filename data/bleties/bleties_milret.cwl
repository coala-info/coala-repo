cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bleties
  - milret
label: bleties_milret
doc: "MILRET - Method of IES Long-read RETention\n\nTool homepage: https://github.com/Swart-lab/bleties"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: BAM file containing mapping, must be sorted and indexed.
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --bam
  - id: ref_file
    type:
      - 'null'
      - File
    doc: FASTA file containing genomic contigs used as reference for the mapping
    inputBinding:
      position: 101
      prefix: --ref
  - id: ies_file
    type:
      - 'null'
      - File
    doc: GFF3 file containing coordinates of IES junctions in MAC genome, from
      MILRAA or third party tool
    inputBinding:
      position: 101
      prefix: --ies
  - id: use_ies_lengths
    type:
      - 'null'
      - boolean
    doc: Only count inserts that match IES lengths reported in the input GFF 
      file. This assumes that the input GFF file is produced by BleTIES MILRAA
    inputBinding:
      position: 101
      prefix: --use_ies_lengths
  - id: length_threshold
    type:
      - 'null'
      - float
    doc: Length threshold to count matching IES length, if option 
      --use_ies_lengths is applied
    inputBinding:
      position: 101
      prefix: --length_threshold
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output filename prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Dump contents of retention score objects to JSON file, for 
      troubleshooting
    inputBinding:
      position: 101
      prefix: --dump
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: retention_scores
    type:
      - 'null'
      - File
    doc: Table of IES retention scores per junction (<prefix>.milret.tsv)
    outputBinding:
      glob: "$(inputs.output_prefix ? inputs.output_prefix : 'milret.test').milret.tsv"
  - id: dump_json
    type:
      - 'null'
      - File
    doc: JSON dump of retention score objects (<prefix>.milret.dump.json), with
      dump
    outputBinding:
      glob: "$(inputs.output_prefix ? inputs.output_prefix : 'milret.test').milret.dump.json"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_0
stdout: bleties_milret.out
