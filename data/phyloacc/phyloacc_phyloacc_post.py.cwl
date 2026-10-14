cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyloacc_post.py
label: phyloacc_phyloacc_post.py
doc: "phyloacc_post.py combines and summarizes the output from batched PhyloAcc runs.\n\nTool
  homepage: https://github.com/phyloacc/PhyloAcc"
inputs:
  - id: input_dir
    type: Directory
    doc: The directory created from a phyloacc run (it is staged writable, because
      the program writes its log there)
    inputBinding:
      position: 101
      prefix: -i
  - id: out_dest
    type: string
    doc: 'Desired output directory. This will be created for you if it does not exist
      (default: <input directory>/results/)'
    inputBinding:
      position: 101
      prefix: -o
  - id: bf1
    type:
      - 'null'
      - float
    doc: The cutoff for logBF1.
    inputBinding:
      position: 101
      prefix: -bf1
  - id: bf2
    type:
      - 'null'
      - float
    doc: The cutoff for logBF2.
    inputBinding:
      position: 101
      prefix: -bf2
  - id: bf3
    type:
      - 'null'
      - float
    doc: The cutoff for logBF3.
    inputBinding:
      position: 101
      prefix: -bf3
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set this to overwrite existing files.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set this flag to prevent PhyloAcc from reporting detailed information about
      each step.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: appendlog
    type:
      - 'null'
      - boolean
    doc: Set this to keep the old log file even if --overwrite is specified. New log
      information will instead be appended to the previous log file.
    inputBinding:
      position: 101
      prefix: --appendlog
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_dest_dir
    type:
      - 'null'
      - Directory
    doc: Combined results of all batches
    outputBinding:
      glob: $(inputs.out_dest)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloacc:2.4.5--py313h4c9e609_1
stdout: phyloacc_phyloacc_post.py.out
