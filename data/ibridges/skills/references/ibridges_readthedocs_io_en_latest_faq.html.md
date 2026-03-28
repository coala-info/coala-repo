[iBridges](index.html)

Contents:

* [Quick Start Guide](quickstart.html)
* [iBridges with Python](ibridges_python.html)
* [Command Line Interface](cli.html)
* Frequently Asked Questions
  + [**When should I use iBridges instead of python-irodsclient/iCommands?**](#when-should-i-use-ibridges-instead-of-python-irodsclient-icommands)
  + [**I found a bug or have a feature request, where do I go?**](#i-found-a-bug-or-have-a-feature-request-where-do-i-go)
  + [**I want to contribute to iBridges, where do I go?**](#i-want-to-contribute-to-ibridges-where-do-i-go)
  + [**I have installed iBridges and now get “ibridges: command not found”**](#i-have-installed-ibridges-and-now-get-ibridges-command-not-found)
  + [**Help, I’m getting a “NetworkError” while trying to transfer (large) files**](#help-i-m-getting-a-networkerror-while-trying-to-transfer-large-files)
  + [**During data transfers I receive warnings or errors. How can I steer the verbosity?**](#during-data-transfers-i-receive-warnings-or-errors-how-can-i-steer-the-verbosity)
  + [**My metadata with keys starting with `org\_` do not show up in the iBridges metadata.**](#my-metadata-with-keys-starting-with-org-do-not-show-up-in-the-ibridges-metadata)

[iBridges](index.html)

* Frequently Asked Questions
* [View page source](_sources/faq.rst.txt)

---

# Frequently Asked Questions[](#frequently-asked-questions "Link to this heading")

## **When should I use iBridges instead of python-irodsclient/iCommands?**[](#when-should-i-use-ibridges-instead-of-python-irodsclient-icommands "Link to this heading")

The python-irodsclient and the iCommands are much more powerful and expressive than iBridges. If you are already
intimately familiar with either of them, you probably don’t need iBridges, since it doesn’t add any functionality that isn’t
already there.

The target audience of iBridges is different: it tries to help researchers/users that are not
expert iRODS users. The learning curve of using iBridges is much easier than either of the two alternatives.
Additionally, its simplicity and default checks makes it less likely you will end up with bad data.

An advantage compared to the iCommands is that iBridges also works on Mac OS and Windows.

## **I found a bug or have a feature request, where do I go?**[](#i-found-a-bug-or-have-a-feature-request-where-do-i-go "Link to this heading")

Our development is done on [GitHub](https://github.com/iBridges-for-iRODS/iBridges) Look under the Issues section
whether the bug or feature request has already been reported. If not, we heartily welcome creating a new issue. We
try to get back to you as soon as possible, at least within a few days.

## **I want to contribute to iBridges, where do I go?**[](#i-want-to-contribute-to-ibridges-where-do-i-go "Link to this heading")

Our development is done on [GitHub](https://github.com/iBridges-for-iRODS/iBridges) We are welcoming contributions
by pull requests. You can also ask for new features/ideas in our issue tracker.

## **I have installed iBridges and now get “ibridges: command not found”**[](#i-have-installed-ibridges-and-now-get-ibridges-command-not-found "Link to this heading")

This can happen for a variety for reasons, but the most common reason is that your PATH is not setup correctly on your system.
Often pip will complain about this when you install ibridges. To solve this, you must first find out where pip installs the
ibridges executable. Usually this will be something like /home/your\_username/.local/bin, but this is dependent on your system. Then we must
add this to the path on the command line: export PATH=”${PATH}:/home/your\_username/.local/bin” (change the path according to your system). This should allow
your shell to find the ibridges command. You would have to type the previous command every time you start a new shell, which can be inconvenient.
To fix this permanently, add the command to your .bashrc or .zshrc file in your home directory at the end of the file
(depending on your shell, type echo ${SHELL} to find out).

## **Help, I’m getting a “NetworkError” while trying to transfer (large) files**[](#help-i-m-getting-a-networkerror-while-trying-to-transfer-large-files "Link to this heading")

This error is most likely to happen if you try to transfer a large file. The default timeout for iBridges is 25000 seconds,
which translates to roughly 7 hours. This should not cause issues during the actual transfer. However, if the calculation
of the checksum takes more than 7 hours (if the iRODS server is busy for example, or the file is many terabytes), then
you will get a network error. The checksum itself should still be created. You can increase the timeout in your irods\_environment.json
file by adding a new entry with `"connection_timeout": <time in seconds>,`.

Note, that the **maximum number equals to 292 years**, i.e. “connection\_timeout”: 9208512000,.

## **During data transfers I receive warnings or errors. How can I steer the verbosity?**[](#during-data-transfers-i-receive-warnings-or-errors-how-can-i-steer-the-verbosity "Link to this heading")

iBridges tries to prevent overwriting data by accident. However, sometimes data needs to be overwritten. In those cases iBridges informs the user that data has been overwritten. To steer the behaviour we implemented the flags overwrite and ignore\_err in the data transfer functions sync, upload and download:

Data transfer flags[](#id1 "Link to this table")

| overwrite | ignore\_err | Outcome |
| --- | --- | --- |
| False | False | Throws FileExistsError if data already exists. |
| True | False | Overwrite existing data.  Other errors are thrown. |
| False | True | Skip the data which already exists and print a warning. |
| True | True | Overwrite existing data.  All errors are turned into warning. |

Warnings can also be switched off through python’s warnings package:

```
import warnings
warnings.filterwarnings("ignore")
```

## **My metadata with keys starting with `org\_` do not show up in the iBridges metadata.**[](#my-metadata-with-keys-starting-with-org-do-not-show-up-in-the-ibridges-metadata "Link to this heading")

By default, iBridges **does not show** metadata that contain a key starting with the prefix org\_. This is due to data security reasons on [Yoda systems](https://github.com/UtrechtUniversity/yoda).

You can omit this by the following code:

```
from ibridges.meta import MetaData

# collections
meta = MetaData(IrodsPath(session, "~", "my_coll").collection, blacklist=None)
# data objects
meta = MetaData(IrodsPath(session, "~", "my_obj").dataobject, blacklist=None)
print(meta)
```

[Previous](api/cli.html "Reference")

---

© Copyright 2024, 2025, Utrecht University.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).