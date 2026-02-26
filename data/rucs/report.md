# rucs CWL Generation Report

## rucs

### Tool Description
RUCS: Robust Universal primer and probe design for DNA sequencing

### Metadata
- **Docker Image**: quay.io/biocontainers/rucs:1.0.3--hdfd78af_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/rucs/src/master/
- **Package**: https://anaconda.org/channels/bioconda/packages/rucs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rucs/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-06-03
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: rucs [-h] [--positives POSITIVES [POSITIVES ...]]
            [--negatives NEGATIVES [NEGATIVES ...]]
            [--references REFERENCES [REFERENCES ...]] [--reference REFERENCE]
            [--template TEMPLATE] [--pairs PAIRS]
            [--settings_file SETTINGS_FILE] [--kmer_size KMER_SIZE]
            [--read_length READ_LENGTH] [--tm_threshold TM_THRESHOLD]
            [--primer_pair_max_diff_tm PRIMER_PAIR_MAX_DIFF_TM]
            [--dna_conc DNA_CONC] [--dna_conc_probe DNA_CONC_PROBE]
            [--salt_monovalent_conc SALT_MONOVALENT_CONC]
            [--salt_divalent_conc SALT_DIVALENT_CONC] [--dntp_conc DNTP_CONC]
            [--anneal_tm ANNEAL_TM] [--max_3end_gc MAX_3END_GC]
            [--product_size_min PRODUCT_SIZE_MIN]
            [--product_size_max PRODUCT_SIZE_MAX] [--pick_probe]
            [--annotation_evalue ANNOTATION_EVALUE]
            entry_point

positional arguments:
  entry_point

options:
  -h, --help            show this help message and exit
  --positives POSITIVES [POSITIVES ...]
                        File paths for the positive dataset
  --negatives NEGATIVES [NEGATIVES ...]
                        File paths for the nagetive dataset
  --references REFERENCES [REFERENCES ...]
                        File paths for the references to be tested
  --reference REFERENCE
                        The reference file to which the k-mers should be
                        mapped.
  --template TEMPLATE   File path for the template file
  --pairs PAIRS         File containing pcr primer pair sets (1 pair per line,
                        tab-separated sequences, format: forward, reverse,
                        probe*) *optional
  --settings_file SETTINGS_FILE
                        File containing the default settings for this program
  --kmer_size KMER_SIZE
                        This will overwrite the set value in the settings
  --read_length READ_LENGTH
                        This option will modify min_seq_len_pos and
                        min_seq_len_neg in the settings file
  --tm_threshold TM_THRESHOLD
                        This will overwrite the set value in the settings
  --primer_pair_max_diff_tm PRIMER_PAIR_MAX_DIFF_TM
                        This will overwrite the set value in the settings
  --dna_conc DNA_CONC   This will overwrite the set value in the settings
  --dna_conc_probe DNA_CONC_PROBE
                        This will overwrite the set value in the settings
  --salt_monovalent_conc SALT_MONOVALENT_CONC
                        This will overwrite the set value in the settings
  --salt_divalent_conc SALT_DIVALENT_CONC
                        This will overwrite the set value in the settings
  --dntp_conc DNTP_CONC
                        This will overwrite the set value in the settings
  --anneal_tm ANNEAL_TM
                        This will modify the appropriate values in the
                        settings
  --max_3end_gc MAX_3END_GC
                        This will overwrite the set value in the settings
  --product_size_min PRODUCT_SIZE_MIN
                        This will overwrite the set value in the settings
  --product_size_max PRODUCT_SIZE_MAX
                        This will overwrite the set value in the settings
  --pick_probe          This will overwrite the set value in the settings
  --annotation_evalue ANNOTATION_EVALUE
                        This will overwrite the set value in the settings
```

