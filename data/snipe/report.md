# snipe CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| snipe_ops_common | PASS |  |
| snipe_ops_guided-merge | PASS |  |
| snipe_ops_intersect | PASS |  |
| snipe_ops_subtract | Failed | tool bug: the image calls a missing method (SnipeSig has no attribute 'subtract'), so the command always errors |
| snipe_ops_sum | PASS |  |
| snipe_ops_union | PASS |  |
| snipe_qc | PASS |  |
| snipe_sketch | PASS |  |

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


## snipe_ops_common

### Tool Description
Extract hashes that are common to all input signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/snipe-bio/snipe
- **Package**: https://anaconda.org/channels/bioconda/packages/snipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snipe ops common [OPTIONS] [SIG_FILES]...

  Extract hashes that are common to all input signatures.

  This command identifies hashes that are present in **every** input signature
  and creates a new signature containing only these common hashes. The
  abundance values from the first signature are retained.

  **Example:**

      snipe ops common sample1.sig.zip sample2.sig.zip sample3.sig.zip -o
      common_hashes.sig.zip

  This command will:   1. Load `sample1.sig.zip`, `sample2.sig.zip`, and
  `sample3.sig.zip`.   2. Apply any specified operations.   3. Identify hashes
  common to all signatures.   4. Retain abundance values from
  `sample1.sig.zip` for these common hashes.   5. Export the resulting common
  hashes signature to `common_hashes.sig.zip`.

Options:
  -n, --name TEXT         Name for the output signature.  [required]
  -o, --output-file TEXT  Output file with .zip or .sig extension.  [required]
  --trim-below-median     Trim hashes below the median abundance.
  --max-abund INTEGER     Keep hashes with abundance <= this value.
  --min-abund INTEGER     Keep hashes with abundance >= this value.
  --trim-singletons       Trim singletons from all input signatures.
  --reset-abundance       Reset abundance for all input signatures to 1.
  --sigs-from-file PATH   File containing signature paths (one per line).
  --debug                 Enable debugging and detailed logging.
  --force                 Overwrite the output file if it already exists.
  --help                  Show this message and exit.
```

## snipe_ops_guided-merge

### Tool Description
Guide signature merging by groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/snipe-bio/snipe
- **Package**: https://anaconda.org/channels/bioconda/packages/snipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snipe ops guided-merge [OPTIONS]

  Guide signature merging by groups.

  This command reads a table file (CSV or TSV) where each line contains a
  signature file path and an experiment name. It groups signatures by
  experiment, applies specified operations, sums the signatures within each
  group, and saves the merged signatures as
  `{output_dir}/{experiment_name}.zip`.

  **Example:**

      snipe ops guided-merge --table mapping.tsv --output-dir merged_sigs
      --reset-abundance --force --cores 4

  **Example Table File (`mapping.tsv`):**

      /path/to/sig1.zip    exp1     /path/to/sig2.zip    exp1
      /path/to/sig3.zip    exp2     /path/to/sig4.zip    exp2
      /path/to/sig5.zip    exp3

Options:
  -t, --table FILE            Tabular file (CSV or TSV) with two columns:
                              <signature_path> <experiment_name>  [required]
  -d, --output-dir DIRECTORY  Directory to save merged signature files.
                              [required]
  --reset-abundance           Reset abundance for all input signatures to 1.
  --trim-singletons           Trim singletons from all input signatures.
  --min-abund INTEGER         Keep hashes with abundance >= this value.
  --max-abund INTEGER         Keep hashes with abundance <= this value.
  --trim-below-median         Trim hashes below the median abundance.
  --debug                     Enable debugging and detailed logging.
  --force                     Overwrite existing files in the output
                              directory.
  --cores INTEGER             Number of cores to use for processing
                              experiments in parallel.
  --help                      Show this message and exit.
```

## snipe_ops_intersect

### Tool Description
Intersect multiple sigs and retain abundance of first one.

### Metadata
- **Docker Image**: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/snipe-bio/snipe
- **Package**: https://anaconda.org/channels/bioconda/packages/snipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snipe ops intersect [OPTIONS] [SIG_FILES]...

  Intersect multiple sigs and retain abundance of first one.

  This command identifies hashes that are present in **all** input signatures
  and retains their abundance from the first signature.

  **Example:**

      snipe ops intersect sample1.sig.zip sample2.sig.zip -o
      intersection.sig.zip

  This command will:   1. Load `sample1.sig.zip` and `sample2.sig.zip`.   2.
  Apply any specified operations.   3. Retain only hashes common to both
  signatures.   4. Use the abundance values from `sample1.sig.zip` for the
  common hashes.   5. Export the resulting intersection to
  `intersection.sig.zip`.

Options:
  -n, --name TEXT         Name for the output signature.  [required]
  -o, --output-file TEXT  Output file with .zip or .sig extension.  [required]
  --trim-below-median     Trim hashes below the median abundance.
  --max-abund INTEGER     Keep hashes with abundance <= this value.
  --min-abund INTEGER     Keep hashes with abundance >= this value.
  --trim-singletons       Trim singletons from all input signatures.
  --reset-abundance       Reset abundance for all input signatures to 1.
  --sigs-from-file PATH   File containing signature paths (one per line).
  --debug                 Enable debugging and detailed logging.
  --force                 Overwrite the output file if it already exists.
  --help                  Show this message and exit.
```

## snipe_ops_subtract

### Tool Description
Subtract one signature from another.

### Metadata
- **Docker Image**: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/snipe-bio/snipe
- **Package**: https://anaconda.org/channels/bioconda/packages/snipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snipe ops subtract [OPTIONS] [SIG_FILES]...

  Subtract one signature from another.

  This command removes the hashes present in the second signature from the
  first signature. The resulting signature will contain only the hashes that
  are unique to the first signature.

  **Example:**

      snipe ops subtract sample1.sig.zip sample2.sig.zip -o subtracted.sig.zip

  This command will:   1. Load `sample1.sig.zip` and `sample2.sig.zip`.   2.
  Apply any specified operations.   3. Subtract the hashes of
  `sample2.sig.zip` from `sample1.sig.zip`.   4. Export the resulting
  signature to `subtracted.sig.zip`.

Options:
  -n, --name TEXT         Name for the output signature.  [required]
  -o, --output-file TEXT  Output file with .zip or .sig extension.  [required]
  --trim-below-median     Trim hashes below the median abundance.
  --max-abund INTEGER     Keep hashes with abundance <= this value.
  --min-abund INTEGER     Keep hashes with abundance >= this value.
  --trim-singletons       Trim singletons from all input signatures.
  --reset-abundance       Reset abundance for all input signatures to 1.
  --sigs-from-file PATH   File containing signature paths (one per line).
  --debug                 Enable debugging and detailed logging.
  --force                 Overwrite the output file if it already exists.
  --help                  Show this message and exit.
```

## snipe_ops_sum

### Tool Description
Merge multiple signatures by summing their abundances.

### Metadata
- **Docker Image**: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/snipe-bio/snipe
- **Package**: https://anaconda.org/channels/bioconda/packages/snipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snipe ops sum [OPTIONS] [SIG_FILES]...

  Merge multiple signatures by summing their abundances.

  This command loads multiple signature files, applies specified operations
  (like resetting abundances), and then sums them to create a new signature
  where the abundance of each hash is the sum of its abundances across all
  input signatures.

  **Example:**

      snipe ops sum sample1.sig.zip sample2.sig.zip -o summed.sig.zip --reset-
      abundance

  This command will:   1. Load `sample1.sig.zip` and `sample2.sig.zip`.   2.
  Reset the abundance of each hash in both signatures to 1.   3. Sum the
  signatures, resulting in `summed.sig.zip` where each hash has an abundance
  of 2.

Options:
  -n, --name TEXT         Name for the output signature.  [required]
  -o, --output-file TEXT  Output file with .zip or .sig extension.  [required]
  --trim-below-median     Trim hashes below the median abundance.
  --max-abund INTEGER     Keep hashes with abundance <= this value.
  --min-abund INTEGER     Keep hashes with abundance >= this value.
  --trim-singletons       Trim singletons from all input signatures.
  --reset-abundance       Reset abundance for all input signatures to 1.
  --sigs-from-file PATH   File containing signature paths (one per line).
  --debug                 Enable debugging and detailed logging.
  --force                 Overwrite the output file if it already exists.
  --help                  Show this message and exit.
```

## snipe_ops_union

### Tool Description
Merge multiple signatures by taking the union of hashes.

### Metadata
- **Docker Image**: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/snipe-bio/snipe
- **Package**: https://anaconda.org/channels/bioconda/packages/snipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snipe ops union [OPTIONS] [SIG_FILES]...

  Merge multiple signatures by taking the union of hashes.

  This command combines multiple signatures, retaining all unique hashes from
  each. If a hash appears in multiple signatures, its abundance in the
  resulting signature is the sum of its abundances across all input
  signatures.

  **Example:**

      snipe ops union sample1.sig.zip sample2.sig.zip -o union.sig.zip

  This command will:   1. Load `sample1.sig.zip` and `sample2.sig.zip`.   2.
  Apply any specified operations.   3. Combine the signatures, summing
  abundances for overlapping hashes.   4. Export the resulting union signature
  to `union.sig.zip`.

Options:
  -n, --name TEXT         Name for the output signature.  [required]
  -o, --output-file TEXT  Output file with .zip or .sig extension.  [required]
  --trim-below-median     Trim hashes below the median abundance.
  --max-abund INTEGER     Keep hashes with abundance <= this value.
  --min-abund INTEGER     Keep hashes with abundance >= this value.
  --trim-singletons       Trim singletons from all input signatures.
  --reset-abundance       Reset abundance for all input signatures to 1.
  --sigs-from-file PATH   File containing signature paths (one per line).
  --debug                 Enable debugging and detailed logging.
  --force                 Overwrite the output file if it already exists.
  --help                  Show this message and exit.
```

## Metadata
- **Skill**: generated
