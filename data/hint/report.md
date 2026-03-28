# hint CWL Generation Report

## hint_pre

### Tool Description
Preprocessing Hi-C data, alignment, create contact matrices, and normalization.

### Metadata
- **Docker Image**: quay.io/biocontainers/hint:2.2.8--py_1
- **Homepage**: https://github.com/suwangbio/HiNT_py3
- **Package**: https://anaconda.org/channels/bioconda/packages/hint/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hint/overview
- **Total Downloads**: 18.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/suwangbio/HiNT_py3
- **Stars**: N/A
### Original Help Text
```text
usage: hint pre [-h] -d HICDATA --refdir REFERENCEDIR --samtoolspath
                SAMTOOLSPATH [-a BWAPATH] [-i BWAINDEX] [-g {hg38,hg19,mm10}]
                [--informat {fastq,bam}] [--outformat {cooler,juicer}]
                [-r RESOLUTION] [--coolerpath COOLERPATH]
                [--juicerpath JUICERPATH] --pairtoolspath PAIRSAMPATH
                [-n NAME] [-o OUTDIR] [-p THREADS]

HiNT-pre: Preprocessing Hi-C data, alignment, create contact matrices, and
normalization. EXAMPLE: hint pre -d
/path/to/hic_1.fastq.gz,/path/to/hic_2.fastq.gz --refdir
/path/to/HiNT_reference_dir/hg19/ -i /path/to/bwaIndex/hg19/hg19.fa --informat
fastq --outformat cooler -g hg19 -n test -o /path/to/outputdir --
pairtoolspath /path/to/pairtools

optional arguments:
  -h, --help            show this help message and exit
  -d HICDATA, --data HICDATA
                        Hi-C raw data with fastq format, two mates seperate
                        with a comma ',', or bam file after alignment.
  --refdir REFERENCEDIR
                        the reference directory that downloaded from dropbox
                        dropbox. (https://www.dropbox.com/sh/2ufsyu4wvrboxxp/A
                        ABk5-_Fwy7jdM_t0vIsgYf4a?dl=0.)
  --samtoolspath SAMTOOLSPATH
                        Path to samtools,
                        e.g./n/app/samtools/1.3.1/bin/samtools
  -a BWAPATH, --alignerbwa BWAPATH
                        Path to your BWA aligner, required when your input
                        file(s) is in fastq format, ignore when you input a
                        bam file.
  -i BWAINDEX, --bwaIndex BWAINDEX
                        Path to BWA Index if your input file is fastq format,
                        ignore if your input is bam file.
  -g {hg38,hg19,mm10}, --genome {hg38,hg19,mm10}
                        Specify your species, choose from hg38, hg19, and
                        mm10. DEFAULT: hg19
  --informat {fastq,bam}
                        Format for the Hi-C input data, choose from 'fastq'
                        and 'bam', DEFAULT: fastq
  --outformat {cooler,juicer}
                        Format for the output contact matrix, choose from
                        'cooler' and 'juicer', DEFAULT: cooler
  -r RESOLUTION, --resolution RESOLUTION
                        Generate Hi-C contact matrix in user specified
                        resolution. If not set, HiNT will only output Hi-C
                        contact matrix in 50kb, 100kb, and 1Mb
  --coolerpath COOLERPATH
                        Path to cooler tool, required when the format is cool
                        via cooler
  --juicerpath JUICERPATH
                        Path to juicer tools, required when the format is hic
                        via juicer tools
  --pairtoolspath PAIRSAMPATH
                        Path to pairtools
  -n NAME, --name NAME  Prefix for the result files. If not set, 'NA' will be
                        used instead
  -o OUTDIR, --outdir OUTDIR
                        Path to the output directory, where you want to store
                        all the output files, if not set, the current
                        directory will be used
  -p THREADS, --threads THREADS
                        Number of threads for running BWA, DEFAULT: 16
```


## hint_cnv

### Tool Description
prediction of copy number information, as well as segmentation from Hi-C.

### Metadata
- **Docker Image**: quay.io/biocontainers/hint:2.2.8--py_1
- **Homepage**: https://github.com/suwangbio/HiNT_py3
- **Package**: https://anaconda.org/channels/bioconda/packages/hint/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hint cnv [-h] -m MATRIXFILE --refdir REFERENCEDIR
                [--maptrack {24mer,36mer,50mer}] --bicseq BICSEQ [--doiter]
                [-f {cooler,juicer}] [-e {MboI,HindIII,DpnII}] [-r RESOLUTION]
                [-g {hg38,hg19,mm10}] [-o OUTDIR] [-n NAME] [-p THREADS]

HiNT cnv: prediction of copy number information, as well as segmentation from
Hi-C. EXAMPLE: hint cnv -m contactMatrix.mcool -f cooler --refdir
/path/to/HiNT_reference_dir/hg19 -r 50 --bicseq /path/to/BICseq2-seg_v0.7.3 -g
hg19 -n test -o /path/to/outputDir

optional arguments:
  -h, --help            show this help message and exit
  -m MATRIXFILE, --matrixfile MATRIXFILE
                        The matrix compressed file contains single or multiple
                        resolutions Hi-C contact matrix files (multi-cool, or
                        hic file), resolution should be set via parameter -r;
                        or a sparse | dense format matrix file whole genome
                        widely (not suggest when using a high resolution)
  --refdir REFERENCEDIR
                        the reference directory that downloaded from dropbox
                        dropbox. (https://www.dropbox.com/sh/2ufsyu4wvrboxxp/A
                        ABk5-_Fwy7jdM_t0vIsgYf4a?dl=0.)
  --maptrack {24mer,36mer,50mer}
                        Choose which ENCODE mappability track should be used
                        for regression. See more details
                        http://genome.ucsc.edu/cgi-
                        bin/hgTrackUi?db=hg18&g=wgEncodeMapability. DEFAULT:
                        50mer
  --bicseq BICSEQ       /path/to/bicseqDir/
  --doiter              If this switch is on, HiNT will do the iterative
                        regression model by removing copy numer variated
                        regions, DEFAULT=False
  -f {cooler,juicer}, --format {cooler,juicer}
                        Format for the output contact matrix, DEFAULT: cooler
  -e {MboI,HindIII,DpnII}, --enzyme {MboI,HindIII,DpnII}
                        enzyme used for the Hi-C experiments, will be used to
                        calculate enzyme sites
  -r RESOLUTION, --resolution RESOLUTION
                        Resolution for the Hi-C contact matrix used for the
                        CNV detection, unit: kb, DEFAULT: 50kb
  -g {hg38,hg19,mm10}, --genome {hg38,hg19,mm10}
                        Specify your species, choose form hg38, hg19, and
                        mm10. DEFAULT: hg19
  -o OUTDIR, --outdir OUTDIR
                        Path to the output directory, where you want to store
                        all the output files, if not set, the current
                        directory will be used
  -n NAME, --name NAME  Prefix for the result files. If not set, 'NA' will be
                        used instead
  -p THREADS, --threads THREADS
                        Number of threads for running HiNT-cnv, DEFAULT: 16
```


## hint_tl

### Tool Description
interchromosomal translocations and breakpoints detection from Hi-C inter-chromosomal interaction matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/hint:2.2.8--py_1
- **Homepage**: https://github.com/suwangbio/HiNT_py3
- **Package**: https://anaconda.org/channels/bioconda/packages/hint/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hint tl [-h] -m MATRIXFILE --refdir REFERENCEDIR
               [-e {DpnII,MboI,HindIII}] [-f {cooler,juicer}] --ppath
               PAIRIXPATH [-g {hg38,hg19,mm10}] [--chimeric CHIMERIC]
               --backdir BACKGROUNDINTERCHROMMATRIXDIR [-c CUTOFF] [-o OUTDIR]
               [-n NAME] [-p THREADS]

HiNT-tl: interchromosomal translocations and breakpoints detection from Hi-C
inter-chromosomal interaction matrices. EXAMPLE: hint tl -m
/path/to/data_1Mb.cool,/path/to/data_100kb.cool --refdir
/path/to/HiNT_reference_dir/hg19 --backdir /path/to/backgroundMatrices/hg19 -c
chimericReads.pairsam -f cooler -g hg19 -n test -o /path/to/outputDir

optional arguments:
  -h, --help            show this help message and exit
  -m MATRIXFILE, --matrixfile MATRIXFILE
                        The matrix compressed file contains 1Mb and 100kb
                        resolutions Hi-C contact matrix (.hic format), or 1Mb
                        and 100kb resolution files seperate with ',', like
                        /path/to/data_1Mb.cool,/path/to/data_100kb.cool or the
                        directory that contain Hi-C interaction matrix in
                        sparse or dense matrix format, interchromosomal
                        interaction matrices only. Absolute path is required
  --refdir REFERENCEDIR
                        the reference directory that downloaded from dropbox
                        dropbox. (https://www.dropbox.com/sh/2ufsyu4wvrboxxp/A
                        ABk5-_Fwy7jdM_t0vIsgYf4a?dl=0.)
  -e {DpnII,MboI,HindIII}, --enzyme {DpnII,MboI,HindIII}
                        Enzyme used in Hi-C experiment, DEFAULT: MboI
  -f {cooler,juicer}, --format {cooler,juicer}
                        Format for the output contact matrix, DEFAULT: cooler
  --ppath PAIRIXPATH    Path for pairix, use 'which pairix' to get the path
  -g {hg38,hg19,mm10}, --genome {hg38,hg19,mm10}
                        Specify your species, choose form hg38, hg19, and
                        mm10. DEFAULT: hg19
  --chimeric CHIMERIC   Chimeric read pairs with .pairsam format. If no
                        chimeric reads provided, breakpoints in 100kb
                        resolution will be output only
  --backdir BACKGROUNDINTERCHROMMATRIXDIR
                        Path to the directory of
                        backgroundInterchromMatrixDir, can be downloaded from 
                        https://www.dropbox.com/sh/2ufsyu4wvrboxxp/AABk5-_Fwy7
                        jdM_t0vIsgYf4a?dl=0., named as backgroundMatrices,
                        e,g. path_to_/backgroundMatrices/genome
  -c CUTOFF, --cutoff CUTOFF
                        Cutoff of the rank product for chromosomal pairs to
                        select candidate translocated chromosomal pairs,
                        default = 0.05
  -o OUTDIR, --outdir OUTDIR
                        Path to the output directory, where you want to store
                        all the output files, if not set, the current
                        directory will be used
  -n NAME, --name NAME  Prefix for the result files. If not set, 'NA' will be
                        used instead
  -p THREADS, --threads THREADS
                        Number of threads for running HiNT-tl translocation
                        breakpoints detection part, DEFAULT: 16
```


## Metadata
- **Skill**: generated
