cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastoma-infer-roothogs
label: fastoma_infer_roothogs
doc: "Infer the root hierarchical orthologous groups (rootHOGs) from OMAmer hogmap files and the input proteomes.\n\nTool homepage: https://github.com/DessimozLab/FastOMA"
inputs:
  - id: proteomes
    type: Directory
    doc: Path to the folder containing the input proteomes
    inputBinding:
      position: 1
      prefix: --proteomes
  - id: out_rhog_folder
    type: string
    doc: Folder where the roothog fasta files are written
    inputBinding:
      position: 2
      prefix: --out-rhog-folder
  - id: splice
    type:
      - 'null'
      - Directory
    doc: Path to the folder containing the splice information files
    inputBinding:
      position: 3
      prefix: --splice
  - id: hogmap
    type:
      - 'null'
      - Directory
    doc: Path to the folder containing the hogmap files
    inputBinding:
      position: 4
      prefix: --hogmap
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity to info/debug
    inputBinding:
      position: 5
      prefix: -v
  - id: min_sequence_length
    type:
      - 'null'
      - int
    doc: "Minimum sequence length. Shorter sequences will be ignored. (Default=50)"
    inputBinding:
      position: 6
      prefix: --min-sequence-length
  - id: mergHOG_ratioMax_thresh
    type:
      - 'null'
      - float
    doc: For merging rootHOGs, threshold of ratioMax
    inputBinding:
      position: 7
      prefix: --mergHOG-ratioMax-thresh
  - id: mergHOG_ratioMin_thresh
    type:
      - 'null'
      - float
    doc: For merging rootHOGs, threshold of ratioMin
    inputBinding:
      position: 8
      prefix: --mergHOG-ratioMin-thresh
  - id: mergHOG_shared_thresh
    type:
      - 'null'
      - int
    doc: For merging rootHOGs, threshold of number shared proteins
    inputBinding:
      position: 9
      prefix: --mergHOG-shared-thresh
  - id: mergHOG_fscore_thresh
    type:
      - 'null'
      - int
    doc: For merging rootHOGs, threshold of family score shared proteins
    inputBinding:
      position: 10
      prefix: --mergHOG-fscore-thresh
  - id: big_rhog_size
    type:
      - 'null'
      - int
    doc: For big rootHOGs, we have different heuristics
    inputBinding:
      position: 11
      prefix: --big-rhog-size
  - id: big_fscore_thresh
    type:
      - 'null'
      - int
    doc: For huge rootHOGs, we have different heuristics, like filtering low family score proteins
    inputBinding:
      position: 12
      prefix: --big-fscore-thresh
outputs:
  - id: rhog_folder
    type:
      - 'null'
      - Directory
    doc: Folder with the roothog fasta files.
    outputBinding:
      glob: $(inputs.out_rhog_folder)
  - id: gene_id_pickle
    type:
      - 'null'
      - File
    doc: Gene identifier dictionary in pickle format, written to the working directory.
    outputBinding:
      glob: '*.pickle'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
stdout: fastoma_infer_roothogs.out
