# fastga CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fastga_ALNchain | PASS |  |
| fastga_ALNplot | PASS | EPS dot plot on standard output is correct; the pdf option crashes visibly because the image has no epstopdf. |
| fastga_ALNreset | PASS |  |
| fastga_ALNshow | PASS |  |
| fastga_ALNtoPAF | PASS |  |
| fastga_ALNtoPSL | PASS |  |
| fastga_FAtoGDB | PASS |  |
| fastga_FastGA | PASS | PAF numbers match the Galaxy expected file apart from 0.1195 printed as .1195 by this version; PSL identical. |
| fastga_GDBshow | PASS |  |
| fastga_GDBstat | PASS |  |
| fastga_GDBtoFA | PASS |  |
| fastga_GIXcp | PASS |  |
| fastga_GIXmake | PASS |  |
| fastga_GIXmv | PASS |  |
| fastga_GIXrm | PASS |  |
| fastga_GIXshow | PASS |  |
| fastga_ONEview | PASS |  |
| fastga_PAFtoALN | PASS |  |
| fastga_PAFtoPSL | PASS |  |

## fastga_FAtoGDB

### Tool Description
Converts FASTA files to a 1GDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-08-06
- **GitHub**: https://github.com/thegenemyers/FASTGA
- **Stars**: N/A
### Original Help Text
```text
Usage: FAtoGDB [-v] [-L:<log:path>] [-n<int>] <source:path>[<fa_extn>|<1_extn>] [<target:path>[.1gdb]]

           <fa_extn> = (.fa|.fna|.fasta)[.gz]
           <1_extn>  = any valid 1-code sequence file type

       -n: Turn runs of n's of length < # into a's.
       -L: Output log to specified file.
```


## fastga_GIXmake

### Tool Description
Builds a GIX index for a given source file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: GIXmake [-v] [-L:<log:path>] [-T<int(8)>] [-P<dir($TMPDIR)>] [-k<int(40)] [-f<int(10)>]
               ( <source:path>[.1gdb]  |  <source:path>[<fa_extn>|<1_extn>] [<target:path>[.gix]] )

           <fa_extn> = (.fa|.fna|.fasta)[.gz]
           <1_extn>  = any valid 1-code sequence file type

      -v: Verbose mode, output statistics as proceed.
      -L: Output log to specified file.
      -T: Number of threads to use.
      -P: Directory to use for temporary files.

      -k: index k-mer size
      -f: adaptive seed count cutoff
```


## fastga_FastGA

### Tool Description
FastGA is a tool for aligning sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: FastGA [-vkMS] [-L:<log:path>] [-T<int(8)>] [-P<dir($TMPDIR)>] [<format(-paf)>]
              [-f<int(10)>] [-c<int(85)> [-s<int(1000)>] [-l<int(100)>] [-i<float(.7)]
              <source1:path>[<precursor>] [<source2:path>[<precursor>]]

         <format> = -paf[mxsS]* | -psl | -1:<align:path>[.1aln]

         <precursor> = .gix | .1gdb | <fa_extn> | <1_extn>

             <fa_extn> = (.fa|.fna|.fasta)[.gz]
             <1_extn>  = any valid 1-code sequence file type

      -v: Verbose mode, output statistics as proceed.
      -k: Keep any generated .1gdb's and .gix's.
      -M: Use soft mask information if available.
      -S: Use symmetric seeding (not recommended).
      -L: Output log to specified file.
      -T: Number of threads to use.
      -P: Directory to use for temporary files.

      -paf: Stream PAF output
        -pafx: Stream PAF output with CIGAR string with X's
        -pafm: Stream PAF output with CIGAR string with ='s
        -pafs: Stream PAF output with CS string in short form
        -pafS: Stream PAF output with CS string in long form
      -psl: Stream PSL output
      -1: Generate 1-code output to specified file

      -f: adaptive seed count cutoff
      -c: minimum seed chain coverage in both genomes
      -s: threshold for starting a new seed chain
      -l: minimum alignment length
      -i: minimum alignment identity
      -S: seed adaptamers from both genomes
```


## fastga_ALNtoPAF

### Tool Description
Convert ALN alignment files to PAF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ALNtoPAF [-mxsS] [-T<int(8)>] <alignment:path>[.1aln]

      -m: produce Cigar string tag with M's
      -x: produce Cigar string tag with X's and ='s
      -s: produce CS string tag in short form
      -S: produce CS string tag in long form

      -T: Use -T threads.
```


## fastga_ALNtoPSL

### Tool Description
Convert alignment file to PSL format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ALNtoPSL  [-T<int(8)>} <alignment:path>[.1aln]

      -T: Use -T threads.
```


## fastga_GIXrm

### Tool Description
Deletes GIX index files and optionally associated GDB files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: GIXrm [-vifg] <source:path>[.1gdb|.gix] ... 

      -v: Verbose mode, list what is being deleted.
      -i: prompt for each (stub) deletion
      -f: force operation quietly
      -g: Also delete the associated GDB.
```


## fastga_GIXcp

### Tool Description
Copies GIX database files, with options for verbosity, prompting, and overwriting.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: GIXcp [-vinfx] <source:path>[.1gdb|.gix] <target:path>[.1gdb|.gix]

      -v: Verbose mode, list what is being deleted.
      -i: prompt for each deletion
      -n: do not overwrite existing files.
      -f: force operation quietly
```


## fastga_GIXmv

### Tool Description
Move or rename GIX database files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: GIXmv [-vinfx] <source:path>[.1gdb|.gix] <target:path>[.1gdb|.gix]

      -v: Verbose mode, list what is being deleted.
      -i: prompt for each deletion
      -n: do not overwrite existing files.
      -f: force operation quietly
```


## fastga_ALNshow

### Tool Description
Show alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ALNshow [-arU] [-i<int(4)>] [-w<int(100)>] [-b<int(10)>] 
                   <alignments:path>[.1aln] [<selection>|<FILE> [<selection>|<FILE>]]

  <selection> = <range>[+-] [ , <range>[+-] ]*

     <range> = <object/position> [ - <object/position> ]  | @ | .

        <object/position> = @ <scaffold> [ . <contig>] [ : <position> ]
                          |                . <contig>  [ : <position> ]
                          |                                <position>

           <scaffold> = # | <int> | <identifier>
           <contig>   = # | <int>
           <position> = # | <int> [ . <int> ] [kMG]

      -a: Show the alignment of each LA with -w columns in each row.
      -r: Show the alignment of each LA with -w bp's of A in each row.

      -U: Show alignments in upper case.
      -i: Indent alignments by -i spaces.
      -w: Width of each row of alignment in symbols (-a) or bps (-r).
      -b: # of bordering bp.s to show on each side of LA.
```


## fastga_ALNplot

### Tool Description
Plots alignments from various formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ALNplot [-vSL] [-T<int(4)>] [-p[:<output:path>[.pdf]]]
               [-l<int(100)>] [-i<float(.7)>] [-n<int(100000)>]
               [-H<int(600)>] [-W<int>] [-f<int>] [-t<float>]
               <alignment:path>[.1aln|.paf[.gz]]> [<selection>|<FILE> [<selection>|<FILE>]]

  <selection> = <range>[+-] [ , <range>[+-] ]*

     <range> = <object/position> [ - <object/position> ]  | @ | .

        <object/position> = @ <scaffold> [ . <contig>] [ : <position> ]
                          |                . <contig>  [ : <position> ]
                          |                                <position>

           <scaffold> = # | <int> | <identifier>
           <contig>   = # | <int>
           <position> = # | <int> [ . <int> ] [kMG]

      -S: print sequence IDs as labels instead of names
      -L: do not print labels
      -T: use -T threads
      -p: make PDF output (requires '[e]ps[to|2]pdf')

      -l: minimum alignment length
      -i: minimum alignment identity
      -n: maximum number of lines to display (set '0' to force all)

      -H: image height
      -W: image width
      -f: label font size
      -t: line thickness
```


## fastga_ALNchain

### Tool Description
Chains the local alignments of a .1aln file into one-to-one global chains.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: ALNchain [-v] [-g<int(10000)>] [-l<int(10000)>] [-p<float(0.1)>] [-q<float(0.1)>]
                [-z<int(1000)>] [-s<int(10000)>] [-n<int(1)>] [-c<float(0.5)>] [-e<0.0>]
                [-f<int(1000)>] [-o<output:path>[.1aln]] <alignments:path>[.1aln]

      -g: maximum gap size
      -l: maximum overlap size
      -p: a gap of size G cost (-p)*G
      -q: an overlap of size O cost (-q)*O
      -z: score drop threshold for breaking a chain

      -s: minimum chain score
      -n: minimum number of alignment fragments in a chain
      -c: maximum coverage as a fraction of chain size
      -e: minimum extension as a fraction of sequence size
      -f: maximum gap for fuzzy merge

      -o: 1-code output file name
      -v: verbose mode
```

## fastga_ALNreset

### Tool Description
Resets the source genome paths stored in a .1aln alignment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: ALNreset [-T<int(8)>] <alignments:path>[.1aln]
                 <source1:path>[.1gdb|<fa_extn>|<1_extn>] [<source2:path>[.1gdb|<fa_extn>|<1_extn>]]

           <fa_extn> = (.fa|.fna|.fasta)[.gz]
           <1_extn>  = any valid 1-code sequence file type

      -T: Number of threads to use.
```

## fastga_GDBshow

### Tool Description
Shows the scaffolds and contigs of a genome database, or the sequence of a selection.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: GDBshow [-h] [-w<int(80)>] <source:path>[.1gdb] [ <selection>|<FILE> ]

  <selection> = <range>[+-] [ , <range>[+-] ]*

     <range> = <object/position> [ - <object/position> ]  | @ | .

        <object/position> = @ <scaffold> [ . <contig>] [ : <position> ]
                          |                . <contig>  [ : <position> ]
                          |                                <position>

           <scaffold> = # | <int> | <identifier>
           <contig>   = # | <int>
           <position> = # | <int> [ . <int> ] [kMG]

      -h: Show only the header lines.
      -w: Print -w bp per line (default is 80).
```

## fastga_GDBtoFA

### Tool Description
Converts a genome database back to a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: GDBtoFA [-v] [-w<int(80)>] <source:path>[.1gdb] [ @ | <target:path>[<fa_extn>|.1seq] ]

           <fa_extn> = (.fa|.fna|.fasta)[.gz]

      -w: Print -w bp per line (default is 80).
```

## fastga_GIXshow

### Tool Description
Shows k-mers and their positions stored in a genome index.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: GIXshow <source>[.gix] [ <address>[-<address>] ] 

          <address> = <int> | <dna:string>
```

## fastga_ONEview

### Tool Description
Shows a 1-code file (for example a .1aln alignment file) as readable text.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
ONEview [options] onefile
  -t --type <abc>           file type, e.g. seq, aln - required if no header
  -S --schema <schemafile>      schema file name for reading file
  -h --noHeader                 skip the header in ascii output
  -H --headerOnly               only write the header (in ascii)
  -s --writeSchema              write a schema file based on this file
  -b --binary                   write in binary (default is ascii)
  -o --output <filename>        output file name (default stdout)
  -i --index T x[-y](,x[-y])*   write specified objects/groups of type T
  -v --verbose                  write commentary including timing
index only works for binary files; '-i A 0-10' outputs first 10 objects of type A
```

## fastga_PAFtoALN

### Tool Description
Converts a PAF file with CIGAR strings to a .1aln alignment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: PAFtoALN [-T<int(8)>] <alignments:path>[.paf]
                 <source1:path>[.1gdb|<fa_extn>|<1_extn>] [<source2:path>[.1gdb|<fa_extn>|<1_extn>]]

           <fa_extn> = (.fa|.fna|.fasta)[.gz]
           <1_extn>  = any valid 1-code sequence file type

      -T: Number of threads to use.
```

## fastga_PAFtoPSL

### Tool Description
Converts a PAF file with CIGAR strings to PSL format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: PAFtoPSL [-T<int(8)>] [-C<str(cg:Z:)>] <alignments:path>[.paf]

      -T: Number of threads to use.
      -C: Cigar tag in the PAF file.
```

## fastga_GDBstat

### Tool Description
Shows statistics of a genome database.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
- **Homepage**: https://github.com/thegenemyers/FASTGA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: GDBstat [-h[<int>,<int>]] [-hlog] <source:path>[.1gdb]

      -h: Display histograms of scaffold & contig lengths.
            int's give bucket sizes for respective histograms if given.
```

## Metadata
- **Skill**: generated
