cwlVersion: v1.2
class: CommandLineTool
baseCommand: grammarTrain
label: evofold2_grammarTrain
doc: "grammarTrain estimates transition probabilities (production rule probabilities) of stochastic context free grammars by EM. Currently ama type input data is supported.\n\nTool homepage: https://github.com/jakob-skou-pedersen/phy"
inputs:
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named inside the emit models file (for example phylo model files); staged next to the emit models file because their names are relative to it"
  - id: support_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: "Directories referenced from the model files (for example a data directory with the tree file); staged under their own names"
  - id: tree_file
    type:
      - 'null'
      - File
    doc: "File with Newick tree used with phylo grammars"
    inputBinding:
      position: 1
      prefix: --treeFile
  - id: anno_map_file
    type:
      - 'null'
      - File
    doc: "Anno map file"
    inputBinding:
      position: 2
      prefix: --annoMapFile
  - id: anno_name
    type:
      - 'null'
      - string
    doc: "Name of annotation to use"
    inputBinding:
      position: 3
      prefix: --annoName
  - id: pseudo_counts
    type:
      - 'null'
      - float
    doc: "Total number of pseudocounts used for each transition distribution (default 0)"
    inputBinding:
      position: 4
      prefix: --pseudoCounts
  - id: min_delta_log_lik
    type:
      - 'null'
      - float
    doc: "Stopping criterion of the EM training: stop when the difference in log likelihood is below this value (default 1e-4)"
    inputBinding:
      position: 5
      prefix: --minDeltaLogLik
  - id: max_iter
    type:
      - 'null'
      - int
    doc: "Max number of iterations of the EM training (default 100)"
    inputBinding:
      position: 6
      prefix: --maxIter
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Log file for EM training (default grammarLogFile.txt)"
    inputBinding:
      position: 7
      prefix: --logFile
  - id: output_grammar
    type:
      - 'null'
      - string
    doc: "Output file for the trained grammar (default is stdout)"
    inputBinding:
      position: 8
      prefix: --outputGrammar
  - id: tmp_grammar
    type:
      - 'null'
      - string
    doc: "Output file for the partly trained grammar, written in each iteration (default tmpGrammar.txt)"
    inputBinding:
      position: 9
      prefix: --tmpGrammar
  - id: grammar
    type: File
    doc: "Grammar file"
    inputBinding:
      position: 100
  - id: emit_models
    type: File
    doc: "Emit models file"
    inputBinding:
      position: 101
  - id: alignment_ama
    type: File
    doc: "Alignments in ama format"
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Trained grammar when no output file is given
  - id: trained_grammar
    type:
      - 'null'
      - File
    doc: "Trained grammar"
    outputBinding:
      glob: $(inputs.output_grammar)
  - id: grammar_log
    type:
      - 'null'
      - File
    doc: "Log file of the EM training"
    outputBinding:
      glob: $(inputs.log_file || "grammarLogFile.txt")
  - id: partial_grammar
    type:
      - 'null'
      - File
    doc: "Partly trained grammar"
    outputBinding:
      glob: $(inputs.tmp_grammar || "tmpGrammar.txt")
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.emit_models)
      - $(inputs.support_files || [])
      - $(inputs.support_dirs || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofold2:0.1--0
stdout: evofold2_grammarTrain.out
