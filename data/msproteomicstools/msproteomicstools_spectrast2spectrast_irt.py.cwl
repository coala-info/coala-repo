cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spectrast2spectrast_irt.py
label: msproteomicstools_spectrast2spectrast_irt.py
doc: "Normalize the retention times of a SpectraST library (txt format) to iRT using the Biognosys RT-kit peptides and write regression plots for all runs.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_library
    type: File
    doc: "Input SpectraST library in txt format (non-consensus .sptxt/.splib)"
    inputBinding:
      prefix: --in
  - id: output_path
    type: string
    doc: "Output library (.splib); a .pepidx and a .csv with the same base name are written too"
    inputBinding:
      prefix: --out
  - id: kit
    type: ['null', string]
    doc: "RT-kit peptides with their iRT values, as peptide:irt,peptide:irt,..."
    inputBinding:
      prefix: --kit
  - id: applychauvenet
    type: ['null', boolean]
    doc: "Use Chauvenet's criterion to exclude outliers"
    inputBinding:
      prefix: --applychauvenet
  - id: precursorlevel
    type: ['null', boolean]
    doc: "Use precursors instead of peptides for grouping"
    inputBinding:
      prefix: --precursorlevel
  - id: spectralevel
    type: ['null', boolean]
    doc: "Do not merge or group any peptides or precursors (use raw spectra)"
    inputBinding:
      prefix: --spectralevel
  - id: report
    type: ['null', boolean]
    doc: "Write a csv report"
    inputBinding:
      prefix: --report
  - id: exclude
    type: ['null', string]
    doc: "Peptides from the RT-kit to exclude, as run_id1:LGGNEQVTR,run_id2:GAGSSEPVTGLDAK"
    inputBinding:
      prefix: --exclude
  - id: surrogate
    type: ['null', string]
    doc: "Surrogate calibrations, as broken_run_id1:working_run_id2"
    inputBinding:
      prefix: --surrogate
  - id: linearregression
    type: ['null', string]
    doc: "Surrogate linear regressions (first number: c, second number: m), as broken_run_id1:1/3"
    inputBinding:
      prefix: --linearregression
  - id: rsq_threshold
    type: ['null', float]
    doc: "R-squared threshold to accept linear regression (default 0.95)"
    inputBinding:
      prefix: --rsq_threshold
outputs:
  - id: output
    type: File
    doc: "Normalized library"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: pepidx
    type: ['null', File]
    doc: "Peptide index"
    outputBinding:
      glob: "*.pepidx"
  - id: report_csv
    type: ['null', File]
    doc: "Report"
    outputBinding:
      glob: "*.csv"
  - id: plots
    type: 'File[]'
    doc: "Regression plots"
    outputBinding:
      glob: "*.{pdf,png}"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_spectrast2spectrast_irt.py.out
