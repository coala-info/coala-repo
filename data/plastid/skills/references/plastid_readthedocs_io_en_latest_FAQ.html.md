[plastid](index.html)

latest

Getting started

* [Getting started](quickstart.html)
* [Tour](tour.html)
* [Installation](installation.html)
* [Demo dataset](test_dataset.html)
* [List of command-line scripts](scriptlist.html)

User manual

* [Tutorials](examples.html)
* [Module documentation](generated/plastid.html)
* Frequently asked questions
  + [Installation and runtime](#installation-and-runtime)
    - [Installation fails in pip with no obvious error message](#installation-fails-in-pip-with-no-obvious-error-message)
    - [Error messages about numpy or pysam arise during install or runtime](#error-messages-about-numpy-or-pysam-arise-during-install-or-runtime)
    - [Locale error when installing or running `plastid` on OSX](#locale-error-when-installing-or-running-plastid-on-osx)
    - [Install fails on OSX with error code 1](#install-fails-on-osx-with-error-code-1)
    - [`command not found`: I can’t run any of the command line scripts](#command-not-found-i-can-t-run-any-of-the-command-line-scripts)
    - [A script won’t run, reporting error: too few arguments](#a-script-won-t-run-reporting-error-too-few-arguments)
    - [I get an `ImportError` or `DistributionError` when using `plastid`](#i-get-an-importerror-or-distributionerror-when-using-plastid)
  + [Analysis](#analysis)
    - [Can I use `plastid` with reverse-complemented sequencing data, like dUTP sequencing?](#can-i-use-plastid-with-reverse-complemented-sequencing-data-like-dutp-sequencing)
    - [Can `plastid` be used with paired-end data?](#can-plastid-be-used-with-paired-end-data)
    - [The P-site and/or Metagene scripts show few or zero read in their output](#the-p-site-and-or-metagene-scripts-show-few-or-zero-read-in-their-output)
    - [`cs`, `counts_in_region`, or some other part of `plastid` reports zero counts for my gene, even though there are read alignments there](#cs-counts-in-region-or-some-other-part-of-plastid-reports-zero-counts-for-my-gene-even-though-there-are-read-alignments-there)
    - [Why do some scripts report fractional count numbers?](#why-do-some-scripts-report-fractional-count-numbers)
    - [Why does IGV report higher coverage at a given nucleotide than the file exported from `make_wiggle`?](#why-does-igv-report-higher-coverage-at-a-given-nucleotide-than-the-file-exported-from-make-wiggle)
    - [What are the differences between `counts_in_region` and `cs`?](#what-are-the-differences-between-counts-in-region-and-cs)
    - [Why does `SegmentChain.as_gff3()` sometimes throw errors?](#why-does-segmentchain-as-gff3-sometimes-throw-errors)
    - [How do I prepare data for differential gene expression analysis in DESeq?](#how-do-i-prepare-data-for-differential-gene-expression-analysis-in-deseq)
  + [Tests](#tests)
    - [The tests won’t run](#the-tests-won-t-run)
* [Glossary of terms](glossary.html)
* [References](zreferences.html)

Developer info

* [Contributing](devinfo/contributing.html)
* [Entrypoints](devinfo/entrypoints.html)

Other information

* [Citing `plastid`](citing.html)
* [License](license.html)
* [Change log](CHANGES.html)
* [Related resources](related.html)
* [Contact](contact.html)

[plastid](index.html)

* »
* Frequently asked questions
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/FAQ.rst)

---

# Frequently asked questions[¶](#frequently-asked-questions "Permalink to this headline")

FAQ contents

* [Installation and runtime](#installation-and-runtime)

  + [Installation fails in pip with no obvious error message](#installation-fails-in-pip-with-no-obvious-error-message)
  + [Error messages about numpy or pysam arise during install or runtime](#error-messages-about-numpy-or-pysam-arise-during-install-or-runtime)
  + [Locale error when installing or running `plastid` on OSX](#locale-error-when-installing-or-running-plastid-on-osx)
  + [Install fails on OSX with error code 1](#install-fails-on-osx-with-error-code-1)
  + [`command not found`: I can’t run any of the command line scripts](#command-not-found-i-can-t-run-any-of-the-command-line-scripts)
  + [A script won’t run, reporting error: too few arguments](#a-script-won-t-run-reporting-error-too-few-arguments)
  + [I get an `ImportError` or `DistributionError` when using [`plastid`](generated/plastid.html#module-plastid "plastid")](#i-get-an-importerror-or-distributionerror-when-using-plastid)
* [Analysis](#analysis)

  + [Can I use `plastid` with reverse-complemented sequencing data, like dUTP sequencing?](#can-i-use-plastid-with-reverse-complemented-sequencing-data-like-dutp-sequencing)
  + [Can `plastid` be used with paired-end data?](#can-plastid-be-used-with-paired-end-data)
  + [The P-site and/or Metagene scripts show few or zero read in their output](#the-p-site-and-or-metagene-scripts-show-few-or-zero-read-in-their-output)
  + [`cs`, `counts_in_region`, or some other part of `plastid` reports zero counts for my gene, even though there are read alignments there](#cs-counts-in-region-or-some-other-part-of-plastid-reports-zero-counts-for-my-gene-even-though-there-are-read-alignments-there)
  + [Why do some scripts report fractional count numbers?](#why-do-some-scripts-report-fractional-count-numbers)
  + [Why does IGV report higher coverage at a given nucleotide than the file exported from `make_wiggle`?](#why-does-igv-report-higher-coverage-at-a-given-nucleotide-than-the-file-exported-from-make-wiggle)
  + [What are the differences between `counts_in_region` and `cs`?](#what-are-the-differences-between-counts-in-region-and-cs)
  + [Why does `SegmentChain.as_gff3()` sometimes throw errors?](#why-does-segmentchain-as-gff3-sometimes-throw-errors)
  + [How do I prepare data for differential gene expression analysis in DESeq?](#how-do-i-prepare-data-for-differential-gene-expression-analysis-in-deseq)
* [Tests](#tests)

  + [The tests won’t run](#the-tests-won-t-run)

## [Installation and runtime](#id1)[¶](#installation-and-runtime "Permalink to this headline")

### [Installation fails in pip with no obvious error message](#id2)[¶](#installation-fails-in-pip-with-no-obvious-error-message "Permalink to this headline")

Installation can fail for multiple reasons. To figure out what is responsible,
repeat installation passing the `--verbose` flag to `pip`:

```
$ pip install --no-cache-dir --verbose plastid | tee 2>&1 plastid_install_log.txt
```

Then find the corresponding error message below. If the error is not listed,
let us know by filing a bug report at [our issue tracker](https://github.com/joshuagryphon/plastid/issues). Please attach
plastid\_install\_log.txt to your report to help us figure out what is going
on.

If you need to get to work quickly, try installing in a vanilla environment in a
fresh [virtualenv](https://virtualenv.pypa.io/en/latest/) . See instructions at [Install inside a virtualenv](installation.html#install-inside-venv).

### Error messages about [numpy](http://docs.scipy.org/doc/numpy/reference/) or [pysam](http://pysam.readthedocs.io/en/latest/) arise during install or runtime[¶](#error-messages-about-numpy-or-pysam-arise-during-install-or-runtime "Permalink to this headline")

If odd installation or runtime bugs arise that mention [numpy](http://docs.scipy.org/doc/numpy/reference/) or [pysam](http://pysam.readthedocs.io/en/latest/),
then there may be multiple versions of these libraries installed on your system,
with [`plastid`](generated/plastid.html#module-plastid "plastid") having been linked against versions different from those in
your runtime environment. A solution is to install inside a vanilla environment
in a fresh [virtualenv](https://virtualenv.pypa.io/en/latest/), or to use BioConda. See instructions for either in
[Installation](installation.html)

If install succeeds in a [virtualenv](https://virtualenv.pypa.io/en/latest/), this suggests that there are in fact
multiple versions of one or more of plastid’s dependencies installed on your
system. In this case, `plastid` can be used inside the [virtualenv](https://virtualenv.pypa.io/en/latest/). or
BioConda environment.

### [Locale error when installing or running `plastid` on OSX](#id4)[¶](#locale-error-when-installing-or-running-plastid-on-osx "Permalink to this headline")

This is known to occur on OSX. In this case, you should see a stack trace ending
with something like:

```
from docutils.utils.error_reporting import locale_encoding, ErrorString, ErrorOutput
  File "/Applications/anaconda/lib/python2.7/site-packages/docutils/utils/error_reporting.py", line 47, in <module>
    locale_encoding = locale.getlocale()[1] or locale.getdefaultlocale()[1]
  File "/Applications/anaconda/lib/python2.7/locale.py", line 543, in getdefaultlocale
    return _parse_localename(localename)
  File "/Applications/anaconda/lib/python2.7/locale.py", line 475, in _parse_localename
    raise ValueError, 'unknown locale: %s' % localename
ValueError: unknown locale: UTF-8
```

Please see the workaround
[here](http://blog.remibergsma.com/2012/07/10/setting-locales-correctly-on-mac-osx-terminal-application/).

### [Install fails on OSX with error code 1](#id5)[¶](#install-fails-on-osx-with-error-code-1 "Permalink to this headline")

If installing on OSX and you find an error message that resembles the following:

```
Command "/usr/local/opt/python/bin/python2.7 -c "import setuptools, tokenize;\
__file__='/private/var/folders/8y/xm0qbq655f1d4v20kq5vvfgm0000gq/T/pip-build-0bVdPy/pysam/setup.py';\
exec(compile(getattr(tokenize, 'open', open)(__file__).read().replace('\r\n', '\n'), __file__, 'exec'))"\

 install --record /var/folders/some-folder/install-record.txt --single-version-externally-managed \
         --compile --user --prefix=" failed with error code 1 in /private/var/folders/some-folder/pysam
```

Before installing, type:

```
$ export CFLAGS=-Qunused-arguments
$ export CPPFLAGS=-Qunused-arguments
```

and then retry.

### [`command not found`: I can’t run any of the command line scripts](#id6)[¶](#command-not-found-i-can-t-run-any-of-the-command-line-scripts "Permalink to this headline")

If you receive a command not found error from the shell, the folder containing
the command-line scripts might not be in your environment’s `PATH` variable.

Command-line scripts will be installed wherever your system configuration
dictates. On OSX and many varities of linux, the install path for a single-user
install is `~/bin` or `~/.local/bin`. For system-wide installs, the path is
typically `/usr/local/bin`. Make sure the appropriate location is in your
`PATH` by the following line adding to your `.bashrc`, `.bash_profile`, or
`.profile` (depending on which your system uses):

```
export PATH=~/bin:~/.local.bin:/usr/local/bin:$PATH
```

### [A script won’t run, reporting error: too few arguments](#id7)[¶](#a-script-won-t-run-reporting-error-too-few-arguments "Permalink to this headline")

If you see the following error:

```
<script name>: error: too few arguments
```

Try re-ordering the script arguments, so that all of the required arguments
(the ones that don’t start with `-`) come first. For example, change:

```
$ cs count --fiveprime --offset 13 --min_length 23 --max_length 35 \
           --count_files ../some_file.bam some_file.positions some_sample_name
```

to

```
$ cs count some_file.positions some_sample_name \
           --fiveprime --offset 13 --min_length 23 --max_length 35 \
           --count_files ../some_file.bam
```

Alternatively, put a `--` before the required options:

```
$ cs count --fiveprime --offset 13 --min_length 23 --max_length 35 \
           --count_files ../some_file.bam \
           -- some_file.positions some_sample_name
```

Things should then run.

### [I get an `ImportError` or `DistributionError` when using [`plastid`](generated/plastid.html#module-plastid "plastid")](#id8)[¶](#i-get-an-importerror-or-distributionerror-when-using-plastid "Permalink to this headline")

If you get an error like the following:

```
Traceback (most recent call last):
   File "/home/user/Rib_prof/venv/bin/crossmap", line 5, in <module>
     from pkg_resources import load_entry_point
   File "/home/user/Rib_prof/venv/lib/python2.7/site-packages/pkg_resources/__init__.py", line 2970, in <module>
     working_set = WorkingSet._build_master()
   File "/home/user/Rib_prof/venv/lib/python2.7/site-packages/pkg_resources/__init__.py", line 567, in _build_master
     ws.require(__requires__)
   File "/home/user/Rib_prof/venv/lib/python2.7/site-packages/pkg_resources/__init__.py", line 876, in require
     needed = self.resolve(parse_requirements(requirements))
   File "/home/user/Rib_prof/venv/lib/python2.7/site-packages/pkg_resources/__init__.py", line 761, in resolve
     raise DistributionNotFound(req)
 pkg_resources.DistributionNotFound: scipy>=0.12.0
```

One or more dependencies (in this example, [SciPy](http://docs.scipy.org/doc/scipy/reference/) is not installed).
Please reinstall.

---

## [Analysis](#id9)[¶](#analysis "Permalink to this headline")

### [Can I use `plastid` with reverse-complemented sequencing data, like dUTP sequencing?](#id10)[¶](#can-i-use-plastid-with-reverse-complemented-sequencing-data-like-dutp-sequencing "Permalink to this headline")

Yes.

Kits like Illumina’s [Truseq Stranded mRNA Library Prep Kit](http://www.illumina.com/products/truseq_stranded_mrna_library_prep_kit.html),
yield reads that are anti-sense to the mRNA from which they were generated, so
the data coming off the sequencer will be reverse-complemented compared to the
original strand that was cloned.

To use this data in [`plastid`](generated/plastid.html#module-plastid "plastid"), reverse-complement your FASTQ file using the
[fastx\_reverse\_complement](http://hannonlab.cshl.edu/fastx_toolkit/commandline.html#fastx_revcomp_usage)
tool from the Hanon lab’s [fastx toolkit](http://hannonlab.cshl.edu/fastx_toolkit/). Then align the reverse-complemented
data using your favorite aligner.

### [Can `plastid` be used with paired-end data?](#id11)[¶](#can-plastid-be-used-with-paired-end-data "Permalink to this headline")

Yes, but two points:

* Because there are few nucleotide-resolution assays that used paried-end
  sequencing, it has been unclear what sorts of mapping functions might be useful.

  If you have a suggestion for one, please submit your suggestion with a use
  case on [our issue tracker](https://github.com/joshuagryphon/plastid/issues). It would be helpful!
* For simple gene expression counting, it is possible to use the
  `--fiveprime` (implemented in
  `FivePrimeMapFactory`) mapping function
  with zero offset. Accuracy can be improved by counting a single read from
  each pair in which both reads are mapped.

  However, it is critical to retain the read that appears on the same strand as
  the gene from which it arose.

  If the library was prepared using dUTP chemistry, as in many paired-end prep
  kits, select read2 from each pair using `samtools`:

  ```
  $ samtools view  -f 129 -b -o single_from_pair.bam paired_end_file.bam
  ```