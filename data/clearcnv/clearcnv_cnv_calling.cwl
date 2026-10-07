cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clearCNV
  - cnv_calling
label: clearcnv_cnv_calling
doc: "CNV calling script. Output is a single file in tsv format containing a list of CNV calls sorted by score. Some quality control plots are added to the analysis directory in the process.\n\nTool homepage: https://github.com/bihealth/clear-cnv"
inputs:
  - id: panel
    type: string
    doc: "Name of the data set(or panel)"
    inputBinding:
      position: 101
      prefix: --panel
  - id: coverages
    type: File
    doc: "Coverages file in tsv format"
    inputBinding:
      position: 101
      prefix: --coverages
  - id: analysis_directory
    type: string
    doc: "Path to the directory, where analysis files are stored"
    inputBinding:
      position: 101
      prefix: --analysis_directory
  - id: matchscores
    type: File
    doc: "matchscores.tsv file generated with matchscores.py"
    inputBinding:
      position: 101
      prefix: --matchscores
  - id: cnv_calls
    type: string
    doc: "Output cnv_calls.tsv file formatted in tsv format"
    inputBinding:
      position: 101
      prefix: --cnv_calls
  - id: ratio_scores
    type: string
    doc: "Output ratio scores file in tsv format. Best kept together with cnv_calls.tsv"
    inputBinding:
      position: 101
      prefix: --ratio_scores
  - id: z_scores
    type: string
    doc: "Output z-scores file in tsv format. Best kept together with cnv_calls.tsv"
    inputBinding:
      position: 101
      prefix: --z_scores
  - id: expected_artefacts
    type:
      - 'null'
      - float
    doc: "Expected ratio of CNVs or artefacs in target fragment counts"
    inputBinding:
      position: 101
      prefix: --expected_artefacts
  - id: sample_score_factor
    type:
      - 'null'
      - float
    doc: "The factor u multiplied with the median sample score to define sample groups. u should range between 1.0 < u < 5.0. Default is 2.0."
    inputBinding:
      position: 101
      prefix: --sample_score_factor
  - id: minimum_group_sizes
    type:
      - 'null'
      - int
    doc: "Group size per CNV calling group per match scores. Default is 30."
    inputBinding:
      position: 101
      prefix: --minimum_group_sizes
  - id: zscale
    type:
      - 'null'
      - float
    doc: "A higher z-scale results in more CNV calls. Should only be 0.0 <= zscale <= 2.0. Default is 0.65."
    inputBinding:
      position: 101
      prefix: --zscale
  - id: del_cutoff
    type:
      - 'null'
      - float
    doc: "A hard threshold on the ratio score for deletions. Default is 0.75."
    inputBinding:
      position: 101
      prefix: --del_cutoff
  - id: dup_cutoff
    type:
      - 'null'
      - float
    doc: "A hard threshold on the ratio score for duplications. Default is 1.35."
    inputBinding:
      position: 101
      prefix: --dup_cutoff
  - id: trans_prob
    type:
      - 'null'
      - float
    doc: "Transition probability of the HMM to change state from WT to CNV. Default is 0.001. Lower values prefer longer CNVs, higher values prefer shorter CNVs."
    inputBinding:
      position: 101
      prefix: --trans_prob
  - id: plot_regions
    type:
      - 'null'
      - boolean
    doc: "If set, the CNV calling script plots heatmaps of the CNV called regions with the corresponding sample group taken as background."
    inputBinding:
      position: 101
      prefix: --plot_regions
  - id: cores
    type:
      - 'null'
      - int
    doc: "Number of cpu cores used in parallel processing. Default: determined automatically."
    inputBinding:
      position: 101
      prefix: --cores
outputs:
  - id: cnv_calls_tsv
    type: File
    doc: "CNV calls sorted by score"
    outputBinding:
      glob: "$(inputs.cnv_calls)"
  - id: ratio_scores_tsv
    type: File
    doc: "Ratio scores"
    outputBinding:
      glob: "$(inputs.ratio_scores)"
  - id: z_scores_tsv
    type: File
    doc: "Z-scores"
    outputBinding:
      glob: "$(inputs.z_scores)"
  - id: analysis_dir
    type: Directory
    doc: "Analysis directory with quality control plots"
    outputBinding:
      glob: "$(inputs.analysis_directory)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
