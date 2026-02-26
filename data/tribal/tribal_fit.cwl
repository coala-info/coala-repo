cwlVersion: v1.2
class: CommandLineTool
baseCommand: tribal fit
label: tribal_fit
doc: "Fit B cell lineage trees\n\nTool homepage: https://github.com/elkebir-group/TRIBAL"
inputs:
  - id: clonotypes
    type: File
    doc: path to pickled clonotypes dictionary of parsimony forests, alignments,
      and isotypes
    inputBinding:
      position: 101
      prefix: --clonotypes
  - id: cores
    type:
      - 'null'
      - int
    doc: number of cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: max_cand
    type:
      - 'null'
      - int
    doc: max candidate tree size per clonotype
    inputBinding:
      position: 101
      prefix: --max-cand
  - id: mode
    type:
      - 'null'
      - string
    doc: mode for fitting B cell lineage trees, one of 'refinment' or 'score'
    inputBinding:
      position: 101
      prefix: --mode
  - id: n_isotypes
    type: int
    doc: the number of isotypes states to use
    inputBinding:
      position: 101
      prefix: --n_isotypes
  - id: niter
    type:
      - 'null'
      - int
    doc: max number of iterations during fitting
    inputBinding:
      position: 101
      prefix: --niter
  - id: restarts
    type:
      - 'null'
      - int
    doc: number of restarts
    inputBinding:
      position: 101
      prefix: --restarts
  - id: score
    type:
      - 'null'
      - File
    doc: filename where the objective values file should be saved
    inputBinding:
      position: 101
      prefix: --score
  - id: seed
    type:
      - 'null'
      - int
    doc: random number seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: stay_prob
    type:
      - 'null'
      - string
    doc: 'the lower and upper bound of not class switching, example: 0.55,0.95'
    inputBinding:
      position: 101
      prefix: --stay-prob
  - id: thresh
    type:
      - 'null'
      - string
    doc: theshold for convergence in during fitting
    inputBinding:
      position: 101
      prefix: --thresh
  - id: transmat
    type:
      - 'null'
      - File
    doc: optional filename of isotype transition probabilities
    inputBinding:
      position: 101
      prefix: --transmat
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print additional messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: transmat_infer
    type:
      - 'null'
      - File
    doc: filename where the inferred transition matrix should be saved
    outputBinding:
      glob: $(inputs.transmat_infer)
  - id: pickle
    type:
      - 'null'
      - File
    doc: path where the output dictionary of LineageTree lists should be pickled
    outputBinding:
      glob: $(inputs.pickle)
  - id: write_results
    type:
      - 'null'
      - File
    doc: path where all optimal solution results are saved
    outputBinding:
      glob: $(inputs.write_results)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tribal:0.1.1--py310hdbdd923_1
