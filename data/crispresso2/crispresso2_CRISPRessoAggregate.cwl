cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPRessoAggregate
label: crispresso2_CRISPRessoAggregate
doc: Aggregate CRISPResso2 Runs
inputs:
  - id: crispresso_folders
    type:
      type: array
      items: Directory
    doc: CRISPResso2 output folders to aggregate; they are staged in the 
      working directory so that --prefix/--suffix can find them
  - id: prefix
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --prefix
          separate: true
    doc: Prefix for CRISPResso folders to aggregate (may be specified multiple 
      times)
    inputBinding:
      position: 101
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix for CRISPResso folders to aggregate
    inputBinding:
      position: 101
      prefix: --suffix
  - id: name
    type: string
    doc: Output name of the report
    inputBinding:
      position: 101
      prefix: --name
  - id: min_reads_for_inclusion
    type:
      - 'null'
      - int
    doc: Minimum number of reads for a run to be included in the run summary
    inputBinding:
      position: 101
      prefix: --min_reads_for_inclusion
  - id: place_report_in_output_folder
    type:
      - 'null'
      - boolean
    doc: If true, report will be written inside the CRISPResso output folder. By
      default, the report will be written one directory up from the report 
      output.
    inputBinding:
      position: 101
      prefix: --place_report_in_output_folder
  - id: suppress_report
    type:
      - 'null'
      - boolean
    doc: Suppress output report
    inputBinding:
      position: 101
      prefix: --suppress_report
  - id: suppress_plots
    type:
      - 'null'
      - boolean
    doc: Suppress output plots
    inputBinding:
      position: 101
      prefix: --suppress_plots
  - id: max_samples_per_summary_plot
    type:
      - 'null'
      - int
    doc: Maximum number of samples on each page of the pdf report plots. If this
      number gets above ~150, they will be too big for matplotlib.
    inputBinding:
      position: 101
      prefix: --max_samples_per_summary_plot
  - id: n_processes
    type:
      - 'null'
      - string
    doc: Specify the number of processes to use for analysis. Please use with 
      caution since increasing this parameter will significantly increase the 
      memory required to run CRISPResso. Can be set to 'max'.
    inputBinding:
      position: 101
      prefix: --n_processes
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debug messages
    inputBinding:
      position: 101
      prefix: --debug
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level of output to the console (1-4), 4 is the most verbose
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: halt_on_plot_fail
    type:
      - 'null'
      - boolean
    doc: Halt execution if a plot fails to generate
    inputBinding:
      position: 101
      prefix: --halt_on_plot_fail
  - id: use_matplotlib
    type:
      - 'null'
      - boolean
    doc: Use matplotlib for plotting instead of plotly/d3 when CRISPRessoPro is 
      installed
    inputBinding:
      position: 101
      prefix: --use_matplotlib
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: aggregate_folder
    type: Directory
    doc: Aggregate output folder CRISPRessoAggregate_on_<name>
    outputBinding:
      glob: CRISPRessoAggregate_on_$(inputs.name)
  - id: report
    type:
      - 'null'
      - File
    doc: HTML report (written beside the output folder by default)
    outputBinding:
      glob: CRISPRessoAggregate_on_$(inputs.name).html
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.crispresso_folders)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispresso2:2.3.3--py39hff726c5_0
stdout: CRISPRessoAggregate.out
s:url: https://github.com/pinellolab/CRISPResso2
$namespaces:
  s: https://schema.org/
