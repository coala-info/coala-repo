cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tbpore
  - process
label: tbpore_process
doc: "Single-sample TB genomic analysis from Nanopore sequencing data\n\nTool homepage:
  https://github.com/mbhall88/tbpore/"
inputs:
  - id: inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: Fastq file(s) and/or a directory containing fastq files. All files will
      be joined into a single fastq file, so ensure they're all part of the same
      sample/isolate.
    inputBinding:
      position: 1
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: Path to use for the cache
    default: /root/.cache
    inputBinding:
      position: 102
      prefix: --cache
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Remove all temporary files on *successful* completion
    inputBinding:
      position: 102
      prefix: --cleanup
  - id: coverage
    type:
      - 'null'
      - int
    doc: Depth of coverage to subsample to. Use 0 to disable
    inputBinding:
      position: 102
      prefix: --coverage
  - id: decontamination_db
    type:
      - 'null'
      - File
    doc: Path to the decontaminaton database
    default: /root/.tbpore/decontamination_db/remove_contam.map-ont.mmi
    inputBinding:
      position: 102
      prefix: --db
  - id: metadata
    type:
      - 'null'
      - File
    doc: Path to the decontaminaton database metadata file
    default: 
      /usr/local/lib/python3.8/site-packages/data/decontamination_db/remove_contam.tsv.gz
    inputBinding:
      position: 102
      prefix: --metadata
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Remove all temporary files on *successful* completion
    inputBinding:
      position: 102
      prefix: --no-cleanup
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recursively search INPUTS for fastq files
    inputBinding:
      position: 102
      prefix: --recursive
  - id: report_all_mykrobe_calls
    type:
      - 'null'
      - boolean
    doc: Report all mykrobe calls (turn on flag -A, --report_all_calls when 
      calling mykrobe)
    inputBinding:
      position: 102
      prefix: --report_all_mykrobe_calls
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Name of the sample. By default, will use the first INPUT file with 
      fastq extensions removed
    inputBinding:
      position: 102
      prefix: --name
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use in multithreaded tools
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Specify where to write all (tbpore) temporary files.
    default: <outdir>/.tbpore
    inputBinding:
      position: 102
      prefix: --tmp
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to place output files
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbpore:0.7.1--pyhdfd78af_0
