# mirdeep2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mirdeep2_bwa_sam_converter.pl | Failed | tool bug: with -c a read with several SAM lines is counted once per line (8 multi-mapped tutorial reads doubled, total 378342 instead of 378333); without -c and with unique mappings the arf (151 lines) and read counts were correct |
| mirdeep2_clip_adapters.pl | PASS | new CWL; 10000 tutorial reads lost the TCGTATGCCGTCTTCTGCTTGT adapter (no adapter left, 22 nt miRNAs remain) |
| mirdeep2_collapse_reads_md.pl | PASS | new CWL; 10000 tutorial reads collapsed to 1238 unique cel_<n>_x<count> entries with counts summing to 10000 |
| mirdeep2_convert_bowtie_output.pl | PASS | new CWL; bowtie output of tutorial collapsed reads gave 167 arf lines, the first two equal to the miRDeep2 mapper arf lines, and the same columns as bwa_sam_converter |
| mirdeep2_excise_precursors.pl | PASS | new CWL; tutorial genome and parsed arf gave 20 precursors (-a 2) with matching coordinates file |
| mirdeep2_excise_precursors_iterative_final.pl | PASS | new CWL; tutorial genome and parsed arf gave 28 precursors at stack height 1, precursors fasta, coordinates and stack file identical to the miRDeep2 run |
| mirdeep2_extract_miRNAs.pl | PASS | new CWL; real miRBase mature.fa (nf-core smrnaseq) gave 437 cel and 2656 hsa mature entries in DNA alphabet |
| mirdeep2_fastaparse.pl | PASS | new CWL; 10000 clipped tutorial reads with -a 22 gave 9283 entries all at least 22 nt; -b removed a planted entry with a non-nucleotide letter |
| mirdeep2_fastaselect.pl | PASS | new CWL; tutorial mature miRNAs gave the 3 listed ids, and with -a the 4 other ids |
| mirdeep2_fastq2fasta.pl | PASS | new CWL; 2000 real nf-core smrnaseq fastq reads gave 2000 fasta entries seq_1 to seq_2000 with the same sequences |
| mirdeep2_find_read_count.pl | PASS | new CWL; tutorial collapsed reads gave 378333, equal to the sum of the _x counts |
| mirdeep2_geo2fasta.pl | PASS | synthetic data: GEO-style sequence-count files made from tutorial reads gave 2497 fasta entries, equal to the sum of the counts |
| mirdeep2_get_mirdeep2_precursors.pl | PASS | new CWL; tutorial miRDeep2 result csv gave 6 known and 1 novel precursor (score >= 1) with fasta and bed files; -m gave the mature sequence cel-miR-37 |
| mirdeep2_illumina_to_fasta.pl | PASS | synthetic data: seq.txt and qseq.txt files made from 100 real nf-core smrnaseq reads gave 100 fasta entries each, with dots converted to N |
| mirdeep2_make_html.pl | PASS | new CWL; tutorial output.mrd, survey and quantifier folder gave a result csv identical to the miRDeep2 run and a result html with the 7 known miRNAs; pdf creation also worked (8 pdfs); the Rfam option cannot build its index in the read-only image and is skipped |
| mirdeep2_make_html2.pl | PASS | new CWL; tutorial quantifier folder gave an expression page identical to the one written by quantifier.pl |
| mirdeep2_mapper.pl | PASS | fixed baseCommand to mapper.pl and real -s/-t flags, staged bowtie index; tutorial reads gave the same collapsed reads as the tutorial file and 481 genome mappings |
| mirdeep2_miRDeep2.pl | PASS | new CWL; tutorial C. elegans data gave top known score 61008 as in the tutorial and one novel miRNA |
| mirdeep2_miRDeep2_core_algorithm.pl | PASS | new CWL; tutorial signature and structure files gave 9 scored precursors; novel miRNA score 102165.6 as in the miRDeep2 result |
| mirdeep2_mirdeep2bed.pl | PASS | new CWL; tutorial result.csv gave 8 BED lines (1 novel, 7 known) with the csv scores and coordinates |
| mirdeep2_parse_mappings.pl | PASS | new CWL; tutorial arf with -a 0 -b 21 -c 23 kept 174 of 481 mappings as counted by awk; -h -j on the signature arf trimmed trailing mismatches and dropped suboptimal mappings (3105 of 3109 kept) |
| mirdeep2_perform_controls.pl | PASS | new CWL; 3 permutation rounds of the core algorithm on the tutorial structure file; command line file and its input files are staged by base name |
| mirdeep2_permute_structure.pl | PASS | new CWL; tutorial structure file gave the same 28 ids with permuted sequences and structures (random order) |
| mirdeep2_prepare_signature.pl | PASS | new CWL; tutorial reads and precursors gave a signature file identical to the one from the miRDeep2 run (3109 lines) |
| mirdeep2_quantifier.pl | PASS | fixed baseCommand to quantifier.pl and wrapped all options, collected outputs; tutorial data gave counts for 7 cel miRNAs (cel-miR-37 118131) |
| mirdeep2_remove_white_space_in_id.pl | PASS | new CWL; 200 real miRBase mature records (nf-core smrnaseq) had ids cut at the first space and sequences upper-cased |
| mirdeep2_rna2dna.pl | PASS | new CWL; 200 real miRBase mature records (nf-core smrnaseq) gave DNA sequences (U to T) and ids cut at the first space |
| mirdeep2_samFLAGinfo.pl | PASS | new CWL; flag 163 listed bits 1, 2, 32 and 128 with the right meanings |
| mirdeep2_sam_reads_collapse.pl | Failed | tool bug: merged reads take the first read's count for every merged read, so a read mapped twice is doubled (seq_1_x196422 gave x392844) and reads x10 and x20 gave x20; real nf-core smrnaseq SAM lines, confirmed on a planted two-read SAM |
| mirdeep2_sanity_check_genome.pl | Failed | tool bug: a '\|' inside a sequence is not rejected, although other illegal letters are; valid tutorial genome passes and a space in an id, a bad letter and a duplicate id are reported (synthetic data: planted broken copies). |
| mirdeep2_sanity_check_mapping_file.pl | PASS | synthetic data: tutorial arf (481 lines) gives no message and a planted truncated line is reported with its line number; note: a read whose length disagrees with its mapping fields is not caught. |
| mirdeep2_sanity_check_mature_ref.pl | PASS | synthetic data: valid tutorial mature file gives no message; a planted bad letter and a space in an id are reported; note: duplicate ids are not reported. |
| mirdeep2_sanity_check_reads_ready_file.pl | Failed | synthetic data: tool bug: a bad id, a short sequence and a duplicate sequence were reported, but duplicate read ids are not detected although the error text requires unique ids |
| mirdeep2_select_for_randfold.pl | PASS | new CWL; tutorial signature and structure files gave 9 precursor ids including the 8 loci reported by miRDeep2 |
| mirdeep2_survey.pl | PASS | new CWL; tutorial output, controls, mature and signature files gave the 21-row table identical to the miRDeep2 survey.csv except the -d stack height column |

## mirdeep2_miRDeep2.pl

### Tool Description
Run the miRDeep2 pipeline: identify known and novel miRNAs from deep sequencing reads mapped to a genome

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text


#####################################
#                                   #
# miRDeep2.0.1.3                   #
#                                   #
# last change: 08/11/2019           #
#                                   #
#####################################

miRDeep2 started at 18:5:46


#Starting miRDeep2
/usr/local/bin/miRDeep2.pl -h

miRDeep2 started at 18:5:46


#Starting miRDeep2


miRDeep2.pl reads genome mappings miRNAs_ref/none miRNAs_other/none precursors/none [options] 2>report.log

This script enacts the miRDeep2 pipeline. The input files are:

reads         deep sequences in fasta format. The identifier should contain a prefix, a running
              number and a '_x' to indicate the number of reads that have this sequence.
              There should be no redundancy in the sequences.
genome        genome contigs in fasta format. The identifiers should be unique.
mappings      file_reads mapped against file_genome. The mappings should be in arf format.
              For details on the format see the documentation.
miRNAs_ref    miRBase miRNA sequences in fasta format. These should be the known mature
              sequences for the species being analyzed.
miRNAs_other  miRBase miRNA sequences in fasta format. These should be the pooled known
              mature sequences for 1-5 species closely related to the species being
              analyzed.

precursors    miRBase miRNA precursor sequences in fasta format. These should be the known precursor
              sequences for the species being analyzed.

Please note that [Options] can only be given AFTER the input files have been supplied.

The output files produced are:

result.html   a html table giving an overview of novel and known miRNAs detected in the
              data. The table is hyperlinked to pdfs showing the signature and structure of
              each hairpin.
result.csv    spread-sheet format of results.html
survey.csv    spread-sheet of prediction accuracy for all score-cutoffs between -10 and 10.
output.mrd    text output of the reported hairpins.

Options:

-a int        minimum read stack height that triggers analysis. Using this option disables
              automatic estimation of the optimal value and all detected precursors are analyzed

-g int        maximum number of precursors to analyze when automatic excision gearing is used.
              default=50.000, if set to -1 all precursors will be analyzed

-b int        minimum score cut-off for predicted novel miRNAs to be displayed in the overview
              table. This score cut-off is by default 0.

-c            disable randfold analysis

-d            disable pdf generation

-t species    species being analyzed - this is used to link to the appropriate UCSC browser entry

-u            output list of UCSC browser species that are supported and exit

-v            remove directory with temporary files

-o            do not sort aligned reads in pdf files by sample, only used if multiple samples were used as input (see Readme for mor information)

-s file       File with known miRBase star sequences

-z tag        Additional tag appended to current time stamp

-P            use this switch if mature_ref_miRNAs contain miRBase v18 identifiers (5p and 3p) instead of previous ids from v17

Example of use:

miRDeep2.pl reads.fa genome.fa reads_vs_genome.arf mautre_ref_miRNAs.fa mature_other_miRNAs.fa  hairpin_ref_miRNAs -t Mouse 2>report.log
```

## mirdeep2_mirdeep2bed.pl

### Tool Description
Convert the result.csv file of miRDeep2 into a BED file of the novel and known miRNAs

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mirdeep2bed.pl result.csv > result.bed

Converts the result csv file of miRDeep2 into a BED file (novel and known miRNAs).
No csv file given for bed conversion
```

## mirdeep2_miRDeep2_core_algorithm.pl

### Tool Description
Core algorithm of miRDeep: score potential miRNA precursors from read signatures (blastparsed/arf format) and RNAfold structures

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/miRDeep2_core_algorithm.pl file_signature file_structure

This is the core algorithm of miRDeep. It takes as input a file in blastparsed format with
information on the positions of reads aligned to potential precursor sequences (signature).
It also takes as input an RNAfold output file, giving information on the sequence, structure
and mimimum free energy of the potential precursor sequences.

Extra arguments can be given. -s specifies a fastafile containing the known mature miRNA
sequences that should be considered for conservation purposes. -t prints out the potential
precursor sequences that do _not_ exceed the cut-off (default prints out the sequences that
exceeds the cut-off). -u gives limited output, that is only the ids of the potential precursors
that exceed the cut-off. -v varies the cut-off. -x is a sensitive option for Sanger sequences
obtained through conventional cloning. -z consider the number of base pairings in the lower
stems (this option is not well tested).

-h print this usage
-s fasta file with known miRNAs
-t print filtered
-u limited output (only ids)
-v cut-off (default 1)
-x sensitive option for Sanger sequences
-y file with randfold p-values
-z consider Drosha processing
```

## mirdeep2_parse_mappings.pl

### Tool Description
Parse an arf mapping file and discard selected mappings

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/parse_mappings.pl file_arf

Parses an arf file, and discards select mappings. Any files inputted with
the options should be single-column format, with a single id on each line.

-a int     Discard mappings of edit distance higher than this
-b int     Discard mappings of read queries shorter than this
-c int     Discard mappings of read queries longer than this
-d file    Discard read queries not in this file
-e file    Discard read queries in this file
-f file    Discard reference dbs not in this file
-g file    Discard reference dbs in this file
-h         Discard remaining suboptimal mappings
-i int     Discard remaining suboptimal mappings and discard any
           reads that have more remaining mappings than this
-j         Remove any unmatched nts in the very 3' end
-k         Output progress to standard output
```

## mirdeep2_perform_controls.pl

### Tool Description
Run the miRDeep2 core algorithm command line repeatedly on permuted RNAfold structures to estimate false positives

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/perform_controls.pl file_command_line file_structure rounds_controls

-a   Output progress to screen
```

## mirdeep2_permute_structure.pl

### Tool Description
Permute the order of the ids in an RNAfold output file

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/permute_structure.pl file_struct

Permutes the order of id's in a output file from RNAfold
```

## mirdeep2_prepare_signature.pl

### Tool Description
Prepare the signature file for miRDeep: map reads to potential precursors with bowtie and sort the mappings by precursor

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/prepare_signature.pl file_reads file_precursors read_align_edit_distance

This script prepares the signature file for miRDeep. Options:

-a file  Fasta file with the sequences of known mature miRNAs for the species.
         These sequences will not influence the miRDeep scoring, but will
         subsequently make it easy to estimate sensitivity of the run.
-b       Output progress to screen
```

## mirdeep2_remove_white_space_in_id.pl

### Tool Description
Remove everything after the first whitespace in the id lines of a fasta file (sequences are printed in upper case)

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/remove_white_space_in_id.pl file_fasta

Removes whitespaces from id line in a fasta file
```

## mirdeep2_rna2dna.pl

### Tool Description
Convert RNA sequences in a fasta file to DNA by substituting 'U' with 'T' (ids are cut at the first whitespace, sequences are printed in upper case)

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/rna2dna.pl file_fasta

Parses RNA sequences to DNA by substituting 'U's with 'T'.
```

## mirdeep2_samFLAGinfo.pl

### Tool Description
Translate a SAM FLAG number into its meaning (bits set, hexadecimal value and description)

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text

Please specify the FLAG number you want to have translated

usage:
	perl samFLAGinfo.pl [int]
```

## mirdeep2_sam_reads_collapse.pl

### Tool Description
Parse a SAM file and collapse identical reads (minus-strand reads are reverse complemented); the collapsed reads can be used as miRDeep2 input

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:  /usr/local/bin/sam_reads_collapse.pl  sam_file  reads_output_file

This script parses a sam file and collapses
reads. The reads_output_file can later on be
used as input for miRDeep2.
```

## mirdeep2_sanity_check_genome.pl

### Tool Description
Check a genome fasta file for miRDeep2: ids without whitespace and unique, sequences only [ACGTNacgtn].

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sanity_check_genome.pl genome.fa

Checks a genome fasta file (no help text in the script; read from the source).
Sequences may only comprise [ACGTNacgtn]. Identifiers must have no whitespace and must be unique.
It exits with an error message when the file is broken.
```

## mirdeep2_sanity_check_mapping_file.pl

### Tool Description
Check a mapping file for miRDeep2: every line must follow the arf format.

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sanity_check_mapping_file.pl mappings.arf

Checks that every line of an arf mapping file has the format:
read_id length start end read_seq genomic_id length start end genomic_seq strand mismatches editstring
It exits with an error message when a line is wrong.
```

## mirdeep2_sanity_check_mature_ref.pl

### Tool Description
Check a mature miRNA reference fasta file for miRDeep2: ids without whitespace, sequences only [ACGTUNacgtun].

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sanity_check_mature_ref.pl mature.fa

Checks a mature miRNA reference fasta file. Sequences may only comprise [ACGTUNacgtun].
Identifiers must have no whitespace. It exits with an error message when the file is broken.
```

## mirdeep2_sanity_check_reads_ready_file.pl

### Tool Description
Check a collapsed reads fasta file for miRDeep2: ids of the form name_number_xcount without whitespace, sequences of at least 17 letters [ACGTUNacgtun], no duplicate sequence within a sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sanity_check_reads_ready_file.pl reads_collapsed.fa

Checks a collapsed reads fasta file. Identifiers must have the format name_uniqueNumber_xnumber
(three-letter sample tag), sequences need at least 17 letters [ACGTUNacgtun] and must be unique within a sample.
It exits with an error message when the file is broken.
```

## mirdeep2_select_for_randfold.pl

### Tool Description
Identify potential precursors whose structure is consistent with Dicer recognition; the ids are printed one per line

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/select_for_randfold.pl file_signature file_structure

This script identifies potential precursors whose structure is basically consistent
with Dicer recognition. The relevant ids are outputted one id per line.
```

## mirdeep2_survey.pl

### Tool Description
Survey the prediction accuracy of miRDeep2 for all score cut-offs between -10 and 10

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/survey.pl output_mirdeep

Options:

-a file  file outputted by controls
-b file  mature miRNA fasta reference file for the species
-c file  signature file
-d int   read stack height necessary for triggering excision
```

## Metadata
- **Skill**: generated

## mirdeep2_mapper.pl

### Tool Description
Processes reads and/or maps them to the genome index.

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://www.mdc-berlin.de/8551903/en/research/research_teams/systems_biology_of_gene_regulatory_elements/projects/miRDeep
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1404980811: no space left on device
```

## mirdeep2_quantifier.pl

### Tool Description
The module maps the deep sequencing reads to predefined miRNA precursors and determines the counts for the respective mature miRNAs, star and loop sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://www.mdc-berlin.de/8551903/en/research/research_teams/systems_biology_of_gene_regulatory_elements/projects/miRDeep
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3878772788: no space left on device
```

## mirdeep2_bwa_sam_converter.pl

### Tool Description
Convert read mappings in SAM format (bwa or bowtie) to the miRDeep2 arf format, optionally collapsing the reads first

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
Arf file  not found

Error:
perl bwa_sam_converter.pl -i samfile -o reads_output_file -a arf_output_file

[options]:
	-i    file with read mappings in sam format
	-o    collapsed read output file
	-a    mapping file in arf format
	-c    collapse sam file first and create correct mirdeep2 ids
    -t    tag for temporary directory
	-n    do not delete temporary directory
```

## mirdeep2_clip_adapters.pl

### Tool Description
Remove 3' adapters from deep sequencing reads in a fasta file; works in sequence space

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/clip_adapters.pl file_fasta seq_adapter

Removes 3' adapters from deep sequencing reads. Works in sequence space.
```

## mirdeep2_collapse_reads_md.pl

### Tool Description
Collapse the reads in a fasta file so that each sequence entry is unique; identifiers have the form prefix_number_xcount

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/collapse_reads_md.pl file_fasta prefix

Collapses reads in the fasta file to make each sequence entry unique. Each collapsed
entry will have an identifier that follows an underscore '_' separated format. Example:

>mmu_1189273_x10

The first field 'mmu' shows which sample the sequence is from. This prefix is given on
the command line, and must consist of exactly three alphabetic letters. The second field
'118273' is a running number that secures that each identifier is unique. The third
field '_x10' shows how many times the given sequence was present in the dataset.

-a    outputs progress

example use:
collapse_reads.pl reads.fa mmu
```

## mirdeep2_convert_bowtie_output.pl

### Tool Description
Convert bowtie default-format read mappings (.bwt) to the miRDeep2 arf format

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/convert_bowtie_output.pl reads_mapped.bwt
```

## mirdeep2_excise_precursors.pl

### Tool Description
Excise potential miRNA precursor sequences from a genome using read mappings in arf format

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/excise_precursors.pl file_fasta file_arf precursor.coords

This script excises potential miRNA precursor sequences from a genome.
The fasta file should be the relevant genome, and the arf file should
contain the read mappings.
The precursors.coords designates where to write the precursor genome coordinates to.

-a integer   Only excise if the potential mature microRNA is represented
             by a number of reads equal to or higher than the integer
             (default 2).
-b           Output progress to screen
```

## mirdeep2_excise_precursors_iterative_final.pl

### Tool Description
Excise potential miRNA precursor sequences from a genome, raising the read stack height until fewer than the maximum number of precursors remain

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/excise_precursors_iterative_final.pl file_fasta file_arf precursor.coords file_output pres_max

This script excises potential miRNA precursor sequences from a genome.
The fasta file should be the relevant genome, and the arf file should
contain the read mappings.
The precursors.coords designates where to write the precursor genome coordinates to.

-b           Output progress to screen
```

## mirdeep2_extract_miRNAs.pl

### Tool Description
Extract the miRNA entries of one or more species (three-letter codes) from a miRBase fasta file; sequences are written in DNA alphabet

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Specify species or comma separated list of species

Usage:
	perl /usr/local/bin/extract_miRNAs.pl miRBase_fasta_file species [mature/star]
	e.g. /usr/local/bin/extract_miRNAs.pl mature.fa cel mature
```

## mirdeep2_fastaparse.pl

### Tool Description
Parse a fasta file: remove short entries and entries with non-nucleotide letters

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/fastaparse.pl fastafile

This script parses a fastafile.

-a int    only output entries where the sequence is minimum int nts long
-b        remove all entries that have a sequence that contains letters
          other than a,c,g,t,u,n,A,C,G,T,U,N.
-s        output progress
```

## mirdeep2_fastaselect.pl

### Tool Description
Print the fasta entries whose identifier is present (or, with invert, absent) in an identifier file

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/fastaselect.pl file_fasta idfile (-a)

This script only prints out the fastaentries that has an id
that is present in the idfile. Using the option -a only prints
out entries that has an id that is not present in the id file.
```

## mirdeep2_fastq2fasta.pl

### Tool Description
Convert a fastq file to fasta format; reads are renamed seq_<number>

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 

 /usr/local/bin/fastq2fasta.pl fastq file > outputfile
```

## mirdeep2_find_read_count.pl

### Tool Description
Find the total read count of a collapsed fasta file whose identifiers end in the '_x<count>' format

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/find_read_count.pl file_fasta

finds the total read count if '_x\d' format is used.
```

## mirdeep2_geo2fasta.pl

### Tool Description
Read all deflated GEO sample files (<prefix>*.txt with a sequence and a read count per line) and write one fasta file with the valid sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
perl geo2fasta.pl GSM > outfile

reads in all files starting with GEO and produces one big output files containing only valid sequences

modified by Sebastian M
```

## mirdeep2_get_mirdeep2_precursors.pl

### Tool Description
Extract the precursor, mature or star sequences (fasta) and genome coordinates (bed) of novel, known and not detected miRNAs from a miRDeep2 result csv file

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: get_mirdeep2_precursors.pl -r result.csv  [options]

[options]
	-s [int]	output only precursors with min-score >= [int]
	-t [int]	output only precursors with score     <  [int]
	-d      	output dna instead of rna
	-p      	make simple id with the name only
	-h      	print this help message
	-m      	get_mature instead of precursor
	-k      	get_star instead of precursor
	-T      	Trackname for bedfiles
	-o      	outdir
```

## mirdeep2_illumina_to_fasta.pl

### Tool Description
Parse Illumina _seq.txt (or qseq.txt) read files to fasta format; reads are named seq_<number> and dots are converted to N

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/illumina_to_fasta.pl _seq.txt

This script parses _seq.txt to fasta format. Options:
-a    format is qseq.txt

Example of use:
/usr/local/bin/illumina_to_fasta.pl mouse_seq.txt > mouse.fa
```

## mirdeep2_make_html.pl

### Tool Description
Create the miRDeep2 result html and csv files (and the read signature pdfs) from a miRDeep2 output.mrd file

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
[usage]
	perl make_html.pl -f miRDeep_outfile [options]

[options]
-v 2	 only output hairpins with score above 2
-c	 also create overview in excel format.
-k file	 supply file with known miRNAs
-s file	 supply survey file if score cutoff is used to get information about how big is the confidence of resulting reads


-e 	 report complete survey file
-g 	 report survey for current score cutoff
-r file	 Rfam file to check for already reported small RNA sequences

-q file	 miRBase.mrd file produced by quantifier module
-x file	 signature.arf file with mapped reads to precursors
-t spec	 specify the organism from which your sequencing data was obtained
-u 	 print all available UCSC input organisms
-y 	timestamp of this run
-o 	sort signature by sample in pdf file, default is by beginning position
-d 	 do not generate pdfs


-a 	print genomic coordinates of mature sequence (still testing)
-b 	supply confidence file
-V 	miRDeep2 version used
```

## mirdeep2_make_html2.pl

### Tool Description
Create the miRDeep2 expression html page of the quantifier module (variant of make_html.pl that reports the expression of known miRNAs)

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text
[usage]
	perl make_html.pl -f miRDeep_outfile [options]

[options]
-v 2	 only output hairpins with score above 2
-c	 also create overview in excel format.
-k file	 supply file with known miRNAs
-s file	 supply survey file if score cutoff is used to get information about how big is the confidence of resulting reads


-e 	 report complete survey file
-g 	 report survey for current score cutoff
-r file	 Rfam file to check for already reported small RNA sequences

-q file	 miRBase.mrd file produced by quantifier module
-x file	 signature.arf file with mapped reads to precursors
-t spec	 specify the organism from which your sequencing data was obtained
-u 	 print all available UCSC input organisms
-y 	timestamp of this run
-o 	sort signature by sample in pdf file, default is by beginning position
-d 	 do not generate pdfs


-a 	print genomic coordinates of mature sequence (still testing)
-l 	be stringent when assigning miRNA-precursor connections like mmu-mir only is assigned to mmu-precursor
```
