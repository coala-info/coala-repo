# olga CWL Generation Report

## olga_olga-compute_pgen

### Tool Description
Compute Pgens for TCR and Ig sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/olga:1.3.0--pyh7e72e81_0
- **Homepage**: https://github.com/zsethna/OLGA
- **Package**: https://anaconda.org/channels/bioconda/packages/olga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/olga/overview
- **Total Downloads**: 883
- **Last updated**: 2025-11-19
- **GitHub**: https://github.com/zsethna/OLGA
- **Stars**: N/A
### Original Help Text
```text
Usage: olga-compute_pgen [options]

Options:
  -h, --help            show this help message and exit
  --humanTRA, --human_T_alpha
                        use default human TRA model (T cell alpha chain)
  --humanTRB, --human_T_beta
                        use default human TRB model (T cell beta chain)
  --mouseTRB, --mouse_T_beta
                        use default mouse TRB model (T cell beta chain)
  --mouseTRA, --mouse_T_alpha
                        use default mouse TRA model (T cell alpha chain)
  --humanIGH, --human_B_heavy
                        use default human IGH model (B cell heavy chain)
  --humanIGL, --human_B_lambda
                        use default human IGL model (B cell light lambda
                        chain)
  --humanIGK, --human_B_kappa
                        use default human IGK model (B cell light kappa chain)
  --mouseIGH, --mouse_B_heavy
                        use default mouse IGH model (B cell heavy chain)
  --mouseIGK, --mouse_B_kappa
                        use default mouse IGK model (B cell light kappa chain)
  --mouseIGL, --mouse_B_lambda
                        use default mouse IGL model (B cell light lambda
                        chain)
  --set_custom_model_VDJ=PATH/TO/FOLDER/
                        specify PATH/TO/FOLDER/ for a custom VDJ generative
                        model
  --set_custom_model_VJ=PATH/TO/FOLDER/
                        specify PATH/TO/FOLDER/ for a custom VJ generative
                        model
  -i PATH/TO/FILE, --infile=PATH/TO/FILE
                        read in CDR3 sequences (and optionally V/J masks) from
                        PATH/TO/FILE
  -o PATH/TO/FILE, --outfile=PATH/TO/FILE
                        write CDR3 sequences and pgens to PATH/TO/FILE
  --seq_in=INDEX, --seq_index=INDEX
                        specifies sequences to be read in are in column INDEX.
                        Default is index 0 (the first column).
  --v_in=INDEX, --v_mask_index=INDEX
                        specifies V_masks are found in column INDEX in the
                        input file. Default is no V mask.
  --j_in=INDEX, --j_mask_index=INDEX
                        specifies J_masks are found in column INDEX in the
                        input file. Default is no J mask.
  --v_mask=V_MASK       specify V usage to condition Pgen on for seqs read in
                        as arguments.
  --j_mask=J_MASK       specify J usage to condition Pgen on for seqs read in
                        as arguments.
  -m N, --max_number_of_seqs=N
                        compute Pgens for at most N sequences.
  --lines_to_skip=N     skip the first N lines of the file. Default is 0.
  -a PATH/TO/FILE, --alphabet_filename=PATH/TO/FILE
                        specify PATH/TO/FILE defining a custom 'amino acid'
                        alphabet. Default is no custom alphabet.
  --seq_type_out=SEQ_TYPE
                        if read in sequences are ntseqs, declare what type of
                        sequence to compute pgen for. Default is all. Choices:
                        'all', 'ntseq', 'nucleotide', 'aaseq', 'amino_acid'
  --skip_off, --skip_empty_off
                        stop skipping empty or blank sequences/lines (if for
                        example you want to keep line index fidelity between
                        the infile and outfile).
  --display_off         turn the sequence display off (only applies in write-
                        to-file mode). Default is on.
  --num_lines_for_display=N
                        N lines of the output file are displayed when sequence
                        display is on. Also used to determine the number of
                        sequences to average over for speed and time
                        estimates.
  --time_updates_off    turn time updates off (only applies when sequence
                        display is disabled).
  --seqs_per_time_update=N
                        specify the number of sequences between time updates.
                        Default is 1e5.
  -d DELIMITER, --delimiter=DELIMITER
                        declare infile delimiter. Default is tab for .tsv
                        input files, comma for .csv files, and any whitespace
                        for all others. Choices: 'tab', 'space', ',', ';', ':'
  --raw_delimiter=DELIMITER
                        declare infile delimiter as a raw string.
  --delimiter_out=DELIMITER_OUT
                        declare outfile delimiter. Default is tab for .tsv
                        output files, comma for .csv files, and the infile
                        delimiter for all others. Choices: 'tab', 'space',
                        ',', ';', ':'
  --raw_delimiter_out=DELIMITER_OUT
                        declare for the delimiter outfile as a raw string.
  --gene_mask_delimiter=GENE_MASK_DELIMITER
                        declare gene mask delimiter. Default comma unless
                        infile delimiter is comma, then default is a
                        semicolon. Choices: 'tab', 'space', ',', ';', ':'
  --raw_gene_mask_delimiter=GENE_MASK_DELIMITER
                        declare delimiter of gene masks as a raw string.
  --comment_delimiter=COMMENT_DELIMITER
                        character or string to indicate comment or header
                        lines to skip.
  --skip_fast_pgen      Skip the numba implementation to calculate Pgen, which
                        is much faster.
```


## olga_olga-generate_sequences

### Tool Description
Generates CDR3 sequences using VDJ generative models.

### Metadata
- **Docker Image**: quay.io/biocontainers/olga:1.3.0--pyh7e72e81_0
- **Homepage**: https://github.com/zsethna/OLGA
- **Package**: https://anaconda.org/channels/bioconda/packages/olga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: olga-generate_sequences [options]

Options:
  -h, --help            show this help message and exit
  --humanTRA, --human_T_alpha
                        use default human TRA model (T cell alpha chain)
  --humanTRB, --human_T_beta
                        use default human TRB model (T cell beta chain)
  --mouseTRB, --mouse_T_beta
                        use default mouse TRB model (T cell beta chain)
  --mouseTRA, --mouse_T_alpha
                        use default mouse TRA model (T cell alpha chain)
  --humanIGH, --human_B_heavy
                        use default human IGH model (B cell heavy chain)
  --humanIGK, --human_B_kappa
                        use default human IGK model (B cell light kappa chain)
  --humanIGL, --human_B_lambda
                        use default human IGL model (B cell light lambda
                        chain)
  --mouseIGH, --mouse_B_heavy
                        use default mouse IGH model (B cell heavy chain)
  --mouseIGK, --mouse_B_kappa
                        use default mouse IGK model (B cell light kappa chain)
  --mouseIGL, --mouse_B_lambda
                        use default mouse IGL model (B cell light lambda
                        chain)
  --VDJ_model_folder=PATH/TO/FOLDER/, --set_custom_model_VDJ=PATH/TO/FOLDER/
                        specify PATH/TO/FOLDER/ for a custom VDJ generative
                        model
  --VJ_model_folder=PATH/TO/FOLDER/, --set_custom_model_VJ=PATH/TO/FOLDER/
                        specify PATH/TO/FOLDER/ for a custom VJ generative
                        model
  -o PATH/TO/FILE, --outfile=PATH/TO/FILE
                        write CDR3 sequences to PATH/TO/FILE
  -n N, --num_seqs=N    specify the number of sequences to generate.
  --seed=SEED           set seed for pseudorandom number generator. Default is
                        to not set a seed.
  --seqs_per_time_update=SEQS_PER_TIME_UPDATE
                        specify the number of sequences between time updates.
                        Default is 1e5
  --conserved_J_residues=CONSERVED_J_RESIDUES
                        specify conserved J residues. Default is 'FVW'.
  --time_updates_off    turn time updates off.
  --seq_type=SEQ_TYPE   declare sequence type for output sequences. Choices:
                        'all' [default], 'ntseq', 'nucleotide', 'aaseq',
                        'amino_acid'
  --record_genes_off    turn off recording V and J gene info.
  -d DELIMITER, --delimiter=DELIMITER
                        declare delimiter choice. Default is tab for .tsv
                        output files, comma for .csv files, and tab for all
                        others. Choices: 'tab', 'space', ',', ';', ':'
  --raw_delimiter=DELIMITER
                        declare delimiter choice as a raw string.
```


## Metadata
- **Skill**: generated
