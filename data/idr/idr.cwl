cwlVersion: v1.2
class: CommandLineTool
baseCommand: idr
label: idr
doc: "The IDR (Irreproducible Discovery Rate) framework is a unified approach to measure
  the reproducibility of findings identified from replicate experiments and provide
  confident biological predictions.\n\nTool homepage: https://github.com/kundajelab/idr"
inputs:
  - id: samples
    type:
      type: array
      items: File
    doc: "Files containing peaks and scores (exactly two files)."
    inputBinding:
      position: 101
      prefix: --samples
  - id: peak_list
    type: ['null', File]
    doc: "If provided, all peaks will be taken from this file."
    inputBinding:
      position: 101
      prefix: --peak-list
  - id: input_file_type
    type: ['null', string]
    doc: "File type of --samples and --peak-list: narrowPeak, broadPeak, bed or gff."
    inputBinding:
      position: 101
      prefix: --input-file-type
  - id: rank
    type: ['null', string]
    doc: "Which column to use to rank peaks: signal.value, p.value, q.value or a column index. Default narrowPeak/broadPeak: signal.value; bed: score."
    inputBinding:
      position: 101
      prefix: --rank
  - id: output_file_type
    type: ['null', string]
    doc: "Output file type (narrowPeak, broadPeak, bed). Defaults to the input file type when available, otherwise bed."
    inputBinding:
      position: 101
      prefix: --output-file-type
  - id: idr_threshold
    type: ['null', double]
    doc: "Only return peaks with a global idr threshold below this value. Default: report all peaks"
    inputBinding:
      position: 101
      prefix: --idr-threshold
  - id: soft_idr_threshold
    type: ['null', double]
    doc: "Report statistics for peaks with a global idr below this value but return all peaks with an idr below --idr. Default: 0.05"
    inputBinding:
      position: 101
      prefix: --soft-idr-threshold
  - id: use_old_output_format
    type: ['null', boolean]
    doc: "Use old output format."
    inputBinding:
      position: 101
      prefix: --use-old-output-format
  - id: plot
    type: ['null', boolean]
    doc: "Plot the results to [OFNAME].png"
    inputBinding:
      position: 101
      prefix: --plot
  - id: use_nonoverlapping_peaks
    type: ['null', boolean]
    doc: "Use peaks without an overlapping match and set the value to 0."
    inputBinding:
      position: 101
      prefix: --use-nonoverlapping-peaks
  - id: peak_merge_method
    type: ['null', string]
    doc: "Which method to use for merging peaks (sum, avg, min, max). Default: sum for signal/score/column indexes, min for p/q-value."
    inputBinding:
      position: 101
      prefix: --peak-merge-method
  - id: initial_mu
    type: ['null', double]
    doc: "Initial value of mu. Default: 0.10"
    inputBinding:
      position: 101
      prefix: --initial-mu
  - id: initial_sigma
    type: ['null', double]
    doc: "Initial value of sigma. Default: 1.00"
    inputBinding:
      position: 101
      prefix: --initial-sigma
  - id: initial_rho
    type: ['null', double]
    doc: "Initial value of rho. Default: 0.20"
    inputBinding:
      position: 101
      prefix: --initial-rho
  - id: initial_mix_param
    type: ['null', double]
    doc: "Initial value of the mixture params. Default: 0.50"
    inputBinding:
      position: 101
      prefix: --initial-mix-param
  - id: fix_mu
    type: ['null', boolean]
    doc: "Fix mu to the starting point and do not let it vary."
    inputBinding:
      position: 101
      prefix: --fix-mu
  - id: fix_sigma
    type: ['null', boolean]
    doc: "Fix sigma to the starting point and do not let it vary."
    inputBinding:
      position: 101
      prefix: --fix-sigma
  - id: dont_filter_peaks_below_noise_mean
    type: ['null', boolean]
    doc: "Allow signal points that are below the noise mean (should only be used if you know what you are doing)."
    inputBinding:
      position: 101
      prefix: --dont-filter-peaks-below-noise-mean
  - id: use_best_multisummit_idr
    type: ['null', boolean]
    doc: "Set the IDR value for a group of multi summit peaks to the best value across all of these peaks."
    inputBinding:
      position: 101
      prefix: --use-best-multisummit-IDR
  - id: allow_negative_scores
    type: ['null', boolean]
    doc: "Allow negative values for scores. (should only be used if you know what you are doing)"
    inputBinding:
      position: 101
      prefix: --allow-negative-scores
  - id: random_seed
    type: ['null', int]
    doc: "The random seed value (for breaking ties). Default: 0"
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: max_iter
    type: ['null', int]
    doc: "The maximum number of optimization iterations. Default: 3000"
    inputBinding:
      position: 101
      prefix: --max-iter
  - id: convergence_eps
    type: ['null', double]
    doc: "The maximum change in parameter value changes for convergence. Default: 1.00e-06"
    inputBinding:
      position: 101
      prefix: --convergence-eps
  - id: only_merge_peaks
    type: ['null', boolean]
    doc: "Only return the merged peak list."
    inputBinding:
      position: 101
      prefix: --only-merge-peaks
  - id: verbose
    type: ['null', boolean]
    doc: "Print out additional debug information"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: quiet
    type: ['null', boolean]
    doc: "Don't print any status messages"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: log_output_file_path
    type: ['null', string]
    doc: "File to write the log to. Default: stderr"
    inputBinding:
      position: 102
      prefix: --log-output-file
  - id: output_file_path
    type: string
    default: idrValues.txt
    doc: "File to write output to."
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: File with the IDR results.
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: log_output_file
    type: ['null', File]
    doc: Log file (only when a log file path is given).
    outputBinding:
      glob: $(inputs.log_output_file_path)
  - id: plot_png
    type: ['null', File]
    doc: Plot of the results (only with plot).
    outputBinding:
      glob: $(inputs.output_file_path).png
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idr:2.0.4.2--py39h031d066_12
