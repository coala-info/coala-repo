cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntm-profiler collate
label: ntm-profiler_collate
doc: "Collate results from ntm-profiler runs.\n\nTool homepage: https://github.com/jodyphelan/NTM-Profiler"
inputs:
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    default: /usr/local/share/ntm-profiler/
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug logging
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    default: .
    inputBinding:
      position: 101
      prefix: --dir
  - id: dist_db_name
    type:
      - 'null'
      - string
    doc: Default name for SNP-dist DB
    default: ntm-profiler-dists.db
    inputBinding:
      position: 101
      prefix: --dist_db_name
  - id: distance_cutoff
    type:
      - 'null'
      - int
    doc: Cutoff for SNP distance graph output (distance<=cutoff)
    default: 10
    inputBinding:
      position: 101
      prefix: --distance_cutoff
  - id: format
    type:
      - 'null'
      - string
    doc: Output file type
    default: txt
    inputBinding:
      position: 101
      prefix: --format
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    default: INFO
    inputBinding:
      position: 101
      prefix: --logging
  - id: min_species_relative_abundance
    type:
      - 'null'
      - float
    doc: Minimum abundance (percent) for a species to be reported in the 
      collated output
    default: 2.0
    inputBinding:
      position: 101
      prefix: --min_species_relative_abundance
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Don't remove temporary files after run
    default: false
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: outfile
    type:
      - 'null'
      - string
    doc: Sample prefix
    default: ntmprofiler.collate.txt
    inputBinding:
      position: 101
      prefix: --outfile
  - id: samples
    type:
      - 'null'
      - File
    doc: File with samples (one per line)
    default: None
    inputBinding:
      position: 101
      prefix: --samples
  - id: suffix
    type:
      - 'null'
      - string
    doc: Input results files suffix
    default: .results.json
    inputBinding:
      position: 101
      prefix: --suffix
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp directory to process all files
    default: .
    inputBinding:
      position: 101
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
stdout: ntm-profiler_collate.out
