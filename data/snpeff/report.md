# snpeff CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| snpeff_build | PASS |  |
| snpeff_cds | PASS | synthetic data: CDS FASTA headers rewritten to the transcript IDs the command needs |
| snpeff_closest | PASS |  |
| snpeff_count | PASS |  |
| snpeff_databases | PASS |  |
| snpeff_download | PASS |  |
| snpeff_dump | PASS |  |
| snpeff_genes2bed | PASS |  |
| snpeff_len | Failed | tool bug: the command crashes with a NullPointerException (no predictor loaded) on a valid database |
| snpeff_protein | PASS |  |
| snpeff_seq | PASS |  |
| snpeff_show | PASS |  |
| snpeff_snpEff | PASS |  |

## snpeff_snpEff

### Tool Description
SnpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Total Downloads**: 563.1K
- **Last updated**: 2025-11-28
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Error        :	Missing genomer_version parameter
Command line :	SnpEff  

snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff [ann] [options] genome_version [input_file]


	variants_file                   : Default is STDIN



Options:
	-chr <string>                   : Prepend 'string' to chromosome name (e.g. 'chr1' instead of '1'). Only on TXT output.
	-classic                        : Use old style annotations instead of Sequence Ontology and Hgvs.
	-csvStats <file>                : Create CSV summary file.
	-download                       : Download reference genome if not available. Default: true
	-i <format>                     : Input format [ vcf, bed ]. Default: VCF.
	-fileList                       : Input actually contains a list of files to process.
	-o <format>                     : Output format [ vcf, gatk, bed, bedAnn ]. Default: VCF.
	-s , -stats, -htmlStats         : Create HTML summary file.  Default is 'snpEff_summary.html'
	-noStats                        : Do not create stats (summary) file

Results filter options:
	-fi , -filterInterval  <file>   : Only analyze changes that intersect with the intervals specified in this file (you may use this option many times)
	-no-downstream                  : Do not show DOWNSTREAM changes
	-no-intergenic                  : Do not show INTERGENIC changes
	-no-intron                      : Do not show INTRON changes
	-no-upstream                    : Do not show UPSTREAM changes
	-no-utr                         : Do not show 5_PRIME_UTR or 3_PRIME_UTR changes
	-no <effectType>                : Do not show 'EffectType'. This option can be used several times.

Annotations options:
	-cancer                         : Perform 'cancer' comparisons (Somatic vs Germline). Default: false
	-cancerSamples <file>           : Two column TXT file defining 'oringinal \t derived' samples.
	-fastaProt <file>               : Create an output file containing the resulting protein sequences.
	-fastaProtNoRef                 : Do not add reference sequences to the output (only valid when -fastaProt). Default: false
	-formatEff                      : Use 'EFF' field compatible with older versions (instead of 'ANN').
	-geneId                         : Use gene ID instead of gene name (VCF output). Default: false
	-hgvs                           : Use HGVS annotations for amino acid sub-field. Default: true
	-hgvsOld                        : Use old HGVS notation. Default: false
	-hgvs1LetterAa                  : Use one letter Amino acid codes in HGVS notation. Default: false
	-hgvsTrId                       : Use transcript ID in HGVS notation. Default: false
	-lof                            : Add loss of function (LOF) and Nonsense mediated decay (NMD) tags.
	-noHgvs                         : Do not add HGVS annotations.
	-noLof                          : Do not add LOF and NMD annotations.
	-noOut                          : Do not write the output resuts to STDOUT (maybe used for debugging).
	-noShiftHgvs                    : Do not shift variants according to HGVS notation (most 3prime end).
	-oicr                           : Add OICR tag in VCF file. Default: false
	-sequenceOntology               : Use Sequence Ontology terms. Default: true

Generic options:
	-c , -config                 : Specify config file
	-configOption name=value     : Override a config file option
	-d , -debug                  : Debug mode (very verbose).
	-dataDir <path>              : Override data_dir parameter from config file.
	-download                    : Download a SnpEff database, if not available locally. Default: true
	-nodownload                  : Do not download a SnpEff database, if not available locally.
	-h , -help                   : Show this help and exit
	-noLog                       : Do not report usage statistics to server
	-q , -quiet                  : Quiet mode (do not show any messages or errors)
	-v , -verbose                : Verbose mode
	-version                     : Show version number and exit

Database options:
	-canon                       : Only use canonical transcripts.
	-canonList <file>            : Only use canonical transcripts, replace some transcripts using the 'gene_id 	 transcript_id' entries in <file>.
	-tag <tagName>               : Only use transcript having a tag 'tagName'. This option can be used multiple times.
	-notag <tagName>             : Filter out transcript having a tag 'tagName'. This option can be used multiple times.
	-interaction                 : Annotate using interactions (requires interaction database). Default: true
	-interval <file>             : Use a custom intervals in TXT/BED/BigBed/VCF/GFF file (you may use this option many times)
	-maxTSL <TSL_number>         : Only use transcripts having Transcript Support Level lower than <TSL_number>.
	-motif                       : Annotate using motifs (requires Motif database). Default: true
	-nextProt                    : Annotate using NextProt (requires NextProt database).
	-noGenome                    : Do not load any genomic database (e.g. annotate using custom files).
	-noExpandIUB                 : Disable IUB code expansion in input variants
	-noInteraction               : Disable inteaction annotations
	-noMotif                     : Disable motif annotations.
	-noNextProt                  : Disable NextProt annotations.
	-onlyReg                     : Only use regulation tracks.
	-onlyProtein                 : Only use protein coding transcripts. Default: false
	-onlyTr <file.txt>           : Only use the transcripts in this file. Format: One transcript ID per line.
	-reg <name>                  : Regulation track to use (this option can be used add several times).
	-ss , -spliceSiteSize <int>  : Set size for splice sites (donor and acceptor) in bases. Default: 2
	-spliceRegionExonSize <int>  : Set size for splice site region within exons. Default: 3 bases
	-spliceRegionIntronMin <int> : Set minimum number of bases for splice site region within intron. Default: 3 bases
	-spliceRegionIntronMax <int> : Set maximum number of bases for splice site region within intron. Default: 8 bases
	-strict                      : Only use 'validated' transcripts (i.e. sequence has been checked). Default: false
	-ud , -upDownStreamLen <int> : Set upstream downstream interval length (in bases)
```

## snpeff_closest

### Tool Description
Find the closest exon (or distance to TSS) for each variant or interval.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff closestExon [options] genome_version file.vcf

Options:
	-bed : Input format is BED. Default: VCF
	-tss : Measure distance from TSS (transcription start site)
```

## snpeff_count

### Tool Description
Count reads or intervals that fall into each genomic region of the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff count [options] genome file_1 file_2 ...  file_N
	-n name          : Output file base name. 
	-p               : Calculate probability model (binomial). Default: false
	file             : A file contianing intervals or reads. Either BAM, SAM, VCF, BED or BigBed format.

Generic options:
	-c , -config                 : Specify config file
	-configOption name=value     : Override a config file option
	-d , -debug                  : Debug mode (very verbose).
	-dataDir <path>              : Override data_dir parameter from config file.
	-download                    : Download a SnpEff database, if not available locally. Default: true
	-nodownload                  : Do not download a SnpEff database, if not available locally.
	-h , -help                   : Show this help and exit
	-noLog                       : Do not report usage statistics to server
	-q , -quiet                  : Quiet mode (do not show any messages or errors)
	-v , -verbose                : Verbose mode
	-version                     : Show version number and exit

Database options:
	-canon                       : Only use canonical transcripts.
	-canonList <file>            : Only use canonical transcripts, replace some transcripts using the 'gene_id 	 transcript_id' entries in <file>.
	-tag <tagName>               : Only use transcript having a tag 'tagName'. This option can be used multiple times.
	-notag <tagName>             : Filter out transcript having a tag 'tagName'. This option can be used multiple times.
	-interaction                 : Annotate using interactions (requires interaction database). Default: true
	-interval <file>             : Use a custom intervals in TXT/BED/BigBed/VCF/GFF file (you may use this option many times)
	-maxTSL <TSL_number>         : Only use transcripts having Transcript Support Level lower than <TSL_number>.
	-motif                       : Annotate using motifs (requires Motif database). Default: true
	-nextProt                    : Annotate using NextProt (requires NextProt database).
	-noGenome                    : Do not load any genomic database (e.g. annotate using custom files).
	-noExpandIUB                 : Disable IUB code expansion in input variants
	-noInteraction               : Disable inteaction annotations
	-noMotif                     : Disable motif annotations.
	-noNextProt                  : Disable NextProt annotations.
	-onlyReg                     : Only use regulation tracks.
	-onlyProtein                 : Only use protein coding transcripts. Default: false
	-onlyTr <file.txt>           : Only use the transcripts in this file. Format: One transcript ID per line.
	-reg <name>                  : Regulation track to use (this option can be used add several times).
	-ss , -spliceSiteSize <int>  : Set size for splice sites (donor and acceptor) in bases. Default: 2
	-spliceRegionExonSize <int>  : Set size for splice site region within exons. Default: 3 bases
	-spliceRegionIntronMin <int> : Set minimum number of bases for splice site region within intron. Default: 3 bases
	-spliceRegionIntronMax <int> : Set maximum number of bases for splice site region within intron. Default: 8 bases
	-strict                      : Only use 'validated' transcripts (i.e. sequence has been checked). Default: false
	-ud , -upDownStreamLen <int> : Set upstream downstream interval length (in bases)
```

## snpeff_download

### Tool Description
Download a SnpEff database for a genome version.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff download [options] {snpeff | genome_version}
```

## snpeff_dump

### Tool Description
Dump the genome database (genes, transcripts and exons) as a table or BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff dump [options] genome_version
	-bed                    : Dump in BED format (implies -0)
	-chr <string>           : Prepend 'string' to chromosome name (e.g. 'chr1' instead of '1')
	-txt                    : Dump as a TXT table (implies -1)

Generic options:
	-0                      : Output zero-based coordinates. 
	-1                      : Output one-based coordinates
```

## snpeff_genes2bed

### Tool Description
Write genomic intervals of genes, exons, introns or transcripts as BED.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: SnpEffCmdGenes2Bed genomeVer [-f genes.txt | geneList]}
Options: 
	-cds           : Show coding exons (no UTRs).
	-e             : Show exons for every transcript.
	-f <file.txt>  : A TXT file having one gene ID (or name) per line.
	-i             : Show introns for every transcript.
	-pc            : Use only protein coding genes.
	-tr            : Show transcript coordinates.
	-ud <num>      : Expand gene interval upstream and downstream by 'num' bases.
	geneList       : A list of gene IDs or names. One per command line argument: geneId_1 geneId_2 geneId_3 ... geneId_N
```

## snpeff_build

### Tool Description
Build a SnpEff database from a genome annotation and its sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff build [options] genome_version

Build DB options:

Database format option (default: Auto detect):
	-embl                        : Use Embl format.
	-genbank                     : Use GenBank format.
	-gff2                        : Use GFF2 format (obsolete).
	-gff3                        : Use GFF3 format.
	-gtf22                       : Use GTF 2.2 format.
	-knowngenes                  : Use KnownGenes table from UCSC.
	-refseq                      : Use RefSeq table from UCSC.

Database build options:
	-cellType <type>             : Only build regulation tracks for cellType <type>.
	-maxErrorRate <num>          : Maximum allowed error rate (number between 0.0 and 1.0). Default: 0.05
	-noCheckCds                  : Skip CDS sequences check.
	-noCheckProtein              : Skip Protein sequences check.
	-noStoreSeqs                 : Do not store sequence in binary files. Default: false
	-onlyReg                     : Only build regulation tracks.
	-regSortedByType             : The 'regulation.gff' file is sorted by 'regulation type' instead of sorted by chromosome:pos. Default: false
	-storeSeqs                   : Store sequence in binary files. Default: true

Generic options:
	-c , -config                 : Specify config file
	-configOption name=value     : Override a config file option
	-d , -debug                  : Debug mode (very verbose).
	-dataDir <path>              : Override data_dir parameter from config file.
	-download                    : Download a SnpEff database, if not available locally. Default: true
	-nodownload                  : Do not download a SnpEff database, if not available locally.
	-h , -help                   : Show this help and exit
	-noLog                       : Do not report usage statistics to server
	-q , -quiet                  : Quiet mode (do not show any messages or errors)
	-v , -verbose                : Verbose mode
	-version                     : Show version number and exit
```

## snpeff_len

### Tool Description
Estimate the mappable length of genomic regions by random read sampling.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff len [options] genome_version
Options:
	-r     <num> : Assume a read size of 'num' bases.
	-iter  <num> : Perform 'num' iterations of random sampling.
	-reads <num> : Each random sampling iteration has 'num' reads.
```

## snpeff_protein

### Tool Description
Compare protein sequences of a genome database with a protein FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff protein [options] genome_version proteing_file

Options:
	-codonTables    : Try all codon tables on each chromosome and calculate error rates.
```

## snpeff_databases

### Tool Description
List the SnpEff databases that can be downloaded.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snpEff databases [galaxy|html]

Options
	galaxy  : Show databases in a galaxy menu format.
	html    : Show databases in a HTML format.
```

## snpeff_show

### Tool Description
Show genes and transcripts of a genome database.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff show genome_version gene_1 ... gene_N ... trId_1 ... trId_N
```

## snpeff_cds

### Tool Description
Compare CDS sequences of a genome database with a CDS FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff cds [options] genome_version cds_file

Options:
	-c , -config <file> : Specify config file
	-noLog              : Do not report usage statistics to server
	-v                  : Verbose mode
	-d                  : Debug mode
```

## snpeff_seq

### Tool Description
Show the sequence and translation of sequences or regions of a genome database.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
- **Homepage**: http://snpeff.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snpeff/overview
- **Validation**: PASS

### Original Help Text
```text
snpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani
Usage: snpEff seq [-r] genome seq_1 seq_2 ... seq_N
	-r : Reverse-Watson-Cricks complement.
```

