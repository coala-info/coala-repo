cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystack_motifs
label: haystack_bio_haystack_motifs
doc: "Haystack Motifs Parameters\n\nTool homepage: https://github.com/rfarouni/haystack_bio"
inputs:
  - id: bed_target_filename
    type: File
    doc: A bed file containing the target coordinates on the genome of reference
    inputBinding:
      position: 1
  - id: genome_name
    type: string
    doc: Genome assembly to use from UCSC (for example hg19, mm9, etc.)
    inputBinding:
      position: 2
  - id: bed_bg_filename
    type:
      - 'null'
      - File
    doc: A bed file containing the backround coordinates on the genome of 
      reference (default random sampled regions from the genome)
    inputBinding:
      position: 103
      prefix: --bed_bg_filename
  - id: bed_score_column
    type:
      - 'null'
      - int
    doc: 'Column in the bedfile that represents the score (default: 5)'
    inputBinding:
      position: 103
      prefix: --bed_score_column
  - id: bg_target_ratio
    type:
      - 'null'
      - float
    doc: 'Background size/Target size ratio (default: 1.0)'
    inputBinding:
      position: 103
      prefix: --bg_target_ratio
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: 'Enable the bootstrap if the target set or the background set are too small,
      choices: True, False (default: False)'
    inputBinding:
      position: 103
      prefix: --bootstrap
  - id: c_g_bins
    type:
      - 'null'
      - int
    doc: 'Number of bins for the C+G density correction (default: 8)'
    inputBinding:
      position: 103
      prefix: --c_g_bins
  - id: disable_ratio
    type:
      - 'null'
      - boolean
    doc: Disable target/bg ratio filter
    inputBinding:
      position: 103
      prefix: --disable_ratio
  - id: dump
    type:
      - 'null'
      - boolean
    doc: 'Dump all the intermediate data, choices: True, False (default: False)'
    inputBinding:
      position: 103
      prefix: --dump
  - id: gene_annotations_filename
    type:
      - 'null'
      - File
    doc: Optional gene annotations file from the UCSC Genome Browser in bed 
      format to map each region to its closes gene
    inputBinding:
      position: 103
      prefix: --gene_annotations_filename
  - id: gene_ids_to_names_filename
    type:
      - 'null'
      - File
    doc: Optional mapping file between gene ids to gene names (relevant only if 
      --gene_annotation_filename is used)
    inputBinding:
      position: 103
      prefix: --gene_ids_to_names_filename
  - id: internal_window_length
    type:
      - 'null'
      - int
    doc: 'Window length in bp for the enrichment (default: average lenght of the target
      sequences)'
    inputBinding:
      position: 103
      prefix: --internal_window_length
  - id: mask_repetitive
    type:
      - 'null'
      - boolean
    doc: Mask repetitive sequences
    inputBinding:
      position: 103
      prefix: --mask_repetitive
  - id: meme_motifs_filename
    type:
      - 'null'
      - File
    doc: Motifs database in MEME format (default JASPAR CORE 2016)
    inputBinding:
      position: 103
      prefix: --meme_motifs_filename
  - id: min_central_enrichment
    type:
      - 'null'
      - float
    doc: Minimum central enrichment to report a motif (default:>1.0)
    inputBinding:
      position: 103
      prefix: --min_central_enrichment
  - id: n_processes
    type:
      - 'null'
      - int
    doc: 'Specify the number of processes to use. The default is #cores available.'
    inputBinding:
      position: 103
      prefix: --n_processes
  - id: n_target_coordinates
    type:
      - 'null'
      - int
    doc: 'Number of target coordinates to use (default: all)'
    inputBinding:
      position: 103
      prefix: --n_target_coordinates
  - id: name
    type:
      - 'null'
      - string
    doc: Define a custom output filename for the report
    inputBinding:
      position: 103
      prefix: --name
  - id: no_c_g_correction
    type:
      - 'null'
      - boolean
    doc: Disable the matching of the C+G density of the background
    inputBinding:
      position: 103
      prefix: --no_c_g_correction
  - id: no_random_sampling_target
    type:
      - 'null'
      - boolean
    doc: Select the best --n_target_coordinates using the score column from the 
      target file instead of randomly select them
    inputBinding:
      position: 103
      prefix: --no_random_sampling_target
  - id: nucleotide_bg_filename
    type:
      - 'null'
      - File
    doc: Nucleotide probability for the background in MEME format (default 
      precomupted on the Genome)
    inputBinding:
      position: 103
      prefix: --nucleotide_bg_filename
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: 'Output directory (default: current directory)'
    inputBinding:
      position: 103
      prefix: --output_directory
  - id: p_value
    type:
      - 'null'
      - float
    doc: 'FIMO p-value for calling a motif hit significant (deafult: 1e-4)'
    inputBinding:
      position: 103
      prefix: --p_value
  - id: smooth_size
    type:
      - 'null'
      - int
    doc: 'Size in bp for the smoothing window (default: internal_window_length/4)'
    inputBinding:
      position: 103
      prefix: --smooth_size
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: 'Directory to store temporary files (default: /tmp)'
    inputBinding:
      position: 103
      prefix: --temp_directory
  - id: use_entire_bg
    type:
      - 'null'
      - boolean
    doc: Use the entire background file (use only when the cg correction is 
      disabled)
    inputBinding:
      position: 103
      prefix: --use_entire_bg
  - id: window_length
    type:
      - 'null'
      - int
    doc: Window length in bp for the profiler (default:internal_window_length*5)
    inputBinding:
      position: 103
      prefix: --window_length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystack_bio:0.5.5--0
stdout: haystack_bio_haystack_motifs.out
