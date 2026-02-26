cwlVersion: v1.2
class: CommandLineTool
baseCommand: emirge_rename_fasta.py
label: emirge_emirge_rename_fasta.py
doc: "Rewrites an emirge fasta file to include proper sequence names and prior probabilities
  (abundance estimates) in the record headers, and sorts the sequences from most to
  least abundant\n\nTool homepage: https://github.com/csmiller/EMIRGE"
inputs:
  - id: iter_dir
    type:
      - 'null'
      - Directory
    doc: 'One of the iteration directories created by emirge (for example: emirge_working_dir/iter.40).
      If no iter.DIR is given, emirge_rename_fasta.py assumes that iter.DIR is the
      current working directory.'
    inputBinding:
      position: 1
  - id: no_N
    type:
      - 'null'
      - boolean
    doc: "Don't change bases with no read support to N. Caution: these bases are not
      supported by reads in the input data, but will usually be from a closely related
      sequence."
    inputBinding:
      position: 102
      prefix: --no_N
  - id: no_trim_N
    type:
      - 'null'
      - boolean
    doc: Don't trim off N bases with no read support from ends of sequences. 
      Ignored if --no_N is also passed
    inputBinding:
      position: 102
      prefix: --no_trim_N
  - id: prob_min
    type:
      - 'null'
      - float
    doc: Only include sequences in output with prior probability above PROB_MIN
    default: include all sequences
    inputBinding:
      position: 102
      prefix: --prob_min
  - id: record_prefix
    type:
      - 'null'
      - string
    doc: Add the specified prefix to each fasta record title
    inputBinding:
      position: 102
      prefix: --record_prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emirge:0.61.1--py27_1
stdout: emirge_emirge_rename_fasta.py.out
