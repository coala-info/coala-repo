cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgGcPercent
label: makehub_hgGcPercent
doc: "Calculate GC Percentage in 20kb windows\n\nTool homepage: https://github.com/Gaius-Augustus/MakeHub"
inputs:
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 1
  - id: nib_dir
    type: Directory
    doc: Directory containing .2bit file or *.nib files
    inputBinding:
      position: 2
  - id: bed_region_in
    type:
      - 'null'
      - File
    doc: Read in a bed file for GC content in specific regions and write to 
      bedRegionsOut
    inputBinding:
      position: 103
      prefix: -bedRegionIn
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Process only chrN from the nibDir
    inputBinding:
      position: 103
      prefix: -chr
  - id: do_gaps
    type:
      - 'null'
      - boolean
    doc: 'Process gaps correctly (default: gaps are not counted as GC)'
    inputBinding:
      position: 103
      prefix: -doGaps
  - id: no_dots
    type:
      - 'null'
      - boolean
    doc: Do not display ... progress during processing
    inputBinding:
      position: 103
      prefix: -noDots
  - id: no_load
    type:
      - 'null'
      - boolean
    doc: Do not load mysql table - create bed file
    inputBinding:
      position: 103
      prefix: -noLoad
  - id: no_random
    type:
      - 'null'
      - boolean
    doc: Ignore random chromosomes from the nibDir
    inputBinding:
      position: 103
      prefix: -noRandom
  - id: overlap
    type:
      - 'null'
      - int
    doc: Overlap windows by N bases
    default: 0
    inputBinding:
      position: 103
      prefix: -overlap
  - id: verbose
    type:
      - 'null'
      - int
    doc: Display details to stderr during processing
    inputBinding:
      position: 103
      prefix: -verbose
  - id: wig_out
    type:
      - 'null'
      - boolean
    doc: Output wiggle ascii data ready to pipe to wigEncode
    inputBinding:
      position: 103
      prefix: -wigOut
  - id: window_size
    type:
      - 'null'
      - int
    doc: Change windows size
    default: 20000
    inputBinding:
      position: 103
      prefix: -win
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output to filename (stdout OK)
    outputBinding:
      glob: $(inputs.output_file)
  - id: bed_region_out
    type:
      - 'null'
      - File
    doc: Write a bed file of GC content in specific regions from bedRegionIn
    outputBinding:
      glob: $(inputs.bed_region_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/makehub:1.0.8--hdfd78af_1
