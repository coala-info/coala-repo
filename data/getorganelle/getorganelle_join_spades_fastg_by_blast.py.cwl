cwlVersion: v1.2
class: CommandLineTool
baseCommand: join_spades_fastg_by_blast.py
label: getorganelle_join_spades_fastg_by_blast.py
doc: "Join the SPAdes fastg contigs according to the reference. It adds extra gap nodes (N) and/or overlap nodes (?) in between the connectible nodes and generates a new fastg file. This is a BETA version.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: input_fastg
    type:
      - File
    doc: "Input fastg file."
    inputBinding:
      position: 101
      prefix: "-g"
  - id: reference_fasta
    type:
      - File
    doc: "Reference fasta file (only the 1st sequence is used); a BLAST database is built beside it."
    inputBinding:
      position: 101
      prefix: "-f"
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: "Choose to disable deleting temp files produced by blast and this script."
    inputBinding:
      position: 101
      prefix: "--keep-temp"
  - id: blast_hits_threshold
    type:
      - 'null'
      - float
    doc: "Default: 0.60"
    inputBinding:
      position: 101
      prefix: "--bt"
  - id: max_gap
    type:
      - 'null'
      - int
    doc: "Default: 1500"
    inputBinding:
      position: 101
      prefix: "--max-gap"
  - id: connect_all
    type:
      - 'null'
      - boolean
    doc: "Choose to activate connecting all possible contigs. Default: False"
    inputBinding:
      position: 101
      prefix: "--con-all"
  - id: depth_to_connect
    type:
      - 'null'
      - float
    doc: "Default: 1.0"
    inputBinding:
      position: 101
      prefix: "--depth"
  - id: which_blast
    type:
      - 'null'
      - string
    doc: "Assign the path to BLAST binary files if not added to the path. Default: try GetOrganelleDep/linux/ncbi-blast first, then $PATH"
    inputBinding:
      position: 101
      prefix: "--which-blast"
outputs:
  - id: joined_fastg
    type:
      - File
    doc: "Joined fastg file (input name plus .Ncontigs_added.fastg)."
    outputBinding:
      glob: "*.Ncontigs_added.*"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_fastg)
        writable: true
      - entry: $(inputs.reference_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_join_spades_fastg_by_blast.py.out
