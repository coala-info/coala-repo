cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_ncbi_prep_uce_fasta_files_for_ncbi
label: phyluce_phyluce_ncbi_prep_uce_fasta_files_for_ncbi
doc: "use fasta + sqlite to format files for NCBI\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: fastas
    type: Directory
    doc: "The directory containing fasta files"
    inputBinding:
      position: 10
  - id: db
    type: File
    doc: "The db containing UCE matches"
    inputBinding:
      position: 11
  - id: conf
    type: File
    doc: "A configuration file containing general and sample-specific metadata"
    inputBinding:
      position: 12
  - id: outfile
    type: string
    doc: "The outfile fasta to hold results"
    inputBinding:
      position: 13
  - id: start_value
    type:
      - 'null'
      - int
    doc: "The starting index value to append to sequences"
    inputBinding:
      position: 1
      prefix: --start-value
  - id: trinity
    type:
      - 'null'
      - boolean
    doc: "Contigs are from Trinity assemblies"
    inputBinding:
      position: 1
      prefix: --trinity
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: "Do a dry run."
    inputBinding:
      position: 1
      prefix: --dry-run
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_fasta
    type: File
    doc: "The formatted fasta file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_ncbi_prep_uce_fasta_files_for_ncbi.out
