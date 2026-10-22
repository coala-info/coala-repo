# strainscan CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| strainscan | PASS | repo test data: DB from 11 test genomes, simulated reads of GCF_003812785 give that strain (cluster C4, depth 3.8x), as in Output_Example; baseCommand fixed to strainscan |
| strainscan_strainscan_build | PASS | new CWL; builds a database from the 11 repo test genomes (cluster, k-mer set and tree folders) and strainscan runs on it |

## strainscan

### Tool Description
A kmer-based strain-level identification tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainscan:1.0.14--pyhdfd78af_1
- **Homepage**: https://github.com/liaoherui/StrainScan
- **Package**: https://anaconda.org/channels/bioconda/packages/strainscan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/strainscan/overview
- **Total Downloads**: 7.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/liaoherui/StrainScan
- **Stars**: N/A
### Original Help Text
```text
usage: StrainScan.py [-h] -i INPUT_FQ [-j INPUT_FQ2] -d DB_DIR [-o OUT_DIR]
                     [-k KSIZE] [-l LDEP] [-b SPROB] [-p PMODE] [-r RGENOME]
                     [-e EMODE] [-s MSN]

StrainScan - A kmer-based strain-level identification tool.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FQ, --input_fastq INPUT_FQ
                        The dir of input fastq data --- Required
  -j INPUT_FQ2, --input_fastq_2 INPUT_FQ2
                        The dir of input fastq data (for pair-end data).
  -d DB_DIR, --database_dir DB_DIR
                        The dir of your database --- Required
  -o OUT_DIR, --output_dir OUT_DIR
                        Output dir (default: current dir/StrainVote_Result)
  -k KSIZE, --kmer_size KSIZE
                        The size of kmer, should be odd number. (default:
                        k=31)
  -l LDEP, --low_dep LDEP
                        This parameter can be set to "1" if the sequencing
                        depth of input data is very low (e.g. < 10x). For
                        super low depth ( < 1x ), you can use "-l 2" (default:
                        -l 0)
  -b SPROB, --strain_prob SPROB
                        If this parameter is set to 1, then the algorithm will
                        output the probabolity of detecting a strain (or
                        cluster) in low-depth (e.g. <1x) samples. (default: -b
                        0)
  -p PMODE, --plasmid_mode PMODE
                        If this parameter is set to 1, the intra-cluster
                        searching process will search possible plasmids using
                        short contigs (<100000 bp) in strain genomes, which
                        are likely to be plasmids. If this parameter is set to
                        2, the intra-cluster searching process will search
                        possible strains using given reference genomes by
                        "-r". Reference genome sequences (-r) are required if
                        this mode is used. (default: -p 0)
  -r RGENOME, --ref_genome RGENOME
                        The dir of reference genomes of identified cluster or
                        all strains. If plasmid_mode is used, then this
                        parameter is required.
  -e EMODE, --extraRegion_mode EMODE
                        If this parameter is set to 1, the intra-cluster
                        searching process will search possible strains and
                        return strains with extra regions (could be different
                        genes, SNVs or SVs to the possible strains) covered.
                        (default: -e 0)
  -s MSN, --minimum_snv_num MSN
                        The minimum number of SNV at Layer-2 identification.
                        (default: k=40)
```

## strainscan_strainscan_build

### Tool Description
StrainScan - A kmer-based strain-level identification tool. strainscan_build builds the database from a directory of strain genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainscan:1.0.14--pyhdfd78af_1
- **Homepage**: https://github.com/liaoherui/StrainScan
- **Package**: https://anaconda.org/channels/bioconda/packages/strainscan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: StrainScan_build.py [-h] -i INPUT_FA [-o OUT_DIR] [-c CLS_CUSTOM_FILE]
                           [-k KSIZE] [-t THREADS] [-u UKNUM] [-g GKRATIO]
                           [-m MAS] [-e MEM] [-n MINK] [-x MAXK] [-r MAXN]

StrainScan - A kmer-based strain-level identification tool.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FA, --input_fasta INPUT_FA
                        The dir of input fasta genome --- Required (default:
                        None)
  -o OUT_DIR, --output_dir OUT_DIR
                        Output directory. (default: /StrainScan_DB)
  -c CLS_CUSTOM_FILE, --cls_file CLS_CUSTOM_FILE
                        The custom clustering file provided by user. (default:
                        )
  -k KSIZE, --kmer_size KSIZE
                        The size of kmer, should be odd number. (default: 31)
  -t THREADS, --threads THREADS
                        The threads used to build the database. (default: 1)
  -u UKNUM, --uk_num UKNUM
                        The maximum number of unique k-mers in each genome to
                        extract. (default: 100000)
  -g GKRATIO, --gk_ratio GKRATIO
                        The ratio of group-specific k-mers to extract.
                        (default: 1.0)
  -m MAS, --strainest_sample MAS
                        If this parameter is 1, then the program will search
                        joint kmer sets from msa generated by Strainest.
                        (default: 0)
  -e MEM, --memory_efficient MEM
                        If this parameter is 1, then the program will build
                        the database with the memory efficient mode. (default:
                        0)
  -n MINK, --mink_cutoff MINK
                        Minimum k-mer number cutoff in a node. (default: 1000)
  -x MAXK, --maxk_cutoff MAXK
                        Maximum k-mer number cutoff in a node (default: 30000)
  -r MAXN, --maxn_cutoff MAXN
                        Maximum cluster number for node reconstruction.
                        (default: 3000)
```

