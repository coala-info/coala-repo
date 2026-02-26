# neffy-cli CWL Generation Report

## neffy-cli_neff

### Tool Description
This program computes the Number of Effective Sequences (NEFF) for a given multiple sequence alignment (MSA).
NEFF is used to assess the diversity of sequences by accounting for redundancy and sequence similarity.

### Metadata
- **Docker Image**: quay.io/biocontainers/neffy-cli:0.1.1--h9948957_0
- **Homepage**: https://maryam-haghani.github.io/NEFFy
- **Package**: https://anaconda.org/channels/bioconda/packages/neffy-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/neffy-cli/overview
- **Total Downloads**: 573
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Maryam-Haghani/NEFFy
- **Stars**: N/A
### Original Help Text
```text
Handled Error: Missing value for required flag: file


NEFF - Number of Effective Sequences Computation Tool

Description:
  This program computes the Number of Effective Sequences (NEFF) for a given multiple sequence alignment (MSA).
  NEFF is used to assess the diversity of sequences by accounting for redundancy and sequence similarity.

Usage:
  ./neff --file=<input_file> [options]

Options:
  --file=<input_file>
      Input file(s) containing the MSA(s). Multiple files can be specified as a comma-separated list (without spaces).
      (Required)

  --format=<input_format>
      Format(s) of the input file(s) (comma-separated, no spaces).
      (Optional)

  --alphabet=<value>
      Specifies the valid alphabet for the sequences:
        0 : Protein (default)
        1 : RNA
        2 : DNA

  --check_validation=<true/false>
      Whether to validate sequences to include only letters from the chosen alphabet.
      (Default: false)

  --threshold=<value>
      Similarity threshold (Θ) used to decide if two sequences are considered similar.
      (Default: 0.8)

  --norm=<value>
      NEFF normalization option:
        0 : Normalize by sqrt(Length of alignment) (default)
        1 : Normalize by Length of alignment
        2 : No normalization

  --omit_query_gaps=<true/false>
      If true, gap positions in the query (first) sequence are omitted from all sequences.
      (Default: true)

  --is_symmetric=<true/false>
      Determines whether gap positions are considered in similarity cutoff computation (symmetric) or not (asymmetric).
      (Default: true, meaning symmetric)

  --non_standard_option=<value>
      Determines how non-standard letters are handled:
        0 : AsStandard (default)
        1 : ConsiderGapInCutoff
        2 : ConsiderGap

  --depth=<value>
      Limits the number of sequences (MSA depth) considered in the computation.
      (Default: use all sequences in the input file)

  --gap_cutoff=<value>
      Removes alignment positions where the fraction of gaps is greater than or equal to this value.
      (Default: 1, meaning no positions are removed)

  --pos_start=<value>
      Start position (inclusive) in the alignment for NEFF computation.
      (Default: 1, meaning start of the sequences)

  --pos_end=<value>
      End position (inclusive) in the alignment for NEFF computation.
      (Default: length of the MSA sequence, meaning end of the sequences)

  --only_weights=<true/false>
      If true, the program returns only the sequence weights instead of the final NEFF value.
      (Default: false)

  --multimer_MSA=<true/false>
      If true, computes NEFF for a multimeric MSA.
      (Default: false)

  --stoichiom=<value>
      Specifies the stoichiometry for a multimeric MSA. This parameter is required when --multimer_MSA=true.

  --chain_length=<list of values>
      For heteromer multimer MSAs, provides the lengths of the individual chains.
      This parameter is required when --multimer_MSA=true and the --stoichiom value consists of multiple letters (indicating a heteromer).
      (Default: 0)

  --residue_neff=<true/false>
      If true, computes per-residue (column-wise) NEFF.
      (Default: false)

Examples:
  Compute the NEFF for a protein MSA:
    ./neff --file=msa.a3m --alphabet=0

  Compute NEFF with custom threshold and no normalization:
    ./neff --file=msa.a3m --threshold=0.7 --norm=2

  Compute per-residue NEFF:
    ./neff --file=msa.a3m --residue_neff=true

  For more comprehensive instructions, please refer to the documentation at https://maryam-haghani.github.io/NEFFy.
```


## neffy-cli_converter

### Tool Description
This program converts the format of an input Multiple Sequence Alignment (MSA) file
to that of an output MSA file. It supports various formats and can validate sequences
against a specified alphabet.

### Metadata
- **Docker Image**: quay.io/biocontainers/neffy-cli:0.1.1--h9948957_0
- **Homepage**: https://maryam-haghani.github.io/NEFFy
- **Package**: https://anaconda.org/channels/bioconda/packages/neffy-cli/overview
- **Validation**: PASS

### Original Help Text
```text
MSA Converter Tool

Description:
  This program converts the format of an input Multiple Sequence Alignment (MSA) file
  to that of an output MSA file. It supports various formats and can validate sequences
  against a specified alphabet.

Usage:
  ./converter --in_file=<input_file> --out_file=<output_file> [options]

Options:
  --in_file=<input_file>
      Path to the input MSA file.
      (Required)

  --out_file=<output_file>
      Path to the output MSA file.
      (Required)

  --in_format=<input_format>
      Format of the input file. If not provided, the format is inferred from the file extension.
      (Optional)

  --out_format=<output_format>
      Format of the output file. If not provided, the format is inferred from the file extension.
      (Optional)

  --alphabet=<value>
      Specifies the alphabet for the sequences:
        0 : Protein (default)
        1 : RNA
        2 : DNA

  --check_validation=<true/false>
      If true, validates the sequences to ensure they contain only letters from the specified alphabet.
      (Default: true)

Examples:
  Convert a protein MSA from FASTA to Clustal format:
    ./converter --in_file=msa.fasta --out_file=msa.clustal --alphabet=0

  Convert an RNA MSA with validation:
    ./converter --in_file=msa.a3m --out_file=msa.sto --alphabet=1 --check_validation=true

For more comprehensive instructions, please refer to the documentation at https://maryam-haghani.github.io/NEFFy.
```

