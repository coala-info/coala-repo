# ariba CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ariba_aln2meta | PASS |  |
| ariba_expandflag | PASS |  |
| ariba_flag | PASS |  |
| ariba_getref | PASS |  |
| ariba_micplot | PASS | synthetic data: small hand-written MIC table; the summary and prepareref folder come from a real ariba run (plot made with --no_combinations; with one variant combination the tool divides by zero). |
| ariba_prepareref | PASS |  |
| ariba_prepareref_tb | PASS |  |
| ariba_pubmlstget | PASS |  |
| ariba_pubmlstspecies | PASS |  |
| ariba_refquery | PASS |  |
| ariba_run | PASS |  |
| ariba_summary | PASS |  |

## ariba_aln2meta

### Tool Description
Converts multi-aln fasta and SNPs to metadata

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba aln2meta [options] <aln_fasta> <variants_tsv> <(non)coding> <outprefix>

Make metadata input to prepareref, using multialignment and SNPs

positional arguments:
  aln_fasta           Multi-fasta file of alignments
  variants_tsv        TSV file of variants information
  (non)coding         Sequences are coding or noncoding. Must be one of:
                      coding noncoding
  outprefix           Prefix of output filenames

options:
  -h, --help          show this help message and exit
  --genetic_code INT  Number of genetic code to use. Currently supported
                      1,4,11 [11]
  --variant_only      Use this to flag all sequences as variant only. By
                      default they are considered to be presence/absence
```

## ariba_expandflag

### Tool Description
Expands flag column of report file

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba expandflag <in.report.tsv> <out.tsv

Expands the flag column in a report file from number to comma-separated list
of flag bits

positional arguments:
  infile      Name of input report TSV file
  outfile     Name of output report TSV file

options:
  -h, --help  show this help message and exit
```

## ariba_flag

### Tool Description
Translate the meaning of a flag

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba flag <flag>

Translate the meaning of a flag output by ARIBA, found in the report tsv file

positional arguments:
  flag        Flag to be translated (an integer)

options:
  -h, --help  show this help message and exit
```

## ariba_getref

### Tool Description
Download reference data

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba getref [options] <db> <outprefix>

Download reference data from one of a few supported public resources

positional arguments:
  DB name            Database to download. Must be one of: argannot card
                     megares ncbi plasmidfinder resfinder srst2_argannot
                     vfdb_core vfdb_full virulencefinder
  outprefix          Prefix of output filenames

options:
  -h, --help         show this help message and exit
  --debug            Do not delete temporary downloaded files
  --version VERSION  Version of reference data to download. If not used, gets
                     the latest version. Applies to: card, megares, ncbi,
                     plasmidfinder, resfinder, srst2_argannot,
                     virulencefinder. For plasmid/res/virulencefinder: default
                     is to get latest from bitbucket - supply git commit hash
                     to get a specific version from bitbucket, or use "old "
                     to get from old website. For srst2_argannot: default is
                     latest version r2, use r1 to get the older version
```

## ariba_micplot

### Tool Description
Make violin/dot plots using MIC data

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba prepareref [options] <prepareref_dir> <antibiotic> <MIC file> <summary file> <outprefix>

Makes a violin and scatter plot of MIC per variant in the summary file

positional arguments:
  prepareref_dir        Name of output directory when "ariba prepareref" was
                        run
  antibiotic            Antibiotic name. Must exactly match a column from the
                        MIC file
  mic_file              File containing MIC data for each sample and one or
                        more antibiotics
  summary_file          File made by running "ariba summary"
  outprefix             Prefix of output files

options:
  -h, --help            show this help message and exit

General options:
  --out_format OUT_FORMAT
                        Output format of image file. Use anything that
                        matplotlib can save to, eg pdf or png [pdf]
  --main_title "title in quotes"
                        Main title of plot. Default is to use the antibiotic
                        name
  --plot_height FLOAT   Height of plot in inches [7]
  --plot_width FLOAT    Width of plot in inches [7]
  --use_hets {yes,no,exclude}
                        How to deal with HET snps. Choose from yes,no,exclude.
                        yes: count a het SNP as present. no: do not count a
                        het SNP as present. exclude: completely remove any
                        sample with any het SNP [yes]
  --interrupted         Include interrupted genes (as in the assembled column
                        of the ariba summary files)
  --min_samples INT     Minimum number of samples in each column required to
                        include in plot [1]
  --no_combinations     Do not show combinations of variants. Instead separate
                        out into one box/violin plot per variant.
  --panel_heights height1,height2
                        Two integers that determine relative height of top and
                        bottom plots. eg 5,1 means ratio of 5:1 between top
                        and bottom panel heights [9,2]
  --panel_widths width1,width2
                        Two integers that determine relative width of plots
                        and space used by counts legend. eg 5,1 means ratio of
                        5:1 between top and bottom panel widths. Only applies
                        when plotting points and --point_size 0 [5,1]
  --count_legend_x FLOAT
                        Control x position of counts legend when plotting
                        points and --point_size 0 [-2]
  --p_cutoff P_CUTOFF   p-value cutoff for Mann-Whitney tests [0.05]
  --xkcd                Best used with xkcd font installed ;)

Colour options:
  --colourmap colourmap name
                        Colours to use. See
                        http://matplotlib.org/users/colormaps.html [Accent]
  --number_of_colours INT
                        Number of colours in plot. 0:same number as columns in
                        the plot. 1:all black. >1: take the first N colours
                        from the colourmap specified by --colourmap and cycle
                        them [0]
  --colour_skip FLOAT1,FLOAT2
                        If using a continuous colourmap, --colour_skip a,b
                        (where 0 <= a < b <= 1) will skip the range between a
                        and b. Useful for excluding near-white colours

Upper plot options:
  --plot_types type1,type2,...
                        Types of plots to make, separated by commas. Choose
                        from violin,point [violin,point]
  --hlines float1,float2,...
                        Comma-separated list of positions at which to draw
                        horizontal lines. Default is to draw no lines.
  --jitter_width FLOAT  Jitter width option when plotting points [0.1]
  --log_y FLOAT         Base of log applied to y values. Set to zero to not
                        log [2]
  --point_size FLOAT    Size of points when --plot_types includes point. If
                        zero, will group points and size them proportional to
                        the group size [4]
  --point_scale FLOAT   Scale point sizes when --point_size 0. All point sizes
                        are multiplied by this number. Useful if you have
                        large data set [1]
  --violin_width VIOLIN_WIDTH
                        Width of violins [0.75]

Lower plot options:
  --dot_size FLOAT      Size of dots in lower part of plot [100]
  --dot_outline         Black outline around all dots (whether coloured or
                        not) in lower part of plots
  --dot_y_text_size INT
                        Text size of labels [7]
```

## ariba_prepareref

### Tool Description
Prepare reference data for input to "run"

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba prepareref [options] <outdir>

Prepare reference data for running the pipeline with "ariba run"

positional arguments:
  outdir                Output directory (must not already exist)

options:
  -h, --help            show this help message and exit

input files options:
  -f FILENAME, --fasta FILENAME
                        REQUIRED. Name of fasta file. Can be used more than
                        once if your sequences are spread over more than on
                        file
  -m FILENAME, --metadata FILENAME
                        Name of tsv file of metadata about the input
                        sequences. Can be used more than once if your metadata
                        is spread over more than one file. Incompatible with
                        --all_coding
  --all_coding {yes,no}
                        Use this if you only have a fasta of presence absence
                        sequences as input, and no metadata. Use "yes" if all
                        sequences are coding, or "no" if they are all non-
                        coding. Incompatible with -m/--metadata

cd-hit options:
  --no_cdhit            Do not run cd-hit. Each input sequence is put into its
                        own "cluster". Incompatible with --cdhit_clusters.
  --cdhit_clusters FILENAME
                        File specifying how the sequences should be clustered.
                        Will be used instead of running cdhit. Format is one
                        cluster per line. Sequence names separated by
                        whitespace. Incompatible with --no_cdhit
  --cdhit_min_id FLOAT  Sequence identity threshold (cd-hit option -c) [0.9]
  --cdhit_min_length FLOAT
                        Length difference cutoff (cd-hit option -s) [0.0]
  --cdhit_max_memory INT
                        Memory limit in MB (cd-hit option -M) [None]. Use 0
                        for unlimited.

other options:
  --min_gene_length INT
                        Minimum allowed length in nucleotides of reference
                        genes [6]
  --max_gene_length INT
                        Maximum allowed length in nucleotides of reference
                        genes [10000]
  --min_noncoding_length INT
                        Minimum allowed length in nucleotides of non-coding
                        sequences [6]
  --max_noncoding_length INT
                        Maximum allowed length in nucleotides of non-coding
                        sequences [20000]
  --genetic_code INT    Number of genetic code to use. Currently supported
                        1,4,11 [11]
  --force               Overwrite output directory, if it already exists
  --threads INT         Number of threads (currently only applies to cdhit)
                        [1]
  --verbose             Be verbose

REQUIRED: -f/--fasta, and also either -m/--metadata or --all_coding must be
used
```

## ariba_prepareref_tb

### Tool Description
Prepare reference TB data for input to "run"

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba prepareref_tb <outdir>

Prepare built-in TB reference data for running the pipeline with "ariba run"

positional arguments:
  outdir      Output directory (must not already exist)

options:
  -h, --help  show this help message and exit
```

## ariba_pubmlstget

### Tool Description
Download species from PubMLST and make db

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba pubmlstget [options] <"species in quotes"> <output_directory>

Download typing scheme for a given species from PubMLST, and make an ARIBA db

positional arguments:
  species     Species to download. Put it in quotes
  outdir      Name of output directory to be made (must not already exist)

options:
  -h, --help  show this help message and exit
  --verbose   Be verbose
```

## ariba_pubmlstspecies

### Tool Description
Get list of available species from PubMLST

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba pubmlstspecies <outfile>

Get a list of species available from PubMLST. Use this to show the possible
species that can be used when running pubmlstget

options:
  -h, --help  show this help message and exit
```

## ariba_refquery

### Tool Description
Get cluster or sequence info from prepareref output

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba refquery <prepareref directory> <cluster|seq> <cluster name|sequence name>

Get cluster or sequence info from the output directory made by prepareref

positional arguments:
  prepareref_dir  Name of directory output by prepareref
  {cluster,seq}   Use "cluster" to get the sequences in a cluster, or "seq" to
                  get information about a sequence
  search_name     Name of cluster or sequence to search for

options:
  -h, --help      show this help message and exit
```

## ariba_run

### Tool Description
Run the local assembly pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba run [options] <prepareref_dir> <reads1.fq> <reads2.fq> <outdir>

Runs the local assembly pipeline. Input is dir made by prepareref, and paired
reads

positional arguments:
  prepareref_dir        Name of output directory when "ariba prepareref" was
                        run
  reads_1               Name of fwd reads fastq file
  reads_2               Name of rev reads fastq file
  outdir                Output directory (must not already exist)

options:
  -h, --help            show this help message and exit

nucmer options:
  --nucmer_min_id INT   Minimum alignment identity (delta-filter -i) [90]
  --nucmer_min_len INT  Minimum alignment length (delta-filter -i) [20]
  --nucmer_breaklen INT
                        Value to use for -breaklen when running nucmer [200]

Assembly options:
  --assembler {fermilite,spades}
                        Assembler to use
  --assembly_cov INT    Target read coverage when sampling reads for assembly
                        [50]
  --min_scaff_depth INT
                        Minimum number of read pairs needed as evidence for
                        scaffold link between two contigs [10]
  --spades_mode {wgs,sc,rna}
                        If using Spades assembler, either use default WGS
                        mode, Single Cell mode (`spades.py --sc`) or RNA mode
                        (`spades.py --rna`). Use SC or RNA mode if your input
                        is from a viral sequencing with very uneven and deep
                        coverage. Set `--assembly_cov` to some high value if
                        using SC or RNA mode
  --spades_options SPADES_OPTIONS
                        Extra options to pass to Spades assembler. Sensible
                        default options will be picked based on
                        `--spades_mode` argument. Anything set here will
                        replace the defaults completely

Other options:
  --threads INT         Experimental. Number of threads. Will run clusters in
                        parallel, but not minimap (yet) [1]
  --assembled_threshold FLOAT (between 0 and 1)
                        If proportion of gene assembled (regardless of into
                        how many contigs) is at least this value then the flag
                        gene_assembled is set [0.95]
  --gene_nt_extend INT  Max number of nucleotides to extend ends of gene
                        matches to look for start/stop codons [30]
  --unique_threshold FLOAT (between 0 and 1)
                        If proportion of bases in gene assembled more than
                        once is <= this value, then the flag unique_contig is
                        set [0.03]
  --force               Overwrite output directory, if it already exists
  --noclean             Do not clean up intermediate files
  --tmp_dir TMP_DIR     Existing directory in which to create a temporary
                        directory used for local assemblies
  --verbose             Be verbose
```

## ariba_summary

### Tool Description
Summarise multiple reports made by "run"

### Metadata
- **Docker Image**: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
- **Homepage**: https://github.com/sanger-pathogens/ariba
- **Package**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ariba/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/sanger-pathogens/ariba
- **Stars**: 184
### Original Help Text
```text
usage: ariba summary [options] <outprefix> [report1.tsv report2.tsv ...]

Make a summary of multiple ARIBA report files, and also make Phandango files

positional arguments:
  outprefix             Prefix of output files
  infiles               Files to be summarised

options:
  -h, --help            show this help message and exit
  -f FILENAME, --fofn FILENAME
                        File of filenames of ariba reports to be summarised.
                        Must be used if no input files listed after the
                        outfile. The first column should be the filename. An
                        optional second column can be used to specify a sample
                        name for that file, which will be used instead of the
                        filename in output files. Columns separated by
                        whitespace.
  --preset minimal|cluster_small|cluster_all|cluster_var_groups|all|all_no_filter
                        Shorthand for setting --cluster_cols,--col_filter,--
                        row_filter,--v_groups,--variants. Using this overrides
                        those options
  --cluster_cols col1,col2,...
                        Comma separated list of cluster columns to include.
                        Choose from: assembled, match, ref_seq, pct_id,
                        ctg_cov, known_var, novel_var [match]
  --col_filter y|n      Choose whether columns where all values are "no" or
                        "NA" are removed [y]
  --no_tree             Do not make phandango tree
  --row_filter y|n      Choose whether rows where all values are "no" or "NA"
                        are removed [y]
  --min_id FLOAT        Minimum percent identity cutoff to count as assembled
                        [90]
  --only_clusters Cluster_names
                        Only report data for the given comma-separated list of
                        cluster names, eg: cluster1,cluster2,cluster42
  --v_groups            Show a group column for each group of variants
  --known_variants      Report all known variants
  --novel_variants      Report all novel variants
  --verbose             Be verbose

Files must be listed after the output file and/or the option --fofn must be
used. If both used, all files in the filename specified by --fofn AND the
files listed after the output file will be used as input.
```

## Metadata
- **Skill**: generated
