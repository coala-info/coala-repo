# dnaclust CWL Generation Report

## dnaclust

### Tool Description
The output is written to STDOUT. Each line will contain the ids of the sequences in each cluster, and the first id of each line is the cluster representative.

### Metadata
- **Docker Image**: biocontainers/dnaclust:v3-4b2-deb_cv1
- **Homepage**: https://github.com/jenhantao/DNACluster
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dnaclust/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/jenhantao/DNACluster
- **Stars**: N/A
### Original Help Text
```text
Usage: dnaclust [OPTIONS] FastaFile
  The output is written to STDOUT. Each line will contain the ids of the sequences in each cluster, and the first id of each line is the cluster representative.
  Example: To cluster a set of 16S rRNA fragments at 0.98 similarity use:
  ./dnaclust file.fasta -l -s 0.98 > clusters 
  You can optionally specify a k-mer length for the filter. The longer k-mers use more memory.  Also the filter will be more specific with longer k-mers. The default log_4(median length) should be good for most cases.
Options:
  -h [ --help ]                         produce help message
  -s [ --similarity ] arg (=0.99000001) set similarity between cluster center 
                                        and cluster sequences
  -i [ --input-file ] arg               input file
  -p [ --predetermined-cluster-centers ] arg
                                        file containing predetermined cluster 
                                        centers
  -r [ --recruit-only ]                 when used with 'predetermined-cluster-c
                                        enters' option, only clusters the input
                                        sequences that are similar to the 
                                        predetermined centers
  -d [ --header ]                       output header line indicating run 
                                        options
  -l [ --left-gaps-allowed ]            allow for gaps on the left of shorter 
                                        string in semi-global alignment
  -k [ --k-mer-length ] arg             length of k-mer for filtering
  --approximate-filter                  use faster approximate k-mer filter
  --k-mer-filter                        use k-mer filter
  --no-k-mer-filter                     do not use k-mer filter
  --no-overlap                          cluster some of sequences such that the
                                        cluster centers are at distance at 
                                        least two times the radius of the 
                                        clusters
  -t [ --threads ] arg                  number of threads
  -u [ --use-full-query-header ]        use the full query header instead of 
                                        the first word
  -m [ --mismatches ] arg (=-1)         number of mismatches allowed from 
                                        cluster center
  -a [ --assign-ambiguous ]             assign ambiguous reads to clusters 
                                        based on abundances of non-ambiguous 
                                        reads
  -e [ --random-seed ] arg              Seed for random number generator
  --print-inverted-index                Print mapping from sequence to each 
                                        center
```


## Metadata
- **Skill**: generated
