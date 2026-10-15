cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_match_contigs_to_barcodes
label: phyluce_phyluce_assembly_match_contigs_to_barcodes
doc: "Match a folder of contig files against a barcode sequence(s) for a given group of taxa\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: contigs
    type: Directory
    doc: "The directory containing the assembled contigs in which you are searching for UCE loci."
    inputBinding:
      position: 1
      prefix: --contigs
  - id: barcodes
    type: File
    doc: "A FASTA-formatted file of barcode(s)."
    inputBinding:
      position: 1
      prefix: --barcodes
  - id: output
    type: string
    doc: "The directory in which to store the resulting SQL database and LASTZ files."
    inputBinding:
      position: 1
      prefix: --output
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use (INFO, WARN or CRITICAL)."
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory must already exist."
    inputBinding:
      position: 1
      prefix: --log-path
  - id: no_bold
    type:
      - 'null'
      - boolean
    doc: "Don't run matches against BOLD"
    inputBinding:
      position: 1
      prefix: --no-bold
  - id: database
    type:
      - 'null'
      - string
    doc: "The COI database to use (COX1, COX1_SPECIES or COX1_SPECIES_PUBLIC). Defaults to all BOLD records for COI > 500 bp."
    inputBinding:
      position: 1
      prefix: --database
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_dir
    type: Directory
    doc: "The directory holding the lastz files and barcode slices"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_match_contigs_to_barcodes.out
