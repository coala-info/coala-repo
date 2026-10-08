cwlVersion: v1.2
class: CommandLineTool
baseCommand: finestructuregreedy.sh
label: finestructure_greedy
doc: "Greedy maximisation with fineSTRUCTURE: repeats fineSTRUCTURE MCMC runs until
  successive runs find the same population assignment, then computes the tree once at
  the end.\n\nTool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: datafile
    type: File
    doc: Chunk-count matrix (for example the chunkcounts.out file from ChromoPainter)
    inputBinding:
      position: 2
  - id: outputfile
    type: string
    doc: Output file name; it must end in .xml
    inputBinding:
      position: 3
  - id: repeats
    type:
      - 'null'
      - int
    doc: Number of repeated fineSTRUCTURE runs to perform before giving in (default
      20)
    inputBinding:
      position: 1
      prefix: -m
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of fineSTRUCTURE iterations to perform per step (finestructure -x
      flag; default 50000)
    inputBinding:
      position: 1
      prefix: -x
  - id: tree_steps
    type:
      - 'null'
      - int
    doc: fineSTRUCTURE -t flag (default 100000000, effectively infinite; may be slow)
    inputBinding:
      position: 1
      prefix: -t
  - id: finestructure_flags
    type:
      - 'null'
      - string
    doc: fineSTRUCTURE flags to be passed to all runs, for example "-X -Y". Usually
      not needed.
    inputBinding:
      position: 1
      prefix: -a
  - id: finestructure_executable
    type:
      - 'null'
      - string
    doc: Location of the fineSTRUCTURE executable (default finestructure)
    inputBinding:
      position: 1
      prefix: -f
  - id: replace_temporary
    type:
      - 'null'
      - boolean
    doc: Replace temporary files. Without this you can run more iterations by
      changing -m and -x.
    inputBinding:
      position: 1
      prefix: -r
  - id: remove_tree
    type:
      - 'null'
      - boolean
    doc: Delete the final tree file if present. The default is not to.
    inputBinding:
      position: 1
      prefix: -R
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Perform a dry run without running anything; useful to see the fineSTRUCTURE
      arguments used in each step
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Output XML file and intermediate files written with the output name
    outputBinding:
      glob: $(inputs.outputfile.replace(/\.xml$/, ""))*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
