cwlVersion: v1.2
class: CommandLineTool
baseCommand: python endorS.py
label: endorspy
doc: "endorS.py calculates percent on target (aka Endogenous DNA) from samtools flagstat
  files and print to screen. The percent on target reported will be different depending
  on the combination of samtools flagstat provided. This program also calculates clonality
  (aka cluster factor) and percent duplicates when the flagstat file after duplicate
  removal is provided Use --output flag to write results to a file\n\nTool homepage:
  https://github.com/aidaanva/endorS.py"
inputs:
  - id: deduplicated_stats_file
    type:
      - 'null'
      - File
    doc: output of samtools flagstat in a txt file, whereby duplicate removal 
      has been performed on the input reads
    inputBinding:
      position: 101
      prefix: --deduplicated
  - id: output_name
    type:
      - 'null'
      - string
    doc: 'specify name for the output file. Default: extracted from the first samtools
      flagstat file provided'
    inputBinding:
      position: 101
      prefix: --name
  - id: qualityfiltered_stats_file
    type:
      - 'null'
      - File
    doc: output of samtools flagstat in a txt file, assumes some form of quality
      or length filtering has been performed, must be provided with at least one
      of the options -r or -dedup
    inputBinding:
      position: 101
      prefix: --qualityfiltered
  - id: raw_stats_file
    type:
      - 'null'
      - File
    doc: output of samtools flagstat in a txt file, assumes no quality filtering
      nor duplicate removal performed
    inputBinding:
      position: 101
      prefix: --raw
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: increase output verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'specify a file format for an output file. Options: <json> for a MultiQC
      json output. Default: none'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/endorspy:1.4--hdfd78af_0
