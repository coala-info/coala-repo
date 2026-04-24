cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainphlan
label: metaphlan_strainphlan
doc: "StrainPhlAn is a tool for the reconstruction of bacterial strains and their
  phylogenetic analysis.\n\nTool homepage: https://github.com/biobakery/metaphlan"
inputs:
  - id: breadth_thres
    type:
      - 'null'
      - int
    doc: Threshold defining the minimum breadth of coverage for the markers
    inputBinding:
      position: 101
      prefix: --breadth_thres
  - id: clade
    type:
      - 'null'
      - string
    doc: The clade to investigate
    inputBinding:
      position: 101
      prefix: --clade
  - id: clade_markers
    type:
      - 'null'
      - File
    doc: The clade markers as FASTA file
    inputBinding:
      position: 101
      prefix: --clade_markers
  - id: database
    type:
      - 'null'
      - string
    doc: The input MetaPhlAn 4.2.4 database
    inputBinding:
      position: 101
      prefix: --database
  - id: debug
    type:
      - 'null'
      - boolean
    doc: If specified, StrainPhlAn will not remove the temporary folders
    inputBinding:
      position: 101
      prefix: --debug
  - id: marker_in_n_samples_perc
    type:
      - 'null'
      - float
    doc: Threshold defining the minimum percentage of primary samples to keep a 
      marker
    inputBinding:
      position: 101
      prefix: --marker_in_n_samples_perc
  - id: mutation_rates
    type:
      - 'null'
      - boolean
    doc: If specified, StrainPhlAn will produce a mutation rates table for each 
      of the aligned markers and a summary table for the concatenated MSA. This 
      operation can take long time to finish
    inputBinding:
      position: 101
      prefix: --mutation_rates
  - id: non_interactive
    type:
      - 'null'
      - boolean
    doc: If specified, StrainPhlAn will select the first SGB available when the 
      clade is specified at the species level
    inputBinding:
      position: 101
      prefix: --non_interactive
  - id: nprocs
    type:
      - 'null'
      - int
    doc: The number of threads to use
    inputBinding:
      position: 101
      prefix: --nprocs
  - id: output_dir
    type: Directory
    doc: The output directory
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: phylophlan_configuration
    type:
      - 'null'
      - File
    doc: The PhyloPhlAn configuration file
    inputBinding:
      position: 101
      prefix: --phylophlan_configuration
  - id: phylophlan_mode
    type:
      - 'null'
      - string
    doc: The presets for fast or accurate phylogenetic analysis
    inputBinding:
      position: 101
      prefix: --phylophlan_mode
  - id: phylophlan_params
    type:
      - 'null'
      - string
    doc: Additional phylophlan parameters
    inputBinding:
      position: 101
      prefix: --phylophlan_params
  - id: polymorphism_perc
    type:
      - 'null'
      - float
    doc: Threshold defining the maximum percentage of polymorphic sites in a 
      marker to be considered
    inputBinding:
      position: 101
      prefix: --polymorphism_perc
  - id: print_clades_only
    type:
      - 'null'
      - boolean
    doc: If specified, StrainPhlAn will only print the potential clades and stop
      the execution
    inputBinding:
      position: 101
      prefix: --print_clades_only
  - id: references
    type:
      - 'null'
      - type: array
        items: File
    doc: The reference genomes
    inputBinding:
      position: 101
      prefix: --references
  - id: sample_with_n_markers
    type:
      - 'null'
      - int
    doc: Threshold defining the minimum absolute number of markers for a sample 
      to be primary. This rule is combined with AND logic with 
      --sample_with_n_markers_perc
    inputBinding:
      position: 101
      prefix: --sample_with_n_markers
  - id: sample_with_n_markers_after_filt
    type:
      - 'null'
      - int
    doc: Threshold defining the minimum absolute number of markers after 
      filtering to keep a sample. This rule is combined with AND logic with 
      --sample_with_n_markers_after_filt_perc
    inputBinding:
      position: 101
      prefix: --sample_with_n_markers_after_filt
  - id: sample_with_n_markers_after_filt_perc
    type:
      - 'null'
      - float
    doc: Threshold defining the minimum percentage of markers kept after 
      filtering to keep a sample. This rule is combined with AND logic with 
      --sample_with_n_markers_after_filt
    inputBinding:
      position: 101
      prefix: --sample_with_n_markers_after_filt_perc
  - id: sample_with_n_markers_perc
    type:
      - 'null'
      - float
    doc: Threshold defining the minimum percentage of markers to for a sample to
      be primary. This rule is combined with AND logic with 
      --sample_with_n_markers
    inputBinding:
      position: 101
      prefix: --sample_with_n_markers_perc
  - id: samples
    type:
      - 'null'
      - type: array
        items: File
    doc: The reconstructed markers for each sample
    inputBinding:
      position: 101
      prefix: --samples
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: If specified, the directory where to store the temporary files.
    inputBinding:
      position: 101
      prefix: --tmp
  - id: treeshrink
    type:
      - 'null'
      - boolean
    doc: If specified, StrainPhlAn will execute TreeShrink after building the 
      tree
    inputBinding:
      position: 101
      prefix: --treeshrink
  - id: trim_sequences
    type:
      - 'null'
      - int
    doc: The number of bases to remove from both ends when trimming markers
    inputBinding:
      position: 101
      prefix: --trim_sequences
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan:4.2.4--pyhdfd78af_0
stdout: metaphlan_strainphlan.out
