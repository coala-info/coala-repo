cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - create_peptide.py
label: gromacs_py_create_peptide
doc: "Create a linear peptide structure, do a minimisation and a vacuum equilibration.\n\nTool homepage: https://github.com/samuelmurail/gromacs_py"
inputs:
  - id: sequence
    type: string
    doc: "Peptide sequence"
    inputBinding:
      position: 101
      prefix: -seq
  - id: output_directory
    type: string
    doc: "Output directory"
    inputBinding:
      position: 101
      prefix: -o
  - id: min_steps
    type:
      - 'null'
      - int
    doc: "Minimisation nsteps, default=1000"
    inputBinding:
      position: 101
      prefix: -m_steps
  - id: time
    type:
      - 'null'
      - float
    doc: "Vacuum equilibration time (ns), default = 1 ns"
    inputBinding:
      position: 101
      prefix: -time
outputs:
  - id: output_directory_dir
    type: Directory
    doc: "Output directory written by create_peptide.py"
    outputBinding:
      glob: $(inputs.output_directory)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs_py:2.0.3--pyhdfd78af_0
stdout: gromacs_py_create_peptide.out
