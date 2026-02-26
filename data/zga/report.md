# zga CWL Generation Report

## zga

### Tool Description
ZGA genome assembly and annotation pipeline ver. 0.1.1

### Metadata
- **Docker Image**: quay.io/biocontainers/zga:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/laxeye/zga
- **Package**: https://anaconda.org/channels/bioconda/packages/zga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/zga/overview
- **Total Downloads**: 14.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/laxeye/zga
- **Stars**: N/A
### Original Help Text
```text
usage: zga [-h]
           [-s {readqc,processing,assembling,polishing,check_genome,annotation}]
           [-l {readqc,processing,assembling,polishing,check_genome,annotation}]
           -o OUTPUT_DIR [--force] [-t THREADS] [-m MEMORY_LIMIT]
           [--genus GENUS] [--species SPECIES] [--strain STRAIN]
           [--transparent] [--domain {Archaea,Bacteria}] [-V]
           [-1 PE_1 [PE_1 ...]] [-2 PE_2 [PE_2 ...]]
           [--pe-merged PE_MERGED [PE_MERGED ...]]
           [-S SINGLE_END [SINGLE_END ...]] [--mp-1 MP_1 [MP_1 ...]]
           [--mp-2 MP_2 [MP_2 ...]] [--pacbio PACBIO [PACBIO ...]]
           [--nanopore NANOPORE [NANOPORE ...]] [-q QUALITY_CUTOFF]
           [--adapters ADAPTERS] [--filter-by-tile]
           [--min-short-read-length MIN_SHORT_READ_LENGTH]
           [--entropy-cutoff ENTROPY_CUTOFF] [--bbduk-k BBDUK_K]
           [--bbduk-extra [BBDUK_EXTRA ...]] [--tadpole-correct] [--bbmerge]
           [--bbmerge-extra [BBMERGE_EXTRA ...]]
           [--normalize-kmer-cov NORMALIZE_KMER_COV] [--calculate-genome-size]
           [--genome-size-estimation GENOME_SIZE_ESTIMATION]
           [--mash-kmer-copies MASH_KMER_COPIES] [--use-unknown-mp]
           [--no-nxtrim] [-a {spades,unicycler,flye,megahit}]
           [--no-spades-correction] [--use-scaffolds]
           [--spades-k-list SPADES_K_LIST]
           [--unicycler-mode {conservative,normal,bold}]
           [--linear-seqs LINEAR_SEQS] [--extract-replicons]
           [--flye-short-polish] [--flye-skip-long-polish]
           [--perform-polishing] [--polishing-iterations POLISHING_ITERATIONS]
           [--check-phix] [--checkm-mode {taxonomy_wf,lineage_wf}]
           [--checkm-rank CHECKM_RANK] [--checkm-taxon CHECKM_TAXON]
           [--checkm-full-tree] [-g GENOME] [--locus-tag LOCUS_TAG]
           [--compliant] [--minimum-contig-length MINIMUM_CONTIG_LENGTH]
           [--prefix PREFIX] [--translation-table {4,11}]

ZGA genome assembly and annotation pipeline ver. 0.1.1

options:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit

General options:

  -s {readqc,processing,assembling,polishing,check_genome,annotation}, --first-step {readqc,processing,assembling,polishing,check_genome,annotation}
                        First step of the pipeline. Default: readqc
  -l {readqc,processing,assembling,polishing,check_genome,annotation}, --last-step {readqc,processing,assembling,polishing,check_genome,annotation}
                        Last step of the pipeline. Default: annotation
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Output directory
  --force               Overwrite output directory if exists
  -t THREADS, --threads THREADS
                        Number of CPU threads to use (where possible),
                        default: 4.
  -m MEMORY_LIMIT, --memory-limit MEMORY_LIMIT
                        Memory limit in GB, default: 8.
  --genus GENUS         Genus name if known, default: 'Unknown'.
  --species SPECIES     Species name if known, , default: 'sp.'
  --strain STRAIN       Strain name if known
  --transparent         Show output from tools inside the pipeline
  --domain {Archaea,Bacteria}
                        Prokaryotic domain: Bacteria or Archaea, default:
                        Bacteria.

Input files and options:
  Sequencing reads should be in FASTQ format and may be GZipped. Multiple
  libraries should be provided as space-separated list. If some type of
  short reads are partialyy available use n/a. e.g. -1 Monday.R1.fq
  Friday.R1.fq -2 Monday.R2.fq Friday.R2.fq --pe-merged n/a Friday.merged.fq

  -1 PE_1 [PE_1 ...], --pe-1 PE_1 [PE_1 ...]
                        FASTQ file(s) with first (left) paired-end reads.
                        Space-separated if multiple.
  -2 PE_2 [PE_2 ...], --pe-2 PE_2 [PE_2 ...]
                        FASTQ file(s) with second (right) paired-end reads.
                        Space-separated if multiple.
  --pe-merged PE_MERGED [PE_MERGED ...]
                        FASTQ file(s) with merged overlapped paired-end reads
  -S SINGLE_END [SINGLE_END ...], --single-end SINGLE_END [SINGLE_END ...]
                        FASTQ file(s) with unpaired or single-end reads
  --mp-1 MP_1 [MP_1 ...]
                        Mate pair forward reads. SPAdes only
  --mp-2 MP_2 [MP_2 ...]
                        Mate pair forward reads. SPAdes only
  --pacbio PACBIO [PACBIO ...]
                        PacBio reads. Space-separated if multiple.
  --nanopore NANOPORE [NANOPORE ...]
                        Nanopore reads. Space-separated if multiple.

Read processing settings:
  -q QUALITY_CUTOFF, --quality-cutoff QUALITY_CUTOFF
                        Base quality cutoff for short reads, default: 18
  --adapters ADAPTERS   Adapter sequences for short reads trimming (FASTA). By
                        default Illumina and BGI adapter sequences are used.
  --filter-by-tile      Filter short reads (Illumina only!) based on
                        positional quality over a flowcell.
  --min-short-read-length MIN_SHORT_READ_LENGTH
                        Minimum short read length to keep after quality
                        trimming.
  --entropy-cutoff ENTROPY_CUTOFF
                        Set between 0 and 1 to filter reads with entropy below
                        that value. Higher is more stringent. Default = -1,
                        filtering disabled.
  --bbduk-k BBDUK_K     Kmer length used for finding contaminants with BBduk.
  --bbduk-extra [BBDUK_EXTRA ...]
                        Extra options for BBduk. Should be space-separated.
  --tadpole-correct     Perform error correction of short reads with
                        tadpole.sh from BBtools.SPAdes correction may be
                        disabled with "--no-spades-correction".
  --bbmerge             Merge overlapped paired-end reads with BBMerge.
  --bbmerge-extra [BBMERGE_EXTRA ...]
                        Extra options for BBMerge. Should be space-separated.
  --normalize-kmer-cov NORMALIZE_KMER_COV
                        Normalize read depth based on kmer counts to arbitrary
                        value.
  --calculate-genome-size
                        Estimate genome size with mash.
  --genome-size-estimation GENOME_SIZE_ESTIMATION
                        Genome size in bp (no K/M suffix supported) for Flye
                        assembler, if known.
  --mash-kmer-copies MASH_KMER_COPIES
                        Minimum copies of each k-mer to include in size
                        estimation, default: 10.
  --use-unknown-mp      NxTrim: Include reads that are probably mate pairs
                        (default: only known mate pairs used)
  --no-nxtrim           Don't process mate-pair reads with NxTrim. Usefull for
                        preprocessed reads

Assembly settings:
  -a {spades,unicycler,flye,megahit}, --assembler {spades,unicycler,flye,megahit}
                        Assembler: Unicycler (default; better quality), SPAdes
                        (faster, may use mate-pair reads), Flye (long reads
                        only with short-reads polishing), MEGAHIT (short reads
                        only).
  --no-spades-correction
                        Disable short read correction by SPAdes.
  --use-scaffolds       SPAdes: Use assembled scaffolds. Contigs are used by
                        default.
  --spades-k-list SPADES_K_LIST
                        SPAdes: List of kmers, comma-separated even numbers
                        e.g. '21,33,55,77'
  --unicycler-mode {conservative,normal,bold}
                        Unicycler: assember mode: conservative, normal
                        (default) or bold.
  --linear-seqs LINEAR_SEQS
                        Expected number of linear sequences
  --extract-replicons   Unicycler: extract complete replicons (e.g. plasmids)
                        from the short-read based assembly to separate files
  --flye-short-polish   Perform polishing of Flye assembly with short reads
                        using racon.
  --flye-skip-long-polish
                        Skip stage of genome polishing with long reads.
  --perform-polishing   Perform polishing. Useful only for flye assembly of
                        long reads and short reads available.
  --polishing-iterations POLISHING_ITERATIONS
                        Number of polishing iterations, default: 1.

Genome check settings:
  --check-phix          Check genome for presence of PhiX control sequence.
  --checkm-mode {taxonomy_wf,lineage_wf}
                        CheckM working mode. Default is checking for domain-
                        specific marker-set.
  --checkm-rank CHECKM_RANK
                        Rank of taxon for CheckM. Run 'checkm taxon_list' for
                        details.
  --checkm-taxon CHECKM_TAXON
                        Taxon for CheckM. Run 'checkm taxon_list' for details.
  --checkm-full-tree    Use full tree for inference of marker set, requires
                        LOTS of memory.

Annotation settings:
  -g GENOME, --genome GENOME
                        Genome assembly (when starting with assembled genome).
  --locus-tag LOCUS_TAG
                        Locus tag prefix. If not provided prefix will be by
                        bakta.
  --compliant           Force Genbank/ENA/DDJB compliance.
  --minimum-contig-length MINIMUM_CONTIG_LENGTH
                        Minimum sequence length in genome assembly.
  --prefix PREFIX       Prefix for annotated files.
  --translation-table {4,11}
                        Translation table: 11/4, default: 11.
```

