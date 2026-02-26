cwlVersion: v1.2
class: CommandLineTool
baseCommand: TIR-Learner
label: tir-learner_TIR-Learner
doc: "TIR-Learner is an ensemble pipeline for Terminal Inverted Repeat (TIR) transposable
  elements annotation in eukaryotic genomes\n\nTool homepage: https://github.com/lutianyu2001/TIR-Learner"
inputs:
  - id: additional_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments (Optional). See documentation for more details.
    inputBinding:
      position: 101
      prefix: --additional_args
  - id: checkpoint_dir
    type:
      - 'null'
      - Directory
    doc: The path to the checkpoint directory (Optional). If not specified, the 
      program will automatically search for it in the genome file directory and 
      the output directory.
    inputBinding:
      position: 101
      prefix: --checkpoint_dir
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of processors allowed (Optional)
    inputBinding:
      position: 101
      prefix: --cpu
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode (Optional). If activated, data for all completed steps will 
      be stored in the checkpoint file. Meanwhile, the temporary files in the 
      working directory will also be kept.
    inputBinding:
      position: 101
      prefix: -d
  - id: genome_file
    type: File
    doc: Genome file in fasta format
    inputBinding:
      position: 101
      prefix: --genome_file
  - id: genome_name
    type:
      - 'null'
      - string
    doc: Genome name (Optional)
    inputBinding:
      position: 101
      prefix: --genome_name
  - id: grf_path
    type:
      - 'null'
      - File
    doc: Path to GRF program (Optional)
    inputBinding:
      position: 101
      prefix: --grf_path
  - id: gt_path
    type:
      - 'null'
      - File
    doc: Path to genometools program (Optional)
    inputBinding:
      position: 101
      prefix: --gt_path
  - id: length
    type:
      - 'null'
      - int
    doc: Max length of TIR (Optional)
    inputBinding:
      position: 101
      prefix: --length
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Parallel execution mode, one of the following: "py" and "gnup" (Optional)'
    inputBinding:
      position: 101
      prefix: --mode
  - id: processors
    type:
      - 'null'
      - int
    doc: Number of processors allowed (Optional)
    inputBinding:
      position: 101
      prefix: --processors
  - id: species
    type: string
    doc: 'One of the following: "maize", "rice" or "others"'
    inputBinding:
      position: 101
      prefix: --species
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (Optional). Will show interactive progress bar and more 
      execution details.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: The path to the working directory (Optional). An isolated sandbox 
      directory for storing all the temporary files will be created in the 
      working directory. This sandbox directory will only persist during the 
      program execution. DO NOT TOUCH THE SANDBOX DIRECTORY IF IT IS NOT FOR 
      DEBUGGING!
    inputBinding:
      position: 101
      prefix: --working_dir
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory (Optional)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tir-learner:3.0.7--hdfd78af_0
