cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - revertransseq.pl
label: phyloaln_revertransseq.pl
doc: "Use the aligned translated sequences in a file as blueprint to align nucleotide sequences, which means reverse-translation.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_file
    type:
      type: array
      items: File
    doc: "input nucleotide sequences file or files (joined with ',')"
    inputBinding:
      position: 1
      prefix: "-i"
      itemSeparator: ","
  - id: blueprint_file
    type: File
    doc: "aligned amino acid sequences file translated from the input file, used as blueprint"
    inputBinding:
      position: 2
      prefix: "-b"
  - id: output_file_path
    type: string
    doc: "output aligned nucleotide sequences file"
    inputBinding:
      position: 3
      prefix: "-o"
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
    doc: "symbol of termination in blueprint (default='*')"
    inputBinding:
      position: 5
      prefix: "-t"
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "num threads (default=1)"
    inputBinding:
      position: 6
      prefix: "-n"
  - id: log_file_name
    type:
      - 'null'
      - string
    doc: "log file name (default='revertransseq.log')"
    inputBinding:
      position: 7
      prefix: "-l"
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Aligned nucleotide sequences"
    outputBinding:
      glob: "$(inputs.output_file_path)"
  - id: log_file
    type:
      - 'null'
      - File
    doc: "Log file"
    outputBinding:
      glob: "$(inputs.log_file_name || \"revertransseq.log\")"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.input_file.map(function(f) {return {"entryname": f.basename, "entry": f, "writable": true};}))'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
