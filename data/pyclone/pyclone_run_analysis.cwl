cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PyClone
  - run_analysis
label: pyclone_run_analysis
doc: "Run an MCMC sampler to sample from the posterior of the PyClone model.\n\nTool homepage: https://github.com/Roth-Lab/pyclone"
inputs:
  - id: config_file
    type: File
    doc: "Path to configuration file used for analysis (config.yaml in analysis_dir)."
    loadContents: true
  - id: analysis_dir
    type: Directory
    doc: "Analysis directory made by setup_analysis or run_analysis_pipeline (holds config.yaml, the yaml folder and the trace folder). Keep its original name so the paths in the config resolve."
  - id: seed
    type:
      - 'null'
      - int
    doc: "Set random seed so results can be reproduced."
    inputBinding:
      position: 1
      prefix: --seed
outputs:
  - id: analysis_dir_out
    type: Directory
    doc: "Analysis directory with the trace folder."
    outputBinding:
      glob: $(inputs.analysis_dir.basename)
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
