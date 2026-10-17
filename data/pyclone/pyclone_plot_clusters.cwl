cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PyClone
  - plot_clusters
label: pyclone_plot_clusters
doc: "Plot features of the clusters.\n\nTool homepage: https://github.com/Roth-Lab/pyclone"
inputs:
  - id: config_file
    type: File
    doc: "Path to configuration file used for analysis (config.yaml in analysis_dir)."
    loadContents: true
  - id: analysis_dir
    type: Directory
    doc: "Analysis directory made by setup_analysis or run_analysis_pipeline (holds config.yaml, the yaml folder and the trace folder). Keep its original name so the paths in the config resolve."
  - id: plot_file
    type: string
    doc: "Path to file where plot will be saved. Format is set by the file extension."
    inputBinding:
      position: 1
      prefix: --plot_file
  - id: plot_type
    type: string
    doc: "Style of plot: density, parallel_coordinates or scatter."
    inputBinding:
      position: 1
      prefix: --plot_type
  - id: burnin
    type:
      - 'null'
      - int
    doc: "Number of samples to discard as burning for the MCMC chain. Default is 0."
    inputBinding:
      position: 1
      prefix: --burnin
  - id: thin
    type:
      - 'null'
      - int
    doc: "Number of samples to thin MCMC trace. Default is 1."
    inputBinding:
      position: 1
      prefix: --thin
  - id: max_clusters
    type:
      - 'null'
      - int
    doc: "Maximum number of clusters to consider for post-processing."
    inputBinding:
      position: 1
      prefix: --max_clusters
  - id: mesh_size
    type:
      - 'null'
      - int
    doc: "Number of points to use for approximating the cluster posteriors. Default is 101."
    inputBinding:
      position: 1
      prefix: --mesh_size
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: "Clusters with fewer mutations than this value will not be plotted."
    inputBinding:
      position: 1
      prefix: --min_cluster_size
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: "Samples to plot and order to plot them in."
    inputBinding:
      position: 1
      prefix: --samples
outputs:
  - id: plot
    type: File
    doc: "Plot file."
    outputBinding:
      glob: $(inputs.plot_file)
arguments:
  - prefix: --config_file
    valueFrom: pyclone_run_config.yaml
    position: 1
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.analysis_dir.basename)
        entry: $(inputs.analysis_dir)
        writable: true
      - entryname: pyclone_run_config.yaml
        entry: |-
          $(inputs.config_file.contents.replace(/^working_dir:.*$/m, 'working_dir: ' + runtime.outdir + '/' + inputs.analysis_dir.basename))
  - class: EnvVarRequirement
    envDef:
      - envName: MPLBACKEND
        envValue: Agg
      - envName: NUMBA_CACHE_DIR
        envValue: /tmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyclone:0.13.1--py_0
