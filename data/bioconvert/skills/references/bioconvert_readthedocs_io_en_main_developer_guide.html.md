[bioconvert
![Logo](_static/logo.png)](index.html)

* [1. Installation](installation.html)
* [2. User Guide](user_guide.html)
* [3. Tutorial](tutorial.html)
* 4. Developer guide
  + [4.1. Quick start](#quick-start)
  + [4.2. Installation for developers](#installation-for-developers)
  + [4.3. How to add a new conversion](#how-to-add-a-new-conversion)
  + [4.4. One-to-many and many-to-one conversions](#one-to-many-and-many-to-one-conversions)
  + [4.5. How to add a new method to an existing converter](#how-to-add-a-new-method-to-an-existing-converter)
  + [4.6. Decorators](#decorators)
  + [4.7. How to add a test](#how-to-add-a-test)
  + [4.8. How to add a test file](#how-to-add-a-test-file)
  + [4.9. How to locally run the tests](#how-to-locally-run-the-tests)
  + [4.10. How to benchmark your new method vs others](#how-to-benchmark-your-new-method-vs-others)
  + [4.11. How to add you new converter to the main documentation ?](#how-to-add-you-new-converter-to-the-main-documentation)
  + [4.12. pep8 and conventions](#pep8-and-conventions)
  + [4.13. Requirements files](#requirements-files)
  + [4.14. How to update bioconvert on bioconda](#how-to-update-bioconvert-on-bioconda)
  + [4.15. Sphinx Documentation](#sphinx-documentation)
  + [4.16. Docker](#docker)
* [5. Benchmarking](benchmarking.html)
* [6. Gallery](auto_examples/index.html)
* [7. References](references.html)
* [8. Formats](formats.html)
* [9. Glossary](glossary.html)
* [10. Faqs](faqs.html)
* [11. Bibliography](bibliography.html)

[bioconvert](index.html)

* 4. Developer guide
* [View page source](_sources/developer_guide.rst.txt)

---

# [4. Developer guide](#id3)[](#developer-guide "Link to this heading")

Contents

* [Developer guide](#developer-guide)

  + [Quick start](#quick-start)
  + [Installation for developers](#installation-for-developers)
  + [How to add a new conversion](#how-to-add-a-new-conversion)
  + [One-to-many and many-to-one conversions](#one-to-many-and-many-to-one-conversions)
  + [How to add a new method to an existing converter](#how-to-add-a-new-method-to-an-existing-converter)
  + [Decorators](#decorators)
  + [How to add a test](#how-to-add-a-test)
  + [How to add a test file](#how-to-add-a-test-file)
  + [How to locally run the tests](#how-to-locally-run-the-tests)
  + [How to benchmark your new method vs others](#how-to-benchmark-your-new-method-vs-others)
  + [How to add you new converter to the main documentation ?](#how-to-add-you-new-converter-to-the-main-documentation)
  + [pep8 and conventions](#pep8-and-conventions)
  + [Requirements files](#requirements-files)
  + [How to update bioconvert on bioconda](#how-to-update-bioconvert-on-bioconda)
  + [Sphinx Documentation](#sphinx-documentation)
  + [Docker](#docker)

## [4.1. Quick start](#id4)[](#quick-start "Link to this heading")

As a developer, assuming you have a valid environment and installed Bioconvert ([Installation for developers](#install-dev)),
go to bioconvert directory and type the bioconvert init command for the input and output formats you wish to add (here we want to convert format A to B). You may also just copy an existing file:

```
cd bioconvert
bioconvert_init -i A -o B > A2B.py
```

see [How to add a new conversion](#add-converter) section for details. Edit the file, update the method that performs the conversion by adding the relevant code (either python or external tools). Once done, please

1. add an input test file in the ./test/data directory (see [How to add a test](#add-test))
2. add the relevant data test files in the `./bioconvert/test/data/` directory (see [How to add a test file](#add-test-file))
3. Update the documentation as explained in [How to add you new converter to the main documentation ?](#update-doc) section:

   1. add the module in doc/ref\_converters.rst in the autosummary section
   2. add the A2B in the README.rst
4. add a CI action in .github/workflows named after the conversion (A2B.yml)

Note also that a converter (a Python module, e.g., fastq2fasta) may have several methods included and it is quite straightforward to add a new method ([How to add a new method to an existing converter](#add-method)). They can later be compared thanks to our benchmarking framework.

If this is a new formats, you may also update the glossary.rst file in the documentation.

## [4.2. Installation for developers](#id5)[](#installation-for-developers "Link to this heading")

To develop on bioconvert it is highly recommended to install bioconvert in a virtualenv

```
mkdir bioconvert
cd bioconvert
python3.7 -m venv py37
source py37/bin/activate
```

And clone the bioconvert project

```
mkdir src
cd src
git clone https://github.com/bioconvert/bioconvert.git
cd  bioconvert
```

We need to install some extra requirements to run the tests or build the doc so to install these requirements

```
pip install -e . [testing]
```

Warning

The extra requirements try to install pygraphviz so you need to install graphviz on your computer.
If you running a distro based on debian you have to install libcgraph6, libgraphviz-dev and graphviz packages.

Note

You may need to install extra tools to run some conversion.
The requirements\_tools.txt file list conda extra tools

## [4.3. How to add a new conversion](#id6)[](#how-to-add-a-new-conversion "Link to this heading")

Officially, **Bioconvert** supports one-to-one conversions only (from one format to
another format). See the note here below about [One-to-many and many-to-one conversions](#multi-conversion).

Let us imagine that we want to include a new format conversion
from [FastQ](glossary.html#term-FASTQ) to [FastA](glossary.html#term-FASTA) format.

First, you need to add a new file in the `./bioconvert` directory called:

```
fastq2fasta.py
```

Please note that the name is **all in small caps** and that we concatenate the input format name, the character **2** and the output format name. Sometimes a format already includes the character 2 in its name (e.g. bz2), which may be confusing. For now, just follow the previous convention meaning duplicate the character 2 if needed (e.g., for bz2 to gz format, use bz22gz).

As for the class name, we us **all in big caps**. In the newly created file (**fastq2fasta.py**) you can (i) copy / paste the content of an existing converter (ii) use the **bioconvert\_init** executable (see later), or (iii) copy / paste the following code:

```
 1"""Convert :term:`FastQ` format to :term:`FastA` formats"""
 2from bioconvert import ConvBase
 3
 4__all__ = ["FASTQ2FASTA"]
 5
 6
 7class FASTQ2FASTA(ConvBase):
 8    """
 9
10    """
11    _default_method = "v1"
12
13    def __init__(self, infile, outfile):
14        """
15        :param str infile: information
16        :param str outfile: information
17        """
18        super().__init__(infile, outfile)
19
20    @requires(external_library="awk")
21    def _method_v1(self, *args, **kwargs):
22        # Conversion is made here.
23        # You can use self.infile and  self.outfile
24        # If you use an external command, you can use self.execute:
25        self.execute(cmd)
26
27    @requires_nothing
28    def _method_v2(self, *args, **kwargs):
29        #another method
30        pass
```

On line 1, please explain the conversion using the terms available in the [Glossary](glossary.html#glossary) (`./doc/glossary.rst` file). If not available, you may edit the glossary.rst file to add a quick description of the formats.

Warning

If the format is not already included in **Bioconvert**, you will need to update the file core/extensions.py to add the format name and its possible extensions.

On line 2, just import the common class.

On line 7, name the class after your input and output formats; again include the
character 2 between the input and output formats. Usually, we use
big caps for the formats since most format names are acronyms. If the input or
output format exists already in **Bioconvert**, please follow the existing
conventions.

On line 13, we add the constructor.

On line 21, we add a method to perform the conversion named **\_method\_v1**.
Here, the prefix **\_method\_** is compulsary: it tells **Bioconvert** that is it a possible conversion to include in the user interface. This is also where you will add your code to perform the conversion.
The suffix name (here **v1**) is the name of the conversion.
That way you can add as many conversion methods as you need (e.g. on line 28,
we implemented another method called **v2**).

Line 20 and line 27 show the decorator that tells **bioconvert** which external
tools are required. See [Decorators](#decorator) section.

Since several methods can be implemented, we need to define a default method (line 11; here **v1**).

In order to simplify the creation of new converters, you can also use the standalone **bioconvert\_init**. Example:

```
$ bioconvert_init -i fastq -o fasta > fastq2fasta.py
```

Of course, you will need to edit the file to add the conversion itself in the
appropriate method (e.g. \_method\_v1).

If you need to include extra arguments, such as a reference file, you may add extra argument, although this is not yet part of the official **Bioconvert** API. See for instance [`SAM2CRAM`](ref_converters.html#bioconvert.sam2cram.SAM2CRAM "bioconvert.sam2cram.SAM2CRAM") converter.

## [4.4. One-to-many and many-to-one conversions](#id7)[](#one-to-many-and-many-to-one-conversions "Link to this heading")

The one-to-many and many-to-one conversions are now implemented in
**Bioconvert**. We have only 2 instances so far namely class:bioconvert.fastq2fasta\_qual
and class:bioconvert.fasta\_qual2fastq. We have no instances of many-to-many
so far. The underscore character purpose is to indicate a **and** connection. So
you need QUAL *and* FASTA to create a FASTQ file.

For developers, we ask the input or output formats to be sorted alphabetically
to ease the user experience.

## [4.5. How to add a new method to an existing converter](#id8)[](#how-to-add-a-new-method-to-an-existing-converter "Link to this heading")

As shown above, use this code and add it to the relevant file in `./bioconvert`
directory:

```
def _method_UniqueName(self, *args, **kwargs):
    # from kwargs, you can use any kind of arguments.
    # threads is an example, reference, another example.
    # Your code here below
    pass
```

Then, it will be available in the class and **bioconvert**
automatically; the **bioconvert** executable should show the name of your new method in the help message.

In order to add your new method, you can add:

* Pure Python code
* Python code that relies on third-party library. If so, you may use:

  > + Python libraries available on pypi. Pleaes add the library name to the
  >   requirements.txt
  > + if the Python library requires lots of compilation and is available
  >   on bioconda, you may add the library name to the requirements\_tools.txt
  >   instead.
* Third party tools available on **bioconda** (e.g., squizz, seqtk, etc)
  that you can add to the requirements\_tools.txt
* Perl and GO code are also accepted. If so, use the self.install\_tool(NAME)
  and add a script in `./misc/install_NAME.sh`

## [4.6. Decorators](#id9)[](#decorators "Link to this heading")

[Decorators](https://en.wikipedia.org/wiki/Python_syntax_and_semantics#Decorators) have
been defined in `bioconvert/core/decorators.py` that can be used to “flag” or
“modify” conversion methods:

* `@in_gz` can be used to indicate that the method is able to transparently
  handle input files that are compressed in `.gz` format. This is done by
  adding an `in_gz` attribute (set to `True`) to the method.
* `@compressor` will wrap the method in code that handles input decompression
  from `.gz` format and output compression to `.gz`, `.bz2` or `.dsrc`.
  This automatically applies `@in_gz`.

  Example:

```
@compressor
def _method_noncompressor(self, *args, **kwargs):
    """This method does not handle compressed input or output by itself."""
    pass
# The decorator transforms the method that now handles compressed
# input and output; the method has an in_gz attribute (which is set to True)
```

* `@out_compressor` will wrap the method in code that handles output
  compression to `.gz`, `.bz2` or `.dsrc`. It is intended to be used on
  methods that already handle compressed input transparently, and therefore do
  not need the input decompression provided by `@compressor`. Typically, one
  would also apply `@in_gz` to such methods. In that case, `@in_gz` should
  be applied “on top” of `@out_compressor`. The reason is that decorators
  closest to the function are applied first, and applying another decorator on
  top of `@in_gz` would typically not preserve the `in_gz` attribute.
  Example:

```
@in_gz
@out_compressor
def _method_incompressor(self, *args, **kwargs):
    """This method already handles compressed .gz input."""
    pass
# This results in a method that handles compressed input and output
# This method is further modified to have an in_gz attribute
# (which is set to True)
```

Another **bioconvert** decorator is called **requires**.

It should be used to annotate a method with the type of tools it needs to work.

It is important to decorate all methods with the **requires** decorator so that user
interface can tell what tools are properly installed or not. You can use 4
arguments as explained in [`bioconvert.core.decorators`](ref_core.html#module-bioconvert.core.decorators "bioconvert.core.decorators"):

```
 1@requires_nothing
 2def _method_python(self, *args, **kwargs):
 3    # a pure Python code does not require extra libraries
 4    with open(self.outfile, "w") as fasta, open(self.infile, "r") as fastq:
 5         for (name, seq, _) in FASTQ2FASTA.readfq(fastq):
 6             fasta.write(">{}\n{}\n".format(name, seq))
 7
 8 @requires(python_library="mappy")
 9 def _method_mappy(self, *args, **kwargs):
10     with open(self.outfile, "w") as fasta:
11         for (name, seq, _) in fastx_read(self.infile):
12             fasta.write(">{}\n{}\n".format(name, seq))
13
14 @requires("awk")
15 def _method_awk(self, *args, **kwargs):
16     # Note1: since we use .format, we need to escape the { and } characters
17     # Note2: the \n need to be escaped for Popen to work
18     awkcmd = """awk '{{printf(">%s\\n",substr($0,2));}}' """
19     cmd = "{} {} > {}".format(awkcmd, self.infile, self.outfile)
20     self.execute(cmd)
```

On line 1, we decorate the method with the [`requires_nothing()`](ref_core.html#bioconvert.core.decorators.requires_nothing "bioconvert.core.decorators.requires_nothing") decorator because the method is implemented in Pure Python.

One line 8, we decorate the method with the [`requires()`](ref_core.html#bioconvert.core.decorators.requires "bioconvert.core.decorators.requires") decorator to inform **bioconvert** that the method relies on the external Python library called mappy.

One line 14, we decorate the method with the [`requires()`](ref_core.html#bioc