# pytransaln CWL Generation Report

## pytransaln_align

### Tool Description
Align nucleotide sequences and translate them to amino acids, handling reading frames and stop codons.

### Metadata
- **Docker Image**: quay.io/biocontainers/pytransaln:0.2.2--pyh7e72e81_0
- **Homepage**: https://github.com/monagrland/pytransaln
- **Package**: https://anaconda.org/channels/bioconda/packages/pytransaln/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pytransaln/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/monagrland/pytransaln
- **Stars**: N/A
### Original Help Text
```text
usage: pytransaln align [-h] [--how HOW] [--maxstops MAXSTOPS] [--frame FRAME]
                        [--aligner ALIGNER] [--out_aa OUT_AA]
                        [--out_bad OUT_BAD] [--out_aln_aa OUT_ALN_AA]
                        [--out_aln_nt OUT_ALN_NT]
                        [--out_aln_nt_aug OUT_ALN_NT_AUG]
                        [--out_bad_fs_report OUT_BAD_FS_REPORT]
                        [--threads THREADS]

options:
  -h, --help            show this help message and exit
  --how HOW             How to choose reading frame: 'each' - find reading
                        frame that minimizes stop codons for each individual
                        sequence; may result in more than one possible frame
                        per sequence; 'cons' - find frame that minimizes stop
                        codons across all sequences and apply that frame too
                        all sequences; 'user' - user specified reading frame
                        at option --frame
  --maxstops MAXSTOPS   Max stop codons to allow in 'good' alignment; nt
                        sequences over this threshold in all frames will be
                        written to --out_bad
  --frame FRAME         Reading frame offset to apply to all sequences, must
                        be 0, 1, or 2; overridden by --how each or --how cons
  --aligner ALIGNER     Alignment program to use (only MAFFT implemented at
                        the moment)
  --out_aa OUT_AA       Path to write aa translations with <=MAXSTOPS stop
                        codons
  --out_bad OUT_BAD     Path to write nt sequences with too many stop codons
                        (putative pseudogenes)
  --out_aln_aa OUT_ALN_AA
                        Path to write initial aa alignment
  --out_aln_nt OUT_ALN_NT
                        Path to write initial codon alignment
  --out_aln_nt_aug OUT_ALN_NT_AUG
                        Path to write codon alignment augmented with putative
                        pseudogenes
  --out_bad_fs_report OUT_BAD_FS_REPORT
                        Path to write report on likely frameshifts in putative
                        pseudogenes
  --threads THREADS     Number of threads to pass to alignment program
```


## pytransaln_stats

### Tool Description
Calculate statistics from translated alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/pytransaln:0.2.2--pyh7e72e81_0
- **Homepage**: https://github.com/monagrland/pytransaln
- **Package**: https://anaconda.org/channels/bioconda/packages/pytransaln/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pytransaln stats [-h] [--out_hist_hmm OUT_HIST_HMM]
                        [--out_mqc_hmm OUT_MQC_HMM]
                        [--out_screened OUT_SCREENED] [--out_stats OUT_STATS]
                        [--out_hist_spf OUT_HIST_SPF]
                        [--out_mqc_spf OUT_MQC_SPF]
                        [--out_hist_mins OUT_HIST_MINS]
                        [--out_mqc_mins OUT_MQC_MINS]

options:
  -h, --help            show this help message and exit
  --out_hist_hmm OUT_HIST_HMM
                        Path to plot histogram of HMM bit scores
  --out_mqc_hmm OUT_MQC_HMM
                        Path to write histogram of HMM bit scores in JSON
                        format for MultiQC
  --out_screened OUT_SCREENED
                        Path to write sequences that passed screening, Fasta
                        format
  --out_stats OUT_STATS
                        Path to write per-frame stop codon statistics
  --out_hist_spf OUT_HIST_SPF
                        Path to plot histogram of stops per reading frame
  --out_mqc_spf OUT_MQC_SPF
                        Path to write counts of stops per reading frame in
                        JSON format for MultiQC
  --out_hist_mins OUT_HIST_MINS
                        Path to plot histogram of minimum stop codons per
                        sequence
  --out_mqc_mins OUT_MQC_MINS
                        Path to write counts of minimum stop codons per
                        sequence in JSON format for MultiQC
```

