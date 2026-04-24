cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - write_most_significant_fasta
label: tombo_write_most_significant_fasta
doc: "Write FASTA file of sequences from the most significant regions based on Tombo
  statistics.\n\nTool homepage: https://github.com/nanoporetech/tombo"
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
      - 'null'
      - type: array
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
  - id: statistic_order
    type:
      - 'null'
      - boolean
    doc: 'Order selected locations by p-values or mean likelihood ratio. Default:
      fraction of significant reads.'
    inputBinding:
      position: 101
      prefix: --statistic-order
  - id: statistics_filename
    type: File
    doc: File to save/load base by base statistics.
    inputBinding:
      position: 101
      prefix: --statistics-filename
outputs:
  - id: sequences_filename
    type:
      - 'null'
      - File
    doc: File for sequences from selected regions. Sequences will be stored in 
      FASTA format.
    outputBinding:
      glob: $(inputs.sequences_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
