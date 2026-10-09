cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LinkStats
label: linkstats_mol_len_hist_data
doc: "Read molecule length histogram data from a CSV FILE, and save CSV files or combined plots.\n\nTool homepage: https://github.com/wtsi-hpag/LinkStats"
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 10
    valueFrom: mol-len-hist-data
  - position: 30
    valueFrom: |
      ${
        var a = [];
        if (inputs.save_csv) {
          a = a.concat(['save-csvs', '--no-summ', '--mol-hist', inputs.prefix]);
        }
        if (inputs.save_plots) {
          a = a.concat(['save-plots', inputs.prefix]);
        }
        return a;
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
    doc: Molecule length histogram CSV file (for example PREFIX_molecular_length_histograms.csv.bz2).
    inputBinding:
      position: 20
  - id: prefix
    type: string
    doc: Output prefix. Files are written as PREFIX_<name> (the directory part must exist).
  - id: save_csv
    type:
      - 'null'
      - boolean
    doc: Run save-csvs to save the molecular-length histogram data at PREFIX_.
  - id: save_plots
    type:
      - 'null'
      - boolean
    doc: Run save-plots to generate plots from the histogram data at PREFIX_.
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
stdout: linkstats_mol_len_hist_data.out
