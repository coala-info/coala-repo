cwlVersion: v1.2
class: CommandLineTool
baseCommand: blast_formatter
label: blast_blast_formatter
doc: Stand-alone BLAST formatter client, version 2.17.0+
inputs:
  - id: archive
    type: File
    doc: 'File containing BLAST Archive format in ASN.1 (i.e.: output format 11).
      Incompatible with: rid'
    inputBinding:
      position: 101
      prefix: -archive
  - id: html
    type:
      - 'null'
      - boolean
    doc: Produce HTML output?
    inputBinding:
      position: 101
      prefix: -html
  - id: line_length
    type:
      - 'null'
      - int
    doc: Line length for formatting alignments. Not applicable for outfmt > 4
    inputBinding:
      position: 101
      prefix: -line_length
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: 'Maximum number of aligned sequences to keep. Incompatible with: num_descriptions,
      num_alignments'
    inputBinding:
      position: 101
      prefix: -max_target_seqs
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: 'Number of database sequences to show alignments for. Incompatible with:
      max_target_seqs'
    inputBinding:
      position: 101
      prefix: -num_alignments
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: 'Number of database sequences to show one-line descriptions for. Not applicable
      for outfmt > 4. Incompatible with: max_target_seqs'
    inputBinding:
      position: 101
      prefix: -num_descriptions
  - id: out
    type: string
    doc: Output file name
    inputBinding:
      position: 101
      prefix: -out
  - id: outfmt
    type:
      - 'null'
      - string
    doc: alignment view options (0-20). Options 6, 7, 10, 17 and 20 can be 
      additionally configured to produce a custom format.
    inputBinding:
      position: 101
      prefix: -outfmt
  - id: parse_deflines
    type:
      - 'null'
      - boolean
    doc: Should the query and subject defline(s) be parsed?
    inputBinding:
      position: 101
      prefix: -parse_deflines
  - id: rid
    type:
      - 'null'
      - string
    doc: 'BLAST Request ID (RID). Incompatible with: archive'
    inputBinding:
      position: 101
      prefix: -rid
  - id: show_gis
    type:
      - 'null'
      - boolean
    doc: Show NCBI GIs in deflines?
    inputBinding:
      position: 101
      prefix: -show_gis
  - id: sorthits
    type:
      - 'null'
      - int
    doc: 'Sorting option for hits: 0 = evalue, 1 = bit score, 2 = total score, 3 =
      percent identity, 4 = query coverage. Not applicable for outfmt > 4'
    inputBinding:
      position: 101
      prefix: -sorthits
  - id: sorthsps
    type:
      - 'null'
      - int
    doc: 'Sorting option for hps: 0 = hsp evalue, 1 = hsp score, 2 = hsp query start,
      3 = hsp percent identity, 4 = hsp subject start. Not applicable for outfmt !=
      0'
    inputBinding:
      position: 101
      prefix: -sorthsps
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.17.0--h66d330f_0
s:url: https://blast.ncbi.nlm.nih.gov/doc/blast-help/
$namespaces:
  s: https://schema.org/
