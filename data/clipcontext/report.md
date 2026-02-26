# clipcontext CWL Generation Report

## clipcontext_g2t

### Tool Description
Map genomic regions to transcripts and extract context sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/clipcontext:0.7--py_0
- **Homepage**: https://github.com/BackofenLab/CLIPcontext
- **Package**: https://anaconda.org/channels/bioconda/packages/clipcontext/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clipcontext/overview
- **Total Downloads**: 12.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BackofenLab/CLIPcontext
- **Stars**: N/A
### Original Help Text
```text
usage: clipcontext g2t [-h] --in str --out str --tr str --gtf str --gen str
                       [--thr float] [--rev-filter] [--min-len int]
                       [--max-len int] [--min-exon-ol float]
                       [--merge-mode {1,2,3}] [--merge-ext int] [--add-out]
                       [--seq-ext int] [--all-gen-out] [--gen-uniq-ids]
                       [--report]

optional arguments:
  -h, --help            show this help message and exit
  --thr float           Site score threshold for filtering --in BED file
                        (default: None)
  --rev-filter          Reverse filtering (keep values <= threshold and prefer
                        sites with smaller values) (default: False)
  --min-len int         Minimum input site length for filtering --in BED file
                        (default: False)
  --max-len int         Maximum input site length for filtering --in BED file
                        (default: False)
  --min-exon-ol float   Minimum exon overlap of a site to be reported as
                        transcript hit (intersectBed -f parameter) (default:
                        0.9)
  --merge-mode {1,2,3}  Defines how to merge overlapping transcript sites
                        (overlap controlled by --merge-ext). (1) only merge
                        sites overlapping at exon borders, (2) merge all
                        overlapping sites, (3) do NOT merge overlapping sites
                        (default: 1)
  --merge-ext int       Extend regions mapped to transcripts by --merge-ext
                        before running mergeBed to merge overlapping regions
                        (default: 10)
  --add-out             Output centered and extended sites and sequences for
                        all transcript matches (unique + non-unique) (default:
                        False)
  --seq-ext int         Up- and downstream extension of centered sites for
                        context sequence extraction (default: 30)
  --all-gen-out         Output all centered and extended genomic regions,
                        instead of only the ones with unique transcript
                        matches (default: False)
  --gen-uniq-ids        Generate unique column 4 IDs for --in BED file entries
                        (default: False)
  --report              Output an .html report with statistics and plots
                        comparing transcript and genomic sequences (default:
                        False)

required arguments:
  --in str              Genomic regions (hg38) BED file (6-column format)
  --out str             Output results folder
  --tr str              Transcript sequence IDs list file to define
                        transcripts to map on
  --gtf str             Genomic annotations (hg38) GTF file (.gtf or .gtf.gz)
  --gen str             Genomic sequences (hg38) .2bit file
```


## clipcontext_t2g

### Tool Description
Processes transcript regions BED file with genomic annotations and sequences to extract context sequences and generate reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/clipcontext:0.7--py_0
- **Homepage**: https://github.com/BackofenLab/CLIPcontext
- **Package**: https://anaconda.org/channels/bioconda/packages/clipcontext/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clipcontext t2g [-h] --in str --out str --gtf str --gen str
                       [--thr float] [--rev-filter] [--min-len int]
                       [--max-len int] [--seq-ext int] [--gen-uniq-ids]
                       [--report]

optional arguments:
  -h, --help      show this help message and exit
  --thr float     Site score threshold for filtering --in BED file (default:
                  None)
  --rev-filter    Reverse filtering (keep values <= threshold and prefer sites
                  with smaller values) (default: False)
  --min-len int   Minimum input site length for filtering --in BED file
                  (default: False)
  --max-len int   Maximum input site length for filtering --in BED file
                  (default: False)
  --seq-ext int   Up- and downstream extension of centered sites for context
                  sequence extraction (default: 30)
  --gen-uniq-ids  Generate unique column 4 IDs for --in BED file entries
                  (default: False)
  --report        Output an .html report with statistics and plots comparing
                  transcript and genomic sequences (default: False)

required arguments:
  --in str        Transcript regions BED file (6-column format) (transcript
                  IDs need to be in --gtf)
  --out str       Output results folder
  --gtf str       Genomic annotations (hg38) GTF file (.gtf or .gtf.gz)
  --gen str       Genomic sequences (hg38) .2bit file
```


## clipcontext_lst

### Tool Description
Accept only transcripts with length >= --min-len (default: False)

### Metadata
- **Docker Image**: quay.io/biocontainers/clipcontext:0.7--py_0
- **Homepage**: https://github.com/BackofenLab/CLIPcontext
- **Package**: https://anaconda.org/channels/bioconda/packages/clipcontext/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clipcontext lst [-h] --gtf str --out str [--min-len int] [--strict]
                       [--add-infos]

optional arguments:
  -h, --help     show this help message and exit
  --min-len int  Accept only transcripts with length >= --min-len (default:
                 False)
  --strict       Accept only transcripts with transcript support level (TSL)
                 1-5 (default: False)
  --add-infos    Add additional information columns (gene ID, TSL, length) to
                 output file (default: False)

required arguments:
  --gtf str      Genomic annotations (hg38) GTF file (.gtf or .gtf.gz) (NOTE:
                 tested with Ensembl GTF files, expects transcript support
                 level (TSL) information)
  --out str      Output transcript IDs list file
```


## clipcontext_int

### Tool Description
CLIP peak regions overlapping with introns output BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/clipcontext:0.7--py_0
- **Homepage**: https://github.com/BackofenLab/CLIPcontext
- **Package**: https://anaconda.org/channels/bioconda/packages/clipcontext/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clipcontext int [-h] --in str --tr str --gtf str --out str
                       [--min-intron-ol float] [--min-len int] [--max-len int]
                       [--thr float] [--rev-filter]

optional arguments:
  -h, --help            show this help message and exit
  --min-intron-ol float
                        Minimum intron overlap of a site to be reported as
                        intron overlapping (intersectBed -f parameter)
                        (default: 0.9)
  --min-len int         Minimum input site length for filtering --in BED file
                        (default: False)
  --max-len int         Maximum input site length for filtering --in BED file
                        (default: False)
  --thr float           Filter out --in BED regions < --thr column 5 score
                        (default: no filtering)
  --rev-filter          Reverse filtering (keep values <= --thr and prefer
                        sites with smaller values) (default: False)

required arguments:
  --in str              CLIP peak regions input BED file (6-column format)
  --tr str              Transcript sequence IDs list file to define intron
                        regions
  --gtf str             Genomic annotations (hg38) GTF file (.gtf or .gtf.gz)
  --out str             CLIP peak regions overlapping with introns output BED
                        file
```


## clipcontext_exb

### Tool Description
CLIP peak regions near exon borders output BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/clipcontext:0.7--py_0
- **Homepage**: https://github.com/BackofenLab/CLIPcontext
- **Package**: https://anaconda.org/channels/bioconda/packages/clipcontext/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clipcontext exb [-h] --in str --tr str --gtf str --out str
                       [--max-dist int] [--min-len int] [--max-len int]
                       [--thr float] [--rev-filter]

optional arguments:
  -h, --help      show this help message and exit
  --max-dist int  Maximum distance of CLIP peak region end to nearest exon end
                  for CLIP region to still be output (default: 50)
  --min-len int   Minimum input site length for filtering --in BED file
                  (default: False)
  --max-len int   Maximum input site length for filtering --in BED file
                  (default: False)
  --thr float     Filter out --in BED regions < --thr column 5 score (default:
                  no filtering)
  --rev-filter    Reverse filtering (keep values <= --thr and prefer sites
                  with smaller values) (default: False)

required arguments:
  --in str        CLIP peak regions input BED file (6-column format)
  --tr str        Transcript sequence IDs list file to define exon regions
  --gtf str       Genomic annotations (hg38) GTF file (.gtf or .gtf.gz)
  --out str       CLIP peak regions near exon borders output BED file
```


## clipcontext_eir

### Tool Description
Extracts exon and intron regions from genomic annotations based on transcript sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/clipcontext:0.7--py_0
- **Homepage**: https://github.com/BackofenLab/CLIPcontext
- **Package**: https://anaconda.org/channels/bioconda/packages/clipcontext/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clipcontext eir [-h] --tr str --gtf str --exon-out str --intron-out str

optional arguments:
  -h, --help        show this help message and exit

required arguments:
  --tr str          Transcript sequence IDs list file for which to extract
                    exon + intron regions
  --gtf str         Genomic annotations (hg38) GTF file (.gtf or .gtf.gz)
  --exon-out str    Exon regions BED output file
  --intron-out str  Intron regions BED output file
```


## clipcontext_mtf

### Tool Description
Search for motifs in genomic or transcript sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/clipcontext:0.7--py_0
- **Homepage**: https://github.com/BackofenLab/CLIPcontext
- **Package**: https://anaconda.org/channels/bioconda/packages/clipcontext/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clipcontext mtf [-h] --in str --motif str [--gtf str] [--gen str]
                       [--out str] [--stats-out str] [--data-id str]

optional arguments:
  -h, --help       show this help message and exit
  --gtf str        Genomic annotations (hg38) GTF file (.gtf or .gtf.gz).
                   Required for --in type (2) or (3)
  --gen str        Genomic sequences (hg38) .2bit file. Required for --in type
                   (2) or (3)
  --out str        Output results folder, to store motif hit regions in BED
                   files
  --stats-out str  Output table to store motif search results in (for --in
                   type (1) (requires --data-id to be set). If table exists,
                   append results row to table
  --data-id str    Data ID (column 1) for --stats-out output table to store
                   motif search results (requires --stats-out to be set)

required arguments:
  --in str         Three different inputs possible: (1) output folder of
                   clipcontext g2t or clipcontext t2g with genomic and
                   transcript context sequence sets in which to look for given
                   --motif. (2) BED file (genomic or transcript regions) in
                   which to look for given --motif. (3) Transcript list file,
                   to search for --motif in the respective transcript
                   sequences. Note that (2)+(3) need --gtf and --gen
  --motif str      Motif or regular expression (RNA letters!) to search for in
                   --in folder context sequences (e.g. --motif '[AC]UGCUAA')
```

