cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloFlash_compare.pl
label: phyloflash_phyloFlash_compare.pl
doc: "Compare phyloFlash runs.\n\nTool homepage: https://github.com/HRGV/phyloFlash"
inputs:
  - id: allzip
    type:
      - 'null'
      - boolean
    doc: Use all phyloflash tar.gz archives in the current folder (by matching 
      filename *.phyloFlash.tar.gz) for a comparison run. Overrides anything 
      passed to option --zip.
    inputBinding:
      position: 101
      prefix: --allzip
  - id: barplot_palette
    type:
      - 'null'
      - string
    doc: 'Palette to color taxa in barplot. Should be one of the qualitative ColorBrewer2
      palettes: Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, or Set3.'
    default: Set3
    inputBinding:
      position: 101
      prefix: --barplot_palette
  - id: barplot_rawval
    type:
      - 'null'
      - boolean
    doc: 'Logical: Display counts rather than proportions in barplot, i.e. bars will
      not be rescaled to 100% for each sample.'
    default: false
    inputBinding:
      position: 101
      prefix: --barplot_rawval
  - id: barplot_scaleplotwidth
    type:
      - 'null'
      - float
    doc: 'Numeric: Change plot width by this scaling factor (e.g. 2 makes it twice
      as wide). Allows adjustment when bars are hidden because the legend labels are
      too long.'
    default: 1.0
    inputBinding:
      position: 101
      prefix: --barplot_scaleplotwidth
  - id: barplot_subset
    type:
      - 'null'
      - string
    doc: Display only the subset from this taxon, e.g. "Bacteria". Should be a 
      taxon string excluding trailing semicolon, e.g. "Bacteria;Proteobacteria".
    inputBinding:
      position: 101
      prefix: --barplot_subset
  - id: cluster_samples
    type:
      - 'null'
      - string
    doc: 'Clustering method to use for clustering/sorting samples in heatmap. Options:
      "alpha", "ward.D", "single", "complete", "average", "mcquitty", "median", "centroid",
      or "custom". "custom" will use the Unifrac-like abundance weighted taxonomic
      distances (the distance matrix can be separately output with --task matrix).
      This is an experimental (unpublished) metric similar to Unifrac, but using a
      taxonomy tree instead of a real phylogeny.'
    default: ward.D
    inputBinding:
      position: 101
      prefix: --cluster-samples
  - id: cluster_taxa
    type:
      - 'null'
      - string
    doc: 'Clustering method to use for clustering/sorting taxa. Options: "alpha",
      "ward", "single", "complete", "average", "mcquitty", "median", "centroid".'
    default: ward.D
    inputBinding:
      position: 101
      prefix: --cluster-taxa
  - id: csv_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-separated list of NTU abundance tables from phyloflash runs. The 
      files should be named [LIBNAME].phyloFlash.NTUabundance.csv or 
      [LIBNAME].phyloFlash.NTUfull_abundance.csv
    inputBinding:
      position: 101
      prefix: --csv
  - id: displaytaxa
    type:
      - 'null'
      - int
    doc: Number of top taxa to display in barplot. Integer between 3 and 12 is 
      preferable.
    default: 5
    inputBinding:
      position: 101
      prefix: --displaytaxa
  - id: keeptmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files
    default: false
    inputBinding:
      position: 101
      prefix: --keeptmp
  - id: level
    type:
      - 'null'
      - int
    doc: Taxonomic level to perform the comparison. Must be an integer between 1
      and 7.
    default: 4
    inputBinding:
      position: 101
      prefix: --level
  - id: log
    type:
      - 'null'
      - boolean
    doc: Save log file to file [OUTPREFIX].log
    default: false
    inputBinding:
      position: 101
      prefix: --log
  - id: long_taxnames
    type:
      - 'null'
      - boolean
    doc: Do not shorten taxa names to two last groups
    inputBinding:
      position: 101
      prefix: --long-taxnames
  - id: min_ntu_count
    type:
      - 'null'
      - int
    doc: Sum up NTUs with fewer counts into a pseudo-NTU "Other".
    default: 50
    inputBinding:
      position: 101
      prefix: --min-ntu-count
  - id: out
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    default: test.phyloFlash_compare
    inputBinding:
      position: 101
      prefix: --out
  - id: outfmt
    type:
      - 'null'
      - string
    doc: "Format for plots (tasks 'barplot' and 'heatmap' only). Options: \"pdf\"\
      , \"png\""
    default: pdf
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: task
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Type of analysis to be run. Options: "heatmap", "barplot", "matrix", "ntu_table"
      or a recognizable substring thereof. Supply more than one option as comma- separated
      list.'
    inputBinding:
      position: 101
      prefix: --task
  - id: use_sam
    type:
      - 'null'
      - boolean
    doc: Ignore NTU abundance tables in CSV format, and recalculate the NTU 
      abundances from SAM files in the compressed tar.gz phyloflash archives. 
      Useful if e.g. phyloflash was originally called to summarize the taxonomy 
      at a higher level than you want to use for the comparison. Only works if 
      the tar.gz archives from phyloflash runs are specified with the --zip 
      option above.
    default: false
    inputBinding:
      position: 101
      prefix: --use_SAM
  - id: zip_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-separated list of tar.gz archives from phyloflash runs. These 
      will be parsed to search for the [LIBNAME].phyloFlash.NTUabundance.csv 
      files within the archive, to extract the NTU classifications. This assumes
      that the archive filenames are named [LIBNAME].phyloFlash.tar.gz, and that
      the LIBNAME matches the contents of the archive.
    inputBinding:
      position: 101
      prefix: --zip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
stdout: phyloflash_phyloFlash_compare.pl.out
