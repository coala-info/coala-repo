# samestr CWL Generation Report

## samestr_db

### Tool Description
Database check arguments:

### Metadata
- **Docker Image**: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
- **Homepage**: https://github.com/danielpodlesny/samestr/
- **Package**: https://anaconda.org/channels/bioconda/packages/samestr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samestr/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/danielpodlesny/samestr
- **Stars**: N/A
### Original Help Text
```text
usage: samestr db [-h] [--db-check] [--marker-dir DIR]
                  [--db-version DB_VERSION] [--markers-fasta FASTA]
                  [--markers-info PATH [PATH ...]] [--clade CLADE [CLADE ...]]
                  [--output-dir DIR]

options:
  -h, --help            show this help message and exit

Database check arguments:
  --db-check            Performs just a database integrity check, if an
                        existing SameStr database is provided. All other
                        options will be ignored. (default: False)
  --marker-dir DIR      Path to existing MetaPhlAn or mOTUs clade marker
                        database. (default: None)

Input arguments:
  --db-version DB_VERSION
                        Path to version file of database (`mpa_latest` for
                        MetaPhlAn, or `db_mOTU_versions` for mOTUs.) (default:
                        PATH)
  --markers-fasta FASTA
                        Markers fasta file (MetaPhlAn
                        [mpa_vJan21_CHOCOPhlAnSGB_202103.fna or higher], or
                        mOTUs [db_mOTU_DB_CEN.fasta] (default: None)
  --markers-info PATH [PATH ...]
                        Path(s) to marker info files. For MetaPhlAn should be
                        MetaPhlAn pickle file
                        (mpa_vJan21_CHOCOPhlAnSGB_202103.pkl or higher). For
                        mOTUs, should be both `db_mOTU_taxonomy_meta-
                        mOTUs.tsv` and `db_mOTU_taxonomy_ref-mOTUs.tsv`.
                        (default: None)
  --clade CLADE [CLADE ...]
                        Clade to process from input files. Processing all if
                        not specified. Names must correspond to the taxonomy
                        of the respective database [e.g. t__SGB10068 for
                        MetaPhlAn or ref_mOTU_v3_00095 for mOTUs] (default:
                        None)

Output arguments:
  --output-dir DIR      Path to output directory. (default: out_db/)
```


## samestr_convert

### Tool Description
Convert MetaPhlAn or mOTUs marker alignments to a standardized format.

### Metadata
- **Docker Image**: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
- **Homepage**: https://github.com/danielpodlesny/samestr/
- **Package**: https://anaconda.org/channels/bioconda/packages/samestr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: samestr convert [-h] [--nprocs INT] [--tmp-dir DIR] --marker-dir DIR
                       [--db-force] --input-files SAM|SAM.BZ2|BAM
                       [SAM|SAM.BZ2|BAM ...] [--recursive-input]
                       [--output-dir DIR] [--keep-tmp-files]
                       [--min-aln-identity FLOAT] [--min-aln-len INT]
                       [--tax-profiles-dir DIR] [--tax-profiles-extension EXT]
                       [--min-base-qual INT] [--min-aln-qual INT]
                       [--min-vcov INT]

options:
  -h, --help            show this help message and exit

General arguments:
  --nprocs INT          The number of processing units to use. (default: 1)
  --tmp-dir DIR         Path to temporary directory (default: tmp/)
  --marker-dir DIR      Path to MetaPhlAn or mOTUs clade marker database.
                        (default: None)
  --db-force            Force execution, even when database version is not an
                        exact match. (default: False)

Input arguments:
  --input-files SAM|SAM.BZ2|BAM [SAM|SAM.BZ2|BAM ...]
                        Path to input MetaPhlAn or mOTUs marker alignments
                        (.sam, .sam.bz2, .bam). (default: [])
  --recursive-input     Allow checking subdirectories of the input directory
                        for input files. (default: False)

Output arguments:
  --output-dir DIR      Path to output directory. (default: out_convert/)
  --keep-tmp-files      Keeps intermediate files from transformation steps on
                        disk. (default: False)

Alignment arguments:
  --min-aln-identity FLOAT
                        Minimum percent identity in alignment. (default: 0.9)
  --min-aln-len INT     Minimum alignment length. (default: 40)
  --tax-profiles-dir DIR
                        Path to directory with taxonomic profiles (MetaPhlAn
                        or mOTUs, default extension: .profile.txt). When not
                        specified, will look for profiles in `input-files`
                        directory. (default: None)
  --tax-profiles-extension EXT
                        File extension of taxonomic profiles. (default:
                        .profile.txt)
  --min-base-qual INT   Minimum base call quality. (default: 20)
  --min-aln-qual INT    Minimum alignment quality. Increasing this threshold
                        can drastically reduce the number of considered
                        variants. (default: 0)
  --min-vcov INT        Minimum vertical coverage. (default: 3)
```


## samestr_extract

### Tool Description
Extracts marker sequences from input FASTA files based on a specified clade and database.

### Metadata
- **Docker Image**: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
- **Homepage**: https://github.com/danielpodlesny/samestr/
- **Package**: https://anaconda.org/channels/bioconda/packages/samestr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: samestr extract [-h] [--nprocs INT] [--tmp-dir DIR] --marker-dir DIR
                       --input-files FASTA|FNA|FA|FASTA.GZ|FNA.GZ|FA.GZ
                       [FASTA|FNA|FA|FASTA.GZ|FNA.GZ|FA.GZ ...] --clade CLADE
                       [--output-dir DIR] [--keep-tmp-files]
                       [--save-marker-aln] [--aln-program {muscle,mafft}]
                       [--marker-trunc-len INT]

options:
  -h, --help            show this help message and exit

General arguments:
  --nprocs INT          The number of processing units to use. (default: 1)
  --tmp-dir DIR         Path to temporary directory (default: tmp/)
  --marker-dir DIR      Path to MetaPhlAn or mOTUs clade marker database.
                        (default: None)

Input arguments:
  --input-files FASTA|FNA|FA|FASTA.GZ|FNA.GZ|FA.GZ [FASTA|FNA|FA|FASTA.GZ|FNA.GZ|FA.GZ ...]
                        Reference genomes in fasta format. (default: [])
  --clade CLADE         Clade to process from input files. Names must
                        correspond to the taxonomy of the respective database
                        [e.g. t__SGB10068 for MetaPhlAn or ref_mOTU_v3_00095
                        for mOTUs] (default: None)

Output arguments:
  --output-dir DIR      Path to output directory. (default: out_extract/)
  --keep-tmp-files      If not working from memory, keeps extracted alignments
                        per sample on disk. (default: False)
  --save-marker-aln     Keep alignment files for individual markers. (default:
                        False)

Alignment arguments:
  --aln-program {muscle,mafft}
                        Program to use for alignment of marker sequences.
                        (default: muscle)
  --marker-trunc-len INT
                        Number of Nucleotides to be cut from each side of a
                        marker. (default: 0)
```


## samestr_merge

### Tool Description
Merge SNV profiles from multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
- **Homepage**: https://github.com/danielpodlesny/samestr/
- **Package**: https://anaconda.org/channels/bioconda/packages/samestr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: samestr merge [-h] [--nprocs INT] --marker-dir DIR
                     [--input-files NPY [NPY ...]] [--input-dir INPUT_DIR]
                     [--output-dir DIR] [--clade CLADE [CLADE ...]]

options:
  -h, --help            show this help message and exit

General arguments:
  --nprocs INT          The number of processing units to use. (default: 1)
  --marker-dir DIR      Path to MetaPhlAn or mOTUs clade marker database.
                        (default: None)

Input arguments:
  --input-files NPY [NPY ...]
                        Path to input SNV profiles. Should have .npy, .npz or
                        .npy.gz extension. (default: [])
  --input-dir INPUT_DIR
                        Path to input SNV profiles. Should have .npy, .npz or
                        .npy.gz extension. (default: None)

Output arguments:
  --output-dir DIR      Path to output directory. (default: out_merge/)

Clade arguments:
  --clade CLADE [CLADE ...]
                        Clade to process from input files. Processing all if
                        not specified. Names must correspond to the taxonomy
                        of the respective database [e.g. t__SGB10068 for
                        MetaPhlAn or ref_mOTU_v3_00095 for mOTUs] (default:
                        None)
```


## samestr_filter

### Tool Description
Filter SNV profiles based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
- **Homepage**: https://github.com/danielpodlesny/samestr/
- **Package**: https://anaconda.org/channels/bioconda/packages/samestr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: samestr filter [-h] [--nprocs INT] --marker-dir DIR --input-files NPY
                      [NPY ...] --input-names TXT [TXT ...] [--output-dir DIR]
                      [--keep-poly] [--keep-mono] [--delete-pos]
                      [--clade CLADE [CLADE ...]] [--clade-min-samples INT]
                      [--marker-remove TXT] [--marker-keep TXT]
                      [--marker-trunc-len INT] [--sample-var-min-n-vcov INT]
                      [--sample-var-min-f-vcov FLOAT]
                      [--sample-pos-min-n-vcov INT]
                      [--sample-pos-min-sd-vcov FLOAT]
                      [--samples-select TXT [TXT ...]]
                      [--samples-min-n-hcov INT] [--samples-min-f-hcov FLOAT]
                      [--samples-min-m-vcov FLOAT]
                      [--global-pos-min-n-vcov INT]
                      [--global-pos-min-f-vcov FLOAT]

options:
  -h, --help            show this help message and exit

General arguments:
  --nprocs INT          The number of processing units to use. (default: 1)
  --marker-dir DIR      Path to MetaPhlAn or mOTUs clade marker database.
                        (default: None)

Input arguments:
  --input-files NPY [NPY ...]
                        Path to input SNV Profiles. Should have .npy, .npz or
                        .npy.gz extension. (default: [])
  --input-names TXT [TXT ...]
                        Path to input name files. (default: [])

Output arguments:
  --output-dir DIR      Path to output directory. (default: out_filter/)
  --keep-poly           Keep only positions that are polymorphic in at least
                        one sample (default: False)
  --keep-mono           Keep only positions that are monomorphic in all
                        samples (default: False)
  --delete-pos          Delete masked marker and global positions from array
                        instead of np.nan (default: False)

Clade arguments:
  --clade CLADE [CLADE ...]
                        Clade to process from input files. Processing all if
                        not specified. Names must correspond to the taxonomy
                        of the respective database [e.g. t__SGB10068 for
                        MetaPhlAn or ref_mOTU_v3_00095 for mOTUs] (default:
                        None)
  --clade-min-samples INT
                        Skipping clades with fewer than `clade-min-samples`
                        samples. (default: 2)

Clade Marker arguments:
  --marker-remove TXT   List of Markers to remove for selected clade. Requires
                        `clade` to be specified. (default: None)
  --marker-keep TXT     List of Markers to keep for selected clade. Requires
                        `clade` to be specified. Overrides `marker-remove`.
                        (default: None)
  --marker-trunc-len INT
                        Number of Nucleotides to be cut from each two sides of
                        a marker. (default: 50)

Sample Variant Filtering arguments:
  --sample-var-min-n-vcov INT
                        Remove variants with coverage below `sample-var-min-n-
                        vcov` nucleotides. (default: 2)
  --sample-var-min-f-vcov FLOAT
                        Remove variants with coverage below `sample-var-min-f-
                        vcov` percent. (default: 0.05)

Sample Position Filtering arguments:
  --sample-pos-min-n-vcov INT
                        Remove positions with coverage below `sample-pos-min-
                        n-vcov` nucleotides. (default: 1)
  --sample-pos-min-sd-vcov FLOAT
                        Remove positions with coverage +-`sample-pos-min-sd-
                        vcov` from the mean. (default: 3.0)

Sample Filtering arguments:
  --samples-select TXT [TXT ...]
                        Path to names file with subsample of input names.
                        (default: [])
  --samples-min-n-hcov INT
                        Remove samples with horizontal coverage below
                        `samples-min-n-hcov`. (default: 5000)
  --samples-min-f-hcov FLOAT
                        Remove samples with fraction of horizontal coverage
                        below `samples-min-f-hcov`. (default: None)
  --samples-min-m-vcov FLOAT
                        Remove samples with mean coverage below `samples-min-
                        m-vcov`. (default: None)

Global Position Filtering arguments:
  --global-pos-min-n-vcov INT
                        Remove positions covered by fewer than `global-pos-
                        min-n-vcov` number of samples. Overrides `global-pos-
                        min-f-vcov`. (default: 2)
  --global-pos-min-f-vcov FLOAT
                        Remove positions covered by fewer than `global-pos-
                        min-f-vcov` fraction of samples. (default: False)
```


## samestr_stats

### Tool Description
Report statistics on SNV profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
- **Homepage**: https://github.com/danielpodlesny/samestr/
- **Package**: https://anaconda.org/channels/bioconda/packages/samestr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: samestr stats [-h] [--nprocs INT] --marker-dir DIR --input-files NPY
                     [NPY ...] --input-names FILEPATH [FILEPATH ...]
                     [--output-dir DIR] [--dominant-variants]

options:
  -h, --help            show this help message and exit

General arguments:
  --nprocs INT          The number of processing units to use. (default: 1)
  --marker-dir DIR      Path to MetaPhlAn or mOTUs clade marker database.
                        (default: None)

Input arguments:
  --input-files NPY [NPY ...]
                        Path to input SNV profiles. Should have .npy, .npz or
                        .npy.gz extension. (default: [])
  --input-names FILEPATH [FILEPATH ...]
                        Path to input name files. (default: [])

Output arguments:
  --output-dir DIR      Path to output directory. (default: marker_db/)
  --dominant-variants   Report statistics only for dominant variants as
                        obtained from consensus call. (default: False)
```


## samestr_compare

### Tool Description
Compare SNV profiles between samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
- **Homepage**: https://github.com/danielpodlesny/samestr/
- **Package**: https://anaconda.org/channels/bioconda/packages/samestr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: samestr compare [-h] [--nprocs INT] --marker-dir DIR --input-files NPY
                       [NPY ...] --input-names TXT [TXT ...]
                       [--output-dir DIR] [--dominant-variants]
                       [--dominant-variants-added] [--dominant-variants-msa]

options:
  -h, --help            show this help message and exit

General arguments:
  --nprocs INT          The number of processing units to use. (default: 1)
  --marker-dir DIR      Path to MetaPhlAn or mOTUs clade marker database.
                        (default: None)

Input arguments:
  --input-files NPY [NPY ...]
                        Path to input SNV Profiles. Should have .npy, .npz or
                        .npy.gz extension. (default: [])
  --input-names TXT [TXT ...]
                        Path to input name files. (default: [])

Output arguments:
  --output-dir DIR      Path to output directory. (default: out_compare/)
  --dominant-variants   Compare only dominant variants as obtained from
                        consensus call. (default: False)
  --dominant-variants-added
                        Add dominant variants as additional entries to data.
                        (default: False)
  --dominant-variants-msa
                        Output alignment of dominant variants as fasta.
                        (default: False)
```


## samestr_summarize

### Tool Description
Summarize pairwise alignment comparisons to identify shared strains.

### Metadata
- **Docker Image**: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
- **Homepage**: https://github.com/danielpodlesny/samestr/
- **Package**: https://anaconda.org/channels/bioconda/packages/samestr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: samestr summarize [-h] --marker-dir DIR --input-dir DIR
                         --tax-profiles-dir DIR [--tax-profiles-extension EXT]
                         [--output-dir DIR] [--aln-pair-min-overlap INT]
                         [--aln-pair-min-similarity FLOAT]

options:
  -h, --help            show this help message and exit

General arguments:
  --marker-dir DIR      Path to MetaPhlAn or mOTUs clade marker database.
                        (default: None)

Input arguments:
  --input-dir DIR       Path to `samestr compare` output directory. Must
                        contain pairwise comparison of alignment files
                        (.fraction.txt, .overlap.txt) (default: None)
  --tax-profiles-dir DIR
                        Path to directory with taxonomic profiles (MetaPhlAn
                        or mOTUs, default extension: .profile.txt). (default:
                        None)
  --tax-profiles-extension EXT
                        File extension of taxonomic profiles. (default:
                        .profile.txt)

Output arguments:
  --output-dir DIR      Path to output directory. (default: out_summarize/)

Summary threshold arguments:
  --aln-pair-min-overlap INT
                        Minimum number of overlapping positions which have to
                        be covered in both alignments in order to evaluate
                        alignment similarity. (default: 5000)
  --aln-pair-min-similarity FLOAT
                        Minimum pairwise alignment similarity to call shared
                        strains. (default: 0.999)
```


## Metadata
- **Skill**: generated
