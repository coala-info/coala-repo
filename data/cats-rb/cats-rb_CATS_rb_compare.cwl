cwlVersion: v1.2
class: CommandLineTool
baseCommand: cats-rb_compare
label: cats-rb_CATS_rb_compare
doc: "transcriptome assembly comparison script\n\nTool homepage: https://github.com/bodulic/CATS-rb"
inputs:
  - id: genome
    type: string
    doc: Genome file
    inputBinding:
      position: 1
  - id: transcriptome_map_dir1
    type:
      type: array
      items: Directory
    doc: Transcriptome map directory
    inputBinding:
      position: 2
  - id: aligned_transcript_distribution_breakpoints
    type:
      - 'null'
      - string
    doc: Proportion of aligned transcript distribution breakpoints (specified 
      with x,y,z...)
    inputBinding:
      position: 103
      prefix: -A
  - id: alignment_proportion_threshold
    type:
      - 'null'
      - float
    doc: Alignment proportion threshold for structural inconsistency detection
    inputBinding:
      position: 103
      prefix: -M
  - id: barplot_colors
    type:
      - 'null'
      - string
    doc: Barplot colors (quoted hexadecimal codes or R color names, specified 
      with x,y,z...)
    inputBinding:
      position: 103
      prefix: -b
  - id: common_element_set_relative_length_breakpoints
    type:
      - 'null'
      - string
    doc: Common element set relative length distribution breakpoints (specified 
      with x,y,z...)
    inputBinding:
      position: 103
      prefix: -R
  - id: comparison_output_directory
    type:
      - 'null'
      - Directory
    doc: Comparison output directory name
    inputBinding:
      position: 103
      prefix: -D
  - id: element_set_coverage_proportion_breakpoints
    type:
      - 'null'
      - string
    doc: Proportion of element sets covered by a GTF set distribution 
      breakpoints (specified with x,y,z...)
    inputBinding:
      position: 103
      prefix: -s
  - id: exon_set_location_plot_colors
    type:
      - 'null'
      - string
    doc: Exon set genomic location plot colors (quoted hexadecimal codes or R 
      color names, specified with x,y,z...)
    inputBinding:
      position: 103
      prefix: -n
  - id: figure_dpi
    type:
      - 'null'
      - int
    doc: Figure DPI
    inputBinding:
      position: 103
      prefix: -d
  - id: figure_extension
    type:
      - 'null'
      - string
    doc: Figure extension
    inputBinding:
      position: 103
      prefix: -x
  - id: gtf_gff3_file
    type:
      - 'null'
      - File
    doc: GTF/GFF3 file for the annotation-based analysis
    inputBinding:
      position: 103
      prefix: -F
  - id: hierarchical_clustering_heatmap_colors
    type:
      - 'null'
      - string
    doc: Hierarchical clustering heatmap colors (quoted hexadecimal codes or R 
      color names, specified with x,y,z...)
    inputBinding:
      position: 103
      prefix: -c
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: Maximum intron length (in bp)
    inputBinding:
      position: 103
      prefix: -i
  - id: max_right_tail_quantile
    type:
      - 'null'
      - float
    doc: Maximum right-tail distribution quantile for raincloud plots
    inputBinding:
      position: 103
      prefix: -q
  - id: max_transcript_segment_overlap
    type:
      - 'null'
      - float
    doc: Maximum proportion of allowed transcript segment overlap for 
      identification of segments mapping to disjunct genomic regions
    inputBinding:
      position: 103
      prefix: -C
  - id: max_transcript_set_length
    type:
      - 'null'
      - int
    doc: Maximum transcript set length for completeness analysis (in bp)
    inputBinding:
      position: 103
      prefix: -m
  - id: min_completeness_threshold
    type:
      - 'null'
      - float
    doc: Minimum completeness threshold for assigning an element set to a Venn 
      set
    inputBinding:
      position: 103
      prefix: -V
  - id: min_exon_identity_proportion
    type:
      - 'null'
      - float
    doc: Minimum exon identity proportion
    inputBinding:
      position: 103
      prefix: -p
  - id: min_exon_length
    type:
      - 'null'
      - int
    doc: Minimum exon length (in bp)
    inputBinding:
      position: 103
      prefix: -e
  - id: min_exon_set_coverage_proportion
    type:
      - 'null'
      - float
    doc: Minimum proportion of an exon set that must be covered to be considered
      a match to a GTF exon set (and vice versa)
    inputBinding:
      position: 103
      prefix: -g
  - id: min_exon_set_length
    type:
      - 'null'
      - int
    doc: Minimum exon set length for completeness analysis (in bp)
    inputBinding:
      position: 103
      prefix: -l
  - id: min_exon_set_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap between exon sets for edge specification (in bp)
    inputBinding:
      position: 103
      prefix: -j
  - id: min_transcript_set_coverage_proportion
    type:
      - 'null'
      - float
    doc: Minimum proportion of a transcript set that must be covered to be 
      considered a match to a GTF transcript set (and vice versa)
    inputBinding:
      position: 103
      prefix: -G
  - id: min_transcript_set_length
    type:
      - 'null'
      - int
    doc: Minimum transcript set length for completeness analysis (in bp)
    inputBinding:
      position: 103
      prefix: -L
  - id: min_transcript_set_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap between transcript sets for edge specification (in bp)
    inputBinding:
      position: 103
      prefix: -J
  - id: min_transcript_set_to_transcript_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap between transcript set and transcript for isoform 
      specification (in bp)
    inputBinding:
      position: 103
      prefix: -o
  - id: num_cpu_threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    inputBinding:
      position: 103
      prefix: -t
  - id: num_exons_per_transcript_breakpoints
    type:
      - 'null'
      - string
    doc: Number of exons per transcript distribution breakpoints (specified with
      x,y,z...)
    inputBinding:
      position: 103
      prefix: -N
  - id: num_genomic_bins
    type:
      - 'null'
      - int
    doc: Number of genomic bins for exon set genomic location plot
    inputBinding:
      position: 103
      prefix: -B
  - id: num_isoforms_per_transcript_set_breakpoints
    type:
      - 'null'
      - string
    doc: Number of isoforms per transcript set distribution breakpoints 
      (specified with x,y,z...)
    inputBinding:
      position: 103
      prefix: -I
  - id: num_longest_element_sets_clustering
    type:
      - 'null'
      - int
    doc: Number of longest element sets used in hierarchical clustering
    inputBinding:
      position: 103
      prefix: -H
  - id: num_longest_scaffolds
    type:
      - 'null'
      - string
    doc: Number of longest genomic scaffolds for exon set genomic location plot
    inputBinding:
      position: 103
      prefix: -f
  - id: overwrite_output_directory
    type:
      - 'null'
      - boolean
    doc: Overwrite the comparison output directory
    inputBinding:
      position: 103
      prefix: -O
  - id: pairwise_similarity_tileplot_colors
    type:
      - 'null'
      - string
    doc: Pairwise similarity tileplot colors (quoted hexadecimal codes or R 
      color names, specified with x,y,z...)
    inputBinding:
      position: 103
      prefix: -y
  - id: raincloud_plot_colors
    type:
      - 'null'
      - string
    doc: Raincloud plot colors (quoted hexadecimal codes or R color names, 
      specified with x,y,z...)
    inputBinding:
      position: 103
      prefix: -r
  - id: stranded_analysis
    type:
      - 'null'
      - boolean
    doc: Enable stranded analysis
    inputBinding:
      position: 103
      prefix: -S
  - id: transcript_set_proximity_region
    type:
      - 'null'
      - int
    doc: Transcript set proximity region length for unique exon set analysis (in
      bp)
    inputBinding:
      position: 103
      prefix: -P
  - id: upset_plot_colors
    type:
      - 'null'
      - string
    doc: UpSet plot bar and matrix colors (quoted hexadecimal codes or R color 
      names, specified with x,y)
    inputBinding:
      position: 103
      prefix: -u
  - id: use_raster_heatmap
    type:
      - 'null'
      - boolean
    doc: Use raster for heatmap plotting
    inputBinding:
      position: 103
      prefix: -E
  - id: venn_diagram_colors
    type:
      - 'null'
      - string
    doc: Venn diagram colors (quoted hexadecimal codes or R color names, 
      specified with x,y,z...)
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rb:1.0.3--hdfd78af_0
stdout: cats-rb_CATS_rb_compare.out
