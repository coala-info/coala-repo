# Tags

Tags give the ability to mark specific points in history as being important

* ## [v6.2.6](/s.fuchs/prophane/-/tags/v6.2.6)

  [fad9ba4f](/s.fuchs/prophane/-/commit/fad9ba4f9233e8341d13eb989dfc599ff7cfce4d)
  ·
  [bump to v6.2.6](/s.fuchs/prophane/-/commit/fad9ba4f9233e8341d13eb989dfc599ff7cfce4d)
  ·
  Oct 14, 2021

  Release:
  [v6.2.6](/s.fuchs/prophane/-/releases/v6.2.6)

  ```
  - fix fail of analysis if no sample groups were specified
  ```
* ## [v6.2.5](/s.fuchs/prophane/-/tags/v6.2.5)

  [5f1eb059](/s.fuchs/prophane/-/commit/5f1eb0597d430daaed6c77b4ee73471cf34a4d3c)
  ·
  [bump to v6.2.5](/s.fuchs/prophane/-/commit/5f1eb0597d430daaed6c77b4ee73471cf34a4d3c)
  ·
  Oct 13, 2021

  Release:
  [v6.2.5](/s.fuchs/prophane/-/releases/v6.2.5)

  ```
  - fix parsing of Proteome discoverer output that lacks a column named "Master" by calculating the mean value of the non-zero protein abundancies for all protein groups
  ```
* ## [v6.2.4](/s.fuchs/prophane/-/tags/v6.2.4)

  [4921c494](/s.fuchs/prophane/-/commit/4921c494ec2523b941f5febf1eb416d2468b6ae3)
  ·
  [bump to v6.2.4](/s.fuchs/prophane/-/commit/4921c494ec2523b941f5febf1eb416d2468b6ae3)
  ·
  Oct 01, 2021

  Release:
  [v6.2.4](/s.fuchs/prophane/-/releases/v6.2.4)

  ```
  - fix dbcan tasks: erroneous parsing of hmmer output resulted in many missed annotations. Previously the wrong columns (1/3) were parsed from hmmer results, which resulted in a lot of missed hits. The correct columns are 0 and 2 for hmmscan and hmmsearch respectively.
  - internal: refactor building and writing of summary for comprehensibility.
  - internal: remove second accession column from id2annot map files
  - internal: rename column names of dbcan, pfam, tigrfam maps
  ```
* ## [v6.2.3](/s.fuchs/prophane/-/tags/v6.2.3)

  [faf8b183](/s.fuchs/prophane/-/commit/faf8b183f705149c99b0d7688b033a91f451923c)
  ·
  [bump to v6.2.3](/s.fuchs/prophane/-/commit/faf8b183f705149c99b0d7688b033a91f451923c)
  ·
  Sep 28, 2021

  Release:
  [v6.2.3](/s.fuchs/prophane/-/releases/v6.2.3)

  ```
  - fix tigrfam download links
  - fix memory issues during lca calculation. Large numbers of protein groups in combination with many samples lead to large RAM consumption. Protein Group and Sample information is now stored in a sqlite db (`pgs/protein_groups_db.sql`), reducing the memory requirements to a minimum.
  - fix order of summary columns: When using sample groups, the name and title of summary columns did not match (affected: quant and mafft columns). Krona plots were not affected.
  - fix Proteome Discoverer Parsing for groups without master protein (#84). If a group has no master protein, it's abundance is set to the mean of all member protein abundance values
  - fix emapper v4 analysis (set block size parameter only for emapper v5)
  ```
* ## [v6.2.2](/s.fuchs/prophane/-/tags/v6.2.2)

  [de0934e8](/s.fuchs/prophane/-/commit/de0934e870829daa8f510a59f064d06638f9cacd)
  ·
  [bump to v6.2.2](/s.fuchs/prophane/-/commit/de0934e870829daa8f510a59f064d06638f9cacd)
  ·
  Aug 20, 2021

  Release:
  [v6.2.2](/s.fuchs/prophane/-/releases/v6.2.2)

  ```
  - fix #82: prophane.de: eggnog jobs fail with memory error for some query fasta files
    - fixed by setting the block_size parameter based on the size of the all.faa fasta file: if the fasta file is larger than 10MB: block_size = 10 / size_in_MB(all.faa), rounded to one decimal. For smaller fasta files, the block_size is set to 2.
  ```
* ## [v6.2.1](/s.fuchs/prophane/-/tags/v6.2.1)

  [f1a1100a](/s.fuchs/prophane/-/commit/f1a1100a6ce8bd05c56f3e4ef7b00b8ec1ae1973)
  ·
  [bump to v6.2.1](/s.fuchs/prophane/-/commit/f1a1100a6ce8bd05c56f3e4ef7b00b8ec1ae1973)
  ·
  Jul 28, 2021

  Release:
  [v6.2.1](/s.fuchs/prophane/-/releases/v6.2.1)

  ```
  - fix eggnog v5 download
  - fix eggnog v5 result mapping
  - fix emapper log redirection, now is properly written to {task_file_name}.log
  ```
* ## [v6.2](/s.fuchs/prophane/-/tags/v6.2)

  [4889e765](/s.fuchs/prophane/-/commit/4889e765f0f53a165d7f195c24182ead23f686c7)
  ·
  [bump to v6.2](/s.fuchs/prophane/-/commit/4889e765f0f53a165d7f195c24182ead23f686c7)
  ·
  Jul 09, 2021

  Release:
  [v6.2](/s.fuchs/prophane/-/releases/v6.2)

  ```
  - add support for eggnog database version 5.0.2
  ```
* ## [v6.1.1](/s.fuchs/prophane/-/tags/v6.1.1)

  [775fa43a](/s.fuchs/prophane/-/commit/775fa43a0259784b5c45f5b1e4ca2298accf27ed)
  ·
  [bum to v6.1.1](/s.fuchs/prophane/-/commit/775fa43a0259784b5c45f5b1e4ca2298accf27ed)
  ·
  Jul 06, 2021

  Release:
  [v6.1.1](/s.fuchs/prophane/-/releases/v6.1.1)

  ```
  - fix issue 80: only download ncbi_taxdump database for taxonomic analyses
  - fix mafft workflow if no protein groups with more than one accession are present
  - fix prophane crash upon executing `prophane list-dbs` on outdated databases. DBs are now automatically migrated.
  - add `prophane --version` parameter to cli
  - doc: adapt installation instructions to include direct conda installation, remove setup.sh
  ```
* ## [v6.1](/s.fuchs/prophane/-/tags/v6.1)

  [f02d4bc1](/s.fuchs/prophane/-/commit/f02d4bc17898a2baeff6872c472692a0a9512209)
  ·
  [bump to v6.1](/s.fuchs/prophane/-/commit/f02d4bc17898a2baeff6872c472692a0a9512209)
  ·
  Jun 10, 2021

  Release:
  [v6.1](/s.fuchs/prophane/-/releases/v6.1)

  ```
  - add support for gzipped fasta files as input
  - fix crash during parsing of Proteome Discoverer Output if it contains protein groups without any quantification values for the master protein. Now, Prophane ignores these protein groups.
  ```
* ## [v6.0.5](/s.fuchs/prophane/-/tags/v6.0.5)

  [33b6edb1](/s.fuchs/prophane/-/commit/33b6edb1ef489171415cbccbb3b0ee4d7122e3e9)
  ·
  [bump to v6.0.5](/s.fuchs/prophane/-/commit/33b6edb1ef489171415cbccbb3b0ee4d7122e3e9)
  ·
  Jun 04, 2021

  Release:
  [v6.0.5](/s.fuchs/prophane/-/releases/v6.0.5)

  ```
  add support for large mzIdentML files
  ```
* ## [v6.0.4](/s.fuchs/prophane/-/tags/v6.0.4)

  [6d735f2c](/s.fuchs/prophane/-/commit/6d735f2cb2a70146b1ca8bad507c16cbb0d4a6d4)
  ·
  [bump to v6.0.4](/s.fuchs/prophane/-/commit/6d735f2cb2a70146b1ca8bad507c16cbb0d4a6d4)
  ·
  Jun 03, 2021

  Release:
  [v6.0.4](/s.fuchs/prophane/-/releases/v6.0.4)

  ```
  refactor code to parse search result using snakemake (previously: plain python)
  ```
* ## [v6.0.3](/s.fuchs/prophane/-/tags/v6.0.3)

  [f1b7020c](/s.fuchs/prophane/-/commit/f1b7020ca41e5bdc58cd074d87fda6fd828de060)
  ·
  [bump to v6.0.3](/s.fuchs/prophane/-/commit/f1b7020ca41e5bdc58cd074d87fda6fd828de060)
  ·
  Jun 03, 2021

  Release:
  [v6.0.3](/s.fuchs/prophane/-/releases/v6.0.3)

  ```
  - fix command line interface option "prepare-dbs". It now accepts additional snakemake options and will work if the job config contains acc2annot_mapper tasks
  ```
* ## [v6.0.2](/s.fuchs/prophane/-/tags/v6.0.2)

  [5c042660](/s.fuchs/prophane/-/commit/5c04266004e10400664b5239516b05f4b0f96b50)
  ·
  [bump to v6.0.2](/s.fuchs/prophane/-/commit/5c04266004e10400664b5239516b05f4b0f96b50)
  ·
  May 28, 2021

  Release:
  [v6.0.2](/s.fuchs/prophane/-/releases/v6.0.2)

  ```
  - fix database migration for setups that contain multiple versions of the same db
  ```
* ## [v6.0.1](/s.fuchs/prophane/-/tags/v6.0.1)

  [c1e596e4](/s.fuchs/prophane/-/commit/c1e596e448e3a672c9f540235046160fd439a7fa)
  ·
  [bump to v6.0.1](/s.fuchs/prophane/-/commit/c1e596e448e3a672c9f540235046160fd439a7fa)
  ·
  May 20, 2021

  Release:
  [v6.0.1](/s.fuchs/prophane/-/releases/v6.0.1)

  ```
  - fix prophane path detection in CLI
  ```
* ## [v6.0](/s.fuchs/prophane/-/tags/v6.0)

  [6dff995e](/s.fuchs/prophane/-/commit/6dff995e6d40d238f0713c464782df4ad4a48d1f)
  ·
  [bump to v6.0](/s.fuchs/prophane/-/commit/6dff995e6d40d238f0713c464782df4ad4a48d1f)
  ·
  May 19, 2021

  Release:
  [v6.0](/s.fuchs/prophane/-/releases/v6.0)

  ```
  ** 6.0
  *** Breaking Changes
  change of command line interface:

      prophane -> prophane.py run
      prophane --list-dbs -> prophane.py list-dbs
      prophane --list-styles -> prophane.py list-styles

  *** Features
  Automatically download databases that are specified in the job-config. On first run of prophane, run prophane init {DB_DIR} where DB_DIR is an empty or non existant directory. To execute prophane, run prophane run {path-to-job-config}.

  *** Changes
  * bump the db_schema version to 5
  * task and plot files now include the database version number instead of the md5sum: tasks/{annot_type}_annot_by_{tool}_on_{db_type}.v{db_version}.task{taskid}.{ext}
  ```
* ## [v5.1.1](/s.fuchs/prophane/-/tags/v5.1.1)

  [9f56d99b](/s.fuchs/prophane/-/commit/9f56d99b12693c023292390e36f6fbc1adfc59e7)
  ·
  [bump to v5.1.1](/s.fuchs/prophane/-/commit/9f56d99b12693c023292390e36f6fbc1adfc59e7)
  ·
  May 10, 2021

  Release:
  [v5.1.1](/s.fuchs/prophane/-/releases/v5.1.1)

  ```
  - add mamba dependency
  ```
* ## [v5.1](/s.fuchs/prophane/-/tags/v5.1)

  [91d08b0c](/s.fuchs/prophane/-/commit/91d08b0ce6369211b12227dd952763535248d09a)
  ·
  [bump to v5.1](/s.fuchs/prophane/-/commit/91d08b0ce6369211b12227dd952763535248d09a)
  ·
  Mar 30, 2021

  Release:
  [v5.1](/s.fuchs/prophane/-/releases/v5.1)

  ```
  - add parser for proteome discoverer output
  ```
* ## [v5.0.2](/s.fuchs/prophane/-/tags/v5.0.2)

  [1c2bafd5](/s.fuchs/prophane/-/commit/1c2bafd5fbc7939b5552ba24f7020a94f5fb6889)
  ·
  [bump to v5.0.2](/s.fuchs/prophane/-/commit/1c2bafd5fbc7939b5552ba24f7020a94f5fb6889)
  ·
  Mar 22, 2021

  Release:
  [v5.0.2](/s.fuchs/prophane/-/releases/v5.0.2)

  ```
  - fix mztab parser skipping samples without associated spectra and not counting all spectra
  ```
* ## [v5.0.1](/s.fuchs/prophane/-/tags/v5.0.1)

  [1d8a2198](/s.fuchs/prophane/-/commit/1d8a2198bc0f83ff6479b8479e4bc454341632ef)
  ·
  [bump to v5.0.1](/s.fuchs/prophane/-/commit/1d8a2198bc0f83ff6479b8479e4bc454341632ef)
  ·
  Feb 19, 2021

  Release:
  [v5.0.1](/s.fuchs/prophane/-/releases/v5.0.1)

  ```
  fix parsing of spectra IDs from protein group yaml and some test files
  ```
* ## [v5.0.0](/s.fuchs/prophane/-/tags/v5.0.0)

  [2b3b4b0b](/s.fuchs/prophane/-/commit/2b3b4b0b307082f332d5bb4b6b2a9efbdd9cc2cc)
  ·
  [bump version to v5.0.0](/s.fuchs/prophane/-/commit/2b3b4b0b307082f332d5bb4b6b2a9efbdd9cc2cc)
  ·
  Feb 17, 2021

  Release:
  [v5.0.0](/s.fuchs/prophane/-/releases/v5.0.0)

  ```
  LCA determination of proteins with multiple annotations: If a species/lineage is found for all protein accessions in a protein group, this species/lineage is chosen as LCA. Before: if any other species was determined --> various.

  LCA determination with two different methods:
  1. (default) per protein group (with threshold, default: 1). If the ratio of proteins assigned to an ancestor is at least as high as the threshold, this ancestor is assigned to the entire group (multiple above threshold --> lca with highest support). Changes previous default behaviour. For example if a species/lineage is found for all protein accessions in one group, this species/lineage has a support of 100% and is chosen by the new lca-methode as LCA. Before: if any other species was determined --> various.
  2. democratic: takes the one with highest occurrence among all protein groups in the whole task

  New columns in summary.txt: lca-support, describing the number of proteins/spectra assigned to the respective LCA. Also the summary rule is adjusted for csv export, we only have to adjust the separator and includes spectra in output (if available).
  ```

* [1](/s.fuchs/prophane/-/tags)
* [2](/s.fuchs/prophane/-/tags?page=2)