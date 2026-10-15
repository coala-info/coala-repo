cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_run_raxml_multilocus_bootstraps
label: phyluce_phyluce_genetrees_run_raxml_multilocus_bootstraps
doc: "Performs multi-locus bootstrapping and ML tree searches for a folder of phylip-formatted alignments\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: Directory
    doc: "The input directory containing alignments in phylip format"
    inputBinding:
      position: 1
      prefix: --input
  - id: best_trees
    type: Directory
    doc: "The directory containing the best trees"
    inputBinding:
      position: 2
      prefix: --best-trees
  - id: output
    type: string
    doc: "The output directory to hold alignments"
    inputBinding:
      position: 3
      prefix: --output
  - id: bootreps
    type:
      - 'null'
      - int
    doc: "The number of bootstrap replicates to run"
    inputBinding:
      position: 4
      prefix: --bootreps
  - id: outgroup
    type:
      - 'null'
      - string
    doc: "The outgroup to use"
    inputBinding:
      position: 5
      prefix: --outgroup
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of RAxML threads to run (best to determine empirically)"
    inputBinding:
      position: 6
      prefix: --threads
  - id: cores
    type:
      - 'null'
      - int
    doc: "The number of concurrent RAxML jobs to run"
    inputBinding:
      position: 7
      prefix: --cores
  - id: quiet
    type:
      - 'null'
      - boolean
    default: true
    doc: "Suppress the CPU usage question. The program asks the question on every run, so this defaults to true."
    inputBinding:
      position: 8
      prefix: --quiet
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
    doc: "The output directory with one RAxML result folder per alignment and one boot### file per multi-locus replicate."
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout_log
    type: File
    doc: "Standard output of the program."
    outputBinding:
      glob: "raxml_multilocus_bootstraps.stdout.txt"
stdout: raxml_multilocus_bootstraps.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.log_path ? {"class": "Directory", "basename": inputs.log_path, "listing": []} : null)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
