# pxblat CWL Generation Report

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


## pxblat_server

### Tool Description
Make a server to quickly find where DNA occurs in genome

### Metadata
- **Docker Image**: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
- **Homepage**: https://pypi.org/project/pxblat/
- **Package**: https://anaconda.org/channels/bioconda/packages/pxblat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pxblat server [OPTIONS] COMMAND [ARGS]...                               
                                                                                
 Make a server to quickly find where DNA occurs in genome                       
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help  -h        Show this message and exit.                                │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ start   To set up a server.                                                  │
│ stop    To remove a server.                                                  │
│ status  To figure out if server is alive, on static instances get usage      │
│         statics.                                                             │
│ files   To get input file list.                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```

