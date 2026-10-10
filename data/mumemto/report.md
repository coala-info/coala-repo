# mumemto CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mumemto | PASS |  |
| mumemto_bed | Failed | tool bug: the last collinear block is never written, and a MUMs file without blocks gives empty output unless --verbose is set |
| mumemto_collinear | PASS |  |
| mumemto_convert | PASS |  |
| mumemto_coverage | PASS |  |
| mumemto_extract | Not completed | the lengths file stores absolute FASTA paths that do not exist inside a CWL run; works only when the FASTA files sit at those paths |
| mumemto_inversion | PASS | synthetic data: a planted 3 kb inversion in the chimp genome is found with a small max_block_gap_len; the real mitochondrial genomes have none |
| mumemto_label | PASS |  |
| mumemto_lengths | PASS |  |
| mumemto_merge | PASS |  |
| mumemto_viz | PASS |  |

## mumemto

### Tool Description
find maximal [unique | exact] matches using PFP.

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Total Downloads**: 15.8K
- **Last updated**: 2025-10-29
- **GitHub**: https://github.com/vikshiv/mumemto
- **Stars**: N/A
### Original Help Text
```text
[1m[31m
mumemto version: 1.3.4[m[0m

mumemto - find maximal [unique | exact] matches using PFP.
Usage: mumemto [options] [input_fasta [...]]

*** for all options, N = # of sequences ***
I/O options:
	-h, --help                      prints this usage message
	-i, --input           [FILE]    path to a file-list of genomes to use (overrides positional args)
	-o, --output          [PREFIX]  output prefix path
	-r, --no-revcomp                include the reverse complement of the sequences (default: true)

	-b, --binary                    output binary format (multi-MUMs only)

	-A, --arrays-out                write LCP, BWT, and SA to file
	-a, --arrays-in       [PREFIX]  compute matches from precomputed LCP, BWT, SA (with shared PREFIX.bwt/sa/lcp)

	-M, --merge                     output extra metadata to enable merging multi-MUMs
	-n, --anchor                    Use anchor-based merging (requires -M, uses first sequence as anchor)
Exact match parameters:
	-l, --min-match-len   [INT]     minimum MUM or MEM length (default: 20)

	-k, --minimum-genomes [INT]     find matches in at least k sequences (k < 0 sets the sequences relative to N, i.e. matches must occur in at least N - |k| sequences)
	                                (default: match occurs in all sequences, i.e. strict multi-MUM/MEM)

	-f, --per-seq-freq    [INT]     maximum number of occurences per sequence (set to 0 for no upper limit)
	                                (default: 1 [unique])

	-F, --max-total-freq  [INT]     maximum number of total occurences of match (if negative, then relative to N) 
	                                (default: no upper limit)

PFP options:
	-w, --window          [INT]     window size used for pfp (default: 10)
	-m, --modulus         [INT]     hash-modulus used for pfp (default: 100)
	-p, --from-parse                use pre-computed pf-parse (with shared PREFIX.parse and PREFIX.dict)
	-K, --keep-temp-files           keep PFP files
	-g, --use-gsacak                skip PFP and use gsacak directly to compute LCP, BWT, SA
	-P, --only-parse                only compute PFP over the input files and do not compute matches

Overview:
	By default, Mumemto computes multi-MUMs. Exact match parameters can be additionally tuned in three main ways:
	1) Choosing the number of sequences a match must appear in [-k]
	2) Choosing the maximum number of occurences in each genome [-f]
	3) Choosing the total maximum number of occurences [-F]
Examples:
	 - Find all strict multi-MUMs across a collection: mumemto [OPTIONS] [input_fasta [...]] (equivalently -k 0 -f 1 -F 0)
	 - Find partial multi-MUMs in all sequences but one: mumemto -k -1 [OPTIONS] [input_fasta [...]]
	 - Find multi-MEMs that appear at most 3 times in each sequence: mumemto -f 3 [OPTIONS] [input_fasta [...]]
	 - Find all MEMs that appear at most 100 times within a collection: mumemto -f 0 -k 2 -F 100 [OPTIONS] [input_fasta [...]]
```

## mumemto_bed

### Tool Description
Convert MUMs file to BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mumemto [-h] [--lengths-file LENGTHS_FILE] [-v]
               [--min-singleton-length MIN_SINGLETON_LENGTH]
               [--seq-idx SEQ_IDX] [--output OUTPUT]
               mums_file

Convert MUMs file to BED file

positional arguments:
  mums_file             Path to the MUMs file

options:
  -h, --help            show this help message and exit
  --lengths-file LENGTHS_FILE, -l LENGTHS_FILE
                        Path to the lengths file (optional)
  -v, --verbose         Enable verbose output with progress bars
  --min-singleton-length MIN_SINGLETON_LENGTH, -L MIN_SINGLETON_LENGTH
                        Minimum length of singleton blocks to include
  --seq-idx SEQ_IDX, -s SEQ_IDX
                        Sequence to output BED coordinates (default: first
                        sequence)
  --output OUTPUT, -o OUTPUT
                        Path to the output file (default: stdout)
```

## mumemto_coverage

### Tool Description
Aggregates MUM coverage from mumemto output

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mumemto [-h] (--input-prefix PREFIX | --mums MUMFILE) [--lengths LENS]
               [--len-filter LENFILTER] [--seq-idx SEQ_IDX] [--verbose]

Aggregates MUM coverage from mumemto output.

options:
  -h, --help            show this help message and exit
  --input-prefix PREFIX, -i PREFIX
                        prefix for filelist, mums, and lengths files
  --mums MUMFILE, -m MUMFILE
                        path to *.mum file from mumemto
  --lengths LENS, -l LENS
                        lengths file, first column is seq length in order of
                        filelist
  --len-filter LENFILTER, -L LENFILTER
                        only consider MUMs longer than threshold
  --seq-idx SEQ_IDX, -s SEQ_IDX
                        sequence index to compute coverage for
  --verbose, -v         verbose mode
```

## mumemto_extract

### Tool Description
Extract MUMs from a MUM and length file

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

### Original Help Text
```text
extract_mums - extract MUMs from a MUM and length file
Usage: extract_mums [options] -m mum_file -o output_file

Options:
	-h, --help                      prints this usage message
	-m, --mums            [FILE]    path to a mum file
	-l, --lengths         [FILE]    path to a length file (optional, uses associated length file if not provided)
	-o, --output          [FILE]    output path
	-t, --no-terminator             do not add terminator (#) to end of each MUM sequence
```

## mumemto_collinear

### Tool Description
Computes collinear blocks of MUMs

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mumemto [-h] (--input-prefix PREFIX | --mums MUMFILE) [--fout FILENAME]
               [--max-gap-len MAX_BREAK] [--verbose]
               [--min-singleton-length MIN_SINGLETON_LENGTH]

Computes collinear blocks of MUMs

options:
  -h, --help            show this help message and exit
  --input-prefix PREFIX, -i PREFIX
                        prefix for filelist, mums, and lengths files
  --mums MUMFILE, -m MUMFILE
                        path to *.mum file from mumemto
  --fout FILENAME, -o FILENAME
                        plot fname (default: input_prefix + _sorted)
  --max-gap-len MAX_BREAK, -g MAX_BREAK
                        maximum break between collinear mums within a
                        collinear block (default: 1kbp)
  --verbose, -v         verbose mode
  --min-singleton-length MIN_SINGLETON_LENGTH
                        Minimum length of singleton blocks to include
                        (default: no singletons)
```

## mumemto_viz

### Tool Description
Plots a synteny plot of MUMs from mumemto

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mumemto [-h] (--input-prefix PREFIX | --mums MUMFILE) [--lengths LENS]
               [--filelist FILELIST] [--labels LABELS]
               [--len-filter LENFILTER] [--subsample SUBSAMPLE] [--center]
               [--inversion-color INV_COLOR] [--mum-color MUM_COLOR]
               [--alpha ALPHA] [--linewidth LINEWIDTH] [--fout FILENAME]
               [--dims SIZE SIZE] [--region REGION REGION] [--dpi DPI]
               [--verbose] [--no-coll-block] [--max-gap-len MAX_BREAK]
               [--mode {normal,delineated,gapped}] [--spacer SPACER]

Plots a synteny plot of MUMs from mumemto

options:
  -h, --help            show this help message and exit
  --input-prefix PREFIX, -i PREFIX
                        prefix for filelist, mums, and lengths files (uses
                        *.mums file over *.bumbl file if both exist)
  --mums MUMFILE, -m MUMFILE
                        path to *.mums (or *.bumbl) file from mumemto
  --lengths LENS, -l LENS
                        lengths file, first column is seq length in order of
                        filelist
  --filelist FILELIST, -f FILELIST
                        filelist defines the order of seqs in the plot. First
                        col = full path from lengths file
  --labels LABELS, -n LABELS
                        labels for each sequence in the plot, one a line,
                        matching the order of the filelist (if given) or the
                        lengths file
  --len-filter LENFILTER, -L LENFILTER
                        only plot MUMs longer than threshold
  --subsample SUBSAMPLE, -s SUBSAMPLE
                        subsample every Nth mum
  --center, -c          center plot
  --inversion-color INV_COLOR, -ic INV_COLOR
                        color for inversions
  --mum-color MUM_COLOR, -mc MUM_COLOR
                        color as hex (default: #00A2FF)
  --alpha ALPHA, -a ALPHA
                        opacity of mums [0-1] (default: 0.8 for blocks, 0.1
                        for MUMs)
  --linewidth LINEWIDTH, -lw LINEWIDTH
                        linewidth of mums (default: 0 for blocks, 0.05 for
                        MUMs)
  --fout FILENAME, -o FILENAME
                        plot fname (default: input_prefix)
  --dims SIZE SIZE      fig dimensions (inches) (default: 6.4, 4.8)
  --region REGION REGION
                        genomic region to zoom in, global coordinates
                        (assuming contigs are concatenated)
  --dpi DPI, -d DPI     dpi
  --verbose, -v         verbose mode
  --no-coll-block, -b   plot only MUMs, not collinear blocks (slower)
                        (default: false)
  --max-gap-len MAX_BREAK, -g MAX_BREAK
                        maximum break between collinear mums within a
                        collinear block (default: <1px)
  --mode {normal,delineated,gapped}
                        Plotting mode for multi-fasta inputs (default: normal)
  --spacer SPACER       spacer between contigs, expressed as proportion (0 -
                        1) of largest contig length (default: 0.1)
```

## mumemto_lengths

### Tool Description
Compute lengths of sequences in FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

### Original Help Text
```text
compute_lengths - compute lengths of sequences in FASTA files
Usage: compute_lengths [options] [input_fastas [...]]

Options:
	-h, --help                      prints this usage message
	-i, --input           [FILE]    path to a file-list of genomes to use (overrides positional args)
	-o, --output          [PREFIX]  output prefix path
	-p, --print-fasta               write concatenated FASTA files (fwd$rc$)
```

## mumemto_label

### Tool Description
Extract the MUM sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mumemto [-h] -m MUMFILE [-o OUTPUT] [-l LENGTHS] [-v] [-n]

Extract the MUM sequences

options:
  -h, --help            show this help message and exit
  -m MUMFILE, --mumfile MUMFILE
                        bumbl file to process
  -o OUTPUT, --output OUTPUT
                        Path to the output file
  -l LENGTHS, --lengths LENGTHS
                        Path to alternate lengths file
  -v, --verbose         Print verbose output
  -n, --contig-names    Print contig names/sequence IDs instead of numerical
                        indexes
```

## mumemto_inversion

### Tool Description
Detect inversions from MUMs

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mumemto [-h] (--input-prefix PREFIX | --mums MUMFILE)
               [--agp-filelist AGP_FILELIST] [--filelist FILELIST] [--chr CHR]
               [--margin MARGIN] [--max-length MAX_LENGTH]
               [--max-block-gap-len MAX_BLOCK_GAP] [--verbose]

Detect inversions from MUMs. Optionally checks if inversions are flanked by
scaffold breaks when AGP files are provided.

options:
  -h, --help            show this help message and exit
  --input-prefix PREFIX, -i PREFIX
                        prefix for filelist, mums, and lengths files
  --mums MUMFILE, -m MUMFILE
                        path to *.mum file from mumemto
  --agp-filelist AGP_FILELIST, -a AGP_FILELIST
                        Path to filelist containing AGP files. Each line
                        should contain the path to an AGP file, in the same
                        order as sequences in the mumemto filelist/lengths
                        file. Assume first sequence is reference.
  --filelist FILELIST, -f FILELIST
                        Path to filelist for sequence names (default lengths
                        file)
  --chr CHR, -c CHR     Chromosome number (required if using --agp-filelist)
  --margin MARGIN, -d MARGIN
                        Proximity margin for scaffold break detection
                        (default: within 1% of inversion length)
  --max-length MAX_LENGTH, -L MAX_LENGTH
                        Maximum inversion length to detect
  --max-block-gap-len MAX_BLOCK_GAP, -g MAX_BLOCK_GAP
                        maximum break between collinear mums within a
                        collinear block (default: 1000)
  --verbose, -v         Print progress updates
```

## mumemto_convert

### Tool Description
Converts Mumemto mum and bumbl formats

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mumemto [-h] [--mums MUMFILE] [--bumbl BUMFILE] [--length-upsize]
               [--fout OUT] [--verbose] [--chunk-size CHUNK_SIZE]

Converts Mumemto mum and bumbl formats

options:
  -h, --help            show this help message and exit
  --mums MUMFILE, -m MUMFILE
                        path to *.mum file from mumemto
  --bumbl BUMFILE, -b BUMFILE
                        path to *.bumbl file from mumemto
  --length-upsize, -l   convert bumbl with 16 bit length to 32 bit (v1.3.1
                        onwards)
  --fout OUT, -o OUT    output fname
  --verbose, -v         verbose mode
  --chunk-size CHUNK_SIZE, -c CHUNK_SIZE
                        chunk size for writing output MUM file
```

## mumemto_merge

### Tool Description
Merge MUMs files

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mumemto [-h] [--merged_mums MERGED_MUMS] [--output OUTPUT] [--verbose]
               MUM_FILES [MUM_FILES ...]

Merge MUMs files

positional arguments:
  MUM_FILES             Paths to MUMs files to merge

options:
  -h, --help            show this help message and exit
  --merged_mums MERGED_MUMS, -m MERGED_MUMS
                        Path to MUMs of MUMs file (only for string merging)
  --output OUTPUT, -o OUTPUT
                        Path to output merged MUMs file
  --verbose, -v         Print verbose output
```

