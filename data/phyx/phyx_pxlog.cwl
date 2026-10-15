cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxlog]
label: phyx_pxlog
doc: |-
  MCMC log file manipulator.
  Can combine and resample parameters or trees across files.
  Log files need not contain the same number of samples.
  Input files may be indicated using wildcards e.g. '*.trees'
  Parameter log files are expected to be whitespace delimited.
  *NOTE* All values are in terms of number of SAMPLES (NOT generations).

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: parm_files
    type: ['null', {type: array, items: File, inputBinding: {prefix: -p}}]
    doc: "input parameter log file(s)"
  - id: tree_files
    type: ['null', {type: array, items: File, inputBinding: {prefix: -t}}]
    doc: "input tree log file(s)"
  - id: out_file_path
    type: ['null', string]
    doc: "output file name (standard output otherwise)"
    inputBinding:
      prefix: -o
  - id: burnin
    type: ['null', int]
    doc: "number of samples to exclude at the beginning of a file"
    inputBinding:
      prefix: -b
  - id: thin
    type: ['null', int]
    doc: "interval of resampling"
    inputBinding:
      prefix: -n
  - id: rand
    type: ['null', int]
    doc: "number of random samples (without replacement) not yet implemented!"
    inputBinding:
      prefix: -r
  - id: info
    type: ['null', boolean]
    doc: "calculate log file attributes and exit"
    inputBinding:
      prefix: -i
  - id: columns
    type: ['null', boolean]
    doc: "print out column names (parameter logs only)"
    inputBinding:
      prefix: -c
  - id: delete
    type: ['null', string]
    doc: "delete columns by 1-index sep by commas (NO SPACES!) (parameter logs only)"
    inputBinding:
      prefix: -d
  - id: keep
    type: ['null', string]
    doc: "keep only columns by 1-index sep by commas (NO SPACES!) (parameter logs only)"
    inputBinding:
      prefix: -k
  - id: seed
    type: ['null', int]
    doc: "random number seed, clock otherwise"
    inputBinding:
      prefix: -x
  - id: verbose
    type: ['null', boolean]
    doc: "make the output more verbose"
    inputBinding:
      prefix: -v
outputs:
  - id: out_file
    type: ['null', File]
    doc: "resampled log file (only when an output name is given)"
    outputBinding:
      glob: $(inputs.out_file_path)
  - id: stdout_text
    type: stdout
    doc: "standard output (log file attributes with --info, column names with --columns, messages)"
stdout: pxlog.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
