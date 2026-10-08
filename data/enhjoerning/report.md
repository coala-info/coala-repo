# enhjoerning CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| enhjoerning_unicorn_alnfilt | PASS |  |
| enhjoerning_unicorn_bamstats | Failed | tool bug: the --outstat option writes no file; the statistics only go to the standard output |
| enhjoerning_unicorn_reassign | PASS |  |
| enhjoerning_unicorn_refstats | PASS |  |
| enhjoerning_unicorn_taxstats | PASS |  |

## enhjoerning_unicorn_alnfilt

### Tool Description
Filter alignments based on user-defined criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
- **Homepage**: https://github.com/GeoGenetics/unicorn
- **Package**: https://anaconda.org/channels/bioconda/packages/enhjoerning/overview
- **Validation**: PASS

### Original Help Text
```text
unicorn 2.4.0 
	Nov 28 2025 12:23:42
./unicorn alnfilt [options] -b <in.bam>|<in.sam>
Options:
  -b <str>                     Input bam|sam
  -o <str> | --outbam  <str>   Output BAM file [stdout]
  --mode <str>                 Filter mode [alltop]
                               Available modes:
                                RNDTOP  - Randomly select a best alignment
                                ALLTOP  - Select all best alignments
                                PCTTOP  - Select alignments within --pct
                                           percentage of best alignment.
                                ALL     - Select all alignments.
  --pct <float>                Percentage threshold for PCTTOP mode [0.90]
  --minani <float>             Minimum average nucleotide identity [90.0]
  --maxani <float>             Maximum average nucleotide identity [100.0]
  --strictbounds               Remove query if ANI out of bounds at any alignment.
  --verbose                    Prints libunicorn's messages.
  -h                           Print this help message.
[unicorn::unicorn_alnfilt] Total time: 0.000024 seconds
```

## enhjoerning_unicorn_bamstats

### Tool Description
Compute per bam statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
- **Homepage**: https://github.com/GeoGenetics/unicorn
- **Package**: https://anaconda.org/channels/bioconda/packages/enhjoerning/overview
- **Validation**: PASS

### Original Help Text
```text
./unicorn bamstats [options] -b <in.bam>|<in.sam>
Options:
  -b <str>         Input bam|sam
  --outstat <str>  Output statistics file
  --filelist <str> File containing input file paths. One per line.
  --printdists     Print distributions of read lengths, alignment lengths, etc.
                   This will create a files <inputname>.dists.txt
unicorn 2.4.0 
	Nov 28 2025 12:23:42
```

## enhjoerning_unicorn_reassign

### Tool Description
Filter alignments via EM algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
- **Homepage**: https://github.com/GeoGenetics/unicorn
- **Package**: https://anaconda.org/channels/bioconda/packages/enhjoerning/overview
- **Validation**: PASS

### Original Help Text
```text
./unicorn reassign [options] -b <in.bam>|<in.sam>
Options:
  -b <str>                     Input bam|sam
  -o <str> | --outbam  <str>   Output BAM file [stdout]
  -t <int> | --threads <int>   Number of threads to use [4]
  --alpha <float>              Score retention scaling factor (0.0, 1.0] [0.80]
  --niter <int>                Max number of EM algorithm iterations [5]
  --scale-type <str>           Scaling type subject weights [LENGTH]
                               Available types:
                                NONE    - No subject weight scaling
                                LENGTH  - Scale by subject length
                                SQRTLEN - Scale by square root of subject length
  --verbose                    Prints libunicorn's messages.
  -h                           Print this help message
unicorn 2.4.0 
	Nov 28 2025 12:23:42
```

## enhjoerning_unicorn_refstats

### Tool Description
Compute per reference statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
- **Homepage**: https://github.com/GeoGenetics/unicorn
- **Package**: https://anaconda.org/channels/bioconda/packages/enhjoerning/overview
- **Validation**: PASS

### Original Help Text
```text
unicorn 2.4.0 
	Nov 28 2025 12:23:42
[unicorn::unicorn_refstats] Error: File error
./unicorn refstats [options] -b <in.bam>|<in.sam>
Options:
  -b <str>   Input bam|sam [Required]
  -t <int>, --threads <int> Number of threads [4]
  -o <str> | --outbam  <str> Output BAM file with filtered alignments.
  --outstat <str> Output statistics file
  --[FILTER] <PARAM>  Apply filter "FILTER" with parameter "PARAM"
      For example "--minreads 100" to filter out references with
      less than 100 reads.
      Available filters:
       - minrefl  <int>  Minimum reference length to consider [0]
       - minreads <int>  Minimum number of reads to consider  [1]
       - minalnas <int>  Minimum alignment score [-Inf]
       - maxdust  <int>  Maximum alignment dust score [100]
  --withtid  Report taxid of reference sequence. Requires --acc2tax, --names and --nodes options.
  --names   <str> Taxonomy nodeid to name mapping file.
  --nodes   <str> Taxonomy nodeid to parent nodeid mapping file.
  --acc2tax <str> Accession to taxid mapping file or .khash file.
  --verbose  Print libunicorn's messages.
  -h         print this help message
```

## enhjoerning_unicorn_taxstats

### Tool Description
Compute per taxid statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
- **Homepage**: https://github.com/GeoGenetics/unicorn
- **Package**: https://anaconda.org/channels/bioconda/packages/enhjoerning/overview
- **Validation**: PASS

### Original Help Text
```text
unicorn 2.4.0 
	Nov 28 2025 12:23:42
[unicorn::unicorn_taxstats] Error: File error
./unicorn taxstats [options] -b <in.bam>|<in.sam>
Options:
  -b <str>                     Input bam|sam
  -o <str> | --outbam <str>    Output BAM file with filtered alignments.
                               <str> is used as a prefix when --filelist is provided.
  -a <str> | --acc2tax <str>   Accession to taxid mapping file or .khash file.
                               Providing a .khash file is much faster.
  -n <str> | --names <str>     Taxonomy names file.
  -d <str> | --nodes <str>     Taxonomy nodes file
  --outstat <str>              Output statistics file [/dev/stdout]
                               <str> is used as a prefix when --filelist is provided.
  --[FILTER] <PARAM>  Apply filter "FILTER" with parameter "PARAM"
      For example "--minreads 100" to filter out taxids with
      less than 100 reads.
      Available filters:
       - minrefl  <int>   Minimum reference length. [0]
       - minreads <int>   Minimum number of reads per taxid. [1]
       - minmani  <float> Minimum mean ANI per taxid. [0]
       - minalnas <int>   Minimum alignment score [-Inf]
       - maxdust  <int>   Maximum alignment dust score [100]
  --filelist <str>             File containing input file paths. One per line.
  --rank <str>                 Taxonomic rank to summarize by. [species]
  --verbose                    Prints libunicorn's messages.
  -h                           Print this help message
[unicorn::unicorn_taxstats] Total time: 0.000035 seconds
```

