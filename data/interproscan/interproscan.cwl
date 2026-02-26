cwlVersion: v1.2
class: CommandLineTool
baseCommand: interproscan.sh
label: interproscan
doc: "InterProScan is a batch tool to scan sequences (protein and nucleic acid) against
  InterPro's signatures.\n\nTool homepage: https://github.com/ebi-pf-team/interproscan"
inputs:
  - id: applications
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of analysis applications to run. Default is all.
    inputBinding:
      position: 101
      prefix: --applications
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of processors to use.
    inputBinding:
      position: 101
      prefix: --cpu
  - id: disable_precalc
    type:
      - 'null'
      - boolean
    doc: Disable use of the InterProScan lookup service.
    inputBinding:
      position: 101
      prefix: --disable-precalc
  - id: formats
    type:
      - 'null'
      - type: array
        items: string
    doc: Case-insensitive, comma-separated list of output formats (e.g., TSV, 
      XML, GFF3, JSON, SVG, HTML).
    inputBinding:
      position: 101
      prefix: --formats
  - id: goterms
    type:
      - 'null'
      - boolean
    doc: Switch on lookup of Gene Ontology (GO) terms.
    inputBinding:
      position: 101
      prefix: --goterms
  - id: input
    type: File
    doc: Input data. Sequence file or directory of sequence files.
    inputBinding:
      position: 101
      prefix: --input
  - id: iprlookup
    type:
      - 'null'
      - boolean
    doc: Switch on lookup of corresponding InterPro annotation.
    inputBinding:
      position: 101
      prefix: --iprlookup
  - id: pathways
    type:
      - 'null'
      - boolean
    doc: Switch on lookup of pathway information.
    inputBinding:
      position: 101
      prefix: --pathways
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: Directory to be used for temporary files.
    inputBinding:
      position: 101
      prefix: --temp-directory
outputs:
  - id: output_file_base
    type:
      - 'null'
      - File
    doc: Optional output file base name. If not provided, the input file name is
      used.
    outputBinding:
      glob: $(inputs.output_file_base)
  - id: outfile
    type:
      - 'null'
      - File
    doc: Explicit output file name. Only valid if a single output format is 
      specified.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/interproscan:5.59-91.0
