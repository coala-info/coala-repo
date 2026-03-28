# verticall CWL Generation Report

## verticall_pairwise

### Tool Description
pairwise analysis of assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Verticall
- **Package**: https://anaconda.org/channels/bioconda/packages/verticall/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/verticall/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-09-02
- **GitHub**: https://github.com/rrwick/Verticall
- **Stars**: N/A
### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: verticall pairwise -i IN_DIR -o OUT_FILE [-r REFERENCE]
                          [--window_count WINDOW_COUNT]
                          [--window_size WINDOW_SIZE] [--ignore_indels]
                          [--smoothing_factor SMOOTHING_FACTOR]
                          [--secondary SECONDARY] [--verbose]
                          [--index_options INDEX_OPTIONS]
                          [--align_options ALIGN_OPTIONS]
                          [--allowed_overlap ALLOWED_OVERLAP] [-t THREADS]
                          [--part PART] [--index_only] [--skip_check]
                          [--existing_tsv EXISTING_TSV] [-h] [--version]

pairwise analysis of assemblies

Required arguments:
  -i, --in_dir IN_DIR     Directory containing assemblies in FASTA format
  -o, --out_file OUT_FILE
                          Filename of TSV output

Reference-based analysis:
  -r, --reference REFERENCE
                          Reference assembly in FASTA format

Settings:
  --window_count WINDOW_COUNT
                          Aim to have at least this many comparison windows
                          between assemblies (default: 50000)
  --window_size WINDOW_SIZE
                          Use this defined window size for all pairwise
                          comparisons (default: dynamically choose window size
                          for each pair)
  --ignore_indels         Only use mismatches to determine distance (default:
                          use both mismatches and gap-compressed indels)
  --smoothing_factor SMOOTHING_FACTOR
                          Degree to which the distance distribution is
                          smoothed (default: 0.8)
  --secondary SECONDARY   Peaks with a mass of at least this fraction of the
                          most massive peak will be used to produce secondary
                          distances (default: 0.7)
  --verbose               Output more detail to stderr for debugging (default:
                          only output basic information)

Alignment:
  --index_options INDEX_OPTIONS
                          Minimap2 options for assembly indexing (default:
                          -k15 -w10)
  --align_options ALIGN_OPTIONS
                          Minimap2 options for assembly-to-assembly alignment
                          (default: -x asm20)
  --allowed_overlap ALLOWED_OVERLAP
                          Allow this much overlap between alignments (default:
                          100)

Performance:
  -t, --threads THREADS   CPU threads for parallel processing (default: 16)
  --part PART             Fraction of the data to analyse (for
                          parallelisation, default: 1/1)
  --index_only            Quit after building indices (default: continue to
                          pairwise analysis)
  --skip_check            Do not carry out the assembly check for duplicate
                          contig names and ambiguous bases (default: perform
                          the assembly check)
  --existing_tsv EXISTING_TSV
                          Verticall will skip any assembly pairs present in
                          this existing TSV file (default: do not skip any
                          pairs)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## verticall_view

### Tool Description
view plots for a single assembly pair

### Metadata
- **Docker Image**: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Verticall
- **Package**: https://anaconda.org/channels/bioconda/packages/verticall/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: verticall view -i IN_DIR -n NAMES [--window_count WINDOW_COUNT]
                      [--window_size WINDOW_SIZE] [--ignore_indels]
                      [--smoothing_factor SMOOTHING_FACTOR]
                      [--secondary SECONDARY] [--verbose]
                      [--index_options INDEX_OPTIONS]
                      [--align_options ALIGN_OPTIONS]
                      [--allowed_overlap ALLOWED_OVERLAP] [--sqrt_distance]
                      [--sqrt_mass] [--result RESULT]
                      [--vertical_colour VERTICAL_COLOUR]
                      [--horizontal_colour HORIZONTAL_COLOUR]
                      [--ambiguous_colour AMBIGUOUS_COLOUR] [-h] [--version]

view plots for a single assembly pair

Required arguments:
  -i, --in_dir IN_DIR     Directory containing assemblies in FASTA format
  -n, --names NAMES       Two sample names (comma-delimited) to be viewed

Settings:
  --window_count WINDOW_COUNT
                          Aim to have at least this many comparison windows
                          between assemblies (default: 50000)
  --window_size WINDOW_SIZE
                          Use this defined window size for all pairwise
                          comparisons (default: dynamically choose window size
                          for each pair)
  --ignore_indels         Only use mismatches to determine distance (default:
                          use both mismatches and gap-compressed indels)
  --smoothing_factor SMOOTHING_FACTOR
                          Degree to which the distance distribution is
                          smoothed (default: 0.8)
  --secondary SECONDARY   Peaks with a mass of at least this fraction of the
                          most massive peak will be used to produce secondary
                          distances (default: 0.7)
  --verbose               Output more detail to stderr for debugging (default:
                          only output basic information)

Alignment:
  --index_options INDEX_OPTIONS
                          Minimap2 options for assembly indexing (default:
                          -k15 -w10)
  --align_options ALIGN_OPTIONS
                          Minimap2 options for assembly-to-assembly alignment
                          (default: -x asm20)
  --allowed_overlap ALLOWED_OVERLAP
                          Allow this much overlap between alignments (default:
                          100)

Plot settings:
  --sqrt_distance         Use a square-root transform on the genomic distance
                          axis (default: no distance axis transform)
  --sqrt_mass             Use a square-root transform on the probability mass
                          axis (default: no mass axis transform)
  --result RESULT         Number of result to plot (used when there are
                          multiple possible results for the pair, default: 1)

Colours:
  --vertical_colour VERTICAL_COLOUR
                          Hex colour for vertical inheritance (default:
                          #4859a0)
  --horizontal_colour HORIZONTAL_COLOUR
                          Hex colour for horizontal inheritance (default:
                          #c47e7e)
  --ambiguous_colour AMBIGUOUS_COLOUR
                          Hex colour for ambiguous inheritance (default:
                          #c9c9c9)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## verticall_matrix

### Tool Description
produce a PHYLIP distance matrix

### Metadata
- **Docker Image**: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Verticall
- **Package**: https://anaconda.org/channels/bioconda/packages/verticall/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: verticall matrix -i IN_FILE -o OUT_FILE
                        [--distance_type {mean,mean_window,median_window,peak_window,mean_vertical_window,median_vertical_window,mean_vertical}]
                        [--asymmetrical] [--no_jukes_cantor]
                        [--multi {first,exclude,low,high}]
                        [--include_names INCLUDE_NAMES]
                        [--exclude_names EXCLUDE_NAMES] [-h] [--version]

produce a PHYLIP distance matrix

Required arguments:
  -i, --in_file IN_FILE   Filename of TSV created by vertical pairwise
  -o, --out_file OUT_FILE
                          Filename of PHYLIP matrix output

Settings:
  --distance_type {mean,mean_window,median_window,peak_window,mean_vertical_window,median_vertical_window,mean_vertical}
                          Which distance to use in matrix (default:
                          median_vertical_window)
  --asymmetrical          Do not average pairs to make symmetrical matrices
                          (default: make matrices symmetrical)
  --no_jukes_cantor       Do not apply Jukes-Cantor correction (default: apply
                          Jukes-Cantor correction)
  --multi {first,exclude,low,high}
                          Behaviour when there are multiple results for a
                          sample pair (default: first)
  --include_names INCLUDE_NAMES
                          Samples names to include in matrix (comma-delimited,
                          default: include all samples)
  --exclude_names EXCLUDE_NAMES
                          Samples names to exclude from matrix (comma-
                          delimited, default: do not exclude any samples)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## verticall_mask

### Tool Description
mask horizontal regions from a whole-genome pseudo-alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Verticall
- **Package**: https://anaconda.org/channels/bioconda/packages/verticall/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: verticall mask -i IN_TSV -a IN_ALIGNMENT -o OUT_ALIGNMENT
                      [--image IMAGE] [--vertical_colour VERTICAL_COLOUR]
                      [--horizontal_colour HORIZONTAL_COLOUR]
                      [--unaligned_colour UNALIGNED_COLOUR]
                      [--reference REFERENCE]
                      [--multi {first,exclude,low,high}] [--h_char H_CHAR]
                      [--u_char U_CHAR] [--exclude_invariant]
                      [--exclude_reference] [-h] [--version]

mask horizontal regions from a whole-genome pseudo-alignment

Required arguments:
  -i, --in_tsv IN_TSV     Filename of TSV created by vertical pairwise
  -a, --in_alignment IN_ALIGNMENT
                          Filename of whole-genome pseudo-alignment to be
                          masked
  -o, --out_alignment OUT_ALIGNMENT
                          Filename of masked whole-genome pseudo-alignment

Illustration:
  --image IMAGE           Filename of SVG illustration of masked regions
                          (optional)
  --vertical_colour VERTICAL_COLOUR
                          Hex colour for vertical inheritance (default:
                          #4859a0)
  --horizontal_colour HORIZONTAL_COLOUR
                          Hex colour for horizontal inheritance (default:
                          #c47e7e)
  --unaligned_colour UNALIGNED_COLOUR
                          Hex colour for unaligned inheritance (default:
                          #c9c9c9)

Settings:
  --reference REFERENCE   Sample name for the reference genome (default:
                          determine automatically if possible from the TSV
                          file)
  --multi {first,exclude,low,high}
                          Behaviour when there are multiple results for a
                          sample pair (default: first)
  --h_char H_CHAR         Character used to mask horizontal regions (default:
                          N, use None to leave horizontal regions unmasked)
  --u_char U_CHAR         Character used to mask unaligned regions (default:
                          -, use None to leave unaligned regions unmasked)
  --exclude_invariant     Only include variant sites in the output alignment
                          (default: include both variant and invariant sites
                          in the output alignment)
  --exclude_reference     Do not include the reference sequence in the output
                          alignment (default: include the reference sequence
                          in the output alignment)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## verticall_summary

### Tool Description
summarise regions for one assembly

### Metadata
- **Docker Image**: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Verticall
- **Package**: https://anaconda.org/channels/bioconda/packages/verticall/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: verticall summary -i IN_FILE -a ASSEMBLY [--all] [--plot]
                         [--vertical_colour VERTICAL_COLOUR]
                         [--horizontal_colour HORIZONTAL_COLOUR]
                         [--unaligned_colour UNALIGNED_COLOUR] [-h]
                         [--version]

summarise regions for one assembly

Required arguments:
  -i, --in_file IN_FILE   Filename of TSV created by vertical pairwise
  -a, --assembly ASSEMBLY
                          Filename of assembly to be summarised

Settings:
  --all                   Output one line for all assembly positions (default:
                          omit redundant adjacent lines)
  --plot                  Instead of outputting a table, display an
                          interactive plot (default: do not display a plot)

Colours:
  --vertical_colour VERTICAL_COLOUR
                          Hex colour for vertical inheritance (default:
                          #4859a0)
  --horizontal_colour HORIZONTAL_COLOUR
                          Hex colour for horizontal inheritance (default:
                          #c47e7e)
  --unaligned_colour UNALIGNED_COLOUR
                          Hex colour for unaligned inheritance (default:
                          #c9c9c9)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## verticall_repair

### Tool Description
repair assembly for use in Verticall

### Metadata
- **Docker Image**: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Verticall
- **Package**: https://anaconda.org/channels/bioconda/packages/verticall/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: verticall repair -i IN_FILE -o OUT_FILE [-h] [--version]

repair assembly for use in Verticall

Required arguments:
  -i, --in_file IN_FILE   Filename of assembly in need of repair
  -o, --out_file OUT_FILE
                          Filename of repaired assembly output (if the same as
                          -i, the input file will be overwritten)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## Metadata
- **Skill**: generated
