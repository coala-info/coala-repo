cwlVersion: v1.2
class: CommandLineTool
baseCommand: consel
label: consel
doc: "Calculates p-values (AU, NP, BP, PP, KH, SH, WKH, WSH) for each item, such as a phylogenetic tree, from the bootstrap replicates in an rmt file made by makermt (or from a rep or cnt file), and writes them to <output_base>.pv and the confidence intervals to <output_base>.ci. View the results with catpv and catci.\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: input_file
    type: File
    doc: input file, an rmt file from makermt (or a rep file with -R, or a cnt
      file with -C)
    inputBinding:
      position: 2
  - id: output_base
    type:
      - 'null'
      - string
    doc: base name of the output files (<output_base>.pv, .ci, .rep, .cnt)
    default: consel_out
    inputBinding:
      position: 3
  - id: input_rep
    type:
      - 'null'
      - boolean
    doc: read replicates of the test statistics from a rep file (input_file is a .rep file) instead of an rmt file
    inputBinding:
      position: 1
      prefix: -R
  - id: input_cnt
    type:
      - 'null'
      - boolean
    doc: read counts from a cnt file (input_file is a .cnt file) instead of an rmt file
    inputBinding:
      position: 1
      prefix: -C
  - id: output_rep
    type:
      - 'null'
      - boolean
    doc: also write the replicates of the test statistics to <output_base>.rep
    inputBinding:
      position: 1
      prefix: -r
  - id: output_cnt
    type:
      - 'null'
      - boolean
    doc: also write the counts of how often each item is chosen as the largest to <output_base>.cnt
    inputBinding:
      position: 1
      prefix: -c
  - id: association_file
    type:
      - 'null'
      - File
    doc: association file (.ass) to compute p-values of associated items, as made by treeass
    inputBinding:
      position: 1
      prefix: -a
  - id: vt_file
    type:
      - 'null'
      - File
    doc: vt file with the variance/test item values
    inputBinding:
      position: 1
      prefix: -v
  - id: pdm_file
    type:
      - 'null'
      - File
    doc: pdm file (.vt) for the item distances
    inputBinding:
      position: 1
      prefix: --pdm
  - id: pa_file
    type:
      - 'null'
      - File
    doc: pa file with the scale parameters
    inputBinding:
      position: 1
      prefix: -p
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: debug mode level
    inputBinding:
      position: 1
      prefix: -d
  - id: threads_cm
    type:
      - 'null'
      - int
    doc: number of items considered at one time (cm)
    inputBinding:
      position: 1
      prefix: -t
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: do not sort the items by their observed statistics
    inputBinding:
      position: 1
      prefix: --no_sort
  - id: no_bp
    type:
      - 'null'
      - boolean
    doc: do not calculate the bootstrap probability (bp)
    inputBinding:
      position: 1
      prefix: --no_bp
  - id: no_pp
    type:
      - 'null'
      - boolean
    doc: do not calculate the Bayesian posterior probability (pp)
    inputBinding:
      position: 1
      prefix: --no_pp
  - id: no_sh
    type:
      - 'null'
      - boolean
    doc: do not calculate the Shimodaira-Hasegawa type tests (kh, sh, wkh, wsh)
    inputBinding:
      position: 1
      prefix: --no_sh
  - id: no_au
    type:
      - 'null'
      - boolean
    doc: do not calculate the approximately unbiased (au) test
    inputBinding:
      position: 1
      prefix: --no_au
  - id: smooth_cnt
    type:
      - 'null'
      - boolean
    doc: smooth the counts
    inputBinding:
      position: 1
      prefix: --smooth_cnt
  - id: quick_mctest
    type:
      - 'null'
      - boolean
    doc: quick multiple comparison test; avoids sorting the replicates
    inputBinding:
      position: 1
      prefix: --quick_mctest
  - id: threshold
    type:
      - 'null'
      - double
    doc: threshold value
    inputBinding:
      position: 1
      prefix: --th
  - id: kappa
    type:
      - 'null'
      - double
    doc: kappa value
    inputBinding:
      position: 1
      prefix: --kappa
  - id: chi_dim
    type:
      - 'null'
      - double
    doc: degrees of freedom for the chi-square fitting (selects chi fitting)
    inputBinding:
      position: 1
      prefix: --chi_dim
  - id: chi_dimmin
    type:
      - 'null'
      - double
    doc: minimum degrees of freedom for the chi-square fitting
    inputBinding:
      position: 1
      prefix: --chi_dimmin
  - id: chi_grid
    type:
      - 'null'
      - int
    doc: number of grid points for the chi-square fitting (selects chi fitting)
    inputBinding:
      position: 1
      prefix: --chi_grid
  - id: chi_opt
    type:
      - 'null'
      - boolean
    doc: optimize the chi-square degrees of freedom with grid search (selects chi fitting)
    inputBinding:
      position: 1
      prefix: --chi_opt
  - id: chi_noopt
    type:
      - 'null'
      - boolean
    doc: do not optimize the chi-square degrees of freedom (selects chi fitting)
    inputBinding:
      position: 1
      prefix: --chi_noopt
  - id: chi_nogs
    type:
      - 'null'
      - boolean
    doc: optimize the chi-square degrees of freedom without grid search (selects chi fitting)
    inputBinding:
      position: 1
      prefix: --chi_nogs
  - id: chieps
    type:
      - 'null'
      - double
    doc: convergence epsilon for the chi-square fitting
    inputBinding:
      position: 1
      prefix: --chieps
  - id: ppcoef
    type:
      - 'null'
      - double
    doc: coefficient for the posterior probability (pp) calculation
    inputBinding:
      position: 1
      prefix: --ppcoef
  - id: ppn
    type:
      - 'null'
      - double
    doc: sample size for the posterior probability (pp) calculation
    inputBinding:
      position: 1
      prefix: --ppn
  - id: aictype
    type:
      - 'null'
      - int
    doc: type of AIC used for model selection in curve fitting
    inputBinding:
      position: 1
      prefix: --aictype
  - id: cieps
    type:
      - 'null'
      - double
    doc: epsilon for the confidence interval calculation
    inputBinding:
      position: 1
      prefix: --cieps
  - id: vceps2
    type:
      - 'null'
      - double
    doc: epsilon for the variance-covariance calculation
    inputBinding:
      position: 1
      prefix: --vceps2
  - id: rmin
    type:
      - 'null'
      - double
    doc: minimum scale r used in the curve fitting
    inputBinding:
      position: 1
      prefix: --rmin
  - id: rmax
    type:
      - 'null'
      - double
    doc: maximum scale r used in the curve fitting
    inputBinding:
      position: 1
      prefix: --rmax
  - id: pmin
    type:
      - 'null'
      - double
    doc: minimum p-value used in the curve fitting
    inputBinding:
      position: 1
      prefix: --pmin
  - id: dmin
    type:
      - 'null'
      - int
    doc: minimum degrees of freedom used in the curve fitting
    inputBinding:
      position: 1
      prefix: --dmin
  - id: mle
    type:
      - 'null'
      - boolean
    doc: use maximum likelihood for the internal curve fitting (the default)
    inputBinding:
      position: 1
      prefix: --mle
  - id: wls
    type:
      - 'null'
      - boolean
    doc: use weighted least squares instead of maximum likelihood for the curve fitting
    inputBinding:
      position: 1
      prefix: --wls
  - id: chi
    type:
      - 'null'
      - boolean
    doc: use chi-square fitting for the curve fitting
    inputBinding:
      position: 1
      prefix: --chi
  - id: fast_rescaling
    type:
      - 'null'
      - boolean
    doc: rescaling approximation; use only replicates with r=1 (use -f with makermt as well)
    inputBinding:
      position: 1
      prefix: -f
  - id: multi
    type:
      - 'null'
      - boolean
    doc: multiple rmt input mode
    inputBinding:
      position: 1
      prefix: -g
  - id: mleeps
    type:
      - 'null'
      - double
    doc: convergence epsilon for the maximum likelihood fitting
    inputBinding:
      position: 1
      prefix: --mleeps
  - id: congbp
    type:
      - 'null'
      - double
    doc: value added for the conditional bootstrap probability
    inputBinding:
      position: 1
      prefix: --congbp
outputs:
  - id: pv
    type: File
    doc: p-values of the tests (view with catpv)
    outputBinding:
      glob: $(inputs.output_base).pv
  - id: ci
    type:
      - 'null'
      - File
    doc: confidence intervals of the test statistics (view with catci)
    outputBinding:
      glob: $(inputs.output_base).ci
  - id: rep
    type:
      - 'null'
      - File
    doc: replicates of the test statistics (with -r)
    outputBinding:
      glob: $(inputs.output_base).rep
  - id: cnt
    type:
      - 'null'
      - File
    doc: counts of the largest item in the replicates (with -c)
    outputBinding:
      glob: $(inputs.output_base).cnt
  - id: log
    type: stdout
    doc: progress log
stdout: consel.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
