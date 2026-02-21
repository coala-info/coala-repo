# optparse Command Line Option Parsing

optparse is a command line option parser inspired by Python's "optparse" library. Use this with Rscript to write "#!"-shebang scripts that accept short and long flags/options, generate a usage statement, and set default values for options that are not specified on the command line.

In our working directory we have two example R scripts, named "example.R" and "display\_file.R" illustrating the use of the optparse package.

**bash$ ls**

```
display_file.R
example.R
```

In order for a \*nix system to recognize a "#!"-shebang line you need to mark the file executable with the `chmod` command, it also helps to add the directory containing your Rscripts to your path:

**bash$ chmod ug+x display\_file.R example.R**

**bash$ export PATH=$PATH:`pwd`**

Here is what `example.R` contains:

**bash$ display\_file.R example.R**

```
#!/usr/bin/env Rscript
# Copyright 2010-2013 Trevor L Davis <trevor.l.davis@gmail.com>
# Copyright 2008 Allen Day
#
#  This file is free software: you may copy, redistribute and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation, either version 2 of the License, or (at your
#  option) any later version.
#
#  This file is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
suppressPackageStartupMessages(library("optparse"))
suppressPackageStartupMessages(library("stats"))

# specify our desired options in a list
# by default OptionParser will add an help option equivalent to
# make_option(c("-h", "--help"), action="store_true", default=FALSE,
#               help="Show this help message and exit")
option_list <- list(
    make_option(c("-v", "--verbose"), action="store_true", default=TRUE,
        help="Print extra output [default]"),
    make_option(c("-q", "--quietly"), action="store_false",
        dest="verbose", help="Print little output"),
    make_option(c("-c", "--count"), type="integer", default=5,
        help="Number of random normals to generate [default %default]",
        metavar="number"),
    make_option("--generator", default="rnorm",
        help = "Function to generate random deviates [default \"%default\"]"),
    make_option("--mean", default=0,
        help="Mean if generator == \"rnorm\" [default %default]"),
    make_option("--sd", default=1, metavar="standard deviation",
        help="Standard deviation if generator == \"rnorm\" [default %default]")
    )

# get command line options, if help option encountered print help and exit,
# otherwise if options not found on command line then set defaults,
opt <- parse_args(OptionParser(option_list=option_list))

# print some progress messages to stderr if "quietly" wasn't requested
if ( opt$verbose ) {
    write("writing some verbose output to standard error...\n", stderr())
}

# do some operations based on user input
if( opt$generator == "rnorm") {
    cat(paste(rnorm(opt$count, mean=opt$mean, sd=opt$sd), collapse="\n"))
} else {
    cat(paste(do.call(opt$generator, list(opt$count)), collapse="\n"))
}
cat("\n")
```

By default *optparse* will generate a help message if it encounters `--help` or `-h` on the command line. Note how `%default` in the example program was replaced by the actual default values in the help statement that *optparse* generated.

**bash$ example.R --help**

```
Usage: example.R [options]

Options:
    -v, --verbose
        Print extra output [default]

    -q, --quietly
        Print little output

    -c NUMBER, --count=NUMBER
        Number of random normals to generate [default 5]

    --generator=GENERATOR
        Function to generate random deviates [default "rnorm"]

    --mean=MEAN
        Mean if generator == "rnorm" [default 0]

    --sd=STANDARD DEVIATION
        Standard deviation if generator == "rnorm" [default 1]

    -h, --help
        Show this help message and exit
```

If you specify default values when creating your `OptionParser` then *optparse* will use them as expected.

**bash$ example.R**

```
writing some verbose output to standard error...

-1.0319088787312
1.51467317739761
-0.182264759789326
0.250964592323344
2.39012966005878
```

Or you can specify your own values.

**bash$ example.R --mean=10 --sd=10 --count=3**

```
writing some verbose output to standard error...

-5.8641068053515
5.00111136905801
-3.86971764740004
```

If you remember from the example program that `--quiet` had `action="store_false"` and `dest="verbose"`. This means that `--quiet` is a switch that turns the `verbose` option from its default value of `TRUE` to `FALSE`. Note how the `verbose` and `quiet` options store their value in the exact same variable.

**bash$ example.R --quiet -c 4 --generator="runif"**

```
0.0934223954100162
0.347937157377601
0.262309876270592
0.867103962693363
```

If you specify an illegal flag then *optparse* will throw an error.

**bash$ example.R --silent -m 5**

```
Usage: example.R [options]

example.R: error: Error in getopt(spec = spec, opt = args) : long flag "silent" is invalid
```

If you specify the same option multiple times then *optparse* will use the value of the last option specified.

**bash$ example.R -c 100 -c 2 -c 1000 -c 7**

```
writing some verbose output to standard error...

-0.356474119252246
-0.542733697176872
0.350193368905548
0.315063370156928
-1.03597296782789
-0.119909869407653
2.20846228253079
```

*optparse* can also recognize positional arguments if `parse_args` is given the option `positional_arguments = c(min_pa, max_pa)` where `min_pa` is the minimum and `max_pa` is the maximum number of supported positional arguments. (A single numeric corresponds to `min_pa == max_pa`, `TRUE` is equivalent to `c(0, Inf)`, and `FALSE`, the default, is equivalent to `0`.) Below we give an example program *display\_file.R*, which is a program that prints out the contents of a single file (the required positional argument, not an optional argument) and which accepts the normal help option as well as an option to add line numbers to the output. Note that the positional arguments need to be placed *after* the optional arguments.

**bash$ display\_file.R --help**

```
Usage: display_file.R [options] file

Options:
    -n, --add_numbers
        Print line number at the beginning of each line [default]

    -h, --help
        Show this help message and exit
```

**bash$ display\_file.R --add\_numbers display\_file.R**

```
1 #!/usr/bin/env Rscript
2 # Copyright 2010-2013 Trevor L Davis <trevor.l.davis@gmail.com>
3 # Copyright 2013 Kirill Müller
4 #
5 #  This file is free software: you may copy, redistribute and/or modify it
6 #  under the terms of the GNU General Public License as published by the
7 #  Free Software Foundation, either version 2 of the License, or (at your
8 #  option) any later version.
9 #
10 #  This file is distributed in the hope that it will be useful, but
11 #  WITHOUT ANY WARRANTY; without even the implied warranty of
12 #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
13 #  General Public License for more details.
14 #
15 #  You should have received a copy of the GNU General Public License
16 #  along with this program.  If not, see <http://www.gnu.org/licenses/>.
17 suppressPackageStartupMessages(library("optparse"))
18
19 option_list <- list(
20     make_option(c("-n", "--add_numbers"), action="store_true", default=FALSE,
21         help="Print line number at the beginning of each line [default]")
22     )
23 parser <- OptionParser(usage = "%prog [options] file", option_list=option_list)
24
25 arguments <- parse_args(parser, positional_arguments = 1)
26 opt <- arguments$options
27 file <- arguments$args
28
29 if( file.access(file) == -1) {
30     stop(sprintf("Specified file ( %s ) does not exist", file))
31 } else {
32     file_text <- readLines(file)
33 }
34
35 if(opt$add_numbers) {
36     cat(paste(1:length(file_text), file_text), sep = "\n")
37 } else {
38     cat(file_text, sep = "\n")
39 }
```

**bash$ display\_file.R non\_existent\_file.txt**

```
Error: Specified file ( non_existent_file.txt ) does not exist
Execution halted
```

**bash$ display\_file.R**

```
Usage: display_file.R [options] file

display_file.R: error: required at least 1 positional arguments, got 0
```