cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - compute_full_matrix.py
label: msproteomicstools_compute_full_matrix.py
doc: "Select all peakgroups below the FDR cutoff in all files and try to align them to each other. With one file it acts as peakgroup selector (best by m_score) and applies the FDR cutoff.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: infiles
    type: 'File[]'
    doc: "A list of mProphet output files containing all peakgroups"
    inputBinding:
      prefix: --in
  - id: matrix_outfile
    type: ['null', string]
    doc: "Matrix containing one peak group per row (supports .csv, .tsv or .xls)"
    inputBinding:
      prefix: --out_matrix
  - id: frac_selected
    type: ['null', float]
    doc: "Do not write peakgroup if selected in less than this fraction of runs (range 0 to 1)"
    inputBinding:
      prefix: --frac_selected
  - id: file_format
    type: ['null', string]
    doc: "Which input file format is used (openswath or peakview)"
    inputBinding:
      prefix: --file_format
  - id: output_method
    type: ['null', string]
    doc: "Which columns are written besides Intensity (none, RT, score or full)"
    inputBinding:
      prefix: --output_method
  - id: readmethod
    type: ['null', string]
    doc: "Read full or minimal transition groups (minimal,full)"
    inputBinding:
      prefix: --readmethod
  - id: remove_requant_values
    type: ['null', boolean]
    doc: "Remove requantified values"
    inputBinding:
      prefix: --remove_requant_values
  - id: aligner_mscore_threshold
    type: ['null', float]
    doc: "Cutoff used at alignment, for coloring realigned values in blue"
    inputBinding:
      prefix: --aligner_mscore_threshold
outputs:
  - id: matrix
    type: ['null', File]
    doc: "Peakgroup matrix"
    outputBinding:
      glob: "$(inputs.matrix_outfile)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_compute_full_matrix.py.out
