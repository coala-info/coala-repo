[**Skip to main text**](#content)

[Free Software Supporter](//www.fsf.org/fss):

[JOIN THE FSF](https://www.fsf.org/associate/support_freedom?referrer=4052)

[![ [A GNU head] ](/graphics/heckert_gnu.transp.small.png)**GNU** Operating System](/)
Supported by the
[Free Software Foundation](#mission-statement)

[![ [Search www.gnu.org] ](/graphics/icons/search.png)](//www.gnu.org/cgi-bin/estseek.cgi)

[Site navigation](#navigation "More...")
[**Skip**](#content)

* [ABOUT GNU](/gnu/gnu.html)
* [PHILOSOPHY](/philosophy/philosophy.html)
* [LICENSES](/licenses/licenses.html)
* [EDUCATION](/education/education.html)
* =
  [SOFTWARE](/software/software.html)

  =
* [DISTROS](/distros/distros.html)
* [DOCS](/doc/doc.html)
* [MALWARE](/proprietary/proprietary.html)
* [HELP GNU](/help/help.html)
* [AUDIO & VIDEO](/audio-video/audio-video.html)
* [GNU ART](/graphics/graphics.html)
* [FUN](/fun/humor.html)
* [GNU'S WHO?](/people/people.html)
* [SOFTWARE DIRECTORY](//directory.fsf.org)
* [HARDWARE](https://h-node.org/)
* [SITEMAP](/server/sitemap.html)

[← back to GNU Datamash main page](../)

## GNU datamash - Examples

GNU datamash is command-line program which performs
simple calculation (e.g. count, sum, min, max, mean, stdev, string coalescing)
on input files.

```
# sum the values in the first column
$ seq 10 | datamash sum 1
55
```

Datamash has a rich set of statistical functions, to quickly assess information
in textual input files. An example of calculating basic statistic
(mean, 1st quartile, median, 3rd quartile, IQR, sample-standard-deviation,
and p-value of Jarque-Bera test for normal distribution:

```
$ datamash -H mean 1 q1 1 median 1 q3 1 iqr 1 sstdev 1 jarque 1 < FILE.TXT
mean(x)   q1(x)  median(x)  q3(x)   iqr(x)  sstdev(x)  jarque(x)
45.32     23     37         61.5    38.5    30.4487    8.0113e-09
```

### Topics

* [Example files](#example_files)
* [Example: Test Scores](#example_scores)
* [Example: Header Lines](#example_header)
* [Example: Genes](#example_genes)
* [Example: Datamash with other unix programs](#example_pipes)
* [Example: Grouping Multiple Fields](#example_grouping)
* [Example: Descriptive Statistics](#example_descstat)* [Example: Transpose File (swap rows, columns)](#example_transpose)* [Example: Reverse fields](#example_reverse)

### Example Files

The input files used in the following examples are distributed with datamash's source code,
and can also be downloaded directly:
[scores.txt](http://git.savannah.gnu.org/cgit/datamash.git/plain/examples/scores.txt),
[scores\_h.txt](http://git.savannah.gnu.org/cgit/datamash.git/plain/examples/scores_h.txt),
[genes.txt](http://git.savannah.gnu.org/cgit/datamash.git/plain/examples/genes.txt),
[genes\_h.txt](http://git.savannah.gnu.org/cgit/datamash.git/plain/examples/genes_h.txt)
(The "`_h`" files have an additional header line as the first line of the file).

When datamash is locally installed, example files are typically in
`/usr/share/datamash/examples`
or
`/usr/local/share/datamash/examples`.

### Example: Test Scores

The file `scores.txt` contains tests scores of
college students of different majors (Arts, Business, Health and Medicine,
Life Sciences, Engineering, Social Sciences).

The files has three columns: Name, Major, Score:

```
$ cat scores.txt
Shawn     Arts  65
Marques   Arts  58
Fernando  Arts  78
Paul      Arts  63
Walter    Arts  75
...
```

Using datamash, find the lowest (min) and
highest (max) score for each College Major (Major is in column 2,
the score values are in column 3):

```
$ datamash -g 2 min 3 max 3 < scores.txt
Arts            46  88
Business        79  94
Health-Medicine 72  100
Social-Sciences 27  90
Life-Sciences   14  91
Engineering     39  99
```

Similarly, find the number of students, mean score and
sample-standard-deviation for each College major:

```
$ datamash -g 2 mean 3 sstdev 3 < scores.txt
Arts             68.9474  10.4215
Business         87.3636  5.18214
Health-Medicine  90.6154  9.22441
Social-Sciences  60.2667  17.2273
Life-Sciences    55.3333  20.606
Engineering      66.5385  19.8814
```

### Example: Header Lines

A *header line* is an optional first line in the input or output files,
which labels each column. Datamash can generate
header line in the output file, even if the input file doesn't have a header line
(`scores.txt` does not have a header line,
the first line in the file contains data).

Use `--header-out` to add a header line to the output
(when the input does not contain a header line):

```
$ datamash --header-out -g 2 count 3 mean 3 pstdev 3 < scores.txt
GroupBy(field-2)    mean(field-3)  sstdev(field-3)
Arts                68.9474        10.4215
Business            87.3636        5.18214
Health-Medicine     90.6154        9.22441
Social-Sciences     60.2667        17.2273
Life-Sciences       55.3333        20.606
Engineering         66.5385        19.8814
```

When the input file has a header line, datamash
will use the names from each column in the output header line.
`scores_h.txt` contains the same information as
`scores.txt`, with an additional header line:

```
$ cat scores_h.txt
Name        Major   Score
Shawn       Arts    65
Marques     Arts    58
Fernando    Arts    78
Paul        Arts    63
Walter      Arts    75
...
```

Use `-H`
(equivalent to `--header-in --header-out`)
to use input headers and print output headers:

```
$ datamash -H -g 2 count 3 mean 3 pstdev 3 < scores_h.txt
GroupBy(Major)      mean(Score)    sstdev(Score)
Arts                68.9474        10.4215
Business            87.3636        5.18214
Health-Medicine     90.6154        9.22441
Social-Sciences     60.2667        17.2273
Life-Sciences       55.3333        20.606
Engineering         66.5385        19.8814
```

### Example: Genes

*note:* The following examples assume basic bioinformatics knowledge.

The `genes.txt` file contains a small subset of the Human Genome genes.
The columns of `genes.txt` are:

1. bin
2. name - isoform/transcript identifier
3. chromosome
4. strand
5. txStart - transcription start site
6. txEnda - transcription end site
7. cdsStart - coding start site
8. cdsEnd - coding end site
9. exonCount - number of exons
10. exonStarts
11. exonEnds
12. score
13. GeneName - gene identifier
14. cdsStartStat
15. cdsEndStat
16. exonFrames

The list is compiled by the UCSC Genome Browser Project, part of of Center for Biomolecular Science and Engineering (CBSE) at the University of
California Santa Cruz (UCSC).

#### Find Number of isoforms per gene

The gene identifiers are in column 13, the transcript identifiers are in column 2.
To count how many isoforms each gene has, use datamash
to group by column 13, and for each group, count the values in column 2
(use `-s` to automatically sort the input file):

```
$ datamash -s -g 13 count 2 < genes.txt
ABCC1   1
ABCC10  2
ABCC11  3
ABCC12  1
ABCC13  2
...
```

Using the `collapse` operation, datamash can print all
the isoforms for each gene:

```
$ datamash -s -g 13 count 2 collapse 2 < genes.txt
ABCC1   1  NM_004996
ABCC10  2  NM_001198934,NM_033450
ABCC11  3  NM_032583,NM_033151,NM_145186
ABCC12  1  NM_033226
ABCC13  2  NR_003087,NR_003088
...
```

When using a file with a header line, add `-H`:

```
$ datamash -H -s -g 13 count 2 collapse 2 < genes_h.txt
GroupBy(name2)  count(name) collapse(name)
ABCC1           1           NM_004996
ABCC10          2           NM_001198934,NM_033450
ABCC11          3           NM_033151,NM_145186,NM_032583
ABCC12          1           NM_033226
ABCC13          2           NR_003088,NR_003087
...
```

### Datamash with other unix programs

Datamash is designed as a unix filter program,
reading from standard input and writing to standard output. It works well with
the common unix programs (such as awk) for additional functionality:

**Find genes with more than 5 isoforms:**

```
 $ cat genes.txt | datamash -s -g 13 count 2 collapse 2 | awk '$2>5'
AC159540.1  6  NR_040097,NR_103732,NR_103733,NR_040097,NR_103732,NR_103733
ACSF3       6  NM_001127214,NM_001243279,NM_001284316,NM_174917,NR_045667,NR_104293
ADAM29      7  NM_001130703,NM_001130704,NM_001130705,NM_001278125,NM_001278126,NM_001278127,NM_014269
AIPL1       8  NM_001033054,NM_001033055,NM_001285399,NM_001285400,NM_001285401,NM_001285402,NM_001285403,NM_014336
ANXA8       6  NM_001040084,NM_001271702,NM_001271703,NM_001040084,NM_001271702,NM_001271703
...
```

**Which genes are transcribes from both strands?**

(that is, they have isoforms with both positive and negative strands.
strand column is number 4)

```
$ cat genes.txt | datamash -s -g 13 countunique 4 | awk '$2>1'
AC159540.1   2
AMY1C        2
ANXA8        2
BMS1P17      2
BMS1P18      2
...
```

**Which genes are transcribes from multiple chromosomes?**

(that is, they have isoforms from multiple chromosomes.
Chromosome column is number 3):

```
$ cat genes.txt | datamash -s -g 13 countunique 3 unique 3 | awk '$2>1'
AKAP17A      2   chrX,chrY
ASMT         2   chrX,chrY
ASMTL        2   chrX,chrY
ASMTL-AS1    2   chrX,chrY
BMS1P17      2   chr14,chr22
...
```

**Examine Exon-count variability**

(for each gene, list the minimum, maximum, mean and stddev of the
exon-count of its isoforms. Exon-Count column is number 9):

```
$ cat genes.txt | datamash -s -g 13 count 9 min 9 max 9 mean 9 pstdev 9 | awk '$2>1'
ABCC10     2   20   22     21   1
ABCC11     3   29   30   29.3   0.471405
ABCC13     2    5    6    5.5   0.5
ABCC3      2   12   31   21.5   9.5
AC159540.1 6    4    5    4.1   0.372678
...
```

### Example: Grouping multiple fields

**Chromosome name is in column 3. How many transcripts are in each chromosome?**

```
$ datamash -s -g 3 count 2 < genes.txt
chr1  365
chr10 164
chr11 189
chr12 187
chr13 66
...
```

**Strand information is in column 4. How many transcripts are in each chromsome AND strand?**

To find out, group by two columns: Column 3 (chromosome name) and Column 4 (strand):

```
$ datamash -s -g 3,4 count 2 < genes.txt
chr1  - 183
chr1  + 182
chr10 -  52
chr10 + 112
chr11 - 105
chr11 +  84
chr12 - 117
chr12 +  70
...
```

### Example: Descriptive Statistics

Calculating the Five-Number Summary: of all values in the first column of the input file:

```
$ datamash min 1 q1 1 median 1 q3 1 max 1 < FILE.TXT
78      93     100        107    120
```

The same command, with header lines for better clarity:

```
$ datamash -H min 1 q1 1 median 1 q3 1 max 1 < FILE.TXT
min(x)  q1(x)  median(x)  q3(x)  max(x)
78      93     100        107    120
```

Finding out the count,mean and sample standard-deviation:

```
$ datamash -H count 1 mean 1 sstdev 1 < FILE.TXT
count(x)   mean(x)   sstdev(x)
100        100.06    9.5767184
```

### Example: Transpose File (swap rows, columns)

Use **transpose** to swap rows and columns in a file:

```
$ cat input.txt
Sample   Year   Count
id-123   2014   1002
id-99    2013    990
id-42    2014   2030
id-13    2014    599

$ datamash transpose < input.txt
Sample  id-123  id-99   id-42   id-13
Year    2014    2013    2014    2014
Count   1002    990     2030    599
```

By default, **transpose** verifies the input has the same number of fields
in each line, and fails with an error otherwise:

```
$ cat input1.txt
Sample  Year    Count
id-123  2014    1002
id-99   2013
id-42   2014    2030
id-13   2014    599

$ datamash transpose < input1.txt
datamash: transpose input error: line 3 has 2 fields (previous lines had 3);
see --help to disable strict mode
```

Use **--no-strict** to allow missing values:

```
$ datamash --no-strict transpose < input1.txt
Sample  id-123  id-99    id-42    id-13
Year    2014    2013     2014     2014
Count   1002    N/A      2030     599

# Use --filler to set the missing-field-filler value:
$ datamash --no-strict --filler XYZ transpose < input1.txt
Sample  id-123  id-99   id-42   id-13
Year    2014    2013    2014    2014
Count   1002    XYZ     2030    599
```

### Example: Reverse Fields

Use **reverse** to reverse the fields order in a file:

```
$ cat input.txt
Sample   Year   Count
id-123   2014   1002
id-99    2013    990
id-42    2014   2030
id-13    2014    599

$ datamash reverse < input.txt
Count   Year    Sample
1002    2014    id-123
990     2013    id-99
2030    2014    id-42
599     2014    id-13
```

By default, **reverse** verifies the input has the same number of fields
in each line, and fails with an error otherwise. Use **--no-strict** to
disable this behaviour (See transpose section above for an example).

---

[BACK TO TOP ▲](#header)

> [![ [FSF logo] ](/graphics/fsf-logo-notext-small.png)](//www.fsf.org)**“The Free Software Foundation (FSF) is a nonprofit with a worldwide
> mission to promote computer user freedom. We defend the rights of all
> software users.”**

[JOIN](//www.fsf.org/associate/support_freedom?referrer=4052)
[DONATE](//donate.fsf.org/)
[SHOP](//shop.fsf.org/)

Please send general FSF & GNU inquiries to
<gnu@gnu.org>.
There are also [other ways to contact](/contact/)
the FSF. Broken links and other corrections or suggestions can be sent
to <bug-datamash@gnu.org>.

Please see the [Translations
README](/server/standards/README.translations.html) for information on coordinating and submitting translations
of this article.

Copyright © 2014 Free Software Foundation, Inc.

This page is licensed under a [Creative
Commons Attribution-NoDerivs 3.0 United States License](http://creativecommons.org/licenses/by-nd/3.0/us/).

[Copyright Infringement Notification](//www.fsf.org/about/dmca-notice)

Updated:
$Date: 2018/03/17 23:40:32 $