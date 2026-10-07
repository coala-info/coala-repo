# cressent CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cressent_adjust_seq | PASS |  |
| cressent_align | PASS |  |
| cressent_build_contaminant_db | PASS |  |
| cressent_build_tree | PASS |  |
| cressent_cluster | PASS |  |
| cressent_db_builder | PASS |  |
| cressent_detect_contamination | PASS |  |
| cressent_gc_ht | PASS |  |
| cressent_gene_map | PASS |  |
| cressent_motif | PASS |  |
| cressent_motif_disc | PASS |  |
| cressent_motif_map_viz | PASS |  |
| cressent_plot_tree | PASS |  |
| cressent_recombination | PASS |  |
| cressent_run_cruise | Failed | tool bug: the run_cruise command in cli.py uses an undefined name 'outputdir', so it always stops with a NameError. |
| cressent_seq_logo | PASS |  |
| cressent_sl_finder | Failed | image problem: the ViennaRNA Python package (RNA) is missing from the image, so sl_finder stops at start. |
| cressent_tanglegram | PASS |  |

## cressent_adjust_seq

### Tool Description
Adjust sequences in a FASTA file to start with a specified motif.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent adjust_seq [OPTIONS]

  Adjust sequences in a FASTA file to start with a specified motif.

Options:
  -i, --input_fasta TEXT  Path to the input FASTA file.  [required]
  -o, --output TEXT       Path to the output directory (Default: working
                          directory)
  -m, --motif TEXT        Motif to adjust sequences to start with (default:
                          TAGTATTAC).
  --help                  Show this message and exit.
```

## cressent_align

### Tool Description
Pipeline for sequence alignment and trimming.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent align [OPTIONS]

  Pipeline for sequence alignment and trimming.

Options:
  -t, --threads INTEGER       Number of threads
  -i, --input_fasta TEXT      Input FASTA file with sequences  [required]
  -o, --output TEXT           Path to the output directory (Default: working
                              directory)
  --mafft_ep FLOAT            Alignment length for MAFFT (default: 0.123)
  --gap_threshold FLOAT       Gap threshold for TrimAl (default: 0.2)
  --db_family TEXT            List of family names for specific families,
                              'all' to use all the database, or 'custom' to
                              use a custom AA file
  --db_path TEXT              Path to the database FASTA files
  --protein_type [reps|caps]  Specify protein type (Rep or Cap) for database
                              files
  --custom_aa TEXT            Path to custom AA fasta file for alignment
  --help                      Show this message and exit.
```

## cressent_build_contaminant_db

### Tool Description
Build a viral contaminant database for decontamination pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent build_contaminant_db [OPTIONS]

  Build a viral contaminant database for decontamination pipelines.

Options:
  --accession-csv TEXT  CSV file with accessions (must have 'accession'
                        column)  [required]
  -o, --output TEXT     Path to the output directory (Default: working
                        directory)  [required]
  --output-name TEXT    Base name for output files (default: contaminant_db)
  --email TEXT          Email for NCBI Entrez queries (not required, default:
                        user@example.com)
  --batch-size INTEGER  Maximum number of sequences to download in each batch
                        (default = 10)
  --help                Show this message and exit.
```

## cressent_build_tree

### Tool Description
Build phylogenetic tree using IQ-TREE.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent build_tree [OPTIONS]

  Build phylogenetic tree using IQ-TREE.

Options:
  -i, --input_fasta TEXT   Input FASTA file with sequences.  [required]
  -o, --output TEXT        Path to the output directory (Default: working
                           directory)  [required]
  -B, --bootstrap INTEGER  Number of bootstrap iterations (default: 1000)
  -t, --threads TEXT       Number of threads to use (default: AUTO)
  -m, --model TEXT         Substitution models (default: MFP - ModelFinder)
  --keep_names             Keep only the first word of sequence IDs, otherwise
                           it replaces space with _
  --extra_args TEXT        Extra arguments to pass directly to IQ-TREE (can be
                           specified multiple times)
  --help                   Show this message and exit.
```

## cressent_cluster

### Tool Description
Sequence clustering using BLAST, anicalc, and aniclust.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent cluster [OPTIONS]

  Sequence clustering using BLAST, anicalc, and aniclust.

Options:
  -i, --input_fasta TEXT  Path to input FASTA file  [required]
  -o, --output TEXT       Path to the output directory (Default: working
                          directory)
  -t, --threads INTEGER   Number of threads for BLAST (Default = 1)
  --min_ani FLOAT         Minimum average identity for clustering (Default =
                          95.0)
  --min_tcov FLOAT        Minimum target coverage (Default = 85.0)
  --min_qcov FLOAT        Minimum query coverage (Default = 0.0)
  --keep_names            Keep only the first word of sequence IDs, otherwise
                          replaces space with _
  --help                  Show this message and exit.
```

## cressent_db_builder

### Tool Description
Build taxonomy-based database for ssDNA tool

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent db_builder [OPTIONS]

  Build taxonomy-based database for ssDNA tool

Options:
  -t, --taxonomy-file TEXT        Path to taxonomy_accession_number.csv file
                                  [required]
  -l, --taxonomy-level [Realm|Subrealm|Kingdom|Subkingdom|Phylum|Subphylum|Class|Subclass|Order|Suborder|Family|Subfamily|Genus|Subgenus|Species]
                                  Taxonomy level to use for selection
                                  [required]
  -s, --selected-taxonomies TEXT  Selected taxonomies (if not provided, will
                                  list available options)
  -o, --output-dir TEXT           Output directory for database
  -e, --email TEXT                Email for NCBI Entrez
  --threads INTEGER               Number of threads to use (default: 8)
  --cd-hit-identity FLOAT         CD-HIT identity threshold (default: 0.95)
  --mcl-inflation FLOAT           MCL inflation parameter (default: 1.5)
  --help                          Show this message and exit.
```

## cressent_detect_contamination

### Tool Description
Filter viral contaminants from sequence data (nucleotide or protein).

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent detect_contamination [OPTIONS]

  Filter viral contaminants from sequence data (nucleotide or protein).

Options:
  -i, --input_fasta TEXT  Input FASTA file  [required]
  --db TEXT               Contaminant database FASTA file  [required]
  -o, --output TEXT       Path to the output directory (Default: working
                          directory)  [required]
  --output-name TEXT      Base name for output files (default:
                          clean_sequences)
  --seq-type [nucl|prot]  Sequence type (auto-detect if not specified)
  --evalue FLOAT          BLAST E-value threshold (default: 1e-10)
  --identity FLOAT        Minimum percent identity to consider a match
                          (default: 90.0)
  --coverage FLOAT        Minimum query coverage to consider a match (default:
                          50.0)
  -t, --threads INTEGER   Number of CPU threads for BLAST (default: 1)
  --keep-temp             Keep temporary BLAST output files
  --help                  Show this message and exit.
```

## cressent_gc_ht

### Tool Description
Generate a GC content heatmap from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent gc_ht [OPTIONS]

  Generate a GC content heatmap from a FASTA file.

Options:
  -i, --input_fasta TEXT  Input FASTA file containing sequences.  [required]
  -o, --output TEXT       Path to the output directory (Default: working
                          directory)
  --window_size INTEGER   Sliding window size for GC content calculation
                          (default: 30).
  --step_size INTEGER     Step size for GC calculation (default: 5).
  --xticklabels INTEGER   Interval for x-axis tick labels (default: None).
  --fig_width INTEGER     Figure width in inches (default: 12).
  --fig_height INTEGER    Figure height in inches (default: 6).
  --output_name TEXT      Name of output image file with extension (default:
                          gc_heatmap.png).
  --help                  Show this message and exit.
```

## cressent_gene_map

### Tool Description
Generate gene arrow plots from motif data using R.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent gene_map [OPTIONS]

  Generate gene arrow plots from motif data using R.

Options:
  -i, --input TEXT   Input file path for the motif table CSV  [required]
  -o, --output TEXT  Path to the output directory (Default: working directory)
  --filename TEXT    Output filename for the generated plot (default:
                     gene_motif.pdf)
  --height FLOAT     Height of the output plot in inches (default: 10)
  --width FLOAT      Width of the output plot in inches (default: 10)
  -t, --title TEXT   Title for the plot (optional)
  --help             Show this message and exit.
```

## cressent_motif

### Tool Description
Combined module for motif finding and sequence logo generation.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent motif [OPTIONS]

  Combined module for motif finding and sequence logo generation.

Options:
  -i, --input_fasta TEXT  Input FASTA file with sequences.  [required]
  -o, --output TEXT       Path to the output directory (Default: working
                          directory)
  -p, --pattern TEXT      Sequence pattern (regex) for motif searching.
                          [required]
  -n, --table_name TEXT   Name of the file that will store motif positions
                          (Default: pattern_positions.txt)
  --remove-gaps           If set, removes gaps ('-') before searching for
                          motifs.
  --split-sequences       If set, the sequences will be split at the motif
                          position.
  --generate-logo         If set, generate a sequence logo from the motif
                          results.
  --logo-name TEXT        Name of the sequence logo PDF file (Default:
                          sequence_logo.pdf)
  --plot-title TEXT       Title of the Sequence Logo (Default: sequence_logo)
  --width FLOAT           Width of the sequence logo PDF file (Default = 10)
  --height FLOAT          Height of the sequence logo PDF file (Default = 10)
  --split-logo            If set, the sequence logo will be split by group
                          label.
  --metadata TEXT         Path to metadata file containing group labels.
  --ncol INTEGER          Number of columns when splitting the sequence logo.
  --group-label TEXT      Column name in metadata for grouping sequences.
  --help                  Show this message and exit.
```

## cressent_motif_disc

### Tool Description
Discover de novo motifs using MEME.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent motif_disc [OPTIONS]

  Discover de novo motifs using MEME.

Options:
  -i, --input_fasta TEXT  Input FASTA file  [required]
  -o, --output TEXT       Path to the output directory (Default: working
                          directory) (used for MEME and generated files)
  -nmotifs INTEGER        Number of motifs to find (Default = 1)
  -minw INTEGER           Minimum motif width (Default = 5)
  -maxw INTEGER           Maximum motif width (Default = 10)
  --meme_extra TEXT       Additional MEME arguments (list format)
  --scanprosite           Run ScanProsite
  --help                  Show this message and exit.
```

## cressent_motif_map_viz

### Tool Description
Module to plot motif analysis results (ScanProsite or MEME motifs)

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent motif_map_viz [OPTIONS]

  Module to plot motif analysis results (ScanProsite or MEME motifs)

Options:
  -f, --file TEXT                 Input file from scanprosite or motif
                                  analysis  [required]
  -o, --output TEXT               Path to the output directory (Default:
                                  working directory)
  --format [prosite|motif_table|auto]
                                  Input format (default: auto-detect)
  --help                          Show this message and exit.
```

## cressent_plot_tree

### Tool Description
Plot phylogenetic trees using ggtree.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent plot_tree [OPTIONS]

  Plot phylogenetic trees using ggtree.

Options:
  -t, --tree TEXT       Input tree file (Newick format)
  --dist_matrix TEXT    Use distance matrix method for tree construction
  -o, --output TEXT     Path to the output directory (Default: working
                        directory)  [required]
  --metadata_1 TEXT     Optional CSV metadata file
  --metadata_2 TEXT     Optional TSV name table file
  --alignment TEXT      Optional alignment file (FASTA) to include in the plot
  --layout TEXT         Tree layout (e.g., rectangular, circular, unrooted)
                        Default: rectangular
  --branch_length TEXT  Branch length parameter for ggtree (Default:
                        branch.length)
  --open_angle FLOAT    Open angle for circular/unrooted layouts (default = 0)
  --offset FLOAT        Tip label offset (default = 0)
  --tip_label TEXT      Column name to use as the tip label (default = family)
  --color BOOLEAN       Color tree by group (requires metadata) (default =
                        True)
  --fig_width FLOAT     Figure width (ggsave) (default = 7)
  --fig_height FLOAT    Figure height (ggsave) (default = 7)
  --plot_tips BOOLEAN   Include tip labels in the plot (default = True)
  --plot_name TEXT      Name of the output plot file (default: tree_plot.pdf)
  --help                Show this message and exit.
```

## cressent_recombination

### Tool Description
Detect recombination events in ssDNA virus sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent recombination [OPTIONS]

  Detect recombination events in ssDNA virus sequences.

Options:
  -i, --input_fasta TEXT  Input alignment file in FASTA format  [required]
  -o, --output TEXT       Path to the output directory (Default: working
                          directory)
  -f, --output_file TEXT  Output file for results (CSV format)  [required]
  -c, --config TEXT       Configuration file in INI format for OpenRDP
                          parameters
  -rdp                    Run RDP method
  -threeseq               Run 3Seq method
  -geneconv               Run GENECONV method
  -maxchi                 Run MaxChi method
  -chimaera               Run Chimaera method
  -bootscan               Run Bootscan method
  -siscan                 Run Siscan method
  -all                    Run all methods
  -quiet                  Suppress console output
  -verbose                Enable verbose logging
  --help                  Show this message and exit.
```

## cressent_run_cruise

### Tool Description
Search for iterons around CRESS stem-loops in GFF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent run_cruise [OPTIONS]

  Search for iterons around CRESS stem-loops in GFF files.

Options:
  -o, --output TEXT           Path to the output directory (Default: working
                              directory)
  -i, --input_fasta TEXT      Path to input FASTA file with all sequences
                              [required]
  --inputGFF TEXT             Path to associated input GFF file  [required]
  --outputGFF TEXT            Path for output GFF file (default:
                              finaloutput.gff)  [required]
  --outputAnnotations TEXT    Identifiers to selectively preserve annotations
                              (default: 2 CRUISE)
  --minLength INTEGER         Minimum iteron length (default = 5)
  --maxLength INTEGER         Maximum iteron length (default = 12)
  --range INTEGER             Number of base pairs around nona to search
                              (default = 65)
  --rank BOOLEAN              Use ranking system (default = True)
  --numberTopIterons INTEGER  The number of iterons returned in rank order
                              (default = 5)
  --maxScore INTEGER          Maximum score allowed for iterons if rank =
                              False (default = 40)
  --wiggle INTEGER            Max difference between iteron length and
                              distance (default = 5)
  --goodLength INTEGER        The highest favorable iteron length (default =
                              11)
  --doStemLoop BOOLEAN        Whether to annotate stem-loop repeats (default =
                              True)
  --doKnownIterons BOOLEAN    Whether to annotate known iterons (default =
                              True)
  --maxDist INTEGER           Maximum allowed distance between iterons
                              (default = 20)
  --bestDist INTEGER          Optimal maximum distance between iterons
                              (default = 10)
  --scoreRange INTEGER        Score range between outputted candidates
                              (default = 50)
  --help                      Show this message and exit.
```

## cressent_seq_logo

### Tool Description
Generate a sequence logo from a FASTA file or sequence table.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent seq_logo [OPTIONS]

  Generate a sequence logo from a FASTA file or sequence table.

Options:
  -i, --input_fasta TEXT          Path to the fasta file.
  -tb, --seq_df TEXT              Path to the table produced by seqkit.
  -o, --output TEXT               Path to the output directory (Default:
                                  working directory)
  -n, --output_name TEXT          Name of the sequence logo (default:
                                  sequence_logo.pdf)
  --plot_title TEXT               Title of the Sequence Logo (default:
                                  sequence_logo)
  --width FLOAT                   Width of the sequence logo (default = 10)
  --height FLOAT                  Height of the sequence logo (default = 10)
  --split                         If set, the sequence logo will be split by
                                  group label (default = True)
  --metadata TEXT                 Path to metadata file containing group
                                  labels.
  --ncol INTEGER                  Number of columns when splitting the
                                  sequence logo.
  --group_label TEXT              Column name in metadata for grouping
                                  sequences.
  --positions_per_row INTEGER     Number of positions per row when creating
                                  multi-row plots (default: 50)
  --max_positions_single_row INTEGER
                                  Maximum number of positions before
                                  automatically splitting into multiple rows
                                  (default: 100)
  --method [bits|prob]            Method for ggseqlogo: 'bits' for information
                                  content or 'prob' for probability (default:
                                  prob)
  --help                          Show this message and exit.
```

## cressent_sl_finder

### Tool Description
A module for putative stem-loop annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent sl_finder [OPTIONS]

  A module for putative stem-loop annotation.

Options:
  -i, --input_fasta TEXT          Input FASTA file  [required]
  --gff_in TEXT                   Input GFF/GTF file  [required]
  --out_gff TEXT                  Output GFF filename  [required]
  -o, --output TEXT               Path to the output directory (Default:
                                  working directory)
  --csv_out TEXT                  Output CSV filename
  --motif TEXT                    Conserved motif (default = nantantan)
  --family [geminiviridae|genomoviridae|smacoviridae|cycloviridae|circoviridae|general]
                                  CRESS viral family
  -s, --idealstemlen INTEGER      Ideal stem length (default = 11)
  -l, --ideallooplen INTEGER      Ideal loop length (default = 11)
  -f, --frame INTEGER             Bases around motif for folding (default =
                                  15)
  --help                          Show this message and exit.
```

## cressent_tanglegram

### Tool Description
Generate a tanglegram from two phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/ricrocha82/cressent
- **Package**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cressent/overview
- **Total Downloads**: 286
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/ricrocha82/cressent
- **Stars**: N/A
### Original Help Text
```text
Usage: cressent tanglegram [OPTIONS]

  Generate a tanglegram from two phylogenetic trees.

Options:
  --tree1 TEXT            Path to the first tree file.  [required]
  --tree2 TEXT            Path to the second tree file.  [required]
  --label1 TEXT           Label for the first tree in the tanglegram.
                          [required]
  --label2 TEXT           Label for the second tree in the tanglegram.
                          [required]
  -o, --output TEXT       Path to the output directory (Default: working
                          directory)  [required]
  --name_tanglegram TEXT  Name of the tanglegram PDF file (default:
                          tanglegram.pdf)
  --width FLOAT           Width of the tanglegram (default = 20)
  --height FLOAT          Height of the tanglegram (default = 11)
  --lab_cex FLOAT         cex size of the labels (default = 1.5)
  --help                  Show this message and exit.
```
