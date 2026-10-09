# hmftools-bwa-plus CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hmftools-bwa-plus_index | PASS |  |
| hmftools-bwa-plus_mem | PASS | 197 of 200 SARS-CoV-2 read positions agree with the bwa mem alignment from nf-core test data |

## hmftools-bwa-plus_index

### Tool Description
Create the bwa-plus index of a reference FASTA.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmftools-bwa-plus:1.0.0--h077b44d_0
- **Homepage**: https://github.com/hartwigmedical/bwa-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/hmftools-bwa-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Looking to launch executable "/usr/local/bin/bwa-plus.avx2", simd = .avx2
Launching executable "/usr/local/bin/bwa-plus.avx2"
Usage: bwa-plus index [-p prefix] <in.fasta>
Total time taken: 0.0000
```

## hmftools-bwa-plus_mem

### Tool Description
Align reads to a reference with bwa-plus.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmftools-bwa-plus:1.0.0--h077b44d_0
- **Homepage**: https://github.com/hartwigmedical/bwa-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/hmftools-bwa-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Looking to launch executable "/usr/local/bin/bwa-plus.avx2", simd = .avx2
Launching executable "/usr/local/bin/bwa-plus.avx2"
-----------------------------
Executing in AVX2 mode!!
-----------------------------
* SA compression enabled with xfactor: 8
Usage: bwa-plus mem [options] <idxbase> <in1.fq> [in2.fq]
Options:
  Algorithm options:
    -o STR        Output SAM file name
    -t INT        number of threads [1]
    -k INT        minimum seed length [19]
    -w INT        band width for banded alignment [100]
    -d INT        off-diagonal X-dropoff [100]
    -r FLOAT      look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]
    -y INT        seed occurrence for the 3rd round seeding [20]
    -c INT        skip seeds with more than INT occurrences [500]
    -D FLOAT      drop chains shorter than FLOAT fraction of the longest overlapping chain [0.50]
    -W INT        discard a chain if seeded bases shorter than INT [0]
    -m INT        perform at most INT rounds of mate rescues for each read [50]
    -S            skip mate rescue
    -o            output file name missing
    -P            skip pairing; mate rescue performed unless -S also in use
Scoring options:
   -A INT        score for a sequence match, which scales options -TdBOELU unless overridden [1]
   -B INT        penalty for a mismatch [4]
   -O INT[,INT]  gap open penalties for deletions and insertions [6,6]
   -E INT[,INT]  gap extension penalty; a gap of size k cost '{-O} + {-E}*k' [1,1]
   -L INT[,INT]  penalty for 5'- and 3'-end clipping [5,5]
   -U INT        penalty for an unpaired read pair [17]
Input/output options:
   -p            smart pairing (ignoring in2.fq)
   -R STR        read group header line such as '@RG\tID:foo\tSM:bar' [null]
   -H STR/FILE   insert STR to header if it starts with @; or insert lines in FILE [null]
   -j            treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt file)
   -5            for split alignment, take the alignment with the smallest coordinate as primary
   -q            don't modify mapQ of supplementary alignments
   -K INT        process INT input bases in each batch regardless of nThreads (for reproducibility) []
   -v INT        verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]
   -T INT        minimum score to output [30]
   -h INT[,INT]  if there are <INT hits with score >80% of the max score, output all in XA [5,200]
   -a            output all alignments for SE or unpaired PE
   -C            append FASTA/FASTQ comment to SAM output
   -V            output the reference FASTA header in the XR tag
   -Y            use soft clipping for supplementary alignments
   -M            mark shorter split hits as secondary
   -I FLOAT[,FLOAT[,INT[,INT]]]
                 specify the mean, standard deviation (10% of the mean if absent), max
                 (4 sigma from the mean if absent) and min of the insert size distribution.
                 FR orientation only. [inferred]
Note: Please read the man page for detailed description of the command line and options.
```
