[phyluce](../index.html)

Contents:

* [Purpose](../purpose.html)
* [Installation](../installation.html)
* [Phyluce Tutorials](../tutorials/index.html)
* [Phyluce in Daily Use](index.html)
  + [Quality Control](daily-use-1-quality-control.html)
  + [Assembly](daily-use-2-assembly.html)
  + UCE Processing for Phylogenomics
    - [Identifying UCE loci](#identifying-uce-loci)
      * [Get the probe set FASTA](#get-the-probe-set-fasta)
      * [Match contigs to probes](#match-contigs-to-probes)
    - [Creating a data matrix configuration file](#creating-a-data-matrix-configuration-file)
      * [Complete taxon set](#complete-taxon-set)
      * [Incomplete data matrix](#incomplete-data-matrix)
      * [Creating additional data matrix configuration files for other analyses](#creating-additional-data-matrix-configuration-files-for-other-analyses)
      * [Incorporating outgroup/other data](#incorporating-outgroup-other-data)
    - [Extracting FASTA data using the data matrix configuration file](#extracting-fasta-data-using-the-data-matrix-configuration-file)
      * [Complete data matrix](#complete-data-matrix)
      * [Incomplete data matrix](#id2)
      * [Incorporating outgroup/other data](#id3)
    - [Aligning and trimming FASTA data](#aligning-and-trimming-fasta-data)
      * [Complete data matrix](#id4)
      * [Incomplete data matrix](#id5)
    - [Operations on alignments](#operations-on-alignments)
      * [Converting one alignment format to another](#converting-one-alignment-format-to-another)
      * [Shortening taxon names](#shortening-taxon-names)
      * [Excluding loci or taxa](#excluding-loci-or-taxa)
      * [Extracting taxon data from alignments](#extracting-taxon-data-from-alignments)
    - [Preparing concatenated alignment data for analysis](#preparing-concatenated-alignment-data-for-analysis)
      * [RAxML](#raxml-concat)
      * [MrBayes (Nexus format)](#mrbayes-nexus-format)
  + [Workflows](daily-use-4-workflows.html)
  + [List of Phyluce Programs](list-of-programs.html)

* [Citing](../citing.html)
* [License](../license.html)
* [Attributions](../attributions.html)
* [Funding](../funding.html)
* [Acknowledgements](../ack.html)

[phyluce](../index.html)

* [Phyluce in Daily Use](index.html)
* UCE Processing for Phylogenomics
* [View page source](../_sources/daily-use/daily-use-3-uce-processing.rst.txt)

---

# UCE Processing for Phylogenomics[](#uce-processing-for-phylogenomics "Link to this heading")

The process described below is meant for users who are analyzing UCE data in
phylogenetic contexts - meaning that you are interested in addressing questions
at or deeper than the species-level.

## Identifying UCE loci[](#identifying-uce-loci "Link to this heading")

Once we have assembled our fastq data (see [Assembly](daily-use-2-assembly.html#assembly)), we need to process
those contigs to (a) determine which represent enrichend UCE loci and (b)
remove any potential paralogs from the data set. Before we can do that, we
need to to a little preparatory work by downloading a FASTA file representing
the bait/probe set that we used.

### Get the probe set FASTA[](#get-the-probe-set-fasta "Link to this heading")

To identify which of the contigs we’ve assembled are UCE loci (and which UCE
loci they might be), we are going to match our assembled contigs to the probes
we used to enrich UCE loci. Before we do that, however, we need to download
a copy of probe set we used for matching purposes.

Attention

We archive official probe sets at
<https://github.com/faircloth-lab/uce-probe-sets/>, but you need to be
careful about which one you grab - probe sets can be of different sizes
(e.g. 2,500 or 5,500 loci) and for different groups of taxa (e.g., amniotes,
fish)

#### Download the probe set[](#download-the-probe-set "Link to this heading")

To download a given probe set for [phyluce](https://github.com/faircloth-lab/phyluce), you need to figure out which probe
set you need. Then, you can use a command like `wget` on the command-line (or
navigate with your browser to the URL and save the file):

```
# to get the 2.5k, amniote probe set
wget https://raw.githubusercontent.com/faircloth-lab/uce-probe-sets/refs/heads/master/V1/uce-2.5k-probe-set/uce-2.5k-probes.fasta

# to get the 5k, amniote probe set
wget https://raw.githubusercontent.com/faircloth-lab/uce-probe-sets/refs/heads/master/V1/uce-5k-probe-set/uce-5k-probes.fasta
```

### Match contigs to probes[](#match-contigs-to-probes "Link to this heading")

Once we’ve downloaded the probe set we used to enrich UCE loci, we need to find
which of our assembled contigs are the UCE loci that we enriched. During this
process, the code will also remove any contigs that appear to be duplicates as a
result of assembly/other problems **or** a biological event(s).

The way that this process works is that [phyluce](https://github.com/faircloth-lab/phyluce) aligns (using [lastz](http://www.bx.psu.edu/~rsharris/lastz/)) the
contigs you assembled to the probes you input on a taxon-by-taxon (or otu-by-otu)

> basis. Then, the code parses the alignment file to determine which contigs

matched which probes, whether any probes from a single locus matched multiple
contigs or whether a single contig matched probes designed from muliple UCE
loci. Either of these latter two events suggests that the locus in question is
problematic.

Hint

**ADVANCED**: The default regular expression assumes probes in your
file are named according to `uce-NNN_pN`, where `uce-` is just a text
string, `NNN` is an integer value denoting each unique locus, `_p` is a
text string denoting a “probe” targeting locus `NNN`, and the trailing
`N` is an integer value denoting each unique probe targeting the same
locus.

If you are using a custom probe file, then you will either need to ensure
that your naming scheme conforms to this approach **OR** you will need to
input a different regular expression to convert the probe names to locus
names using the `--regex` flag. **It is up to you to determine what
is the appropriate regular expression**.

To identify which of your assembled contigs are UCE contigs, run:

```
# make a directory for log files
mkdir log
# match contigs to probes
phyluce_assembly_match_contigs_to_probes \
    --contigs /path/to/assembly/contigs/ \
    --probes uce-5k-probes.fasta \
    --output /path/to/uce/output \
    --log-path log
```

When you run this code, you should see output similar to:

```
2014-04-24 14:38:15,979 - match_contigs_to_probes - INFO - ================ Starting match_contigs_to_probes ===============
2014-04-24 14:38:15,979 - match_contigs_to_probes - INFO - Version: git 7aec8f1
2014-04-24 14:38:15,979 - match_contigs_to_probes - INFO - Argument --contigs: /path/to/assembly/contigs/
2014-04-24 14:38:15,980 - match_contigs_to_probes - INFO - Argument --keep_duplicates: None
2014-04-24 14:38:15,980 - match_contigs_to_probes - INFO - Argument --log_path: None
2014-04-24 14:38:15,980 - match_contigs_to_probes - INFO - Argument --min_coverage: 80
2014-04-24 14:38:15,980 - match_contigs_to_probes - INFO - Argument --min_identity: 80
2014-04-24 14:38:15,980 - match_contigs_to_probes - INFO - Argument --output: /path/to/uce/output
2014-04-24 14:38:15,980 - match_contigs_to_probes - INFO - Argument --probes: uce-5k-probes.fasta
2014-04-24 14:38:15,981 - match_contigs_to_probes - INFO - Argument --regex: ^(uce-\d+)(?:_p\d+.*)
2014-04-24 14:38:15,981 - match_contigs_to_probes - INFO - Argument --verbosity: INFO
2014-04-24 14:38:16,138 - match_contigs_to_probes - INFO - Checking probe/bait sequences for duplicates
2014-04-24 14:38:19,022 - match_contigs_to_probes - INFO - Creating the UCE-match database
2014-04-24 14:38:19,134 - match_contigs_to_probes - INFO - Processing contig data
2014-04-24 14:38:19,134 - match_contigs_to_probes - INFO - -----------------------------------------------------------------
2014-04-24 14:38:25,713 - match_contigs_to_probes - INFO - genus_species1: 1031 (70.14%) uniques of 1470 contigs, 0 dupe probe matches, 48 UCE probes matching multiple contigs, 117 contigs matching multiple UCE probes
2014-04-24 14:38:32,846 - match_contigs_to_probes - INFO - genus_species2: 420 (68.52%) uniques of 613 contigs, 0 dupe probe matches, 30 UCE probes matching multiple contigs, 19 contigs matching multiple UCE probes
2014-04-24 14:38:39,184 - match_contigs_to_probes - INFO - genus_species3: 1071 (63.15%) uniques of 1696 contigs, 0 dupe probe matches, 69 UCE probes matching multiple contigs, 101 contigs matching multiple UCE probes
2014-04-24 14:49:59,654 - match_contigs_to_probes - INFO - -----------------------------------------------------------------
2014-04-24 14:49:59,654 - match_contigs_to_probes - INFO - The LASTZ alignments are in /path/to/uce/output/
2014-04-24 14:49:59,654 - match_contigs_to_probes - INFO - The UCE match database is in /path/to/uce/output/probe.matches.sqlite
2014-04-24 14:49:59,655 - match_contigs_to_probes - INFO - =============== Completed match_contigs_to_probes ===============
```

Note

The `*.log` files for each operation are always printed to the
screen AND also written out to the `$CWD` (current working directory).
You can keep these files more orderly by specifying a `$LOG` on the
command line using the `--log-path` option.

#### Results[](#results "Link to this heading")

The resulting files will be in the:

```
/path/to/output
```

directory. If you look in this directory, you’ll see that it contains species-
specific lastz\_ files as well as an [sqlite](http://www.sqlite.org) database:

```
$ ls /path/to/output

genus_species1.contigs.lastz
genus_species2.contigs.lastz
genus_species3.contigs.lastz
probe.matches.sqlite
```

The `*.lastz` files within the `/path/to/output` directory are basically for
reference and individual review (they are text files that you can open using a
text editor to view). The really important data from the [lastz](http://www.bx.psu.edu/~rsharris/lastz/) files are
summarized in the:

```
probe.matches.sqlite
```

database file. It’s probably a good idea to have some knowledge of how this
database is structured, since it’s basically what makes the next few steps work.
So, let’s go over the structure and contents of this database.

##### The probe.matches.sqlite database[](#the-probe-matches-sqlite-database "Link to this heading")

`probe.matches.sqlite` is a [relational database](http://en.wikipedia.org/wiki/Relational_database) that summarizes all
**valid** matches of contigs to UCE loci across the set of taxa that you fed it.
The database is created by and for a program named [sqlite](http://www.sqlite.org), which is a very
handy, portable SQL database. For more info on SQL and SQLITE, see this
[sqlite-tutorial](http://www.sqlite.org/sqlite.html). I’ll briefly cover the database contents and use below.

First, take a look at the contents of the database by running:

```
sqlite3 probe.matches.sqlite
```

You’ll now see something like:

```
SQLite version 3.7.3
Enter ".help" for instructions
Enter SQL statements terminated with a ";"
sqlite>
```

It’s often easier to change some defaults for better viewing, so at the prompt,
paste in the following:

```
sqlite> .mode columns
sqlite> .headers on
sqlite> .nullvalue .
```

Tip

For more info on [sqlite](http://www.sqlite.org) “dot” commands, you can type
`.help`.

Now that that’s done, let’s see which tables the database contains by running
the `.tables` command:

```
sqlite> .tables
match_map  matches
```

This tells us there’s two tables in the database, named `match_map` and
`matches`.

##### The `matches` table[](#the-matches-table "Link to this heading")

Let’s take a look at the contents of the `matches` table. Once you’ve started
the sqlite interface, run:

```
sqlite> SELECT * FROM matches LIMIT 10;
```

This query select all rows (`SELECT *`) from the `matches` table (`FROM
matches`) and limits the number of returned rows to 10 (`LIMIT 10`). This
will output data that look something like:

```
uce         genus_species1  genus_species2  genus_species3
----------  --------------  --------------  --------------
uce-500     1               .               .
uce-501     1               .               .
uce-502     1               .               .
uce-503     1               1               1
uce-504     1               .               .
uce-505     1               .               .
uce-506     .               .               .
uce-507     1               .               .
uce-508     1               1               .
uce-509     1               1               1
```

Basically, what this indicates is that you enriched 9 of 10 targeted UCE loci
from `genus_species1`, 3 of 10 UCE loci in the list from `genus_species2`,
and 2 of 10 UCE loci from `genus_species3`. The locus name is given in the
`uce column`. Remember that we’ve limited the results to 10 rows for the sake
of making the results easy to view.

If we wanted to see only those loci that enriched in all species, we could run:

```
sqlite> SELECT * FROM matches WHERE genus_species1 = 1
   ...> AND genus_species2 = 1 AND genus_species3 = 1;
```

Assuming we only had those 10 UCE loci listed above in the database, if we ran
this query, we would see something like:

```
uce         genus_species1  genus_species2  genus_species3
----------  --------------  --------------  --------------
uce-503     1               1               1
uce-509     1               1               1
```

Basically, the `matches` table and this query are what we run to generate
**complete** (only loci enriched in all taxa) and **incomplete** (all loci
enriched from all taxa) matrices very easily and quickly (see
[Creating a data matrix configuration file](#locus-counts)).

##### The `match_map` table[](#the-match-map-table "Link to this heading")

The `match_map` table shows us which species-specific, contigs match which UCE
loci. Because each assembly program assigns an arbitrary designator to each
assembled contig, we need to map these arbitrary designators (which also differ
for each taxon/OTU) to the UCE locus to which it corresponds. Because assembled
contigs are also not in any particular orientation relative to each other across
taxa/OTUs (i.e., they may be 5’ - 3’ or 3’ - 5’), the database also records the
orientation of all contigs relative to orientation of each probe in the probes
file.

Let’s take a quick look at the `match_map` table:

```
SELECT * FROM match_map LIMIT 10;
```

This query is similar to the one that we ran against `matches` and returns the
first 10 rows of the `match_map` table:

```
uce         genus_species1  genus_species2  genus_species3
----------  --------------  --------------  --------------
uce-500     node_233(+)     .               .
uce-501     node_830(+)     .               .
uce-502     node_144(-)     .               .
uce-503     node_1676(+)    node_243(+)     node_322(+)
uce-504     node_83(+)      .               .
uce-505     node_1165(-)    .               .
uce-