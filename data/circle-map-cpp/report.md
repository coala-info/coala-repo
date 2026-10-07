# circle-map-cpp CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| circle-map-cpp_ReadExtractor | PASS |  |
| circle-map-cpp_Realign | Failed | image problem: the megadepth program that Realign calls (/usr/local/bin/thirdparty/megadepth) is not in the image, so no circles are written. |

## circle-map-cpp_ReadExtractor

### Tool Description
Extracts circular DNA read candidates

### Metadata
- **Docker Image**: quay.io/biocontainers/circle-map-cpp:1.0.0--h5ca1c30_0
- **Homepage**: https://github.com/BGI-Qingdao/Circle-Map-cpp
- **Package**: https://anaconda.org/channels/bioconda/packages/circle-map-cpp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circle-map-cpp/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-11-26
- **GitHub**: https://github.com/BGI-Qingdao/Circle-Map-cpp
- **Stars**: N/A
### Original Help Text
```text
usage: circle_map++ ReadExtractor [options]

Extracts circular DNA read candidates

required arguments:
  -i                    Input: query name sorted bam file

optional arguments:
  -o, --output          Ouput: Reads indicating circular DNA structural
                        variants
  -t, --threads         Number of threads to use.Default 1
  -dir, --directory     Working directory, default is the working directory
  -q, --quality         bwa-mem mapping quality cutoff. Default value 10
  -nd, --nodiscordant   Turn off discordant (R2F1 oriented) read extraction
  -nsc, --nosoftclipped
                        Turn off soft-clipped read extraction
  -nhc, --nohardclipped
                        Turn off hard-clipped read extraction
  -v, --verbose         Verbose level, 1=error,2=warning, 3=message
```

## circle-map-cpp_Realign

### Tool Description
Realign circular DNA read candidates

### Metadata
- **Docker Image**: quay.io/biocontainers/circle-map-cpp:1.0.0--h5ca1c30_0
- **Homepage**: https://github.com/BGI-Qingdao/Circle-Map-cpp
- **Package**: https://anaconda.org/channels/bioconda/packages/circle-map-cpp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circle-map-cpp/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-11-26
- **GitHub**: https://github.com/BGI-Qingdao/Circle-Map-cpp
- **Stars**: N/A
### Original Help Text
```text
usage: circle_map++ Realign [options]

Realign circular DNA read candidates

Input/Output options:
  -i                    Input: bam file containing the reads extracted by
                        ReadExtractor
  -qbam                 Input: query name sorted bam file
  -sbam                 Input: coordinate sorted bam file
  -fasta                Input: Reference genome fasta file
  -o, --output          Output filename

Running options:
  -t, --threads         Number of threads to use.Default 1
  -dir, --directory     Working directory, default will create a tmp_${pid}
                        folder in the working directory and automaticlly
                        delete it when exit..
  -N, --no_coverage     Don't compute coverage statistics

Candidate intervals:
  -K, --clustering_dist 
                        Cluster reads that are K nucleotides appart in the
                        same node. Default: 500

Insert size estimation options:
  -ss, --sample_size    Number of concordant reads (R2F1) to use for
                        estimating the insert size distribution. Default
                        100000
  -iq, --insert_mapq    Mapq cutoff for stimating the insert size
                        distribution. Default 60

Interval processing options:
  -m, --mean_is_size    mean value of insert size
  -di, --sd_val_insert 
                        SD Value of insert size
  -S, --std_factor      std_factor,extern realign interval by
                        mIS+sIS*std_factor.(default 4)
  -q, --mapping_qual    minimum mapping quality(default 20)
  -p, --min_interval_prob 
                        minimum interval probability(default 0.01)
  -e, --edit_dist_fraction 
                        edit distance fraction(default 0.05)
  -l, --min_softclip_len 
                        minimum softclip length(default 8)
  -rn, --max_aln_num    nhit, maximum alignment number(default 10)
  -G, --penity_gap_open 
                        penity for gap open(default 5)
  -E, --penity_gap_extern 
                        penity for gap extern(default 1)
  -P, --aln_prob        alignment probability(default 0.99)

Merge result options:
  -f, --merge_fraction 
                        Merge intervals reciprocally overlapping by a
                        fraction. Default 0.99
  -af, --allele_frequency 
                        Minimum allele frequency required to report the circle
                        interval. Default (0.1)
  -O, --number_of_discordants 
                        Number of required discordant reads for intervals with
                        only discordants. Default: 3
  -T, --split           Number of required split reads to output a eccDNA.
                        Default: 0
  -Q, --split_quality   Minium split score to output an interval. Default
                        (0.0)
  -bs, --bases          Number of bases to extend for computing the coverage
                        ratio. Default: 200
  -ce, --extension      Number of bases inside the eccDNA breakpoint
                        coordinates to compute the ratio. Default: 100
  -r, --ratio           Minimum in/out required coverage ratio. Default: 0.0
```
