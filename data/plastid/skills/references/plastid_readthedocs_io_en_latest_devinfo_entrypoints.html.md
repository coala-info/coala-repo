[plastid](../index.html)

latest

Getting started

* [Getting started](../quickstart.html)
* [Tour](../tour.html)
* [Installation](../installation.html)
* [Demo dataset](../test_dataset.html)
* [List of command-line scripts](../scriptlist.html)

User manual

* [Tutorials](../examples.html)
* [Module documentation](../generated/plastid.html)
* [Frequently asked questions](../FAQ.html)
* [Glossary of terms](../glossary.html)
* [References](../zreferences.html)

Developer info

* [Contributing](contributing.html)
* Entrypoints
  + [Setting up the folder](#setting-up-the-folder)
  + [Writing command-line options for mapping rules](#writing-command-line-options-for-mapping-rules)
    - [Mapping rules](#mapping-rules)
    - [Additional parameters for mapping rules](#additional-parameters-for-mapping-rules)
  + [Writing `setup.py`](#writing-setup-py)
  + [Installing the new mapping rules](#installing-the-new-mapping-rules)
  + [See also](#see-also)

Other information

* [Citing `plastid`](../citing.html)
* [License](../license.html)
* [Change log](../CHANGES.html)
* [Related resources](../related.html)
* [Contact](../contact.html)

[plastid](../index.html)

* »
* Extending plastid
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/devinfo/entrypoints.rst)

---

# Extending plastid[¶](#extending-plastid "Permalink to this headline")

Plastid defines the following entry points to enable users to write plug-in
functions that can be accessed from the command line:

> |  |  |
> | --- | --- |
> | **Entry point** | **Used for** |
> | `plastid.mapping_rules` | Adding new [mapping rules](../glossary.html#term-mapping-rule) to [`plastid`](../generated/plastid.html#module-plastid "plastid")’s command-line scripts. |
> | `plastid.mapping_options` | Adding command-line options used by new [mapping rules](../glossary.html#term-mapping-rule). |

For [`plastid`](../generated/plastid.html#module-plastid "plastid") to discover your plug-in, your plug-in must be registered
with the system. Registration requires some packaging, which isn’t too painful.
Packaging is discussed in the following sections:

* [Setting up the folder](#setting-up-the-folder)
* [Writing command-line options for mapping rules](#writing-command-line-options-for-mapping-rules)

  + [Mapping rules](#mapping-rules)
  + [Additional parameters for mapping rules](#additional-parameters-for-mapping-rules)
* [Writing `setup.py`](#writing-setup-py)
* [Installing the new mapping rules](#installing-the-new-mapping-rules)
* [See also](#see-also)

## [Setting up the folder](#id1)[¶](#setting-up-the-folder "Permalink to this headline")

First, create a folder with structure similar to the following:

```
my_project/
    setup.py
    my_project/
        __init__.py
        map_rules.py
```

Adjust the filenames to suit your project.

## [Writing command-line options for mapping rules](#id2)[¶](#writing-command-line-options-for-mapping-rules "Permalink to this headline")

### [Mapping rules](#id3)[¶](#mapping-rules "Permalink to this headline")

We assume you have written mapping rules as described in
[Writing new mapping functions](../concepts/mapping_rules.html#mapping-rules-roll-your-own). [`plastid`](../generated/plastid.html#module-plastid "plastid") needs some metadata
to use them. This is specified in a dictionary that defines at least
bamfunc or bowtiefunc. All of the remaining keys are optional:

> |  |  |  |
> | --- | --- | --- |
> | **Key** | **Value type** | **Value** |
> | name | str | Overrides the command-line name of mapping rule defined in `setup.py`. I.e. - the flag `--name` will be the command-line argument that invokes the rule  Must not contain spaces, dashes, or special characters. Underscores are o |
> | bamfunc | Function | Mapping function for alignments in [BAM](http://samtools.github.io/hts-specs/) format |
> | bowtiefunc | Function | Mapping function for alignments in [bowtie](http://bowtie-bio.sourceforge.net/manual.shtml) format |
> | help | str | Command-line help for the mapping function. Should describe what the function does, and which command-line arguments affect its behavior (e.g. `--offset`, `--nibble` or something added in [Additional parameters for mapping rules](#entrypoints-parameters)) |

If bowtiefunc or bamfunc are unspecified or set to None,
[`plastid`](../generated/plastid.html#module-plastid "plastid") will assume the mapping function is not implemented
for the corresponding type. Typically, users would only write
a function for mapping [BAM](http://samtools.github.io/hts-specs/) files.

We’ll suppose that all of our functions are specified in `my_project/map_rules.py`
as described [above](#entrypoints-folder). The contents of `map_rules.py`
might then look something like this:

```
#!/usr/bin/env python

def rule1_for_bowtie_files(alignment,args=None):
    # calculate position(s) where a single aliignment maps
    # and the value to place at each position
    #
    # the parsed command-line arguments will be passed
    # as an argparse.Namespace object
    ...

    return position_value_tuples

def rule1_for_BAM_files(alignments,segment,args=args):
    # calculate positions where a list of alignments map,
    # and a vector of values at each position
    #
    # again, args is an argparse.Namespace object
    # from the command-line args
    ...

    return reads_out, count_array

def rule2_for_BAM_files_only(alignments,segment,args=args):
    # calculate positions where a list of alignments map,
    # and a vector of values at each position
    ...

    # do something with a command-line argument
    my_option = args.new_option
    if my_option == "":
        pass

    return reads_out, count_array

rule1_info = {
    "name"       : 'rule1',
    "bamfunc"    : rule1_for_BAM_files,
    "bowtiefunc" : rule1_for_bowtie_files,
    "help"       : "Some help text for rule 1."
}

rule2_info = {
    "name"       : 'rule2',
    "bamfunc"    : rule2_for_BAM_files_only,
    "help"       : "Some help text. Rule 2's behavior is modified by the option `--new_option`"
}
```

rule1 is defined for both [BAM](http://samtools.github.io/hts-specs/) and [bowtie](http://bowtie-bio.sourceforge.net/manual.shtml) files. rule2 is defined
only for [BAM](http://samtools.github.io/hts-specs/) files, and it uses the command-line option `--new_option`,
which we define below in [Additional parameters for mapping rules](#entrypoints-parameters).

### [Additional parameters for mapping rules](#id4)[¶](#additional-parameters-for-mapping-rules "Permalink to this headline")

Additional command-line parameters are also specified as dictionaries.
In these, the keys and values can be any valid parameters for
[`argparse.ArgumentParser.add_argument()`](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser.add_argument "(in Python v3.10)"). Each dictionary should
additionally define a key called name, whose value will be used as
the name of the command-line argument. For example, we might add
the following lines to `my_project/map_rules.py`:

```
param1 = {
    "name"  : "new_option",
    "type"  : int,
    "nargs" : 2,
    "help"  : "Some help text for --new_option",
    "metavar" : "N",
}
```

That’s it!

## [Writing `setup.py`](#id5)[¶](#writing-setup-py "Permalink to this headline")

Having written the mapping functions and made dictionaries describing them,
we need to write package metadata so that [`plastid`](../generated/plastid.html#module-plastid "plastid") can find the new
functions. All of this information goes into `setup.py`.

`setup.py` should everything needed to set up and install your package.
For more information see the documentation for `setuptools` and / or
[`distutils`](https://docs.python.org/3/library/distutils.html#module-distutils "(in Python v3.10)"). `setup.py` should minimally contain the following:

```
#/usr/bin/env python
from setuptools import setup, find_packages

# list all the rules we want to include
# syntax is:
#
#    rule_name = path.to.rule:rule_info_dictionary"
#
#
rules = [
    "rule1 = my_project.rules:rule1_info",
    "rule2 = my_project.rules:rule2_info",
]

# list any extra arguments we want to include
# syntax is:
#
#    argument_name = path.to.rule:arg_info_dictionary"
#
#
rule_options = [
    "new_option = my_project.rules:param1",
]

setup(
    # root level name of package
    name = "my_project",

    # tell setup() that `rules` and `rule_options` specify mapping
    # ruls and arguments for plastid:
    entry_points = {
        "plastid.mapping_rules"   : rules,
        "plastid.mapping_options" : rule_options,
    },

    setup_requires = ['plastid>=0.4.4'],
    packages = find_packages(),

    # plus any other arguments (e.g. package author, description)
    # to ``setup``.

)
```

That’s the last piece.

## [Installing the new mapping rules](#id6)[¶](#installing-the-new-mapping-rules "Permalink to this headline")

Installation is the final step. Enter the folder containing `setup.py`.
Then, to install your new mapping rules, type:

```
$ python setup.py install [--user]
```

Or, if you plan to keep developing your [mapping rules](../glossary.html#term-mapping-rule),
and want [`plastid`](../generated/plastid.html#module-plastid "plastid") to be aware of these changes instantly:

```
$ python setup.py develop --user
```

To test your installation, check command-line help from a script that uses
mapping rules (e.g. `make_wiggle`):

```
$ make-wiggle --help
```

If the installation proceeded correctly you should see something like this:

```
# rest of command line help above

alignment mapping options (BAM & bowtie files only):
  For BAM or bowtie files, one of the mutually exclusive read mapping choices
  is required:

  --fiveprime_variable  Map read alignment to a variable offset from 5'
                        position of read, with offset determined by read
                        length. Requires `--offset` below
  --fiveprime           Map read alignment to 5' position.
  --threeprime          Map read alignment to 3' position
  --center              Subtract N positions from each end of read, and add
                        1/(length-N), to each remaining position, where N is
                        specified by `--nibble`
  --rule2               Some help text. Rule 2's behavior is modified by the
                        option `--new_option`
  --rule1               Some help text for rule 1.

  The remaining arguments are optional and affect the behavior of specific
  mapping rules:

  --offset OFFSET       For `--fiveprime` or `--threeprime`, provide an
                        integer representing the offset into the read,
                        starting from either the 5' or 3' end, at which data
                        should be plotted. For `--fiveprime_variable`, provide
                        the filename of a two-column tab-delimited text file,
                        in which first column represents read length or the
                        special keyword `'default'`, and the second column
                        represents the offset from the five prime end of that
                        read length at which the read should be mapped.
  --nibble N            For use with `--center` only. nt to remove from each
                        end of read before mapping (Default: 0)
  --new_option N N      Some help text for --new_option

 # remaining command-line help below
```

If the new mapping rule and command-line arguments are listed, you are ready.

---

## [See also](#id7)[¶](#see-also "Permalink to this headline")

> * [Read mapping functions](../concepts/mapping_rules.html) for information on how to write
>   [mapping rules](../glossary.html#term-mapping-rule)
> * [`argparse`](https://docs.python.org/3/library/argparse.html#module-argparse "(in Python v3.10)") documentation for information on command-line arguments
> * Documentation for `setuptools` and [`distutils`](https://docs.python.org/3/library/distutils.html#module-distutils "(in Python v3.10)") for more information
>   on packaging

[Previous](contributing.html "Contributing")
[Next](../citing.html "Citing plastid")

---

© Copyright 2014-2022, Joshua G. Dunn.
Revision `d97f239d`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).