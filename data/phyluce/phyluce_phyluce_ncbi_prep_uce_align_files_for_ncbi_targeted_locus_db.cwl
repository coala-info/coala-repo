cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_ncbi_prep_uce_align_files_for_ncbi_targeted_locus_db
label: phyluce_phyluce_ncbi_prep_uce_align_files_for_ncbi_targeted_locus_db
doc: "Format a monolithic NCBI fasta file for tbl2asn from alignments\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing alignments"
    inputBinding:
      position: 1
      prefix: --alignments
  - id: conf
    type: File
    doc: "The config file name"
    inputBinding:
      position: 1
      prefix: --conf
  - id: output
    type: string
    doc: "The directory in which to store output files"
    inputBinding:
      position: 1
      prefix: --output
  - id: input_format
    type:
      - 'null'
      - string
    doc: "The input alignment format (fasta, nexus, phylip, phylip-relaxed, clustal, emboss or stockholm)"
    inputBinding:
      position: 1
      prefix: --input-format
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
  - id: output_dir
    type: Directory
    doc: "The directory holding the .fsa and .tbl files"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_ncbi_prep_uce_align_files_for_ncbi_targeted_locus_db.out
