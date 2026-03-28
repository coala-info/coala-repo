# genomics-data-index CWL Generation Report

## genomics-data-index_gdi analysis

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


## genomics-data-index_gdi load vcf

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


## genomics-data-index_gdi load mlst-tseemann

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


## genomics-data-index_gdi load mlst-sistr

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


## Metadata
- **Skill**: generated
