# metabat2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metabat2 | PASS |  |
| metabat2_contigOverlaps | PASS | ran on two Galaxy test BAM sets; the lists are from unrelated references, so only the table format was checked |
| metabat2_jgi_summarize_bam_contig_depths | PASS |  |
| metabat2_metabat1 | PASS |  |

## metabat2

### Tool Description
MetaBAT: Metagenome Binning based on Abundance and Tetranucleotide frequency.

#

## metabat2_metabat1

### Tool Description
MetaBAT 1: metagenome binning (legacy version).

### Metadata
- **Docker Image**: quay.io/biocontainers/metabat2:2.18--h6f16272_0
- **Homepage**: https://bitbucket.org/berkeleylab/metabat
- **Package**: https://anaconda.org/channels/bioconda/packages/metabat2/overview
- **Validation**: PASS

### Original Help Text
```text
MetaBAT: Metagenome Binning based on Abundance and Tetranucleotide frequency (version 1:2.18; 20250528_211447)
by Don Kang (ddkang@lbl.gov), Jeff Froula, Rob Egan, and Zhong Wang (zhongwang@lbl.gov) 

Allowed options:
  -h [ --help ]                     produce help message
  -i [ --inFile ] arg               Contigs in (gzipped) fasta file format [Mandatory]
  -o [ --outFile ] arg              Base file name for each bin. The default output is fasta format. Use -l 
                                    option to output only contig names [Mandatory]
  -a [ --abdFile ] arg              A file having mean and variance of base coverage depth (tab delimited; 
                                    the first column should be contig names, and the first row will be 
                                    considered as the header and be skipped) [Optional]
  --cvExt                           When a coverage file without variance (from third party tools) is used 
                                    instead of abdFile from jgi_summarize_bam_contig_depths
  -p [ --pairFile ] arg             A file having paired reads mapping information. Use it to increase 
                                    sensitivity. (tab delimited; should have 3 columns of contig index 
                                    (ordered by), its mate contig index, and supporting mean read coverage. 
                                    The first row will be considered as the header and be skipped) [Optional]
  --p1 arg (=0)                     Probability cutoff for bin seeding. It mainly controls the number of 
                                    potential bins and their specificity. The higher, the more (specific) 
                                    bins would be. (Percentage; Should be between 0 and 100)
  --p2 arg (=0)                     Probability cutoff for secondary neighbors. It supports p1 and better be 
                                    close to p1. (Percentage; Should be between 0 and 100)
  --minProb arg (=0)                Minimum probability for binning consideration. It controls sensitivity. 
                                    Usually it should be >= 75. (Percentage; Should be between 0 and 100)
  --minBinned arg (=0)              Minimum proportion of already binned neighbors for one's membership 
                                    inference. It contorls specificity. Usually it would be <= 50 
                                    (Percentage; Should be between 0 and 100)
  --verysensitive                   For greater sensitivity, especially in a simple community. It is the 
                                    shortcut for --p1 90 --p2 85 --pB 20 --minProb 75 --minBinned 20 
                                    --minCorr 90
  --sensitive                       For better sensitivity [default]. It is the shortcut for --p1 90 --p2 90 
                                    --pB 20 --minProb 80 --minBinned 40 --minCorr 92
  --specific                        For better specificity. Different from --sensitive when using correlation
                                    binning or ensemble binning. It is the shortcut for --p1 90 --p2 90 --pB 
                                    30 --minProb 80 --minBinned 40 --minCorr 96
  --veryspecific                    For greater specificity. No correlation binning for short contig 
                                    recruiting. It is the shortcut for --p1 90 --p2 90 --pB 40 --minProb 80 
                                    --minBinned 40
  --superspecific                   For the best specificity. It is the shortcut for --p1 95 --p2 90 --pB 50 
                                    --minProb 80 --minBinned 20
  --minCorr arg (=0)                Minimum pearson correlation coefficient for binning missed contigs to 
                                    increase sensitivity (Helpful when there are many samples). Should be 
                                    very high (>=90) to reduce contamination. (Percentage; Should be between 
                                    0 and 100; 0 disables)
  --minSamples arg (=10)            Minimum number of sample sizes for considering correlation based 
                                    recruiting
  -x [ --minCV ] arg (=1)           Minimum mean coverage of a contig to consider for abundance distance 
                                    calculation in each library
  --minCVSum arg (=2)               Minimum total mean coverage of a contig (sum of all libraries) to 
                                    consider for abundance distance calculation
  -s [ --minClsSize ] arg (=200000) Minimum size of a bin to be considered as the output
  -m [ --minContig ] arg (=2500)    Minimum size of a contig to be considered for binning (should be >=1500; 
                                    ideally >=2500). If # of samples >= minSamples, small contigs (>=1000) 
                                    will be given a chance to be recruited to existing bins by default.
  --minContigByCorr arg (=1000)     Minimum size of a contig to be considered for recruiting by pearson 
                                    correlation coefficients (activated only if # of samples >= minSamples; 
                                    disabled when minContigByCorr > minContig)
  -t [ --numThreads ] arg (=0)      Number of threads to use (0: use all cores)
  --minShared arg (=50)             Percentage cutoff for merging fuzzy contigs
  --fuzzy                           Binning with fuzziness which assigns multiple memberships of a contig to 
                                    bins (activated only with --pairFile at the moment)
  -l [ --onlyLabel ]                Output only sequence labels as a list in a column without sequences
  -S [ --sumLowCV ]                 If set, then every sample that falls below the minCV will be used in an 
                                    aggregate sample
  -V [ --maxVarRatio ] arg (=0)     Ignore any contigs where variance / mean exceeds this ratio (0 disables)
  --saveTNF arg                     File to save (or load if exists) TNF matrix for each contig in input
  --saveDistance arg                File to save (or load if exists) distance graph at lowest probability 
                                    cutoff
  --saveCls                         Save cluster memberships as a matrix format
  --unbinned                        Generate [outFile].unbinned.fa file for unbinned contigs
  --noBinOut                        No bin output. Usually combined with --saveCls to check only contig 
                                    memberships
  -B [ --B ] arg (=20)              Number of bootstrapping for ensemble binning (Recommended to be >=20)
  --pB arg (=50)                    Proportion of shared membership in bootstrapping. Major control for 
                                    sensitivity/specificity. The higher, the specific. (Percentage; Should be
                                    between 0 and 100)
  --seed arg (=0)                   For reproducibility in ensemble binning, though it might produce slightly
                                    different results. (0: use random seed)
  --keep                            Keep the intermediate files for later usage
  -d [ --debug ]                    Debug output
  -v [ --verbose ]                  Verbose output
```

## metabat2_contigOverlaps

### Tool Description
Report how reads span contigs between assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabat2:2.18--h6f16272_0
- **Homepage**: https://bitbucket.org/berkeleylab/metabat
- **Package**: https://anaconda.org/channels/bioconda/packages/metabat2/overview
- **Validation**: PASS

### Original Help Text
```text
ContigOverlaps 2.18 20250528_211447
Usage: contigOverlaps <options> firstAssemblyBams.fofn secondAssemblyBams.fofn [ ... ]
where options include:
	--help              print out this message
	--percentIdentity   arg  The minimum end-to-end % identity of qualifying reads (default: 97)
```

## Metadata
- **Docker Image**: quay.io/biocontainers/metabat2:2.18--h6f16272_0
- **Homepage**: https://bitbucket.org/berkeleylab/metabat
- **Package**: https://anaconda.org/channels/bioconda/packages/metabat2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metabat2/overview
- **Total Downloads**: 74.5K
- **Last updated**: 2025-05-28
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/metabat2:2.18--h6f16272_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2240744173: no space left on device
```


## Metadata
- **Skill**: generated

## metabat2_jgi_summarize_bam_contig_depths

### Tool Description
Summarize BAM contig depths for MetaBAT2 binning.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabat2:2.18--h6f16272_0
- **Homepage**: https://bitbucket.org/berkeleylab/metabat
- **Package**: https://anaconda.org/channels/bioconda/packages/metabat2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/metabat2:2.18--h6f16272_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3863026982: no space left on device
```

