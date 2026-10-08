cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - minimize_pdb.py
label: gromacs_py_minimize_pdb
doc: "Minimize a PDB structure in 2 steps, the first step without bond constraints and the second step with.\n\nTool homepage: https://github.com/samuelmurail/gromacs_py"
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
  - id: min_steps
    type:
      - 'null'
      - int
    doc: "Minimisation nsteps, default=1000"
    inputBinding:
      position: 101
      prefix: -m_steps
  - id: box
    type:
      - 'null'
      - string
    doc: "Create a box, default=False"
    inputBinding:
      position: 101
      prefix: -box
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
    doc: "Output directory written by minimize_pdb.py"
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
stdout: gromacs_py_minimize_pdb.out
