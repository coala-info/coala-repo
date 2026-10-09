cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-filter-quality-minoche
label: illumina-utils_iu-filter-quality-minoche
doc: "Implementation of \"http://genomebiology.com/content/12/11/R112\"

Tool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: config_file
    type: File
    doc: "User configuration to run (INI file)."
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTQ files named in the config file, staged in the working directory so that the relative names resolve."
  - id: min_hq_length
    type:
      - 'null'
      - float
    doc: "Minimum high-quality read length (default: 0.75)"
    inputBinding:
      position: 2
      prefix: '-p'
  - id: ignore_deflines
    type:
      - 'null'
      - boolean
    doc: "If FASTQ files are not CASAVA outputs, parsing the header info may go wrong. This flag tells the software to skip parsing deflines."
    inputBinding:
      position: 13
      prefix: '--ignore-deflines'
  - id: visualize_quality_curves
    type:
      - 'null'
      - boolean
    doc: "When set, mean quality score for individual bases will be stored and visualized for each group of reads."
    inputBinding:
      position: 14
      prefix: '--visualize-quality-curves'
  - id: limit_num_pairs
    type:
      - 'null'
      - int
    doc: "Put a limit to the number of pairs to analyze. For testing purposes."
    inputBinding:
      position: 15
      prefix: '--limit-num-pairs'
  - id: print_qual_scores
    type:
      - 'null'
      - boolean
    doc: "When set, the script will print out the Q-scores the way it sees it in the FASTQ file."
    inputBinding:
      position: 16
      prefix: '--print-qual-scores'
  - id: store_read_fate
    type:
      - 'null'
      - boolean
    doc: "Keep track of the read fate and store it on disk."
    inputBinding:
      position: 17
      prefix: '--store-read-fate'
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written by the tool in the working directory
    outputBinding:
      glob: "*"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
stdout: illumina-utils_iu-filter-quality-minoche.out
