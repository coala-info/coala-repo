cwlVersion: v1.2
class: CommandLineTool
baseCommand: lefse_run.py
label: lefse_lefse_run.py
doc: "LEfSe: linear discriminant analysis effect size, to find biomarkers that explain differences between classes.\n\nTool homepage: https://github.com/SegataLab/lefse"
inputs:
  - id: input_file
    type: File
    doc: 'the input file (formatted with lefse_format_input.py)'
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: 'the output file containing the data for the visualization module'
    inputBinding:
      position: 2
  - id: out_text_file
    type:
      - 'null'
      - string
    doc: 'set the file for exporting the result (only concise textual form)'
    inputBinding:
      position: 10
      prefix: -o
  - id: anova_alpha
    type:
      - 'null'
      - float
    doc: 'set the alpha value for the Anova test (default 0.05)'
    inputBinding:
      position: 10
      prefix: -a
  - id: wilcoxon_alpha
    type:
      - 'null'
      - float
    doc: 'set the alpha value for the Wilcoxon test (default 0.05)'
    inputBinding:
      position: 10
      prefix: -w
  - id: lda_threshold
    type:
      - 'null'
      - float
    doc: 'set the threshold on the absolute value of the logarithmic LDA score (default 2.0)'
    inputBinding:
      position: 10
      prefix: -l
  - id: nlogs
    type:
      - 'null'
      - int
    doc: 'max log influence of LDA coefficients'
    inputBinding:
      position: 10
      prefix: --nlogs
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'verbose execution (default 0)'
    inputBinding:
      position: 10
      prefix: --verbose
  - id: wilc
    type:
      - 'null'
      - int
    doc: 'whether to perform the Wilcoxon step (default 1)'
    inputBinding:
      position: 10
      prefix: --wilc
  - id: rank_method
    type:
      - 'null'
      - string
    doc: 'select LDA or SVM for effect size (default LDA)'
    inputBinding:
      position: 10
      prefix: -r
  - id: svm_norm
    type:
      - 'null'
      - int
    doc: 'whether to normalize the data in [0,1] for SVM feature weighting (default 1)'
    inputBinding:
      position: 10
      prefix: --svm_norm
  - id: bootstrap_iterations
    type:
      - 'null'
      - int
    doc: 'set the number of bootstrap iterations for LDA (default 30)'
    inputBinding:
      position: 10
      prefix: -b
  - id: only_same_subclass
    type:
      - 'null'
      - int
    doc: 'set whether to perform the Wilcoxon test only among the subclasses with the same name (default 0)'
    inputBinding:
      position: 10
      prefix: -e
  - id: curtis
    type:
      - 'null'
      - int
    doc: 'set whether to perform the Wilcoxon test in the Curtis approach [BETA VERSION] (default 0)'
    inputBinding:
      position: 10
      prefix: -c
  - id: subsample_fraction
    type:
      - 'null'
      - float
    doc: 'set the subsampling fraction value for each bootstrap iteration (default 0.66666)'
    inputBinding:
      position: 10
      prefix: -f
  - id: multiple_testing
    type:
      - 'null'
      - int
    doc: 'set the multiple testing correction option: 0 no correction (default), 1 independent comparisons, 2 dependent comparisons'
    inputBinding:
      position: 10
      prefix: -s
  - id: min_c
    type:
      - 'null'
      - int
    doc: 'minimum number of samples per subclass for performing the Wilcoxon test (default 10)'
    inputBinding:
      position: 10
      prefix: --min_c
  - id: title
    type:
      - 'null'
      - string
    doc: 'set the title of the analysis (default input file without extension)'
    inputBinding:
      position: 10
      prefix: -t
  - id: multiclass_strategy
    type:
      - 'null'
      - int
    doc: '(for multiclass tasks) one-against-one (1, more strict) or one-against-all (0, less strict) (default 0)'
    inputBinding:
      position: 10
      prefix: -y
outputs:
  - id: output_file_out
    type: File
    doc: 'The LEfSe result file'
    outputBinding:
      glob: $(inputs.output_file)
  - id: text_output
    type: File?
    doc: 'Concise textual result, written when out_text_file is set'
    outputBinding:
      glob: $(inputs.out_text_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
