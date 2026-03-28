[Pynteny](../..)

* [Home](../..)

Subcommands

* [Search](../search/)
* [Build](../build/)
* [Parse](./)
* [Download](../download/)

Examples

* [Example CLI](../../examples/example_cli/)
* [Example API](../../examples/example_api/)
* [Sus operon](../../examples/example_sus/)

References

* [API references](../../references/api/)

[Pynteny](../..)

* »
* Subcommands »
* Parse
* [Edit on GitHub](https://github.com/Robaina/Pynteny/edit/master/docs/subcommands/parse.md)

---

# Description

Translate synteny structure with gene symbols into one with
HMM groups, according to provided HMM database.

# Usage:

```
usage: pynteny parse [-h] [args]
```

# Arguments

| short | long | default | help |
| --- | --- | --- | --- |
| `-h` | `--help` |  | show this help message and exit |
| `-s` | `--synteny_struc` | `None` | synteny structure containing gene symbols instead of HMMs |
| `-m` | `--hmm_meta` | `None` | path to hmm database metadata file. If already downloaded with pynteny download, hmm meta file is retrieved from the default location. |
| `-l` | `--log` | `None` | path to log file. Log not written by default. |

[Previous](../build/ "Build")
[Next](../download/ "Download")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).

[GitHub](https://github.com/Robaina/Pynteny)
[« Previous](../build/)
[Next »](../download/)