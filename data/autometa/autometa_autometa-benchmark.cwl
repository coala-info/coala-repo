cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-benchmark
label: autometa_autometa-benchmark
doc: "Benchmark classification, clustering or binning-classification against reference assignments for the provided simulated/synthetic community.\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: benchmark
    type: string
    doc: "Type of benchmarking to perform (binning-classification, clustering, classification)"
    inputBinding:
      position: 1
      prefix: --benchmark
  - id: predictions
    type:
      type: array
      items: File
    doc: "Path to Autometa predictions (May specify multiple if they all correspond to the same `--reference` community)"
    inputBinding:
      position: 1
      prefix: --predictions
  - id: reference
    type: File
    doc: "Path to community reference assignments"
    inputBinding:
      position: 1
      prefix: --reference
  - id: average_method
    type:
      - 'null'
      - string
    doc: "Normalizer for normalized mutual information score clustering metric (geometric, max, arithmetic, min) (default: max)"
    inputBinding:
      position: 1
      prefix: --average-method
  - id: output_wide
    type:
      - 'null'
      - string
    doc: "Path to write benchmarking evaluation metrics, one column per metric (default: `benchmark`_benchmarks.tsv.gz)"
    inputBinding:
      position: 1
      prefix: --output-wide
  - id: output_long
    type:
      - 'null'
      - string
    doc: "Path to write clustering evaluation metrics stacked into one 'metric' column"
    inputBinding:
      position: 1
      prefix: --output-long
  - id: output_classification_reports
    type:
      - 'null'
      - string
    doc: "Path to write classification evaluation reports"
    inputBinding:
      position: 1
      prefix: --output-classification-reports
  - id: ncbi
    type:
      - 'null'
      - Directory
    doc: "Path to NCBI databases directory (Required with --benchmark=classification)"
    inputBinding:
      position: 1
      prefix: --ncbi
outputs:
  - id: wide_out
    type: File
    doc: "Benchmark metrics table (wide)"
    outputBinding:
      glob: "${ return inputs.output_wide ? inputs.output_wide : inputs.benchmark + '_benchmarks.tsv.gz'; }"
  - id: long_out
    type: File?
    doc: "Benchmark metrics table (long)"
    outputBinding:
      glob: "${ return inputs.output_long ? inputs.output_long : []; }"
  - id: classification_reports_out
    type: Directory?
    doc: "Classification evaluation reports"
    outputBinding:
      glob: "${ return inputs.output_classification_reports ? inputs.output_classification_reports : []; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
