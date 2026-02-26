# spine CWL Generation Report

## spine_spine.pl

### Tool Description
This is a wrapper script to run the Spine algorithm

### Metadata
- **Docker Image**: quay.io/biocontainers/spine:0.3.2--pl526_0
- **Homepage**: https://github.com/egonozer/Spine
- **Package**: https://anaconda.org/channels/bioconda/packages/spine/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spine/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/egonozer/Spine
- **Stars**: N/A
### Original Help Text
```text
Spine (version 0.3.2);

This is a wrapper script to run the Spine algorithm

PREREQUISITES:
- Perl 5.10 or above
- MUMmer version 3.22 or above
- Mac OSX or Linux. No guarantees that this will work on Windows or other
  operating systems.

REQUIRED:
  -f or --file      file with list of input sequence files. Accepted file
                    formats include fasta sequence files, genbank sequence +
                    annotation files, or separate fasta sequence files with
                    corresponding gff3-formatted annotation files.
                    This file should be formatted like so:
                    
                    path/to/file1<tab>unique_identifier<tab>fasta or gbk or comb
                    path/to/file2<tab>unique_identifier<tab>fasta or gbk or comb
                    
                    Example:
                    /home/seqs/PAO1.fasta   PAO1    fasta
                    /home/seqs/LESB58.gbk   LESB58  gbk
                    /home/seqs/PA14.fasta,/home/seqs/PA14.gff3  PA14    comb
                    
                    The third column (fasta, gbk, or comb) is optional, but should
                    be given if your sequence files end with suffixes other
                    than ".fasta" or ".gbk" or if you are providing sequences
                    with gff3 annotation files, i.e. comb(ined).
                    
                    If you have genomes spread across multiple files (i.e.
                    chromosomes and/or plasmids), these can be combined by
                    either concatenating the files into one:
                    i.e. 'cat chrom_I.gbk chrom_II.gbk > combined.gbk'
                    or by including all the files in this input file,
                    separated by commmas:
                    Example:
                    /seqs/chrom_I.fasta,/seqs/chrom_II.fasta    mygenome    fasta
                    chrom_A.gbk,chrom_B.gbk,plasmid_X.gbk   myothergenome   gbk
                    seqA.fasta,seqB.fasta,seqA.gff3,seqB.gff3   genomeAB    comb
                    
                    IMPORTANT: When including multiple files for a strain or
                    joining multiple files within a strain, please ensure that
                    all chromosome/plasmid/contig IDs are unique across files
                    within a single genome. If sequence IDs are duplicated, the
                    results are likely to be wrong.
                    
OPTIONS:
  -a or --pctcore   percentage of input genomes in which a region must be
                    found in order to be considered core
                    (default: 100)
  -g or --maxdist   maximum distance between core genome segments. Distances
                    less than this between adjacent segments will result in
                    combination of fragments with N's rather than separating
                    into two or more fragments.
                    (default: 10)
  -l  or --license  print license information and quit
  -m  or --nucpath  full path to folder containing MUMmer scripts and
                    executables, i.e. /home/applications/MUMmer/bin
                    (default: tries to find MUMmer in your PATH)
  -r or --refs      reference genome sequence(s) to use as primary output
                    source(s). This should be one or more integers corresponding
                    to the order of the genomes given in the file above, i.e.
                    "1" would use the first-listed sequence, "3" would use
                    the third-listed, etc. To prioritize multiple genome
                    sequences, separate the integers with commas, i.e. "1,3"
                    for giving sequence 1 the highest priority and sequence 3
                    the next-highest priority.
                    Reference sequences will serve as the source of backbone
                    sequences to be output, as well as the source of backbone
                    locus IDs, if applicable.
                    The number of reference genomes used will depend on the
                    definition of core genome given by option -a. For instance,
                    if core is determined from 10 input genomes and -a is given
                    as 100, then core sequence will only be taken from one
                    reference genome. If, for example, -a is given as 90 from
                    10 input genomes, then potentially two reference sequences
                    will be needed: The first for sequences present in all 10
                    genomes and for sequences present in 9 out of 10 genomes
                    including the first genome. The second reference sequence
                    would then be used as the source of all sequences present
                    in 9 out of 10 genomes, but not present in the first
                    reference genome.
                    (default: reference priority will be the same as the order
                    of genomes entered, with the first genome having the highest
                    priority and the last genome having the lowest priority)
  --mini            produce only limited output, i.e. just the backbone sequence
                    derived from the reference genome(s). This saves time on
                    large data sets, especially if you only need the backbone
                    sequence to get accessory sequences from AGEnt.
                    (default: core and accessory sequence sets will be output
                    for all included genomes)
  --pangenome       produce a pangenome sequence and characteristics from
                    sequences in the order given. This option will be ignored
                    if '--mini' option is given.
                    (default: no pangenome information will be output)
  -o or --prefix    Output prefix
                    (default: "output")        
  -p or --pctid     minimum percent identity for regions to be considered
                    homologous
                    (default: 85) 
  -s or --minout    minimum size of sequences to be output, in bases
                    (default: 10)
  -t or --threads   Number of parallel processes to run. Careful: This script
                    does not perform any verification of the number of
                    processers available. If you set this number higher than
                    the number of processors you have, performance is likely to
                    be significantly degraded.
                    (default: 4)
  -v or --version   print version information and quit

** Nucmer Options **
Advanced use only. Little reason to change defaults in most situations. See
MUMmer documentation for more information.
  --breaklen        Integer (default: 200)
  --mincluster      Integer (default: 65)
  --diagdiff        Integer (default: 5)
  --diagfactor      Float (default: 0.12)
  --minmatch        Integer (default: 20)
  --nosimplify      (default: simplify)
```

