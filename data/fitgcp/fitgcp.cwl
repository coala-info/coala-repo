cwlVersion: v1.2
class: CommandLineTool
baseCommand: fitgcp
label: fitgcp
doc: Fits mixtures of probability distributions to genome coverage profiles using
  an EM-like iterative algorithm. The script uses a SAM file as input and parses the
  mapping information and creates a Genome Coverage Profile (GCP).
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_file)
        writable: true
  - class: InlineJavascriptRequirement
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
        inputBinding:
          prefix: --alpha
    doc: 'Specifies the initial values for the proportion alpha of each distribution.
      Usage: For three distributions -a 0.3 -a 0.3 specifies the proportions 0.3,
      0.3 and 0.4.'
    inputBinding:
      position: 102
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Specifies a coverage cutoff quantile such that only coverage values below
      this quantile are considered.
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: distributions
    type:
      - 'null'
      - string
    doc: 'Distributions to fit. z->zero; n: nbinom (MOM); N: nbinom (MLE); p:binom;
      t: tail.'
    inputBinding:
      position: 102
      prefix: --distributions
  - id: iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations.
    inputBinding:
      position: 102
      prefix: --iterations
  - id: log
    type:
      - 'null'
      - boolean
    doc: Enable logging.
    inputBinding:
      position: 102
      prefix: --log
  - id: means
    type:
      - 'null'
      - type: array
        items: float
        inputBinding:
          prefix: --means
    doc: 'Specifies the initial values for the mean of each Poisson or Negative Binomial
      distribution. Usage: -m 12.4 -m 16.1'
    inputBinding:
      position: 102
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Create a plot of the fitted mixture model.
    inputBinding:
      position: 102
      prefix: --plot
  - id: threshold
    type:
      - 'null'
      - float
    doc: Set the convergence threshold for the iteration. Stop if the change between
      two iterations is less than THR.
    inputBinding:
      position: 102
      prefix: --threshold
  - id: view
    type:
      - 'null'
      - boolean
    doc: Only view the GCP. Do not fit any distribution. Respects cutoff (-c).
    inputBinding:
      position: 102
      prefix: --view
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_files
    type:
      type: array
      items: File
    doc: Fit parameters, log file, GCP file and plot written next to the SAM file
    outputBinding:
      glob: $(inputs.sam_file.nameroot)*
      outputEval: "$(self.filter(function(f){return f.basename !== inputs.sam_file.basename;}))"
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fitgcp:v0.0.20150429-2-deb_cv1
stdout: fitgcp.out
