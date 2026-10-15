cwlVersion: v1.2
class: CommandLineTool
baseCommand: profbval
label: profbval
doc: "PROFbval predicts flexible and rigid residues (backbone B-values) from the protein sequence with a neural network.\n\nTool homepage: https://rostlab.org/owiki/index.php/PROFbval"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: fasta_file
    type: File
    doc: "File containing the protein amino-acid sequence in FASTA format."
    inputBinding:
      position: 1
  - id: rdb_prof_file
    type: File
    doc: "Secondary structure and solvent accessibility prediction by PROF in RDB format."
    inputBinding:
      position: 2
  - id: hssp_file
    type: File
    doc: "PSI-BLAST alignment profile file converted to HSSP format."
    inputBinding:
      position: 3
  - id: output_file
    type: string
    doc: "Name of the output file (comma-separated names when several output modes are given)."
    inputBinding:
      position: 4
  - id: window
    type: int
    doc: "Window size for the neural network input (for example 9)."
    inputBinding:
      position: 5
  - id: output_mode
    type: string
    doc: "Output mode (for example 6, or a comma-separated list such as -1,0,1,2,3,4,5,6,snap,snapfun)."
    inputBinding:
      position: 6
  - id: debug
    type:
      - 'null'
      - int
    doc: "Debug flag (non-zero keeps the temporary directory)."
    inputBinding:
      position: 7
outputs:
  - id: predictions
    type: File
    doc: Per-residue predictions
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profbval:v1.0.22-6-deb_cv1
stdout: profbval.out
