cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alignseq.pl
label: phyloaln_alignseq.pl
doc: "Align sequences in a file by mafft.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_file
    type: File
    doc: "input sequences file"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: output_file_path
    type: string
    doc: "output sequences file"
    inputBinding:
      position: 2
      prefix: "-o"
  - id: alignment_type
    type:
      - 'null'
      - string
    doc: "type of alignment (direct/translate/codon/complement/ncRNA, default 'direct'; 'translate' means alignment of the translation of the sequences)"
    inputBinding:
      position: 3
      prefix: "-a"
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: "genetic code (default=1, invertebrate mitochondrion=5)"
    inputBinding:
      position: 4
      prefix: "-g"
  - id: termination_symbol
    type:
      - 'null'
      - string
    doc: "symbol of termination (default='X', mafft will clean '*')"
    inputBinding:
      position: 5
      prefix: "-t"
  - id: translate_incomplete_codons
    type:
      - 'null'
      - int
    doc: "if translate incomplete codons into 'X' (default=no; give 1 for yes)"
    inputBinding:
      position: 6
      prefix: "-c"
  - id: delete_intermediate_files
    type:
      - 'null'
      - int
    doc: "if delete the intermediate files, such as translated files and aligned aa files (default=no; give 1 for yes)"
    inputBinding:
      position: 7
      prefix: "-m"
  - id: mafft_folder
    type:
      - 'null'
      - string
    doc: "the folder where mafft/linsi is; not needed when mafft is in PATH"
    inputBinding:
      position: 8
      prefix: "-f"
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "num threads (default=1)"
    inputBinding:
      position: 9
      prefix: "-n"
  - id: log_file_name
    type:
      - 'null'
      - string
    doc: "log file name (default='alignseq.log')"
    inputBinding:
      position: 10
      prefix: "-l"
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Aligned sequences"
    outputBinding:
      glob: "$(inputs.output_file_path)"
  - id: log_file
    type:
      - 'null'
      - File
    doc: "Log file"
    outputBinding:
      glob: "$(inputs.log_file_name || \"alignseq.log\")"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
