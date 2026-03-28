[iBridges](index.html)

Contents:

* Quick Start Guide
  + [Python Installation](#python-installation)
  + [Installation](#installation)
  + [Configure iBridges](#configure-ibridges)
  + [Configuration of your home collection](#configuration-of-your-home-collection)
  + [Connecting to your iRODS server](#connecting-to-your-irods-server)
  + [Upload data](#upload-data)
  + [Add metadata](#add-metadata)
  + [Download data](#download-data)
  + [Closing the session](#closing-the-session)
* [iBridges with Python](ibridges_python.html)
* [Command Line Interface](cli.html)
* [Frequently Asked Questions](faq.html)

[iBridges](index.html)

* Quick Start Guide
* [View page source](_sources/quickstart.rst.txt)

---

# Quick Start Guide[](#quick-start-guide "Link to this heading")

## Python Installation[](#python-installation "Link to this heading")

iBridges requires Python version 3.8 or higher. There are many ways to install Python, also depending on your operating system.
Any of these methods can work, but the path/environment needs to be set correctly so that the commands below work. For users
that are completely unfamiliar with Python and have never installed it, we recommend installing [Anaconda](https://www.anaconda.com/download/success).

Note

Beware of the difference between the command line prompt and the python console. The command line prompt, which might also be called
terminal, console, console or powershell, is the place where you can install iBridges and use the
command line interface ([CLI](cli.html)). The Python console can be used to interactively execute python code
and can be started from the command line prompt by typing python and hitting enter.

To check whether your installation works correctly you can execute the following commands on the command line:

```
python --version
pip --version
```

This should give you the version of the installed Python and pip respectively. If you get a
SyntaxError you are most likely using the python console and not your command line prompt.
If you get Python: command not found or something similar, then your path is not set up correctly.
Make sure that during installation you check the box that sets your environment for you.

## Installation[](#installation "Link to this heading")

You can install iBridges with pip using the command line:

```
pip install ibridges
```

## Configure iBridges[](#configure-ibridges "Link to this heading")

iBridges connects to an iRODS server. To do so it needs an iRODS client configuration file, the irods\_environment.json.
It is the same file which is also used with other iRODS clients e.g. the (icommands).

Below we give an example of such a file

```
{
    "irods_host": "<iRODS servername or IP address>",
    "irods_port": 8247,
    "irods_user_name": "<irods username>",
    "irods_home": "/<irods_zone>/home/<irods username>",
    "irods_zone_name": "<iRODS zone name>",
    "irods_client_server_negotiation": "request_server_negotiation",
    "irods_client_server_policy": "CS_NEG_REQUIRE",
    "irods_default_hash_scheme": "SHA256",
    "irods_default_resource": "irodsResc",
    "irods_encryption_algorithm": "AES-256-CBC",
    "irods_encryption_key_size": 32,
    "irods_encryption_num_hash_rounds": 16,
    "irods_encryption_salt_size": 8
}
```

It is recommended to store this file in the default location ~/.irods/irods\_environment.json.
However, if needed you can point iBridges also to a different location.

Ensure that the file is saved as .json.

## Configuration of your home collection[](#configuration-of-your-home-collection "Link to this heading")

iBridges makes use of the configuration setting “irods\_home”. The “irods\_home” is your default path on the iRODS server which in iBridges you can address with ~ when creating paths.

In a default iRODS instance you have a personal location on the iRODS server with the path

```
/<zone_name>/home/<username>
```

However, this can differ. E.g. on Yoda instances you will belong to a research group and hence your iRODS home will be:

```
/<zone_name>/home/research-<group name>
```

Please ask your iRODS admin or service provider how to set up the irods\_environment.json such that it matches your iRODS instance.

## Connecting to your iRODS server[](#connecting-to-your-irods-server "Link to this heading")

To connect to your iRODS server, we will create a session. The session is the central object in the iBridges library;
almost all functionality is enabled with this connection to your server. Generally you will create a session,
perform your data operations, and then delete/close the session. To create a new session, open Python:

```
from ibridges import Session
from pathlib import Path

session = Session(irods_env_path=Path.home() / ".irods" / "irods_environment.json", password="mypassword")
```

## Upload data[](#upload-data "Link to this heading")

You can easily upload your data with the previously created session:

```
from ibridges import upload

upload(session, "/your/local/path", "/irods/path")
```

This upload function can upload both directories (collections in iRODS) and files (data objects in iRODS).

## Add metadata[](#add-metadata "Link to this heading")

One of the powerful features of iRODS is its ability to store metadata with your data in a consistent manner.
Let’s add some metadata to a collection or data object:

```
from ibridges import IrodsPath

ipath = IrodsPath(session, "/irods/path")
ipath.meta.add("some_key", "some_value", "some_units")
```

We have used the `IrodsPath` class here, which is another central class to the iBridges API. From here we have
access to the metadata as shown above, but additionally there are many more convenient features directly accessible
such as getting the size of a collection or data object. A detailed description of the features is present in
another part of the [documentation](ipath.html).

## Download data[](#download-data "Link to this heading")

Naturally, we also want to download the data back to our local machine. This is done with the download function:

```
from ibridges import download

download(session, "/irods/path", "/other/local/path")
```

## Closing the session[](#closing-the-session "Link to this heading")

When you are done with your session, you should generally close it:

```
session.close()
```

[Previous](index.html "Welcome to the iBridges documentation!")
[Next](ibridges_python.html "iBridges with Python")

---

© Copyright 2024, 2025, Utrecht University.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).