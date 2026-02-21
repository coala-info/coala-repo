cwlVersion: v1.2
class: CommandLineTool
baseCommand: fitgcp
label: fitgcp
doc: Fits mixtures of probability distributions to genome coverage profiles using
  an EM-like iterative algorithm. The script uses a SAM file as input and parses the
  mapping information and creates a Genome Coverage Profile (GCP).
inputs:
  - id: sam_file
    type: File
    doc: Name of SAM file to analyze.
    inputBinding:
      position: 1
  - id: alpha
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Specifies the initial values for the proportion alpha of each distribution.
      Usage: For three distributions -a 0.3 -a 0.3 specifies the proportions 0.3,
      0.3 and 0.4.'
    inputBinding:
      position: 102
      prefix: --alpha
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Specifies a coverage cutoff quantile such that only coverage values below
      this quantile are considered.
    default: 0.95
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: distributions
    type:
      - 'null'
      - string
    doc: 'Distributions to fit. z->zero; n: nbinom (MOM); N: nbinom (MLE); p:binom;
      t: tail.'
    default: zn
    inputBinding:
      position: 102
      prefix: --distributions
  - id: iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations.
    default: 50
    inputBinding:
      position: 102
      prefix: --iterations
  - id: log
    type:
      - 'null'
      - boolean
    doc: Enable logging.
    default: false
    inputBinding:
      position: 102
      prefix: --log
  - id: means
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Specifies the initial values for the mean of each Poisson or Negative Binomial
      distribution. Usage: -m 12.4 -m 16.1'
    inputBinding:
      position: 102
      prefix: --means
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Create a plot of the fitted mixture model.
    default: false
    inputBinding:
      position: 102
      prefix: --plot
  - id: threshold
    type:
      - 'null'
      - float
    doc: Set the convergence threshold for the iteration. Stop if the change between
      two iterations is less than THR.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --threshold
  - id: view
    type:
      - 'null'
      - boolean
    doc: Only view the GCP. Do not fit any distribution. Respects cutoff (-c).
    default: false
    inputBinding:
      position: 102
      prefix: --view
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fitgcp:v0.0.20150429-2-deb_cv1
stdout: fitgcp.out
