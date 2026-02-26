cwlVersion: v1.2
class: CommandLineTool
baseCommand: yapc
label: yapc
doc: "An adhoc peak caller for genomic high-throughput sequencing data such as ATAC-seq,
  DNase-seq or ChIP-seq. Specifically written for the purpose of capturing representative
  peaks of characteristic width in a time series data set with two biological replicates
  per time point. Briefly, candidate peak locations are defined using concave regions
  (regions with negative smoothed second derivative) from signal averaged across all
  samples. The candidate peaks are then tested for condition-specific statistical
  significance using IDR.\n\nTool homepage: https://github.com/jurgjn/yapc"
inputs:
  - id: output_prefix
    type: string
    doc: Prefix to use for all output files
    inputBinding:
      position: 1
  - id: condition_rep1_rep2
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of the condition, BigWig files of first and second replicates; all
      separated by spaces.
    default: None
    inputBinding:
      position: 2
  - id: fixed_peak_halfwidth
    type:
      - 'null'
      - int
    doc: Set final peak coordinates to the specified number of base pairs on 
      either side of the concave region mode.
    default: None
    inputBinding:
      position: 103
      prefix: --fixed-peak-halfwidth
  - id: min_concave_region_width
    type:
      - 'null'
      - int
    doc: Discard concave regions smaller than the threshold specified.
    default: 75
    inputBinding:
      position: 103
      prefix: --min-concave-region-width
  - id: pseudoreplicates
    type:
      - 'null'
      - boolean
    doc: 'Use pseudoreplicates as implemented in modENCODE (Landt et al 2012; around
      Fig 7): for each condition, assess peak reproducibility in replicates and pseudoreplicates;
      report globalIDRs for the set with a larger number of peak calls (at IDR=0.001).
      Pseudoreplicates are specified as the 3rd and 4th file name after every condition.'
    default: false
    inputBinding:
      position: 103
      prefix: --pseudoreplicates
  - id: recycle
    type:
      - 'null'
      - boolean
    doc: Do not recompute (intermediate) output files if a file with the 
      expected name is already present. Enabling this can lead to funky 
      behaviour e.g. in the case of a previously interrupted run.
    default: false
    inputBinding:
      position: 103
      prefix: --recycle
  - id: smoothing_times
    type:
      - 'null'
      - int
    doc: Number of times smoothing is applied to the second derivative.
    default: 3
    inputBinding:
      position: 103
      prefix: --smoothing-times
  - id: smoothing_window_width
    type:
      - 'null'
      - int
    doc: Width of the smoothing window used for the second derivative track. If 
      the peak calls aren't capturing the peak shape well, try setting this to 
      different values ranging from 75 to 200.
    default: 150
    inputBinding:
      position: 103
      prefix: --smoothing-window-width
  - id: truncate_idr_input
    type:
      - 'null'
      - int
    doc: Truncate IDR input to the number of peaks specified.
    default: 100000
    inputBinding:
      position: 103
      prefix: --truncate-idr-input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yapc:0.1--py_0
stdout: yapc.out
