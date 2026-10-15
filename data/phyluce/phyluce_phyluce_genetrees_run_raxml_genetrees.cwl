cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_run_raxml_genetrees
label: phyluce_phyluce_genetrees_run_raxml_genetrees
doc: "Performs ML tree search on a folder of phylip-formatted alignments using RAxML\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: Directory
    doc: "The input directory containing alignments in phylip format"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "The output directory to hold alignments"
    inputBinding:
      position: 2
      prefix: --output
  - id: outgroup
    type:
      - 'null'
      - string
    doc: "The outgroup to use"
    inputBinding:
      position: 3
      prefix: --outgroup
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of RAxML threads to run (best to determine empirically)"
    inputBinding:
      position: 4
      prefix: --threads
  - id: tree_searches
    type:
      - 'null'
      - int
    doc: "The number of tree searches to run."
    inputBinding:
      position: 5
      prefix: --tree-searches
  - id: cores
    type:
      - 'null'
      - int
    doc: "The number of concurrent RAxML jobs to run"
    inputBinding:
      position: 6
      prefix: --cores
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress the CPU usage question"
    inputBinding:
      position: 7
      prefix: --quiet
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use. One of INFO, WARN, CRITICAL."
    inputBinding:
      position: 8
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory is created in the working directory before the run."
    inputBinding:
      position: 9
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
    doc: "The output directory with one RAxML result folder per alignment."
    outputBinding:
      glob: "$(inputs.output)"
  - id: all_best_trees
    type:
      - 'null'
      - File
    doc: "The best tree of every alignment, one per line."
    outputBinding:
      glob: "$(inputs.output)/all-best-trees.tre"
  - id: stdout_log
    type: File
    doc: "Standard output of the program (run time and pattern count per alignment)."
    outputBinding:
      glob: "raxml_genetrees.stdout.txt"
stdout: raxml_genetrees.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.log_path ? {"class": "Directory", "basename": inputs.log_path, "listing": []} : null)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
