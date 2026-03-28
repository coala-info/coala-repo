[Skip to main content](#main-content)

Back to top
[ ]

[ ]

`Ctrl`+`K`

[![Kaptive 3.1.0 documentation - Home](https://github.com/klebgenomics/Kaptive/blob/master/extras/kaptive_logo.png?raw=true)](index.html)

* [Introducing Kaptive 3](index.html)

* [Installation](Installation.html)
* Usage
* [Method](Method.html)
* [Outputs](Outputs.html)
* [Interpreting the results](Interpreting-the-results.html)
* [Databases](Databases.html)
* [Legacy Database Information](Legacy.html)
* [FAQs](FAQs.html)

* [.rst](_sources/Usage.rst "Download source file")
* .pdf

# Usage

## Contents

* [Quickstart (for the impatient)](#quickstart-for-the-impatient)
* [Detailed usage](#detailed-usage)
  + [kaptive assembly](#kaptive-assembly)
    - [Advanced options](#advanced-options)
  + [kaptive convert](#kaptive-convert)
    - [Usage](#id3)
  + [API](#api)

# Usage[#](#usage "Link to this heading")

## Quickstart (for the impatient)[#](#quickstart-for-the-impatient "Link to this heading")

To type polysaccharide loci from genome assemblies:

```
kaptive assembly <database> <path_to_assemblies> -o kaptive_results.tsv
```

This will run `kaptive assembly` with the default parameters, and produce a table detailing the best match locus,
predicted phenotype, confidence score and detailed typing information for each input genome assembly in the file
called `kaptive_results.tsv`.

## Detailed usage[#](#detailed-usage "Link to this heading")

We designed Kaptive 3 to be easier to use on the command-line than previous versions by structuring the program as a
series of sub-commands that follow the general pattern of `kaptive <mode> <database> <input>`.
There are three modes:

* **assembly**: [type assemblies](#kaptive-assembly)
* **extract**: [extract](Databases.html#kaptive-extract) features from Kaptive databases in different formats
* **convert**: [convert](#kaptive-convert) Kaptive results to different formats

Note

To see the full list of commands and options, run `kaptive -h/--help`.

### kaptive assembly[#](#kaptive-assembly "Link to this heading")

Given a Kaptive database and a bacterial genome assembly, `kaptive assembly` will perform 3 main tasks:

* Determines the most likely locus type of the genome assembly.
* Reconstructs the biosynthetic gene cluster from the assembly contig sequences.
* Predicts the corresponding serotype/phenotype of the genome assembly.

Note

As of version 3, Kaptive no longer supports allelic (*wzi*, *wzc*) typing.

To perform K locus typing on a directory of *Klebsiella pneumoniae* assemblies, you would run:

```
kaptive assembly kpsc_k assemblies/*.fasta -o kaptive_results.tsv
```

Here we have told Kaptive to perform typing of assemblies with `assembly` and used the database keyword
`kpsc_k` to specify the *Klebsiella pneumoniae* K locus database. All other parameters are set to the default.

[Database keywords](Databases.html#database-keywords) are a handy short-cut for using the databases distributed with Kaptive and
located in the `reference_databases` directory. Alternatively, you can specify the full path to your own database.

You may also want to specify the locations and/or filenames of the output files using the following options:

```
Note, text outputs accept '-' for stdout

-o , --out           Output file to write/append tabular results to (default: stdout)
-f [], --fasta []    Turn on fasta output
                     Accepts a single file or a directory (default: cwd)
-j [], --json []     Turn on JSON lines output
                     Optionally choose file (can be existing) (default: kaptive_results.json)
-s [], --scores []   Dump locus score matrix to tsv (typing will not be performed!)
                     Optionally choose file (can be existing) (default: stdout)
-p [], --plot []     Plot results to "./{assembly}_kaptive_results.{fmt}"
                     Optionally choose a directory (default: cwd)
--plot-fmt png/svg   Format for locus plots (default: png)
--no-header          Suppress header line
```

Example:

```
kaptive assembly kpsc_k assemblies/*.fasta -o kaptive_results.tsv -f -j -p
```

This will output a tabular file called `kaptive_results.tsv`, a fasta file for each assembly called
`{assembly}_kaptive_results.fna`, a JSON lines file called `kaptive_results.json` and a plot for each assembly
called `{assembly}_kaptive_results.{png,svg}`.

Warning

It is possible to write **all** text formats (TSV, JSON and FASTA) to the same file (including stdout), however
this is not recommended for downstream analysis.

#### Advanced options[#](#advanced-options "Link to this heading")

Advanced users may wish to customise Kaptive’s scoring options (for picking the best match locus), confidence options
(for marking matches as ‘Typeable’ or ‘Untypeable’) or database parsing options. We recommend keeping the default
options for standard typing using the *Klebsiella* and/or *A. baumanii* databases distributed with Kaptive.

[Scoring options](Method.html#scoring-algorithm):

```
--min-cov            Minimum gene %coverage (blen/q_len*100) to be used for scoring (default: 50.0)
--score-metric       Metric for scoring each locus (default: 0)
                       0: AS (alignment score of genes found)
                       1: mlen (matching bases of genes found)
                       2: blen (aligned bases of genes found)
                       3: q_len (query length of genes found)
--weight-metric      Weighting for the 1st stage of the scoring algorithm (default: 3)
                       0: No weighting
                       1: Number of genes found
                       2: Number of genes expected
                       3: Proportion of genes found
                       4: blen (aligned bases of genes found)
                       5: q_len (query length of genes found)
--n-best             Number of best loci from the 1st round of scoring to be
                     fully aligned to the assembly (default: 2)
```

[Confidence options](Interpreting-the-results.html#confidence-score):

```
--gene-threshold     Species-level locus gene identity threshold (default: database specific)
--max-other-genes    Typeable if <= other genes (default: 1)
--percent-expected   Typeable if >= % expected genes (default: 50)
--below-threshold    Typeable if any genes are below threshold (default: False)
```

See database options [here](Databases.html#database-options) and other options:

```
-V, --verbose         Print debug messages to stderr
-v , --version        Show version number and exit
-h , --help           Show this help message and exit
-t , --threads        Number of threads for alignment (default: maximum available CPUs / 32)
```

### kaptive convert[#](#kaptive-convert "Link to this heading")

The `convert` command allows you to convert the Kaptive results JSON file into a range of useful formats, including:

* **tsv**: [Tabular](Outputs.html#tabular) output (tsv)
* **json**: JSON lines format (same as input but optionally filtered)
* **fna**: Locus nucleotide sequences in fasta format.
* **ffn**: Gene nucleotide sequences in fasta format.
* **faa**: Protein sequences in fasta format.
* **plot**: Locus [plots](Outputs.html#plot) as PNG or SVG

Warning

The `convert` command is only compatible with JSON files from Kaptive v3.0.0 onwards.

#### Usage[#](#id3 "Link to this heading")

General usage is as follows:

```
kaptive convert <db> <json> [formats] [options]
```

Inputs:

```
db path/keyword       Kaptive database path or keyword
json                  Kaptive JSON lines file or - for stdin
```

Formats:

```
Note, text outputs accept '-' for stdout

-t [], --tsv []       Convert to tabular format in file (default: stdout)
-j [], --json []      Convert to JSON lines format in file (default: stdout)
--fna []              Convert to locus nucleotide sequences in fasta format
                      Accepts a single file or a directory (default: cwd)
--ffn []              Convert to locus gene nucleotide sequences in fasta format
                      Accepts a single file or a directory (default: cwd)
--faa []              Convert to locus gene protein sequences in fasta format
                      Accepts a single file or a directory (default: cwd)
-p [], --plot []      Plot results to "./{assembly}_kaptive_results.{fmt}"
                      Optionally choose a directory (default: cwd)
--plot-fmt png/svg    Format for locus plots (default: png)
--no-header           Suppress header line
```

Filter options:

```
-r , --regex          Python regular-expression to select JSON lines (default: All)
-l  [ ...], --loci  [ ...]
                    Space-separated list to filter locus names (default: All)
-s  [ ...], --samples  [ ...]
                    Space-separated list to filter sample names (default: All)
```

Note

Filters take precedence in descending order

For example, to convert the JSON file to a tabular format, run either of the following commands:

```
kaptive convert kpsc_k kaptive_results.json --tsv kaptive_results.tsv

cat *.json | kaptive convert kpsc_k - --tsv - > kaptive_results.tsv
```

To output multiple formats, you can run:

```
kaptive convert kpsc_k kaptive_results.json --tsv kaptive_results.tsv --fna - --faa proteins/
```

Where the tabular results will be written to `kaptive_results.tsv`, the locus nucleotide sequences will be written to
stdout, and the protein sequences will be written to the directory `proteins/` with the filenames
`{assembly}_kaptive_results.faa`.

Warning

It is possible to write **all** text formats (TSV, JSON, FNA, FAA and FFN) to the same file (including stdout), however
this is not recommended for downstream analysis.

### API[#](#api "Link to this heading")

Whilst Kaptive isn’t designed to be a fully-fledged API, it is possible to use it as a module in your own Python scripts.
For typing assemblies, you can use the `kaptive.assembly.typing_pipeline` function, which takes an assembly and a
`kaptive.database.Database` object as input and returns a `kaptive.typing.TypingResult` object.

```
from kaptive.assembly import typing_pipeline
from kaptive.database import load_database
from pathlib import Path

db = load_database('kpsc_k')  # Load the Klebsiella K locus database once and pass it to the typing pipeline
for result in map(lambda a: typing_pipeline(a, db), Path('assemblies').glob('*.fna.gz')):
    if result:  # If the assembly was successfully typed
        print(result.format('tsv'), end='')  # TSV format will end in a newline, so we set end to ''
```

For example, if you wanted to perform K and O locus typing on a single assembly, you could do the following:

```
# Here, we pass the keyword arguments for the database, they will be loaded inside the typing pipeline
for result in map(lambda d: typing_pipeline('test/kpsc/2018-01-389.fasta', d), ['kpsc_k', 'kpsc_o']):
    if result:  # If the assembly was successfully typed
        print(result.format('tsv'), end='')  # TSV format will end in a newline, so we set end to ''
```

Note

By default the `typing_pipeline` runs `minimap2` on a all available CPUs, however this can be controlled
with the `threads` parameter.

[previous

Installation](Installation.html "previous page")
[next

Method](Method.html "next page")

Contents

* [Quickstart (for the impatient)](#quickstart-for-the-impatient)
* [Detailed usage](#detailed-usage)
  + [kaptive assembly](#kaptive-assembly)
    - [Advanced options](#advanced-options)
  + [kaptive convert](#kaptive-convert)
    - [Usage](#id3)
  + [API](#api)

By Tom Stanton

© Copyright 2025, Tom Stanton, Ryan Wick, Kathryn Holt, Kelly Wyres.