[iBridges](index.html)

Contents:

* [Quick Start Guide](quickstart.html)
* iBridges with Python
  + [The Session](session.html)
  + [iRODS paths](ipath.html)
  + [Data Transfers](data_transfers.html)
  + [Metadata](metadata.html)
  + [iRODS Search](irods_search.html)
  + [iBridges API Reference](api/main.html)
* [Command Line Interface](cli.html)
* [Frequently Asked Questions](faq.html)

[iBridges](index.html)

* iBridges with Python
* [View page source](_sources/ibridges_python.rst.txt)

---

# iBridges with Python[](#ibridges-with-python "Link to this heading")

This section is for users that want to use Python to connect to their iRODS server and perform
data manipulations. The Python API (Application Programming Interface) is the most feature complete
part of iBridges and it is also the most flexible, since users can manipulate the underlying
data structures to be able to use all the features of the underlying [python-irodsclient](https://github.com/irods/python-irodsclient)
library. Alternatively, users can use the [Command Line Interface](cli.html) or the [Graphical User Interface](https://github.com/chStaiger/iBridges-Gui).

* [The Session](session.html)
  + [Authentication with the iRODS server](session.html#authentication-with-the-irods-server)
  + [The Session object](session.html#the-session-object)
  + [The Session home](session.html#the-session-home)
  + [The Session cwd](session.html#the-session-cwd)
* [iRODS paths](ipath.html)
  + [IrodsPath](ipath.html#irodspath)
* [Data Transfers](data_transfers.html)
  + [Upload](data_transfers.html#upload)
  + [Download](data_transfers.html#download)
  + [Synchronisation](data_transfers.html#synchronisation)
  + [Streaming data objects](data_transfers.html#streaming-data-objects)
* [Metadata](metadata.html)
  + [The MetaData class](metadata.html#the-metadata-class)
  + [The MetaDataItem class](metadata.html#the-metadataitem-class)
  + [Add metadata](metadata.html#add-metadata)
  + [Set metadata](metadata.html#set-metadata)
  + [Find metadata items](metadata.html#find-metadata-items)
  + [Modify metadata items](metadata.html#modify-metadata-items)
  + [Delete metadata](metadata.html#delete-metadata)
  + [Export Metadata](metadata.html#export-metadata)
* [iRODS Search](irods_search.html)
  + [Search data by path pattern](irods_search.html#search-data-by-path-pattern)
  + [Search data by metadata](irods_search.html#search-data-by-metadata)
  + [Search data by checksum](irods_search.html#search-data-by-checksum)
  + [Search data by item type](irods_search.html#search-data-by-item-type)
* [iBridges API Reference](api/main.html)
  + [User Reference](api/user_reference.html)
  + [Full Reference](api/full_reference.html)

[Previous](quickstart.html "Quick Start Guide")
[Next](session.html "The Session")

---

© Copyright 2024, 2025, Utrecht University.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).