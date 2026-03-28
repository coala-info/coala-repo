[Pynteny](../..)

* [Home](../..)

Subcommands

* [Search](./)
* [Build](../build/)
* [Parse](../parse/)
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
* Search
* [Edit on GitHub](https://github.com/Robaina/Pynteny/edit/master/docs/subcommands/search.md)

---

Query sequence database for HMM hits arranged in provided synteny structure.

## Usage

```
usage: pynteny search [-h] [args]
```

## Arguments

| short | long | default | help |
| --- | --- | --- | --- |
| `-h` | `--help` |  | show this help message and exit |
| `-s` | `--synteny_struc` | `None` | string displaying hmm structure to search for, such as: '>hmm\_a n\_ab ' indicates a hmm target located on the positive strand, '<' a target located on the negative strand, and n\_ab cooresponds to the maximum number of genes separating matched genes a and b. Multiple hmms may be employed. No order symbol in a hmm indicates that results should be independent of strand location. |
| `-i` | `--data` | `None` | path to fasta file containing peptide database. Record labels must follow the format specified in docs (see section: General Usage). Pynteny build subcommand exports the generated database in the correct format |
| `-d` | `--hmm_dir` | `None` | path to directory containing hmm (i.e, tigrfam or pfam) models. IMPORTANT: the directory must contain one hmm per file, and the file name must coincide with the hmm name that will be displayed in the synteny structure. The directory can contain more hmm models than used in the synteny structure. It may also be the path to a compressed (tar, tar.gz, tgz) directory. If not provided, hmm models (PGAP database) will be downloaded from the NCBI. (if not already downloaded) |
| `-o` | `--outdir` | `None` | path to output directory |
| `-x` | `--prefix` | `` | prefix to be added to output files |
| `-p` | `--processes` | `None` | maximum number of processes available to HMMER. Defaults to all but one. |
| `-a` | `--hmmsearch_args` | `None` | list of comma-separated additional arguments to hmmsearch for each input hmm. A single argument may be provided, in which case the same additional argument is employed in all hmms. |
| `-g` | `--gene_ids` |  | use gene symbols in synteny structure instead of HMM names. If set, a path to the hmm database metadata file must be provided in argument '--hmm\_meta' |
| `-u` | `--unordered` |  | whether the HMMs should be arranged in the exact same order displayed in the synteny\_structure or in any order. If ordered, the filters will filter collinear rather than syntenic structures. If more than two HMMs are employed, the largest maximum distance among any pair is considered to run the search. |
| `-r` | `--reuse` |  | reuse hmmsearch result table in following synteny searches. Do not delete hmmer\_outputs subdirectory for this option to work. |
| `-m` | `--hmm_meta` | `None` | path to hmm database metadata file |
| `-l` | `--log` | `None` | path to log file. Log not written by default. |

## Description

Search for synteny blocks in a set of ORFs using HMMER and outputs the results in a tabular format. Synteny blocks are specified by strings of ordered HMM names or gene IDs with the following format:

\[\lt HMM\_a \space n\_{ab} \space \lt HMM\_b \space n\_{bc} \space \lt(HMM\_{c1}|HMM\_{c2}|HMM\_{c3}),\]

where \(n\_{ab}\) corresponds to the maximum number of genes between \(HMM\_a\) and \(HMM\_b\). Results can be strand-specific, in that case, \(>\) preceding an HMM name indicates that the corresponding ORF must be located in the positive (or sense) strand. Likewise, a \(<\) symbol indicates that the ORF must be located in the negative (antisense) strand. Searches can be made strand-insensitive by omitting the \(>\) or \(<\) symbol.

Several HMMs can be assigned to the same ORF, in which case the search is performed for all of them. In this case, HMM names must be separated by "|" and grouped within parentheses, as shown above.

If the PGAP database is employed (see `pynteny download` below), synteny blocks can also be specified by gene symbols, such as \(\(\lt leuD \space 0 \space \lt leuC \space 1 \space \lt leuA.\)\) In that case, the program will try to match gene symbols to HMM names in the PGAP database before running the search.

[Previous](../.. "Home")
[Next](../build/ "Build")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).

[GitHub](https://github.com/Robaina/Pynteny)
[« Previous](../..)
[Next »](../build/)