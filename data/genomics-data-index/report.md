# genomics-data-index CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| genomics-data-index_gdi_analysis | Not completed | pipeline, skipped (runs a Snakemake pipeline with conda). |
| genomics-data-index_gdi_build_alignment | PASS | Alignment of 3 samples plus the reference made from loaded variants. |
| genomics-data-index_gdi_build_tree | PASS | IQ-TREE tree of 3 samples plus the reference made from loaded variants. |
| genomics-data-index_gdi_db_size | Failed | image problem: the image has BusyBox du, which lacks --block-size, so the command crashes. |
| genomics-data-index_gdi_export_tree | PASS | Exported the stored tree as Newick and as ASCII. |
| genomics-data-index_gdi_init | PASS | Created an empty project folder. |
| genomics-data-index_gdi_input | PASS | Table of 3 assemblies written. |
| genomics-data-index_gdi_input-split-file | PASS | A 3-sequence FASTA was split into 3 files with a sample table. |
| genomics-data-index_gdi_list_genomes | PASS | Listed the loaded reference genome. |
| genomics-data-index_gdi_list_samples | PASS | Listed the 3 loaded samples. |
| genomics-data-index_gdi_load_kmer | Failed | tool bug: after making the sketch it copies the file onto itself (SameFileError) and the sketch is not registered. |
| genomics-data-index_gdi_load_mlst-chewbbaca | PASS | Real chewBBACA table from the tool repository; 2 new samples listed. |
| genomics-data-index_gdi_load_mlst-sistr | PASS | Real SISTR table from the tool repository; 2 new samples listed. |
| genomics-data-index_gdi_load_mlst-tseemann | PASS | Real mlst table from the tool repository; 4 new samples listed. |
| genomics-data-index_gdi_load_snippy | PASS | Real snippy results from the tool repository; query found the expected mutation in 1 of 3 samples. |
| genomics-data-index_gdi_load_vcf | PASS | Real VCFs from the tool repository; 3 samples loaded and listed. |
| genomics-data-index_gdi_load_vcf-kmer | PASS | Real VCFs and sourmash sketches from the tool repository; 3 sketches stored. |
| genomics-data-index_gdi_query | PASS | Query for one known mutation found it in 1 of 3 samples; feature summary also works. |
| genomics-data-index_gdi_rebuild_tree | PASS | Tree rebuilt and stored; export tree then showed it. |

## genomics-data-index_gdi_analysis

### Tool Description
Perform analysis on genomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/apetkau/genomics-data-index
- **Stars**: N/A
### Original Help Text
```text
--- Logging error ---
Traceback (most recent call last):
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/ete3treeview.py", line 17, in <module>
    from ete3 import TreeStyle, NodeStyle, Face, RectFace, CircleFace, TextFace
ImportError: cannot import name 'TreeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/logging/__init__.py", line 1083, in emit
    msg = self.format(record)
  File "/usr/local/lib/python3.9/logging/__init__.py", line 927, in format
    return fmt.format(record)
  File "/usr/local/lib/python3.9/logging/__init__.py", line 663, in format
    record.message = record.getMessage()
  File "/usr/local/lib/python3.9/logging/__init__.py", line 367, in getMessage
    msg = msg % self.args
TypeError: not all arguments converted during string formatting
Call stack:
  File "/usr/local/bin/gdi", line 7, in <module>
    from genomics_data_index.cli.gdi import main
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/cli/gdi.py", line 21, in <module>
    from genomics_data_index.api.query.GenomicsDataIndex import GenomicsDataIndex
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 972, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 972, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/__init__.py", line 1, in <module>
    from genomics_data_index.api.query.GenomicsDataIndex import GenomicsDataIndex
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/GenomicsDataIndex.py", line 15, in <module>
    from genomics_data_index.api.query.impl.DataFrameSamplesQuery import DataFrameSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/DataFrameSamplesQuery.py", line 9, in <module>
    from genomics_data_index.api.query.impl.TreeSamplesQueryFactory import TreeSamplesQueryFactory
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/TreeSamplesQueryFactory.py", line 9, in <module>
    from genomics_data_index.api.query.impl.ExperimentalTreeSamplesQuery import ExperimentalTreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/ExperimentalTreeSamplesQuery.py", line 8, in <module>
    from genomics_data_index.api.query.impl.MutationTreeSamplesQuery import MutationTreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/MutationTreeSamplesQuery.py", line 7, in <module>
    from genomics_data_index.api.query.impl.TreeSamplesQuery import TreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/TreeSamplesQuery.py", line 10, in <module>
    from genomics_data_index.ete3treeview import TreeStyle, NodeStyle
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/ete3treeview.py", line 19, in <module>
    logger.warning("Could not import ete3 package. Visualization of dendrograms is unavailable.", e)
Message: 'Could not import ete3 package. Visualization of dendrograms is unavailable.'
Arguments: (ImportError("cannot import name 'TreeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)"),)
QT_QPA_PLATFORM unset. Attempting to set QT_QPA_PLATFORM='offscreen' and import ete3 package
Could not import ete3 package after adjusting QT_QPA_PLATFORM. Visualization of dendrograms is unavailable
("Could not properly import NodeStyle. Error message: [cannot import name 'NodeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)]. If the ete3 package is found, then this is likely due to a missing or improperly installed X server, which is required for graphical functionality within the ETE toolkit (see <https://github.com/etetoolkit/ete/issues/101>). Please either install an X server or attempt to run the application within a virtual framebuffer (like 'xvfb')", ImportError("cannot import name 'NodeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)"))
Usage: gdi analysis [OPTIONS] [GENOMES]...
Try 'gdi analysis --help' for help.

Error: No such option: --h Did you mean --help?
```


## genomics-data-index_gdi_load_vcf

### Tool Description
Load VCF files into the Genomics Data Index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
--- Logging error ---
Traceback (most recent call last):
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/ete3treeview.py", line 17, in <module>
    from ete3 import TreeStyle, NodeStyle, Face, RectFace, CircleFace, TextFace
ImportError: cannot import name 'TreeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/logging/__init__.py", line 1083, in emit
    msg = self.format(record)
  File "/usr/local/lib/python3.9/logging/__init__.py", line 927, in format
    return fmt.format(record)
  File "/usr/local/lib/python3.9/logging/__init__.py", line 663, in format
    record.message = record.getMessage()
  File "/usr/local/lib/python3.9/logging/__init__.py", line 367, in getMessage
    msg = msg % self.args
TypeError: not all arguments converted during string formatting
Call stack:
  File "/usr/local/bin/gdi", line 7, in <module>
    from genomics_data_index.cli.gdi import main
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/cli/gdi.py", line 21, in <module>
    from genomics_data_index.api.query.GenomicsDataIndex import GenomicsDataIndex
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 972, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 972, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/__init__.py", line 1, in <module>
    from genomics_data_index.api.query.GenomicsDataIndex import GenomicsDataIndex
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/GenomicsDataIndex.py", line 15, in <module>
    from genomics_data_index.api.query.impl.DataFrameSamplesQuery import DataFrameSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/DataFrameSamplesQuery.py", line 9, in <module>
    from genomics_data_index.api.query.impl.TreeSamplesQueryFactory import TreeSamplesQueryFactory
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/TreeSamplesQueryFactory.py", line 9, in <module>
    from genomics_data_index.api.query.impl.ExperimentalTreeSamplesQuery import ExperimentalTreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/ExperimentalTreeSamplesQuery.py", line 8, in <module>
    from genomics_data_index.api.query.impl.MutationTreeSamplesQuery import MutationTreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/MutationTreeSamplesQuery.py", line 7, in <module>
    from genomics_data_index.api.query.impl.TreeSamplesQuery import TreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/TreeSamplesQuery.py", line 10, in <module>
    from genomics_data_index.ete3treeview import TreeStyle, NodeStyle
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/ete3treeview.py", line 19, in <module>
    logger.warning("Could not import ete3 package. Visualization of dendrograms is unavailable.", e)
Message: 'Could not import ete3 package. Visualization of dendrograms is unavailable.'
Arguments: (ImportError("cannot import name 'TreeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)"),)
QT_QPA_PLATFORM unset. Attempting to set QT_QPA_PLATFORM='offscreen' and import ete3 package
Could not import ete3 package after adjusting QT_QPA_PLATFORM. Visualization of dendrograms is unavailable
("Could not properly import NodeStyle. Error message: [cannot import name 'NodeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)]. If the ete3 package is found, then this is likely due to a missing or improperly installed X server, which is required for graphical functionality within the ETE toolkit (see <https://github.com/etetoolkit/ete/issues/101>). Please either install an X server or attempt to run the application within a virtual framebuffer (like 'xvfb')", ImportError("cannot import name 'NodeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)"))
Usage: gdi load vcf [OPTIONS] VCF_FOFNS
Try 'gdi load vcf --help' for help.

Error: No such option: --h Did you mean --help?
```


## genomics-data-index_gdi_load_mlst-tseemann

### Tool Description
Load MLST data from TSEEMANN format into the Genomics Data Index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
--- Logging error ---
Traceback (most recent call last):
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/ete3treeview.py", line 17, in <module>
    from ete3 import TreeStyle, NodeStyle, Face, RectFace, CircleFace, TextFace
ImportError: cannot import name 'TreeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/logging/__init__.py", line 1083, in emit
    msg = self.format(record)
  File "/usr/local/lib/python3.9/logging/__init__.py", line 927, in format
    return fmt.format(record)
  File "/usr/local/lib/python3.9/logging/__init__.py", line 663, in format
    record.message = record.getMessage()
  File "/usr/local/lib/python3.9/logging/__init__.py", line 367, in getMessage
    msg = msg % self.args
TypeError: not all arguments converted during string formatting
Call stack:
  File "/usr/local/bin/gdi", line 7, in <module>
    from genomics_data_index.cli.gdi import main
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/cli/gdi.py", line 21, in <module>
    from genomics_data_index.api.query.GenomicsDataIndex import GenomicsDataIndex
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 972, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 972, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/__init__.py", line 1, in <module>
    from genomics_data_index.api.query.GenomicsDataIndex import GenomicsDataIndex
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/GenomicsDataIndex.py", line 15, in <module>
    from genomics_data_index.api.query.impl.DataFrameSamplesQuery import DataFrameSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/DataFrameSamplesQuery.py", line 9, in <module>
    from genomics_data_index.api.query.impl.TreeSamplesQueryFactory import TreeSamplesQueryFactory
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/TreeSamplesQueryFactory.py", line 9, in <module>
    from genomics_data_index.api.query.impl.ExperimentalTreeSamplesQuery import ExperimentalTreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/ExperimentalTreeSamplesQuery.py", line 8, in <module>
    from genomics_data_index.api.query.impl.MutationTreeSamplesQuery import MutationTreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/MutationTreeSamplesQuery.py", line 7, in <module>
    from genomics_data_index.api.query.impl.TreeSamplesQuery import TreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/TreeSamplesQuery.py", line 10, in <module>
    from genomics_data_index.ete3treeview import TreeStyle, NodeStyle
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/ete3treeview.py", line 19, in <module>
    logger.warning("Could not import ete3 package. Visualization of dendrograms is unavailable.", e)
Message: 'Could not import ete3 package. Visualization of dendrograms is unavailable.'
Arguments: (ImportError("cannot import name 'TreeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)"),)
QT_QPA_PLATFORM unset. Attempting to set QT_QPA_PLATFORM='offscreen' and import ete3 package
Could not import ete3 package after adjusting QT_QPA_PLATFORM. Visualization of dendrograms is unavailable
("Could not properly import NodeStyle. Error message: [cannot import name 'NodeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)]. If the ete3 package is found, then this is likely due to a missing or improperly installed X server, which is required for graphical functionality within the ETE toolkit (see <https://github.com/etetoolkit/ete/issues/101>). Please either install an X server or attempt to run the application within a virtual framebuffer (like 'xvfb')", ImportError("cannot import name 'NodeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)"))
Usage: gdi load mlst-tseemann [OPTIONS] [MLST_FILE]...
Try 'gdi load mlst-tseemann --help' for help.

Error: No such option: --h Did you mean --help?
```


## genomics-data-index_gdi_load_mlst-sistr

### Tool Description
Load MLST-sistr data into the Genomics Data Index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
--- Logging error ---
Traceback (most recent call last):
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/ete3treeview.py", line 17, in <module>
    from ete3 import TreeStyle, NodeStyle, Face, RectFace, CircleFace, TextFace
ImportError: cannot import name 'TreeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/logging/__init__.py", line 1083, in emit
    msg = self.format(record)
  File "/usr/local/lib/python3.9/logging/__init__.py", line 927, in format
    return fmt.format(record)
  File "/usr/local/lib/python3.9/logging/__init__.py", line 663, in format
    record.message = record.getMessage()
  File "/usr/local/lib/python3.9/logging/__init__.py", line 367, in getMessage
    msg = msg % self.args
TypeError: not all arguments converted during string formatting
Call stack:
  File "/usr/local/bin/gdi", line 7, in <module>
    from genomics_data_index.cli.gdi import main
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/cli/gdi.py", line 21, in <module>
    from genomics_data_index.api.query.GenomicsDataIndex import GenomicsDataIndex
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 972, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 972, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/__init__.py", line 1, in <module>
    from genomics_data_index.api.query.GenomicsDataIndex import GenomicsDataIndex
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/GenomicsDataIndex.py", line 15, in <module>
    from genomics_data_index.api.query.impl.DataFrameSamplesQuery import DataFrameSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/DataFrameSamplesQuery.py", line 9, in <module>
    from genomics_data_index.api.query.impl.TreeSamplesQueryFactory import TreeSamplesQueryFactory
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/TreeSamplesQueryFactory.py", line 9, in <module>
    from genomics_data_index.api.query.impl.ExperimentalTreeSamplesQuery import ExperimentalTreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/ExperimentalTreeSamplesQuery.py", line 8, in <module>
    from genomics_data_index.api.query.impl.MutationTreeSamplesQuery import MutationTreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/MutationTreeSamplesQuery.py", line 7, in <module>
    from genomics_data_index.api.query.impl.TreeSamplesQuery import TreeSamplesQuery
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/api/query/impl/TreeSamplesQuery.py", line 10, in <module>
    from genomics_data_index.ete3treeview import TreeStyle, NodeStyle
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/usr/local/lib/python3.9/site-packages/genomics_data_index/ete3treeview.py", line 19, in <module>
    logger.warning("Could not import ete3 package. Visualization of dendrograms is unavailable.", e)
Message: 'Could not import ete3 package. Visualization of dendrograms is unavailable.'
Arguments: (ImportError("cannot import name 'TreeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)"),)
QT_QPA_PLATFORM unset. Attempting to set QT_QPA_PLATFORM='offscreen' and import ete3 package
Could not import ete3 package after adjusting QT_QPA_PLATFORM. Visualization of dendrograms is unavailable
("Could not properly import NodeStyle. Error message: [cannot import name 'NodeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)]. If the ete3 package is found, then this is likely due to a missing or improperly installed X server, which is required for graphical functionality within the ETE toolkit (see <https://github.com/etetoolkit/ete/issues/101>). Please either install an X server or attempt to run the application within a virtual framebuffer (like 'xvfb')", ImportError("cannot import name 'NodeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)"))
Usage: gdi load mlst-sistr [OPTIONS] [MLST_FILE]...
Try 'gdi load mlst-sistr --help' for help.

Error: No such option: --h Did you mean --help?
```


## genomics-data-index_gdi_init

### Tool Description
Initialize an empty project folder for the genomics data index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi init [OPTIONS] PROJECT_DIR

Options:
  --help  Show this message and exit.
```

## genomics-data-index_gdi_load_vcf-kmer

### Tool Description
Load variants from VCF files and kmer sketches listed in an input file into the index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi load vcf-kmer [OPTIONS] VCF_KMER_FOFNS

Options:
  --reference-file PATH           Reference genome file
  --reference-name TEXT           Reference genome name
  --index-unknown / --no-index-unknown
                                  Enable/disable indexing unknown/missing
                                  positions. Indexing missing positions can
                                  significantly slow down the indexing
                                  process.  [default: index-unknown]
  --sample-batch-size INTEGER RANGE
                                  Number of samples to process within a single
                                  batch.  [default: 2000; x>=1]
  --build-tree / --no-build-tree  Builds tree of all samples after loading
                                  [default: no-build-tree]
  --align-type [core|full]        The type of alignment to generate ("core"
                                  implies is only --include-variants "SNP")
                                  [default: full]
  --include-variants [SNP|MNP|DELETION|DELETION_OTHER]
                                  Which type of variant(s) to include in tree.
                                  [default: SNP, MNP, DELETION]
  --extra-tree-params TEXT        Extra parameters to tree-building software
  --help                          Show this message and exit.
```

## genomics-data-index_gdi_load_snippy

### Tool Description
Load variants from a folder of snippy results (one sub-folder per sample) into the index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi load snippy [OPTIONS] SNIPPY_DIR

Options:
  --reference-file PATH           Reference genome file
  --reference-name TEXT           Reference genome name
  --index-unknown / --no-index-unknown
                                  Enable/disable indexing unknown/missing
                                  positions. Indexing missing positions can
                                  significantly slow down the indexing
                                  process.  [default: index-unknown]
  --sample-batch-size INTEGER RANGE
                                  Number of samples to process within a single
                                  batch.  [default: 2000; x>=1]
  --build-tree / --no-build-tree  Builds tree of all samples after loading
                                  [default: no-build-tree]
  --align-type [core|full]        The type of alignment to generate ("core"
                                  implies is only --include-variants "SNP")
                                  [default: full]
  --include-variants [SNP|MNP|DELETION|DELETION_OTHER]
                                  Which type of variant(s) to include in tree.
                                  [default: SNP, MNP, DELETION]
  --extra-tree-params TEXT        Extra parameters to tree-building software
  --help                          Show this message and exit.
```

## genomics-data-index_gdi_load_kmer

### Tool Description
Index kmers (sourmash sketches) of genomes listed in an input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi load kmer [OPTIONS] KMER_FOFNS

Options:
  --kmer-size INTEGER RANGE  Kmer size for indexing. List multiple for
                             multiple kmer sizes in an index  [default: 31;
                             1<=x<=201]
  --help                     Show this message and exit.
```

## genomics-data-index_gdi_load_mlst-chewbbaca

### Tool Description
Load MLST results from chewBBACA into the index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi load mlst-chewbbaca [OPTIONS] [MLST_FILE]...

Options:
  --scheme-name TEXT  Set scheme name  [required]
  --help              Show this message and exit.
```

## genomics-data-index_gdi_list_genomes

### Tool Description
List the reference genomes in the index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi list genomes [OPTIONS]

Options:
  --help  Show this message and exit.
```

## genomics-data-index_gdi_list_samples

### Tool Description
List the samples in the index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi list samples [OPTIONS]

Options:
  --help  Show this message and exit.
```

## genomics-data-index_gdi_db_size

### Tool Description
Show the size of the index database and its files.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi db size [OPTIONS]

Options:
  --unit [B|KB|MB|GB]  The unit to display data sizes as.  [default: B]
  --help               Show this message and exit.
```

## genomics-data-index_gdi_query

### Tool Description
Query the index for samples and summarize their mutations or MLST features.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi query [OPTIONS] [QUERY_COMMAND]...

Options:
  --reference-name TEXT           Reference genome name for querying by
                                  phylogenetic distance
  --summary / --no-summary        Print summary information on query
                                  [default: no-summary]
  --features-summary [mutations|mlst]
                                  Summarize by the passed feature.
  --features-summary-unique [mutations|mlst]
                                  Summarize by the passed feature (show only
                                  unique features).
  --include-annotations / --no-include-annotations
                                  If using --features-summary or --features-
                                  summary-unique specifies if variant
                                  annotations are included.  [default:
                                  include-annotations]
  --help                          Show this message and exit.
```

## genomics-data-index_gdi_export_tree

### Tool Description
Export the stored tree of a reference genome (Newick, or ASCII figure).

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi export tree [OPTIONS] [NAME]...

Options:
  --ascii / --no-ascii  Export as ASCII figure  [default: no-ascii]
  --help                Show this message and exit.
```

## genomics-data-index_gdi_build_alignment

### Tool Description
Build a multiple sequence alignment from the variants in the index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi build alignment [OPTIONS]

Options:
  --output-file PATH              Output file  [required]
  --reference-name TEXT           Reference genome name  [required]
  --align-type [core|full]        The type of alignment to generate ("core"
                                  implies is only --include-variants "SNP")
                                  [default: full]
  --include-variants [SNP|MNP|DELETION|DELETION_OTHER]
                                  Which type of variant(s) to include.
                                  [default: SNP, MNP, DELETION]
  --sample TEXT                   Sample to include in alignment (can list
                                  more than one).
  --help                          Show this message and exit.
```

## genomics-data-index_gdi_build_tree

### Tool Description
Build a phylogenetic tree (IQ-TREE) from the variants in the index.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi build tree [OPTIONS]

Options:
  --output-file PATH              Output file  [required]
  --reference-name TEXT           Reference genome name  [required]
  --align-type [core|full]        The type of alignment to use for generating
                                  the tree ("core" implies is only --include-
                                  variants "SNP")  [default: full]
  --tree-build-type [iqtree]      The type of tree building software
                                  [default: iqtree]
  --include-variants [SNP|MNP|DELETION|DELETION_OTHER]
                                  Which type of variant(s) to include.
                                  [default: SNP, MNP, DELETION]
  --sample TEXT                   Sample to include in tree (can list more
                                  than one).
  --extra-params TEXT             Extra parameters to tree-building software
  --help                          Show this message and exit.
```

## genomics-data-index_gdi_rebuild_tree

### Tool Description
Rebuild the stored tree of the index for one or more reference genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi rebuild tree [OPTIONS] [REFERENCE]...

Options:
  --align-type [core|full]        The type of alignment to use for generating
                                  the tree ("core" implies is only --include-
                                  variants "SNP")  [default: full]
  --include-variants [SNP|MNP|DELETION|DELETION_OTHER]
                                  Which type of variant(s) to include.
                                  [default: SNP, MNP, DELETION]
  --extra-params TEXT             Extra parameters to tree-building software
  --help                          Show this message and exit.
```

## genomics-data-index_gdi_input

### Tool Description
Write a table of samples and genome files (assembly or reads) for use with gdi analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi input [OPTIONS] [GENOMES]...

Options:
  --skip-existing-samples / --no-skip-existing-samples
                                  Skip samples that already exist in the
                                  index. Attempts to automatically detect
                                  sample names from file names.  [default:
                                  skip-existing-samples]
  --absolute / --no-absolute      Convert paths to absolute paths  [default:
                                  no-absolute]
  --input-genomes-file PATH       A file listing the genomes to process, one
                                  per line. This is an alternative to passing
                                  genomes as arguments on the command-line
  --check-files-exist / --no-check-files-exist
                                  Check that the passed files in the input
                                  genomes file exist  [default: check-files-
                                  exist]
  --help                          Show this message and exit.
```

## genomics-data-index_gdi_input-split-file

### Tool Description
Split multi-sequence FASTA files into one file per sequence and write a table of samples and files.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/apetkau/genomics-data-index
- **Package**: https://anaconda.org/channels/bioconda/packages/genomics-data-index/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gdi input-split-file [OPTIONS] [INPUT_FILES]...

Options:
  --absolute / --no-absolute  Convert paths to absolute paths  [default: no-
                              absolute]
  --output-dir PATH           The directory where individual output sequence
                              files should be written into.  [default: split-
                              files.1791490441.27392]
  --output-samples-file PATH  The file listing all the samples and linking
                              them back to the individual sequence files.
                              Defaults to STDOUT.
  --subsample-file PATH       Subsample the input files to contain only those
                              samples listed in the passed file (one sample
                              per line).
  --subsample FLOAT RANGE     Subsample the input files to contain only the
                              give number of samples. If >= 1 this is the
                              number of samples to select. If < 1 this is the
                              proportion of samples out of all sequences in
                              the input files (e.g., 0.5 means subsample to
                              50% of the original sequences).  [x>=0]
  --seed INTEGER              Seed for random number generator when
                              subsampling.
  --help                      Show this message and exit.
```

## Metadata
- **Skill**: generated
