cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_snp_screen_phased_alignments
label: phyluce_phyluce_snp_screen_phased_alignments
doc: "Program description\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing the alignment files"
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The directory in which to store the output files"
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type:
      - 'null'
      - string
    doc: "The input alignment format. One of fasta, nexus, phylip, clustal, emboss, stockholm."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: output_format
    type:
      - 'null'
      - string
    doc: "The input alignment format. One of fasta, nexus, phylip, clustal, emboss, stockholm."
    inputBinding:
      position: 4
      prefix: --output-format
  - id: include_missing
    type:
      - 'null'
      - boolean
    doc: "Include sites within missing/ambiguous information (-, ?, N, X)"
    inputBinding:
      position: 5
      prefix: --include-missing
  - id: random
    type:
      - 'null'
      - boolean
    doc: "Pick one random site from each locus"
    inputBinding:
      position: 6
      prefix: --random
  - id: numerical_encoding
    type:
      - 'null'
      - boolean
    doc: "Output SNP calls encoded as 0 (ref/ref), 1 (ref/alt), or 2 (alt/alt)"
    inputBinding:
      position: 7
      prefix: --numerical-encoding
  - id: cores
    type:
      - 'null'
      - int
    doc: "Process alignments in parallel using --cores for alignment. This is the number of PHYSICAL CPUs."
    inputBinding:
      position: 8
      prefix: --cores
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use. One of INFO, WARN, CRITICAL."
    inputBinding:
      position: 9
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory is created in the working directory before the run."
    inputBinding:
      position: 10
      prefix: --log-path
outputs:
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: "The directory that holds the logs."
    outputBinding:
      glob: "$(inputs.log_path)"
  - id: output_dir
    type: Directory
    doc: "The output directory with the SNP-only alignments."
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout_log
    type: File
    doc: "Standard output of the program."
    outputBinding:
      glob: "screen_phased_alignments.stdout.txt"
stdout: screen_phased_alignments.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.log_path ? {"class": "Directory", "basename": inputs.log_path, "listing": []} : null)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
