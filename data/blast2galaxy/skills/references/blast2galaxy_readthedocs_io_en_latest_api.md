[ ]
[ ]

[Skip to content](#api-reference)

blast2galaxy Documentation

API Reference

[blast2galaxy](https://github.com/IPK-BIT/blast2galaxy "Go to repository")

blast2galaxy Documentation

[blast2galaxy](https://github.com/IPK-BIT/blast2galaxy "Go to repository")

* [Introduction](..)
* [Installation](../installation/)
* [Configuration](../configuration/)
* [ ]

  Usage

  Usage
  + [CLI Usage](../usage_cli/)
  + [API Usage](../usage_api/)
* [Tutorial](../tutorial/)
* [CLI Reference](../cli/)
* [ ]

  API Reference

  [API Reference](./)

  Table of contents
  + [Main methods of the Python API](#main-methods-of-the-python-api)

    - [blastn](#blast2galaxy.blastn)
    - [blastp](#blast2galaxy.blastp)
    - [blastx](#blast2galaxy.blastx)
    - [diamond\_blastp](#blast2galaxy.diamond_blastp)
    - [diamond\_blastx](#blast2galaxy.diamond_blastx)
    - [list\_dbs](#blast2galaxy.list_dbs)
    - [list\_tools](#blast2galaxy.list_tools)
    - [tblastn](#blast2galaxy.tblastn)
  + [Configuration via API during runtime](#configuration-via-api-during-runtime)

    - [add\_default\_profile](#blast2galaxy.config.add_default_profile)
    - [add\_default\_server](#blast2galaxy.config.add_default_server)
    - [add\_profile](#blast2galaxy.config.add_profile)
    - [add\_server](#blast2galaxy.config.add_server)

Table of contents

* [Main methods of the Python API](#main-methods-of-the-python-api)

  + [blastn](#blast2galaxy.blastn)
  + [blastp](#blast2galaxy.blastp)
  + [blastx](#blast2galaxy.blastx)
  + [diamond\_blastp](#blast2galaxy.diamond_blastp)
  + [diamond\_blastx](#blast2galaxy.diamond_blastx)
  + [list\_dbs](#blast2galaxy.list_dbs)
  + [list\_tools](#blast2galaxy.list_tools)
  + [tblastn](#blast2galaxy.tblastn)
* [Configuration via API during runtime](#configuration-via-api-during-runtime)

  + [add\_default\_profile](#blast2galaxy.config.add_default_profile)
  + [add\_default\_server](#blast2galaxy.config.add_default_server)
  + [add\_profile](#blast2galaxy.config.add_profile)
  + [add\_server](#blast2galaxy.config.add_server)

# API Reference

This page provides API docs for the Python API of blast2galaxy.

## Main methods of the Python API

### blast2galaxy.blastn

```
blastn(profile='default', query='', query_str=None, task=ChoicesTaskBlastn.megablast, db=None, evalue='0.001', out='', outfmt='6', html=False, dust=ChoicesYesNo.yes.value, strand=ChoicesStrand.both.value, max_hsps=None, perc_identity=0.0, word_size=None, ungapped=False, parse_deflines=False, qcov_hsp_perc=0.0, window_size=None, gapopen=None, gapextend=None)
```

blastn

search nucleotide databases using a nucleotide query

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `profile` | `Optional[str]` | the profile ID from .blast2galaxy.toml or runtime configuration | `'default'` |
| `query` | `str` | file path with your query sequence | `''` |
| `query_str` | `str` | Python string containing the query sequence, can be used instead of `query` param | `None` |
| `task` | `Optional[ChoicesTaskBlastn]` | the blastn task: megablast or something | `megablast` |
| `db` | `Optional[str | None]` | the BLAST database to search in | `None` |
| `evalue` | `Optional[str]` | Expectation value cutoff | `'0.001'` |
| `out` | `str` | Path / filename of file to store the BLAST result | `''` |
| `outfmt` | `Optional[str]` | Output format | `'6'` |
| `html` | `Optional[bool]` | Format output as HTML document | `False` |
| `dust` | `Optional[ChoicesYesNo]` | Filter out low complexity regions (with DUST) | `yes.value` |
| `strand` | `Optional[ChoicesStrand]` | Query strand(s) to search against database/subject | `value` |
| `max_hsps` | `Optional[int | None]` | Maximum number of HSPs (alignments) to keep for any single query-subject pair | `None` |
| `perc_identity` | `Optional[float]` | Percent identity cutoff | `0.0` |
| `word_size` | `Optional[int | None]` | Word size for wordfinder algorithm | `None` |
| `ungapped` | `Optional[bool]` | Perform ungapped alignment only? | `False` |
| `parse_deflines` | `Optional[bool]` | Should the query and subject defline(s) be parsed? | `False` |
| `qcov_hsp_perc` | `Optional[float]` | Minimum query coverage per hsp (percentage, 0 to 100) | `0.0` |
| `window_size` | `Optional[int | None]` | Multiple hits window size: use 0 to specify 1-hit algorithm, leave blank for default | `None` |
| `gapopen` | `Optional[int | None]` | Cost to open a gap | `None` |
| `gapextend` | `Optional[int | None]` | Cost to extend a gap | `None` |

### blast2galaxy.blastp

```
blastp(profile='default', query='', query_str=None, task=ChoicesTaskBlastp.blastp, db=None, evalue='0.001', out='', outfmt='6', html=False, seg=ChoicesYesNo.yes.value, matrix=None, max_target_seqs=500, num_descriptions=500, num_alignments=250, threshold=None, max_hsps=None, word_size=None, ungapped=False, parse_deflines=False, qcov_hsp_perc=0.0, window_size=None, gapopen=None, gapextend=None, comp_based_stats='2', use_sw_tback=False)
```

blastp

search protein databases using a protein query

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `profile` | `str` | the profile ID from .blast2galaxy.toml or runtime configuration | `'default'` |
| `query` | `str` | file path with your query sequence | `''` |
| `query_str` | `str` | Python string containing the query sequence, can be used instead of `query` param | `None` |
| `task` | `Optional[ChoicesTaskBlastp]` | the blastn task: megablast or something | `blastp` |
| `db` | `Optional[str]` | the BLAST database to search in | `None` |
| `evalue` | `Optional[str]` | Expectation value cutoff | `'0.001'` |
| `out` | `str` | Path / filename of file to store the BLAST result | `''` |
| `outfmt` | `Optional[str]` | Output format | `'6'` |
| `html` | `Optional[bool]` | Format output as HTML document | `False` |
| `seg` | `Optional[ChoicesYesNo]` | Filter out low complexity regions (with SEG) | `yes.value` |
| `matrix` | `Optional[str]` | Scoring matrix name (normally BLOSUM62) | `None` |
| `max_target_seqs` | `Optional[int]` | Maximum number of aligned sequences to keep (value of 5 or more is recommended) Default = 500 | `500` |
| `num_descriptions` | `Optional[int]` | Number of database sequences to show one-line descriptions for. Not applicable for outfmt > 4. Default = 500 \* Incompatible with: max\_target\_seqs | `500` |
| `num_alignments` | `Optional[int]` | Number of database sequences to show alignments for. Default = 250 \* Incompatible with: max\_target\_seqs | `250` |
| `threshold` | `Optional[float]` | Minimum word score such that the word is added to the BLAST lookup table | `None` |
| `max_hsps` | `Optional[int]` | Maximum number of HSPs (alignments) to keep for any single query-subject pair | `None` |
| `word_size` | `Optional[int]` | Word size for wordfinder algorithm | `None` |
| `ungapped` | `Optional[bool]` | Perform ungapped alignment only? | `False` |
| `parse_deflines` | `Optional[bool]` | Should the query and subject defline(s) be parsed? | `False` |
| `qcov_hsp_perc` | `Optional[float]` | Minimum query coverage per hsp (percentage, 0 to 100) | `0.0` |
| `window_size` | `Optional[int]` | Multiple hits window size: use 0 to specify 1-hit algorithm, leave blank for default | `None` |
| `gapopen` | `Optional[int]` | Cost to open a gap | `None` |
| `gapextend` | `Optional[int]` | Cost to extend a gap | `None` |
| `comp_based_stats` | `Optional[str]` | Use composition-based statistics: D or d: default (equivalent to 2 ); 0 or F or f: No composition-based statistics; 1: Composition-based statistics as in NAR 29:2994-3005, 2001; 2 or T or t : Composition-based score adjustment as in Bioinformatics 21:902-911, 2005, conditioned on sequence properties; 3: Composition-based score adjustment as in Bioinformatics 21:902-911, 2005, unconditionally | `'2'` |
| `use_sw_tback` | `Optional[bool]` | Compute locally optimal Smith-Waterman alignments? | `False` |

### blast2galaxy.blastx

```
blastx(profile='default', query='', query_str=None, task=ChoicesTaskBlastx.blastx, db=None, evalue='0.001', out='', outfmt='6', html=False, seg=ChoicesYesNo.yes.value, matrix=None, max_target_seqs=500, num_descriptions=None, num_alignments=None, threshold=None, max_hsps=None, word_size=None, ungapped=False, parse_deflines=False, qcov_hsp_perc=0.0, window_size=None, gapopen=None, gapextend=None, comp_based_stats='2')
```

blastx

search protein databases using a translated nucleotide query

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `profile` | `str` | the profile ID from .blast2galaxy.toml or runtime configuration | `'default'` |
| `query` | `str` | file path with your query sequence | `''` |
| `query_str` | `str` | Python string containing the query sequence, can be used instead of `query` param | `None` |
| `task` | `Optional[ChoicesTaskBlastx]` | the blastn task: megablast or something | `blastx` |
| `db` | `Optional[str]` | the BLAST database to search in | `None` |
| `evalue` | `Optional[str]` | Expectation value cutoff | `'0.001'` |
| `out` | `str` | Path / filename of file to store the BLAST result | `''` |
| `outfmt` | `Optional[str]` | Output format | `'6'` |
| `html` | `Optional[bool]` | Format output as HTML document | `False` |
| `seg` | `Optional[ChoicesYesNo]` | Filter out low complexity regions (with SEG) | `yes.value` |
| `matrix` | `Optional[str]` | Scoring matrix name (normally BLOSUM62) | `None` |
| `max_target_seqs` | `Optional[int]` | Maximum number of aligned sequences to keep (value of 5 or more is recommended) Default = 500 | `500` |
| `num_descriptions` | `Optional[int]` | Number of database sequences to show one-line descriptions for. Not applicable for outfmt > 4. Default = 500 \* Incompatible with: max\_target\_seqs | `None` |
| `num_alignments` | `Optional[int]` | Number of database sequences to show alignments for. Default = 250 \* Incompatible with: max\_target\_seqs | `None` |
| `threshold` | `Optional[float]` | Minimum word score such that the word is added to the BLAST lookup table | `None` |
| `max_hsps` | `Optional[int]` | Maximum number of HSPs (alignments) to keep for any single query-subject pair | `None` |
| `word_size` | `Optional[int]` | Word size for wordfinder algorithm | `None` |
| `ungapped` | `Optional[bool]` | Perform ungapped alignment only? | `False` |
| `parse_deflines` | `Optional[bool]` | Should the query and subject defline(s) be parsed? | `False` |
| `qcov_hsp_perc` | `Optional[float]` | Minimum query coverage per hsp (percentage, 0 to 100) | `0.0` |
| `window_size` | `Optional[int]` | Multiple hits window size: use 0 to specify 1-hit algorithm, leave blank for default | `None` |
| `gapopen` | `Optional[int]` | Cost to open a gap | `None` |
| `gapextend` | `Optional[int]` | Cost to extend a gap | `None` |
| `comp_based_stats` | `Optional[str]` | Use composition-based statistics: D or d: default (equivalent to 2 ); 0 or F or f: No composition-based statistics; 1: Composition-based statistics as in NAR 29:2994-3005, 2001; 2 or T or t : Composition-based score adjustment as in Bioinformatics 21:902-911, 2005, conditioned on sequence properties; 3: Composition-based score adjustment as in Bioinformatics 21:902-911, 2005, unconditionally | `'2'` |

### blast2galaxy.diamond\_blastp

```
diamond_blastp(profile='default', query='', query_str=None, task=ChoicesTaskBlastp.blastp, db=None, evalue='0.001', outfmt=ChoicesOutfmtDiamond.blast_pairwise.value, faster=False, fast=False, mid_sensitive=False, sensitive=False, more_sensitive=False, very_sensitive=False, ultra_sensitive=False, strand=ChoicesStrand.both.value, matrix='BLOSUM62', max_target_seqs=500, max_hsps=None, window=None, gapopen=None, gapextend=None, comp_based_stats='1')
```

diamond\_blastp

search protein databases using a protein query with DIAMOND

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `profile` | `str` | the profile ID from .blast2galaxy.toml or runtime configuration | `'default'` |
| `query` | `str` | file path with your query sequence | `''` |
| `query_str` | `str` | Python string containing the query sequence, can be used instead of `query` param | `None` |
| `task` | `Optional[ChoicesTaskBlastp]` | the blastn task: megablast or something | `blastp` |
| `db` | `Optional[str]` | the BLAST database to search in | `None` |
| `evalue` | `Optional[str]` | Expectation value cutoff | `'0.001'` |
| `outfmt` | `Optional[ChoicesOutfmtDiamond]` | Output format | `value` |
| `faster` | `Optional[bool]` | faster mode | `False` |
| `fast` | `Optional[bool]` | fast mode | `False` |
| `mid_sensitive` | `Optional[bool]` | mid\_sensitive mode | `False` |
| `sensitive` | `Optional[bool]` | sensitive mode | `False` |
| `more_sensitive` | `Optional[bool]` | more\_sensitive mode | `False` |
| `very_sensitive` | `Optional[bool]` | very\_sensitive mode | `False` |
| `ultra_sensitive` | `Optional[bool]` | ultra\_sensitive mode | `False` |
| `strand` | `Optional[ChoicesStrand]` | Query strand(s) to search against database/subject | `value` |
| `matrix` | `Optional[str]` | Scoring matrix name (normally BLOSUM62) | `'BLOSUM62'` |
| `max_target_seqs` | `Optional[int]` | Maximum number of aligned sequences to keep (value of 5 or more is recommended) Default = 500 | `500` |
| `max_hsps` | `Optional[int]` | Maximum number of HSPs (alignments) to keep for any single query-subject pair | `None` |
| `window` | `Optional[int]` | Multiple hits window size: use 0 to specify 1-hit algorithm, leave blank for default | `None` |
| `gapopen` | `Optional[int]` | Cost to open a gap | `None` |
| `gapextend` | `Optional[int]` | Cost to extend a gap | `None` |
| `comp_based_stats` | `Optional[str]` | Use composition-based statistics: D or d: default (equivalent to 2 ); 0 or F or f: No composition-based statistics; 1: Composition-based statistics as in NAR 29:2994-3005, 2001; 2 or T or t : Composition-based score adjustment as in Bioinformatics 21:902-911, 2005, conditioned on sequence properties; 3: Composition-based score adjustment as in Bioinformatics 21:902-911, 2005, unconditionally | `'1'` |

### blast2galaxy.diamond\_blastx

```
diamond_blastx(profile='default', query='', query_str=None, task=ChoicesTaskBlastp.blastp, db=None, evalue='0.001', out='', outfmt=ChoicesOutfmtDiamond.blast_pairwise.value, faster=False, fast=False, mid_sensitive=False, sensitive=False, more_sensitive=False, very_sensitive=False, ultra_sensitive=False, strand=ChoicesStrand.both.value, matrix='BLOSUM62', max_target_seqs=500, max_hsps=None, window=None, gapopen=None, gapextend=None, comp_based_stats='1')
```

diamond\_blastx

search protein databases using a translated nucleotide query with DIAMOND

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `profile` | `str` | the profile ID from .blast2galaxy.toml or runtime configuration | `'default'` |
| `query` | `str` | file path with your query sequence | `''` |
| `query_str` | `str` | Pyth