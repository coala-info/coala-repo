cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - endorspy
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
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'specify a file format for an output file. Options: <json> for a MultiQC
      json output. Default: none'
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Percent on target, clonality and percent duplicates printed to screen
  - id: output_file
    type:
      - 'null'
      - File
    doc: MultiQC json file named <name>_percent_on_target_mqc.json (written with --output json)
    outputBinding:
      glob: '*_percent_on_target_mqc.json'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/endorspy:1.4--hdfd78af_0
stdout: endorspy.out
