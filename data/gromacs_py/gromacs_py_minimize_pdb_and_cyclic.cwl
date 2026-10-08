cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - minimize_pdb_and_cyclic.py
label: gromacs_py_minimize_pdb_and_cyclic
doc: "Minimize a (cyclic) peptide structure in 2 steps, the first step without bond constraints and the second step with bond constraints.\n\nTool homepage: https://github.com/samuelmurail/gromacs_py"
inputs:
  - id: input_pdb
    type: File
    doc: "Input PDB file"
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: "$(self.basename)"
  - id: name
    type: string
    doc: "Output name (the minimized structure is written as NAME.pdb)"
    inputBinding:
      position: 101
      prefix: -n
  - id: out_dir
    type:
      - 'null'
      - string
    doc: "Output directory for intermediate files"
    inputBinding:
      position: 101
      prefix: -dir
  - id: min_steps
    type:
      - 'null'
      - int
    doc: "Minimisation nsteps, default=1000"
    inputBinding:
      position: 101
      prefix: -m_steps
  - id: keep
    type:
      - 'null'
      - boolean
    doc: "Keep temporary files (without this flag the output directory is deleted)"
    inputBinding:
      position: 101
      prefix: -keep
  - id: cyclic
    type:
      - 'null'
      - boolean
    doc: "Indicate that the peptide/protein is cyclic"
    inputBinding:
      position: 101
      prefix: -cyclic
  - id: keep_segid
    type:
      - 'null'
      - boolean
    doc: "Keep the original chain/segid"
    inputBinding:
      position: 101
      prefix: -keep_segid
  - id: add_ter
    type:
      - 'null'
      - boolean
    doc: "Include TER lines between chains and where residues in the input PDB are not consecutive"
    inputBinding:
      position: 101
      prefix: -add_ter
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
  - id: output_pdb
    type:
      - 'null'
      - File
    doc: "Minimized structure written as NAME.pdb"
    outputBinding:
      glob: $(inputs.name).pdb
  - id: out_dir_dir
    type:
      - 'null'
      - Directory
    doc: "Intermediate files directory (kept with -keep)"
    outputBinding:
      glob: $(inputs.out_dir)
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
stdout: gromacs_py_minimize_pdb_and_cyclic.out
