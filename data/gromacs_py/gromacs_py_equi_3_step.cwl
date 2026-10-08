cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - equi_3_step.py
label: gromacs_py_equi_3_step
doc: "Equilibrate a system (coordinates + topology) in 3 steps: heavy atom position restraints, alpha carbon position restraints, then weak alpha carbon position restraints.\n\nTool homepage: https://github.com/samuelmurail/gromacs_py"
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
  - id: ha_time
    type:
      - 'null'
      - float
    doc: "Equilibration with HA constraint time (ns), default = 0.25 ns"
    inputBinding:
      position: 101
      prefix: -HA_time
  - id: ca_time
    type:
      - 'null'
      - float
    doc: "Equilibration with CA constraint time (ns), default = 1 ns"
    inputBinding:
      position: 101
      prefix: -CA_time
  - id: ca_low_time
    type:
      - 'null'
      - float
    doc: "Equilibration with weak CA constraint time (ns), default = 5 ns"
    inputBinding:
      position: 101
      prefix: -CA_LOW_time
  - id: dt_ha
    type:
      - 'null'
      - float
    doc: "Equi HA dt, default=0.002 (2 fs)"
    inputBinding:
      position: 101
      prefix: -dt_HA
  - id: dt
    type:
      - 'null'
      - float
    doc: "Equi CA, CA_LOW dt, default=0.002 (2 fs)"
    inputBinding:
      position: 101
      prefix: -dt
  - id: maxwarn
    type:
      - 'null'
      - int
    doc: "Total number of warnings allowed for the equilibration, default=0"
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
    doc: "Output directory written by equi_3_step.py"
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
stdout: gromacs_py_equi_3_step.out
