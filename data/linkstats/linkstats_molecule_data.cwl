cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LinkStats
label: linkstats_molecule_data
doc: "Read molecular data from a CSV FILE, re-calculate histogram data, and save CSV files and optional plots.\n\nTool homepage: https://github.com/wtsi-hpag/LinkStats"
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 10
    valueFrom: molecule-data
  - position: 30
    valueFrom: save-csvs
  - position: 50
    valueFrom: $(inputs.prefix)
  - position: 60
    valueFrom: |
      ${
        return inputs.save_plots ? ['save-plots', inputs.prefix] : [];
      }
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Default=4.
    inputBinding:
      position: 1
      prefix: --threads
  - id: min_reads
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: --min_reads
    doc: Minimum reads per molecule for analysis, multiple values possible. Default=(1, 3, 5, 10).
    inputBinding:
      position: 2
  - id: data_file
    type: File
    doc: Molecular data CSV file (for example PREFIX_molecular_data.csv.bz2).
    inputBinding:
      position: 20
  - id: prefix
    type: string
    doc: Output prefix. Files are written as PREFIX_<name> (the directory part must exist).
  - id: save_summary
    type:
      - 'null'
      - boolean
    doc: Save summary data table. Default=True.
    inputBinding:
      position: 40
      valueFrom: "$(self ? '--summ' : '--no-summ')"
  - id: save_molecules
    type:
      - 'null'
      - boolean
    doc: Save molecule data table. Default=False.
    inputBinding:
      position: 40
      valueFrom: "$(self ? '--mol' : '--no-mol')"
  - id: save_coverage
    type:
      - 'null'
      - boolean
    doc: Save coverage data table. Default=False.
    inputBinding:
      position: 40
      valueFrom: "$(self ? '--cov' : '--no-cov')"
  - id: save_mol_hist
    type:
      - 'null'
      - boolean
    doc: Save molecular-length histogram data table. Default=False.
    inputBinding:
      position: 40
      valueFrom: "$(self ? '--mol-hist' : '--no-mol-hist')"
  - id: save_cov_hist
    type:
      - 'null'
      - boolean
    doc: Save coverage-gap histogram data table. Default=False.
    inputBinding:
      position: 40
      valueFrom: "$(self ? '--cov-hist' : '--no-cov-hist')"
  - id: save_plots
    type:
      - 'null'
      - boolean
    doc: Also run save-plots to generate plots from the histogram data at PREFIX_.
outputs:
  - id: result_files
    type:
      type: array
      items: File
    doc: Summary, data, histogram and plot files written with the prefix.
    outputBinding:
      glob: $(inputs.prefix)_*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linkstats:0.1.3--py310h82d6cb0_6
stdout: linkstats_molecule_data.out
