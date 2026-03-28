# ribotish CWL Generation Report

## ribotish_quality

### Tool Description
Quality control for Riboseq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
- **Homepage**: https://github.com/zhpn1024/ribotish
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ribotish/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-11-13
- **GitHub**: https://github.com/zhpn1024/ribotish
- **Stars**: N/A
### Original Help Text
```text
usage: ribotish quality [-h] -b RIBOBAMPATH [-g GENEPATH] [-o OUTPUT] [-t]
                        [-i INPUT] [--geneformat GENEFORMAT] [--chrmap CHRMAP]
                        [-f FIGPDFPATH] [-r PARAPATH] [-l LENS] [-d DIS]
                        [--bins BINS] [--nom0] [--th TH] [--end3]
                        [--maxNH MAXNH] [--minMapQ MINMAPQ] [--secondary]
                        [--paired] [--colorblind] [--colors COLORS]
                        [-p NUMPROC] [-v]

options:
  -h, --help            show this help message and exit
  -b RIBOBAMPATH        Riboseq bam file
  -g GENEPATH           Gene annotation file
  -o OUTPUT             Output data file (default: ribobampath[:-4]+
                        '_qual.txt')
  -t, --tis             The data is TIS enriched (for LTM & Harritonine)
  -i INPUT              Input previous output file, do not read gene file and
                        bam file again
  --geneformat GENEFORMAT
                        Gene annotation file format (gtf, bed, gpd, gff,
                        default: auto)
  --chrmap CHRMAP       Input chromosome id mapping table file if annotation
                        chr ids are not same as chr ids in bam/fasta files
  -f FIGPDFPATH         Output pdf figure file (default: ribobampath[:-4]+
                        '_qual.pdf')
  -r PARAPATH           Output offset parameter file (default:
                        ribobampath[:-4]+ '.para.py')
  -l LENS               Range of tag length (default: 25,35)
  -d DIS                Position range near start codon or stop codon
                        (default: -40,20)
  --bins BINS           Bins for cds profile (default: 20)
  --nom0                Do not consider reads with mismatch at position 0 as a
                        new group
  --th TH               Threshold for quality (default: 0.5)
  --end3                Plot 3' end profile
  --maxNH MAXNH         Max NH value allowed for bam alignments (default: 1)
  --minMapQ MINMAPQ     Min MapQ value required for bam alignments (default:
                        1)
  --secondary           Use bam secondary alignments
  --paired              Reads are paired end
  --colorblind          Use a color style readable for color blind people
                        ('#F00078,#00F000,#0078F0')
  --colors COLORS       User specified Matplotlib accepted color codes for
                        three frames (default: 'r,g,b')
  -p NUMPROC            Number of processes (default: 1)
  -v, --verbose         Increase output verbosity
```


## ribotish_predict

### Tool Description
Predicts ORFs using riboseq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
- **Homepage**: https://github.com/zhpn1024/ribotish
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotish/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribotish predict [-h] [-t TISBAMPATHS] [-b RIBOBAMPATHS] -g GENEPATH
                        -f GENOMEFAPATH -o OUTPUT [-i INPUT] [--igenomepos]
                        [--geneformat GENEFORMAT] [--tispara TISPARA]
                        [--ribopara RIBOPARA] [--nparts NPARTS] [-a AGENEPATH]
                        [-e ESTPATH] [-s INESTPATH]
                        [--transprofile TRANSPROFILE] [--inprofile INPROFILE]
                        [--chrmap CHRMAP] [--allresult ALLRESULT] [--alt]
                        [--altcodons ALTCODONS] [--tis2ribo] [--harr]
                        [--harrwidth HARRWIDTH] [--enrichtest]
                        [--minaalen MINAALEN] [--genefilter GENEFILTER]
                        [--tpth TPTH] [--fpth FPTH] [--minpth MINPTH]
                        [--fspth FSPTH] [--fsqth FSQTH] [--framelocalbest]
                        [--framebest] [--longest] [--seq] [--aaseq] [--blocks]
                        [--inframecount] [--maxNH MAXNH] [--minMapQ MINMAPQ]
                        [--secondary] [--paired] [--nocompatible]
                        [--compatiblemis COMPATIBLEMIS] [-p NUMPROC] [-v]

options:
  -h, --help            show this help message and exit
  -t TISBAMPATHS        TIS enriched riboseq bam files, comma seperated
  -b RIBOBAMPATHS       Ordinary riboseq bam files, comma seperated
  -g GENEPATH           Gene annotation file for ORF prediction
  -f GENOMEFAPATH       Genome fasta file
  -o OUTPUT             Output result file
  -i INPUT              Only test input candidate ORFs, format: transID start
                        stop (0 based, half open)
  --igenomepos          The start and end in -i input file are genome
                        positions
  --geneformat GENEFORMAT
                        Gene annotation file format (gtf, bed, gpd, gff,
                        default: auto)
  --tispara TISPARA     Input offset parameter files for -t bam files
  --ribopara RIBOPARA   Input offset parameter files for -b bam files
  --nparts NPARTS       Group transcript according to TIS reads density
                        quantile (default: 10)
  -a AGENEPATH          Gene file for known protein coding gene annotation and
                        TIS background estimation instead of -g gene file
  -e ESTPATH            Output TIS background estimation result (default:
                        tisBackground.txt)
  -s INESTPATH          Input background estimation result file instead of
                        instant estimation
  --transprofile TRANSPROFILE
                        Output RPF P-site profile for each transcript
  --inprofile INPROFILE
                        Input RPF P-site profile for each transcript, instead
                        of reading bam reads, save time for re-running
  --chrmap CHRMAP       Input chromosome id mapping table file if annotation
                        chr ids are not same as chr ids in bam/fasta files
  --allresult ALLRESULT
                        All result output without FDR q-value threshold
                        (default: output + '_all.txt', 'off' to turn off)
  --alt                 Use alternative start codons (all codons with 1 base
                        different from ATG)
  --altcodons ALTCODONS
                        Use provided alternative start codons, comma
                        seperated, eg. CTG,GTG,ACG
  --tis2ribo            Add TIS bam counts to ribo, if specified or -b not
                        provided
  --harr                The data is treated with harringtonine (instead of
                        LTM)
  --harrwidth HARRWIDTH
                        Flanking region for harr data, in codons (default: 15)
  --enrichtest          Use enrich test instead of frame test
  --minaalen MINAALEN   Min amino acid length of candidate ORF (default: 6)
  --genefilter GENEFILTER
                        Only process given genes
  --tpth TPTH           TIS p value threshold (default: 0.05)
  --fpth FPTH           Frame p value threshold (default: 0.05)
  --minpth MINPTH       At least one of TIS or frame p value should be lower
                        than this threshold (default: 0.05)
  --fspth FSPTH         Fisher's p value threshold
  --fsqth FSQTH         Fisher's FDR q value threshold
  --framelocalbest      Only report local best frame test results
  --framebest           Only report best frame test results
  --longest             Only report longest possible ORF results
  --seq                 Report ORF sequences
  --aaseq               Report amino acid sequences
  --blocks              Report all exon block positions for predicted ORFs
  --inframecount        Report the sum of all counts at the in-frame positions
                        in the ORF
  --maxNH MAXNH         Max NH value allowed for bam alignments (default: 5)
  --minMapQ MINMAPQ     Min MapQ value required for bam alignments (default:
                        1)
  --secondary           Use bam secondary alignments
  --paired              Reads are paired end
  --nocompatible        Do not require reads compatible with transcript splice
                        junctions
  --compatiblemis COMPATIBLEMIS
                        Missed bases allowed in reads compatibility check
                        (default: 2)
  -p NUMPROC            Number of processes
  -v, --verbose         Increase output verbosity
```


## ribotish_tisdiff

### Tool Description
Compares TIS usage between two groups of samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
- **Homepage**: https://github.com/zhpn1024/ribotish
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotish/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribotish tisdiff [-h] -1 TIS1PATHS -2 TIS2PATHS -a TIS1BAMPATHS
                        -b TIS2BAMPATHS -g GENEPATH -o OUTPUT
                        [--tis1para TIS1PARA] [--tis2para TIS2PARA]
                        [--geneformat GENEFORMAT] [--maxNH MAXNH]
                        [--minMapQ MINMAPQ] [--secondary] [--paired]
                        [--l1 TIS1LABELS] [--l2 TIS2LABELS] [--nocompatible]
                        [--compatiblemis COMPATIBLEMIS] [--chrmap CHRMAP]
                        [--normcomm] [--normanno] [--rnaseq RNASEQ]
                        [--scalefactor SCALEFACTOR] [--rnascale RNASCALE]
                        [--chi2] [--betabinom] [--export EXPORT]
                        [--plotout PLOTOUT] [--figsize FIGSIZE]
                        [--plotma PLOTMA] [--qi QI] [-f FOLDCHANGE]
                        [--ipth IPTH] [--iqth IQTH] [--opth OPTH]
                        [--oqth OQTH] [-p NUMPROC] [-v]

options:
  -h, --help            show this help message and exit
  -1 TIS1PATHS          Prediction results of group 1 TIS data
  -2 TIS2PATHS          Prediction results of group 2 TIS data
  -a TIS1BAMPATHS       Group 1 TIS enriched riboseq bam files, comma
                        seperated
  -b TIS2BAMPATHS       Group 2 TIS enriched riboseq bam files, comma
                        seperated
  -g GENEPATH           Gene annotation file
  -o OUTPUT             Output result file
  --tis1para TIS1PARA   Input offset parameter files for group 1 bam files
  --tis2para TIS2PARA   Input offset parameter files for group 2 bam files
  --geneformat GENEFORMAT
                        Gene annotation file format (gtf, bed, gpd, gff,
                        default: auto)
  --maxNH MAXNH         Max NH value allowed for bam alignments (default: 5)
  --minMapQ MINMAPQ     Min MapQ value required for bam alignments (default:
                        1)
  --secondary           Use bam secondary alignments
  --paired              Reads are paired end
  --l1 TIS1LABELS       Labels for group 1 TIS data
  --l2 TIS2LABELS       Labels for group 2 TIS data
  --nocompatible        Do not require reads compatible with transcript splice
                        junctions
  --compatiblemis COMPATIBLEMIS
                        Missed bases allowed in reads compatibility check
  --chrmap CHRMAP       Input chromosome id mapping table file if annotation
                        chr ids are not same as chr ids in bam/fasta files
  --normcomm            Use common TISs instead of union TISs for
                        normalization
  --normanno            Use only annotated TISs for normalization
  --rnaseq RNASEQ       RNASeq count input
  --scalefactor SCALEFACTOR
                        Input TIS scale factor of 2/1 (default: auto)
  --rnascale RNASCALE   Input RNASeq scale factor of 2/1 (default: auto)
  --chi2                Use chisquare test instead of Fisher's exact test for
                        mRNA referenced test
  --betabinom           Use beta-binom test instead of Fisher's exact test for
                        mRNA referenced test
  --export EXPORT       Export count table for differential analysis with
                        other tools
  --plotout PLOTOUT     Scatter plot output pdf file
  --figsize FIGSIZE     Scatter plot figure size (default: 8,8)
  --plotma PLOTMA       TIS normalization MA plot output pdf file
  --qi QI               Index of TIS q value, 0 based (default: 15)
  -f FOLDCHANGE         Minimum fold change threshold (default: 1.5)
  --ipth IPTH           Input TIS p value threshold (default: 0.05)
  --iqth IQTH           Input TIS q value threshold (default: 0.05)
  --opth OPTH           Output TIS diff p value threshold (default: 0.05)
  --oqth OQTH           Output TIS diff q value threshold (default: 0.05)
  -p NUMPROC            Number of processes
  -v, --verbose         Increase output verbosity
```


## ribotish_transplot

### Tool Description
Plotting tool for riboseq and rnaseq data aligned to transcripts.

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
- **Homepage**: https://github.com/zhpn1024/ribotish
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotish/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ribotish transplot [-h] -g GENEPATH -t TID -b BAMPATHS -f GENOMEFAPATH
                          [-o OUTPUT] [-l LABELS] [--para PARA]
                          [--scale SCALE] [--rna RNA] [--rnaoffset RNAOFFSET]
                          [--rnacol RNACOL] [--ymax YMAX] [-s SIZE] [-r RANGE]
                          [--geneformat GENEFORMAT] [--alt]
                          [--altcodons ALTCODONS] [--morecds MORECDS]
                          [--morecdsgp MORECDSGP] [--morecdsbox]
                          [--morecdslabel MORECDSLABEL] [--markpept MARKPEPT]
                          [--colorblind] [--colors COLORS] [--paired]
                          [--nocompatible] [--compatiblemis COMPATIBLEMIS]

options:
  -h, --help            show this help message and exit
  -g GENEPATH           Gene annotation file
  -t TID                Transcript id
  -b BAMPATHS           List of riboseq bam files, comma seperated
  -f GENOMEFAPATH       Genome fasta file
  -o OUTPUT             Output pdf figure file
  -l LABELS             Labels for riboseq bam files, comma seperated
  --para PARA           Input offset parameter files for -b bam files
  --scale SCALE         Input scale parameters for bam files, comma seperated
  --rna RNA             Which bam files are RNASeq instead of RiboSeq, 0
                        based, comma seperated
  --rnaoffset RNAOFFSET
                        Offset value for RNASeq reads (default: 12)
  --rnacol RNACOL       Color for RNASeq tracks, comma seperated, matching
                        --rna option (default: black)
  --ymax YMAX           Max y scale for tracks, comma seperated (default:
                        auto)
  -s SIZE               Figure size (default: 12,auto)
  -r RANGE              Range shown on the transcript, format: start,stop
                        (default: full transcript)
  --geneformat GENEFORMAT
                        Gene annotation file format (gtf, bed, gpd, gff,
                        default: auto)
  --alt                 Use alternative start codons (all codons with 1 base
                        different from ATG)
  --altcodons ALTCODONS
                        Use provided alternative start codons, comma
                        seperated, eg. CTG,GTG,ACG
  --morecds MORECDS     More cds regions plot in ORF track, format:
                        start1-stop1,start2-stop2...
  --morecdsgp MORECDSGP
                        More cds regions in genome position, format:
                        start1-stop1,start2-stop2...
  --morecdsbox          Add box to more CDS regions
  --morecdslabel MORECDSLABEL
                        Label for more cds regions plot in ORF track, comma
                        seperated
  --markpept MARKPEPT   Mark peptide position in morecds, relative to morecds
                        start format: start1-stop1,start2-stop2...
  --colorblind          Use a color style readable for color blind people
                        ('#F00078,#00F000,#0078F0')
  --colors COLORS       User specified Matplotlib accepted color codes for
                        three frames (default: 'r,g,b')
  --paired              Reads are paired end
  --nocompatible        Do not require reads compatible with transcript splice
                        junctions
  --compatiblemis COMPATIBLEMIS
                        Missed bases allowed in reads compatibility check
                        (default: 2)
```


## Metadata
- **Skill**: generated
