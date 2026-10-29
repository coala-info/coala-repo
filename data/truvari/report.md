# truvari CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| truvari | PASS | wraps truvari bench; rewritten from the help; real_small SV VCFs give TP+FN=base count and TP+FP=comp count |
| truvari_anno_addid | PASS |  |
| truvari_anno_bpovl | PASS |  |
| truvari_anno_chunks | PASS |  |
| truvari_anno_density | PASS |  |
| truvari_anno_dpcnt | PASS |  |
| truvari_anno_gcpct | PASS |  |
| truvari_anno_grm | Failed | image problem: bwapy is not installed in the image (tool prints 'bwapy isn't available') |
| truvari_anno_grpaf | PASS |  |
| truvari_anno_gtcnt | PASS |  |
| truvari_anno_hompct | PASS |  |
| truvari_anno_lcr | PASS |  |
| truvari_anno_numneigh | PASS |  |
| truvari_anno_remap | Failed | image problem: bwapy is not installed in the image (tool prints 'bwapy isn't available') |
| truvari_anno_repmask | Not completed | RepeatMasker is not in the image; only the repo's fake test script could be used (output matches the repo answer key) |
| truvari_anno_svinfo | PASS |  |
| truvari_anno_trf | PASS | real trf binary from the repo test files; annotations match the repo answer key; repeats file re-bgzipped (repo copy is plain gzip) |
| truvari_collapse | PASS |  |
| truvari_consistency | PASS |  |
| truvari_divide | PASS |  |
| truvari_ga4gh | PASS |  |
| truvari_phab | PASS |  |
| truvari_refine | PASS |  |
| truvari_segment | PASS |  |
| truvari_stratify | PASS |  |
| truvari_stratp | PASS |  |
| truvari_vcf2df | PASS |  |

## truvari

### Tool Description
Performance metrics for structural variant calling

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/spiralgenetics/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Total Downloads**: 27.3K
- **Last updated**: 2025-10-08
- **GitHub**: https://github.com/spiralgenetics/truvari
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0' locally
5.4.0--pyhdfd78af_0: Pulling from biocontainers/truvari
0cacab098358: Already exists
bd9ddc54bea9: Already exists
eafbf86db929: Pulling fs layer
docker: write /var/lib/docker/tmp/GetImageBlob2966681274: no space left on device

Run 'docker run --help' for more information
```

## truvari_anno_addid

### Tool Description
Sets an ID to variants

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: addid [-h] [-o OUTPUT] [input]

Sets an ID to variants

positional arguments:
  input                 VCF to annotate (stdin)

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output filename (stdout)
```

## truvari_anno_bpovl

### Tool Description
Creates intersection of features in an annotation file with SVs' breakpoints and overlap

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bpovl [-h] -a ANNO -o OUTPUT [--sizemin SIZEMIN] [--spanmax SPANMAX]
             [-p {bed,gff}] [-c COMMENT] [-s SEQUENCE] [-b BEGIN] [-e END]
             [-1]
             [input]

Creates intersection of features in an annotation file with SVs' breakpoints and overlap

positional arguments:
  input                 VCF to annotate (stdin)

options:
  -h, --help            show this help message and exit
  -a ANNO, --anno ANNO  Tab-delimited annotation file
  -o OUTPUT, --output OUTPUT
                        Output joblib DataFrame
  --sizemin SIZEMIN     Minimum size of variant to annotate (50)
  --spanmax SPANMAX     Maximum span of SVs to annotate (50000)

Annotation File Arguments:
  -p {bed,gff}, --preset {bed,gff}
                        Annotation format. This option overwrites -s, -b, -e,
                        -c and -1 (None)
  -c COMMENT, --comment COMMENT
                        Skip lines started with character. (#)
  -s SEQUENCE, --sequence SEQUENCE
                        Column of sequence/chromosome name. (0)
  -b BEGIN, --begin BEGIN
                        Column of start chromosomal position. (1)
  -e END, --end END     Column of end chromosomal position. (2)
  -1, --one-based       The position in the anno file is 1-based rather than
                        0-based. (False)
```

## truvari_anno_chunks

### Tool Description
Count the number of variants in each chunk

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chunks [-h] [-b BED] [-o OUTPUT] [-c CHUNKSIZE] [-s SIZEMIN]
              [-S SIZEMAX]
              input

Count the number of variants in each chunk
Column 3: total number of variants
Column 4: comma-deliminted number of sub-chunks after accounting for size
Column 5: comma-deliminted number of sub-chunks after accounting for size and distance again

positional arguments:
  input                 Input VCF

options:
  -h, --help            show this help message and exit
  -b BED, --bed BED     Bed file of variants to chunk
  -o OUTPUT, --output OUTPUT
                        Output name
  -c CHUNKSIZE, --chunksize CHUNKSIZE
                        Distance between variants to split chunks (500)
  -s SIZEMIN, --sizemin SIZEMIN
                        Minimum SV length (50)
  -S SIZEMAX, --sizemax SIZEMAX
                        Maximum SV length (50000)
```

## truvari_anno_density

### Tool Description
Identify 'dense' and 'sparse' variant windows of the genome

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: density [-h] -g GENOME -o OUTPUT [-m MASK] [-w WINDOWSIZE]
               [-s STEPSIZE] [-t THRESHOLD]
               [input]

Identify 'dense' and 'sparse' variant windows of the genome

positional arguments:
  input                 Input VCF (/dev/stdin)

options:
  -h, --help            show this help message and exit
  -g GENOME, --genome GENOME
                        Genome bed file
  -o OUTPUT, --output OUTPUT
                        Output joblib DataFrame
  -m MASK, --mask MASK  Mask bed file
  -w WINDOWSIZE, --windowsize WINDOWSIZE
                        Window size (10000)
  -s STEPSIZE, --stepsize STEPSIZE
                        Window step size (10000)
  -t THRESHOLD, --threshold THRESHOLD
                        std for identifying 'dense' regions (3)
```

## truvari_anno_dpcnt

### Tool Description
Quick utility to count how many samples have >= Nx coverage per-variant

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dpcnt [-h] [-b BINS] [--no-ad] [-p] [-o OUTPUT] [input]

Quick utility to count how many samples have >= Nx coverage per-variant

positional arguments:
  input                 VCF to annotate (stdin)

options:
  -h, --help            show this help message and exit
  -b BINS, --bins BINS  Coverage bins to bisect left the counts (0,5,10,15)
  --no-ad               Skip adding ADCNT bins
  -p, --present         Only count sites with present (non ./.) genotypes
  -o OUTPUT, --output OUTPUT
                        Output filename (stdout)
```

## truvari_anno_gcpct

### Tool Description
Annotates GC content of SVs

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gcpct [-h] [-o OUTPUT] -r REFERENCE [input]

Annotates GC content of SVs

positional arguments:
  input                 VCF to annotate (stdin)

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output filename (stdout)
  -r REFERENCE, --reference REFERENCE
                        Reference fasta
```

## truvari_anno_grm

### Tool Description
Maps graph edge kmers with BWA to assess Graph Reference Mappability

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: grm [-h] -i INPUT -r REFERENCE [-R REGIONS] [-o OUTPUT] [-k KMERSIZE]
           [-m MIN_SIZE] [-t THREADS] [--debug]

Maps graph edge kmers with BWA to assess Graph Reference Mappability

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input VCF
  -r REFERENCE, --reference REFERENCE
                        BWA indexed reference
  -R REGIONS, --regions REGIONS
                        Bed file of regions to parse (None)
  -o OUTPUT, --output OUTPUT
                        Output dataframe (results.jl)
  -k KMERSIZE, --kmersize KMERSIZE
                        Size of kmer to map (50)
  -m MIN_SIZE, --min-size MIN_SIZE
                        Minimum size of variants to map (25)
  -t THREADS, --threads THREADS
                        Number of threads (1)
  --debug               Verbose logging
```

## truvari_anno_grpaf

### Tool Description
Add allele frequency annotations for subsets of samples

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: grpaf [-h] [-o OUTPUT] -l LABELS [-t TAGS] [--strict] [--debug] [input]

Add allele frequency annotations for subsets of samples

positional arguments:
  input                 VCF to annotate

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output filename (stdout)
  -l LABELS, --labels LABELS
                        Tab-delimited file of sample and group
  -t TAGS, --tags TAGS  Comma-separated list of tags to add from
                        AF,MAF,ExcHet,HWE,MAC,AC,AN (all)
  --strict              Exit if sample listed in labels is not present in VCF
                        (False)
  --debug               Verbose logging
```

## truvari_anno_gtcnt

### Tool Description
Annotates GTCounts of alleles

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtcnt [-h] [-o OUTPUT] [input]

Annotates GTCounts of alleles

positional arguments:
  input                 VCF to annotate (stdin)

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output filename (stdout)
```

## truvari_anno_hompct

### Tool Description
Calculate the Hom / (Het + Hom) of variants in the region of SVs

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hompct [-h] -i INPUT [-o OUTPUT] [-b BUFFER] [-m MINANNO] [-M MAXGT]
              [-c MINCOUNT] [--debug]

Calcluate the the Hom / (Het + Hom) of variants in the region of SVs
Requires the VCF to contain SVs beside SNPs/Indels

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Compressed, indexed VCF to annotate
  -o OUTPUT, --output OUTPUT
                        Output filename (stdout)
  -b BUFFER, --buffer BUFFER
                        Number of base-pairs up/dn-stream to query (5000)
  -m MINANNO, --minanno MINANNO
                        Minimum size of event to annotate (50)
  -M MAXGT, --maxgt MAXGT
                        Largest event size to count for genotyping (1)
  -c MINCOUNT, --mincount MINCOUNT
                        Minimum number of genotyping events to report HOMPCT
                        (0)
  --debug               Verbose logging
```

## truvari_anno_lcr

### Tool Description
Annotate low complexity region entropy score for variants

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lcr [-h] [-o OUTPUT] [input]

Annotate low complexity region entropy score for variants
Credit: https://jszym.com/blog/dna_protein_complexity/

positional arguments:
  input                 VCF to annotate (stdin)

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output filename (stdout)
```

## truvari_anno_numneigh

### Tool Description
Add NumNeighbors and NeighId info fields for calls within size boundaries

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: numneigh [-h] [-o OUTPUT] [-r REFDIST] [-s SIZEMIN] [--passonly]
                [--debug]
                [input]

For every call within size boundaries,
Add NumNeighbors info field of how many calls are within the distance
Add NeighId clustering field in the same chained neighborhood
For example,
::
    -- is a call, refdist is 2
         - - -   -    - -
    nn:  1 2 1   0    1 1
    id:  0 0 0   1    2 2

positional arguments:
  input                 VCF to annotate

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output vcf (stdout)
  -r REFDIST, --refdist REFDIST
                        Max reference location distance (1000)
  -s SIZEMIN, --sizemin SIZEMIN
                        Minimum variant size to consider for annotation (50)
  --passonly            Only count calls with FILTER == PASS
  --debug               Verbose logging
```

## truvari_anno_remap

### Tool Description
Remap VCF's alleles sequence to the reference to annotate REMAP

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: remap [-h] -r REFERENCE [-o OUTPUT] [-m MINLENGTH] [-t THRESHOLD]
             [-d DIST] [-H HITS] [--debug]
             [input]

Remap VCF'S alleles sequence to the reference to annotate REMAP

- novel : Allele has no hits in reference
- tandem : Allele's closest hit is within len(allele) bp of the SV's position
- interspersed : Allele's closest hit is not tandem
- partial : Allele only has partial hit(s) less than --threshold

Which alleles and alignments to consider can be altered with:
- --minlength : minimum SV length to be remapped (50)
- --dist : For deletion SVs, do not consider alignments that hit within Nbp of the SV's position
(a.k.a. alignments back to the source sequence) (10)
- --threshold : Minimum percent of allele's sequence used by alignment to be considered (.8)

positional arguments:
  input                 Input VCF (/dev/stdin)

options:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        BWA indexed reference
  -o OUTPUT, --output OUTPUT
                        Output VCF (/dev/stdout)
  -m MINLENGTH, --minlength MINLENGTH
                        Smallest length of allele to remap (50)
  -t THRESHOLD, --threshold THRESHOLD
                        Threshold for pct of allele covered to consider hit
                        (0.8)
  -d DIST, --dist DIST  Minimum distance an alignment must be from a DEL's
                        position to be considered (10))
  -H HITS, --hits HITS  Report top hits as chr:start-end.pct (max 0)
  --debug               Verbose logging
```

## truvari_anno_repmask

### Tool Description
Wrapper around RepeatMasker to annotate insertion sequences in a VCF

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: repmask [-h] -i INPUT [-o OUTPUT] [-e EXECUTABLE] [-m MIN_LENGTH]
               [-M MAX_LENGTH] [-t THRESHOLD] [-p PARAMS] [-T THREADS]
               [--debug]

 Wrapper around RepeatMasker to annotate insertion sequences in a VCF 

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        VCF to annotate (None)
  -o OUTPUT, --output OUTPUT
                        Output filename (/dev/stdout)
  -e EXECUTABLE, --executable EXECUTABLE
                        Path to RepeatMasker (RepeatMasker)
  -m MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum size of entry to annotate (50)
  -M MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum size of entry to annotate (50000)
  -t THRESHOLD, --threshold THRESHOLD
                        Threshold for pct of allele covered (0.8)
  -p PARAMS, --params PARAMS
                        Default parameter string to send to RepeatMasker (-pa
                        {threads} -qq -e hmmer -species human -lcambig -nocut
                        -div 50 -no_id -s {fasta})
  -T THREADS, --threads THREADS
                        Number of threads to use (1)
  --debug               Verbose logging
```

## truvari_anno_svinfo

### Tool Description
Adds SVTYPE and SVLEN INFO fields

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svinfo [-h] [-o OUTPUT] [-m MINSIZE] [input]

Adds SVTYPE and SVLEN INFO fields

positional arguments:
  input                 VCF to annotate (stdin)

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output filename (stdout)
  -m MINSIZE, --minsize MINSIZE
                        Minimum size of entry to annotate (50)
```

## truvari_anno_trf

### Tool Description
Intersect vcf with reference tandem repeats and annotate variants with the best fitting repeat motif and its copy number

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: trf [-h] -i INPUT [-o OUTPUT] [-e EXECUTABLE] [-T TRF_PARAMS] -r
           REPEATS [--buffer BUFFER] -f REFERENCE [-s MOTIF_SIMILARITY]
           [-m MIN_LENGTH] [-R] [--no-estimate] [-C CHUNK_SIZE] [-t THREADS]
           [--debug]

Intersect vcf with reference tandem repeats and annotate
variants with the best fitting repeat motif and its copy number
relative to the reference

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        VCF to annotate
  -o OUTPUT, --output OUTPUT
                        Output filename (stdout)
  -e EXECUTABLE, --executable EXECUTABLE
                        Path to tandem repeat finder (trf409.linux64)
  -T TRF_PARAMS, --trf-params TRF_PARAMS
                        Default parameters to send to trf (3 7 7 80 5 40 500
                        -h -ngs)
  -r REPEATS, --repeats REPEATS
                        Reference repeat annotations
  --buffer BUFFER       buffer on annotations during intersection (5)
  -f REFERENCE, --reference REFERENCE
                        Reference fasta file
  -s MOTIF_SIMILARITY, --motif-similarity MOTIF_SIMILARITY
                        Motif similarity threshold (0.9)
  -m MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum size of entry to annotate (50)
  -R, --regions-only    Only write variants within --repeats regions (False)
  --no-estimate         Skip INS estimation procedure and run everything
                        through TRF. (False)
  -C CHUNK_SIZE, --chunk-size CHUNK_SIZE
                        Size (in mbs) of reference chunks for parallelization
                        (5)
  -t THREADS, --threads THREADS
                        Number of threads to use (1)
  --debug               Verbose logging
```

## truvari_collapse

### Tool Description
Structural variant collapser

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: collapse [-h] -i INPUT [-o OUTPUT] [-c REMOVED_OUTPUT] [-f REFERENCE]
                [-w] [-k {first,maxqual,common}] [--bed BED]
                [--gt {off,all,het}] [--intra] [--median-info] [-F] [--debug]
                [-r REFDIST] [-p PCTSEQ] [-P PCTSIZE] [-O PCTOVL] [-t] [-n]
                [-m MAX_RESOLVE] [-D] [-d] [-B BNDDIST] [--hap] [--chain]
                [--no-consolidate] [-s SIZEMIN] [-S SIZEMAX] [--passonly]

Structural variant collapser

Will collapse all variants within sizemin/max that match over thresholds

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input variants
  -o OUTPUT, --output OUTPUT
                        Output vcf (stdout)
  -c REMOVED_OUTPUT, --removed-output REMOVED_OUTPUT
                        Variants that collapsed into kept variants
                        (removed.vcf)
  -f REFERENCE, --reference REFERENCE
                        Indexed fasta used to call variants. Only needed with
                        symbolic variants.
  -w, --write-resolved  Replace resolved symbolic variants with their sequence
  -k {first,maxqual,common}, --keep {first,maxqual,common}
                        When collapsing calls, which one to keep (first)
  --bed BED             Bed file of regions to analyze
  --gt {off,all,het}    Disallow intra-sample events to collapse for genotypes
                        (off)
  --intra               Intrasample merge to first sample in output (False)
  --median-info         Store median start/end/size of collapsed entries in
                        kept's INFO
  -F, --fast-cluster    Perform pre-clustering faster, but potentially lose
                        matches (False)
  --debug               Verbose logging
  --hap                 Collapsing a single individual's haplotype resolved
                        calls (False)
  --chain               Chain comparisons to extend possible collapsing
                        (False)
  --no-consolidate      Skip consolidation of sample genotype fields (False)

Comparison Threshold Arguments:
  -r REFDIST, --refdist REFDIST
                        Max reference location distance (500)
  -p PCTSEQ, --pctseq PCTSEQ
                        Min percent sequence similarity. Set to 0 to ignore.
                        (0.95)
  -P PCTSIZE, --pctsize PCTSIZE
                        Min pct allele size similarity (minvarsize/maxvarsize)
                        (0.95)
  -O PCTOVL, --pctovl PCTOVL
                        Min pct reciprocal overlap (0.0) for DEL events
  -t, --typeignore      Variant types don't need to match to compare (False)
  -n, --no-roll         Turn off rolling sequence similarity
  -m MAX_RESOLVE, --max-resolve MAX_RESOLVE
                        Maximum size of variant to attempt to sequence resolve
                        ($(default)s)
  -D, --decompose       Allow decomposition for SV to BND comparison (False)
  -d, --dup-to-ins      Assume DUP svtypes are INS (False)
  -B BNDDIST, --bnddist BNDDIST
                        Maximum distance allowed between BNDs (100; -1=off)

Filtering Arguments:
  -s SIZEMIN, --sizemin SIZEMIN
                        Minimum variant size to consider for comparison (50)
  -S SIZEMAX, --sizemax SIZEMAX
                        Maximum variant size to consider for comparison (-1 =
                        off; 50000)
  --passonly            Only consider calls with FILTER == PASS
```

## truvari_consistency

### Tool Description
Over multiple vcfs, calculate their intersection/consistency

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: consistency [-h] [-d] [-j] [-o OUTPUT] VCFs [VCFs ...]

Over multiple vcfs, calculate their intersection/consistency.

Calls will match between VCFs if they have a matching key of `CHROM POS ID REF ALT`

positional arguments:
  VCFs                  VCFs to intersect

options:
  -h, --help            show this help message and exit
  -d, --no-dups         Disallow duplicate SVs
  -j, --json            Output report in json format
  -o OUTPUT, --output OUTPUT
                        Write tsv of variant keys, flag, vcf_count
```

## truvari_divide

### Tool Description
Divide a VCF into independent parts

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: divide [-h] [-b BUFFER] [-m MIN] [--no-compress] [-T THREADS] VCF DIR

Divide a VCF into independent parts

positional arguments:
  VCF                   VCF to split
  DIR                   Output directory to save parts

options:
  -h, --help            show this help message and exit
  -b BUFFER, --buffer BUFFER
                        Buffer to make mini-clusters (1000)
  -m MIN, --min MIN     Minimum number of entries per-vcf (50000)
  --no-compress         Don't attempt to compress/index sub-VCFs
  -T THREADS, --threads THREADS
                        Number of threads for compressing/indexing sub-VCFs
                        (1)
```

## truvari_ga4gh

### Tool Description
Consolidate truvari by truth/query and annotate with GA4GH intermediates tags

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ga4gh [-h] -i INPUT -o OUTPUT [-r] [-w] [-b BUFFER]

Consolidate truvari by truth/query and annotate with GA4GH intermediates tags

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Truvari result directory
  -o OUTPUT, --output OUTPUT
                        Output prefix
  -r, --no-refine       Don't pull from refined results
  -w, --write-phab      Count/Write the phab variant representations
  -b BUFFER, --buffer BUFFER
                        Amount of buffer used around refined regions (0)
```

## truvari_phab

### Tool Description
Wrapper around MAFFT and other tools to harmonize phased variants

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phab [-h] -r REGION -f REFERENCE [-o OUTPUT] [--maxsize MAXSIZE]
            [--passonly] [--no-dedup] [--buffer BUFFER]
            [--align {mafft,wfa,poa}] [--mafft-params MAFFT_PARAMS]
            [--samples SAMPLES] [--lowmem] [--threads THREADS] [--debug]
            INPUT [INPUT ...]

Wrapper around MAFFT and other tools to harmonize phased variants

positional arguments:
  INPUT                 Input VCFs to harmonize

options:
  -h, --help            show this help message and exit
  -r REGION, --region REGION
                        Bed filename or comma-separated list of chrom:start-
                        end regions to process
  -f REFERENCE, --reference REFERENCE
                        Reference
  -o OUTPUT, --output OUTPUT
                        Output VCF
  --maxsize MAXSIZE     Maximum size of variant to incorporate into haplotypes
                        (50000)
  --passonly            Only incorporate passing variants (False)
  --no-dedup            Don't dedupicate haplotypes before MSA
  --buffer BUFFER       Number of reference bases before/after region to add
                        to MSA (100)
  --align {mafft,wfa,poa}
                        Alignment method (poa)
  --mafft-params MAFFT_PARAMS
                        Parameters for mafft, wrap in a single quote (--auto
                        --thread 1)
  --samples SAMPLES     Subset of samples to MSA
  --lowmem              For harmonizing many samples
  --threads THREADS     Number of threads (1)
  --debug               Verbose logging
```

## truvari_refine

### Tool Description
Automated Truvari bench result refinement with phab variant harmonization

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refine [-h] [-a {mafft,wfa,poa}] [-u] [-w] [-t THREADS] [-b BUFFER]
              [-f REFERENCE] [-r REGIONS] [-c {R,O}] [-S] [-m MAFFT_PARAMS]
              [--debug]
              DIR

Automated Truvari bench result refinement with phab variant harmonization

positional arguments:
  DIR                   Truvari bench directory

options:
  -h, --help            show this help message and exit
  -a {mafft,wfa,poa}, --align {mafft,wfa,poa}
                        Alignment method for phab (poa)
  -u, --use-original-vcfs
                        Use original input VCFs instead of filtered tp/fn/fps
  -w, --write-phab      Use phab variant representations for counting/outputs
  -t THREADS, --threads THREADS
                        Number of threads to use (4)
  -b BUFFER, --buffer BUFFER
                        Amount of buffer around refined regions (100)
  -f REFERENCE, --reference REFERENCE
                        Indexed fasta used to call variants (optional if bench
                        -f was used)
  -r REGIONS, --regions REGIONS
                        Regions to refine (candidate.refine.bed)
  -c {R,O}, --coords {R,O}
                        Which bed file coordinates to use, Regions or
                        includebed Original (R)
  -S, --subset          Only report metrics from the refined regions
  -m MAFFT_PARAMS, --mafft-params MAFFT_PARAMS
                        Parameters for mafft, wrap in a single quote (--auto
                        --thread 1)
  --debug               Verbose logging
```

## truvari_segment

### Tool Description
Segmentation: Normalization of SVs into disjointed genomic regions

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: segment [-h] [-o OUTPUT] [--passonly] IN

Segmentation: Normalization of SVs into disjointed genomic regions

positional arguments:
  IN                    VCF to parse

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output VCF
  --passonly            Only segment PASS variants
```

## truvari_stratify

### Tool Description
Count variants which start and end within each bed region

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: stratify [-h] [-o OUT] [-H] [-v] [--debug] BED VCF

Count variants which start and end within each bed region

positional arguments:
  BED                   Regions to process
  VCF                   Truvari bench result directory or a single VCF

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Output bed-like file
  -H, --header          Input regions have header to preserve in output
  -v, --complement      Only count variants not within region boundaries
  --debug               Verbose logging
```

## truvari_stratp

### Tool Description
Stratification Performance Test

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: stratp [-h] [--features FEATURES] [--states {base,comp}]
              [--preset {mims,giab1.1}] [-o OUTPUT] [-c COUNT_OUTPUT]
              [--debug] [--min-obs MIN_OBS] [--nperm NPERM]
              [--tail {left,right,two}] [--alpha ALPHA] [--check-co CHECK_CO]
              [--seed SEED]
              DIR

Stratification Performance Test

positional arguments:
  DIR                   Truvari bench result directory

options:
  -h, --help            show this help message and exit
  --features FEATURES   Comma-separated list of categorical features to score
                        (e.g. svtype,szbin)
  --states {base,comp}  Score VCF entries from (base)line or (comp)arison
                        (default:base)
  --preset {mims,giab1.1}
                        Preset features to score
  -o OUTPUT, --output OUTPUT
                        Score output tsv file (stdout)
  -c COUNT_OUTPUT, --count-output COUNT_OUTPUT
                        Stratification variant count tsv file
  --debug               Verbose logging

statistics arguments:
  --min-obs MIN_OBS     Minimum observation for a bin (10)
  --nperm NPERM         Number of permutations to perform (10000)
  --tail {left,right,two}
                        Tail to test (left)
  --alpha ALPHA         Significance threshold (0.01)
  --check-co CHECK_CO   Check if features co-occur and warns if phi ≥
                        threshold. Requires scipy. (-1=off)
  --seed SEED           Random seed for permutation tests (42)
```

## truvari_vcf2df

### Tool Description
Takes a vcf and creates a data frame. Can parse a bench output directory

### Metadata
- **Docker Image**: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/ACEnglish/truvari
- **Package**: https://anaconda.org/channels/bioconda/packages/truvari/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vcf2df [-h] [-b] [-i] [-f] [-s SAMPLE] [-n] [-S] [-c LVL] [-a] [-p]
              [--debug]
              VCF JL

Takes a vcf and creates a data frame. Can parse a bench output directory

positional arguments:
  VCF                   VCF to parse
  JL                    Output joblib to save

options:
  -h, --help            show this help message and exit
  -b, --bench-dir       Input is a truvari bench directory
  -i, --info            Attempt to put the INFO fields into the dataframe
  -f, --format          Attempt to put the FORMAT fileds into the dataframe
  -s SAMPLE, --sample SAMPLE
                        SAMPLE name to parse when building columns for
                        --format
  -n, --no-prefix       Don't prepend sample name to format columns
  -S, --skip-compression
                        Skip the attempt to optimize the dataframe's size
  -c LVL, --compress LVL
                        Compression level for joblib 0-9 (3)
  -a, --alleles         Add REF/ALT alleles into the dataframe
  -p, --parquet         Write a parquet file instead of joblib dump
  --debug               Verbose logging
```

