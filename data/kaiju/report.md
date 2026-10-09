# kaiju CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kaiju_kaiju | PASS |  |
| kaiju_kaiju-addTaxonNames | PASS |  |
| kaiju_kaiju-convertNR | PASS | synthetic data: real RefSeq proteins with a planted accession-to-taxon table; all 12 records converted with the taxon ID |
| kaiju_kaiju-convertRefSeq | PASS | synthetic data: real WP_ RefSeq proteins with a planted accession-to-taxon table; all 5 records converted with the taxon ID |
| kaiju_kaiju-gbk2faa | PASS |  |
| kaiju_kaiju-mergeOutputs | PASS |  |
| kaiju_kaiju-mkbwt | PASS |  |
| kaiju_kaiju-mkfmi | PASS |  |
| kaiju_kaiju-multi | PASS |  |
| kaiju_kaiju2krona | PASS |  |
| kaiju_kaiju2table | PASS |  |
| kaiju_kaijup | PASS |  |
| kaiju_kaijux | PASS |  |

## kaiju_kaiju-addTaxonNames

### Tool Description
Add taxon names (or full taxon paths) to a kaiju output file.

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   kaiju-addTaxonNames -t nodes.dmp -n names.dmp -i kaiju.out -o kaiju-names.out

Mandatory arguments:
   -i FILENAME   Name of input file
   -o FILENAME   Name of output file. If not specified, output will be printed to STDOUT.
   -t FILENAME   Name of nodes.dmp file
   -n FILENAME   Name of names.dmp file.

Optional arguments:
   -u            Unclassified reads are not contained in the output.
   -p            Print full taxon path.
   -r            Print taxon path containing only ranks specified by a comma-separated list,
                 for example: superkingdom,phylum,class,order,family,genus,species
   -v            Enable verbose output.
```

## kaiju_kaiju-convertRefSeq

### Tool Description
Convert RefSeq protein FASTA records into the FASTA format used to build a kaiju database.

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   kaiju-convertRefSeq -t nodes.dmp -m merged.dmp -g prot.accession2taxid 
Mandatory arguments:
   -t FILENAME   Name of nodes.dmp file.
   -m FILENAME   Name of merged.dmp file.
   -g FILENAME   Name of prot.accession2taxid.FULL.gz file.
   -o FILENAME   Name of output file.
Optional arguments:
   -a            Prefix taxon ID with the accession number.
   -v            Verbose mode
   -d            Debug mode
```

## kaiju_kaiju

### Tool Description
Taxonomic classification of metagenomic reads (DNA or protein) by matches to a protein database (.fmi).

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   kaiju -t nodes.dmp -f kaiju_db.fmi -i reads.fastq [-j reads2.fastq]

Mandatory arguments:
   -t FILENAME   Name of nodes.dmp file
   -f FILENAME   Name of database (.fmi) file
   -i FILENAME   Name of input file containing reads in FASTA or FASTQ format

Optional arguments:
   -j FILENAME   Name of second input file for paired-end reads
   -o FILENAME   Name of output file. If not specified, output will be printed to STDOUT
   -z INT        Number of parallel threads for classification (default: 1)
   -a STRING     Run mode, either "mem"  or "greedy" (default: greedy)
   -e INT        Number of mismatches allowed in Greedy mode (default: 3)
   -m INT        Minimum match length (default: 11)
   -s INT        Minimum match score in Greedy mode (default: 65)
   -E FLOAT      Minimum E-value in Greedy mode (default: 0.01)
   -x            Enable SEG low complexity filter (enabled by default)
   -X            Disable SEG low complexity filter
   -p            Input sequences are protein sequences
   -v            Enable verbose output
```

## kaiju_kaiju-mkbwt

### Tool Description
Calculate the BWT and suffix array of a protein FASTA file (first step to build a kaiju database).

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
---
mkbwt takes a fasta file as argument and calculates the BWT.
Output file name given with -o (defaults to the input file name)

Example cmd line
   mkbwt -a DNA -o outputname infilename.fsa
or for proteins (default alphabet)
   mkbwt -o outputname infilename.fsa
or for some other alphabet
   mkbwt -a abcdefgHIJK -o outputname infilename.fsa

It can also take sequences on stdin, in which case you have to give
the filesize in millions of letters (rounded up), e.g. -l 3000
corresponding to 3 billion letters.

Files are created with outputname followed by various extensions

See options below
---

Options and arguments:

ARG 1, -infilename (string)
      Name of an input file (stdin if no file is given, in which case you
      need to give length)
      Value:  NULL (null)

-outfilename, -o (string)
      Name of output. Several files with different extensions are produced
      (if not given, input file name is used).
      Value:  NULL (null)

-Alphabet, -a (string)
      Alphabet used. Must end with the sequence terminator. Instead of alphabet
      you can specify DNA, RNA or protein, in which case the alphabet is ACGT,
      ACGU, or ACDEFGHIKLMNPQRSTVWYX
      Value:  protein

-nThreads, -n (integer)
      Number of threads
      Value:  2

-length, -l (double)
      Length of concatenated sequence in millions (one decimal, round up).
      Used when reading from stdin. If file name is given, length is estimated
      from file size and length needs not be specified.
      Value:  0.000000

-checkpoint, -e (integer)
      Exponent for suffix array checkpoints. There is a checkpoint for every
      2^e points. Value around 5 is a good compromise between speed and space.
      Value:  5

-caseSens, -c
      The sequence is read case sensitive
      Value: OFF

-revComp, -r
      Reverse complement sequence. Works only for DNA.
      Value: OFF

-term, -t (string)
      Terminating symbol (only used for debugging)
      Value:  *

-revsort, -s
      The termination symbols sorts as reverse sequences. This will make the
      BWT more compressible.
      Value: OFF

-help, -h
      Prints summary of options and arguments
      Value: ON
```

## kaiju_kaiju2table

### Tool Description
Summarize kaiju outputs as a table of read counts per taxon at a chosen rank.

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   kaiju2table -t nodes.dmp -n names.dmp -r species -o kaiju.table input1.tsv [input2.tsv ...]

Mandatory arguments:
   -o FILENAME   Name of output file.
   -t FILENAME   Name of nodes.dmp file
   -n FILENAME   Name of names.dmp file.
   -r STRING     Taxonomic rank, must be one of: phylum, class, order, family, genus, species

Optional arguments:
   -m FLOAT      Number in [0, 100], denoting the minimum required percentage for the taxon (except viruses) to be reported (default: 0.0)
   -c INT        Integer number > 0, denoting the minimum required number of reads for the taxon (except viruses) to be reported (default: 0)
   -e            Expand viruses, which are always shown as full taxon path and read counts are not summarized in higher taxonomic levels.
   -u            Unclassified reads are not counted for the total reads when calculating percentages for classified reads.
   -p            Print full taxon path.
   -l            Print taxon path containing only ranks specified by a comma-separated list,
                 for example: superkingdom,phylum,class,order,family,genus,species
   -v            Enable verbose output.

Only one of the options -m and -c may be used at a time.
```

## kaiju_kaiju-multi

### Tool Description
Run kaiju on several samples at once, loading the database only once.

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   kaiju-multi -t nodes.dmp -f kaiju_db.fmi -i sample1_R1.fastq,sample2_R1.fastq [-j sample1_R2.fastq,sample2_R2.fastq] -o sample1.out,sample2.out

Mandatory arguments:
   -t FILENAME   Name of nodes.dmp file
   -f FILENAME   Name of database (.fmi) file
   -i FILENAME   List of input files containing reads in FASTA or FASTQ format
   -o FILENAME   List of output files 

Optional arguments:
   -j FILENAME   List of secondary input files for paired-end reads
   -z INT        Number of parallel threads for classification (default: 1)
   -a STRING     Run mode, either "mem"  or "greedy" (default: greedy)
   -e INT        Number of mismatches allowed in Greedy mode (default: 3)
   -m INT        Minimum match length (default: 11)
   -s INT        Minimum match score in Greedy mode (default: 65)
   -E FLOAT      Minimum E-value in Greedy mode
   -x            Enable SEG low complexity filter (enabled by default)
   -X            Disable SEG low complexity filter
   -p            Input sequences are protein sequences
   -v            Enable verbose output
```

## kaiju_kaiju-mergeOutputs

### Tool Description
Merge two kaiju outputs into one classification, resolving conflicts per read.

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   kaiju-mergeOutputs -i in1.tsv -j in2.tsv [-o outfile.tsv] [-c 1|2|lca|lowest] [-s] [-t nodes.dmp] [-v] [-d]

Mandatory arguments:
   -i FILENAME   Name of first input file
   -j FILENAME   Name of second input file

Optional arguments:
   -o FILENAME   Name of output file.
   -c STRING     Conflict resolution mode, must be 1, 2,  lca, or lowest (default: lca)
   -t FILENAME   Name of nodes.dmp file, only required when -c is set to lca
   -s            Use 4th column with classification score to give precedence to taxon with better score.
   -v            Enable verbose output, which will print a summary in the end.
   -d            Enable debug output.

NOTE: Both input files need to be sorted by the read name in the second column.

The option -c determines the method of resolving conflicts in the taxonomic assignment for a read.
Possible values are '1', '2', 'lca', 'lowest':
  '1' -> the taxon id from the first input file is used.
  '2' -> the taxon id from the second input file is used.
  'lca' -> the least common ancestor of the two taxon ids from both input files is used.
  'lowest' -> the lower rank of the two taxa is used if they are within the same lineage. Otherwise the LCA is used.
When using values 'lca' or 'lowest', the path to the file nodes.dmp needs to be specified via option -t.
```

## kaiju_kaiju-mkfmi

### Tool Description
Calculate the FM index from the BWT and write the kaiju database (.fmi) file.

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
---
mkfmi is run after mkbwt

mkfmi takes a BWT and calculates the FM index and collects the files
containing the bwt, suffix array and FMI into one file.

Example cmd line
   mkfmi <filename>

It will look for <filename>.bwt and <filename>.sa
Output in <filename>.bwt (SA and FMI appended to this file)


After the program has been run, <filename>.sa can be deleted

See options below
---

Options and arguments:

ARG 1, -filenm (string)
      Name of index files. Mandatory
      Value:  NULL (null)

-removecmd, -r (string)
      Command for deleting .bwt and .sa files (e.g. rm)
      Value:  NULL (null)

-help, -h
      Prints summary of options and arguments
      Value: ON
```

## kaiju_kaiju-convertNR

### Tool Description
Convert an NCBI NR protein FASTA file into the FASTA format used to build a kaiju database.

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   kaiju-convertNR -t nodes.dmp -m merged.dmp -g prot.accession2taxid [-i nr]
Mandatory arguments:
   -t FILENAME   Name of nodes.dmp file.
   -m FILENAME   Name of merged.dmp file.
   -g FILENAME   Name of prot.accession2taxid file.
   -o FILENAME   Name of output file.
Optional arguments:
   -a            Prefix taxon ID in database names with the first accession number per record.
   -i FILENAME   Name of NR file. If this option is not used, then the program will read from STDIN.
   -l FILENAME   Name of file with taxon IDs. Only records having one of these IDs as ancestor in the taxonomy will be used.
   -e FILENAME   Name of file with accession numbers that will be excluded.
```

## kaiju_kaijux

### Tool Description
Match translated reads to a protein database (.fmi) and report the matching database sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   kaijux -f proteins.fmi -i reads.fastq [-j reads2.fastq]

Mandatory arguments:
   -f FILENAME   Name of database file (.fmi) file
   -i FILENAME   Name of input file containing reads in FASTA or FASTQ format

Optional arguments:
   -j FILENAME   Name of second input file for paired-end reads
   -o FILENAME   Name of output file. If not specified, output will be printed to STDOUT
   -z INT        Number of parallel threads for classification (default: 1)
   -a STRING     Run mode, either "mem"  or "greedy" (default: greedy)
   -e INT        Number of mismatches allowed in Greedy mode (default: 3)
   -m INT        Minimum match length (default: 11)
   -s INT        Minimum match score in Greedy mode (default: 65)
   -E FLOAT      Minimum E-value in Greedy mode (default: 0.01)
   -x            Enable SEG low complexity filter (enabled by default)
   -X            Disable SEG low complexity filter
   -v            Enable verbose output.
```

## kaiju_kaijup

### Tool Description
Match protein sequences to a protein database (.fmi) without taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   kaijup -f proteins.fmi -i reads.fastq

Mandatory arguments:
   -f FILENAME   Name of database file (.fmi) file
   -i FILENAME   Name of input file containing reads in FASTA or FASTQ format

Optional arguments:
   -o FILENAME   Name of output file. If not specified, output will be printed to STDOUT
   -z INT        Number of parallel threads for classification (default: 1)
   -a STRING     Run mode, either "mem"  or "greedy" (default: greedy)
   -e INT        Number of mismatches allowed in Greedy mode (default: 3)
   -m INT        Minimum match length (default: 11)
   -s INT        Minimum match score in Greedy mode (default: 65)
   -E FLOAT      Minimum E-value in Greedy mode (default: 0.01)
   -x            Enable SEG low complexity filter (enabled by default)
   -X            Disable SEG low complexity filter
   -v            Enable verbose output.
```

## kaiju_kaiju-gbk2faa

### Tool Description
Extract protein sequences from a GenBank file into a FASTA file for building a kaiju database.

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kaiju-gbk2faa.pl infile.gbk outfile.faa
Extracts all amino acid sequences from the /translation fields into a FASTA file; the header holds the protein ID and the taxon ID from /db_xref="taxon:<ID>".
```

## Metadata
- **Skill**: generated

## kaiju_kaiju2krona

### Tool Description
Convert Kaiju output to Krona format

### Metadata
- **Docker Image**: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
- **Homepage**: https://github.com/bioinformatics-centre/kaiju
- **Package**: https://anaconda.org/channels/bioconda/packages/kaiju/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Error: Please specify the name of the output file, using the -o option.

Kaiju 1.10.1
Copyright 2015-2023 Peter Menzel, Anders Krogh
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

Usage:
   /usr/local/bin/kaiju2krona -t nodes.dmp -n names.dmp -i kaiju.out -o kaiju2krona.out

Mandatory arguments:
   -i FILENAME   Name of input file
   -o FILENAME   Name of output file.
   -t FILENAME   Name of nodes.dmp file
   -n FILENAME   Name of names.dmp file

Optional arguments:
   -l            Print taxon path containing only ranks specified by a comma-separated list,
                 for example: superkingdom,phylum,class,order,family,genus,species
   -u            Include count for unclassified reads in output.
   -v            Enable verbose output.
```
