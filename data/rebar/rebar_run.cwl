cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rebar
  - run
label: rebar_run
doc: "Detect recombination in a dataset population and/or an input alignment.

Tool homepage: https://github.com/phac-nml/rebar"
inputs:
  - id: dataset_dir
    type: Directory
    doc: "Dataset directory"
    inputBinding:
      position: 1
      prefix: --dataset-dir
  - id: output_dir
    type: string
    doc: "Output directory. It is created if it does not exist"
    inputBinding:
      position: 2
      prefix: --output-dir
  - id: populations
    type:
      - 'null'
      - string
    doc: "Input fasta alignment (as named in the tool help)"
    inputBinding:
      position: 3
      prefix: --populations
  - id: alignment
    type:
      - 'null'
      - File
    doc: "Input dataset population (as named in the tool help); a fasta alignment"
    inputBinding:
      position: 4
      prefix: --alignment
  - id: parents
    type:
      - 'null'
      - string
    doc: "Restrict the parent search to these candidate parents"
    inputBinding:
      position: 5
      prefix: --parents
  - id: knockout
    type:
      - 'null'
      - string
    doc: "Remove these populations (and their descendants) from the dataset"
    inputBinding:
      position: 6
      prefix: --knockout
  - id: mask
    type:
      - 'null'
      - string
    doc: "Number of bases to mask at the 5' and 3' ends, comma separated; 0,0 disables masking (default 100,200)"
    inputBinding:
      position: 7
      prefix: --mask
  - id: max_iter
    type:
      - 'null'
      - int
    doc: "Maximum number of search iterations to find each parent (default 3)"
    inputBinding:
      position: 8
      prefix: --max-iter
  - id: max_parents
    type:
      - 'null'
      - int
    doc: "Maximum number of parents (default 2)"
    inputBinding:
      position: 9
      prefix: --max-parents
  - id: min_parents
    type:
      - 'null'
      - int
    doc: "Minimum number of parents (default 2)"
    inputBinding:
      position: 10
      prefix: --min-parents
  - id: min_consecutive
    type:
      - 'null'
      - int
    doc: "Minimum number of consecutive bases in a parental region (default 3)"
    inputBinding:
      position: 11
      prefix: --min-consecutive
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length of a parental region (default 500)"
    inputBinding:
      position: 12
      prefix: --min-length
  - id: min_subs
    type:
      - 'null'
      - int
    doc: "Minimum number of substitutions in a parental region (default 1)"
    inputBinding:
      position: 13
      prefix: --min-subs
  - id: naive
    type:
      - 'null'
      - boolean
    doc: "Run a naive search that ignores edge cases and known recombinant parents"
    inputBinding:
      position: 14
      prefix: --naive
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of CPU threads to use (default 1)"
    inputBinding:
      position: 15
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "Control output verbosity level (info, warn, debug, error). Default is info"
    inputBinding:
      position: 90
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: run_dir
    type: Directory
    doc: "Run output directory"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
stdout: rebar_run.out
