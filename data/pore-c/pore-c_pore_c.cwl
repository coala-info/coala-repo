cwlVersion: v1.2
class: CommandLineTool
baseCommand: pore_c
label: pore-c_pore_c
doc: "A suite of tools designed to analyse Oxford Nanopore reads with multiway\n \
  \ chromatin contacts.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: dask_dashboard_port
    type:
      - 'null'
      - int
    doc: "The port to use for the dask dashboard, set\n                          \
      \        to 0 to use a random port"
    inputBinding:
      position: 101
      prefix: --dask-dashboard-port
  - id: dask_disable_dashboard
    type:
      - 'null'
      - boolean
    doc: Disable the dask dashboard
    inputBinding:
      position: 101
      prefix: --dask-disable-dashboard
  - id: dask_num_workers
    type:
      - 'null'
      - int
    doc: Number of dask workers
    inputBinding:
      position: 101
      prefix: --dask-num-workers
  - id: dask_scheduler_port
    type:
      - 'null'
      - int
    doc: "The port to use for the dask scheduler, set\n                          \
      \        to 0 to use a random port"
    inputBinding:
      position: 101
      prefix: --dask-scheduler-port
  - id: dask_threads_per_worker
    type:
      - 'null'
      - int
    doc: Number of threads per worker
    inputBinding:
      position: 101
      prefix: --dask-threads-per-worker
  - id: dask_use_threads
    type:
      - 'null'
      - boolean
    doc: Use threads instead of processes
    inputBinding:
      position: 101
      prefix: --dask-use-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all logging
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbosity
    type:
      - 'null'
      - boolean
    doc: "Increase level of logging information, eg.\n                           \
      \       -vvv"
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
stdout: pore-c_pore_c.out
