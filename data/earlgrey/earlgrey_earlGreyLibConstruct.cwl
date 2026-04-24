cwlVersion: v1.2
class: CommandLineTool
baseCommand: earlgrey_earlGreyLibConstruct
label: earlgrey_earlGreyLibConstruct
doc: "A script for modification and automation of Dfam configuration steps for RepeatMasker.\n\
  \nTool homepage: https://github.com/TobyBaril/EarlGrey"
inputs:
  - id: abblast_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing ABBLAST executables.
    inputBinding:
      position: 101
      prefix: --abblast-dir
  - id: crossmatch_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing crossmatch executables.
    inputBinding:
      position: 101
      prefix: --crossmatch-dir
  - id: decompress_partitions
    type:
      - 'null'
      - boolean
    doc: Decompresses the downloaded Dfam partition files.
    inputBinding:
      position: 101
      prefix: --decompress-partitions
  - id: default_search_engine
    type:
      - 'null'
      - string
    doc: The default search engine for RepeatMasker.
    inputBinding:
      position: 101
      prefix: --default-search-engine
  - id: download_partitions
    type:
      - 'null'
      - boolean
    doc: Initiates the download of specified Dfam partitions.
    inputBinding:
      position: 101
      prefix: --download-partitions
  - id: force_reconfigure
    type:
      - 'null'
      - boolean
    doc: Force re-running the RepeatMasker configuration even if it seems 
      configured.
    inputBinding:
      position: 101
      prefix: --force-reconfigure
  - id: hmmer_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing HMMER executables.
    inputBinding:
      position: 101
      prefix: --hmmer-dir
  - id: libdir
    type:
      - 'null'
      - Directory
    doc: Directory where RepeatMasker libraries are located.
    inputBinding:
      position: 101
      prefix: --libdir
  - id: partition_range
    type:
      - 'null'
      - string
    doc: 'Specifies the range or list of Dfam partition numbers to download. Example:
      [0-10] for partitions 0 to 10, or [3,5,7] for partitions 3, 5, and 7. [0-16]
      downloads all partitions.'
    inputBinding:
      position: 101
      prefix: --partition-range
  - id: rerun_configure
    type:
      - 'null'
      - boolean
    doc: Reruns the RepeatMasker configuration with the updated Dfam partitions.
    inputBinding:
      position: 101
      prefix: --rerun-configure
  - id: rmblast_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing rmblast executables.
    inputBinding:
      position: 101
      prefix: --rmblast-dir
  - id: skip_backup
    type:
      - 'null'
      - boolean
    doc: Skip the backup of the min_init partition.
    inputBinding:
      position: 101
      prefix: --skip-backup
  - id: trf_prgm
    type:
      - 'null'
      - File
    doc: Path to the trf program.
    inputBinding:
      position: 101
      prefix: --trf-prgm
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/earlgrey:7.0.2--hd63eeec_0
stdout: earlgrey_earlGreyLibConstruct.out
