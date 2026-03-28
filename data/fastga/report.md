# fastga CWL Generation Report

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


## fastga_GDBstat

### Tool Description
Display histograms of scaffold & contig lengths.

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


## Metadata
- **Skill**: generated
