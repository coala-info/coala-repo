cwlVersion: v1.2
class: CommandLineTool
baseCommand: emerald
label: emerald
doc: "EMERALD is a tool for finding suboptimal alignments in protein sequences.\n\n\
  Tool homepage: https://github.com/algbio/emerald"
inputs:
  - id: alignments
    type:
      - 'null'
      - int
    doc: Non-negative integer n, creates a fasta file in the current working 
      directory containing randomly chosen n suboptimal alignments.
    inputBinding:
      position: 101
      prefix: --alignments
  - id: alpha
    type:
      - 'null'
      - float
    doc: Floating value, choose edges that appear in (alpha*100)% of all 
      (sub-)optimal paths to be safe.
    inputBinding:
      position: 101
      prefix: --alpha
  - id: approximation
    type:
      - 'null'
      - boolean
    doc: Approximates big integers with doubles. Output might be less accurate, 
      but running speed will be increased.
    inputBinding:
      position: 101
      prefix: --approximation
  - id: clusterfile
    type: File
    doc: Path to input FASTA cluster file
    inputBinding:
      position: 101
      prefix: -f
  - id: costmat
    type:
      - 'null'
      - File
    doc: Reads the aligning score of two symbols from a text file. The text file
      is a lower triangular matrix with 20 lines.
    inputBinding:
      position: 101
      prefix: --costmat
  - id: delta
    type:
      - 'null'
      - int
    doc: Integer value, defines suboptimal paths to be in the delta neighborhood
      of the optimal.
    inputBinding:
      position: 101
      prefix: --delta
  - id: drawgraph
    type:
      - 'null'
      - string
    doc: Name of a directory (created before the run) that receives dot code 
      files of all alignments for plotting the Delta suboptimal subgraph.
    inputBinding:
      position: 101
      prefix: --drawgraph
  - id: gapcost
    type:
      - 'null'
      - int
    doc: Integer, set the score of aligning a character to a gap.
    inputBinding:
      position: 101
      prefix: --gapcost
  - id: reference
    type:
      - 'null'
      - string
    doc: Protein identity, selects reference protein. By default, this is the 
      first protein.
    inputBinding:
      position: 101
      prefix: --reference
  - id: special
    type:
      - 'null'
      - int
    doc: Integer, sets the score of aligning symbols with special characters. 
      INF value ignores these characters.
    inputBinding:
      position: 101
      prefix: --special
  - id: startgap
    type:
      - 'null'
      - int
    doc: Integer, set the score of starting a gap alignment.
    inputBinding:
      position: 101
      prefix: --startgap
  - id: threads
    type:
      - 'null'
      - int
    doc: Integer, specifies the number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: windowmerge
    type:
      - 'null'
      - boolean
    doc: Merge safety windows if they intersect or are adjacent. EMERALD prints 
      both merged and unmerged safety windows if this option is in use.
    inputBinding:
      position: 101
      prefix: --windowmerge
  - id: outputfile_path
    type: string
    doc: Path to the output file. EMERALD appends to an existing file.
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: outputfile
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.outputfile_path)
  - id: suboptimal_alignments
    type:
      type: array
      items: File
    doc: FASTA files with randomly chosen suboptimal alignments (written with 
      --alignments)
    outputBinding:
      glob: suboptimal_*.fasta
  - id: drawgraph_dir
    type:
      - 'null'
      - Directory
    doc: Directory with dot code files (written with --drawgraph)
    outputBinding:
      glob: $(inputs.drawgraph)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.drawgraph ? {class: 'Directory', basename: inputs.drawgraph, listing:
        []} : null)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emerald:1.2.1--hd2a2fb8_2
