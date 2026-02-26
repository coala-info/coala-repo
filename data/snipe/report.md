# snipe CWL Generation Report

## snipe_ops

### Tool Description
Perform operations on SnipeSig signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/snipe-bio/snipe
- **Package**: https://anaconda.org/channels/bioconda/packages/snipe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snipe/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/snipe-bio/snipe
- **Stars**: N/A
### Original Help Text
```text
Usage: snipe ops [OPTIONS] COMMAND [ARGS]...

  Perform operations on SnipeSig signatures.

  Subcommands:     1. `sum`        Merge multiple signatures by summing their
  abundances.     2. `intersect`  Compute the intersection of multiple
  signatures.     3. `union`      Compute the union of multiple signatures.
  4. `subtract`   Subtract one signature from another.     5. `common`
  Extract hashes common to all input signatures.

  Use 'snipe ops <subcommand> --help' for more information on a command.

Options:
  --help  Show this message and exit.

Commands:
  common        Extract hashes that are common to all input signatures.
  guided-merge  Guide signature merging by groups.
  intersect     Intersect multiple sigs and retain abundance of first one.
  subtract      Subtract one signature from another.
  sum           Merge multiple signatures by summing their abundances.
  union         Merge multiple signatures by taking the union of hashes.
```


## snipe_qc

### Tool Description
Perform quality control (QC) on multiple samples against a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/snipe-bio/snipe
- **Package**: https://anaconda.org/channels/bioconda/packages/snipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snipe qc [OPTIONS]

  Perform quality control (QC) on multiple samples against a reference genome.

  This command calculates various QC metrics for each provided sample,
  optionally including advanced metrics and ROI (Return on investement)
  predictions. Results are aggregated and exported to a TSV file.

  ## Usage

  ```bash snipe qc [OPTIONS] ```

  ## Options

  - `--ref PATH` **[required]**   Reference genome signature file.

  - `--sample PATH`   Sample signature file. Can be provided multiple times.

  - `--samples-from-file PATH`   File containing sample paths (one per line).

  - `--amplicon PATH`   Amplicon signature file (optional).

  - `--roi`   Calculate ROI for 1x, 2x, 5x, and 9x coverage folds.

  - `--ychr PATH`   Y chromosome signature file (overrides the reference
  ychr).

  - `--debug`   Enable debugging and detailed logging.

  - `-o`, `--output PATH` **[required]**   Output TSV file for QC results.

  - `--var PATH`   Variance signature file path. Can be used multiple times.

  - `--export-var` Export signatures for sample hashes found in the variance
  signature.

  - `-c`, `--cores INT` Number of CPU cores to use for parallel processing.
  Default: 1.

  - `--metadata STR` Additional metadata in the format
  `colname=value,colname=value,...`. Applies to all samples.

  - `--metadata-from-file PATH` File containing metadata information in TSV or
  CSV format.  Each row should have `sample_path,metadata_col,value`.

  ## Examples

  ### Performing QC on Multiple Samples

  ```bash snipe qc --ref reference.sig --sample sample1.sig --sample
  sample2.sig -o qc_results.tsv ```

  ### Performing QC with Samples Listed in a File

  ```bash snipe qc --ref reference.sig --samples-from-file samples.txt -o
  qc_results.tsv ```

  *Contents of `samples.txt`:*

  ``` sample1.sig sample2.sig sample3.sig ```

  ### Performing QC with an Amplicon Signature

  ```bash snipe qc --ref reference.sig --amplicon amplicon.sig --sample
  sample1.sig -o qc_results.tsv ```

  ### Including Advanced QC Metrics and ROI Calculations

  ```bash snipe qc --ref reference.sig --sample sample1.sig --advanced --roi
  -o qc_results.tsv ```

  ### Using Multiple Variance Signatures

  ```bash snipe qc --ref reference.sig --sample sample1.sig --var var1.sig
  --var var2.sig -o qc_results.tsv ```

  ### Overriding the Y Chromosome Signature

  ```bash snipe qc --ref reference.sig --sample sample1.sig --ychr
  custom_y.sig -o qc_results.tsv ```

  ### Combining Multiple Options

  ```bash snipe qc --ref reference.sig --sample sample1.sig --sample
  sample2.sig --amplicon amplicon.sig --var var1.sig --var var2.sig --advanced
  --roi -o qc_results.tsv ```

  ## Detailed Use Cases

  ### Use Case 1: Basic QC on Single Sample

  **Objective:** Perform QC on a single sample against a reference genome
  without any advanced metrics or ROI.

  **Command:**

  ```bash snipe qc --ref reference.sig --sample sample1.sig -o qc_basic.tsv
  ```

  **Explanation:**

  - `--ref reference.sig`: Specifies the reference genome signature file. -
  `--sample sample1.sig`: Specifies the sample signature file. - `-o
  qc_basic.tsv`: Specifies the output TSV file for QC results.

  **Expected Output:**

  A TSV file named `qc_basic.tsv` containing basic QC metrics for
  `sample1.sig`.

  ### Use Case 2: QC on Multiple Samples with ROI

  **Objective:** Perform QC on multiple samples and calculate Regions of
  Interest (ROI) for each.

  **Command:**

  ```bash snipe qc --ref reference.sig --sample sample1.sig --sample
  sample2.sig --roi -o qc_roi.tsv ```

  **Explanation:**

  - `--ref reference.sig`: Reference genome signature file. - `--sample
  sample1.sig` & `--sample sample2.sig`: Multiple sample signature files. -
  `--roi`: Enables ROI calculations. - `-o qc_roi.tsv`: Output file for QC
  results.

  **Expected Output:**

  A TSV file named `qc_roi.tsv` containing QC metrics along with ROI
  predictions for `sample1.sig` and `sample2.sig`.

  ### Use Case 3: Advanced QC with Amplicon and Variance Signatures

  **Objective:** Perform advanced QC on a sample using an amplicon signature
  and multiple variance signatures.

  **Command:**

  ```bash snipe qc --ref reference.sig --amplicon amplicon.sig --sample
  sample1.sig --var var1.sig --var var2.sig --advanced -o qc_advanced.tsv ```

  **Explanation:**

  - `--ref reference.sig`: Reference genome signature file. - `--amplicon
  amplicon.sig`: Amplicon signature file. - `--sample sample1.sig`: Sample
  signature file. - `--var var1.sig` & `--var var2.sig`: Variance signature
  files. - `--export-var`: Export signatures for variances. - `--metadata`:
  Additional metadata in the format `metadata1=value,metadata2=value,...`. -
  `--metadata-from-file`: File containing metadata information in TSV or CSV
  format per signature. - `-o qc_advanced.tsv`: Output file for QC results.

  **Expected Output:**

  A TSV file named `qc_advanced.tsv` containing comprehensive QC metrics,
  including advanced metrics and analyses based on the amplicon and variance
  signatures for `sample1.sig`.

  ### Use Case 4: Overwriting Existing Output File

  **Objective:** Perform QC and overwrite an existing output TSV file.

  **Command:**

  ```bash snipe qc --ref reference.sig --sample sample1.sig -o qc_results.tsv
  ```

  **Explanation:**

  - If `qc_results.tsv` already exists, the command will **fail** to prevent
  accidental overwriting. To overwrite, use the `--force` flag (assuming
  you've implemented it; if not, you may need to adjust the `qc` command to
  include a `--force` option).

  **Adjusted Command with `--force` (if implemented):**

  ```bash snipe qc --ref reference.sig --sample sample1.sig -o qc_results.tsv
  --force ```

  **Expected Output:**

  The existing `qc_results.tsv` file will be overwritten with the new QC
  results for `sample1.sig`.

  ### Use Case 5: Using a Custom Y Chromosome Signature

  **Objective:** Override the default Y chromosome signature with a custom one
  during QC.

  **Command:**

  ```bash snipe qc --ref reference.sig --sample sample1.sig --ychr
  custom_y.sig -o qc_custom_y.tsv ```

  **Explanation:**

  - `--ychr custom_y.sig`: Specifies a custom Y chromosome signature file to
  override the default.

  **Expected Output:**

  A TSV file named `qc_custom_y.tsv` containing QC metrics for `sample1.sig`
  with analyses based on the custom Y chromosome signature.

  ### Use Case 6: Reading Sample Paths from a File

  **Objective:** Perform QC on multiple samples listed in a text file.

  **Command:**

  ```bash snipe qc --ref reference.sig --samples-from-file samples.txt -o
  qc_from_file.tsv ```

  **Explanation:**

  - `--samples-from-file samples.txt`: Specifies a file containing sample
  paths, one per line.

  **Contents of `samples.txt`:**

  ``` sample1.sig sample2.sig sample3.sig ```

  **Expected Output:**

  A TSV file named `qc_from_file.tsv` containing QC metrics for `sample1.sig`,
  `sample2.sig`, and `sample3.sig`.

  ### Use Case 7: Combining Multiple Options for Comprehensive QC

  **Command:**

  ```bash snipe qc --ref reference.sig --sample sample1.sig --sample
  sample2.sig --amplicon amplicon.sig --var var1.sig --var var2.sig --advanced
  --roi -o qc_comprehensive.tsv ```

  **Explanation:**

  - `--ref reference.zip`: Reference genome signature file. - `--sample
  sample1.zip` & `--sample sample2.sig`: Multiple sample signature files. -
  `--amplicon amplicon.zip`: Amplicon signature file. - `--var var1.zip` &
  `--var var2.zip`: Variance signature files. - `--advanced`: Includes
  advanced QC metrics. - `--roi`: Enables ROI calculations. - `-o
  qc_comprehensive.tsv`: Output file for QC results.

  **Expected Output:**

  A TSV file named `qc_comprehensive.tsv` containing comprehensive QC metrics,
  including advanced analyses, ROI predictions, and data from amplicon and
  variance signatures for both `sample1.sig` and `sample2.sig`.

Options:
  --ref PATH                 Reference genome signature file (required).
                             [required]
  --sample PATH              Sample signature file. Can be provided multiple
                             times.
  --samples-from-file PATH   File containing sample paths (one per line).
  --amplicon PATH            Amplicon signature file (optional).
  --roi                      Calculate ROI for 1,2,5,9 folds.
  --export-var               Export signatures for variances
  --ychr PATH                Y chromosome signature file (overrides the
                             reference ychr).
  --debug                    Enable debugging and detailed logging.
  -o, --output TEXT          Output TSV file for QC results.  [required]
  --var PATH                 Extra signature file path to study variance of
                             non-reference k-mers.
  -c, --cores INTEGER        Number of CPU cores to use for parallel
                             processing.  [default: 1]
  --metadata TEXT            Additional metadata in the format
                             colname=value,colname=value,...
  --metadata-from-file PATH  File containing metadata information in TSV or
                             CSV format.
  --help                     Show this message and exit.
```


## snipe_sketch

### Tool Description
Sketch genomic data to generate signatures for QC.

### Metadata
- **Docker Image**: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/snipe-bio/snipe
- **Package**: https://anaconda.org/channels/bioconda/packages/snipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snipe sketch [OPTIONS]

  Sketch genomic data to generate signatures for QC.

  Only one input type (`--sample`, `--ref`, or `--amplicon`) can be specified
  at a time.

  ## Usage

  ```bash snipe sketch [OPTIONS] ```

  ## Options

  - `-s`, `--sample PATH`     Sample FASTA file.

  - `-r`, `--ref PATH`     Reference genome FASTA file.

  - `-a`, `--amplicon PATH`     Amplicon FASTA file.

  - `--ychr PATH`     Y chromosome FASTA file (overrides the reference ychr).

  - `-n`, `--name TEXT` **[required]**     Signature name.

  - `-o`, `--output-file PATH` **[required]**     Output file with `.zip`
  extension.

  - `-b`, `--batch-size INTEGER` **[default: 100000]**     Batch size for
  sample sketching.

  - `-c`, `--cores INTEGER` **[default: 4]**     Number of CPU cores to use.

  - `-k`, `--ksize INTEGER` **[default: 51]**     K-mer size.

  - `-f`, `--force`     Overwrite existing output file.

  - `--scale INTEGER` **[default: 10000]**     Sourmash scale factor.

  - `--debug`     Enable debugging.

  ## Examples

  ### Sketching a Reference Genome

  Generate a sketch from a reference genome FASTA file.

  ```bash snipe sketch -r reference.fasta -n genome_ref -o genome_output.zip
  --cores 8 --debug ```

  ### Sketching a Sample FASTA File

  Generate a sketch from a sample FASTA file.

  ```bash snipe sketch -s sample.fasta -n sample_name -o sample_output.zip ```

  ### Sketching an Amplicon FASTA File with Custom Batch Size

  ```bash snipe sketch -a amplicon.fasta -n amplicon_name -o
  amplicon_output.zip -b 50000 ```

  ### Overwriting an Existing Output File

  ```bash snipe sketch -r reference.fasta -n genome_ref -o genome_output.zip
  --force ```

  ### Using a Custom Y Chromosome File

  ```bash snipe sketch -r reference.fasta -n genome_ref -o genome_output.zip
  --ychr custom_y.fasta ```

Options:
  -s, --sample PATH         Sample FASTA file.
  -r, --ref PATH            Reference genome FASTA file.
  -a, --amplicon PATH       Amplicon FASTA file.
  --ychr PATH               Y chromosome FASTA file (overrides the reference
                            ychr).
  -n, --name TEXT           Signature name.  [required]
  -o, --output-file TEXT    Output file with .zip extension.  [required]
  -b, --batch-size INTEGER  Batch size for sample sketching.  [default:
                            100000]
  -c, --cores INTEGER       Number of CPU cores to use.  [default: 4]
  -k, --ksize INTEGER       K-mer size.  [default: 51]
  -f, --force               Overwrite existing output file.
  --scale INTEGER           sourmash scale factor.  [default: 10000]
  --help                    Show this message and exit.
```


## Metadata
- **Skill**: generated
