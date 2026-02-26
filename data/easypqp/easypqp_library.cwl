cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - easypqp
  - library
label: easypqp_library
doc: "Generate EasyPQP library\n\nTool homepage: https://github.com/grosenberger/easypqp"
inputs:
  - id: infiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Input PSM and Peak pickle files generated from an `easypqp 
      convert[psm|sage]` command.
    inputBinding:
      position: 1
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: Generate consensus instead of best replicate spectra.
    default: true
    inputBinding:
      position: 102
      prefix: --consensus
  - id: diannpqp
    type:
      - 'null'
      - boolean
    doc: Generate DIA-NN2-compatible PQP library.
    default: false
    inputBinding:
      position: 102
      prefix: --diannpqp
  - id: im_filter
    type:
      - 'null'
      - string
    doc: Optional tag to filter candidate IM reference runs.
    inputBinding:
      position: 102
      prefix: --im_filter
  - id: im_lowess_fraction
    type:
      - 'null'
      - float
    doc: Fraction of data points to use for IM lowess regression. If set to 0, 
      cross validation is used.
    default: 0.05
    inputBinding:
      position: 102
      prefix: --im_lowess_fraction
  - id: im_psm_fdr_threshold
    type:
      - 'null'
      - float
    doc: PSM FDR threshold used for IM alignment.
    default: 0.001
    inputBinding:
      position: 102
      prefix: --im_psm_fdr_threshold
  - id: im_reference
    type:
      - 'null'
      - File
    doc: Optional IM reference file.
    inputBinding:
      position: 102
      prefix: --im_reference
  - id: im_reference_run_path
    type:
      - 'null'
      - File
    doc: Writes reference run IM file, if IM reference file is not provided.
    default: easypqp_im_reference_run.tsv
    inputBinding:
      position: 102
      prefix: --im_reference_run_path
  - id: min_peptides
    type:
      - 'null'
      - int
    doc: Minimum peptides required for successful alignment.
    default: 5
    inputBinding:
      position: 102
      prefix: --min_peptides
  - id: no_consensus
    type:
      - 'null'
      - boolean
    doc: Generate consensus instead of best replicate spectra.
    default: false
    inputBinding:
      position: 102
      prefix: --no-consensus
  - id: no_diann_pqp
    type:
      - 'null'
      - boolean
    doc: Generate DIA-NN2-compatible PQP library.
    default: true
    inputBinding:
      position: 102
      prefix: --no-diann-pqp
  - id: no_fdr_filtering
    type:
      - 'null'
      - boolean
    doc: Do not reassess or filter by FDR, as library was already provided using
      customized FDR filtering.
    default: true
    inputBinding:
      position: 102
      prefix: --no-fdr-filtering
  - id: no_proteotypic
    type:
      - 'null'
      - boolean
    doc: Use only proteotypic, unique, non-shared peptides.
    default: false
    inputBinding:
      position: 102
      prefix: --no-proteotypic
  - id: nofdr
    type:
      - 'null'
      - boolean
    doc: Do not reassess or filter by FDR, as library was already provided using
      customized FDR filtering.
    default: false
    inputBinding:
      position: 102
      prefix: --nofdr
  - id: peptide_fdr_threshold
    type:
      - 'null'
      - float
    doc: Peptide FDR threshold.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --peptide_fdr_threshold
  - id: peptidetsv
    type:
      - 'null'
      - File
    doc: peptide.tsv file from Philosopher.
    inputBinding:
      position: 102
      prefix: --peptidetsv
  - id: perform_im_calibration
    type:
      - 'null'
      - boolean
    doc: Whether to perform IM calibration
    default: true
    inputBinding:
      position: 102
      prefix: --perform_im_calibration
  - id: perform_rt_calibration
    type:
      - 'null'
      - boolean
    doc: Whether to perform RT calibration
    default: true
    inputBinding:
      position: 102
      prefix: --perform_rt_calibration
  - id: pi0_lambda
    type:
      - 'null'
      - type: array
        items: float
    doc: Use non-parametric estimation of p-values. Either use <START END 
      STEPS>, e.g. 0.1, 1.0, 0.1 or set to fixed value, e.g. 0.4, 0, 0.
    default:
      - 0.1
      - 0.5
      - 0.05
    inputBinding:
      position: 102
      prefix: --pi0_lambda
  - id: protein_fdr_threshold
    type:
      - 'null'
      - float
    doc: Protein FDR threshold.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --protein_fdr_threshold
  - id: proteotypic
    type:
      - 'null'
      - boolean
    doc: Use only proteotypic, unique, non-shared peptides.
    default: true
    inputBinding:
      position: 102
      prefix: --proteotypic
  - id: psm_fdr_threshold
    type:
      - 'null'
      - float
    doc: PSM FDR threshold.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --psm_fdr_threshold
  - id: psmtsv
    type:
      - 'null'
      - File
    doc: psm.tsv file from Philosopher.
    inputBinding:
      position: 102
      prefix: --psmtsv
  - id: rt_filter
    type:
      - 'null'
      - string
    doc: Optional tag to filter candidate RT reference runs.
    inputBinding:
      position: 102
      prefix: --rt_filter
  - id: rt_lowess_fraction
    type:
      - 'null'
      - float
    doc: Fraction of data points to use for RT lowess regression. If set to 0, 
      cross validation is used.
    default: 0.05
    inputBinding:
      position: 102
      prefix: --rt_lowess_fraction
  - id: rt_psm_fdr_threshold
    type:
      - 'null'
      - float
    doc: PSM FDR threshold used for RT alignment.
    default: 0.001
    inputBinding:
      position: 102
      prefix: --rt_psm_fdr_threshold
  - id: rt_reference
    type:
      - 'null'
      - File
    doc: Optional iRT/CiRT reference file.
    inputBinding:
      position: 102
      prefix: --rt_reference
  - id: rt_reference_run_path
    type:
      - 'null'
      - File
    doc: Writes reference run RT file, if RT reference file is not provided.
    default: easypqp_rt_reference_run.tsv
    inputBinding:
      position: 102
      prefix: --rt_reference_run_path
outputs:
  - id: out
    type: File
    doc: Output TSV peptide query parameter file.
    outputBinding:
      glob: $(inputs.out)
  - id: peptide_plot
    type: File
    doc: Output peptide-level PDF report.
    outputBinding:
      glob: $(inputs.peptide_plot)
  - id: protein_plot
    type: File
    doc: Output protein-level PDF report.
    outputBinding:
      glob: $(inputs.protein_plot)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
