- [View On GitHub](https://github.com/eBay/tsv-utils)

# eBay's TSV Utilities

Command line tools for large tabular data files.

---

Project maintained by [eBay](https://github.com/eBay)
Hosted on GitHub Pages — Theme by [mattgraham](https://twitter.com/michigangraham)

*Visit the [main page](/tsv-utils/)*

# Tips and Tricks

Contents:

* [Useful bash aliases and shell scripts](#useful-bash-aliases-and-shell-scripts)
* [macOS: Install GNU versions of Unix command line tools](#macos-install-gnu-versions-of-unix-command-line-tools)
* [Customize the sort command](#customize-the-sort-command)
* [Enable bash-completion](#enable-bash-completion)
* [Convert newline format and character encoding with dos2unix and iconv](#convert-newline-format-and-character-encoding-with-dos2unix-and-iconv)
* [Add a column to a TSV file](#add-a-column-to-a-tsv-file)
* [Use line buffering when processing slow input streams](#use-line-buffering-when-processing-slow-input-streams)
* [Using grep and tsv-filter together](#using-grep-and-tsv-filter-together)
* [Faster processing using GNU parallel](#faster-processing-using-gnu-parallel)
* [Reading data in R](#reading-data-in-r)
* [Shuffling large files](#shuffling-large-files)

## Useful bash aliases and shell scripts

### Bash aliases

A bash alias is a keystroke shortcut known by the shell. They are set up in the user's `~/.bashrc` or another shell init file. A convenient alias when working with TSV files is `tsv-header` which lists the field numbers for each field in a TSV file. To define it, put the following in `~/.bashrc` or other init file:

```
tsv-header () { head -n 1 "$@" | tr $'\t' $'\n' | nl -ba ; }
```

Once this is defined, use it as follows:

```
$ tsv-header worldcitiespop.tsv
     1	Country
     2	City
     3	AccentCity
     4	Region
     5	Population
     6	Latitude
     7	Longitude
```

A similar alias can be set up for CSV files. Here are two. The first uses [csv2tsv](/tsv-utils/docs/tool_reference/csv2tsv.html) to interpret the CSV header line, including CSV escape characters. The second uses only standard Unix tools. It won't interpret CSV escapes, but many header lines don't use escapes. (Define only one):

```
csv-header () { csv2tsv "$@" | head -n 1 | tr $'\t' $'\n' | nl -ba ; }
csv-header () { head -n 1 "$@" | tr $',' $'\n' | nl -ba ; }
```

Many useful aliases can be defined. Here is another the author finds useful with TSV files. It prints a file excluding the first line (the header line):

```
but-first () { tail -n +2 "$@" ; }
```

These aliases can be created in most shells. Non-bash shells may have a different syntax though.

### Shell scripts

Shell scripts are an alternative to bash aliases. They function similarly, but shell scripts are preferred for longer scripts or commands that need to be invoked by other programs. Here's an example of the `tsv-header` command written as a script rather than an alias. It extends the alias by printing help when invoked with the `-h` or `--help` options.

```
#!/bin/sh
if [ "$1" == "-h" ] || [ "$1" == "--h" ] || [ "$1" = "--help" ]; then
    program_filename=$(basename $0)
    echo "synopsis: $program_filename <tsv-file>"
    echo ""
    echo "Print field numbers and header text from the first line of <tsv-file>."
else
    head -n 1 "$@" | tr $'\t' $'\n' | nl -ba
fi
```

Put the above in the file `tsv-header` somewhere on the PATH. A common location is the `~/bin` directory, but this is not required. Run the command `$ chmod a+x tsv-header` to make it executable. Now it can be invoked just like the alias version of `tsv-header`.

The are a couple of simple sample scripts in the [Customize the sort command](#customize-the-sort-command) section.

## macOS: Install GNU versions of Unix command line tools

If you're using a Mac, one of best things you can do is install GNU versions of the typical Unix text processing tools. `cat`, `cut`, `grep`, `awk`, etc. The versions shipped with macOS are older and quite slow compared to the newer GNU versions, which are often more than five times faster. The [2017 Comparative Benchmarks](/tsv-utils/docs/comparative-benchmarks-2017.html) includes several benchmarks showing these deltas.

The [Homebrew](https://brew.sh/) and [MacPorts](https://www.macports.org/) package managers are good ways to install these tools and many others. Useful packages for data processing include:

* `coreutils` - The key Unix command line tools, including `cp`, `cat`, `cut`, `head`, `tail`, `wc`, `sort`, `uniq`, `shuf` and quite a few others.
* `gawk` - GNU awk.
* `gnu-sed` (Homebrew), `gsed` (MacPorts) - GNU sed.
* `grep` - GNU grep.

Note that in many cases the default installation process will install the tools with alternative names to avoid overriding the built-in versions. This is often done by adding a leading `g`. For example, `gawk`, `gsort`, `ggrep`, `gwc`, etc. Each package manager provides instructions for installing using the standard names.

## Customize the sort command

The standard Unix `sort` utility works quite well on TSV files. The syntax for sorting on individual fields (`-k|--key` option) takes getting used to, but once learned `sort` becomes a very capable tool. However, there are few simple tweaks that can improve convenience and performance.

### Install an updated sort utility (especially on macOS)

Installing an up-to-date utility is a worthwhile step on all platforms. This is especially so on macOS, as the default `sort` program is a bit slow. The `sort` utility available as part of [GNU Core Utils](https://www.gnu.org/software/coreutils/coreutils.html) is typically quite a bit faster. As of late 2019, the current GNU `sort` (version 8.31) is often more than twice as fast as the `sort` utility shipped with OS X Mojave.

Use your system's package manager to upgrade to the latest sort utility and consider installing GNU `sort` if it's not currently on your system. (Two popular package managers on the Mac are Homebrew and MacPorts.) Note that in some cases the GNU `sort` routine may be installed under a different name than the built-in `sort` utility, typically `gsort`.

### Specify TAB as a delimiter in a shell command

Unix `sort` utilities are able to sort using fields as keys. To use this feature on TSV files the TAB character must be passed as the field delimiter. This is easy enough, but specifying it on every sort invocation is a nuisance.

The way to fix this is to create either a `bash` alias or a shell script. A shell script is a better fit for `sort`, as shell commands can be invoked by other programs. This is convenient when using tools like [keep-header](/tsv-utils/docs/tool_reference/keep-header.html).

Put the lines below in a file, eg. `tsv-sort`. Run `$ chmod a+x tsv-sort` and add the file to the PATH:

*file: tsv-sort*

```
#!/bin/sh
sort -t $'\t' "$@"
```

Now `tsv-sort` will run `sort` with TAB as the delimiter. The following command sorts on field 2:

```
$ tsv-sort worldcitiespop.tsv -k2,2
```

### Set the buffer size for reading from standard input

GNU `sort` uses a small buffer by default when reading from standard input. This causes it to run much more slowly than when reading files directly. On the author's system the delta is about 2-3x. This will happen when using Unix pipelines. The [keep-header](/tsv-utils/docs/tool_reference/keep-header.html) tool uses a pipe internally, so it is affected as well. Examples:

```
$ grep green file.txt | sort
$ keep-header file.txt -- sort
```

Most of the performance of direct file reads can be regained by specifying a buffer size in the `sort` command invocation. The author has had good results with a 2 GB buffer on machines having 16 to 64 GB of RAM, and a 1 GB buffer obtains most of improvement. The change to the above commands:

```
$ grep green file.txt | sort --buffer-size=2G
$ keep-header file.txt -- sort --buffer-size=2G
```

These can be added to the shell script shown earlier. The revised shell script:

*file: tsv-sort*

```
#!/bin/sh
sort  -t $'\t' --buffer-size=2G "$@"
```

Now the commands are once again simple and have good performance:

```
$ grep green file.txt | tsv-sort
$ keep-header file.txt -- tsv-sort
```

Remember to use the correct `sort` program name if an updated version has been installed under a different name. This may be `gsort` on some systems.

A sample implementation of this script can be found in the `extras/scripts` directory in the tsv-utils GitHub repository. This sample script is also included in the prebuilt binaries package.

*More details*: The `--buffer-size` option may affect `sort` programs differently depending on whether input is being read from files or standard input. This is the case for [GNU sort](https://www.gnu.org/software/coreutils/manual/coreutils.html#sort-invocation), perhaps the most common `sort` program available. This is because by default `sort` uses different methods to choose an internal buffer size when reading from files and when reading from standard input. `--buffer-size` controls both. On a machine with large amounts of RAM, e.g. 64 GB, picking a 1 or 2 GB buffer size may actually slow `sort` down when reading from files while speeding it up when reading from standard input. The author has not experimented with enough systems to make a universal recommendation, but a bit of experimentation on any specific system should help. [GNU sort](https://www.gnu.org/software/coreutils/manual/coreutils.html#sort-invocation) has additional options when optimum performance is needed.

### Turn off locale sensitive sorting when not needed

GNU `sort` performs locale sensitive sorting, obeying the locale setting of the shell. Locale sensitive sorting is designed to produce standard dictionary sort orders across all languages and character sets. However, it is quite a bit slower than sorting using byte values for comparisons, in some cases by an order of magnitude.

This affects shells set to a non-default locale ("C" or "POSIX"). Setting the locale is normally preferred and is especially useful when working with Unicode data. Run the `locale` command to check the settings.

Locale sensitive sorting can be turned off when not needed. This is done by setting environment variable `LC_ALL=C` for the duration of the `sort` command. Here is a version of the sort shell script that does this:

*file: tsv-sort-fast*

```
#!/bin/sh
(LC_ALL=C sort -t $'\t' --buffer-size=2G "$@")
```

The `tsv-sort-fast` script can be used the same way as the `tsv-sort` script shown earlier.

A sample implementation of this script can be found in the `extras/scripts` directory in the tsv-utils GitHub repository. This sample script is also included in the prebuilt binaries package.

## Enable bash-completion

Bash command completion is quite handy for command line tools. Command names complete by default, already useful. Adding completion of command options is even better. As an example, with bash completion turned on, enter the command name, then a single dash (-):

```
$ tsv-select -
```

Now type a TAB (or pair of TABs depending on setup). A list of possible completions is printed and the command line restored for continued entry.

```
$ tsv-select -
--delimiter  --fields     --header     --help       --rest
$ tsv-select --
```

Now type 'r', then TAB, and the command will complete up to `$ tsv-select --rest`.

Enabling bash completion is a bit more involved than other packages, but still not too hard. It will often be necessary to install a package. The way to do this is system specific. A good source of instructions can be found at the [bash-completion GitHub repository](https://github.com/scop/bash-completion). Mac users may find the MacPorts [How to use bash-completion](https://trac.macports.org/wiki/howto/bash-completion) guide useful. Procedures for Homebrew are similar, but the details differ a bit.

After enabling bash-completion, add completions for the tsv-utils package. Completions are available in the `tsv-utils` file in the `bash_completion` directory in the tsv-utils GitHub repository. This file is also included with the prebuilt binary release packages. One way to add them is to 'source' the file from the `~/.bash_completion` file. A line like the following will achieve this:

```
if [ -r ~/tsv-utils/bash_completion/tsv-utils ]; then
    . ~/tsv-utils/bash_completion/tsv-utils
fi
```

The file can also be added to the bash completions system directory on your system. The location is system specific, see the bash-completion installation instructions for details.

## Convert newline format and character encoding with dos2unix and iconv

TSV Utilities tools expect input data to be utf-8 encoded and use Unix newlines. The `dos2unix` and `iconv` command line tools are useful when conversion is required.

Needing to convert newlines from DOS/Windows format to Unix is relatively common. Data files may have been prepared for Windows, and a number of spreadsheet programs generate Windows line feeds when exporting data. The `csv2tsv` tool converts Windows newlines as part of its operation. The other TSV Utilities detect Windows newlines when running on a Unix platform, including macOS. The following `dos2unix` commands convert files to use Unix newlines:

```
$ # In-place conversion.
$ dos2unix file.tsv

$ # Conversion writing to a new file. The existing file is not modified.
$ dos2unix -n file_dos.tsv file_unix.tsv

$ # Reading from standard input writes to standard output
$ cat file_dos.tsv | dos2unix | tsv-select -f 1-3 > newfile.tsv
```

Most applications and databases will export data in utf-8 encoding, but it can still be necessary to convert to utf-8. `iconv` serves this purpose nicely. An example converting Windows Latin-1 (code page 1252) to utf-8:

```
$ iconv -f CP1252 -t UTF-8 file_latin1.tsv > file_utf8.tsv
```

The above can be combined with `dos2unix` to perform both conversions at once:

```
$ iconv -f CP1252 -t UTF-8 file_window.tsv | dos2unix > file_unix.tsv
```

See the `dos2unix` and `iconv` man pages for more details.

## Add a column to a TSV file

An occasional task: Add a column to TSV data. Same value for all records, but a custom header. There are any number of ways to do this, the best is the one you can remember. Here's a trick for doing this using the [tsv-filter](/tsv-utils/docs/tool_reference/tsv-filter.html) `--label` option:

```
$ # The file
$ tsv-pretty data.tsv
 id  color   count
100  green     173
101  red       756
102  red      1303
103  yellow    180

$ # Add a 'year' field with value '2021'
$ tsv-filter data.tsv -H --label year --label-values 2021:any | tsv-pretty
 id  color   count  year
100  green     173  2021
101  red       756  2021
102  red      1303  2021
103  yellow    180  2021
```

This works because there was no test specified and `tsv-filter` defaults to passing all records through the filter. The `--label` option marks all records, indicating if the filter criteria was met or not. Of course, the `--label` option can be used with more so