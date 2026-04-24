cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - homopolish
  - make_train_data
label: homopolish_make_train_data
doc: "Make training data for homopolish by aligning reference genomes to assembly
  genomes and downloading homologous sequences.\n\nTool homepage: https://github.com/ythuang0522/homopolish"
inputs:
  - id: ani
    type:
      - 'null'
      - int
    doc: ani identity
    inputBinding:
      position: 101
      prefix: --ani
  - id: assembly
    type: File
    doc: Path to a assembly genome.
    inputBinding:
      position: 101
      prefix: --assembly
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Keep the information of every contig after mash, such as homologous 
      sequences and its identity infomation.
    inputBinding:
      position: 101
      prefix: --debug
  - id: distance
    type:
      - 'null'
      - int
    doc: Difference of structure (counted by ani).
    inputBinding:
      position: 101
      prefix: --distance
  - id: download_contig_nums
    type:
      - 'null'
      - int
    doc: How much contig to download from NCBI.
    inputBinding:
      position: 101
      prefix: --download_contig_nums
  - id: genus
    type:
      - 'null'
      - string
    doc: Genus name
    inputBinding:
      position: 101
      prefix: --genus
  - id: local_db_path
    type:
      - 'null'
      - Directory
    doc: Path to your local DB
    inputBinding:
      position: 101
      prefix: --local_DB_path
  - id: mash_screen
    type:
      - 'null'
      - boolean
    doc: Use mash screen.
    inputBinding:
      position: 101
      prefix: --mash_screen
  - id: mash_threshold
    type:
      - 'null'
      - float
    doc: Mash output threshold.
    inputBinding:
      position: 101
      prefix: --mash_threshold
  - id: meta
    type:
      - 'null'
      - boolean
    doc: Your assembly genome is metagenome.
    inputBinding:
      position: 101
      prefix: --meta
  - id: minimap_args
    type:
      - 'null'
      - string
    doc: Minimap2 -x argument.
    inputBinding:
      position: 101
      prefix: --minimap_args
  - id: reference
    type: File
    doc: True reference aligned to assembly genome. Include labels in output.
    inputBinding:
      position: 101
      prefix: --reference
  - id: sketch_path
    type:
      - 'null'
      - File
    doc: Path to a mash sketch file.
    inputBinding:
      position: 101
      prefix: --sketch_path
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homopolish:0.4.2--pyhdfd78af_0
