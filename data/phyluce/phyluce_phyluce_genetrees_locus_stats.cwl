cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_locus_stats
label: phyluce_phyluce_genetrees_locus_stats
doc: "Program description\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: config
    type: File
    doc: "The gene tree configuration file"
    inputBinding:
      position: 1
      prefix: --config
  - id: alignments
    type: Directory
    doc: "Alignment files to process"
    inputBinding:
      position: 2
      prefix: --alignments
  - id: input_format
    type:
      - 'null'
      - string
    doc: "The input alignment format. One of fasta, nexus, phylip, clustal, emboss, stockholm."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use. One of INFO, WARN, CRITICAL."
    inputBinding:
      position: 4
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory is created in the working directory before the run."
    inputBinding:
      position: 5
      prefix: --log-path
  - id: cores
    type:
      - 'null'
      - int
    doc: "Process alignments in parallel using --cores for alignment. This is the number of PHYSICAL CPUs."
    inputBinding:
      position: 6
      prefix: --cores
outputs:
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: "The directory that holds the logs."
    outputBinding:
      glob: "$(inputs.log_path)"
  - id: locus_stats
    type: File
    doc: "Standard output of the program."
    outputBinding:
      glob: "locus_stats.txt"
stdout: locus_stats.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.log_path ? {"class": "Directory", "basename": inputs.log_path, "listing": []} : null)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
