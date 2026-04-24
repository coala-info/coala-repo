cwlVersion: v1.2
class: CommandLineTool
baseCommand: jamm_JAMM.sh
label: jamm_JAMM.sh
doc: "Welcome to JAMM v1.0.7rev5 (GNU GPLv3). Copyright (C) 2014-2020  Mahmoud Ibrahim.\n\
  \nThis program comes with ABSOLUTELY NO WARRANTY; for details visit http://www.gnu.org/licenses/gpl.html.
  This is free software, and you are welcome to redistribute it under certain conditions;
  visit http://www.gnu.org/licenses/gpl.html for details.\n\nTool homepage: https://github.com/mahmoudibrahim/JAMM"
inputs:
  - id: bin_size
    type:
      - 'null'
      - string
    doc: Bin Size
    inputBinding:
      position: 101
      prefix: -b
  - id: control_dir
    type:
      - 'null'
      - Directory
    doc: directory containing input or Control files
    inputBinding:
      position: 101
      prefix: -c
  - id: fragment_lengths
    type:
      - 'null'
      - string
    doc: Fragment length(s)
    inputBinding:
      position: 101
      prefix: -f
  - id: genome_size_file
    type: File
    doc: Genome size file (required)
    inputBinding:
      position: 101
      prefix: -g
  - id: initialization
    type:
      - 'null'
      - string
    doc: clustering Initialization window selection, deterministic or stochastic
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_pcr_duplicates_single_end
    type:
      - 'null'
      - string
    doc: keep PCR Dupicates in single-end mode, y or n
    inputBinding:
      position: 101
      prefix: -d
  - id: minimum_window_size
    type:
      - 'null'
      - int
    doc: 'minimum Window size (default: 2 --- Note: this means minimum_window_size
      = bin_size x the_value_of_-w)'
    inputBinding:
      position: 101
      prefix: -w
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode, normal or narrow
    inputBinding:
      position: 101
      prefix: -m
  - id: num_processors
    type:
      - 'null'
      - int
    doc: Number of processors used by R scripts
    inputBinding:
      position: 101
      prefix: -p
  - id: resolution
    type:
      - 'null'
      - string
    doc: Resolution, peak or region or window
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_dir
    type: Directory
    doc: directory containing Sample files (required)
    inputBinding:
      position: 101
      prefix: -s
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the temporary working repository will be created. This 
      directory will be deleted after JAMM is done
    inputBinding:
      position: 101
      prefix: -T
  - id: type
    type:
      - 'null'
      - string
    doc: Type, single or paired
    inputBinding:
      position: 101
      prefix: -t
  - id: window_enrichment_cutoff
    type:
      - 'null'
      - string
    doc: window Enrichment cutoff, auto or any numeric value
    inputBinding:
      position: 101
      prefix: -e
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory (required)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jamm:1.0.8.0--hdfd78af_1
