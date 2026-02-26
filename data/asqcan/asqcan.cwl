cwlVersion: v1.2
class: CommandLineTool
baseCommand: asqcan
label: asqcan
doc: "A combined pipeline for bacterial genome ASsembly, Quality Control, and ANnotation.\n\
  \nTool homepage: https://github.com/bogemad/asqcan"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite files in the output directories.
    inputBinding:
      position: 101
      prefix: --force
  - id: ion_torrent
    type:
      - 'null'
      - boolean
    doc: Reads are sourced from the Ion Torrent platform. Don't include this if 
      your reads are Illumina-sourced.
    inputBinding:
      position: 101
      prefix: --ion-torrent
  - id: max_memory
    type:
      - 'null'
      - string
    doc: Maximum amount of RAM to assign to the pipeline in GB (Just the 
      number).
    inputBinding:
      position: 101
      prefix: --max_memory
  - id: reads_dir
    type: Directory
    doc: Path to a directory with your interleaved fastq files.
    inputBinding:
      position: 101
      prefix: --fastq-dir
  - id: search_database
    type:
      - 'null'
      - File
    doc: Path to the local search database. This pipeline does not require you 
      to have a local copy of a search database but without it you will not be 
      able to use similarity data for blobtools. Similarity data adds 
      significantly to the blobplot and blobtools table outputs of this 
      pipeline. See 
      https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download
      to install a local database.
    inputBinding:
      position: 101
      prefix: --search_database
  - id: searcher
    type:
      - 'null'
      - string
    doc: Search algorithm to use. Options [blastn, diamond]
    inputBinding:
      position: 101
      prefix: --searcher
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for multiprocessing.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity on command line output (n.b. verbose output is 
      always saved to asqcan.log in the output directory).
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type: Directory
    doc: Path to the output directory. A directory will be created if one does 
      not exist.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/asqcan:0.4--pyh7cba7a3_0
