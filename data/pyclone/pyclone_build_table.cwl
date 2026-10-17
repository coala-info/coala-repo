cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PyClone
  - build_table
label: pyclone_build_table
doc: "Build results table which contains cluster ids and (mean) cellular prevalence estimates.\n\nTool homepage: https://github.com/Roth-Lab/pyclone"
inputs:
  - id: config_file
    type: File
    doc: "Path to configuration file used for analysis (config.yaml in analysis_dir)."
    loadContents: true
  - id: analysis_dir
    type: Directory
    doc: "Analysis directory made by setup_analysis or run_analysis_pipeline (holds config.yaml, the yaml folder and the trace folder). Keep its original name so the paths in the config resolve."
  - id: out_file
    type: string
    doc: "Path where table will be written in tsv format."
    inputBinding:
      position: 1
      prefix: --out_file
  - id: table_type
    type: string
    doc: "Table to build: cluster, loci or old_style."
    inputBinding:
      position: 1
      prefix: --table_type
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
outputs:
  - id: table
    type: File
    doc: "Results table in tsv format."
    outputBinding:
      glob: $(inputs.out_file)
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
