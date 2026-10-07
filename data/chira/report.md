# chira CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| chira_collapse | PASS |  |
| chira_extract | PASS |  |
| chira_map | PASS |  |
| chira_merge | PASS |  |
| chira_quantify | PASS |  |

## chira_collapse

### Tool Description
Chimeric Read Annotator: collapse FASTQ reads to FASTA format

### Metadata
- **Docker Image**: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
- **Homepage**: https://github.com/pavanvidem/chira/
- **Package**: https://anaconda.org/channels/bioconda/packages/chira/overview
- **Validation**: PASS
### Original Help Text
```text
usage: chira_collapse.py [-h] [-v,--version]

Chimeric Read Annotator: collapse FASTQ reads to FASTA format

optional arguments:
  -h, --help            show this help message and exit
  -i , --fastq          Input fastq file (default: None)
  -o , --fasta          Output fasta file (default: None)
  -u UMI_LEN, --umi_len UMI_LEN
                        Length of the UMI, if present.It is trimmed from the
                        5' end of each read and appended to the tag id
                        (default: 0)
  -v, --version         show program's version number and exit
```

## chira_map

### Tool Description
Chimeric Read Annotator: map reads to the reference

### Metadata
- **Docker Image**: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
- **Homepage**: https://github.com/pavanvidem/chira/
- **Package**: https://anaconda.org/channels/bioconda/packages/chira/overview
- **Validation**: PASS
### Original Help Text
```text
usage: chira_map.py [-h] [-v,--version]

Chimeric Read Annotator: map reads to the reference

optional arguments:
  -h, --help            show this help message and exit
  -a , --aligner        Alignment program to use, bwa or clan (default: bwa)
  -i , --query_fasta    Path to query fasta file (default: None)
  -o , --outdir         Output directory path for the analysis (default: None)
  -x1 , --index1        first prioroty index file (default: None)
  -x2 , --index2        second priority index file (default: None)
  -f1 , --ref_fasta1    First prioroty fasta file (default: None)
  -f2 , --ref_fasta2    second priority fasta file (default: None)
  -b, --build           Build indices from reference fasta files (default:
                        False)
  -p , --processes      Number of processes to use (default: 1)
  -s , --stranded       Strand-specificity of input samples. fw = map to
                        transcript strand; rc = map to reverse compliment of
                        transcript strand; both = try to map on both strnads
                        (default: fw)
  -l1 , --seed_length1 
                        Seed length for 1st mapping iteration. bwa-mem
                        parameter "-k" (default: 12)
  -l2 , --seed_length2 
                        Seed length for 2nd mapping iteration. bwa-mem
                        parameter "-k" (default: 16)
  -s1 , --align_score1 
                        Minimum alignment score in 1st mapping iteration. bwa-
                        mem parameter "-T" and clan_search parameter "-l"
                        (default: 18)
  -s2 , --align_score2 
                        Minimum alignment score in 2nd mapping iteration. It
                        must be smaller than --align_score1 parameter. bwa-mem
                        parameter "-T" and clan_search parameter "-l"
                        (default: 16)
  -ma1 , --match1       Matching score for 1st mapping iteration. (default: 1)
  -mm1 , --mismatch1    Mismatch penalty for 1st mapping iteration. (default:
                        4)
  -ma2 , --match2       Matching score for 2nd mapping iteration. (default: 1)
  -mm2 , --mismatch2    Mismatch penalty for 2nd mapping iteration. (default:
                        6)
  -go1 , --gapopen1     Gap opening penalty for 1st mapping iteration.
                        (default: 6)
  -ge1 , --gapext1      Gap extension penalty for 1st mapping iteration.
                        (default: 1)
  -go2 , --gapopen2     Gap opening penalty for 2nd mapping iteration.
                        (default: 100)
  -ge2 , --gapext2      Gap extension penalty for 2nd mapping iteration.
                        (default: 100)
  -h1 , --nhits1        Number of allowed multi hits per read (default: 50)
  -h2 , --nhits2        Number of allowed multi hits per read in 2nd iteration
                        (default: 100)
  -co , --chimeric_overlap 
                        Maximum number of bases allowed between the chimeric
                        segments of a read (default: 2)
  -v, --version         show program's version number and exit
```

## chira_merge

### Tool Description
Chimeric Read Annotator: merge alignments and convert coordinates

### Metadata
- **Docker Image**: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
- **Homepage**: https://github.com/pavanvidem/chira/
- **Package**: https://anaconda.org/channels/bioconda/packages/chira/overview
- **Validation**: PASS
### Original Help Text
```text
usage: chira_merge.py [-h] [-v,--version]

Chimeric Read Annotator: merge alignments and convert coordinates

optional arguments:
  -h, --help            show this help message and exit
  -bb, --block_based
  -b , --bed            Input BED file with alignments (default: None)
  -o , --outdir         Output directory path for the whole analysis (default:
                        None)
  -g , --gtf            Annotation GTF file (default: None)
  -ao , --alignment_overlap 
                        Minimum percentage overlap among BED entries inorder
                        to merge. [0-1.0] (default: 0.7)
  -so , --segment_overlap 
                        Matching read positions with greater than this %
                        overlap are merged into a segment (default: 0.7)
  -lt , --length_threshold 
                        Minimum length of the alignments to consider as a
                        fraction of longest alignmnet. [0.8-1.0] (default:
                        0.9)
  -d , --distance       Blockbuster parameter distance (default: 30)
  -mc , --min_cluster_height 
                        Blockbuster parameter minClusterHeight (default: 10)
  -mb , --min_block_height 
                        Blockbuster parameter minBlockHeight (default: 10)
  -sc , --scale         Blockbuster parameter scale (default: 0.1)
  -co , --chimeric_overlap 
                        Maximum number of bases allowed between the chimeric
                        segments of a read (default: 2)
  -f1 , --ref_fasta1    First prioroty fasta file (default: None)
  -f2 , --ref_fasta2    second priority fasta file (default: None)
  -c, --chimeric_only   Consider chimeric reads only for merging (default:
                        False)
  -ls , --min_locus_size 
                        Minimum number of alignments required per mered locus
                        (default: 1)
  -v, --version         show program's version number and exit
```

## chira_quantify

### Tool Description
Chimeric Read Annotator: quantify mapped loci

### Metadata
- **Docker Image**: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
- **Homepage**: https://github.com/pavanvidem/chira/
- **Package**: https://anaconda.org/channels/bioconda/packages/chira/overview
- **Validation**: PASS
### Original Help Text
```text
usage: chira_quantify.py [-h] [-v,--version]

Chimeric Read Annotator: quantify mapped loci

optional arguments:
  -h, --help            show this help message and exit
  -b , --bed            Input BED file (default: None)
  -m , --merged_bed     Input merged BED file (default: None)
  -o , --outdir         Output file containing merged alignments (default:
                        None)
  -cs , --crl_share     Minimum fraction of reads of a locus that must overlap
                        with all CRL loci inorder to merge it into that CRL.
                        (default: 0.7)
  -ls , --min_locus_size 
                        Minimum number of reads a locus should have in order
                        to participate in CRL creation.Always set this value
                        relative to your sequencing depth. Setting this to
                        lower leadsCRLs of random multimappings Also consider
                        setting the --crl_share option along with this
                        (default: 10)
  -e , --em_threshold   The maximum difference of transcripts expression
                        between two consecutive iterations of EM algorithm to
                        converge. (default: 1e-05)
  -crl, --build_crls_too
                        Create CRLs too (default: False)
  -v, --version         show program's version number and exit
```

## chira_extract

### Tool Description
Chimeric Read Annotator: extract chimeras

### Metadata
- **Docker Image**: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
- **Homepage**: https://github.com/pavanvidem/chira/
- **Package**: https://anaconda.org/channels/bioconda/packages/chira/overview
- **Validation**: PASS
### Original Help Text
```text
usage: chira_extract.py [-h] [-v,--version]

Chimeric Read Annotator: extract chimeras

optional arguments:
  -h, --help            show this help message and exit
  -l , --loci           Input BED file with alignments (default: None)
  -o , --out            Path to output directory (default: None)
  -g , --gtf            Annotation GTF file (default: None)
  -p , --processes      Number of processes to use (default: 1)
  -tc , --tpm_cutoff    Transcripts with less than this percentile TPMs will
                        be discarded in the final output. [0-1.0] (default: 0)
  -sc , --score_cutoff 
                        Hybrids with less than this score will be discarded in
                        the final output. [0-1.0] (default: 0.0)
  -co , --chimeric_overlap 
                        Maximum number of bases allowed between the chimeric
                        segments of a read (default: 2)
  -r, --hybridize       Hybridize the predicted chimeras (default: False)
  -ns, --no_seed        Do not enforce seed interactions (default: False)
  -acc , --accessibility 
                        IntaRNA accessibility: C (compute) or N (not)
                        (default: N)
  -m , --intarna_mode   IntaRNA mode: H (heuristic), M (exact), S (seed-only)
                        (default: H)
  -t , --temperature    IntaRNA temperature parameter in Celsius to setup the
                        VRNA energy parameters (default: 37)
  -sbp , --seed_bp      IntaRNA --seedBP parameter: number of inter-molecular
                        base pairs within the seed region (default: 5)
  -smpu , --seed_min_pu 
                        IntaRNA --seedMinPu parameter: minimal unpaired
                        probability (per sequence) a seed region may have
                        (default: 0)
  -accw , --acc_width   IntaRNA --accW parameter: sliding window size for
                        accessibility computation (default: 150)
  -f1 , --ref_fasta1    First prioroty fasta file (default: None)
  -f2 , --ref_fasta2    second priority fasta file (default: None)
  -f , --ref            Reference fasta file (default: None)
  -s, --summerize       Summerize interactions at loci level (default: False)
  -v, --version         show program's version number and exit
```

## Metadata
- **Skill**: generated

