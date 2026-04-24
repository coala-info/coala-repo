cwlVersion: v1.2
class: CommandLineTool
baseCommand: freddie_segment.py
label: freddie_freddie_segment.py
doc: "Cluster aligned reads into isoforms\n\nTool homepage: https://github.com/vpc-ccg/freddie"
inputs:
  - id: consider_ends
    type:
      - 'null'
      - boolean
    doc: Consider the start and end splice sites in segmentation
    inputBinding:
      position: 101
      prefix: --consider-ends
  - id: max_problem_size
    type:
      - 'null'
      - int
    doc: Maximum number of candidate breakpoints allowed per segmentation 
      problem
    inputBinding:
      position: 101
      prefix: --max-problem-size
  - id: min_read_support_outside
    type:
      - 'null'
      - int
    doc: Minimum reads support for splice site to support a breakpoint
    inputBinding:
      position: 101
      prefix: --min-read-support-outside
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: sigma
    type:
      - 'null'
      - float
    doc: Sigma value for gaussian_filter1d
    inputBinding:
      position: 101
      prefix: --sigma
  - id: split_dir
    type: Directory
    doc: Path to Freddie split directory of the reads
    inputBinding:
      position: 101
      prefix: --split-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for multiprocessing.
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold_rate
    type:
      - 'null'
      - float
    doc: 'Threshold rate above which the read will be considered as covering a segment.
      Low threshold is 1-threshold_rate. Anything in between is considered ambigious.
      Note: the stricter threshold for a given segment length will be used.'
    inputBinding:
      position: 101
      prefix: --threshold-rate
  - id: variance_factor
    type:
      - 'null'
      - float
    doc: The stdev factor to fix a candidate peak. The threshold is set as > 
      mean(non-zero support for splicing 
      postions)+variance_factor*stdev(non-zero support for splicing postions).
    inputBinding:
      position: 101
      prefix: --variance-factor
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freddie:0.4--hdfd78af_0
stdout: freddie_freddie_segment.py.out
