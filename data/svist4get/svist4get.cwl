cwlVersion: v1.2
class: CommandLineTool
baseCommand: svist4get
label: svist4get
doc: "a simple visualization tool for genomic tracks from sequencing experiments.\n\
  \nTool homepage: https://bitbucket.org/artegorov/svist4get/"
inputs:
  - id: aminoacid_sequence_style
    type:
      - 'null'
      - string
    doc: 'Style of the aminoacid sequence track: tics (suitable for long regions e.g.
      > 160 nts, shows only start and stop codons with colored tics) or codons (show
      each aminoacid as labeled block) (default: auto)'
    default: auto
    inputBinding:
      position: 101
      prefix: -aas
  - id: bedgraph_aggregation_function
    type:
      - 'null'
      - string
    doc: "This parameter sets the function to aggregate bedGraph signal values for
      a single bar of the bedGraph tracks. Default: 'mean'. Alternatives: 'median',
      'max', 'min'. 'none' forces plotting the raw signal at 1nt resolution."
    default: mean
    inputBinding:
      position: 101
      prefix: -bgb
  - id: bedgraph_colors
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Space-separated list of colors for bedGraph tracks. The colors should be
      specified by names listed in the palette file (default: internal palette or
      palettes/palette.txt). The list will be cycled through if shorter than the number
      of bedGraph tracks. Paired and basic bedGraph tracks use joint color list.'
    inputBinding:
      position: 101
      prefix: -bgc
  - id: bedgraph_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Paths to bedGraph files for genomic signal tracks
    inputBinding:
      position: 101
      prefix: -bg
  - id: bedgraph_label_position
    type:
      - 'null'
      - string
    doc: 'Text label position for the bedGraph tracks (default: center)'
    default: center
    inputBinding:
      position: 101
      prefix: -blp
  - id: bedgraph_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Text labels for the bedGraph tracks, space-separated list of values, a separate
      value required for each bedGraph track (default: names of the bedGraph files)'
    inputBinding:
      position: 101
      prefix: -bl
  - id: bedgraph_log_scale
    type:
      - 'null'
      - boolean
    doc: Logarithmic (log2) scale for the each bedGraph (Y-axis).
    inputBinding:
      position: 101
      prefix: -bg_log
  - id: bedgraph_lower_limit
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Lower limit for a bedGraph track Y-axis, can be: 1. a space-separated list
      of values: a separate axis limit for each bedGraph track; 2. min: a minimum
      reachable value across all visible tracks. Paired bedGraph uses absolute values
      for both signal tracks, since the negative Y-axis range is used to display the
      2nd track.'
    inputBinding:
      position: 101
      prefix: -bll
  - id: bedgraph_upper_limit
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Upper limit for a bedGraph track Y-axis, can be: 1. a space-separated list
      of values: a separate axis limit for each bedGraph track; 2. max: a maximum
      reachable value across all visible tracks. Default: reachable maximum for each
      track separately.'
    inputBinding:
      position: 101
      prefix: -bul
  - id: bedgraph_yaxis_tics_levels
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Y axis tics levels for a bedGraph track, a space-separated list of values,
      a separate value for each bedGraph track (default: auto)'
    default: auto
    inputBinding:
      position: 101
      prefix: -lb
  - id: bedgraph_yaxis_tics_step
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Step between axis tics a the bedgraph track Y-axis, a space-separated list
      of values, a separate value for each bedGraph track (default: auto)'
    default: auto
    inputBinding:
      position: 101
      prefix: -ys
  - id: configuration_file
    type:
      - 'null'
      - string
    doc: Path to a configuration file or name of the premade config file (can be
      A4_p1, A4_p2, A4_l)
    inputBinding:
      position: 101
      prefix: -c
  - id: contig
    type:
      - 'null'
      - string
    doc: Visualization an arbitrary genomic window using genomic coordinates
    inputBinding:
      position: 101
      prefix: -w
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Provide detailed stack trace for debugging purposes
    inputBinding:
      position: 101
      prefix: --debug
  - id: end
    type:
      - 'null'
      - int
    doc: End coordinate for arbitrary genomic window visualization
    inputBinding:
      position: 101
  - id: gene_id
    type:
      - 'null'
      - string
    doc: Visualization of the genomic window of a particular gene (using GTF 
      gene_id)
    inputBinding:
      position: 101
      prefix: -g
  - id: genome_assembly_fasta
    type: File
    doc: 'Path to the genome assembly multifasta for the sequence track NOTE: the
      multifasta file must contain all contigs in a single file.'
    inputBinding:
      position: 101
      prefix: -fa
  - id: genomic_interval_colors
    type:
      - 'null'
      - type: array
        items: string
    doc: Space-separated list of colors for genomic intervals tracks, uses the 
      same logic as -bgc parameter
    inputBinding:
      position: 101
      prefix: -gic
  - id: genomic_interval_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Labels for genomic intervals, space-separated list of strings, a 
      separate value required for each gemomic intervals track
    inputBinding:
      position: 101
      prefix: -gil
  - id: genomic_intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional track showing selected genomic intervals as segments, 
      space-separated list of start-end pairs
    inputBinding:
      position: 101
      prefix: -gi
  - id: gtf_file
    type: File
    doc: Path to the gtf file with the transcript annotation
    inputBinding:
      position: 101
      prefix: -gtf
  - id: hide_intronic_segments
    type:
      - 'null'
      - boolean
    doc: 'Hide intronic segments (default: false)'
    default: false
    inputBinding:
      position: 101
      prefix: -hi
  - id: highlight_codon
    type:
      - 'null'
      - string
    doc: Highlight selected codon on the aminoacid sequence track, e.g. -hc TGA
    inputBinding:
      position: 101
      prefix: -hc
  - id: highlight_reading_frame
    type:
      - 'null'
      - int
    doc: Highlight a particular reading frame (+0, +1 or +2)
    inputBinding:
      position: 101
      prefix: -hrf
  - id: highlight_segment
    type:
      - 'null'
      - type: array
        items: string
    doc: Highlight and label a given segment of the genomic window (global 
      coordinates on the selected contig)
    inputBinding:
      position: 101
      prefix: -hf
  - id: image_title
    type:
      - 'null'
      - string
    doc: Image title
    inputBinding:
      position: 101
      prefix: -it
  - id: paired_bedgraph_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Paths to 2 bedGraph files to be used for the paired genomic signal 
      track (e.g. to plot signals for + and - DNA strands together). Positive 
      and negative range of the Y-axis will be used for the first and second 
      file, respectively (or vice versa if the reverse complementary 
      transformation using -rc parameter is requested) The track will use 
      absolute values from each bedGraph. Multiple paired tracks can be 
      generated by using multiple '-pbg' parameters. For this track, the signs 
      of values in each bedGraph will be ignored
    inputBinding:
      position: 101
      prefix: -pbg
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: 'Reverse-complement transformation of the genomic window (default: off)'
    default: false
    inputBinding:
      position: 101
      prefix: -rc
  - id: sampledata
    type:
      - 'null'
      - boolean
    doc: Creates the 'svist4get' folder in the current working directory. The 
      folder will contain sample data sets and adjustable configuration file 
      templates.
    inputBinding:
      position: 101
      prefix: --sampledata
  - id: show_reference_sequence
    type:
      - 'null'
      - boolean
    doc: 'Show reference genomic sequence with single-nucleotide resolution (default:
      hide)'
    inputBinding:
      position: 101
      prefix: -nts
  - id: show_transcripts
    type:
      - 'null'
      - type: array
        items: string
    doc: A complete list of transcript IDs to show (others will be hidden, 
      applicable to -w and -g modes)
    inputBinding:
      position: 101
      prefix: -st
  - id: start
    type:
      - 'null'
      - int
    doc: Start coordinate for arbitrary genomic window visualization
    inputBinding:
      position: 101
  - id: transcript_id
    type:
      - 'null'
      - string
    doc: Visualization of the genomic window of a particular transcript (using 
      GTF transcript_id)
    inputBinding:
      position: 101
      prefix: -t
  - id: transcript_label_replacement
    type:
      - 'null'
      - type: array
        items: string
    doc: Allows to replace the default <transcript_id> label with an arbitrary 
      text <label>. For re-labeling several transcripts, several '-tl' keys can 
      be used.
    inputBinding:
      position: 101
      prefix: -tl
  - id: transcript_label_style
    type:
      - 'null'
      - string
    doc: Transcript label style. Can be 'none' (hide the transcript label), 
      'name','id' or gene_id (show annotated transcript_name, transcript_id or 
      gene_id respectively as a transcript_label), 'both' (show annotated 
      transcript_name and transcript_id) and 'auto' (hide name if it is included
      in the ID)
    default: auto
    inputBinding:
      position: 101
      prefix: -tls
  - id: tss_tis
    type:
      - 'null'
      - string
    doc: Visualization of the genomic window centered on a transcription start 
      site|translation initiation site of a particular transcript (using GFF 
      transcript_id) with a fixed offsets upstream and downstream
    inputBinding:
      position: 101
      prefix: -t
  - id: tss_tis_downstream
    type:
      - 'null'
      - int
    doc: Downstream offset for tss|tis visualization
    inputBinding:
      position: 101
  - id: tss_tis_upstream
    type:
      - 'null'
      - int
    doc: Upstream offset for tss|tis visualization
    inputBinding:
      position: 101
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show all progress messages
    inputBinding:
      position: 101
      prefix: --verbose
  - id: xaxis_tics_step
    type:
      - 'null'
      - int
    doc: 'X axis tics step (nt) (default: auto)'
    default: auto
    inputBinding:
      position: 101
      prefix: -xs
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name. Generates a pdf (vector) or png (raster) file based 
      on the provided extension. Both png and pdf will be generated if the 
      extension is not specified.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svist4get:1.3.1.1--pyhdfd78af_0
