cwlVersion: v1.2
class: CommandLineTool
baseCommand: kronos run
label: kronos_run
doc: "run kronos-made pipelines with optional initialization\n\nTool homepage: https://github.com/jtaghiyar/kronos"
inputs:
  - id: components_dir
    type: Directory
    doc: path to components_dir
    inputBinding:
      position: 101
      prefix: --components_dir
  - id: config_file
    type:
      - 'null'
      - File
    doc: path to the config_file.yaml
    inputBinding:
      position: 101
      prefix: --config_file
  - id: drmaa_library_path
    type:
      - 'null'
      - File
    doc: path of drmaa library
    inputBinding:
      position: 101
      prefix: --drmaa_library_path
  - id: input_samples
    type:
      - 'null'
      - File
    doc: path to the input samples file
    inputBinding:
      position: 101
      prefix: --input_samples
  - id: job_scheduler
    type:
      - 'null'
      - string
    doc: job scheduler used to manage jobs on the cluster
    inputBinding:
      position: 101
      prefix: --job_scheduler
  - id: kronos_pipeline
    type:
      - 'null'
      - File
    doc: path to kronos-made pipeline script.
    inputBinding:
      position: 101
      prefix: --kronos_pipeline
  - id: no_prefix
    type:
      - 'null'
      - boolean
    doc: switch off the prefix that is added to all the output files.
    inputBinding:
      position: 101
      prefix: --no_prefix
  - id: num_jobs
    type:
      - 'null'
      - int
    doc: maximum number of simultaneous jobs per pipeline
    inputBinding:
      position: 101
      prefix: --num_jobs
  - id: num_pipelines
    type:
      - 'null'
      - int
    doc: maximum number of simultaneous running pipelines
    inputBinding:
      position: 101
      prefix: --num_pipelines
  - id: pipeline_name
    type:
      - 'null'
      - string
    doc: pipeline name
    inputBinding:
      position: 101
      prefix: --pipeline_name
  - id: python_installation
    type:
      - 'null'
      - File
    doc: path to python executable
    inputBinding:
      position: 101
      prefix: --python_installation
  - id: qsub_options
    type:
      - 'null'
      - string
    doc: native qsub specifications for the cluster in a single string
    inputBinding:
      position: 101
      prefix: --qsub_options
  - id: run_id
    type:
      - 'null'
      - string
    doc: pipeline run id
    inputBinding:
      position: 101
      prefix: --run_id
  - id: setup_file
    type:
      - 'null'
      - File
    doc: path to the setup file
    inputBinding:
      position: 101
      prefix: --setup_file
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: path to the working_dir
    inputBinding:
      position: 101
      prefix: --working_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronos:2.3.0--py_0
stdout: kronos_run.out
