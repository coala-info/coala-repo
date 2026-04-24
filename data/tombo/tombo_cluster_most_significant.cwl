cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - cluster_most_significant
label: tombo_cluster_most_significant
doc: "Cluster and plot the most significant signal differences between two sets of
  FAST5 files.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup(s) (under Analyses/[corrected-group]) containing 
      basecalls.
    inputBinding:
      position: 101
      prefix: --basecall-subgroups
  - id: control_fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Control set of directories containing fast5 files. These reads should 
      contain only standard nucleotides.
    inputBinding:
      position: 101
      prefix: --control-fast5-basedirs
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    inputBinding:
      position: 101
      prefix: --corrected-group
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 101
      prefix: --fast5-basedirs
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: FASTA file used to re-squiggle. For faster sequence access.
    inputBinding:
      position: 101
      prefix: --genome-fasta
  - id: num_bases
    type:
      - 'null'
      - int
    doc: Number of bases to plot/output.
    inputBinding:
      position: 101
      prefix: --num-bases
  - id: num_regions
    type:
      - 'null'
      - int
    doc: Number of regions to plot.
    inputBinding:
      position: 101
      prefix: --num-regions
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes.
    inputBinding:
      position: 101
      prefix: --processes
  - id: q_value_threshold
    type:
      - 'null'
      - float
    doc: Plot all regions below provied q-value. Overrides --num-regions.
    inputBinding:
      position: 101
      prefix: --q-value-threshold
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: slide_span
    type:
      - 'null'
      - int
    doc: Number of bases offset over which to search when computing distances 
      for signal cluster plotting.
    inputBinding:
      position: 101
      prefix: --slide-span
  - id: statistics_filename
    type: File
    doc: File to save/load base by base statistics.
    inputBinding:
      position: 101
      prefix: --statistics-filename
outputs:
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    outputBinding:
      glob: $(inputs.pdf_filename)
  - id: r_data_filename
    type:
      - 'null'
      - File
    doc: Filename to save R data structure.
    outputBinding:
      glob: $(inputs.r_data_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
