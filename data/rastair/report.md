# rastair CWL Generation Report

## rastair_call

### Tool Description
Call methylated positions

Process TAPS-sequenced BAM files and call methylated positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
- **Homepage**: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rastair/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rastair/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2026-02-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Call methylated positions

Process TAPS-sequenced BAM files and call methylated positions.

If no output file is specified, the output is written to stdout. You can use `--vcf` and `--bed` to write to files instead.

If using `-c` (`--cpgs-only`), all CpG positions in the reference as well as de-novo CpGs are written. Stdout will default to BED.

Only variants that pass all filters are written by default. Use `--all` to get a full VCF file.

Usage: rastair call [OPTIONS] --fasta-file <FASTA_FILE> <BAM_FILE>

Options:
  -v, --verbose
          Enable more logging
          
          You can also use the `RASTAIR_LOG` environment variable to configure logging in a more precise way. See the documentation of the `tracing-subscriber` library to learn more.

  -h, --help
          Print help (see a summary with '-h')

Input Options:
  -r, --fasta-file <FASTA_FILE>
          Path to sorted and indexed (via samtools faidx) FASTA file. Can be bgzip compressed, but requires both a gzi index and a fai index

  -l, --region <REGION>
          Restrict to a specific chromosome or region of a chromosome. Format is "chr", "chr:start" or "chr:start-end", where start is 1-based and end is inclusive

  <BAM_FILE>
          Path to sorted and indexed BAM file

Processing Options:
      --segment-max-length <SEGMENT_MAX_LENGTH>
          Maximum length of a segment in bases
          
          Used for splitting work between threads. Tweak this to adjust memory usage.
          
          [default: 100000]

      --segment-overlap <SEGMENT_OVERLAP>
          Number of bases to overlap between segments
          
          Helpful to avoid missing variants at the edges of segments.
          
          [default: 200]

      --error-model <ERROR_MODEL>
          The error model to use
          
          Accepts platform names or a custom error rate (e.g., 0.005)

          Possible values:
          - miseq:       MiSeq <https://support.illumina.com/sequencing/sequencing_instruments/miseq.html>
          - miniseq:     MiniSeq <https://support.illumina.com/sequencing/sequencing_instruments/miniseq.html>
          - nextseq500:  NextSeq500 <https://support.illumina.com/sequencing/sequencing_instruments/nextseq-500.html>
          - nextseq550:  NextSeq550 <https://support.illumina.com/sequencing/sequencing_instruments/nextseq-550.html>
          - hiseq2500:   HiSeq2500 <https://support.illumina.com/sequencing/sequencing_instruments/hiseq_2500.html>
          - novaseq6000: NovaSeq6000 <https://support.illumina.com/sequencing/sequencing_instruments/novaseq-6000.html>
          - hiseqxten:   HiSeq X Ten <https://support.illumina.com/sequencing/sequencing_instruments/hiseq-x.html>
          
          [default: novaseq6000]

      --vcf-threads <VCF_THREADS>
          Number of threads to use for writing (and compressing) VCF files
          
          This is subtracted from `--threads` but never below 1. Adjust this if you think that VCF writing is a bottleneck, e.g. when the output files contain a lot of positions.
          
          [default: 1]

  -@, --threads <TOTAL_THREADS>
          Number of threads to use for processing the BAM file. Will use all available threads when not specified.
          
          Note that VCF writing might use additional threads internally for compression. This can be overwritten with `--vcf-threads`.
          
          [env: RASTAIR_THREADS=]
          [default: 20]

Filter Options:
      --keep-overlapping-reads
          Whether to keep overlapping reads

      --v-min-depth <V_MIN_DEPTH>
          [default: 3]

      --max-coverage <MAX_COVERAGE>
          [default: 1000]

  -q, --min-mapq <MIN_MAPQ>
          Minimum mapping quality to consider a read
          
          [default: 1]

  -Q, --min-baseq <MIN_BASEQ>
          Minimum base quality to consider a base
          
          [default: 10]

      --nOT <N_OT>
          For OT reads, exclude `[r1_start, r1_end, r2_start, r2_end]` bases from counting.
          
          The coordinates are relative to the read, so start is the distance from the 5' of the read, the end is the distance to the 3', irrespective of which way around the read aligns to the reference.
          
          Also note that the distance is relative to read length, not alignment length, so soft-clipped bases count, too!
          
          [default: 0,0,0,0]

      --nOB <N_OB>
          For OB reads, exclude `[r1_start, r1_end, r2_start, r2_end]` bases from counting.
          
          The coordinates are relative to the read, so start is the distance from the 5' of the read, the end is the distance to the 3', irrespective of which way around the read aligns to the reference.
          
          Also note that the distance is relative to read length, not alignment length, so soft-clipped bases count, too!
          
          [default: 0,0,0,0]

  -f, --include-flags <INCLUDE_FLAGS>
          Include reads that match all of these bit-flags
          
          [default: 3]

  -F, --exclude-flags <EXCLUDE_FLAGS>
          Exclude reads that match any of these bit-flags
          
          [default: 3852]

      --cpg-novo-min-depth <CPG_NOVO_MIN_DEPTH>
          Minimum reads needed in support of de-novo CpG
          
          [default: 2]

      --cpg-novo-min-baseq <CPG_NOVO_MIN_BASEQ>
          Minimum base quality for de-novo CpGs
          
          [default: 15]

      --cpg-novo-min-mapq <CPG_NOVO_MIN_MAPQ>
          Minimum mapping quality for de-novo CpGs
          
          [default: 50]

      --cpg-novo-min-vaf <CPG_NOVO_MIN_VAF>
          Minimum variant allele frequency for de-novo CpGs
          
          [default: 0.2]

      --m-vaf-min <M_VAF_MIN>
          The minimum variant allele frequency
          
          [default: 0.2]

      --m-min-depth <M_MIN_DEPTH>
          The minimum number of reads to call a position as methylated
          
          [default: 3]

      --m-bq-ratio-min <M_BQ_RATIO_MIN>
          The minimum quality ratio `(ad_alt*bq_alt + 1) / (ad_ref*bq_ref + 1)`
          
          [default: 0.27]

      --m-read-position-min <M_READ_POSITION_MIN>
          The minimum relative position in read for alt allele evidence
          
          [default: 0.2]

      --m-read-position-max <M_READ_POSITION_MAX>
          The maximum relative position in read for alt allele evidence
          
          [default: 0.8]

      --m-max-coverage <M_MAX_COVERAGE>
          The maximum coverage depth for methylation calling
          
          [default: 1000]

      --no-ml
          Only use hard thresholds to call variants and methylation events.
          
          This disables using the machine learning models. This will make rastair much faster, but at the cost of accuracy.

      --ml [<ML>]
          Use machine learning model with this threshold value to call variants and methylation events
          
          When specified, a ML model will classify positions with a prediction score. Anything above this threshold is considered PASS.
          
          For consistency with `--no-ml`, this option can be also be specified as `--ml` without a value, which will use the default threshold.
          
          [default: 0.50]

      --model <MODEL>
          Path to the combined model file containing CpG, denovo, and others models
          
          Default is the bundled model in the Rastair binary.

  -c, --cpgs-only
          Report CpGs only and default to BED output
          
          Only report positions that are CpGs in the reference or variants that would result in a de-novo CpG.
          
          If combined with `--all`, non-passing de-novo CpG positions and CpGs in the reference but without coverage in the sample will also be reported.

      --bed-include-empty
          Include CpG positions with zero coverage
          
          This can be useful to get a complete list of CpG positions in the output BED file. Note that this requires the input data to contain a complete list of CpG positions, e.g. by using the `--cpgs-only` option when calling methylation.

Output Options:
      --all
          Output all positions, even if they do not pass filters.
          
          If combined with `--cpgs-only`, only CpG positions will be reported, including non-passing de-novo CpGs, and those without coverage.

  -o, --vcf [<VCF>]
          VCF/BCF output file path (use - to write to stdout)
          
          Format is guessed based on the file extension: `.vcf` for VCF (uncompressed), `.vcf.gz` for VCF (compressed), `.bcf` for BCF (compressed) `.mpk.lz4` for internal format (Message Pack, LZ4-compressed)

      --vcf-info-fields <VCF_INFO_FIELDS>
          Additional INFO fields to include in VCF output (comma-separated VCF field IDs)
          
          By default, only a minimal set is included.
          
          [possible values: AD, BQ, DP, MQ, MQ0, NS, AS_SB, SC5, AF, ABQ, AMQ, AS_SS_BQ, AS_SS_MQ, PIR, ENT100, NAB, NOI, M5mC_Strands, CPG, CPGnovo]

      --vcf-format-fields <VCF_FORMAT_FIELDS>
          Additional FORMAT fields to include in VCF output (comma-separated VCF field IDs)
          
          By default, only a minimal set is included.
          
          [possible values: GT, GL, GC, DP, M5mC, ML]

      --bed [<BED>]
          Output BED file with the called methylated positions

      --bed-format <BED_FORMAT>
          Format of the output BED file
          
          If not specified, the format is guessed based on the file extension.

          Possible values:
          - bed-gz: BGZIP compressed file, usually `.bed.gz`
          - bed:    Regular BED file, usually `.bed`
```


## rastair_per-read

### Tool Description
Call methylation per-read
This will produce a bed file that list the methylation status of all CpGs in every read that overlaps a CpG, plus some other metadata

### Metadata
- **Docker Image**: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
- **Homepage**: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rastair/overview
- **Validation**: PASS

### Original Help Text
```text
Call methylation per-read

This will produce a bed file that list the methylation status of all CpGs in every read that overlaps a CpG, plus some other metadata

Usage: rastair per-read [OPTIONS] --fasta-file <FASTA_FILE> <BAM_FILE>

Options:
  -v, --verbose
          Enable more logging
          
          You can also use the `RASTAIR_LOG` environment variable to configure logging in a more precise way. See the documentation of the `tracing-subscriber` library to learn more.

  -h, --help
          Print help (see a summary with '-h')

Input Options:
  -r, --fasta-file <FASTA_FILE>
          Path to sorted and indexed (via samtools faidx) FASTA file. Can be bgzip compressed, but requires both a gzi index and a fai index

  -l, --region <REGION>
          Restrict to a specific chromosome or region of a chromosome. Format is "chr", "chr:start" or "chr:start-end", where start is 1-based and end is inclusive

      --calls <CALLS>
          BED file Rastair wrote with methylation calls per position

  <BAM_FILE>
          Path to sorted and indexed BAM file

Processing Options:
      --segment-max-length <SEGMENT_MAX_LENGTH>
          Maximum length of a segment in bases
          
          Used for splitting work between threads. Tweak this to adjust memory usage.
          
          [default: 100000]

      --segment-overlap <SEGMENT_OVERLAP>
          Number of bases to overlap between segments
          
          Helpful to avoid missing variants at the edges of segments.
          
          [default: 500]

  -@, --threads <TOTAL_THREADS>
          Number of threads to use for processing the BAM file. Will use all available threads when not specified.
          
          Note that VCF writing might use additional threads internally for compression. This can be overwritten with `--vcf-threads`.
          
          [default: 20]

Filter Options:
  -f, --include-flags <INCLUDE_FLAGS>
          Include reads that match all of these bit-flags
          
          [default: 3]

  -F, --exclude-flags <EXCLUDE_FLAGS>
          Exclude reads that match any of these bit-flags
          
          [default: 3852]

  -w, --max-read-length <MAX_READ_LENGTH>
          expected maximum read length. If set too short, some read positions might not get counted. Safest to set this a bit higher than the actual read length, to allow for indels in reads
          
          [default: 200]

  -q, --min-mapq <MIN_MAPQ>
          Minimum mapping quality per aligned read
          
          [default: 1]

      --exclude-ambiguous
          Exclude reads where the orientation cannot be unambiguously determined

      --count-clipped
          Count clipped positions
          
          By default, rastair ignores the leading (soft and hard) clipped positions in the "positions in read" columns. The indices written can be seen as "position in read relative to the first base actually aligned".
          
          If `--count-clipped` is set, clipped positions will instead be counted. The indices written then match the sequence of the read.

Output Options:
  -A, --all-reads
          Report reads with no CpGs in them

      --bed [<BED>]
          Output BED file with all reads
          
          [default: -]

      --bed-format <BED_FORMAT>
          Format of the output BED reads file
          
          If not specified, the format is guessed based on the file extension.

          Possible values:
          - bed-gz: BGZIP compressed file, usually `.bed.gz`
          - bed:    Regular BED file, usually `.bed`
```


## rastair_convert

### Tool Description
Convert between different file formats

### Metadata
- **Docker Image**: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
- **Homepage**: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rastair/overview
- **Validation**: PASS

### Original Help Text
```text
Convert between different file formats

Usage: rastair convert [OPTIONS]

Options:
  -v, --verbose
          Enable more logging
          
          You can also use the `RASTAIR_LOG` environment variable to configure logging in a more precise way. See the documentation of the `tracing-subscriber` library to learn more.

  -h, --help
          Print help (see a summary with '-h')

Input Options:
  -i, --input <INPUT>
          Input file
          
          [default: -]

  -f, --input-format <INPUT_FORMAT>
          Input file format, guessed from file extension if not specified

          Possible values:
          - vcf:            Text-based VCF format (.vcf)
          - bcf:            Binary VCF format (.bcf)
          - vcf-compressed: Compressed text-based VCF format (.vcf.gz)
          - mpk.lz4

Output Options:
  -o, --output <OUTPUT>
          Output file
          
          [default: -]

  -F, --output-format <OUTPUT_FORMAT>
          Output file format, guessed from file extension if not specified

          Possible values:
          - vcf:            Text-based VCF format (.vcf)
          - bcf:            Binary VCF format (.bcf)
          - vcf-compressed: Compressed text-based VCF format (.vcf.gz)
          - mpk.lz4
          - bed:            Regular BED file, usually `.bed`
          - bed-gz:         BGZIP compressed file, usually `.bed.gz`

      --all
          Output all positions, even if they do not pass filters.
          
          If combined with `--cpgs-only`, only CpG positions will be reported, including non-passing de-novo CpGs, and those without coverage.

Processing Options:
      --error-model <ERROR_MODEL>
          Possible values:
          - miseq:       MiSeq <https://support.illumina.com/sequencing/sequencing_instruments/miseq.html>
          - miniseq:     MiniSeq <https://support.illumina.com/sequencing/sequencing_instruments/miniseq.html>
          - nextseq500:  NextSeq500 <https://support.illumina.com/sequencing/sequencing_instruments/nextseq-500.html>
          - nextseq550:  NextSeq550 <https://support.illumina.com/sequencing/sequencing_instruments/nextseq-550.html>
          - hiseq2500:   HiSeq2500 <https://support.illumina.com/sequencing/sequencing_instruments/hiseq_2500.html>
          - novaseq6000: NovaSeq6000 <https://support.illumina.com/sequencing/sequencing_instruments/novaseq-6000.html>
          - hiseqxten:   HiSeq X Ten <https://support.illumina.com/sequencing/sequencing_instruments/hiseq-x.html>
          
          [default: novaseq6000]

Filter Options:
  -c, --cpgs-only
          Report CpGs only and default to BED output
          
          Only report positions that are CpGs in the reference or variants that would result in a de-novo CpG.
          
          If combined with `--all`, non-passing de-novo CpG positions and CpGs in the reference but without coverage in the sample will also be reported.

      --bed-include-empty
          Include CpG positions with zero coverage
          
          This can be useful to get a complete list of CpG positions in the output BED file. Note that this requires the input data to contain a complete list of CpG positions, e.g. by using the `--cpgs-only` option when calling methylation.

      --bed-ml <ML_THRESHOLD>
          Minimum ML score to consider a position as variant
          
          This does nothing if the input data does not contain ML scores.
          
          [default: 0.50]
```


## rastair_view

### Tool Description
View internal format as JSON lines

### Metadata
- **Docker Image**: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
- **Homepage**: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rastair/overview
- **Validation**: PASS

### Original Help Text
```text
View internal format as JSON lines

Usage: rastair view [OPTIONS] <INPUT>

Arguments:
  <INPUT>
          Message Pack file to view

Options:
  -v, --verbose
          Enable more logging
          
          You can also use the `RASTAIR_LOG` environment variable to configure logging in a more precise way. See the documentation of the `tracing-subscriber` library to learn more.

  -h, --help
          Print help (see a summary with '-h')

Output Options:
  -o, --output <OUTPUT>
          Message Pack file to view
          
          [default: -]
```


## rastair_mbias

### Tool Description
Calculate conversion per base position in read

### Metadata
- **Docker Image**: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
- **Homepage**: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rastair/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate conversion per base position in read

This will produce a `mbias.html` file with information about conversion counts relative to read position.

Please note that this is currently implemented as an R script. Unless you're using the official Docker image, you need to install R and the necessary packages yourself.

Usage: rastair mbias [OPTIONS] <BED_FILE>

Options:
      --r-script-dir <R_SCRIPT_DIR>
          Override directory to find R scripts
          
          When not set, tries to look for `$rastair_path/scripts` and `./scripts`
          
          [env: R_SCRIPT_DIR=]

  -v, --verbose
          Enable more logging
          
          You can also use the `RASTAIR_LOG` environment variable to configure logging in a more precise way. See the documentation of the `tracing-subscriber` library to learn more.

  -h, --help
          Print help (see a summary with '-h')

Input Options:
  <BED_FILE>
          Input per-read BED file (can be gzipped)

Filter Options:
      --region <REGION>
          Genomic region

      --include-flag <INCLUDE_FLAG>
          Include bitflag as integer
          
          [default: 3]

      --exclude-flag <EXCLUDE_FLAG>
          Exclude bitflag as integer
          
          [default: 3852]

      --read-length <READ_LENGTH>
          Read length as integer

Processing Options:
      --tabix-path <TABIX_PATH>
          Path to tabix executable
          
          [default: tabix]

Output Options:
      --output-prefix <OUTPUT_PREFIX>
          Output path prefix
          
          [default: .]
```


## rastair_license

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
- **Homepage**: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rastair/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Non-commercial Use Licence
==========================

These licence terms apply to all licences granted by THE CHANCELLOR, MASTERS AND SCHOLARS OF THE UNIVERSITY OF OXFORD whose administrative offices are at University Offices, Wellington Square, Oxford OX1 2JD, United Kingdom (the “University”) for use of rastair version 2 and newer (“the Software”). 

By downloading the Software, you (the “Licensee”) are confirming that you agree that your use of the Software is subject to these licence terms.”

PLEASE READ THESE LICENCE TERMS CAREFULLY BEFORE DOWNLOADING THE SOFTWARE THROUGH THIS WEBSITE.  IF YOU DO NOT AGREE TO THESE LICENCE TERMS YOU SHOULD NOT DOWNLOAD THE SOFTWARE.

THIS LIENCE FOR THE SOFTWARE IS INTENDED FOR NON-COMMERCIAL RESEARCH USE. USE FOR WHICH ANY FINANCIAL RETURN IS RECEIVED SHALL BE DEFINED AS COMMERCIAL USE, AND INCLUDES (1) INTEGRATION OF ALL OR PART OF THE SOURCE CODE OR THE SOFTWARE INTO A PRODUCT FOR SALE OR LICENSE BY OR ON BEHALF OF LICENSEE TO THIRD PARTIES OR (2) USE OF THE SOFTWARE OR ANY DERIVATIVE OF IT FOR RESEARCH WITH THE FINAL  AIM OF DEVELOPING SOFTWARE PRODUCTS FOR SALE OR LICENSE TO A THIRD PARTY OR (3) USE OF THE SOFTWARE OR ANY DERIVATIVE OF IT FOR RESEARCH WITH THE FINAL AIM OF DEVELOPING NON-SOFTWARE PRODUCTS FOR SALE OR LICENSE TO A THIRD PARTY, OR (4) USE OF THE SOFTWARE TO PROVIDE ANY SERVICE TO AN EXTERNAL ORGANISATION FOR WHICH PAYMENT IS RECEIVED. 

If you are interested in using the Software commercially, please contact Oxford University Innovation Limited to negotiate a licence. Contact details are enquiries@innovation.ox.ac.uk quoting reference 24811.


1.	Academic Use Licence
1.1. The Licensee is granted a limited non-exclusive and non-transferable royalty free licence to download and use the Software provided that the Licensee will:
	(a)	limit their use of the Software to their own internal non-commercial research; 
	(b)	not to make commercial use the Software for or on behalf of any third party or to provide a commercial service or integrate all or part of the Software into a product for sale or license to third parties;
	(c)	use the Software in accordance with the prevailing instructions and guidance for use given on the Website and comply with procedures on the Website for user identification, authentication and access;
	(d)	comply with all applicable laws and regulations with respect to their use of the Software; and 
	(e)	ensure that wherever the Software is reproduced, described, referenced or cited in any research publication or on any documents or other material created using the Software the Copyright Notice “Copyright © 2025, University of Oxford” is used.
1.2. The Licensee may only reproduce, modify, transmit or transfer the Software where:
	(a)	such reproduction, modification, transmission or transfer is for academic, research or other scholarly use;
	(b)	the conditions of this Licence are imposed upon the receiver of the Software or any modified Software;
	(c)	all original and modified Source Code is included in any transmitted software program; and
	(d)	the Licensee grants the University an irrevocable, indefinite, royalty free, non-exclusive unlimited licence to use and sub-licence any modified Source Code as part of the Software.
1.3. The University reserves the right at any time and without liability or prior notice to the Licensee to revise, modify and replace the functionality and performance of the access to and operation of the Software. 
1.4. The Licensee acknowledges and agrees that the University owns all intellectual property rights in the Software.  The Licensee shall not have any right, title or interest in the Software.
1.5. This Licence will terminate immediately and the Licensee will no longer have any right to use the Software or exercise any of the rights granted to the Licensee upon any breach of the conditions in Section 1 of this Licence.

2.	Indemnity and Liability 
2.1. The Licensee shall defend, indemnify and hold harmless the University against any claims, actions, proceedings, losses, damages, expenses and costs (including without limitation court costs and reasonable legal fees) arising out of or in connection with the Licensee's possession or use of the Software, or any breach of these terms by the Licensee. 
2.2. The Software is provided on an ‘as is’ basis and the Licensee uses the Software at their own risk. No representations, conditions, warranties or other terms of any kind are given in respect of the the Software and all statutory warranties and conditions are excluded to the fullest extent permitted by law. Without affecting the generality of the previous sentences, the University gives no implied or express warranty and makes no representation that the Software or any part of the Software: (a) will enable specific results to be obtained; or (b) meets a particular specification or is comprehensive within its field or that it is error free or will operate without interruption; or (c) is suitable for any particular, or the Licensee's specific purposes. 
2.3. Except in relation to fraud, death or personal injury, the University's liability to the Licensee for any use of the Software, in negligence or arising in any other way out of the subject matter of these licence terms, will not extend to any incidental or consequential damages or losses, or any loss of profits, loss of revenue, loss of data, loss of contracts or opportunity, whether direct or indirect.
2.4. The Licensee hereby irrevocably undertakes to the University not to make any claim against any employee, student, researcher or other individual engaged by the University, being a claim which seeks to enforce against any of them any liability whatsoever in connection with these licence terms or their subject-matter. 

3.	General 
3.1. Severability - If any provision (or part of a provision) of these licence terms is found by any court or administrative body of competent jurisdiction to be invalid, unenforceable or illegal, the other provisions shall remain in force.
3.2. Entire Agreement - These licence terms constitute the whole agreement between the parties and supersede any previous arrangement, understanding or agreement between them relating to the Software. 
3.3. Law and Jurisdiction - These licence terms and any disputes or claims arising out of or in connection with them shall be governed by, and construed in accordance with, the law of England. The Licensee irrevocably submits to the exclusive jurisdiction of the English courts for any dispute or claim that arises out of or in connection with these licence terms.
```


## rastair_Enable

### Tool Description
A command-line tool for managing rastair configurations.

### Metadata
- **Docker Image**: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
- **Homepage**: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rastair/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Enable'

Usage: rastair [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## rastair_You

### Tool Description
A tool for analyzing and visualizing RNA sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
- **Homepage**: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rastair/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'You'

Usage: rastair [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## rastair_Print

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
- **Homepage**: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/
- **Package**: https://anaconda.org/channels/bioconda/packages/rastair/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Print'

Usage: rastair [OPTIONS] <COMMAND>

For more information, try '--help'.
```

