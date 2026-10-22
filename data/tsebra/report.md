# tsebra CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tsebra | PASS | output identical to the Galaxy test output for braker.gtf and hintsfile.gff |
| tsebra_best_by_compleasm | Not completed | needs a BRAKER result folder, compleasm and a BUSCO lineage database |
| tsebra_fix_gtf_ids | PASS | output identical to the repository example files |
| tsebra_get_longest_isoform | PASS | one transcript per gene locus on two real BRAKER gene sets |
| tsebra_get_overlapping_genes | PASS |  |
| tsebra_rename_gtf | PASS |  |

## tsebra

### Tool Description
TSEBRA: Transcript Selector for BRAKER; combines gene predictions by selecting transcripts based on extrinsic evidence.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
- **Homepage**: https://github.com/Gaius-Augustus/TSEBRA
- **Package**: https://anaconda.org/channels/bioconda/packages/tsebra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsebra.py [-h] [-g GTF] [-k KEEP_GTF] [-e HINTFILES] [-c CFG]
                 [--filter_single_exon_genes] [--ignore_tx_phase]
                 [-s SCORE_TAB] -o OUT [-q] [-v VERBOSE]

TSEBRA: Transcript Selector for BRAKER TSEBRA combines gene predictions by
selecing transcripts based on their extrisic evidence support.

options:
  -h, --help            show this help message and exit
  -g GTF, --gtf GTF     List (separated by commas) of gene prediciton files in
                        gtf. (e.g.
                        gene_pred1.gtf,gene_pred2.gtf,gene_pred3.gtf)
  -k KEEP_GTF, --keep_gtf KEEP_GTF
                        List (separated by commas) of gene prediciton files in
                        gtf. These gene sets are used the same way as other
                        inputs, but TSEBRA ensures that all transcripts from
                        these gene sets are included in the output.
  -e HINTFILES, --hintfiles HINTFILES
                        List (separated by commas) of files containing
                        extrinsic evidence in gff. (e.g.
                        hintsfile1.gff,hintsfile2.gtf,3.gtf)
  -c CFG, --cfg CFG     Configuration file that sets the parameter for TSEBRA.
                        You can find the recommended parameter at
                        config/default.cfg.
  --filter_single_exon_genes
                        Filter out all single-exon genes out that are not
                        supported by at least one start- or stop-codon hint.
  --ignore_tx_phase     Ignore the phase of transcripts while detecting
                        clusters of overlapping transcripts.
  -s SCORE_TAB, --score_tab SCORE_TAB
                        Prints the transcript scores as a table to the
                        specified file.
  -o OUT, --out OUT     Outputfile for the combined gene prediciton in gtf.
  -q, --quiet           Quiet mode.
  -v VERBOSE, --verbose VERBOSE
```

## tsebra_get_longest_isoform

### Tool Description
Combine gene sets by choosing the isoform with the longest coding sequence for each gene locus.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
- **Homepage**: https://github.com/Gaius-Augustus/TSEBRA
- **Package**: https://anaconda.org/channels/bioconda/packages/tsebra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: get_longest_isoform.py [-h] -g GTF -o OUT [-q] [-v VERBOSE]

Combine gene sets by choosing the isoform with the longes coding sequence for
each gene locus.

options:
  -h, --help            show this help message and exit
  -g GTF, --gtf GTF     List (separated by commas) of gene prediciton files in
                        gtf. (e.g.
                        gene_pred1.gtf,gene_pred2.gtf,gene_pred3.gtf)
  -o OUT, --out OUT     Outputfile for the combined gene prediciton in gtf.
  -q, --quiet           Quiet mode.
  -v VERBOSE, --verbose VERBOSE
```

## tsebra_rename_gtf

### Tool Description
Renames the transcripts and genes of a GTF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
- **Homepage**: https://github.com/Gaius-Augustus/TSEBRA
- **Package**: https://anaconda.org/channels/bioconda/packages/tsebra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rename_gtf.py [-h] --gtf GTF [--prefix PREFIX]
                     [--translation_tab TRANSLATION_TAB] --out OUT

Renames the transcripts and genes of a GTF file.

options:
  -h, --help            show this help message and exit
  --gtf GTF             Path to a gene prediciton file in GTF format, for
                        example the output of TSEBRA.
  --prefix PREFIX       The string is added as a prefix to all transcript and
                        gene IDs.
  --translation_tab TRANSLATION_TAB
                        Writes the translation table for old transcript IDs to
                        new transcript IDs to the given file path.
  --out OUT             Path to the output file.
```

## tsebra_fix_gtf_ids

### Tool Description
Fix the gene and transcript IDs of a GTF file so that TSEBRA can read it.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
- **Homepage**: https://github.com/Gaius-Augustus/TSEBRA
- **Package**: https://anaconda.org/channels/bioconda/packages/tsebra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fix_gtf_ids.py [-h] [--gtf GTF] [--out OUT]

options:
  -h, --help  show this help message and exit
  --gtf GTF
  --out OUT
```

## tsebra_get_overlapping_genes

### Tool Description
Compare two gene sets in GTF format and write GTF files with overlapping and not overlapping genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
- **Homepage**: https://github.com/Gaius-Augustus/TSEBRA
- **Package**: https://anaconda.org/channels/bioconda/packages/tsebra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: get_overlapping_genes.py [-h] [-g1 GENESET1] [-g2 GENESET2] -o OUT [-q]
                                [-v VERBOSE]

Input: Two gtf files; Output: 3 GTF files with overlapping/not overlapping
genes.

options:
  -h, --help            show this help message and exit
  -g1 GENESET1, --geneset1 GENESET1
  -g2 GENESET2, --geneset2 GENESET2
  -o OUT, --out OUT
  -q, --quiet           Quiet mode.
  -v VERBOSE, --verbose VERBOSE
```

## tsebra_best_by_compleasm

### Tool Description
Find or build the best gene set generated with BRAKER and TSEBRA minimizing missing BUSCOs using compleasm.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
- **Homepage**: https://github.com/Gaius-Augustus/TSEBRA
- **Package**: https://anaconda.org/channels/bioconda/packages/tsebra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: best_by_compleasm.py [-h] -m TMP_DIR [-c COMPLEASM_BIN] -d INPUT_DIR
                            [-y TSEBRA] [-f GETANNO] -g GENOME [-t THREADS] -p
                            BUSCO_DB [-n MISSING_BUSCO_THRESHOLD]
                            [-a DIFF_TO_BRAKER] [-v]

Find or build the best gene set generated with BRAKER and TSEBRA minimizing
missing BUSCOs using compleasm. Will only compute a new BRAKER gene set if the
percentage of missing BUSCOs exceeds 5%.

options:
  -h, --help            show this help message and exit
  -m TMP_DIR, --tmp_dir TMP_DIR
                        Temporary directory where intermediate files will be
                        written
  -c COMPLEASM_BIN, --compleasm_bin COMPLEASM_BIN
                        Location of compleasm.py on system
  -d INPUT_DIR, --input_dir INPUT_DIR
                        Output directory of BRAKER
  -y TSEBRA, --tsebra TSEBRA
                        Location of tesbra.py on system
  -f GETANNO, --getanno GETANNO
                        Location of getAnnoFastaFromJoingenes.py on system
  -g GENOME, --genome GENOME
                        Genome FASTA file
  -t THREADS, --threads THREADS
                        Number of threads to use for running compleasm
  -p BUSCO_DB, --busco_db BUSCO_DB
                        BUSCO lineage for running compleasm
  -n MISSING_BUSCO_THRESHOLD, --missing_busco_threshold MISSING_BUSCO_THRESHOLD
                        Threshold for the percentage of missing BUSCOs that
                        decides until which point the BUSCOs in augustus and
                        genemark gene sets will simply be added on top of the
                        braker.gtf gene set, upper boundary.
  -a DIFF_TO_BRAKER, --diff_to_braker DIFF_TO_BRAKER
                        Difference in percentage of missing BUSCOs between
                        braker.gtf and the other gene sets that is allowed for
                        the BUSCOs in the augustus and genemark gene sets to
                        be added on top of the braker.gtf gene set.
  -v, --version         show program's version number and exit
```

## Metadata
- **Skill**: generated

