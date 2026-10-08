cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - extend.py
label: gromacs_py_extend
doc: "Extend a production or equilibration simulation from its run input file.\n\nTool homepage: https://github.com/samuelmurail/gromacs_py"
inputs:
  - id: input_tpr
    type: File
    doc: "Input tpr"
    inputBinding:
      position: 101
      prefix: -s
      valueFrom: "$(self.basename)"
  - id: time
    type:
      - 'null'
      - float
    doc: "Extend simulation time, default=10"
    inputBinding:
      position: 101
      prefix: -time
  - id: dt
    type:
      - 'null'
      - float
    doc: "Integration time step, default=0.005"
    inputBinding:
      position: 101
      prefix: -dt
  - id: checkpoint
    type:
      - 'null'
      - File
    doc: "Checkpoint (.cpt) file of the run, staged beside the tpr"
  - id: extra_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Other files of the run (log, edr, xtc, trr) staged beside the tpr so the run is appended"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Total number of threads to start, default=0"
    inputBinding:
      position: 101
      prefix: -nt
  - id: thread_mpi
    type:
      - 'null'
      - int
    doc: "Number of thread-MPI threads to start, default=0"
    inputBinding:
      position: 101
      prefix: -ntmpi
  - id: gpu_id
    type:
      - 'null'
      - string
    doc: "List of GPU device id-s to use"
    inputBinding:
      position: 101
      prefix: -gpu_id
outputs:
  - id: extended_files
    type:
      type: array
      items: File
    doc: "Run files written or appended by extend.py in the working directory"
    outputBinding:
      glob: ["*.gro", "*.xtc", "*.edr", "*.log", "*.cpt", "*.trr", "*.tpr", "*.mdp"]
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.input_tpr.basename)
        entry: $(inputs.input_tpr)
        writable: true
      - entryname: "$(inputs.checkpoint ? inputs.checkpoint.basename : 'unused_checkpoint')"
        entry: "$(inputs.checkpoint ? inputs.checkpoint : null)"
        writable: true
      - $(inputs.extra_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
stdout: gromacs_py_extend.out
