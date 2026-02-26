cwlVersion: v1.2
class: CommandLineTool
baseCommand: lovis4u
label: lovis4u
doc: "LoVis4u (version 0.1.7): Visualizes genomic loci and their features.\n\nTool
  homepage: https://art-egorov.github.io/lovis4u/"
inputs:
  - id: add_hmm_models
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Add your own hmm models database for hmmscan search. Folder should contain
      files in HMMER format (one file per model). Usage: -hmm path [name]. Specifying
      name is optional, by default it will be taken from them folder name. If you
      want to add multiple hmm databases you can use this argument several times:
      -hmm path1 -hmm path2.'
    inputBinding:
      position: 101
      prefix: --add-hmm-models
  - id: add_locus_id_prefix
    type:
      - 'null'
      - boolean
    doc: Add locus id prefix to each feature id.
    inputBinding:
      position: 101
      prefix: --add-locus-id-prefix
  - id: align_loci
    type:
      - 'null'
      - boolean
    doc: If a conserved protein with homologues present in all loci exists, then
      LoVis4u automatically defines the visualisation window starting from that 
      protein family.
    inputBinding:
      position: 101
      prefix: --align-loci
  - id: bedgraph_colours
    type:
      - 'null'
      - type: array
        items: string
    doc: List of colours for bedgraph/bigWig tracks (order the same as order of 
      bedGraph/bigWig files) Each value can be either HEX code of colour name 
      (e.g. pink, blue, etc (from the palette file))
    inputBinding:
      position: 101
      prefix: --bedgraph-colours
  - id: bedgraph_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: List of labels for bedgraph/bigWig tracks (order the same as order of 
      bedgraph/bigWig files) By default basename of files will be used.
    inputBinding:
      position: 101
      prefix: --bedgraph-labels
  - id: bedgraphs
    type:
      - 'null'
      - type: array
        items: File
    doc: Space separated list of paths to bedGraph files to plot coverage 
      profiles. (>=1 file) ! Can be applied only for single locus.
    inputBinding:
      position: 101
      prefix: --bedgraphs
  - id: bigwigs
    type:
      - 'null'
      - type: array
        items: File
    doc: Space separated list of paths to bigWig files to plot coverage 
      profiles. (>=1 file) ! Can be applied only for single locus.
    inputBinding:
      position: 101
      prefix: --bigwigs
  - id: category_colour_table
    type:
      - 'null'
      - File
    doc: Path to the table with colour code for categories. Default table can be
      found in lovis4u_data folder.
    inputBinding:
      position: 101
      prefix: --category-colour-table
  - id: clust_loci_off
    type:
      - 'null'
      - boolean
    doc: Deactivate defining locus order and using similarity based hierarchical
      clustering of proteomes.
    inputBinding:
      position: 101
      prefix: --clust_loci-off
  - id: cluster_only_window_proteins
    type:
      - 'null'
      - boolean
    doc: Cluster only proteins that are overlapped with the visualisation 
      windows, not all.
    inputBinding:
      position: 101
      prefix: --cluster-only-window-proteins
  - id: config
    type:
      - 'null'
      - string
    doc: 'Path to a configuration file or name of a pre-made config file [default:
      standard]'
    default: standard
    inputBinding:
      position: 101
      prefix: -c
  - id: data
    type:
      - 'null'
      - boolean
    doc: Creates the 'lovis4u_data' folder in the current working directory. The
      folder contains adjustable configuration files used by lovis4u (e.g. 
      config, palettes...)
    inputBinding:
      position: 101
      prefix: --data
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Provide detailed stack trace for debugging purposes.
    inputBinding:
      position: 101
      prefix: --debug
  - id: defence_models
    type:
      - 'null'
      - string
    doc: 'Choose which defence system database to use for hmmscan search [default:
      both (DefenseFinder and PADLOC)]'
    default: both (DefenseFinder and PADLOC)
    inputBinding:
      position: 101
      prefix: --defence-models
  - id: draw_middle_line
    type:
      - 'null'
      - boolean
    doc: Draw middle line for each locus.
    inputBinding:
      position: 101
      prefix: --draw-middle-line
  - id: feature_annotation_file
    type:
      - 'null'
      - File
    doc: Path to the feature annotation table. (See documentation for details)
    inputBinding:
      position: 101
      prefix: --feature-annotation-file
  - id: figure_width
    type:
      - 'null'
      - float
    doc: Output figure width in mm.
    inputBinding:
      position: 101
      prefix: --figure-width
  - id: find_variable_off
    type:
      - 'null'
      - boolean
    doc: Deactivate annotation of variable or conserved protein clusters.
    inputBinding:
      position: 101
      prefix: --find-variable-off
  - id: gb_folder
    type: Directory
    doc: Path to a folder containing genbank files.
    inputBinding:
      position: 101
      prefix: -gb
  - id: gc_skew_track
    type:
      - 'null'
      - boolean
    doc: Show GC skew track. ! Can be applied only for single locus.
    inputBinding:
      position: 101
      prefix: --gc_skew-track
  - id: gc_track
    type:
      - 'null'
      - boolean
    doc: Show GC content track. ! Can be applied only for single locus.
    inputBinding:
      position: 101
      prefix: --gc-track
  - id: get_hmms
    type:
      - 'null'
      - boolean
    doc: Download HMMs (hmmscan format) of defence, anti-defence, virulence, and
      AMR proteins from our server [data-sharing.atkinson-lab.com]
    inputBinding:
      position: 101
      prefix: --get-hmms
  - id: gff_folder
    type: Directory
    doc: Path to a folder containing extended gff files. Each gff file should 
      contain corresponding nucleotide sequence. (designed to handle pharokka 
      produced annotation files).
    inputBinding:
      position: 101
      prefix: -gff
  - id: hide_x_axis
    type:
      - 'null'
      - boolean
    doc: Do not plot individual x-axis for each locus track.
    inputBinding:
      position: 101
      prefix: --hide-x-axis
  - id: homology_links
    type:
      - 'null'
      - boolean
    doc: Draw homology link track.
    inputBinding:
      position: 101
      prefix: --homology-links
  - id: ignored_feature_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: "Space-separated list of feature names for which label won't be shown. [default:
      hypothetical protein, unknown protein]"
    default: hypothetical protein, unknown protein
    inputBinding:
      position: 101
      prefix: --ignored-feature-labels
  - id: keep_default_category
    type:
      - 'null'
      - boolean
    doc: 'Keep default category for proteins that have hits with hmmscan search. [default:
      category is replaced with database name]'
    inputBinding:
      position: 101
      prefix: --keep-default-category
  - id: keep_default_name
    type:
      - 'null'
      - boolean
    doc: 'Keep default names and labels for proteins that have hits with hmmscan search.
      [default: name is replaced with target hmm model name]'
    inputBinding:
      position: 101
      prefix: --keep-default-name
  - id: linux
    type:
      - 'null'
      - boolean
    doc: Replaces the mmseqs path in the pre-made config file from the MacOS 
      version [default] to the Linux version.
    inputBinding:
      position: 101
      prefix: --linux
  - id: locus_annotation_file
    type:
      - 'null'
      - File
    doc: Path to the locus annotation table. (See documentation for details)
    inputBinding:
      position: 101
      prefix: --locus-annotation-file
  - id: locus_label_position
    type:
      - 'null'
      - string
    doc: Locus label position on figure.
    inputBinding:
      position: 101
      prefix: --locus-label-position
  - id: locus_label_style
    type:
      - 'null'
      - string
    doc: Locus label style based on input sequence annotation.
    inputBinding:
      position: 101
      prefix: --locus-label-style
  - id: mac
    type:
      - 'null'
      - boolean
    doc: Replaces the mmseqs path in the pre-made config file from the Linux 
      version [default] to the MacOS version.
    inputBinding:
      position: 101
      prefix: --mac
  - id: mm_per_nt
    type:
      - 'null'
      - float
    doc: 'Scale which defines given space for each nt cell on canvas. [default: 0.05]'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --mm-per-nt
  - id: mmseqs_coverage
    type:
      - 'null'
      - float
    doc: MMSeqs2 parameter for minimal coverage during clustering.
    inputBinding:
      position: 101
      prefix: --mmseqs-coverage
  - id: mmseqs_min_seq_id
    type:
      - 'null'
      - float
    doc: MMSeqs2 parameter for minimal sequence identity during clustering.
    inputBinding:
      position: 101
      prefix: --mmseqs-min-seq-id
  - id: mmseqs_off
    type:
      - 'null'
      - boolean
    doc: Deactivate mmseqs clustering of proteomes of loci.
    inputBinding:
      position: 101
      prefix: --mmseqs-off
  - id: one_cluster
    type:
      - 'null'
      - boolean
    doc: Consider all sequences to be members of one cluster but use clustering 
      dendrogram to define the optimal order.
    inputBinding:
      position: 101
      prefix: --one-cluster
  - id: only_mine_hmms
    type:
      - 'null'
      - boolean
    doc: Force to use only models defined by user with -hmm, --add-hmm-models 
      parameter.
    inputBinding:
      position: 101
      prefix: --only-mine-hmms
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'Output dir name. It will be created if it does not exist. [default: lovis4u_{current_date};
      e.g. uorf4u_2022_07_25-20_41]'
    default: lovis4u_{current_date}; e.g. uorf4u_2022_07_25-20_41
    inputBinding:
      position: 101
      prefix: -o
  - id: parsing_debug
    type:
      - 'null'
      - boolean
    doc: Provide detailed stack trace for debugging purposes for failed reading 
      of gff/gb files.
    inputBinding:
      position: 101
      prefix: --parsing-debug
  - id: pdf_name
    type:
      - 'null'
      - string
    doc: 'Name of the output pdf file (will be saved in the output folder). [default:
      lovis4u.pdf]'
    default: lovis4u.pdf
    inputBinding:
      position: 101
      prefix: --pdf-name
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't show progress messages.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reorient_loci
    type:
      - 'null'
      - boolean
    doc: Auto re-orient loci (set new strands) if they are not matched. 
      (Function tries to maximise co-orientation of homologous features.)
    inputBinding:
      position: 101
      prefix: --reorient_loci
  - id: run_hmmscan
    type:
      - 'null'
      - boolean
    doc: Run hmmscan search for additional functional annotation.
    inputBinding:
      position: 101
      prefix: --hmmscan
  - id: scale_line_track
    type:
      - 'null'
      - boolean
    doc: Draw scale line track.
    inputBinding:
      position: 101
      prefix: --scale-line-track
  - id: set_category_colour
    type:
      - 'null'
      - boolean
    doc: Set category colour for features and plot category colour legend.
    inputBinding:
      position: 101
      prefix: --set-category-colour
  - id: set_group_colour_for
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Space-separated list of feature groups for which colours should be set.
      [default: variable, labeled]'
    default: variable, labeled
    inputBinding:
      position: 101
      prefix: --set-group-colour-for
  - id: set_group_colour_off
    type:
      - 'null'
      - boolean
    doc: Deactivate auto-setting of feature fill and stroke colours. (Pre-set 
      colours specified in feature annotation table will be kept.)
    inputBinding:
      position: 101
      prefix: --set-group-colour-off
  - id: set_mmseqs_path
    type:
      - 'null'
      - string
    doc: Specify mmseqs path that will be used by LoVis4u. Can be either full 
      path to the binary mmseqs, "default_mac", or "default_linux". In case if 
      mmseqs is installed in the system and available without specifying its 
      path, you can run "-smp mmseqs" and this should work.
    inputBinding:
      position: 101
      prefix: --set-mmseqs-path
  - id: show_all_feature_labels
    type:
      - 'null'
      - boolean
    doc: Display all feature labels.
    inputBinding:
      position: 101
      prefix: --show-all-feature-labels
  - id: show_all_labels_for_query
    type:
      - 'null'
      - boolean
    doc: 'Force to show all labels for proteins that have hits to any database with
      hmmscan search. [default: False]'
    default: false
    inputBinding:
      position: 101
      prefix: --show-all-labels-for-query
  - id: show_feature_label_for
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Space-separated list of feature groups for which label should be shown.
      [default: variable, labeled]'
    default: variable, labeled
    inputBinding:
      position: 101
      prefix: --show-feature-label-for
  - id: show_first_feature_label_for
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Space-separated list of feature group types for which label will be displayed
      only for the first occurrence of feature homologues group. [default: shell/core]'
    default: shell/core
    inputBinding:
      position: 101
      prefix: --show-first-feature-label-for
  - id: show_first_noncoding_label
    type:
      - 'null'
      - boolean
    doc: 'Show labels only for the first occurrence for non-coding features. [default:
      False]'
    default: false
    inputBinding:
      position: 101
      prefix: --show-first-noncoding-label
  - id: show_noncoding_labels
    type:
      - 'null'
      - boolean
    doc: 'Show all labels for non-coding features. [default: False]'
    default: false
    inputBinding:
      position: 101
      prefix: --show-noncoding-labels
  - id: show_x_axis
    type:
      - 'null'
      - boolean
    doc: Plot individual x-axis for each locus track.
    inputBinding:
      position: 101
      prefix: --show-x-axis
  - id: use_filename_as_id
    type:
      - 'null'
      - boolean
    doc: Use filename (wo extension) as track (contig) id instead of the contig 
      id written in the gff/gb file.
    inputBinding:
      position: 101
      prefix: --use-filename-as-id
  - id: window_by_proteins
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify window of visualisation by protein id from any locus. If 
      homologues of these proteins are encoded by each locus, then coordinates 
      of visualisation will be defined automatically. If you want to start 
      visualisation from a particular protein (to rotate loci), you can specify 
      it for start and end ('-wp protein_id1 protein_id1')
    inputBinding:
      position: 101
      prefix: --window-by-proteins
  - id: windows
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify window of visualisation (coordinates) for a locus or multiple 
      loci
    inputBinding:
      position: 101
      prefix: --windows
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lovis4u:0.1.7--pyh7e72e81_0
stdout: lovis4u.out
