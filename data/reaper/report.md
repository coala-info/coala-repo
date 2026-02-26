# reaper CWL Generation Report

## reaper

### Tool Description
Reaper is a tool for processing sequencing reads, particularly for removing adapters and other unwanted sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/reaper:16.098--ha92aebf_2
- **Homepage**: https://www.ebi.ac.uk/~stijn/reaper/reaper.html
- **Package**: https://anaconda.org/channels/bioconda/packages/reaper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/reaper/overview
- **Total Downloads**: 7.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Required options
-geom <mode>   mode in {no-bc, 3p-bc, 5p-bc}
-meta <fname>  file with geometry-dependent format. Required columns:
   Geometry    Columns:
      no-bc          3p-ad     -       -      -    tabu
      3p-bc          3p-ad  barcode  3p-si    -    tabu
      5p-bc          3p-ad  barcode    -    5p-si  tabu
bc=barcode, ad=adaptor, si=sequence insert
Columns 3p-si, 5p-si, 3p-ad and tabu may all be empty
Alternatively, to express absence, a single hyphen may be used

Important options
-i <fname>        input stream (gzipped file allowed) (default STDIN)
-clean-length <int> minimum allowed clean length (default 0)
-guard <int>      protect first <int> bases in read from adapter and tabu matching
-restrict <int>   only use the first <int> bases of adapter or tabu sequence (default 18)
                  This is to avoid false positive matches
-tri <threshold>  filter out reads with tri-nt score > threshold
                  a reasonable <threshold> is 35
-qqq-check  <val>/<winlen>  cut sequence when median quality drops below <val>
-qqq-check  <val>/<winlen>/<winofs> as above, cut at <winofs> (default 0)
-qqq-check  <val>/<winlen>/<winofs>/<readofs> as above, start at <readofs>
-dust-suffix <threshold> dust theshold for read suffix (default 0, suggested 20)
-nnn-check <count>/<outof> (default 0/0)
      disregard read onwards from seeing <count> N's in <outof> bases

Alignment options
Options to specify when part of an alignment triggers a match:
-3p-global  l/e[/g[/o]]  (default 14/2/1/0)
-3p-prefix  l/e[/g[/o]]  (default 8/2/0/2)
-3p-barcode l/e[/g[/o]]  (default 0/6/1/0)
-5p-barcode l/e[/g[/o]]  (default 0/0/0/2)
-5p-sinsert l/e[/g[/o]]  (default 0/2/1/10)
-mr-tabu    l/e[/g[/o]]  (default 16/2/1/0)
-3p-head-to-tail l minimal trailing perfect match length (default 0)
   syntax used in the above:
      l  <int> minimum length required to count sub-alignment as match
      e  <int> maximum allowed edit distance
      g  <int> [optional, not active when set to 0] maximum allowed number of gaps
      o  <int> [optional, not active when set to 0] offset:
            o= 5  requires alignment to start in the first five bases of adaptor
            o=-5  requires alignment to end in the last five bases of adaptor
-swp M/S/G match/substitution/gap gain/cost/cost (default 4/1/3)

Input/output options
--fasta-in      read FASTA input
-record-format <format string> (record description, default @%I%A%n%R%n+%#%Q%n)
   [ -record-format syntax is output when supplying --record-format ]
-record-format2 <format string> (simple line formats, one field per line):
      R  read
      I  read identifier
      Q  quality scores
      D  discard field

-basename <pfx>   pfx.lint.gz, pfx.clean.gz pfx.report etc will be constructed
-format-clean <format string> (output for clean reads)
-format-lint <format string> (output for filtered reads)
   -format-clean/lint specification syntax:
      %R  read
      %C  clean read
      %Z  clean read padded with Ns if necessary
      %V  reverse complement of clean read
      %I  read identifier
      %Q  clean or input read quality (for clean / lint file respectively)
      %X  read count (only applicable if -record-format is used)
      %Y  input read quality
      %q<c>  clean input read quality padded with character <c>
      %A  annotation field
      %L  clean read length
      %M  message describing cause for filtering (lint file)
      %T  trinucleotide complexity score (clean/lint file)
      %U  dUst sUffix complexity information
      %3  best read/3p-adaptor alignment
      %=  alignment characteristics
            mt=matchtype
            sc=suffix-complexity
            ht=head-tail-match
            nn=N-match-offset
            bb=B-match-offset
            aa=Polya-offset
            qq=Quality-trim-offset
      %n  newline
      %J  record offset, unique for each read. Use to match paired-end reads
      %f  fastq line number based on standard fastq format
      %t  tab
      %%  percent sign
   Anything else is copied verbatim
-debug [acl]+     a=alignments c=clean l=lint
-sample c/l       if debug, sample every c/l clean/lint read
--nozip           do not output gzipped files
--noqc            do not output quality report files

Miscellaneous options
--bcq-early       perform early 'B' quality filtering (when reading sequences)
--bcq-late        perform late 'B' quality filtering (before outputting sequences)
--full-length     only allow reads not shortened in any filter step
--keep-all        delete rather than discard reads (e.g. tabu match, missing 5p-sinsert)
-trim-length <int>     cut reads back to length <int>
-polya <int>      remove trailing A's if length exceeds <int>
-sc-max <f>       threshold for complexity of suffix following prefix match (default 0.25)

Options for use when running reaper with -geom no-bc
-3pa <three prime adaptor>
-5psi <five prime sequence insert>
-tabu <tabu sequence>
```


## Metadata
- **Skill**: generated
