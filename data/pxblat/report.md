# pxblat CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pxblat_client | PASS | added network access; psl output matches the repo ground-truth file (needs a running pxblat server) |
| pxblat_fatotwobit | PASS | added missing output positional; 2bit file identical to the repo test file |
| pxblat_server_files | PASS | added network access; ran against a pxblat server started from the same image |
| pxblat_server_start | Failed | tool bug: --log writes no log file (server itself starts and answers client and status requests) |
| pxblat_server_status | PASS | added network access; ran against a pxblat server started from the same image |
| pxblat_server_stop | PASS | added network access; ran against a pxblat server started from the same image |
| pxblat_twobittofa | PASS | fasta from the repo test 2bit matches the source sequence |

## pxblat_fatotwobit

### Tool Description
Convert DNA from fasta to 2bit format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
- **Homepage**: https://pypi.org/project/pxblat/
- **Package**: https://anaconda.org/channels/bioconda/packages/pxblat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pxblat/overview
- **Total Downloads**: 29.2K
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/cauliyang/pxblat
- **Stars**: N/A
### Original Help Text
```text
Usage: pxblat fatotwobit [OPTIONS] in.fa [inf2.fa in3.fa ...] out.2bit         
                                                                                
 Convert DNA from fasta to 2bit format.                                         
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    infa         in.fa [inf2.fa in3.fa ...]  The fasta files [required]     │
│ *    out2bit      out.2bit                    The output file [required]     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --long                    Use 64-bit offsets for index. Allow for twoBit to  │
│                           contain more than 4Gb of sequence.                 │
│ --nomask                  Ignore lower-case masking in fa file.              │
│ --stripVersion            Strip off version number after '.' for GenBank     │
│                           accessions.                                        │
│ --ignoreDups              Convert first sequence only if there are duplicate │
│                           sequence names. Use 'twoBitDup' to find duplicate  │
│                           sequences.                                         │
│ --help          -h        Show this message and exit.                        │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pxblat_client

### Tool Description
A client for the genomic finding program that produces a .psl file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
- **Homepage**: https://pypi.org/project/pxblat/
- **Package**: https://anaconda.org/channels/bioconda/packages/pxblat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pxblat client [OPTIONS] HOST PORT SEQDIR INFASTA OUTPSL                 
                                                                                
 A client for the genomic finding program that produces a .psl file.            
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    host         TEXT     The name of the machine running the gfServer      │
│                            [required]                                        │
│ *    port         INTEGER  The same port that you started the gfServer with  │
│                            [required]                                        │
│ *    seqdir       PATH     The path of the .2bit or .nib files relative to   │
│                            the current dir                                   │
│                            [required]                                        │
│ *    infasta      PATH     Fasta format file.  May contain multiple records  │
│                            [required]                                        │
│ *    outpsl       PATH     where to put the output [required]                │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --type           -t      TEXT     Database type. Type is one of: dna, prot,  │
│                                   dnax                                       │
│                                   [default: dna]                             │
│ --qtype          -q      TEXT     Query type. Type is one of: dna, rna,      │
│                                   prot, dnax, rnax                           │
│                                   [default: dna]                             │
│ --prot                            Synonymous with -t=prot -q=prot.           │
│ --dots                   INTEGER  Output a dot every N query sequences.      │
│                                   [default: 0]                               │
│ --nohead                          Suppresses 5-line psl header.              │
│ --minScore               INTEGER  Sets minimum score.  This is twice the     │
│                                   matches minus the mismatches minus some    │
│                                   sort of gap penalty.  Default is 30.       │
│                                   [default: 30]                              │
│ --minIdentity            INTEGER  Sets minimum sequence identity (in         │
│                                   percent).  Default is 90 for nucleotide    │
│                                   searches, 25 for protein or translated     │
│                                   protein searches.                          │
│                                   [default: 90.0]                            │
│ --out                    TEXT     Controls output file format.  Type is one  │
│                                   of: psl, pslx, axt, maf, sim4, wublast,    │
│                                   blast, blast8, blast9                      │
│                                   [default: psl]                             │
│ --maxIntron              INTEGER  Sets maximum intron size. Default is       │
│                                   750000.                                    │
│                                   [default: 750000]                          │
│ --genome                 TEXT     dynamic                                    │
│ --genomeDataDir          TEXT     dynamic                                    │
│ --help           -h               Show this message and exit.                │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pxblat_twobittofa

### Tool Description
Convert all or part of .2bit file to fasta.

### Metadata
- **Docker Image**: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
- **Homepage**: https://pypi.org/project/pxblat/
- **Package**: https://anaconda.org/channels/bioconda/packages/pxblat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pxblat twobittofa [OPTIONS] input.2bit out.fa                           
                                                                                
 Convert all or part of .2bit file to fasta.                                    
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    input2bit      input.2bit  The input 2bit file [required]               │
│ *    outputfa       out.fa      The output fasta file [required]             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --seq              TEXT     Restrict this to just one sequence.              │
│ --start            INTEGER  Start at given position in sequence              │
│                             (zero-based).                                    │
│                             [default: 0]                                     │
│ --end              INTEGER  End at given position in sequence                │
│                             (non-inclusive).                                 │
│                             [default: 0]                                     │
│ --seqList          TEXT     File containing list of the desired sequence     │
│                             names                                            │
│ --noMask                    Convert sequence to all upper case.              │
│ --bpt              TEXT     Use bpt index instead of built-in one.           │
│ --bed              TEXT     Grab sequences specified by input.bed.           │
│ --bedPos                    With -bed, use chrom:start-end as the fasta ID   │
│                             in output.fa.                                    │
│ --udcDir           TEXT     Place to put cache for remote bigBed/bigWigs.    │
│ --help     -h               Show this message and exit.                      │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pxblat_server_start

### Tool Description
To set up a server.

### Metadata
- **Docker Image**: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
- **Homepage**: https://pypi.org/project/pxblat/
- **Package**: https://anaconda.org/channels/bioconda/packages/pxblat/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: pxblat server start [OPTIONS] HOST PORT TWO_BIT                         
                                                                                
 To set up a server.                                                            
                                                                                
 gfServer start host port file(s)                                               
                                                                                
 where the files are .2bit or .nib format files specified relative to the       
 current directory                                                              
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    host         TEXT     [required]                                        │
│ *    port         INTEGER  [required]                                        │
│ *    two_bit      FILE     Two bit file [required]                           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --tile-size              INTEGER  Size of n-mers to index.  Default is 11    │
│                                   for nucleotides, 4 for proteins (or        │
│                                   translated nucleotides).                   │
│                                   [default: 11]                              │
│ --stepSize               INTEGER  Spacing between tiles. Default is          │
│                                   tileSize.                                  │
│                                   [default: 11]                              │
│ --min-match              INTEGER  Number of n-mer matches that trigger       │
│                                   detailed alignment. Default is 2 for       │
│                                   nucleotides, 3 for proteins.               │
│                                   [default: 2]                               │
│ --trans                           Translate database to protein in 6 frames. │
│ --log                    TEXT     Keep a log file that records server        │
│                                   requests.                                  │
│ --mask                            Use masking from .2bit file.               │
│ --repMatch               INTEGER  Number of occurrences of a tile (n-mer)    │
│                                   that triggers repeat masking the tile.     │
│                                   Default is 1024.                           │
│                                   [default: 0]                               │
│ --noSimpRepMask                   Suppresses simple repeat masking.          │
│ --maxDnaHits             INTEGER  Maximum number of hits for a DNA query     │
│                                   that are sent from the server.             │
│                                   [default: 100]                             │
│ --maxTransHits           INTEGER  Maximum number of hits for a translated    │
│                                   query that are sent from the server.       │
│                                   [default: 200]                             │
│ --maxNtSize              INTEGER  Maximum size of untranslated DNA query     │
│                                   sequence.                                  │
│                                   [default: 40000]                           │
│ --perSeqMax              FILE     File contains one seq filename (possibly   │
│                                   with ':seq' suffix) per line.              │
│ --canStop                         If set, a quit message will actually take  │
│                                   down the server.                           │
│ --indexFile              FILE     Index file create by `gfServer index'.     │
│ --timeout                INTEGER  Timeout in seconds. [default: 90]          │
│ --help           -h               Show this message and exit.                │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## pxblat_server_stop

### Tool Description
To remove a server.

### Metadata
- **Docker Image**: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
- **Homepage**: https://pypi.org/project/pxblat/
- **Package**: https://anaconda.org/channels/bioconda/packages/pxblat/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: pxblat server stop [OPTIONS] HOST PORT                                  
                                                                                
 To remove a server.                                                            
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    host      TEXT     [required]                                           │
│ *    port      INTEGER  [required]                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help  -h        Show this message and exit.                                │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## pxblat_server_status

### Tool Description
To figure out if server is alive, on static instances get usage statics.

### Metadata
- **Docker Image**: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
- **Homepage**: https://pypi.org/project/pxblat/
- **Package**: https://anaconda.org/channels/bioconda/packages/pxblat/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: pxblat server status [OPTIONS] HOST PORT                                
                                                                                
 To figure out if server is alive, on static instances get usage statics.       
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    host      TEXT     [required]                                           │
│ *    port      INTEGER  [required]                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --trans            Translate database to protein in 6 frames.                │
│ --help   -h        Show this message and exit.                               │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## pxblat_server_files

### Tool Description
To get input file list.

### Metadata
- **Docker Image**: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
- **Homepage**: https://pypi.org/project/pxblat/
- **Package**: https://anaconda.org/channels/bioconda/packages/pxblat/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: pxblat server files [OPTIONS] HOST PORT                                 
                                                                                
 To get input file list.                                                        
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    host      TEXT     [required]                                           │
│ *    port      INTEGER  [required]                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help  -h        Show this message and exit.                                │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## Metadata
- **Skill**: generated
