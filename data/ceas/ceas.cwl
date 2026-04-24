cwlVersion: v1.2
class: CommandLineTool
baseCommand: ceas
label: ceas
doc: "CEAS (Cis-regulatory Element Annotation System)\n\nTool homepage: https://github.com/jhardy/compass-ceaser-easing"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: input files
    inputBinding:
      position: 1
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file of ChIP regions.
    inputBinding:
      position: 102
      prefix: --bed
  - id: bidirectional_promoter_sizes
    type:
      - 'null'
      - string
    doc: 'Bidirectional-promoter sizes for ChIP region annotation Comma-separated
      two values or a single value can be given. If a single value is given, it will
      be segmented into two equal fractions (ie, 5000 is equivalent to 2500,5000)
      DEFAULT: 2500,5000bp. WARNING: Values > 20000bp are automatically set to 20000bp.'
    inputBinding:
      position: 102
      prefix: --bisizes
  - id: dump_raw_profiles
    type:
      - 'null'
      - boolean
    doc: Whether to save the raw profiles of near TSS, TTS, and gene body. The 
      file names have a suffix of 'TSS', 'TTS', and 'gene' after the name.
    inputBinding:
      position: 102
      prefix: --dump
  - id: experiment_name
    type:
      - 'null'
      - string
    doc: Experiment name. This will be used to name the output files. If an 
      experiment name is not given, the stem of the input BED file name will be 
      used instead (eg, if 'peaks.bed', 'peaks' will be used as a name.)
    inputBinding:
      position: 102
      prefix: --name
  - id: extra_bed_file
    type:
      - 'null'
      - File
    doc: BED file of extra regions of interest (eg, non-coding regions)
    inputBinding:
      position: 102
      prefix: --ebed
  - id: gene_annotation_db
    type:
      - 'null'
      - File
    doc: Gene annotation table (eg, a refGene table in sqlite3 db format 
      provided through the CEAS web, 
      http://liulab.dfci.harvard.edu/CEAS/download.html).
    inputBinding:
      position: 102
      prefix: --gt
  - id: gene_centered_span
    type:
      - 'null'
      - int
    doc: Span from TSS and TTS in the gene-centered annotation. ChIP regions 
      within this range from TSS and TTS are considered when calculating the 
      coverage rates in promoter and downstream, DEFAULT=3000bp
    inputBinding:
      position: 102
      prefix: --span
  - id: gene_group_names
    type:
      - 'null'
      - string
    doc: The names of the gene groups in --gn-groups. The gene group names are 
      separated by commas. (eg, --gn-group-names='top 10%,bottom 10%'). These 
      group names appear in the legends of the wig profiling plots. If no group 
      names given, the groups are represented as 'Group 1, Group2,...Group n'.
    inputBinding:
      position: 102
      prefix: --gn-group-names
  - id: gene_groups_of_interest
    type:
      - 'null'
      - string
    doc: Gene-groups of particular interest in wig profiling. Each gene group 
      file must have gene names in the 1st column. The file names are separated 
      by commas w/ no space (eg, --gn-groups=top10.txt,bottom10.txt)
    inputBinding:
      position: 102
      prefix: --gn-groups
  - id: promoter_sizes
    type:
      - 'null'
      - string
    doc: 'Promoter (also dowsntream) sizes for ChIP region annotation. Comma-separated
      three values or a single value can be given. If a single value is given, it
      will be segmented into three equal fractions (ie, 3000 is equivalent to 1000,2000,3000),
      DEFAULT: 1000,2000,3000. WARNING: Values > 10000bp are automatically set to
      10000bp.'
    inputBinding:
      position: 102
      prefix: --sizes
  - id: relative_distance_to_tss_tts
    type:
      - 'null'
      - int
    doc: 'Relative distance to TSS/TTS in wig profiling, DEFAULT: 3000bp'
    inputBinding:
      position: 102
      prefix: --rel-dist
  - id: run_genome_bg_annotation
    type:
      - 'null'
      - boolean
    doc: 'Run genome BG annotation again. WARNING: This flag is effective only if
      a WIG file is given through -w (--wig). Otherwise, ignored.'
    inputBinding:
      position: 102
      prefix: --bg
  - id: use_name2_column
    type:
      - 'null'
      - boolean
    doc: Whether or not use the 'name2' column of the gene annotation table when
      reading the gene IDs in the files given through --gn-groups. This flag is 
      meaningful only with --gn-groups.
    inputBinding:
      position: 102
      prefix: --gname2
  - id: wig_file
    type:
      - 'null'
      - File
    doc: 'WIG file for either wig profiling or genome background annotation. WARNING:
      --bg flag must be set for genome background re-annotation.'
    inputBinding:
      position: 102
      prefix: --wig
  - id: wig_profiling_resolution
    type:
      - 'null'
      - int
    doc: 'Wig profiling resolution, DEFAULT: 50bp. WARNING: Value smaller than the
      wig interval (resolution) may cause aliasing error.'
    inputBinding:
      position: 102
      prefix: --pf-res
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ceas:1.0.2--py27_1
stdout: ceas.out
