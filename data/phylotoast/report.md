# phylotoast CWL Generation Report

## phylotoast_LDA.py

### Tool Description
Performs Latent Dirichlet Allocation (LDA) analysis on phylogenetic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
- **Homepage**: https://github.com/smdabdoub/phylotoast
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phylotoast/overview
- **Total Downloads**: 15.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/smdabdoub/phylotoast
- **Stars**: N/A
### Original Help Text
```text
/usr/local/lib/python2.7/site-packages/matplotlib/font_manager.py:273: UserWarning: Matplotlib is building the font cache using fc-list. This may take a moment.
  warnings.warn('Matplotlib is building the font cache using fc-list. This may take a moment.')
Traceback (most recent call last):
  File "/usr/local/bin/LDA.py", line 4, in <module>
    __import__('pkg_resources').run_script('phylotoast==1.4.0rc2', 'LDA.py')
  File "/usr/local/lib/python2.7/site-packages/setuptools-27.2.0-py2.7.egg/pkg_resources/__init__.py", line 744, in run_script
  File "/usr/local/lib/python2.7/site-packages/setuptools-27.2.0-py2.7.egg/pkg_resources/__init__.py", line 1506, in run_script
  File "/usr/local/lib/python2.7/site-packages/phylotoast-1.4.0rc2-py2.7.egg/EGG-INFO/scripts/LDA.py", line 10, in <module>
    
  File "build/bdist.linux-x86_64/egg/phylotoast/graph_util.py", line 21, in <module>
  File "/usr/local/lib/python2.7/site-packages/matplotlib/pyplot.py", line 114, in <module>
    _backend_mod, new_figure_manager, draw_if_interactive, _show = pylab_setup()
  File "/usr/local/lib/python2.7/site-packages/matplotlib/backends/__init__.py", line 32, in pylab_setup
    globals(),locals(),[backend_name],0)
  File "/usr/local/lib/python2.7/site-packages/matplotlib/backends/backend_qt5agg.py", line 16, in <module>
    from .backend_qt5 import QtCore
  File "/usr/local/lib/python2.7/site-packages/matplotlib/backends/backend_qt5.py", line 31, in <module>
    from .qt_compat import QtCore, QtGui, QtWidgets, _getSaveFileName, __version__
  File "/usr/local/lib/python2.7/site-packages/matplotlib/backends/qt_compat.py", line 137, in <module>
    from PyQt4 import QtCore, QtGui
ImportError: No module named PyQt4
```


## phylotoast_transform_biom.py

### Tool Description
This script applies varioustransforms to the data in a given BIOM-format table
and outputs a newBIOM table with the transformed data.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
- **Homepage**: https://github.com/smdabdoub/phylotoast
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: transform_biom.py [-h] -i BIOM_TABLE_FP
                         [-t {arcsin_sqrt,log10,ra,ra_log10}]
                         [--fmt {hdf5,json,tsv}] [--gzip] -o OUTPUT_FP [-v]

This script applies varioustransforms to the data in a given BIOM-format table
and outputs a newBIOM table with the transformed data.

optional arguments:
  -h, --help            show this help message and exit
  -i BIOM_TABLE_FP, --biom_table_fp BIOM_TABLE_FP
                        Path to the input BIOM-format table. [REQUIRED]
  -t {arcsin_sqrt,log10,ra,ra_log10}, --transform {arcsin_sqrt,log10,ra,ra_log10}
                        The transform to apply to the data. Default: arcsine
                        square root.
  --fmt {hdf5,json,tsv}
                        Set the output format of the BIOM table. Default is
                        HDF5.
  --gzip                Compress the output BIOM table with gzip. HDF5 BIOM
                        (v2.x) files are internally compressed by default, so
                        this option is not needed when specifying --fmt hdf5.
  -o OUTPUT_FP, --output_fp OUTPUT_FP
                        Output path for the transformed BIOM table.[REQUIRED]
  -v, --verbose
```


## phylotoast_restrict_repset.py

### Tool Description
Take a subset BIOM table (e.g. from a core calculation) and a representative set (repset) FASTA file and create a new repset restricted to the OTUs in the BIOM table.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
- **Homepage**: https://github.com/smdabdoub/phylotoast
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: restrict_repset.py [-h] -i BIOM_FP -r REPSET_FP [-o REPSET_OUT_FP]

Take a subset BIOM table (e.g. from a core calculation) and a representative
set (repset) FASTA file and create a new repset restricted to the OTUs in the
BIOM table.

optional arguments:
  -h, --help            show this help message and exit
  -i BIOM_FP, --biom_fp BIOM_FP
                        Path to a biom-format file with OTU-Sample abundance
                        data.
  -r REPSET_FP, --repset_fp REPSET_FP
                        Path to a FASTA-format file containing the
                        representative set of OTUs
  -o REPSET_OUT_FP, --repset_out_fp REPSET_OUT_FP
                        Path to the new restricted repset file
```


## phylotoast_otu_to_tax_name.py

### Tool Description
Convert a list of OTU IDs to a list of OTU IDs paired with Genus_Species identifiers and perform reverse lookup, if needed.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
- **Homepage**: https://github.com/smdabdoub/phylotoast
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: otu_to_tax_name.py [-h] -i OTU_TABLE -oid OTU_ID_FP [-o OUTPUT_FP]
                          [--reverse_lookup]

Convert a list of OTU IDs to a list of OTU IDs paired with Genus_Species
identifiers and perform reverse lookup, if needed.

optional arguments:
  -h, --help            show this help message and exit
  -i OTU_TABLE, --otu_table OTU_TABLE
                        Input biom file format OTU table. [REQUIRED]
  -oid OTU_ID_FP, --otu_id_fp OTU_ID_FP
                        A single or multi-column (tab-separated) file
                        containing the OTU IDs to be converted in the first
                        column. [REQUIRED]
  -o OUTPUT_FP, --output_fp OUTPUT_FP
                        For a list input, a new file containing a list of OTU
                        IDs and their corresponding short taxonomic
                        identifiers separated by tabs. For a BIOM file input,
                        a new mapping file with all the OTU IDs replaced by
                        the short identifier.[REQUIRED]
  --reverse_lookup      Get OTUIDs from genus-species OTU name.
```

