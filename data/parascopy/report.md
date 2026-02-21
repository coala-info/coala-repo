# parascopy CWL Generation Report

## parascopy_pretable

### Tool Description
Create homology pre-table. This command aligns genomic regions back to the genome to find homologous regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Total Downloads**: 83.5K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/tprodanov/parascopy
- **Stars**: N/A
### Original Help Text
```text
usage: parascopy pretable -f <fasta> [-r <regions> | -R <bed>] -o <bed> [arguments]

Create homology pre-table.
This command aligns genomic regions back to the genome to find homologous regions.

Input/output arguments:
  -f <file>, --fasta-ref <file>
                        Input reference fasta file. Should have BWA index.
  -o <file>, --output <file>
                        Output bed[.gz] file.

Region arguments (optional):
  -r <region> [<region> ...], --regions <region> [<region> ...]
                        Region(s) in format "chr" or "chr:start-end").
                        Start and end are 1-based inclusive. Commas are ignored.
  -R <file> [<file> ...], --regions-file <file> [<file> ...]
                        Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).

Filtering arguments:
  --min-aln-len <int>   Minimal alignment length [default: 250].
  --min-seq-sim <float>
                        Minimal sequence similarity [default: 0.96].
  --max-homologies <int>
                        Skip regions with more than <int> homologies (copies) in the genome [default: 10].
  --keep-self-alns      If true, partial self-alignments will be kept
                        (for example keep an alignment with a 300bp shift).
                        Full self-alignments are always discarded.

Optional arguments:
  --read-len <int>      Artificial read length [default: 900].
  --step-size <int>     Artificial reads step size [default: 150].
  -s, --symmetric       Create a symmetric homology table (may be unstable).

Execution arguments:
  -F, --force           Force overwrite output file.
  -@ <int>, --threads <int>
                        Use <int> threads [default: 4].
  --tmp-dir <dir>       Puts temporary files in the following directory (does not remove temporary
                        files after finishing). Otherwise, creates a temporary directory.
  -b <path>, --bwa <path>
                        Path to BWA executable [default: bwa].
  --seed-len <int>      Minimum BWA seed length [default: 16].
  --tabix <path>        Path to "tabix" executable [default: tabix].
  --bedtools <path>     Path to "bedtools" executable [default: bedtools].
  --bgzip <path>        Path to "bgzip" executable [default: bgzip].

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_This

### Tool Description
A tool for analyzing paralogous sequence copies. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown command "This"

Usage: parascopy <command>
    Valid commands: help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.
```


## parascopy_to

### Tool Description
A tool for analyzing paralogous sequence copies. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown command "to"

Usage: parascopy <command>
    Valid commands: help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.
```


## parascopy_table

### Tool Description
Convert homology pre-table into homology table. This command combines overlapping homologous regions into longer duplications.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: parascopy table -i <pretable> -f <fasta> -o <table> [arguments]

Convert homology pre-table into homology table.
This command combines overlapping homologous regions into longer duplications.

Input/output arguments:
  -i <file>, --input <file>
                        Input indexed bed.gz homology pre-table.
  -f <file> [<file>], --fasta-ref <file> [<file>]
                        Input reference fasta file.
  -o <file>, --output <file>
                        Output table bed[.gz] file with homology table.
  -g <file>, --graph <file>
                        Optional: output directory with duplication graphs.

Region arguments (optional):
  -r <region>, --regions <region>
                        Region(s) in format "chr" or "chr:start-end").
                        Start and end are 1-based inclusive. Commas are ignored.
  -R <file>, --regions-file <file>
                        Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).

Duplications filtering arguments:
  -e <expr>, --exclude <expr>
                        Exclude duplications for which the expression is true
                        [default: length < 500 && seq_sim < 0.97].
  -t <expr>, --tangled <expr>
                        Exclude duplications for which the expression is true and mark regions
                        as "tangled". These regions will be discarded from downstream analysis.
                        Regions in args.exclude will be discarded first.
                        By default, this discards tandem duplications with high multiplicity
                        (low complexity). [default: sep < 5000 && av_mult > 2].

Optional arguments:
  --tabix <path>        Path to "tabix" executable [default: tabix].
  -@ <int>, --threads <int>
                        Use <int> threads [default: 4].

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_This

### Tool Description
A tool for analyzing paralogous sequence copies. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown command "This"

Usage: parascopy <command>
    Valid commands: help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.
```


## parascopy_into

### Tool Description
A tool for analyzing paralogous genes and their copy number variations. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, and call.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown command "into"

Usage: parascopy <command>
    Valid commands: help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.
```


## parascopy_depth

### Tool Description
Calculate read depth and variance in given genomic windows.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: parascopy depth (-i <bam> [...] | -I <bam-list>) (-g hg19|hg38 | -b <bed>) -f <fasta> -o <dir> [arguments]

Calculate read depth and variance in given genomic windows.

Input/output arguments:
  -i <file> [<file> ...], --input <file> [<file> ...]
                        Input indexed BAM/CRAM files.
                        All entries should follow the format "filename[::sample]"
                        If sample name is not set, all reads in a corresponding file should have a read group (@RG).
                        Mutually exclusive with --input-list.
  -I <file>, --input-list <file>
                        A file containing a list of input BAM/CRAM files.
                        All lines should follow the format "filename[ sample]"
                        If sample name is not set, all reads in a corresponding file should have a read group (@RG).
                        Mutually exclusive with --input.
                        
  -g <str>, --genome <str>
                        Use predefined windows for the human genome, possible values are:
                        GRCh37, GRCh38, CHM13; with an optional suffix `-fast`.
                        Mutually exclusive with --bed-regions.
  -b <file>, --bed-regions <file>
                        Input bed[.gz] file containing windows (tab-separated, 0-based semi-exclusive),
                        which will be used to calculate read depth. Windows must be non-overlapping
                        and have the same size. Mutually exclusive with --genome.
                        
  -f <file>, --fasta-ref <file>
                        Input reference fasta file.
  -o <dir>, --output <dir>
                        Output directory.

Filtering arguments:
  -m <float>, --low-mapq-perc <float>
                        Skip windows that have more than <float>% reads with MAPQ < 10 [default: 10].
  -c <float>, --clipped-perc <float>
                        Skip windows that have more than <float>% reads with soft/hard clipping [default: 10].
  -u <float>, --unpaired-perc <float>
                        Skip windows that have more than <float>% reads without proper pair [default: 10].
  -N <int>, --neighbours <int>
                        Discard <int> neighbouring windows to the left and to the right
                        of a skipped window [default: 1].

Depth calculation arguments:
  --long                Prepare read depth for long reads. Implies --no-gc.
  --no-gc               Do not stratify by GC-content. Useful for long reads.
  --loess-frac <float>  Loess parameter: use <float> closest windows to estimate average read depth
                        for each GC-percentage [default: 0.2].
  --tail-windows <int>  Do not use GC-content if it lies in the left or right tail
                        with less than <int> windows [default: 1000].
  --low-mapq <int>      Read mapping quality under <int> is considered as low [default: 10].
  --mate-dist <int>     Insert size (~ distance between read mates) is expected to be under <int> [default: 5000].
  --ploidy <int>        Genome ploidy. [default: 2].
                        If not 2, run "parascopy cn[-using]" with "--modify-ref" parameter.

Optional arguments:
  -@ <int>, --threads <int>
                        Number of threads [default: 4].

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_cn

### Tool Description
Find aggregate and paralog-specific copy number for given unique and duplicated regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: parascopy cn (-i <bam> [...] | -I <bam-list>) -t <table> -f <fasta> (-r <region> [...] | -R <bed>) -d <bg-depth> [...] -o <dir> [arguments]

Find aggregate and paralog-specific copy number for given unique and duplicated regions.

Input/output arguments:
  -i <file>, --input <file>
                        Input indexed BAM/CRAM files.
                        All entries should follow the format "filename[::sample]"
                        If sample name is not set, all reads in a corresponding file should have a read group (@RG).
                        Mutually exclusive with --input-list.
  -I <file>, --input-list <file>
                        A file containing a list of input BAM/CRAM files.
                        All lines should follow the format "filename[ sample]"
                        If sample name is not set, all reads in a corresponding file should have a read group (@RG).
                        Mutually exclusive with --input.
                        
  -t <file>, --table <file>
                        Input indexed bed table with information about segmental duplications.
  -f <file>, --fasta-ref <file>
                        Input reference fasta file.
  -d <file> [<file> ...], --depth <file> [<file> ...]
                        Input files / directories with background read depth.
                        Should be created using "parascopy depth".
  -o <dir>, --output <dir>
                        Output directory.

Region arguments:
  -r <region> [<region> ...], --regions <region> [<region> ...]
                        Region(s) in format "chr" or "chr:start-end".
                        Start and end are 1-based inclusive. Commas are ignored.
                        Optionally, you can provide region name using the format "region::name"
                        For example "-r chr5:70,925,087-70,953,015::SMN1".
  -R <file> [<file> ...], --regions-file <file> [<file> ...]
                        Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).
                        Optional fourth column will be used as a region name.
  --force-agcn <bed>    Instead of calculating aggregate copy numbers, use provided bed file.
                        Columns: chrom, start, end, samples, copy_num. Fourth column can be a single sample name;
                        list of sample names separated by ","; or "*" to indicate all samples.
  --modify-ref <bed>    Modify reference copy number using bed file with the same format as `--force-agcn`.
                        Provided values are used for paralog-specific copy number detection.
  --regions-subset <str> [<str> ...]
                        Additionally filter input regions: only use regions with names that are in this list.
                        If the first argument is "!", only use regions not in this list.

Duplications filtering arguments:
  -e <expr>, --exclude <expr>
                        Exclude duplications for which the expression is true
                        [default: length < 500 && seq_sim < 0.97].
  --short <int>         Skip regions with short duplications (shorter than <int> bp),
                        not excluded in the -e/--exclude argument [default: 500].
  --max-ref-cn <int>    Skip regions with reference copy number higher than <int> [default: 10].
  --unknown-seq <float>
                        At most this fraction of region sequence can be unknown (N) [default: 0.1].
  --skip-unique         Skip regions without any duplications in the reference genome.

Aggregate copy number detection arguments:
  --min-samples <int>   Use multi-sample information if there are at least <int> samples present
                        for the region/PSV [default: 50].
  --min-windows <int>   Predict aggregate and paralog copy number only in regions with at
                        least <int> windows [default: 5].
  --region-dist <int>   Jointly calculate copy number for nearby duplications with equal reference copy number,
                        if the distance between them does not exceed <int> [default: 1000].
  --window-filtering <float>
                        Modify window filtering: by default window filtering is the same as in the background
                        read depth calculation [default: 1].
                        Values < 1 - discard more windows, > 1 - keep more windows.
  --agcn-range <int> <int>
                        Detect aggregate copy number in a range around the reference copy number [default: 5 7].
                        For example, for a duplication with copy number 8 copy numbers 3-15 can be detected.
  --strict-agcn-range   Detect aggregate copy number strictly within the --agcn-range, even if there are
                        samples with bigger/smaller copy number values.
  --agcn-jump <int>     Maximal jump in the aggregate copy number between two consecutive windows [default: 6].
  --transition-prob <float>
                        Log10 transition probability for the aggregate copy number HMM [default: -5].
  --uniform-initial     Copy number HMM: use uniform initial distribution and do not update initial probabilities.
  --no-multipliers      Do not estimate or use read depth multipliers.
  --update-agcn <float>
                        Update agCN using psCN probabilities when agCN quality is less than <float> [default: 40].
  --vmr <str>           Sort samples by variance-mean ratio, and only use samples with smallest values.
                        Value should be either <float> (ratio threshold), or <float>% (use this percentile).

Paralog-specific copy number detection arguments:
  --reliable-threshold <float> <float>
                        PSV-reliability thresholds (reliable PSV has all f-values over the threshold).
                        First value is used for gene conversion detection,
                        second value is used to estimate paralog-specific CN [default: 0.80 0.95].
  --pscn-bound <int> [<int>]
                        Do not estimate paralog-specific copy number if any of the statements is true:
                        - aggregate copy number is higher than <int>[1]           [default: 8],
                        - number of possible psCN tuples is higher than <int>[2]  [default: 500].

Execution parameters:
  --rerun full|partial|none
                        Rerun CN analysis for all loci:
                            full:    complete rerun,
                            partial: use pooled reads from a previous run,
                            none:    skip successfully finished loci [default].
  --skip-cn             Do not calculate agCN and psCN profiles. If this option is set, Parascopy still
                        calculates read depth for duplicated windows and PSV-allelic read depth.
  --skip-pscn           Do not calculate psCN profiles.
  --pool-cram           Pool reads into CRAM files (currently, BAM by default).
  -@ <int>, --threads <int>
                        Number of available threads [default: 4].
  --clean <str>         Which temporary files to remove (multi-letter code, default: empty):
                            e - files in `extra` subdirectories,
                            p - pooled reads BAM/CRAM files.
  --samtools <path>|none
                        Path to samtools executable [default: samtools].
                        Use python wrapper if "none", can lead to errors.
  --tabix <path>        Path to "tabix" executable [default: tabix].
                        Use "none" to skip indexing output files.

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_for

### Tool Description
A tool for analyzing paralogous sequence copies. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, and call.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown command "for"

Usage: parascopy <command>
    Valid commands: help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.
```


## parascopy_cn-using

### Tool Description
Find aggregate and paralog-specific copy number for given unique and duplicated regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: parascopy cn-using <model> (-i <bam> [...] | -I <bam-list>) -t <table> -f <fasta> -d <bg-depth> [...] -o <dir> [arguments]

Find aggregate and paralog-specific copy number for given unique and duplicated regions.

Input/output arguments:
  <model>               Use model parameters from an independent "parascopy cn" run.
                        Allows multiple arguments of the following types:
                        - model/<region>.gz,
                        - file with paths to *.gz files,
                        - directory: use all subfiles *.gz.
                        
  -i <file>, --input <file>
                        Input indexed BAM/CRAM files.
                        All entries should follow the format "filename[::sample]"
                        If sample name is not set, all reads in a corresponding file should have a read group (@RG).
                        Mutually exclusive with --input-list.
  -I <file>, --input-list <file>
                        A file containing a list of input BAM/CRAM files.
                        All lines should follow the format "filename[ sample]"
                        If sample name is not set, all reads in a corresponding file should have a read group (@RG).
                        Mutually exclusive with --input.
                        
  -t <file>, --table <file>
                        Input indexed bed table with information about segmental duplications.
  -f <file>, --fasta-ref <file>
                        Input reference fasta file.
  -d <file> [<file> ...], --depth <file> [<file> ...]
                        Input files / directories with background read depth.
                        Should be created using "parascopy depth".
  -o <dir>, --output <dir>
                        Output directory.

Region arguments:
  --force-agcn <bed>    Instead of calculating aggregate copy numbers, use provided bed file.
                        Columns: chrom, start, end, samples, copy_num. Fourth column can be a single sample name;
                        list of sample names separated by ","; or "*" to indicate all samples.
  --regions-subset <str> [<str> ...]
                        Additionally filter input regions: only use regions with names that are in this list.
                        If the first argument is "!", only use regions not in this list.

Duplications filtering arguments:
  --unknown-seq <float>
                        At most this fraction of region sequence can be unknown (N) [default: 0.1].
  --skip-unique         Skip regions without any duplications in the reference genome.

Aggregate copy number detection arguments:
  --uniform-initial     Copy number HMM: use uniform initial distribution and do not update initial probabilities.
  --no-multipliers      Do not estimate or use read depth multipliers.
  --update-agcn <float>
                        Update agCN using psCN probabilities when agCN quality is less than <float> [default: 40].
  --vmr <str>           Sort samples by variance-mean ratio, and only use samples with smallest values.
                        Value should be either <float> (ratio threshold), or <float>% (use this percentile).

Paralog-specific copy number detection arguments:
  --reliable-threshold <float> <float>
                        PSV-reliability thresholds (reliable PSV has all f-values over the threshold).
                        First value is used for gene conversion detection,
                        second value is used to estimate paralog-specific CN.
                        Default: use reliable thresholds from <model>.

Execution parameters:
  --rerun full|partial|none
                        Rerun CN analysis for all loci:
                            full:    complete rerun,
                            partial: use pooled reads from a previous run,
                            none:    skip successfully finished loci [default].
  --skip-cn             Do not calculate agCN and psCN profiles. If this option is set, Parascopy still
                        calculates read depth for duplicated windows and PSV-allelic read depth.
  --skip-pscn           Do not calculate psCN profiles.
  --pool-cram           Pool reads into CRAM files (currently, BAM by default).
  -@ <int>, --threads <int>
                        Number of available threads [default: 4].
  --clean <str>         Which temporary files to remove (multi-letter code, default: empty):
                            e - files in `extra` subdirectories,
                            p - pooled reads BAM/CRAM files.
  --samtools <path>|none
                        Path to samtools executable [default: samtools].
                        Use python wrapper if "none", can lead to errors.
  --tabix <path>        Path to "tabix" executable [default: tabix].
                        Use "none" to skip indexing output files.

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_pool

### Tool Description
Pool reads from various copies of a duplication.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: parascopy pool (-i <bam> [...] | -I <bam-list>) -t <table> -f <fasta> -r <region> -o <dir>

Pool reads from various copies of a duplication.

Input/output arguments:
  -i <file> [<file> ...], --input <file> [<file> ...]
                        Input indexed BAM/CRAM files.
                        All entries should follow the format "filename[::sample]"
                        If sample name is not set, all reads in a corresponding file should have a read group (@RG).
                        Mutually exclusive with --input-list.
  -I <file>, --input-list <file>
                        A file containing a list of input BAM/CRAM files.
                        All lines should follow the format "filename[ sample]"
                        If sample name is not set, all reads in a corresponding file should have a read group (@RG).
                        Mutually exclusive with --input.
                        
  -t <file>, --table <file>
                        Input indexed bed table with information about segmental duplications.
  -f <file>, --fasta-ref <file>
                        Input reference fasta file.
  -r <region>, --region <region>
                        Single region in format "chr:start-end". Start and end are 1-based inclusive.
                        Commas are ignored.
  -o <dir>|<file>, --output <dir>|<file>
                        Output BAM/CRAM file if corresponding extension is used.
                        Otherwise, write CRAM files in the output directory.
  -b, --bam             Write BAM files to the output directory instead of CRAM.

Duplications filtering arguments:
  -e <expr>, --exclude <expr>
                        Exclude duplications for which the expression is true
                        [default: length < 500 && seq_sim < 0.97].

Optional arguments:
  -m <int>|infinity, --mate-dist <int>|infinity
                        Output read mates even if they are outside of the duplication,
                        if the distance between mates is less than <int> [default: 5000].
                        Use 0 to skip all mates outside the duplicated regions.
                        Use inf|infinity to write all mapped read mates.
  -q, --quiet           Do not write information to the stderr.
  --samtools <path>|none
                        Path to samtools executable [default: samtools].
                        Use python wrapper if "none", can lead to errors.
  --only-regions <file>
                        Append regions, used for pooling and realigning, to this file, and stop.

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_call

### Tool Description
Call variants in duplicated regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: parascopy call -p <dir> [-i <bam> ... | -I <bam-list>] -t <table> -f <fasta> [-o <dir>]

Call variants in duplicated regions.

Input/output arguments:
  -p <dir>, --parascopy <dir>
                        Input directory with Parascopy copy number estimates.
                        By default, pooled reads from the --parascopy directory are taken,
                        however, one may supply alignment files using -i and -I arguments.
  -i <file>, --input <file>
                        Optional: Input indexed BAM/CRAM files.
                        All entries should follow the format "filename[::sample]"
                        If sample name is not set, all reads in a corresponding file should have a read group (@RG).
                        Mutually exclusive with --input-list.
  -I <file>, --input-list <file>
                        Optional: A file containing a list of input BAM/CRAM files.
                        All lines should follow the format "filename[ sample]"
                        If sample name is not set, all reads in a corresponding file should have a read group (@RG).
                        Mutually exclusive with --input.
                        
  -t <file>, --table <file>
                        Input indexed bed table with information about segmental duplications.
  -f <file>, --fasta-ref <file>
                        Input reference fasta file.
  -o <dir>, --output <dir>
                        Output directory. Required if -i or -I arguments were used.
  -R <file>, --regions <file>
                        Limit analysis to regions in the provided BED file.

Freebayes parameters:
  --freebayes <path>    Optional: path to the modified Freebayes executable.
  --alternate-count <int>
                        Minimum alternate allele read count (in at least one sample),
                        corresponds to freebayes parameter -C <int> [default: 4].
  --alternate-fraction <float>
                        Minimum alternate allele read fraction (in at least one sample),
                        corresponds to freebayes parameter -F <float> [default: 0.05].
  --n-alleles <int>     Use at most <int> best alleles (set 0 to all),
                        corresponds to freebayes parameter -n <int> [default: 3].

Variant calling parameters:
  --skip-paralog        Do not calculate paralog-specific genotypes.
  --limit-qual <float>  Skip SNVs that do not overlap PSVs and have Freebayes quality
                        under <float> [default: 1].
  --assume-cn <bed>     Instead of using Parascopy paralog-specific copy number values, use copy number from
                        the input file with columns "chrom start end samples copy_num".
                        Fourth input column can be a single sample name; list of sample names separated by ",";
                        or "*" to indicate all samples.
  --limit-pooled <float>
                        Based solely on allelic read depth, ignore pooled genotypes with probabilities
                        under 10^<float> [default: -5].
  --mutation-rate <float>
                        Log10 mutation rate (used for calculating genotype priors) [default: -3].
  --error-rate <float> <float>
                        Two error rates: first for SNPs, second for indels [default: 0.01 0.01].
  --base-qual <int> <int>
                        Ignore observations with low base quality (first for SNPs, second for indels) [default: 10 10].
  --no-mate-penalty <float>
                        Penalize possible paired-read alignment positions in case they do not match
                        second read alignment position (log10 penalty) [default: -5].
  --psv-ref-gt <float>  Use all PSVs (even unreliable) if they have a reference paralog-specific
                        genotype (genotype quality >= <float>) [default: 20].
  --limit-depth <int> <int>
                        Min and max variant read depth [default: 3, 2000].
  --strand-bias <float>
                        Maximum strand bias (Phred score) [default: 30].
  --unpaired-bias <float>
                        Maximum unpaired bias (Phred score) [default: 30].
  --max-agcn <int>      Maximum aggregate copy number [default: 10].

Execution parameters:
  --rerun full|partial|none
                        Rerun analysis for all loci:
                            full:    complete rerun,
                            partial: use already calculated read-allele observations,
                            none:    skip successfully finished loci [default].
  -s (<file>|<name>) ..., --samples (<file>|<name>) ...
                        Limit the analysis to the provided sample names.
                        Input may consist of sample names and files with sample names (filename should contain "/").
  -@ <int>, --threads <int>
                        Number of available threads [default: 4].
  --regions-subset <str> [<str> ...]
                        Additionally filter input regions: only use regions with names that are in this list.
                        If the first argument is "!", only use regions not in this list.
  --clean <str>         Which temporary files to remove (multi-letter code, default: empty):
                            v - files in `var_extra` subdirectories,
                            p - pooled reads BAM/CRAM files.
  --samtools <path>     Path to "samtools" executable [default: samtools].
  --tabix <path>        Path to "tabix" executable [default: tabix].
                        Use "none" to skip indexing output files.
  --debug               Output additional debug information.

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_view

### Tool Description
View and filter homology table.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: parascopy view <table> [-o <table>] [arguments]

View and filter homology table.

Input/output arguments:
  <file>                Input indexed bed.gz homology table.
  -o <file>, --output <file>
                        Optional: output path.

Region arguments (optional):
  -r <region> [<region> ...], --regions <region> [<region> ...]
                        Region(s) in format "chr" or "chr:start-end").
                        Start and end are 1-based inclusive. Commas are ignored.
  -R <file> [<file> ...], --regions-file <file> [<file> ...]
                        Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).
  --r2 <region> [<region> ...], --regions2 <region> [<region> ...]
                        Second region must overlap region(s) in format "chr" or "chr:start-end").
                        Start and end are 1-based inclusive. Commas are ignored.
  --R2 <file> [<file> ...], --regions2-file <file> [<file> ...]
                        Second region must overlap regions from the input bed[.gz] file(s).

Duplications filtering arguments:
  -i <expr>, --include <expr>
                        Include duplications for which the expression is true.
  -e <expr>, --exclude <expr>
                        Exclude duplications for which the expression is true.
  -t, --skip-tangled    Do not show tangled regions.

Output format arguments:
  -p, --pretty          Print commas as thousand separator and split info field into tab entries.

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_msa

### Tool Description
Visualize multiple sequence alignment of homologous regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: parascopy msa -t <table> -f <fasta> (-r <region> | -R <bed>) [-o <clustal>] [arguments]

Visualize multiple sequence alignment of homologous regions.

Input/output arguments:
  -t <file>, --table <file>
                        Input indexed bed.gz homology table.
  -f <file>, --fasta-ref <file>
                        Input reference fasta file.
  -o <file>, --output <file>
                        Optional: output in clustal format.
  -O <file>, --out-csv <file>
                        Optional: output csv file with aligned positions.

Region arguments (at least one is required):
  -r <region> [<region> ...], --regions <region> [<region> ...]
                        Region(s) in format "chr" or "chr:start-end").
                        Start and end are 1-based inclusive. Commas are ignored.
  -R <file> [<file> ...], --regions-file <file> [<file> ...]
                        Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).

Duplications filtering arguments:
  -e <expr>, --exclude <expr>
                        Exclude duplications for which the expression is true [default: length < 500].

Optional arguments:
  -c, --true-clustal    Outputs true clustal format: writes gaps outside the boundary of duplication,
                        writes number of bases instead of genomic position.
  -w <int>, --width <int>
                        Number of basepairs per line [default: 60].

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_homologous

### Tool Description
The provided help text indicates that 'homologous' is an unknown command for the 'parascopy' tool. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, and call.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown command "homologous"

Usage: parascopy <command>
    Valid commands: help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.
```


## parascopy_psvs

### Tool Description
Output PSVs (paralogous-sequence variants) between homologous regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: parascopy psvs -t <table> -f <fasta> (-r <region> | -R <bed>) -o <vcf> [arguments]

Output PSVs (paralogous-sequence variants) between homologous regions.

Input/output arguments:
  -t <file>, --table <file>
                        Input indexed bed.gz homology table.
  -f <file>, --fasta-ref <file>
                        Input reference fasta file.
  -o <file>, --output <file>
                        Output vcf[.gz] file.

Region arguments (required):
  -r <region> [<region> ...], --regions <region> [<region> ...]
                        Region(s) in format "chr" or "chr:start-end").
                        Start and end are 1-based inclusive. Commas are ignored.
  -R <file> [<file> ...], --regions-file <file> [<file> ...]
                        Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).

Duplications filtering arguments:
  -e <expr>, --exclude <expr>
                        Exclude duplications for which the expression is true [default: length < 500].

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_between

### Tool Description
Error: unknown command "between". Valid commands: help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown command "between"

Usage: parascopy <command>
    Valid commands: help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.
```


## parascopy_examine

### Tool Description
Split input regions by reference copy number.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: parascopy examine -t <table> -o <table> [arguments]

Split input regions by reference copy number.

Input/output arguments:
  -t <file>, --table <file>
                        Input indexed bed.gz homology table.
  -o <file>, --output <file>
                        Output bed[.gz] file.

Region arguments (optional):
  -r <region> [<region> ...], --regions <region> [<region> ...]
                        Region(s) in format "chr" or "chr:start-end").
                        Start and end are 1-based inclusive. Commas are ignored.
  -R <file> [<file> ...], --regions-file <file> [<file> ...]
                        Input bed[.gz] file(s) containing regions (tab-separated, 0-based semi-exclusive).

Duplications filtering arguments:
  -e <expr>, --exclude <expr>
                        Exclude duplications for which the expression is true [default: length < 500].

Optional arguments:
  -m <int>, --min-length <int>
                        Do not output entries shorter that the minimal length [default: 0].

Other arguments:
  -h, --help            Show this help message
  -V, --version         Show version.
```


## parascopy_and

### Tool Description
A tool for analyzing paralogous sequence copies. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: unknown command "and"

Usage: parascopy <command>
    Valid commands: help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call.
```


## parascopy_cite

### Tool Description
Display citation information for Parascopy

### Metadata
- **Docker Image**: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
- **Homepage**: https://github.com/tprodanov/parascopy
- **Package**: https://anaconda.org/channels/bioconda/packages/parascopy/overview
- **Validation**: PASS

### Original Help Text
```text
Parascopy v1.19.0
Created by Timofey Prodanov & Vikas Bansal

Please cite:
  * Copy-number variation detection:
    Prodanov, T. & Bansal, V. Robust and accurate estimation of paralog-specific copy number
    for duplicated genes using whole-genome sequencing. [3mNature Communications[0m [1m13[0m, 3221 (2022)
    [4mhttps://doi.org/10.1038/s41467-022-30930-3[0m

  * Variant calling:
    Prodanov, T. & Bansal, V. A multi-locus approach for accurate variant calling in low-copy
    repeats using whole-genome sequencing. [3mBioinformatics[0m [1m39[0m, i279-i287 (2023)
    [4mhttps://doi.org/10.1093/bioinformatics/btad268[0m
```


## Metadata
- **Skill**: generated
