# mashtree CWL Generation Report

## mashtree

### Tool Description
use distances from Mash (min-hash algorithm) to make a NJ tree

### Metadata
- **Docker Image**: quay.io/biocontainers/mashtree:1.4.6--pl5321h7b50bb2_3
- **Homepage**: https://github.com/lskatz/mashtree
- **Package**: https://anaconda.org/channels/bioconda/packages/mashtree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mashtree/overview
- **Total Downloads**: 97.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lskatz/mashtree
- **Stars**: N/A
### Original Help Text
```text
mashtree: main::main: need more arguments
mashtree: use distances from Mash (min-hash algorithm) to make a NJ tree
  Usage: mashtree [options] *.fastq *.fasta *.gbk *.msh > tree.dnd
  NOTE: fastq files are read as raw reads;
        fasta, gbk, and embl files are read as assemblies;
        Input files can be gzipped.
  --tempdir            ''   If specified, this directory will not be
                            removed at the end of the script and can
                            be used to cache results for future
                            analyses.
                            If not specified, a dir will be made for you
                            and then deleted at the end of this script.
  --numcpus            1    This script uses Perl threads.
  --outmatrix          ''   If specified, will write a distance matrix
                            in tab-delimited format
  --file-of-files           If specified, mashtree will try to read 
                            filenames from each input file. The file of
                            files format is one filename per line. This
                            file of files cannot be compressed.
  --outtree                 If specified, the tree will be written to 
                            this file and not to stdout. Log messages
                            will still go to stderr.
  --version                 Display the version and exit
  --citation                Display the preferred citation and exit

  TREE OPTIONS
  --truncLength        250  How many characters to keep in a filename
  --sigfigs            10   How many decimal places to use in mash distances 
  --sort-order         ABC  For neighbor-joining, the sort order can
                            make a difference. Options include:
                            ABC (alphabetical), random, input-order

  MASH SKETCH OPTIONS
  --genomesize         5000000
  --mindepth           5    If mindepth is zero, then it will be
                            chosen in a smart but slower method,
                            to discard lower-abundance kmers.
  --kmerlength         21
  --sketch-size        10000
  --seed               42   Seed for mash sketch
  --save-sketches      ''   If a directory is supplied, then sketches
                            will be saved in it.
                            If no directory is supplied, then sketches
                            will be saved alongside source files.
   
Stopped at /usr/local/bin/mashtree line 75.
```

