cwlVersion: v1.2
class: CommandLineTool
baseCommand: earlgrey_earlGrey
label: earlgrey_earlGrey
doc: "A script for modification and automation of RepeatMasker configuration with
  Dfam 3.9.\n\nTool homepage: https://github.com/TobyBaril/EarlGrey"
inputs:
  - id: abblast_dir
    type:
      - 'null'
      - Directory
    doc: Directory for abblast.
    default: /usr/local/bin
    inputBinding:
      position: 101
      prefix: --abblast_dir
  - id: configure_script
    type:
      - 'null'
      - File
    doc: Path to the configuration script for RepeatMasker.
    inputBinding:
      position: 101
      prefix: --configure_script
  - id: crossmatch_dir
    type:
      - 'null'
      - Directory
    doc: Directory for crossmatch.
    default: /usr/local/bin
    inputBinding:
      position: 101
      prefix: --crossmatch_dir
  - id: default_search_engine
    type:
      - 'null'
      - string
    doc: Default search engine for RepeatMasker.
    default: rmblast
    inputBinding:
      position: 101
      prefix: --default_search_engine
  - id: dfam_partitions
    type:
      - 'null'
      - string
    doc: 'Specify the Dfam partitions to download. Example: [0-10] for partitions
      0 to 10, or [3,5,7] for partitions 3, 5, and 7. [0-16] downloads all partitions.'
    inputBinding:
      position: 101
      prefix: --dfam_partitions
  - id: hmmer_dir
    type:
      - 'null'
      - Directory
    doc: Directory for hmmer.
    default: /usr/local/bin
    inputBinding:
      position: 101
      prefix: --hmmer_dir
  - id: repeatmasker_libdir
    type:
      - 'null'
      - Directory
    doc: Directory where RepeatMasker libraries are located.
    default: /usr/local/share/RepeatMasker/Libraries/
    inputBinding:
      position: 101
      prefix: --repeatmasker_libdir
  - id: rmblast_dir
    type:
      - 'null'
      - Directory
    doc: Directory for rmblast.
    default: /usr/local/bin
    inputBinding:
      position: 101
      prefix: --rmblast_dir
  - id: trf_program
    type:
      - 'null'
      - File
    doc: Path to the trf program.
    default: /usr/local/bin/trf
    inputBinding:
      position: 101
      prefix: --trf_program
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/earlgrey:7.0.2--hd63eeec_0
stdout: earlgrey_earlGrey.out
