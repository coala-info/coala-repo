# fasta3 CWL Generation Report

## fasta3_fasta36

### Tool Description
FASTA searches a protein or DNA sequence data bank

### Metadata
- **Docker Image**: quay.io/biocontainers/fasta3:36.3.8--0
- **Homepage**: http://faculty.virginia.edu/wrpearson/fasta
- **Package**: https://anaconda.org/channels/bioconda/packages/fasta3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fasta3/overview
- **Total Downloads**: 41.5K
- **Last updated**: 2025-09-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
USAGE
 fasta36 [-options] query_file library_file [ktup]
 "@" query_file uses stdin; query_file:begin-end sets subset range
 library file formats: 0:FASTA; 1:GenBankFF; 3:EMBL_FF; 7:FASTQ; 10:subset; 12:NCBI blastdbcmd;
   alternate library formats: "library_file 7" for 7:FASTQ

DESCRIPTION
 FASTA searches a protein or DNA sequence data bank
 version: 36.3.8 Jul, 2015

OPTIONS (options must preceed query_file library_file)
 -3   compare forward strand only
 -a   show complete Query/Sbjct sequences in alignment
 -A   Smith-Waterman for final DNA alignment, band alignment for protein
      default is band-alignment for DNA, Smith-Waterman for protein
 -b:  high scores reported (limited by -E by default);
      =<int> forces <int> results;
 -c:  expected fraction for band-optimization, joining
 -C:  length of the query/sbjct name in alignments
 -d:  number of alignments shown (limited by -E by default)
 -D   enable debugging output
 -e:  expand_script to extend hits
 -E:  E()-value,E()-repeat threshold
 -f:  gap-open penalty
 -F:  min E()-value displayed
 -g:  gap-extension penalty
 -h   help - show options, arguments
 -H   show histogram
 -i   search with reverse-complement
 -I   interactive mode
 -k:  number of shuffles
 -l:  FASTLIBS abbreviation file
 -L   long library descriptions
 -m:  Output/alignment format;
      0 - standard ":. " alignment; 1 - " xX"; 2 - ".MS.."; 3 - separate >fasta entries;
      4 - "---" alignment map; 5 - 0+4; 6 - <html>;
      8 - BLAST tabular; 8C commented BLAST tabular;
      B - BLAST Query/Sbjct alignments; BB - complete BLAST output;
      9 - FASTA tabular; 9c - FASTA tabular encoded; 9C FASTA tabular CIGAR encoded;
     10 - parseable key:value; 11 - lav for LALIGN;
      A - aligned residue score
      F - 'F0,6,9c out_file' - alternate output formats to files;
 -M:  filter on library sequence length
 -n   DNA/RNA query
 -N:  max library length before overlapping
 -o:  offset coordinates of query/subject
 -O:  write results to file
 -p   protein query
 -q   quiet [default] -- do not prompt
 -Q   quiet [default] -- do not prompt
 -r:  [+0/0]  +match/-mismatch for DNA/RNA
 -R:  raw score file
 -s:  Scoring matrix: (protein)
      BL50, BP62 (sets -f -11 -g -1); P250, OPT5, VT200,
      VT160, P120, VT120, BL80, VT80, MD40, VT40, MD20, VT20, MD10, VT10;
      scoring matrix file name; -s ?BL50 adjusts matrix for short queries;
 -S   filter lowercase (seg) residues
 -T:  max threads/workers
 -U   RNA query
 -v:  shuffle window size
 -V:  annotation characters in query/library for aligments
 -w:  width of alignment display
 -W:  alignment context length (surrounding unaligned sequence)
 -X:  Extended options
 -z:  Statistics estimation method:
      1 - regression; -1 - no stats.; 0 - no scaling; 2 - Maximum Likelihood Est.;
      3 - Altschul/Gish; 4 - iter. regress.; 5 - regress w/variance;
      6 - MLE with comp. adj.;
     11 - 16 - estimates from shuffled library sequences;
     21 - 26 - E2()-stats from shuffled high-scoring sequences;
 -Z:  [library entries] database size for E()-value
```


## fasta3_ssearch36

### Tool Description
SSEARCH performs a Smith-Waterman search

### Metadata
- **Docker Image**: quay.io/biocontainers/fasta3:36.3.8--0
- **Homepage**: http://faculty.virginia.edu/wrpearson/fasta
- **Package**: https://anaconda.org/channels/bioconda/packages/fasta3/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
 ssearch36 [-options] query_file library_file
 "@" query_file uses stdin; query_file:begin-end sets subset range
 library file formats: 0:FASTA; 1:GenBankFF; 3:EMBL_FF; 7:FASTQ; 10:subset; 12:NCBI blastdbcmd;
   alternate library formats: "library_file 7" for 7:FASTQ

DESCRIPTION
 SSEARCH performs a Smith-Waterman search
 version: 36.3.8 Jul, 2015

OPTIONS (options must preceed query_file library_file)
 -3   compare forward strand only
 -a   show complete Query/Sbjct sequences in alignment
 -b:  high scores reported (limited by -E by default);
      =<int> forces <int> results;
 -C:  length of the query/sbjct name in alignments
 -d:  number of alignments shown (limited by -E by default)
 -D   enable debugging output
 -e:  expand_script to extend hits
 -E:  E()-value,E()-repeat threshold
 -f:  gap-open penalty
 -F:  min E()-value displayed
 -g:  gap-extension penalty
 -h   help - show options, arguments
 -H   show histogram
 -i   search with reverse-complement
 -I   interactive mode
 -k:  number of shuffles
 -l:  FASTLIBS abbreviation file
 -L   long library descriptions
 -m:  Output/alignment format;
      0 - standard ":. " alignment; 1 - " xX"; 2 - ".MS.."; 3 - separate >fasta entries;
      4 - "---" alignment map; 5 - 0+4; 6 - <html>;
      8 - BLAST tabular; 8C commented BLAST tabular;
      B - BLAST Query/Sbjct alignments; BB - complete BLAST output;
      9 - FASTA tabular; 9c - FASTA tabular encoded; 9C FASTA tabular CIGAR encoded;
     10 - parseable key:value; 11 - lav for LALIGN;
      A - aligned residue score
      F - 'F0,6,9c out_file' - alternate output formats to files;
 -M:  filter on library sequence length
 -n   DNA/RNA query
 -N:  max library length before overlapping
 -o:  offset coordinates of query/subject
 -O:  write results to file
 -p   protein query
 -P:  PSSM file
 -q   quiet [default] -- do not prompt
 -Q   quiet [default] -- do not prompt
 -r:  [+0/0]  +match/-mismatch for DNA/RNA
 -R:  raw score file
 -s:  Scoring matrix: (protein)
      BL50, BP62 (sets -f -11 -g -1); P250, OPT5, VT200,
      VT160, P120, VT120, BL80, VT80, MD40, VT40, MD20, VT20, MD10, VT10;
      scoring matrix file name; -s ?BL50 adjusts matrix for short queries;
 -S   filter lowercase (seg) residues
 -T:  max threads/workers
 -U   RNA query
 -v:  shuffle window size
 -V:  annotation characters in query/library for aligments
 -w:  width of alignment display
 -W:  alignment context length (surrounding unaligned sequence)
 -X:  Extended options
 -z:  Statistics estimation method:
      1 - regression; -1 - no stats.; 0 - no scaling; 2 - Maximum Likelihood Est.;
      3 - Altschul/Gish; 4 - iter. regress.; 5 - regress w/variance;
      6 - MLE with comp. adj.;
     11 - 16 - estimates from shuffled library sequences;
     21 - 26 - E2()-stats from shuffled high-scoring sequences;
 -Z:  [library entries] database size for E()-value
```


## fasta3_ggsearch36

### Tool Description
GGSEARCH performs a global/global database searches

### Metadata
- **Docker Image**: quay.io/biocontainers/fasta3:36.3.8--0
- **Homepage**: http://faculty.virginia.edu/wrpearson/fasta
- **Package**: https://anaconda.org/channels/bioconda/packages/fasta3/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
 ggsearch36 [-options] query_file library_file
 "@" query_file uses stdin; query_file:begin-end sets subset range
 library file formats: 0:FASTA; 1:GenBankFF; 3:EMBL_FF; 7:FASTQ; 10:subset; 12:NCBI blastdbcmd;
   alternate library formats: "library_file 7" for 7:FASTQ

DESCRIPTION
 GGSEARCH performs a global/global database searches
 version: 36.3.8 Jul, 2015

OPTIONS (options must preceed query_file library_file)
 -3   compare forward strand only
 -b:  high scores reported (limited by -E by default);
      =<int> forces <int> results;
 -C:  length of the query/sbjct name in alignments
 -d:  number of alignments shown (limited by -E by default)
 -D   enable debugging output
 -e:  expand_script to extend hits
 -E:  E()-value,E()-repeat threshold
 -f:  gap-open penalty
 -F:  min E()-value displayed
 -g:  gap-extension penalty
 -h   help - show options, arguments
 -H   show histogram
 -i   search with reverse-complement
 -I   interactive mode
 -k:  number of shuffles
 -l:  FASTLIBS abbreviation file
 -L   long library descriptions
 -m:  Output/alignment format;
      0 - standard ":. " alignment; 1 - " xX"; 2 - ".MS.."; 3 - separate >fasta entries;
      4 - "---" alignment map; 5 - 0+4; 6 - <html>;
      8 - BLAST tabular; 8C commented BLAST tabular;
      B - BLAST Query/Sbjct alignments; BB - complete BLAST output;
      9 - FASTA tabular; 9c - FASTA tabular encoded; 9C FASTA tabular CIGAR encoded;
     10 - parseable key:value; 11 - lav for LALIGN;
      A - aligned residue score
      F - 'F0,6,9c out_file' - alternate output formats to files;
 -M:  filter on library sequence length
 -n   DNA/RNA query
 -N:  max library length before overlapping
 -o:  offset coordinates of query/subject
 -O:  write results to file
 -p   protein query
 -P:  PSSM file
 -q   quiet [default] -- do not prompt
 -Q   quiet [default] -- do not prompt
 -r:  [+0/0]  +match/-mismatch for DNA/RNA
 -R:  raw score file
 -s:  Scoring matrix: (protein)
      BL50, BP62 (sets -f -11 -g -1); P250, OPT5, VT200,
      VT160, P120, VT120, BL80, VT80, MD40, VT40, MD20, VT20, MD10, VT10;
      scoring matrix file name; -s ?BL50 adjusts matrix for short queries;
 -S   filter lowercase (seg) residues
 -T:  max threads/workers
 -U   RNA query
 -v:  shuffle window size
 -V:  annotation characters in query/library for aligments
 -w:  width of alignment display
 -X:  Extended options
 -z:  Statistics estimation method:
      1 - regression; -1 - no stats.; 0 - no scaling; 2 - Maximum Likelihood Est.;
      3 - Altschul/Gish; 4 - iter. regress.; 5 - regress w/variance;
      6 - MLE with comp. adj.;
     11 - 16 - estimates from shuffled library sequences;
     21 - 26 - E2()-stats from shuffled high-scoring sequences;
 -Z:  [library entries] database size for E()-value
```


## fasta3_glsearch36

### Tool Description
GLSEARCH performs a global-query/local-library search

### Metadata
- **Docker Image**: quay.io/biocontainers/fasta3:36.3.8--0
- **Homepage**: http://faculty.virginia.edu/wrpearson/fasta
- **Package**: https://anaconda.org/channels/bioconda/packages/fasta3/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
 glsearch36 [-options] query_file library_file
 "@" query_file uses stdin; query_file:begin-end sets subset range
 library file formats: 0:FASTA; 1:GenBankFF; 3:EMBL_FF; 7:FASTQ; 10:subset; 12:NCBI blastdbcmd;
   alternate library formats: "library_file 7" for 7:FASTQ

DESCRIPTION
 GLSEARCH performs a global-query/local-library search
 version: 36.3.8 Jul, 2015

OPTIONS (options must preceed query_file library_file)
 -3   compare forward strand only
 -b:  high scores reported (limited by -E by default);
      =<int> forces <int> results;
 -C:  length of the query/sbjct name in alignments
 -d:  number of alignments shown (limited by -E by default)
 -D   enable debugging output
 -e:  expand_script to extend hits
 -E:  E()-value,E()-repeat threshold
 -f:  gap-open penalty
 -F:  min E()-value displayed
 -g:  gap-extension penalty
 -h   help - show options, arguments
 -H   show histogram
 -i   search with reverse-complement
 -I   interactive mode
 -k:  number of shuffles
 -l:  FASTLIBS abbreviation file
 -L   long library descriptions
 -m:  Output/alignment format;
      0 - standard ":. " alignment; 1 - " xX"; 2 - ".MS.."; 3 - separate >fasta entries;
      4 - "---" alignment map; 5 - 0+4; 6 - <html>;
      8 - BLAST tabular; 8C commented BLAST tabular;
      B - BLAST Query/Sbjct alignments; BB - complete BLAST output;
      9 - FASTA tabular; 9c - FASTA tabular encoded; 9C FASTA tabular CIGAR encoded;
     10 - parseable key:value; 11 - lav for LALIGN;
      A - aligned residue score
      F - 'F0,6,9c out_file' - alternate output formats to files;
 -M:  filter on library sequence length
 -n   DNA/RNA query
 -N:  max library length before overlapping
 -o:  offset coordinates of query/subject
 -O:  write results to file
 -p   protein query
 -P:  PSSM file
 -q   quiet [default] -- do not prompt
 -Q   quiet [default] -- do not prompt
 -r:  [+0/0]  +match/-mismatch for DNA/RNA
 -R:  raw score file
 -s:  Scoring matrix: (protein)
      BL50, BP62 (sets -f -11 -g -1); P250, OPT5, VT200,
      VT160, P120, VT120, BL80, VT80, MD40, VT40, MD20, VT20, MD10, VT10;
      scoring matrix file name; -s ?BL50 adjusts matrix for short queries;
 -S   filter lowercase (seg) residues
 -T:  max threads/workers
 -U   RNA query
 -v:  shuffle window size
 -V:  annotation characters in query/library for aligments
 -w:  width of alignment display
 -X:  Extended options
 -z:  Statistics estimation method:
      1 - regression; -1 - no stats.; 0 - no scaling; 2 - Maximum Likelihood Est.;
      3 - Altschul/Gish; 4 - iter. regress.; 5 - regress w/variance;
      6 - MLE with comp. adj.;
     11 - 16 - estimates from shuffled library sequences;
     21 - 26 - E2()-stats from shuffled high-scoring sequences;
 -Z:  [library entries] database size for E()-value
```


## fasta3_tfastx36

### Tool Description
TFASTX compares a protein to a translated DNA data bank

### Metadata
- **Docker Image**: quay.io/biocontainers/fasta3:36.3.8--0
- **Homepage**: http://faculty.virginia.edu/wrpearson/fasta
- **Package**: https://anaconda.org/channels/bioconda/packages/fasta3/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
 tfastx36 [-options] query_file library_file [ktup]
 "@" query_file uses stdin; query_file:begin-end sets subset range
 library file formats: 0:FASTA; 1:GenBankFF; 3:EMBL_FF; 7:FASTQ; 10:subset; 12:NCBI blastdbcmd;
   alternate library formats: "library_file 7" for 7:FASTQ

DESCRIPTION
 TFASTX compares a protein to a translated DNA data bank
 version: 36.3.8 Jul, 2015

OPTIONS (options must preceed query_file library_file)
 -3   compare forward strand only
 -b:  high scores reported (limited by -E by default);
      =<int> forces <int> results;
 -c:  expected fraction for band-optimization, joining
 -C:  length of the query/sbjct name in alignments
 -d:  number of alignments shown (limited by -E by default)
 -D   enable debugging output
 -e:  expand_script to extend hits
 -E:  E()-value,E()-repeat threshold
 -f:  gap-open penalty
 -F:  min E()-value displayed
 -g:  gap-extension penalty
 -h   help - show options, arguments
 -H   show histogram
 -i   search with reverse-complement
 -I   interactive mode
 -j:  frame-shift penalty
 -k:  number of shuffles
 -l:  FASTLIBS abbreviation file
 -L   long library descriptions
 -m:  Output/alignment format;
      0 - standard ":. " alignment; 1 - " xX"; 2 - ".MS.."; 3 - separate >fasta entries;
      4 - "---" alignment map; 5 - 0+4; 6 - <html>;
      8 - BLAST tabular; 8C commented BLAST tabular;
      B - BLAST Query/Sbjct alignments; BB - complete BLAST output;
      9 - FASTA tabular; 9c - FASTA tabular encoded; 9C FASTA tabular CIGAR encoded;
     10 - parseable key:value; 11 - lav for LALIGN;
      A - aligned residue score
      F - 'F0,6,9c out_file' - alternate output formats to files;
 -M:  filter on library sequence length
 -n   DNA/RNA query
 -N:  max library length before overlapping
 -o:  offset coordinates of query/subject
 -O:  write results to file
 -p   protein query
 -q   quiet [default] -- do not prompt
 -Q   quiet [default] -- do not prompt
 -r:  [+0/0]  +match/-mismatch for DNA/RNA
 -R:  raw score file
 -s:  Scoring matrix: (protein)
      BL50, BP62 (sets -f -11 -g -1); P250, OPT5, VT200,
      VT160, P120, VT120, BL80, VT80, MD40, VT40, MD20, VT20, MD10, VT10;
      scoring matrix file name; -s ?BL50 adjusts matrix for short queries;
 -S   filter lowercase (seg) residues
 -t:  translation genetic code
 -T:  max threads/workers
 -U   RNA query
 -v:  shuffle window size
 -V:  annotation characters in query/library for aligments
 -w:  width of alignment display
 -X:  Extended options
 -z:  Statistics estimation method:
      1 - regression; -1 - no stats.; 0 - no scaling; 2 - Maximum Likelihood Est.;
      3 - Altschul/Gish; 4 - iter. regress.; 5 - regress w/variance;
      6 - MLE with comp. adj.;
     11 - 16 - estimates from shuffled library sequences;
     21 - 26 - E2()-stats from shuffled high-scoring sequences;
 -Z:  [library entries] database size for E()-value
```


## fasta3_tfasty36

### Tool Description
TFASTY compares a protein to a translated DNA data bank

### Metadata
- **Docker Image**: quay.io/biocontainers/fasta3:36.3.8--0
- **Homepage**: http://faculty.virginia.edu/wrpearson/fasta
- **Package**: https://anaconda.org/channels/bioconda/packages/fasta3/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
 tfasty36 [-options] query_file library_file [ktup]
 "@" query_file uses stdin; query_file:begin-end sets subset range
 library file formats: 0:FASTA; 1:GenBankFF; 3:EMBL_FF; 7:FASTQ; 10:subset; 12:NCBI blastdbcmd;
   alternate library formats: "library_file 7" for 7:FASTQ

DESCRIPTION
 TFASTY compares a protein to a translated DNA data bank
 version: 36.3.8 Jul, 2015

OPTIONS (options must preceed query_file library_file)
 -3   compare forward strand only
 -b:  high scores reported (limited by -E by default);
      =<int> forces <int> results;
 -c:  expected fraction for band-optimization, joining
 -C:  length of the query/sbjct name in alignments
 -d:  number of alignments shown (limited by -E by default)
 -D   enable debugging output
 -e:  expand_script to extend hits
 -E:  E()-value,E()-repeat threshold
 -f:  gap-open penalty
 -F:  min E()-value displayed
 -g:  gap-extension penalty
 -h   help - show options, arguments
 -H   show histogram
 -i   search with reverse-complement
 -I   interactive mode
 -j:  frame-shift, codon substitution penalty
 -k:  number of shuffles
 -l:  FASTLIBS abbreviation file
 -L   long library descriptions
 -m:  Output/alignment format;
      0 - standard ":. " alignment; 1 - " xX"; 2 - ".MS.."; 3 - separate >fasta entries;
      4 - "---" alignment map; 5 - 0+4; 6 - <html>;
      8 - BLAST tabular; 8C commented BLAST tabular;
      B - BLAST Query/Sbjct alignments; BB - complete BLAST output;
      9 - FASTA tabular; 9c - FASTA tabular encoded; 9C FASTA tabular CIGAR encoded;
     10 - parseable key:value; 11 - lav for LALIGN;
      A - aligned residue score
      F - 'F0,6,9c out_file' - alternate output formats to files;
 -M:  filter on library sequence length
 -n   DNA/RNA query
 -N:  max library length before overlapping
 -o:  offset coordinates of query/subject
 -O:  write results to file
 -p   protein query
 -q   quiet [default] -- do not prompt
 -Q   quiet [default] -- do not prompt
 -r:  [+0/0]  +match/-mismatch for DNA/RNA
 -R:  raw score file
 -s:  Scoring matrix: (protein)
      BL50, BP62 (sets -f -11 -g -1); P250, OPT5, VT200,
      VT160, P120, VT120, BL80, VT80, MD40, VT40, MD20, VT20, MD10, VT10;
      scoring matrix file name; -s ?BL50 adjusts matrix for short queries;
 -S   filter lowercase (seg) residues
 -t:  translation genetic code
 -T:  max threads/workers
 -U   RNA query
 -v:  shuffle window size
 -V:  annotation characters in query/library for aligments
 -w:  width of alignment display
 -X:  Extended options
 -z:  Statistics estimation method:
      1 - regression; -1 - no stats.; 0 - no scaling; 2 - Maximum Likelihood Est.;
      3 - Altschul/Gish; 4 - iter. regress.; 5 - regress w/variance;
      6 - MLE with comp. adj.;
     11 - 16 - estimates from shuffled library sequences;
     21 - 26 - E2()-stats from shuffled high-scoring sequences;
 -Z:  [library entries] database size for E()-value
```


## fasta3_fastx36

### Tool Description
FASTX compares a DNA sequence to a protein sequence data bank

### Metadata
- **Docker Image**: quay.io/biocontainers/fasta3:36.3.8--0
- **Homepage**: http://faculty.virginia.edu/wrpearson/fasta
- **Package**: https://anaconda.org/channels/bioconda/packages/fasta3/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
 fastx36 [-options] query_file library_file [ktup]
 "@" query_file uses stdin; query_file:begin-end sets subset range
 library file formats: 0:FASTA; 1:GenBankFF; 3:EMBL_FF; 7:FASTQ; 10:subset; 12:NCBI blastdbcmd;
   alternate library formats: "library_file 7" for 7:FASTQ

DESCRIPTION
 FASTX compares a DNA sequence to a protein sequence data bank
 version: 36.3.8 Jul, 2015

OPTIONS (options must preceed query_file library_file)
 -3   compare forward strand only
 -b:  high scores reported (limited by -E by default);
      =<int> forces <int> results;
 -c:  expected fraction for band-optimization, joining
 -C:  length of the query/sbjct name in alignments
 -d:  number of alignments shown (limited by -E by default)
 -D   enable debugging output
 -e:  expand_script to extend hits
 -E:  E()-value,E()-repeat threshold
 -f:  gap-open penalty
 -F:  min E()-value displayed
 -g:  gap-extension penalty
 -h   help - show options, arguments
 -H   show histogram
 -i   search with reverse-complement
 -I   interactive mode
 -j:  frame-shift penalty
 -k:  number of shuffles
 -l:  FASTLIBS abbreviation file
 -L   long library descriptions
 -m:  Output/alignment format;
      0 - standard ":. " alignment; 1 - " xX"; 2 - ".MS.."; 3 - separate >fasta entries;
      4 - "---" alignment map; 5 - 0+4; 6 - <html>;
      8 - BLAST tabular; 8C commented BLAST tabular;
      B - BLAST Query/Sbjct alignments; BB - complete BLAST output;
      9 - FASTA tabular; 9c - FASTA tabular encoded; 9C FASTA tabular CIGAR encoded;
     10 - parseable key:value; 11 - lav for LALIGN;
      A - aligned residue score
      F - 'F0,6,9c out_file' - alternate output formats to files;
 -M:  filter on library sequence length
 -n   DNA/RNA query
 -N:  max library length before overlapping
 -o:  offset coordinates of query/subject
 -O:  write results to file
 -p   protein query
 -q   quiet [default] -- do not prompt
 -Q   quiet [default] -- do not prompt
 -r:  [+0/0]  +match/-mismatch for DNA/RNA
 -R:  raw score file
 -s:  Scoring matrix: (protein)
      BL50, BP62 (sets -f -11 -g -1); P250, OPT5, VT200,
      VT160, P120, VT120, BL80, VT80, MD40, VT40, MD20, VT20, MD10, VT10;
      scoring matrix file name; -s ?BL50 adjusts matrix for short queries;
 -S   filter lowercase (seg) residues
 -t:  translation genetic code
 -T:  max threads/workers
 -U   RNA query
 -v:  shuffle window size
 -V:  annotation characters in query/library for aligments
 -w:  width of alignment display
 -X:  Extended options
 -z:  Statistics estimation method:
      1 - regression; -1 - no stats.; 0 - no scaling; 2 - Maximum Likelihood Est.;
      3 - Altschul/Gish; 4 - iter. regress.; 5 - regress w/variance;
      6 - MLE with comp. adj.;
     11 - 16 - estimates from shuffled library sequences;
     21 - 26 - E2()-stats from shuffled high-scoring sequences;
 -Z:  [library entries] database size for E()-value
```


## fasta3_fasty36

### Tool Description
FASTY compares a DNA sequence to a protein sequence data bank

### Metadata
- **Docker Image**: quay.io/biocontainers/fasta3:36.3.8--0
- **Homepage**: http://faculty.virginia.edu/wrpearson/fasta
- **Package**: https://anaconda.org/channels/bioconda/packages/fasta3/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
 fasty36 [-options] query_file library_file [ktup]
 "@" query_file uses stdin; query_file:begin-end sets subset range
 library file formats: 0:FASTA; 1:GenBankFF; 3:EMBL_FF; 7:FASTQ; 10:subset; 12:NCBI blastdbcmd;
   alternate library formats: "library_file 7" for 7:FASTQ

DESCRIPTION
 FASTY compares a DNA sequence to a protein sequence data bank
 version: 36.3.8 Jul, 2015

OPTIONS (options must preceed query_file library_file)
 -3   compare forward strand only
 -b:  high scores reported (limited by -E by default);
      =<int> forces <int> results;
 -c:  expected fraction for band-optimization, joining
 -C:  length of the query/sbjct name in alignments
 -d:  number of alignments shown (limited by -E by default)
 -D   enable debugging output
 -e:  expand_script to extend hits
 -E:  E()-value,E()-repeat threshold
 -f:  gap-open penalty
 -F:  min E()-value displayed
 -g:  gap-extension penalty
 -h   help - show options, arguments
 -H   show histogram
 -i   search with reverse-complement
 -I   interactive mode
 -j:  frame-shift, codon substitution penalty
 -k:  number of shuffles
 -l:  FASTLIBS abbreviation file
 -L   long library descriptions
 -m:  Output/alignment format;
      0 - standard ":. " alignment; 1 - " xX"; 2 - ".MS.."; 3 - separate >fasta entries;
      4 - "---" alignment map; 5 - 0+4; 6 - <html>;
      8 - BLAST tabular; 8C commented BLAST tabular;
      B - BLAST Query/Sbjct alignments; BB - complete BLAST output;
      9 - FASTA tabular; 9c - FASTA tabular encoded; 9C FASTA tabular CIGAR encoded;
     10 - parseable key:value; 11 - lav for LALIGN;
      A - aligned residue score
      F - 'F0,6,9c out_file' - alternate output formats to files;
 -M:  filter on library sequence length
 -n   DNA/RNA query
 -N:  max library length before overlapping
 -o:  offset coordinates of query/subject
 -O:  write results to file
 -p   protein query
 -q   quiet [default] -- do not prompt
 -Q   quiet [default] -- do not prompt
 -r:  [+0/0]  +match/-mismatch for DNA/RNA
 -R:  raw score file
 -s:  Scoring matrix: (protein)
      BL50, BP62 (sets -f -11 -g -1); P250, OPT5, VT200,
      VT160, P120, VT120, BL80, VT80, MD40, VT40, MD20, VT20, MD10, VT10;
      scoring matrix file name; -s ?BL50 adjusts matrix for short queries;
 -S   filter lowercase (seg) residues
 -t:  translation genetic code
 -T:  max threads/workers
 -U   RNA query
 -v:  shuffle window size
 -V:  annotation characters in query/library for aligments
 -w:  width of alignment display
 -X:  Extended options
 -z:  Statistics estimation method:
      1 - regression; -1 - no stats.; 0 - no scaling; 2 - Maximum Likelihood Est.;
      3 - Altschul/Gish; 4 - iter. regress.; 5 - regress w/variance;
      6 - MLE with comp. adj.;
     11 - 16 - estimates from shuffled library sequences;
     21 - 26 - E2()-stats from shuffled high-scoring sequences;
 -Z:  [library entries] database size for E()-value
```

