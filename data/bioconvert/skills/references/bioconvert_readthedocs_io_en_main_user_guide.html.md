[bioconvert
![Logo](_static/logo.png)](index.html)

* [1. Installation](installation.html)
* 2. User Guide
  + [2.1. Quick Start](#quick-start)
  + [2.2. Explicit conversion](#explicit-conversion)
  + [2.3. Implicit conversion](#implicit-conversion)
  + [2.4. Compression](#compression)
  + [2.5. Parallelization](#parallelization)
    - [2.5.1. Iteration with unix commands](#iteration-with-unix-commands)
    - [2.5.2. Snakemake option](#snakemake-option)
* [3. Tutorial](tutorial.html)
* [4. Developer guide](developer_guide.html)
* [5. Benchmarking](benchmarking.html)
* [6. Gallery](auto_examples/index.html)
* [7. References](references.html)
* [8. Formats](formats.html)
* [9. Glossary](glossary.html)
* [10. Faqs](faqs.html)
* [11. Bibliography](bibliography.html)

[bioconvert](index.html)

* 2. User Guide
* [View page source](_sources/user_guide.rst.txt)

---

# [2. User Guide](#id1)[](#user-guide "Link to this heading")

Contents

* [User Guide](#user-guide)

  + [Quick Start](#quick-start)
  + [Explicit conversion](#explicit-conversion)
  + [Implicit conversion](#implicit-conversion)
  + [Compression](#compression)
  + [Parallelization](#parallelization)

    - [Iteration with unix commands](#iteration-with-unix-commands)
    - [Snakemake option](#snakemake-option)

## [2.1. Quick Start](#id2)[](#quick-start "Link to this heading")

Most of the time, Bioconvert simply requires the input and output filenames.
If there is no ambiguity, the extension are used to infer the type of conversion
you wish to perform.

For instance, to convert a FASTQ to a FASTA file, use this type of command:

```
bioconvert test.fastq test.fasta
```

If the converter *fastq* to *fasta\*² exists in \*\*Bioconvert\**, it will work out of
the box. In order to get a list of all possible conversions, just type:

```
bioconvert --help
```

To obtain more specific help about a converter that you found in the list:

```
bioconvert fastq2fasta --help
```

Note

All converters are named as <input\_extension>2<output\_extension>

## [2.2. Explicit conversion](#id3)[](#explicit-conversion "Link to this heading")

Sometimes, Bioconvert won’t be able to know what you want solely based on
the input and ouput extensions. So, you may need to be explicit and use a
subcommand. For instance to use the converter *fastq2fasta*, type:

```
bioconvert fastq2fasta  input.fastq output.fasta
```

The rationale behind the subcommand choice is manyfold. First, you may have dedicated help
for a given conversion, which may be different from one conversion to the other:

```
bioconvert fastq2fasta --help
```

Second, the extensions of your input and output may be non-standard or different
from the choice made by the **bioconvert** developers. So, using the subcommand you can do:

```
bioconvert fastq2fasta  input.fq output.fas
```

where the extensions can actually be whatever you want.

If you do not provide the output file, it will be created based on the input
filename by replacing the extension automatically. So this command:

```
bioconvert fastq2fasta input.fq
```

generates an output file called *input.fasta*. Note that it will be placed in
the same directory as the input file, not locally. So:

```
bioconvert fastq2fasta ~/test/input.fq
```

will create the *input.fasta* file in the ~/test directory.

If an output file exists, it will not be overwritten. If you want to do so, use
the –force argument:

```
bioconvert fastq2fasta  input.fq output.fa --force
```

## [2.3. Implicit conversion](#id4)[](#implicit-conversion "Link to this heading")

If the extensions match the conversion name, you can perform implicit
conversion:

```
bioconvert input.fastq output.fasta
```

Internally, a format may be registered with several extensions. For instance
the extensions possible for a FastA file are `fasta` and `fa` so you can
also write:

```
bioconvert input.fastq output.fa
```

## [2.4. Compression](#id5)[](#compression "Link to this heading")

Input files may be compressed. For instance, most FASTQ are compressed in GZ
format. Compression are handled in some converters. Basically, most of the
humand-readable files handle compression. For instance, all those commands
should work and can be used to compress output files, or handle input compressed
files:

```
bioconvert test.fastq.gz test.fasta
bioconvert test.fastq.gz test.fasta.gz
bioconvert test.fastq.gz test.fasta.bz2
```

Note that you can also decompress and compress into another compression keeping
without doing any conversion (note the fastq extension in both input and output
files):

```
bioconvert test.fastq.gz test.fastq.dsrc
```

## [2.5. Parallelization](#id6)[](#parallelization "Link to this heading")

In Bioconvert, if the input contains a wildcard such as `*` or `?` characters, then, input filenames are treated separately and converted sequentially:

```
bioconvert fastq2fasta "*.fastq"
```

Note, however, that the files are processed sequentially one by one. So, we may
want to parallelise the computation.

### [2.5.1. Iteration with unix commands](#id7)[](#iteration-with-unix-commands "Link to this heading")

You can use a bash script under unix to run Bioconvert on a set of files. For
instance the following script takes all files with the *.fastq* extension and
convert them to fasta:

```
#!/bin/bash
FILES=*fastq
CONVERSION=fastq2fasta
for f in $FILES
do
  echo "Processing $f file..."
  bioconvert $CONVERSION $f  --force
done
```

Note, however, that this is still a sequential computation. Yet, you may now
change it slightly to run the commands on a cluster. For instance, on a SLURM
scheduler, you can use:

```
#!/bin/bash
FILES=*fastq
CONVERSION=fastq2fasta
for f in $FILES
do
  echo "Processing $f file..."
  sbatch -c 1 bioconvert $CONVERSION $f  --force
done
```

### [2.5.2. Snakemake option](#id8)[](#snakemake-option "Link to this heading")

If you have lots of files to convert, a snakemake pipeline is available in the [Sequana](https://github.com/sequana/sequana) project and can be installed using **pip install sequana\_bioconvert**. It also installs bioconvert with an ap ptainer image that contains all dependencies for you.

Here is another way of running your jobs in parallel using a
simple Snakefile ([snakemake](https://snakemake.readthedocs.io/en/stable/))
that can be run easily either locally or on a cluster.

You can download the following file [`Snakefile`](_downloads/b0ca7e384af213e2f691bf0435d08557/Snakefile)

```
inext = "fastq"
outext = "fasta"
command = "fastq2fasta"

import glob
samples = glob.glob("*.{}".format(inext))
samples = [this.rsplit(".")[0] for this in samples]

rule all:
    input: expand("{{dataset}}.{}".format(outext), dataset=samples)

rule bioconvert:
    input: "{{dataset}}.{}".format(inext)
    output: "{{dataset}}.{}".format(outext)
    run:
        cmd = "bioconvert {} ".format(command) + "{input} {output}"
        shell(cmd)
```

and execute it locally as follows (assuming you have 4 CPUs):

```
snakemake -s Snakefile --cores 4
```

or on a cluster:

```
snakemake -s Snakefile --cluster "--mem=1000 -j 10"
```

[Previous](installation.html "1. Installation")
[Next](tutorial.html "3. Tutorial")

---

© Copyright .
Last updated on Mar 09, 2026.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).