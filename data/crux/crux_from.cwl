cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux_from
doc: "Crux is a suite of tools for analyzing tandem mass spectrometry data.\n\nTool
  homepage: https://github.com/redbadger/crux"
inputs:
  - id: command
    type: string
    doc: 'The specific Crux command to execute. Available commands include: bullseye,
      tide-index, tide-search, comet, percolator, q-ranker, barista, search-for-xlinks,
      spectral-counts, pipeline, cascade-search, assign-confidence, make-pin, predict-peptide-ions,
      hardklor, param-medic, print-processed-spectra, generate-peptides, get-ms2-spectrum,
      version, psm-convert, subtract-index, xlink-assign-ions, xlink-score-spectrum,
      localize-modification, extract-columns, extract-rows, stat-column, sort-by-column.'
    inputBinding:
      position: 1
  - id: argument
    type:
      - 'null'
      - string
    doc: Command-specific arguments.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_from.out
