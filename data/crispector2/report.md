# crispector2 CWL Generation Report

## crispector2_crispector

### Tool Description
Accurate estimation of genome editing translocation and NHEJ off-target activity from comparative NGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/crispector2:2.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/theAguy/crispector2
- **Package**: https://anaconda.org/channels/bioconda/packages/crispector2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crispector2/overview
- **Total Downloads**: 7.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/theAguy/crispector2
- **Stars**: N/A
### Original Help Text
```text
Usage: crispector [OPTIONS]

  Accurate estimation of genome editing translocation and NHEJ off-target
  activity from comparative NGS data

Options:
  -t_r1, --tx_in1 PATH            Tx read 1 input path or Tx merged FASTQ file
  -t_r2, --tx_in2 PATH            Tx read 2 input path, if FASTQ files aren't
                                  merged [OPTIONAL]
  -m_r1, --mock_in1 PATH          Mock read 1 input path or mock merged FASTQ
                                  file
  -m_r2, --mock_in2 PATH          Mock read read 2 input path, if FASTQ files
                                  aren't merged [OPTIONAL]
  -c, --experiment_config PATH    A CSV (Comma Separated Values‏) file with
                                  the experiment data. Table has 11 columns:
                                  SiteName, AmpliconReference, gRNA, OnTarget,
                                  ForwardPrimer, ReversePrimer,TxInput1Path
                                  TxInput2Path, MockInput1Path,
                                  MockInput2Path, DonorReference. The first 4
                                  columns are required, the rest are optional.
                                  Header should be specified by the above
                                  order. Please check the README on GitHub
                                  further details and examples.  [required]
  -o, --report_output PATH        Path to output folder
  --cut_site_position INTEGER     Expected cut-site position with respect to
                                  the 3' end of the provided sgRNA sequence.
                                  Note, the sgRNA sequence must be entered
                                  without the PAM.  [default: -3]
  --crispector_config PATH        Path to crispector configuration in YAML
                                  format.See "Advanced usage" section in
                                  README on GitHub for further.
  --fastp_options_string TEXT     Try "fastp --help" for more details
  --min_num_of_reads INTEGER      Minimum number of reads (per locus site) to
                                  evaluate edit events  [default: 500]
  --min_read_length_without_primers INTEGER
                                  Filter out any read shorter than
                                  min_read_length_without_primers + length of
                                  forward and reverse primers. This threshold
                                  filters primer-dimmer effect reads.
                                  [default: 10]
  --max_edit_distance_on_primers INTEGER
                                  Maximum edit distance to consider a read
                                  prefix (or suffix) as a match for a primer.
                                  [default: 8]
  --amplicon_min_score FLOAT RANGE
                                  Minimum normalized alignment score to
                                  consider a read alignment as valid.
                                  Normalized alignment score is defined as the
                                  Needleman-Wunch alignment score divided by
                                  the maximum possible score. Below this
                                  alignment threshold, reads are discarded.
                                  [default: 30; 0<=x<=100]
  --translocation_amplicon_min_score FLOAT RANGE
                                  Minimum alignment score to consider a read
                                  with primer inconsistency as a possible
                                  translocation. Should be higher than
                                  --amplicon_min_score, because translocations
                                  reads are noisier.Score is normalized
                                  between 0 (not even one bp match) to 100
                                  (read is identical to the reference)
                                  [default: 80; 0<=x<=100]
  --min_editing_activity FLOAT RANGE
                                  Minimum editing activity (%). Sites with
                                  editing activity lower than the minimum,
                                  will be discarded from the translocation
                                  detection.  [default: 0.1; x<=None]
  --translocation_p_value FLOAT RANGE
                                  Translocations statistical significance
                                  level. This threshold is applied on the
                                  corrected p_value,FDR (false discovery
                                  rate).  [default: 0.05; x<=None]
  --disable_translocations        Disable translocations detection
  --override_noise_estimation     Override noise estimation with default q
                                  parameter from crispector_config file. It's
                                  advisable to set this flag for experiment
                                  with a low number of off-target sites (<5).
                                  q is defined as the probability of an indel
                                  to occur through an edit event. Check
                                  CRISPECTOR paper for more details.
  --confidence_interval FLOAT RANGE
                                  Confidence interval for the evaluated
                                  editing activity  [default: 0.95; 0<=x<=1]
  --enable_substitutions          Enable substitutions events for the
                                  quantification of edit events
  --suppress_site_output          Do not create plots for sites (save memory
                                  and runtime)
  --keep_intermediate_files       Keep intermediate files for debug purposes
                                  [required]
  --verbose                       Higher verbosity
  --snv_ratio TEXT                For a single position along single
                                  amplicon's data reads, if the entropy of the
                                  ratio is lower than the given ratio, don't
                                  count this position as potential snv. Has to
                                  be tuple that sums to 1  [default:
                                  (0.8,0.2)]
  --max_potential_snvs INTEGER    Maximum possible SNVs that may be occur in
                                  the experiment. Above that - certainly
                                  noise.  [default: 5]
  --max_allele_mismatches INTEGER
                                  maximum mismatches allowed when aligning
                                  guide to amplicon (both mock and tx) in the
                                  allelic case  [default: 5]
  --max_len_snv_ctc INTEGER       maximum length from cut site to snv that
                                  consider to be close to cut-site (ctc)
                                  [default: 10]
  --random_reads_percentage_threshold FLOAT
                                  The percentage of reads that if the
                                  algorithm cannot decide to which allele to
                                  classify them, this site won't be analyzed
                                  in the allele case  [default: 0.5]
  --allele                        Flag for analyzing alleles. The default is
                                  False, however if alleles are  needed, set
                                  the flag
  -h, --help                      Show this message and exit.
```

