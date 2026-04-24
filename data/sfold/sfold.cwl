cwlVersion: v1.2
class: CommandLineTool
baseCommand: sfold.pl
label: sfold
doc: "Sfold Executable Code for Academic Users, Version 2.2-20220519\n\nTool homepage:
  https://github.com/Ding-RNA-Lab/Sfold"
inputs:
  - id: sequence_file
    type: File
    doc: sequence file
    inputBinding:
      position: 1
  - id: antisense_oligo_length
    type:
      - 'null'
      - int
    doc: Length of antisense oligos
    inputBinding:
      position: 102
      prefix: -w
  - id: constraints_file
    type:
      - 'null'
      - File
    doc: Name of file containing folding constraints. Constraint syntax follows 
      what is used in mfold 3.1
    inputBinding:
      position: 102
      prefix: -f
  - id: do_not_obliterate_sample_out
    type:
      - 'null'
      - boolean
    doc: Do not obliterate sample.out to save space
    inputBinding:
      position: 102
      prefix: -e
  - id: max_paired_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between paired bases
    inputBinding:
      position: 102
      prefix: -l
  - id: mfe_structure_file
    type:
      - 'null'
      - File
    doc: Name of file containing the MFE structure in GCG connect format. If 
      provided, Sfold clustering module will determine the cluster to which this
      structure belongs.
    inputBinding:
      position: 102
      prefix: -m
  - id: run_clustering
    type:
      - 'null'
      - boolean
    doc: Run clustering on the sampled ensemble
    inputBinding:
      position: 102
      prefix: -a
  - id: sirna_soligo_mode
    type:
      - 'null'
      - int
    doc: 1=do Sirna, 2=do Soligo, 3=both, 0=neither
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Name of directory to which output files are written. Directory will be 
      created if it does not already exist. Existing files will be overwritten.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sfold:2.2--pl5321r44h7b50bb2_4
