cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_extract_contigs_to_barcodes
label: phyluce_phyluce_assembly_extract_contigs_to_barcodes
doc: "Parse the log file from match_contigs_to_barcodes to output a table of results\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: contigs
    type: Directory
    doc: "The directory containing the assembled contigs."
    inputBinding:
      position: 1
      prefix: --contigs
  - id: config
    type: File
    doc: "A config file containing the contigs to extract."
    inputBinding:
      position: 1
      prefix: --config
  - id: output
    type: string
    doc: "The output FASTA file to create"
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
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_fasta
    type: File
    doc: "The output FASTA file with the extracted contigs"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_extract_contigs_to_barcodes.out
