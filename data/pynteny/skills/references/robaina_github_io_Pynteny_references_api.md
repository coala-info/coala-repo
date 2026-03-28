[Pynteny](../..)

* [Home](../..)

Subcommands

* [Search](../../subcommands/search/)
* [Build](../../subcommands/build/)
* [Parse](../../subcommands/parse/)
* [Download](../../subcommands/download/)

Examples

* [Example CLI](../../examples/example_cli/)
* [Example API](../../examples/example_api/)
* [Sus operon](../../examples/example_sus/)

References

* [API references](./)

[Pynteny](../..)

* »
* References »
* API references
* [Edit on GitHub](https://github.com/Robaina/Pynteny/edit/master/docs/references/api.md)

---

## Module api

Classes to facilitate usage within Python scripts / Notebooks

## `Build`

Bases: `[Command](#src.pynteny.api.Command "src.pynteny.api.Command")`

Build command object.

Source code in `src/pynteny/api.py`

|  |  |
| --- | --- |
| ``` 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 ``` | ``` class Build(Command):     """Build command object."""      def __init__(         self,         data: Path,         prepend: bool = False,         outfile: Path = None,         logfile: Path = None,         processes: int = None,         tempdir: Path = None,     ):         """Translate nucleotide assembly file and assign contig and gene location            info to each identified ORF (using prodigal).          Args:             data (Path): _description_             outfile (Path, optional): path to file containing built database. Defaults to None.             logfile (Path, optional): path to logfile. Defaults to None.             processes (int, optional): maximum number of processes. Defaults to all minus one.             tempdir (Path, optional): path to directory to contain temporary files. Defaults to None.         """          self._args = CommandArgs(             data=Path(data),             prepend=prepend,             outfile=Path(outfile) if outfile is not None else outfile,             logfile=Path(logfile) if logfile is not None else logfile,             processes=processes,             tempdir=Path(tempdir) if tempdir is not None else tempdir,         )      def run(self) -> None:         """Run pynteny search"""         return build_database(self._args) ``` |

### `__init__(data, prepend=False, outfile=None, logfile=None, processes=None, tempdir=None)`

Translate nucleotide assembly file and assign contig and gene location
info to each identified ORF (using prodigal).

**Parameters:**

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `data` | `Path` | *description* | *required* |
| `outfile` | `Path` | path to file containing built database. Defaults to None. | `None` |
| `logfile` | `Path` | path to logfile. Defaults to None. | `None` |
| `processes` | `int` | maximum number of processes. Defaults to all minus one. | `None` |
| `tempdir` | `Path` | path to directory to contain temporary files. Defaults to None. | `None` |

Source code in `src/pynteny/api.py`

|  |  |
| --- | --- |
| ``` 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 ``` | ``` def __init__(     self,     data: Path,     prepend: bool = False,     outfile: Path = None,     logfile: Path = None,     processes: int = None,     tempdir: Path = None, ):     """Translate nucleotide assembly file and assign contig and gene location        info to each identified ORF (using prodigal).      Args:         data (Path): _description_         outfile (Path, optional): path to file containing built database. Defaults to None.         logfile (Path, optional): path to logfile. Defaults to None.         processes (int, optional): maximum number of processes. Defaults to all minus one.         tempdir (Path, optional): path to directory to contain temporary files. Defaults to None.     """      self._args = CommandArgs(         data=Path(data),         prepend=prepend,         outfile=Path(outfile) if outfile is not None else outfile,         logfile=Path(logfile) if logfile is not None else logfile,         processes=processes,         tempdir=Path(tempdir) if tempdir is not None else tempdir,     ) ``` |

### `run()`

Run pynteny search

Source code in `src/pynteny/api.py`

|  |  |
| --- | --- |
| ``` 202 203 204 ``` | ``` def run(self) -> None:     """Run pynteny search"""     return build_database(self._args) ``` |

## `Command`

Parent class for Pynteny command

Source code in `src/pynteny/api.py`

|  |  |
| --- | --- |
| ``` 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 ``` | ``` class Command:     """     Parent class for Pynteny command      Args:         CommandArgs     """      def _repr_html_(self):         """Executed by Jupyter to print Author and version in html"""         return """         <table>             <tr>                 <td><strong>Pynteny version</strong></td><td>{version}</td>             </tr><tr>                 <td><strong>Author</strong></td><td>{author}</td>             </tr>         </table>         """.format(             version=__version__, author=__author__         )      def update(self, argname: str, value: str) -> None:         """Update argument value in pynteny command.          Args:             argname (str): argument name to be updated.             value (str): new argument value.         """         setattr(self._args, argname, value)      @staticmethod     def cite():         """Display Pynteny citation"""         args = CommandArgs(version=__version__, author=__author__)         citation = get_citation(args, silent=True)         print(citation) ``` |

### `cite()` `staticmethod`

Display Pynteny citation

Source code in `src/pynteny/api.py`

|  |  |
| --- | --- |
| ``` 57 58 59 60 61 62 ``` | ``` @staticmethod def cite():     """Display Pynteny citation"""     args = CommandArgs(version=__version__, author=__author__)     citation = get_citation(args, silent=True)     print(citation) ``` |

### `update(argname, value)`

Update argument value in pynteny command.

**Parameters:**

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `argname` | `str` | argument name to be updated. | *required* |
| `value` | `str` | new argument value. | *required* |

Source code in `src/pynteny/api.py`

|  |  |
| --- | --- |
| ``` 48 49 50 51 52 53 54 55 ``` | ``` def update(self, argname: str, value: str) -> None:     """Update argument value in pynteny command.      Args:         argname (str): argument name to be updated.         value (str): new argument value.     """     setattr(self._args, argname, value) ``` |

## `Download`

Bases: `[Command](#src.pynteny.api.Command "src.pynteny.api.Command")`

Download HMM database from NCBI.

Source code in `src/pynteny/api.py`

|  |  |
| --- | --- |
| ``` 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 ``` | ``` class Download(Command):     """Download HMM database from NCBI."""      def __init__(         self,         outdir: Path,         logfile: Path = None,         force: bool = False,         unpack: bool = False,     ):         """Download HMM database from NCBI.          Args:             outdir (Path): path to ouput directory in which to store downloaded HMMs.             logfile (Path, optional): path to log file. Defaults to None.             force (bool, optional): force-download database again if already downloaded.             unpack (bool, optional): whether to unpack downloaded file. If False, then PGAP's database.                 will be unpacked in each Pynteny session. Defaults to False.         """          self._args = CommandArgs(             outdir=Path(outdir),             logfile=Path(logfile) if logfile is not None else logfile,             force=force,             unpack=unpack,         )      def run(self) -> None:         """Run pynteny download"""         return download_hmms(self._args) ``` |

### `__init__(outdir, logfile=None, force=False, unpack=False)`

Download HMM database from NCBI.

**Parameters:**

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `outdir` | `Path` | path to ouput directory in which to store downloaded HMMs. | *required* |
| `logfile` | `Path` | path to log file. Defaults to None. | `None` |
| `force` | `bool` | force-download database again if already downloaded. | `False` |
| `unpack` | `bool` | whether to unpack downloaded file. If False, then PGAP's database. will be unpacked in each Pynteny session. Defaults to False. | `False` |

Source code in `src/pynteny/api.py`

|  |  |
| --- | --- |
| ``` 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 ``` | ``` def __init__(     self,     outdir: Path,     logfile: Path = None,     force: bool = False,     unpack: bool = False, ):     """Download HMM database from NCBI.      Args:         outdir (Path): path to ouput directory in which to store downloaded HMMs.         logfile (Path, optional): path to log file. Defaults to None.         force (bool, optional): force-download database again if already downloaded.         unpack (bool, optional): whether to unpack downloaded file. If False, then PGAP's database.             will be unpacked in each Pynteny session. Defaults to False.     """      self._args = CommandArgs(         outdir=Path(outdir),         logfile=Path(logfile) if logfile is not None else logfile,         force=force,         unpack=unpack,     ) ``` |

### `run()`

Run pynteny download

Source code in `src/pynteny/api.py`

|  |  |
| --- | --- |
| ``` 234 235 236 ``` | ``` def run(self) -> None:     """Run pynteny download"""     return download_hmms(self._args) ``` |

## `Search`

Bases: `[Command](#src.pynteny.api.Command "src.pynteny.api.Command")`

Search command object.

Source code in `src/pynteny/api.py`

|  |  |
| --- | --- |
| ```  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 ``` | ``` class Search(Command):     """Search command object."""      def __init__(         self,         data: Path,         synteny_struc: str,         gene_ids: bool = False,         unordered: bool = False,         reuse: bool = False,         hmm_dir: Path = None,         hmm_meta: Path = None,         outdir: Path = None,         prefix: str = "",         hmmsearch_args: str = None,         logfile: Path = None,         processes: int = None,     ):         """Query sequence database for HMM hits arranged in provided synteny structure.          Args:             data (Path): path to input labelled database.             synteny_struc (str): a str describing the desired synteny structure,                 structured as follows:                  '>hmm_a N_ab hmm_b bc <hmm_c'                  where N_ab corresponds to the maximum number of genes separating                 gene found by hmm_a and gene found by hmm_b, and hmm_ corresponds                 to the name of the hmm as provided in the keys of hmm_hits.                 More than two hmms can be concatenated. Strand location may be                 specificed by using '>' for sense and '<' for antisense.             gene_ids (bool, optional): whether gene symbols are used in synteny                 string instead of HMM names. Defaults to False.             unordered (bool, optional): whether the HMMs should be arranged in the                 exact same order displayed in the synteny_structure or in                 any order If ordered, the filters would filter collinear rather                 than syntenic structures. Defaults to False.             reuse (bool, optional): if True then HMMER3 won't be run again for HMMs already                 searched in the same output directory. Defaults to False.             hmm_dir (Path, optional): path to directory containing input HMM files.                 Defaults to None, in which case the PGAP database is downloaded if not                 already so.             hmm_meta (Path, optional): path to PGAP's metadata file. Defaults to None.             outdir (Path, optional): path to output directory. Defaults to None.             prefix (str, optional): prefix of output file names. Defaults to "".             hmmsearch_args (str, optional): additional arguments to hmmsearch or hmmscan. Each                 element in the list is a string with additional arguments for each                 input hmm (arranged in the same order), an element can also take a                 value of None to avoid passing additional arguments for a specific                 input hmm. A single string may also be passed, in which case the                 same additional argument is passed to hmmsearch for all input hmms.                 Defaults to None. Defaults to None.             logfile (Path, optional): path to log file. Defaults to None.             processes (int, optional): maximum number of threads to be employed.                 Defaults to all minus one.         """          self._args = CommandArgs(             data=Path(data),             synteny_struc=synteny_struc,             hmm_dir=Path(hmm_dir) if hmm_dir is not None else hmm_dir,             hmm_meta=Path(hmm_meta) if hmm_meta is not None else hmm_meta,             outdir=Path(outdir) if outdir is not None else outdir,             prefix=prefix,             hmmsearch_args=hmmsearch_args,             gene_ids=gene_ids,             logfile=Path(logfile) if logfile is not None else logfile,             processes=processes,             unordered=unordered,             reuse=reuse,         )      def parse_genes(self, synteny_struc: str) -> str:         """Parse gene IDs in synteny structure and find corresponding HMM names         in provided HMM database.          Args:             synteny_struc (str): a str describing the desired synteny structure,                 structured as follows:                  '>hmm_a N_ab hmm_b bc <hmm_c'                  where N_ab corresponds to the maximum number of genes separating                 gene found by hmm_a and gene found by hmm_b, and hmm_ corresponds                 to the name of the hmm as provided in the keys of hmm_hits.                 More than two hmms can be concatenated. Strand location may be                 specificed by using '>' for sense and '<' for antisense.          Returns:             str: parsed synteny structure in which gene symbols are replaced by                  corresponding HMM names.         """         args = CommandArgs(             synteny_struc=synteny_struc,             hmm_meta=self._args.hmm_meta,             logfile=self._args.logfile,         )         return parse_gene_ids(args)    