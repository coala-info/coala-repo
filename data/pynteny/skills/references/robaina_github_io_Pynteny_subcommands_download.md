[Pynteny](../..)

* [Home](../..)

Subcommands

* [Search](../search/)
* [Build](../build/)
* [Parse](../parse/)
* [Download](./)

Examples

* [Example CLI](../../examples/example_cli/)
* [Example API](../../examples/example_api/)
* [Sus operon](../../examples/example_sus/)

References

* [API references](../../references/api/)

[Pynteny](../..)

* »
* Subcommands »
* Download
* [Edit on GitHub](https://github.com/Robaina/Pynteny/edit/master/docs/subcommands/download.md)

---

Download PGAP's HMM database from NCBI.

# Usage:

```
usage: pynteny download [-h] [args]
```

# Arguments

| short | long | default | help |
| --- | --- | --- | --- |
| `-h` | `--help` |  | show this help message and exit |
| `-o` | `--outdir` | `None` | path to the directory where to download HMM database. |
| `-u` | `--unpack` |  | unpack originally compressed database files |
| `-f` | `--force` |  | force-download database again if already downloaded. |
| `-l` | `--log` | `None` | path to log file. Log not written by default. |

## Description

download the latest version of the [NCBI Prokaryotic Genome Annotation Pipeline](https://github.com/ncbi/pgap) (PGAP) HMM database. Users may provide their own HMM database in the [search](https://github.com/Robaina/Pynteny/wiki/search) subcommand.

[Previous](../parse/ "Parse")
[Next](../../examples/example_cli/ "Example CLI")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).

[GitHub](https://github.com/Robaina/Pynteny)
[« Previous](../parse/)
[Next »](../../examples/example_cli/)