# feelnc CWL Generation Report

## feelnc_FEELnc_filter.pl

### Tool Description
Filter candidate lncRNA transcripts based on a GTF annotation file.

### Metadata
- **Docker Image**: quay.io/biocontainers/feelnc:0.2--pl526_0
- **Homepage**: https://github.com/tderrien/FEELnc
- **Package**: https://anaconda.org/channels/bioconda/packages/feelnc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/feelnc/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tderrien/FEELnc
- **Stars**: N/A
### Original Help Text
```text
Usage:
    FEELnc_filter.pl -i candidate.gtf -a mRNA.gtf > candidate_lncRNA.gtf

Options:
  General:
        --help                      Print this help
        --man                       Open man page
        --verbosity                 Level of verbosity 0, 1 and 2 [default 1]

  Mandatory arguments:
        -i,--infile=file.gtf        Specify the GTF file to be filtered (such as a cufflinks transcripts/merged .GTF file)
        -a,--mRNAfile=file.gtf      Specify the annotation GTF file to be filtered on based on sense exon overlap (file of protein coding annotation)

  Filtering arguments:
        -s,--size=200               Keep transcript with a minimal size (default 200)
        -b,--biotype                Only consider transcript(s) from the reference annotation having this(these) biotype(s) (e.g : -b transcript_biotype=protein_coding,pseudogene) [default undef i.e all transcripts]
        -l,--linconly               Keep only long intergenic/interveaning ncRNAs [default FALSE]
        --monoex=-1|0|1             Keep monoexonic transcript(s): mode to be selected from : -1 keep monoexonic antisense (for RNASeq stranded protocol), 1 keep all monoexonic, 0 remove all monoexonic   [default 0]
        --biex=25                   Discard biexonic transcripts having one exon size lower to this value (default 25)

  Overlapping specification:
        -f,--minfrac_over=0         Minimal fraction out of the candidate lncRNA size to be considered for overlap [default 0 i.e 1nt]
        -p,--proc=4                 Number of thread for computing overlap [default 4]

  Log output:
        -o,--outlog=file.log                Specify the log file of output which [default infile.log]
```


## feelnc_FEELnc_codpot.pl

### Tool Description
FEELnc_codpot.pl is a tool for predicting lncRNA transcripts.

### Metadata
- **Docker Image**: quay.io/biocontainers/feelnc:0.2--pl526_0
- **Homepage**: https://github.com/tderrien/FEELnc
- **Package**: https://anaconda.org/channels/bioconda/packages/feelnc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    FEELnc_codpot.pl -i transcripts.GTF -a known_mRNA.GTF -g genome.FA -l
    known_lnc.GTF [options...]

Options:
  General:
      --help                                Print this help
      --man                                 Open man page
      --verbosity                           Level of verbosity

  Mandatory arguments:
      -i,--infile=file.gtf/.fasta           Specify the .GTF or .FASTA file  (such as a cufflinks transcripts/merged .GTF or .FASTA file)
      -a,--mRNAfile=file.gtf/.fasta         Specify the annotation .GTF or .FASTA file  (file of protein coding transcripts .GTF or .FASTA file)

  Optional arguments:
      -g,--genome=genome.fa                 Genome file or directory with chr files (mandatory if input is .GTF) [ default undef ]
      -l,--lncRNAfile=file.gtf/.fasta       Specify a known set of lncRNA for training .GTF or .FASTA  [ default undef ]
      -b,--biotype                          Only consider transcripts having this(these) biotype(s) from the reference annotation (e.g : -b transcript_biotype=protein_coding,pseudogene) [default undef i.e all transcripts]
      -n,--numtx=undef                      Number of mRNA and lncRNA transcripts required for the training. mRNAs and lncRNAs numbers need to be separate by a ',': i.e. 1500,1000 for 1500 mRNAs and 1000 lncRNAs. For all the annotation, let it blank [ default undef, all the two annotations ]
      -r,--rfcut=[0-1]                      Random forest voting cutoff [ default undef i.e will compute best cutoff ]
      --spethres=undef                      Two specificity threshold based on the 10-fold cross-validation, first one for mRNA and the second for lncRNA, need to be in ]0,1[ on separated by a ','
      -k,--kmer=1,2,3,6,9,12                Kmer size list with size separate by ',' as string [ default "1,2,3,6,9,12" ], the maximum value for one size is '15'
      -o,--outname={INFILENAME}             Output filename [ default infile_name ]
      --outdir="feelnc_codpot_out/"         Output directory [ default "./feelnc_codpot_out/" ]
      -m,--mode                             The mode of the lncRNA sequences simulation if no lncRNA sequences have been provided. The mode can be:
                                                    'shuffle'   : make a permutation of mRNA sequences while preserving the 7mer count. Can be done on either FASTA and GTF input file;
                                                    'intergenic': extract intergenic sequences. Can be done *only* on GTF input file.
      -s,--sizeinter=0.75                   Ratio between mRNA sequence lengths and non coding intergenic region sequence lengths as, by default, ncInter = mRNA * 0.75
      --learnorftype=3                      Integer [0,1,2,3,4] to specify the type of longest ORF calculate [ default: 3 ] for learning data set.
                                            If the CDS is annotated in the .GTF, then the CDS is considered as the longest ORF, whatever the --orftype value.
                                                    '0': ORF with start and stop codon;
                                                    '1': same as '0' and ORF with only a start codon, take the longest;
                                                    '2': same as '1' but with a stop codon;
                                                    '3': same as '0' and ORF with a start or a stop, take the longest (see '1' and '2');
                                                    '4': same as '3' but if no ORF is found, take the input sequence as ORF.
      --testorftype=3                       Integer [0,1,2,3,4] to specify the type of longest ORF calculate [ default: 3 ] for test data set. See --learnortype description for more informations.
      --ntree                               Number of trees used in random forest [ default 500 ]
      --percentage=0.1                      Percentage of the training file use for the training of the kmer model. What remains will be used to train the random forest

  Debug arguments:
      --keeptmp=0                           To keep the temporary files in a 'tmp' directory the outdir, by default don't keep it (0 value). Any other value than 0 will keep the temporary files
      --verbosity=1                         Integer [0,1,2]: which level of information that need to be print [ default 1 ]. Note that that printing is made on STDERR
      --seed=1234                           Use to fixe the seed value for the extraction of intergenic DNA region to get lncRNA like sequences and for the random forest [ default 1234 ]

  Intergenic lncrna extraction:
            -to be added
```


## feelnc_FEELnc_classifier.pl

### Tool Description
Classifies lncRNAs based on their genomic context and overlap with protein-coding genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/feelnc:0.2--pl526_0
- **Homepage**: https://github.com/tderrien/FEELnc
- **Package**: https://anaconda.org/channels/bioconda/packages/feelnc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    FEELnc_classifier.pl -i lncRNA.gtf -a mRNA.gtf > lncRNA_classes.txt

Options:
  General:
      -b, --biotype         Print the biotype of each transcripts in the output
      -l,--log=file         Specify the name for the log file
      --help                Print this help
      --man                 Open man page
      -v,--verbosity        Level of verbosity

  Mandatory arguments:
      -i,--lncrna=file.gtf  Specify the lncRNA GTF file
      -a,--mrna=file.gtf    Specify the annotation GTF file (file of protein coding annotation)

  Filtering arguments:
      -w,--window=10000             Size of the window during the expansion process [default 10000 e.g. 10kb]
      -m,--maxwindow=100000         Size of the window around the lncRNA to compute interactions/classification [default e.g. 100kb]
```


## feelnc_FEELnc_pipeline.sh

### Tool Description
FEELnc pipeline for transcript model annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/feelnc:0.2--pl526_0
- **Homepage**: https://github.com/tderrien/FEELnc
- **Package**: https://anaconda.org/channels/bioconda/packages/feelnc/overview
- **Validation**: PASS

### Original Help Text
```text
Option --candidate is empty, it is mandatory
Exit
Usage: FEELnc_pipeline.sh --candidate=<TRANSCRIPT_MODEL_GTF> --reference=<REFERENCE_GTF> --genome=<GENOME_SEQUENCE_FASTA> --outname=<OUTPUT_NAME> --outdir=<OUTPUT_DIRECTORY>
These options are mandatories
```


## Metadata
- **Skill**: generated
