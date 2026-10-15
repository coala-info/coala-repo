cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_generate_multilocus_bootstrap_count
label: phyluce_phyluce_genetrees_generate_multilocus_bootstrap_count
doc: "Performs multi-locus bootstrapping and ML tree searches for a folder of phylip-formatted alignments\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The input directory containing alignments in phylip format"
    inputBinding:
      position: 1
      prefix: --alignments
  - id: bootstrap_replicates
    type: string
    doc: "The file that will hold bootstrap replicates sampling"
    inputBinding:
      position: 2
      prefix: --bootstrap_replicates
  - id: directory
    type:
      - 'null'
      - string
    doc: "Optional path to directory containing alignments. Defaults to alignment directory if not provided."
    inputBinding:
      position: 3
      prefix: --directory
  - id: bootstrap_counts
    type: string
    doc: "The CSV file that will hold bootstrap replicate counts for each locus"
    inputBinding:
      position: 4
      prefix: --bootstrap_counts
  - id: bootreps
    type:
      - 'null'
      - int
    doc: "The number of bootstrap replicates to run"
    inputBinding:
      position: 5
      prefix: --bootreps
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use. One of INFO, WARN, CRITICAL."
    inputBinding:
      position: 6
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory is created in the working directory before the run."
    inputBinding:
      position: 7
      prefix: --log-path
outputs:
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: "The directory that holds the logs."
    outputBinding:
      glob: "$(inputs.log_path)"
  - id: bootstrap_replicates_file
    type: File
    doc: "The file holding the bootstrap replicate sampling (Python pickle)."
    outputBinding:
      glob: "$(inputs.bootstrap_replicates)"
  - id: bootstrap_counts_file
    type: File
    doc: "The CSV file with the bootstrap replicate count for each locus."
    outputBinding:
      glob: "$(inputs.bootstrap_counts)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.log_path ? {"class": "Directory", "basename": inputs.log_path, "listing": []} : null)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
