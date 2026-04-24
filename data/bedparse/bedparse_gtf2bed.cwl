cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedparse
  - gtf2bed
label: bedparse_gtf2bed
doc: "Converts a GTF file to BED12 format. This tool supports the Ensembl GTF\nformat,
  which uses features of type 'transcript' (field 3) to define\ntranscripts. In case
  the GTF file defines transcripts with a different feature\ntype, it is possible
  to provide the feature name from the command line. If the\nGTF file also annotates
  'CDS' 'start_codon' or 'stop_codon' these are used to\nannotate the thickStart and
  thickEnd in the BED file.\n\nTool homepage: https://github.com/tleonardi/bedparse"
inputs:
  - id: gtf
    type: File
    doc: Path to the GTF file.
    inputBinding:
      position: 1
  - id: extra_fields
    type:
      - 'null'
      - string
    doc: "Comma separated list of extra GTF fields to be added\nafter col 12 (e.g.
      gene_id,gene_name)."
    inputBinding:
      position: 102
      prefix: --extraFields
  - id: filter_key
    type:
      - 'null'
      - string
    doc: GTF extra field on which to apply the filtering
    inputBinding:
      position: 102
      prefix: --filterKey
  - id: filter_type
    type:
      - 'null'
      - string
    doc: "Comma separated list of filterKey field values to\nretain."
    inputBinding:
      position: 102
      prefix: --filterType
  - id: transcript_feature_name
    type:
      - 'null'
      - string
    doc: "Transcript feature name. Features with this string in\nfield 3 of the GTF
      file will be considered\ntranscripts. (default 'transcript')"
    inputBinding:
      position: 102
      prefix: --transcript_feature_name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedparse:0.2.3--py_0
stdout: bedparse_gtf2bed.out
