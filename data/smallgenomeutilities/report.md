# smallgenomeutilities CWL Generation Report

## smallgenomeutilities_convert_reference

### Tool Description
Convert reference sequences based on MSA and BAM alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/smallgenomeutilities
- **Package**: https://anaconda.org/channels/bioconda/packages/smallgenomeutilities/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smallgenomeutilities/overview
- **Total Downloads**: 44.3K
- **Last updated**: 2025-05-28
- **GitHub**: https://github.com/cbg-ethz/smallgenomeutilities
- **Stars**: N/A
### Original Help Text
```text
usage: convert_reference [-h] -t TO [-v] -m input -i input [-o output] [-p]
                         [-X] [-H]

options:
  -h, --help  show this help message and exit
  -t TO       Name of target contig
  -v          Print more information
  -m input    MSA input of all contigs aligned
  -i input    Input SAM/BAM file
  -o output   Output SAM/BAM file
  -p          Insert silent padding states 'P' in CIGAR
  -X          Use X/= instead of M for Match/Mismatch states
  -H          Hard-clip bases instead of the default soft-clipping
```


## smallgenomeutilities_mapper

### Tool Description
Mapper tool

### Metadata
- **Docker Image**: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/smallgenomeutilities
- **Package**: https://anaconda.org/channels/bioconda/packages/smallgenomeutilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mapper [-h] -f source -t dest [-1] [-v] MSA_file

positional arguments:
  MSA_file    file containing MSA

options:
  -h, --help  show this help message and exit
  -f source   Name and Coordinates of source contig, e.g. CONSENSUS:100-200
  -t dest     Name of target contig
  -1          Whether coordinates should be treated 1-based
  -v          Print more information (such as subsequences in references)
```


## smallgenomeutilities_aln2basecnt

### Tool Description
Script to extract base counts and coverage information from a single alignment file

### Metadata
- **Docker Image**: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/smallgenomeutilities
- **Package**: https://anaconda.org/channels/bioconda/packages/smallgenomeutilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: aln2basecnt [-h] -b TSV -c TSV [-N patient-sample] [-A alphabet]
                   [-f ARRAY_BASE] [-s YAML/JSON/INI]
                   BAM/CRAM

Script to extract base counts and coverage information from a single alignment
file

positional arguments:
  BAM/CRAM              alignment file

options:
  -h, --help            show this help message and exit
  -b TSV, --basecnt TSV
                        bases count table output file
  -c TSV, --coverage TSV
                        coverage table output file
  -N patient-sample, --name patient-sample
                        Patient/sample identifiers to use in coverage column
                        title instead of 'coverage'
  -A alphabet, --alphabet alphabet
                        alphabet to use
  -f ARRAY_BASE, --first ARRAY_BASE
                        select whether the first position is named "0"
                        (standard for python tools such as pysam, older
                        versions of smallgenomeutilities, and the BED format)
                        or "1" (standard scientific notation used in most
                        tools, and most text formats such as VCF and GFF)
  -s YAML/JSON/INI, --stats YAML/JSON/INI
                        file to write stats to

output TSVs support compression
```


## smallgenomeutilities_extract_consensus

### Tool Description
Script to construct consensus sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/smallgenomeutilities
- **Package**: https://anaconda.org/channels/bioconda/packages/smallgenomeutilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: extract_consensus [-h] -i BAM [-f FASTA] [-r BED] [-c INT] [-q INT]
                         [-a FLOAT] [-n INT] [-N STR] [-o PATH]

Script to construct consensus sequences

options:
  -h, --help  show this help message and exit
  -f FASTA    Fasta file containing the reference sequence (default: None)
  -r BED      Region of interested in BED format, e.g. HXB2:2253-3869. Loci
              are interpreted using 0-based indexing, and a half-open interval
              is used, i.e, [start:end) (default: None)
  -c INT      Minimum read depth for reporting variants per locus (default:
              50)
  -q INT      Minimum phred quality score a base has to reach to be counted
              (default: 15)
  -a FLOAT    Minimum frequency for an ambiguous nucleotide (default: 0.05)
  -n INT      Read count below which ambiguous base 'n' is reported (default:
              None)
  -N STR      Patient/sample identifier (default: CONSENSUS)
  -o PATH     Output directory (default: /)

required named arguments:
  -i BAM      Input BAM file (default: None)
```


## smallgenomeutilities_frameshift_deletions_checks

### Tool Description
Produces a report about frameshifting indels and stops in a consensus sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/smallgenomeutilities
- **Package**: https://anaconda.org/channels/bioconda/packages/smallgenomeutilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: frameshift_deletions_checks [-h] -i BAM -c FASTA -f FASTA -g GFF
                                   [-O ORF1AB] [-s CHAIN] [-0] [-o TSV] [-E]
                                   [-e [ENGLISH]] [-v]

Produces a report about frameshifting indels and stops in a consensus sequences

options:
  -h, --help            show this help message and exit
  -s CHAIN, --chain CHAIN
                        Chain file describing how the consensus is aligned to
                        the reference (e.g. `bcftools consensus --chain ...`);
                        If not provided, mafft will be used to align the
                        consensus to the reference. (default: None)
  -0, --zero-based      Use 0-based (python) instead of 1-based (standard) seq
                        positions (default: 1)
  -o TSV, --output TSV  Output file (default: /frameshift_deletions_check.tsv)
  -E, --no-english
  -e [ENGLISH], --english [ENGLISH]
                        If True writes english summary diagnosis. (default:
                        True)
  -v, --version         show program's version number and exit

required named arguments:
  -i BAM, --input BAM   Input BAM file, aligned against the reference
                        (default: None)
  -c FASTA, --consensus FASTA
                        Fasta file containing the ref_majority_dels consensus
                        sequence (default: None)
  -f FASTA, --reference FASTA
                        Fasta file containing the reference sequence to
                        compare against (default: None)
  -g GFF, --genes GFF   GFF file listing genes positions on the reference
                        sequence (default: None)
  -O ORF1AB, --orf1ab ORF1AB
                        CDS ID for the full Orf1ab CDS, comprising the
                        ribosomal shift. In the GFF this CDS should consist of
                        2 entries with the same CDS ID due to the partial
                        overlap caused by the ribosomal shift at translation
                        time (default: cds-YP_009724389.1)

columns signification:
	[ref_id/cons_id]: name of the sequence in the reference and consensus
	[start_position/length]: location of the variant
	[VARIANT]: one of: "insertion", "deletion", "stopgain" or "stoploss"
	[gene_region]: Gene in which the deletion is found according to -g argument;
	[reads_all]: Total number of reads covering the indel;
	[reads_fwd]: Total nubmer of forward reads covering the indel;
	[reads_rev]: Total nubmer of reverse reads covering the indel;
	[deletions/insertions/stops]: Number of reads supporting the deletion/insertion/stop;
	[freq_del/freq_insert/freq_stop]: Fraction of reads supporting the deletion/insertion/stop;
	[matches_ref]: number of reads that matche with the reference base;
	[pos_critical_inserts]: Start positions of insertions in the same gene_region that occur in > 40% of reads;
	[pos_critical_dels]: Start positions of deletions in the same gene_region that occur in > 40% of reads;
	[homopolymeric]: True if either around the start or end position of the deletion three bases are the same, which may have caused the polymerase to skip during reverse transcription of viral RNA to cDNA, e.g. AATAG;
	[ref_base]: base in the reference genome;
	[variant_position_english]: english sentence describing the indel or stop;
	[variant_diagnosis]: english sentence with the indel diagnosis
```


## smallgenomeutilities_minority_freq

### Tool Description
Script to extract minority alleles per samples

### Metadata
- **Docker Image**: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/smallgenomeutilities
- **Package**: https://anaconda.org/channels/bioconda/packages/smallgenomeutilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: minority_freq [-h] -r FASTA [-s INT] [-e INT] [-p file.config] [-c INT]
                     [-N name1,name2,...] [-t INT] [-f] [-d] [-o PATH]
                     BAM [BAM ...]

Script to extract minority alleles per samples

positional arguments:
  BAM                   BAM file(s)

options:
  -h, --help            show this help message and exit
  -s INT, --start INT   Starting position of the region of interest, 0-based
                        indexing (default: None)
  -e INT, --end INT     Ending position of the region of interest, 0-based
                        indexing. Note a half-open interval is used, i.e,
                        [start:end) (default: None)
  -p file.config, --config file.config
                        Report minority aminoacids - a .config file specifying
                        reading frames expected (default: None)
  -c INT                Minimum read depth for reporting variants per locus
                        and sample (default: 100)
  -N name1,name2,...    Patient/sample identifiers as comma separated strings
                        (default: None)
  -t INT                Number of threads (default: 1)
  -f, --freqs           Indicates whether or not all frequencies should be
                        stored (default: False)
  -d                    Indicates whether coverage per locus should be written
                        to output file (default: False)
  -o PATH               Output directory (default: /)

required named arguments:
  -r FASTA              Either a fasta file containing a reference sequence or
                        the reference name of the region/chromosome of
                        interest. The latter is expected if a region is
                        specified (default: None)
```


## smallgenomeutilities_paired_end_read_merger

### Tool Description
Merges paired-end reads to one fused reads based on alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/smallgenomeutilities
- **Package**: https://anaconda.org/channels/bioconda/packages/smallgenomeutilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: paired_end_read_merger [-h] [-v] [--verbose] [-q] [-f FASTA]
                              [-qn PHRED] [-o SAM] [--unpaired SAM]
                              [--unaligned SAM]
                              SAM

# Merges paired-end reads to one fused reads based on alignment.

positional arguments:
  SAM                   input SAM file (sorted by QNAME)

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  --verbose             Enable verbose debugging output
  -q, --quiet           Suppress all output except errors
  -f FASTA, --ref FASTA
                        reference file used during alignment
  -qn PHRED, --quality-n PHRED
                        PHRED quality to use when filling gap with n. (e.g. 0
                        or 2)
  -o SAM, --output SAM  file to write merged read-pairs to
  --unpaired SAM        file to write unpaired reads to (defaults to same as
                        output)
  --unaligned SAM       file to write unaligned reads to (if not specified,
                        unaligned reads are skipped)

SAM file need to be sorted by QNAME (not POS) and need @SQ in header: samtools
view -h -T reference.fasta -t reference.fasta.fai L001.bam > L001.sam &&
samtools sort -O sam -n L001.sam > L001.sorted.sam
```


## smallgenomeutilities_coverage_depth_qc

### Tool Description
Computes 'fraction of genome covered a depth' QC metrics from coverage TSV files (made by aln2basecnt, samtools depth, etc.)

### Metadata
- **Docker Image**: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/smallgenomeutilities
- **Package**: https://anaconda.org/channels/bioconda/packages/smallgenomeutilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: coverage_depth_qc [-h] [-v] [-f CHROM.SIZE] [-d DEPTH [DEPTH ...]]
                         [-n DEPTH [DEPTH ...]] [-o YAML/JSON]
                         TSV [TSV ...]

Computes 'fraction of genome covered a depth' QC metrics from coverage TSV
files (made by aln2basecnt, samtools depth, etc.)

positional arguments:
  TSV                   coverage TSV file

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -f CHROM.SIZE, --fract CHROM.SIZE
                        uses reference size table (made by chromsize, bioawk,
                        seqkit, fasta indexing, etc.) to compute relative
                        instead of absolute
  -d DEPTH [DEPTH ...], --depth DEPTH [DEPTH ...]
                        depths at wich to computer ther percentage of genome
                        covered
  -n DEPTH [DEPTH ...], --names DEPTH [DEPTH ...]
                        name to use for each TSV file (by default extract from
                        the TSV column)
  -o YAML/JSON, --output YAML/JSON
                        file to write stats to

input TSVs support compression
```


## smallgenomeutilities_extract_coverage_intervals

### Tool Description
Script to extract coverage windows for ShoRAH

### Metadata
- **Docker Image**: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/smallgenomeutilities
- **Package**: https://anaconda.org/channels/bioconda/packages/smallgenomeutilities/overview
- **Validation**: PASS

### Original Help Text
```text
usage: extract_coverage_intervals [-h] [-r BED] [-cf TSV] [-b INPUTBASED]
                                  [-c INT] [-f FLOAT] [-w len1,len2,...]
                                  [-s shift1, shift2, ...]
                                  [-N name1,name2,...] [-e] [--no-shorah]
                                  [-t INT] [-o OUTPUT]
                                  BAM [BAM ...]

Script to extract coverage windows for ShoRAH

positional arguments:
  BAM                   Input BAM file(s)

options:
  -h, --help            show this help message and exit
  -r BED, --region BED  Region of interested in BED format, e.g.
                        HXB2:2253-3869. Loci are interpreted using 0-based
                        indexing, and a half-open interval is used, i.e,
                        [start:end). If the input TSV isn't 0-based, see
                        option -b below (default: None)
  -cf TSV, --coverage-file TSV
                        File containing coverage per locus per sample. Samples
                        are expected as columns and loci as rows. This option
                        is not compatible with the read-window overlap
                        thresholding (default: None)
  -b INPUTBASED, --based INPUTBASED, --first INPUTBASED
                        Specifies whether the input TSV is 0-based (as used by
                        python tools such as pysamm, or in BED files) or
                        1-based (as standard notation in genetics, or in VCF
                        files), and thus should be converted before outputing
                        the 0-based output.are interpreted using 0-based
                        indexing, and a half-open interval is used, i.e,
                        [start:end) (default: 0)
  -c INT, --min-coverage INT
                        Minimum read depth per window (default: 100)
  -f FLOAT, --window-overlap FLOAT
                        Threshold on the overlap between each read and the
                        window (default: 0.85)
  -w len1,len2,..., --window-lenght len1,len2,...
                        Window length used by ShoRAH (default: 201)
  -s shift1, shift2, ..., --window-shift shift1, shift2, ...
                        Window shifts used by ShoRAH (default: 67)
  -N name1,name2,..., --names name1,name2,..., --IDs name1,name2,...
                        Patient/sample identifiers as comma separated strings
                        (default: None)
  -e, --right-offset    Indicate whether to apply a more liberal shift on
                        intervals' right-endpoint (default: False)
  --no-shorah           Inidcate whether to report regions with sufficient
                        coverage rather than windows for SNV calling using
                        ShoRAH (default: False)
  -t INT, --threads INT
                        Number of threads (default: 1)
  -o OUTPUT, --output OUTPUT, --outfile OUTPUT
                        Output file name (default: coverage_intervals.tsv)
```


## Metadata
- **Skill**: generated
