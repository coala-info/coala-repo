cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_get_aligns_partitioned_by_cluster]
label: phyluce_phyluce_align_get_aligns_partitioned_by_cluster
doc: "Given an input cluster CSV file, partition the input alignments by their cluster in the CSV file.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing the alignment files."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: cluster_csv
    type: File
    doc: "The cluster CSV file."
    inputBinding:
      position: 2
      prefix: --cluster-csv
  - id: output
    type: string
    doc: "An output directory to hold the converted alignments."
    inputBinding:
      position: 3
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, phylip-relaxed, phylip-sequential, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 4
      prefix: --input-format
  - id: output_format
    type: ['null', string]
    doc: "The output alignment format. One of: fasta, nexus, phylip, phylip-relaxed, phylip-sequential, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 5
      prefix: --output-format
  - id: cores
    type: ['null', int]
    doc: "The number of cores to use."
    inputBinding:
      position: 6
      prefix: --cores
  - id: verbosity
    type: ['null', string]
    doc: "The logging level to use (INFO, WARN, CRITICAL)."
    inputBinding:
      position: 7
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: "The path to an existing directory to hold logs."
    inputBinding:
      position: 8
      prefix: --log-path
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of alignments, one per cluster."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
