cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_run_raxml_bootstraps
label: phyluce_phyluce_genetrees_run_raxml_bootstraps
doc: "Program description\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing alignments to be summarized."
    inputBinding:
      position: 1
      prefix: --alignments
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
outputs:
  - id: output_dir
    type: Directory
    doc: "The output directory with one RAxML result folder per alignment."
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout_log
    type: File
    doc: "Standard output of the program."
    outputBinding:
      glob: "raxml_bootstraps.stdout.txt"
stdout: raxml_bootstraps.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
