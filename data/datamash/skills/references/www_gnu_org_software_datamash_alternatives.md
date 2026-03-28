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

## GNU datamash - alternative one-liners

GNU datamash is designed for ease of use, strict input validation,
and robust operation.

If datamash is not available, some operations could be performed using
existing software (such as `awk`, `Perl`,
`R`).

Using Datamash has the following advantages over simple one-liners:

* Datamash performs strict input validation on the input, and provides
  informative error messages when invalid input is found.
* Datamash operations are simpler to type, and less error-prone than
  writing one-liners.
* Datamash supports header lines (`-H/--headers`) on
  all operations.
* Datamash supports printing the entire line (`-f/--full`), not
  just the field being processed.
* Datamash's output is suitable for both interactive command-line usage, and
  for scripting, automation and down-stream processing by other tools.

When analysis requires more than basic operations provided by GNU Datamash,
users will benefit from switching to [GNU R](http://www.r-project.org/),
[GNU PSPP](http://www.gnu.org/software/pspp/),
[GNU Octave](http://www.gnu.org/software/octave/), or other programming
languages.

If you have suggestions and/or improvement to the one-liner examples below,
please send them to bug-datamash@gnu.org.

### sum, min, max, mean (single field, without grouping)

Calculating the sum, minimum value, maximum value and mean can be achieved
with `awk`:

```
$ seq 10 | datamash sum 1
55
$ seq 10 | awk '{sum+=$1} END {print sum}'
55

$ seq -5 1 7 | datamash min 1
-5
$ seq -5 1 7 | awk 'NR==1 {min=$1} NR>1 && $1<min { min=$1 } END {print min}'
-5

$ seq -5 -1 | datamash max 1
-1
$ seq -5 -1 | awk 'NR==1 {max=$1} NR>1 && $1>max { max=$1 } END {print max}'
-1

$ seq 10 | datamash mean 1
5.5
$ seq 10 | awk '{sum+=$1} END {print sum/NR}'
5.5
```

However, using AWK without additional input validation and error checking code
will silently ignore incorrent input and produce incorrect output:

```
$ printf "%s\n" 10 20 25 | awk '{sum+=$1} END {print sum/NR}'
18.3333
$ printf "%s\n" 10 20 25 | datamash mean 1
18.333333333333

# Without additional code, invalid numeric input is silently ignored by awk one-liner
$ printf "%s\n" 10 20 a 25 | awk '{sum+=$1} END {print sum/NR}'
13.75

# Datamash detects invalid input, and prints an informative error message
$ printf "%s\n" 10 20 a 25 | datamash mean 1
datamash: invalid numeric input in line 3 field 1: 'a'
```

### first, last, count, rand, unique, collapse (with grouping)

`awk` and `Perl` can be used to perform equivalent
Datamash operations, such as calculating the sum, minimum value, maximum value,
unique values of groupped input data.

The following input will be used for the examples below. It simulates input
data with two groups (`a`, `b`) and multiple values in
each group:

```
$ printf "%s\t%d\n" a 1 b 2 a 3 b 4 a 3 a 6
a       1
b       2
a       3
b       4
a       3
a       6

$ DATA=$(printf "%s\t%d\n" a 1 b 2 a 3 b 4 a 3 a 6)
```

First value of each group:

```
$ echo "$DATA" | datamash -s -g 1 first 2
a       1
b       2
$ echo "$DATA" | awk '!($1 in a){a[$1]=$2} END {for(i in a) { print i, a[i] }}'
a 1
b 2
```

Last value of each group:

```
$ echo "$DATA" | datamash -s -g 1 last 2
a       6
b       4
$ echo "$DATA" | awk '{a[$1]=$2} END {for(i in a) { print i, a[i] }}'
a 6
b 4
```

Number of values in each group:

```
$ echo "$DATA" | datamash -s -g 1 count 2
a       4
b       2
$ echo "$DATA" | awk '{a[$1]++} END {for(i in a) { print i, a[i] }}'
a 4
b 2
```

Collapse all values in each group:

```
$ echo "$DATA" | datamash -s -g1 collapse 2
a        1,3,3,6
b        2,4
$ echo "$DATA" | perl -lane '{push @{$a{$F[0]}},$F[1]} END{print join("\n",map{"$_ ".join(",",@{$a{$_}})} sort keys %a);}'
a 1,3,3,6
b 2,4
```

Collapse unique values in each group:

```
$ echo "$DATA" | datamash -s -g1 unique 2
a       1,3,6
b       2,4
$ echo "$DATA" | perl -lane '{$a{$F[0]}{$F[1]}=1} END{print join("\n",map{"$_ ".join(",",sort keys %{$a{$_}})} sort keys %a);}'
a 1,3,6
b 2,4
```

Print a random value from each group:

```
$ echo "$DATA" | datamash -s -g 1 rand 2
a       3
b       2
$ echo "$DATA" | perl -lane '{ push @{$a{$F[0]}},$F[1] } END{ print join("\n",map{"$_ ".$a{$_}->[rand(@{$a{$_}})] } sort keys %a ) ;}'
a 6
b 4
```

The `awk` and `Perl` versions has the advantage of not
need to sort the input, at the expense of using more memory.

However, using Perl one-liners without additional code does not handle I/O
errors, such as:

```
$ echo "$DATA" | perl -lane '{$sum+=$F[1]} END { print $sum }'
19
$ echo "$DATA" | perl -lane '{$sum+=$F[1]} END { print $sum }' > /dev/full
# (disk-full error not detected, data is lost without warning)

$ echo "$DATA" | datamash sum 2
19
$ echo "$DATA" | datamash sum 2  > /dev/full
datamash: write error: No space left on device
```

When combining multiple operations, and optional output header line,
`Datamash`'s succinct syntax is advantageous:

```
$ echo "$DATA" | datamash -s -g1 --header-out count 2 collapse 2 sum 2 mean 2 | expand -t 18
GroupBy(field-1)  count(field-2)    collapse(field-2) sum(field-2)      mean(field-2)
a                 4                 1,3,3,6           13                3.25
b                 2                 2,4               6                 3
```

### Statistical Operations

`Rscript` (part of GNU R package) can be used to perform calculations
directly from the command line.

A simple summary of the data, without grouping:

```
$ echo "$DATA" | datamash min 2 q1 2 median 2 mean 2 q3 2 max 2
1       2.25    3       3.1666666666667 3.75    6

$ echo "$DATA" | Rscript -e 'summary(read.table("stdin"))
V1          V2
a:4   Min.   :1.000
b:2   1st Qu.:2.250
      Median :3.000
      Mean   :3.167
      3rd Qu.:3.750
      Max.   :6.000
```

A simple summary of the data, with grouping:

```
$ echo "$DATA" | datamash -s --header-out -g 1 min 2 q1 2 median 2 mean 2 q3 2 max 2 | expand -t 18
GroupBy(field-1)  min(field-2)      q1(field-2)       median(field-2)   mean(field-2)     q3(field-2)       max(field-2)
a                 1                 2.5               3                 3.25              3.75              6
b                 2                 2.5               3                 3                 3.5               4

$ echo "$DATA" | Rscript -e 'a=read.table("stdin")' -e 'aggregate(a$V2,by=list(a$V1),summary)'
  Group.1 x.Min. x.1st Qu. x.Median x.Mean x.3rd Qu. x.Max.
1       a   1.00      2.50     3.00   3.25      3.75   6.00
2       b   2.00      2.50     3.00   3.00      3.50   4.00
```

Calculating mean and standard-deviation for each group:

```
$ echo "$DATA" | datamash -s -g1 mean 2 sstdev 2
a       3.25    2.0615528128088
b       3       1.4142135623731
$ echo "$DATA" | Rscript -e 'a=read.table("stdin")' -e 'f=function(x){c(mean(x),sd(x))}' -e 'aggregate(a$V2,by=list(a$V1),f)'
  Group.1      x.1      x.2
1       a 3.250000 2.061553
2       b 3.000000 1.414214
```

`GNU R`'s output formatting is preferable for interactive exploration of data.
`Datamash`'s output is preferable for scripting and automation.

Similar to `Perl` one-liners, `GNU R` will not detect I/O
errors without additional code. For scripting and automation,
`Datamash`'s error reporting is more informative:

```
$ printf "%s\n" 1 2 3 a 5 | datamash sstdev 1
datamash: invalid numeric input in line 4 field 1: 'a'

$ printf "%s\n" 1 2 3 a 5 | Rscript -e 'sd(read.table("stdin"))'
Error in is.data.frame(x) :
  (list) object cannot be coerced to type 'double'
  Calls: sd -> var -> is.data.frame
  Execution halted
```

### Reverse, Transpose

`Perl` can be used to reverse fields:

```
$ echo "$DATA" | datamash reverse
1       a
2       b
3       a
4       b
3       a
6       a
$ echo "$DATA" | perl -lane 'print join(" ", reverse @F)'
1 a
2 b
3 a
4 b
3 a
6 a
```

The following `Rscript` code can be used to transpose a file
(swap rows and columns):

```
$ echo "$DATA" | datamash transpose
a       b       a       b       a       a
1       2       3       4       3       6

$ echo "$DATA" | Rscript -e 'write.table(t(read.table("stdin")),quote=F,col.names=F,row.names=F)'
a b a b a a
1 2 3 4 3 6
```

Other languages (such as `Perl`,`awk`,`shell`) also offer one-liners to transpose
a file, but their solution usually do not detect invalid input:

```
$ DATAX=$(printf "1\t2\t3\n4\t5\n6\t7\t8\n")
$ echo "$DATAX"
1       2       3
4       5
6       7       8

$ echo "$DATAX" | datamash transpose
datamash: transpose input error: line 2 has 2 fields (previous lines had 3);
see --help to disable strict mode

# Datamash also offers an option to fill-in missing values:
$ echo "$DATAX" | datamash --no-strict transpose
1       4       6
2       5       7
3       N/A     8

$ echo "$DATAX" | Rscript -e 'write.table(t(read.table("stdin")),quote=F,col.names=F,row.names=F)'
Error in scan(file, what, nmax, sep, dec, quote, skip, nlines, na.strings,  :
  line 2 did not have 3 elements
  Calls: write.table -> is.data.frame -> t -> read.table -> scan
  Execution halted
```

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

$Date: 2014/08/23 00:08:34 $