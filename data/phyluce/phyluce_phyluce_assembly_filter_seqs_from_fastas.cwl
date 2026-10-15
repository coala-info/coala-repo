cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_filter_seqs_from_fastas
label: phyluce_phyluce_assembly_filter_seqs_from_fastas
doc: "Removes sequences that are shorter than a specified proportion of the median length of sequences in an alignment.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: Directory
    doc: "The directory containing the FASTA sequences to filter."
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "An output directory to hold the converted alignments."
    inputBinding:
      position: 1
      prefix: --output
  - id: filtered_sequences_file
    type: string
    doc: "The file that will contain names of sequences (and loci) removed"
    inputBinding:
      position: 1
      prefix: --filtered-sequences-file
  - id: cores
    type:
      - 'null'
      - int
    doc: "The number of compute cores to use"
    inputBinding:
      position: 1
      prefix: --cores
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
  - id: trim_length
    type:
      - 'null'
      - boolean
    doc: "Remove sequences shorter than a proportion of the median length of the locus (one of --trim-length or --trim-count is required)"
    inputBinding:
      position: 1
      prefix: --trim-length
  - id: trim_count
    type:
      - 'null'
      - boolean
    doc: "Remove loci with too few sequences (one of --trim-length or --trim-count is required)"
    inputBinding:
      position: 1
      prefix: --trim-count
  - id: proportion
    type:
      - 'null'
      - float
    doc: "Proportion of the median length that will serve as cut off (default=0.5)"
    inputBinding:
      position: 1
      prefix: --proportion
  - id: count
    type:
      - 'null'
      - int
    doc: "Number of sequences per locus that will serve as cut off (default=4)."
    inputBinding:
      position: 1
      prefix: --count
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_dir
    type: Directory
    doc: "The directory holding the filtered fasta files"
    outputBinding:
      glob: $(inputs.output)
  - id: filtered_sequences
    type: File
    doc: "The file with the names of the removed sequences (or loci)"
    outputBinding:
      glob: $(inputs.filtered_sequences_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_filter_seqs_from_fastas.out
