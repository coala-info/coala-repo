# delly CWL Generation Report

## delly_call

### Tool Description
Compute structural variants

### Metadata
- **Docker Image**: quay.io/biocontainers/delly:1.7.2--h4d20210_0
- **Homepage**: https://github.com/dellytools/delly
- **Package**: https://anaconda.org/channels/bioconda/packages/delly/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/delly/overview
- **Total Downloads**: 144.7K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dellytools/delly
- **Stars**: N/A
### Original Help Text
```text
Usage: delly call [OPTIONS] -g <ref.fa> <sample1.sort.bam> <sample2.sort.bam> ...

Generic options:
  -? [ --help ]                       show help message
  -t [ --svtype ] arg (=ALL)          SV type to compute [DEL, INS, DUP, INV, 
                                      BND, ALL]
  -g [ --genome ] arg                 genome fasta file
  -x [ --exclude ] arg                file with regions to exclude
  -o [ --outfile ] arg                BCF output file
  -h [ --threads ] arg (=4)           number of threads

Discovery options:
  -q [ --map-qual ] arg (=1)          min. paired-end (PE) mapping quality
  -r [ --qual-tra ] arg (=20)         min. PE quality for translocation
  -s [ --mad-cutoff ] arg (=9)        insert size cutoff, median+s*MAD 
                                      (deletions only)
  -c [ --minclip ] arg (=25)          min. clipping length
  -z [ --min-clique-size ] arg (=2)   min. PE/SR clique size
  -m [ --minrefsep ] arg (=25)        min. reference separation
  -n [ --maxreadsep ] arg (=40)       max. read separation
  -p [ --max-reads ] arg (=20)        max. reads for consensus computation

Genotyping options:
  -v [ --vcffile ] arg                input VCF/BCF file for genotyping
  -u [ --geno-qual ] arg (=5)         min. mapping quality for genotyping
  -d [ --dump ] arg                   gzipped output file for SV-reads 
                                      (optional)
  -a [ --max-geno-count ] arg (=250)  max. number of reads aligned for SR 
                                      genotyping
```


## delly_merge

### Tool Description
Merge SV BCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/delly:1.7.2--h4d20210_0
- **Homepage**: https://github.com/dellytools/delly
- **Package**: https://anaconda.org/channels/bioconda/packages/delly/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: delly merge [OPTIONS] [<sample1.bcf> <sample2.bcf> ... | <list_of_bcf_files.txt>]

Generic options:
  -? [ --help ]                         show help message
  -o [ --outfile ] arg                  Merged SV BCF output file
  -y [ --quality ] arg (=200)           min. SV site quality
  -u [ --chunks ] arg (=500)            max. chunk size to merge groups of BCF 
                                        files
  -a [ --vaf ] arg (=0.150000006)       min. fractional ALT support
  -v [ --coverage ] arg (=5)            min. coverage
  -m [ --minsize ] arg (=0)             min. SV size
  -n [ --maxsize ] arg (=1000000)       max. SV size
  -e [ --cnvmode ]                      Merge delly CNV files
  -c [ --precise ]                      Filter sites for PRECISE
  -p [ --pass ]                         Filter sites for PASS

Overlap options:
  -b [ --bp-offset ] arg (=1000)        max. breakpoint offset
  -r [ --rec-overlap ] arg (=0.800000012)
                                        min. reciprocal overlap
```


## delly_filter

### Tool Description
Filter SV calls in a BCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/delly:1.7.2--h4d20210_0
- **Homepage**: https://github.com/dellytools/delly
- **Package**: https://anaconda.org/channels/bioconda/packages/delly/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: delly filter [OPTIONS] <input.bcf>

Generic options:
  -? [ --help ]                         show help message
  -f [ --filter ] arg (=somatic)        Filter mode (somatic, germline)
  -o [ --outfile ] arg                  Filtered SV BCF output file
  -y [ --quality ] arg (=300)           min. SV site quality
  -a [ --altaf ] arg (=0.0299999993)    min. fractional ALT support
  -m [ --minsize ] arg (=0)             min. SV size
  -n [ --maxsize ] arg (=500000000)     max. SV size
  -r [ --ratiogeno ] arg (=0.75)        min. fraction of genotyped samples
  -p [ --pass ]                         Filter sites for PASS
  -t [ --tag ]                          Tag filtered sites in the FILTER column
                                        instead of removing them

Somatic options:
  -s [ --samples ] arg                  Two-column sample file listing sample 
                                        name and tumor or control
  -v [ --coverage ] arg (=10)           min. coverage in tumor
  -c [ --controlcontamination ] arg (=0)
                                        max. fractional ALT support in control

Germline options:
  -q [ --gq ] arg (=15)                 min. median GQ for carriers and 
                                        non-carriers
  -e [ --rddel ] arg (=0.800000012)     max. read-depth ratio of carrier vs. 
                                        non-carrier for a deletion
  -u [ --rddup ] arg (=1.20000005)      min. read-depth ratio of carrier vs. 
                                        non-carrier for a duplication
```

