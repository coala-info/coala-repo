# coolpuppy CWL Generation Report

## coolpuppy_coolpup.py

### Tool Description
Create pileups of Hi-C data around specified genomic features.

### Metadata
- **Docker Image**: quay.io/biocontainers/coolpuppy:1.1.0--pyh086e186_0
- **Homepage**: https://github.com/open2c/coolpuppy
- **Package**: https://anaconda.org/channels/bioconda/packages/coolpuppy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coolpuppy/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/open2c/coolpuppy
- **Stars**: N/A
### Original Help Text
```text
usage: coolpup.py [-h] [--features_format {bed,bedpe,auto}] [--view VIEW]
                  [--flank FLANK] [--minshift MINSHIFT] [--maxshift MAXSHIFT]
                  [--nshifts NSHIFTS] [--expected EXPECTED] [--not_ooe]
                  [--mindist MINDIST] [--maxdist MAXDIST]
                  [--ignore_diags IGNORE_DIAGS] [--subset SUBSET]
                  [--by_window] [--by_strand]
                  [--by_distance [BY_DISTANCE ...]] [--groupby [GROUPBY ...]]
                  [--ignore_group_order [IGNORE_GROUP_ORDER ...]]
                  [--flip_negative_strand] [--local]
                  [--coverage_norm [COVERAGE_NORM]] [--trans]
                  [--store_stripes] [--rescale]
                  [--rescale_flank RESCALE_FLANK]
                  [--rescale_size RESCALE_SIZE]
                  [--clr_weight_name [CLR_WEIGHT_NAME]] [-o OUTNAME]
                  [-p N_PROC] [--seed SEED]
                  [-l {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [--post_mortem]
                  [-v]
                  cool_path features

positional arguments:
  cool_path             Cooler file with your Hi-C data
  features              A 3-column bed file or a 6-column double-bed file i.e.
                        chr1,start1,end1,chr2,start2,end2. Should be tab-
                        delimited. With a bed file, will consider all
                        combinations of intervals. To pileup features along
                        the diagonal instead, use the ``--local`` argument.
                        Can be piped in via stdin, then use "-"

options:
  -h, --help            show this help message and exit
  --features_format {bed,bedpe,auto}, --features-format {bed,bedpe,auto}, --format {bed,bedpe,auto}, --basetype {bed,bedpe,auto}
                        Format of the features. Options: bed: chrom, start,
                        end bedpe: chrom1, start1, end1, chrom2, start2, end2
                        auto (default): determined from the file name
                        extension Has to be explicitly provided is features is
                        piped through stdin (default: auto)
  --view VIEW           Path to a file which defines which regions of the
                        chromosomes to use (default: None)
  --flank FLANK, --pad FLANK
                        Flanking of the windows around the centres of
                        specified features i.e. final size of the matrix is 2
                        × flank+res, in bp. Ignored with ``--rescale``, use
                        ``--rescale_flank`` instead (default: 100000)
  --minshift MINSHIFT   Shortest shift for random controls, bp (default:
                        100000)
  --maxshift MAXSHIFT   Longest shift for random controls, bp (default:
                        1000000)
  --nshifts NSHIFTS     Number of control regions per averaged window
                        (default: 10)
  --expected EXPECTED   File with expected (output of ``cooltools compute-
                        expected``). If None, don't use expected and use
                        randomly shifted controls (default: None)
  --not_ooe, --not-ooe  If expected is provided, will accumulate all expected
                        snippets just like for randomly shifted controls,
                        instead of normalizing each snippet individually
                        (default: True)
  --mindist MINDIST     Minimal distance of interactions to use, bp. If not
                        provided, uses 2*flank+2 (in bins) as mindist to avoid
                        first two diagonals (default: None)
  --maxdist MAXDIST     Maximal distance of interactions to use (default:
                        None)
  --ignore_diags IGNORE_DIAGS, --ignore-diags IGNORE_DIAGS
                        How many diagonals to ignore (default: 2)
  --subset SUBSET       Take a random sample of the bed file. Useful for files
                        with too many featuers to run as is, i.e. some
                        repetitive elements. Set to 0 or lower to keep all
                        data (default: 0)
  --by_window, --by-window
                        Perform by-window pile-ups. Create a pile-up for each
                        coordinate in the features. Not compatible with
                        --by_strand and --by_distance. Only works with bed
                        format features, and generates pairwise combinations
                        of each feature against the rest. (default: False)
  --by_strand, --by-strand
                        Perform by-strand pile-ups. Create a separate pile-up
                        for each strand combination in the features. (default:
                        False)
  --by_distance [BY_DISTANCE ...], --by-distance [BY_DISTANCE ...]
                        Perform by-distance pile-ups. Create a separate pile-
                        up for each distance band. If empty, will use default
                        (0,50000,100000,200000,...) edges. Specify edges using
                        multiple argument values, e.g. `--by_distance 1000000
                        2000000` (default: None)
  --groupby [GROUPBY ...]
                        Additional columns of features to use for groupby,
                        space separated. If feature_format=='bed', each
                        columns should be specified twice with suffixes '1'
                        and '2', i.e. if features have a column 'group',
                        specify 'group1 group2'., e.g. --groupby chrom1 chrom2
                        (default: None)
  --ignore_group_order [IGNORE_GROUP_ORDER ...]
                        When using groupby, reorder so that e.g. group1-group2
                        and group2-group1 will be combined into one and
                        flipped to the correct orientation. If using multiple
                        paired groupings (e.g. group1-group2 and
                        category1-category2), need to specify which grouping
                        should be prioritised, e.g. "group" or "group1
                        group2". For flip_negative_strand, +- and -+ strands
                        will be combined (default: None)
  --flip_negative_strand, --flip-negative-strand
                        Flip snippets so the positive strand always points to
                        bottom-right. Requires strands to be annotated for
                        each feature (or two strands for bedpe format
                        features) (default: False)
  --local               Create local pileups, i.e. along the diagonal
                        (default: False)
  --coverage_norm [COVERAGE_NORM], --coverage-norm [COVERAGE_NORM]
                        Normalize the final pileup by accumulated coverage as
                        an alternative to balancing. Useful for single-cell
                        Hi-C data. Can be a string: "cis" or "total" to use
                        "cov_cis_raw" or "cov_tot_raw" columns in the cooler
                        bin table, respectively. If they are not present, will
                        calculate coverage with same ignore_diags as used in
                        coolpup.py and store result in the cooler.
                        Alternatively, if a different string is provided, will
                        attempt to use a column with the that name in the
                        cooler bin table, and will raise a ValueError if it
                        does not exist. If no argument is given following the
                        option string, will use "total". Only allowed when
                        using empty --clr_weight_name (default: )
  --trans               Perform inter-chromosomal (trans) pileups. This
                        ignores all contacts in cis. (default: False)
  --store_stripes       Store horizontal and vertical stripes in pileup output
                        (default: False)
  --rescale             Rescale all features to the same size. Do not use
                        centres of features and flank, and rather use the
                        actual feature sizes and rescale pileups to the same
                        shape and size (default: False)
  --rescale_flank RESCALE_FLANK, --rescale_pad RESCALE_FLANK, --rescale-flank RESCALE_FLANK, --rescale-pad RESCALE_FLANK
                        If --rescale, flanking in fraction of feature length
                        (default: 1.0)
  --rescale_size RESCALE_SIZE, --rescale-size RESCALE_SIZE
                        Size to rescale to. If ``--rescale``, used to
                        determine the final size of the pileup, i.e. it will
                        be size×size. Due to technical limitation in the
                        current implementation, has to be an odd number
                        (default: 99)
  --clr_weight_name [CLR_WEIGHT_NAME], --weight_name [CLR_WEIGHT_NAME], --clr-weight-name [CLR_WEIGHT_NAME], --weight-name [CLR_WEIGHT_NAME]
                        Name of the norm to use for getting balanced data.
                        Provide empty argument to calculate pileups on raw
                        data (no masking bad pixels). (default: weight)
  -o OUTNAME, --outname OUTNAME, --output OUTNAME
                        Name of the output file. If not set, file is saved in
                        the current directory and the name is generated
                        automatically to include important information and
                        avoid overwriting files generated with different
                        settings. (default: auto)
  -p N_PROC, --nproc N_PROC, --n_proc N_PROC, --n-proc N_PROC
                        Number of processes to use. Each process works on a
                        separate chromosome, so might require quite a bit more
                        memory, although the data are always stored as sparse
                        matrices. Set to 0 to use all available cores.
                        (default: 1)
  --seed SEED           Set specific seed value to ensure reproducibility
                        (default: None)
  -l {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --log {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging level (default: INFO)
  --post_mortem, --post-mortem
                        Enter debugger if there is an error (default: False)
  -v, --version         show program's version number and exit
```


## coolpuppy_plotpup.py

### Tool Description
Plot pileups from coolpuppy

### Metadata
- **Docker Image**: quay.io/biocontainers/coolpuppy:1.1.0--pyh086e186_0
- **Homepage**: https://github.com/open2c/coolpuppy
- **Package**: https://anaconda.org/channels/bioconda/packages/coolpuppy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plotpup.py [-h] [--cmap CMAP] [--not_symmetric] [--vmin VMIN]
                  [--vmax VMAX] [--scale {log,linear}] [--stripe STRIPE]
                  [--stripe_sort STRIPE_SORT] [--lineplot]
                  [--out_sorted_bedpe OUT_SORTED_BEDPE] [--divide_pups]
                  [--font FONT] [--font_scale FONT_SCALE] [--cols COLS]
                  [--rows ROWS] [--col_order COL_ORDER]
                  [--row_order ROW_ORDER] [--colnames COLNAMES [COLNAMES ...]]
                  [--rownames ROWNAMES [ROWNAMES ...]] [--query QUERY]
                  [--norm_corners NORM_CORNERS] [--no_score] [--center CENTER]
                  [--ignore_central IGNORE_CENTRAL] [--quaich] [--dpi DPI]
                  [--height HEIGHT] [--plot_ticks] [--output OUTPUT]
                  [-l {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [--post_mortem]
                  [--input_pups INPUT_PUPS [INPUT_PUPS ...]] [-v]

options:
  -h, --help            show this help message and exit
  --cmap CMAP           Colormap to use (see
                        https://matplotlib.org/users/colormaps.html) (default:
                        coolwarm)
  --not_symmetric, --not-symmetric, --not_symmetrical, --not-symmetrical
                        Whether to **not** make colormap symmetric around 1,
                        if log scale (default: False)
  --vmin VMIN           Value for the lowest colour (default: None)
  --vmax VMAX           Value for the highest colour (default: None)
  --scale {log,linear}  Whether to use linear or log scaling for mapping
                        colours (default: log)
  --stripe STRIPE       For plotting stripe stackups (default: None)
  --stripe_sort STRIPE_SORT
                        Whether to sort stripe stackups by total signal (sum),
                        central pixel signal (center_pixel), or not at all
                        (None) (default: sum)
  --lineplot            Whether to plot the average lineplot above stripes.
                        This only works for a single plot, i.e. without
                        rows/columns (default: False)
  --out_sorted_bedpe OUT_SORTED_BEDPE
                        Output bedpe of sorted stripe regions (default: None)
  --divide_pups         Whether to divide two pileups and plot the result
                        (default: False)
  --font FONT           Font to use for plotting (default: DejaVu Sans)
  --font_scale FONT_SCALE
                        Font scale to use for plotting. Defaults to 1
                        (default: 1)
  --cols COLS           Which value to map as columns (default: None)
  --rows ROWS           Which value to map as rows (default: None)
  --col_order COL_ORDER
                        Order of columns to use, space separated inside quotes
                        (default: None)
  --row_order ROW_ORDER
                        Order of rows to use, space separated inside quotes
                        (default: None)
  --colnames COLNAMES [COLNAMES ...]
                        Names to plot for columns, space separated. (default:
                        None)
  --rownames ROWNAMES [ROWNAMES ...]
                        Names to plot for rows, space separated. (default:
                        None)
  --query QUERY         Pandas query to select pups to plot from concatenated
                        input files. Multiple query arguments can be used.
                        Usage example: --query "orientation == '+-' |
                        orientation == '-+'" (default: None)
  --norm_corners NORM_CORNERS
                        Whether to normalize pileups by their top left and
                        bottom right corners. 0 for no normalization, positive
                        number to define the size of the corner squares whose
                        values are averaged (default: 0)
  --no_score            If central pixel score should not be shown in top left
                        corner (default: False)
  --center CENTER       How many central pixels to consider when calculating
                        enrichment for off-diagonal pileups. (default: 3)
  --ignore_central IGNORE_CENTRAL
                        How many central bins to ignore when calculating
                        insulation for local (on-diagonal) non-rescaled
                        pileups. (default: 3)
  --quaich              Activate if pileups are named accodring to Quaich
                        naming convention to get information from the file
                        name (default: False)
  --dpi DPI             DPI of the output plot. Try increasing if heatmaps
                        look blurry (default: 300)
  --height HEIGHT       Height of the plot (default: 1)
  --plot_ticks          Whether to plot ticks demarkating the center and
                        flanking regions, only applicable for non-stripes
                        (default: False)
  --output OUTPUT, -o OUTPUT, --outname OUTPUT
                        Where to save the plot (default: pup.pdf)
  -l {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --log {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging level (default: INFO)
  --post_mortem         Enter debugger if there is an error (default: False)
  --input_pups INPUT_PUPS [INPUT_PUPS ...]
                        All files to plot (default: None)
  -v, --version         show program's version number and exit
```


## Metadata
- **Skill**: generated
