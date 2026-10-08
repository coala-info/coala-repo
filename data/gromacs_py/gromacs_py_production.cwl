cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - production.py
label: gromacs_py_production
doc: "Run a production simulation.\n\nTool homepage: https://github.com/samuelmurail/gromacs_py"
inputs:
  - id: input_pdb
    type: File
    doc: "Input PDB file"
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: "$(self.basename)"
  - id: topology
    type: File
    doc: "Topology in gromacs format .top"
    inputBinding:
      position: 101
      prefix: -p
      valueFrom: "$(self.basename)"
  - id: output_directory
    type: string
    doc: "Output directory"
    inputBinding:
      position: 101
      prefix: -o
  - id: name
    type: string
    doc: "Output file name"
    inputBinding:
      position: 101
      prefix: -n
  - id: time
    type:
      - 'null'
      - float
    doc: "Production time, default=10"
    inputBinding:
      position: 101
      prefix: -time
  - id: dt
    type:
      - 'null'
      - float
    doc: "Integration time step, default=0.002 (2 fs)"
    inputBinding:
      position: 101
      prefix: -dt
  - id: maxwarn
    type:
      - 'null'
      - int
    doc: "Total number of warnings allowed, default=0"
    inputBinding:
      position: 101
      prefix: -maxwarn
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
  - id: include_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files included by the topology (.itp, position restraints), staged beside the topology"
outputs:
  - id: output_directory_dir
    type: Directory
    doc: "Output directory written by production.py"
    outputBinding:
      glob: $(inputs.output_directory)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.input_pdb.basename)
        entry: $(inputs.input_pdb)
        writable: true
      - entryname: $(inputs.topology.basename)
        entry: $(inputs.topology)
        writable: true
      - $(inputs.include_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
stdout: gromacs_py_production.out
