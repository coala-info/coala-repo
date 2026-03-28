[chemfp.com](https://chemfp.com/)

[chemfp documentation](index.html)

* [Installing chemfp](installing.html)
* [Command-line examples for binary fingerprints](tools.html)
* [Command-line examples for sparse count fingerprints](count_tools.html)
* [The chemfp command-line tools](tool_help.html)
* [Getting started with the API](getting_started_api.html)
* [Fingerprint family and type examples](fingerprint_types.html)
* Toolkit API examples
  + [Get a chemfp toolkit](#get-a-chemfp-toolkit)
  + [Parse and create SMILES](#parse-and-create-smiles)
  + [Canonical, non-isomeric, and arbitrary SMILES](#canonical-non-isomeric-and-arbitrary-smiles)
  + [Use *format* to create a record in SDF format](#use-format-to-create-a-record-in-sdf-format)
  + [Use zlib record compression](#use-zlib-record-compression)
  + [Use zst record compression](#use-zst-record-compression)
  + [Get a list of available formats and distinguish between input and output formats](#get-a-list-of-available-formats-and-distinguish-between-input-and-output-formats)
  + [Determine the format for a given filename](#determine-the-format-for-a-given-filename)
  + [Parse the id and the molecule at the same time](#parse-the-id-and-the-molecule-at-the-same-time)
  + [Specify alternate error behavior](#specify-alternate-error-behavior)
  + [Specify a SMILES delimiter through reader\_args](#specify-a-smiles-delimiter-through-reader-args)
  + [Specify an output SMILES delimiter through writer\_args](#specify-an-output-smiles-delimiter-through-writer-args)
  + [RDKit-specific SMILES reader\_args and writer\_args](#rdkit-specific-smiles-reader-args-and-writer-args)
  + [OpenEye-specific SMILES reader\_args and writer\_args](#openeye-specific-smiles-reader-args-and-writer-args)
  + [OpenEye-specific aromaticity](#openeye-specific-aromaticity)
  + [Open Babel-specific SMILES reader\_args and writer\_args](#open-babel-specific-smiles-reader-args-and-writer-args)
  + [CDK-specific SMILES reader\_args and writer\_args](#cdk-specific-smiles-reader-args-and-writer-args)
  + [Get the default reader\_args or writer\_args for a format](#get-the-default-reader-args-or-writer-args-for-a-format)
  + [Convert text settings into reader and writer arguments](#convert-text-settings-into-reader-and-writer-arguments)
  + [Multi-toolkit reader\_args and writer\_args](#multi-toolkit-reader-args-and-writer-args)
  + [Qualified reader and writer parameters names](#qualified-reader-and-writer-parameters-names)
  + [Qualified parameter priorities](#qualified-parameter-priorities)
  + [Qualified names and text settings](#qualified-names-and-text-settings)
  + [Read molecules from an SD file or stdin](#read-molecules-from-an-sd-file-or-stdin)
  + [Read ids and molecules from an SD file at the same time](#read-ids-and-molecules-from-an-sd-file-at-the-same-time)
  + [Read ids and molecules using an SD tag for the id](#read-ids-and-molecules-using-an-sd-tag-for-the-id)
  + [Read from a string instead of a file](#read-from-a-string-instead-of-a-file)
  + [The reader may reuse molecule objects!](#the-reader-may-reuse-molecule-objects)
  + [Write molecules to a SMILES file](#write-molecules-to-a-smiles-file)
  + [Reader and writer context managers](#reader-and-writer-context-managers)
  + [Write molecules to stdout in a specified format](#write-molecules-to-stdout-in-a-specified-format)
  + [Write molecules to a string (and a bit of InChI)](#write-molecules-to-a-string-and-a-bit-of-inchi)
  + [Handling errors when reading molecules from a string](#handling-errors-when-reading-molecules-from-a-string)
  + [Handling errors when reading molecules from a file](#handling-errors-when-reading-molecules-from-a-file)
  + [Ignore errors in create\_string() and create\_bytes()](#ignore-errors-in-create-string-and-create-bytes)
  + [Ignore errors when writing molecules](#ignore-errors-when-writing-molecules)
  + [Reader and writer format metadata](#reader-and-writer-format-metadata)
  + [Location information: filename, record\_format, recno and output\_recno](#location-information-filename-record-format-recno-and-output-recno)
  + [Location information: record position and content](#location-information-record-position-and-content)
  + [Writing your own error handler (Advanced)](#writing-your-own-error-handler-advanced)
  + [A Babel-like structure format converter](#a-babel-like-structure-format-converter)
  + [argparse text settings to reader and writer args](#argparse-text-settings-to-reader-and-writer-args)
    - [How to get from the command-line to reader and writer arguments](#how-to-get-from-the-command-line-to-reader-and-writer-arguments)
    - [Converter with -R and -W support](#converter-with-r-and-w-support)
    - [List the reader and writer arguments for the given formats](#list-the-reader-and-writer-arguments-for-the-given-formats)
  + [Creating a specialized record parser](#creating-a-specialized-record-parser)
  + [Molecule API: Get and set the molecule id](#molecule-api-get-and-set-the-molecule-id)
  + [Molecule API: Copy a molecule](#molecule-api-copy-a-molecule)
  + [Molecule API: Working with SD tags](#molecule-api-working-with-sd-tags)
  + [Add fingerprints to an SD file using a toolkit](#add-fingerprints-to-an-sd-file-using-a-toolkit)
* [Text toolkit examples](text_toolkit.html)
* [chemfp API](chemfp_api.html)
* [Licenses](licenses.html)
* [What’s new in chemfp 5.1](whats_new_in_51.html)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* Toolkit API examples

---

# Toolkit API examples[](#toolkit-api-examples "Link to this heading")

This chapter gives many examples of how to use the toolkit API. For an
overview of the toolkit API functions, see [`chemfp.toolkit`](chemfp_toolkit.html#module-chemfp.toolkit "chemfp.toolkit"). For
details about actual toolkit implementations, see
[`chemfp.cdk_toolkit`](chemfp_cdk_toolkit.html#module-chemfp.cdk_toolkit "chemfp.cdk_toolkit"),
[`chemfp.openeye_toolkit`](chemfp_openeye_toolkit.html#module-chemfp.openeye_toolkit "chemfp.openeye_toolkit"), [`chemfp.openbabel_toolkit`](chemfp_openbabel_toolkit.html#module-chemfp.openbabel_toolkit "chemfp.openbabel_toolkit"),
[`chemfp.rdkit_toolkit`](chemfp_rdkit_toolkit.html#module-chemfp.rdkit_toolkit "chemfp.rdkit_toolkit"), and [`chemfp.text_toolkit`](chemfp_text_toolkit.html#module-chemfp.text_toolkit "chemfp.text_toolkit").

Fingerprint search usually starts with a structure record, and not a
fingerprint. The functions
[`chemfp.read_molecule_fingerprints()`](chemfp_toplevel.html#chemfp.read_molecule_fingerprints "chemfp.read_molecule_fingerprints") and
[`chemfp.read_molecule_fingerprints_from_string()`](chemfp_toplevel.html#chemfp.read_molecule_fingerprints_from_string "chemfp.read_molecule_fingerprints_from_string") give a
quick way to read a file or string containing structure records as the
corresponding fingerprints.

Sometimes you want more control over the process. You might want to
generate multiple fingerprints for the same structure and not want to
reparse the structure record multiple times. Or you might want to
return the search results as extra fields to the query SDF record
instead of a simple list of values.

Chemfp uses a third-party chemistry toolkit to parse the records into
a molecule, or compute the fingerprint for a given molecule. It’s not
hard to write your own Open Babel, OEChem/OEGraphSim, or RDKit code to
handle any of these or similar tasks. The problem comes in when you
want to mix multiple fingerprint types, like to compare the default
RDKit fingerprint to Open Babel’s FP2 fingerprint. You end up writing
very different code for essentially the same fingerprint task.

There’s an old saying in computer science; all problems can be solved
with another layer of indirection. The chemfp toolkit API follows that
tradition. It’s a common API for molecule I/O which works across the
four supported toolkits. It’s also my best effort at implementing a
next generation API.

Bear in mind that it is only an *I/O* API. Chemfp is a fingerprint
toolkit and it does not have a common molecule API. For that, look
toward [Cinfony](http://code.google.com/p/cinfony/).

## Get a chemfp toolkit[](#get-a-chemfp-toolkit "Link to this heading")

In this section you’ll learn how to load a “toolkit” – a portable API
layer above the actual chemistry toolkit – and how to check if a
toolkit is available and has a valid license.

Each toolkit I/O adapter is implemented as a chemfp submodule. If you
know the underlying chemistry toolkit is installed you can import the
adapter directly:

```
>>> from chemfp import openbabel_toolkit
>>> from chemfp import openeye_toolkit
>>> from chemfp import rdkit_toolkit
>>> from chemfp import cdk_toolkit
```

Use [`chemfp.get_toolkit_names()`](chemfp_toplevel.html#chemfp.get_toolkit_names "chemfp.get_toolkit_names") to get the available toolkit
names:

```
>>> chemfp.get_toolkit_names()
set(['cdk', 'openbabel', 'openeye', 'rdkit'])
```

This will try to import each module, which means it may take a second
or more depending on the shared library load time for your
system. (This overhead only occurs once.) The function returns a list
of the modules that could be loaded and have a valid license.

You can use [`chemfp.get_toolkit()`](chemfp_toplevel.html#chemfp.get_toolkit "chemfp.get_toolkit") to get the correct toolkit
module given a name; it raises a ValueError if the underlying toolkit
isn’t installed or the toolkit name is unknown:

```
>>> chemfp.get_toolkit("rdkit")
<module 'chemfp.rdkit_toolkit' from 'chemfp/rdkit_toolkit.py'>
>>> chemfp.get_toolkit("openeye")
<module 'chemfp.openeye_toolkit' from 'chemfp/openeye_toolkit.py'>
>>> chemfp.get_toolkit("openbabel")
<module 'chemfp.openbabel_toolkit' from 'chemfp/openbabel_toolkit.py'>
>>> chemfp.get_toolkit("cdk")
<module 'chemfp.cdk_toolkit' from 'chemfp/cdk_toolkit.py'>
```

Existence isn’t enough to know if you can use a toolkit. OEChem
requires a license. Each I/O adapter implements
[`chemfp.toolkit.is_licensed()`](chemfp_toolkit.html#chemfp.toolkit.is_licensed "chemfp.toolkit.is_licensed"). It returns True for Open Babel and
RDKit and the value of OEChemIsLicensed() for OEChem:

```
>>> for name in chemfp.get_toolkit_names():
...   T = chemfp.get_toolkit(name)
...   print(f"Toolkit {T.name!r} ({T.software}) is licensed? {T.is_licensed()}")
...
Toolkit 'cdk' (CDK/2.8) is licensed? True
Toolkit 'openbabel' (OpenBabel/3.1.0) is licensed? True
Toolkit 'openeye' (OEChem/20220607) is licensed? True
Toolkit 'rdkit' (RDKit/2021.09.4) is licensed? True
```

(Thanks OpenEye for an no-cost developer license to their toolkit!
Thanks to the Open Babel, RDKit, and CDK developers for an open source
license to their toolkits!)

There is currently no way to check if OEGraphSim is licensed; you’ll
need to use native OpenEye code instead.

For fun I also showed the `software` attribute, which gives more
detailed information about the toolkit version in a standardized
format.

There is still another way to get access to the toolkit modules. The
special objects [`chemfp.rdkit`](chemfp_toplevel.html#chemfp.rdkit "chemfp.rdkit"), [`chemfp.cdk`](chemfp_toplevel.html#chemfp.cdk "chemfp.cdk"),
[`chemfp.openeye`](chemfp_toplevel.html#chemfp.openeye "chemfp.openeye"), [`chemfp.openbabel`](chemfp_toplevel.html#chemfp.openbabel "chemfp.openbabel") will automatically
import and redirect to the underlying module, without need for an
explicit import:

```
>>> chemfp.rdkit.morgan2.from_smiles("CCO")[:8]
b'\x00\x00\x00\x00\x00\x00\x00\x00'
>>> chemfp.cdk.pubchem.from_smiles("CCO")[:8]
b'\x00\x02\x04\x00\x00\x00\x00\x00'
>>> chemfp.openeye.tree.from_smiles("CCO")[:8]
b'\x00\x00\x00\x00\x00\x00\x00\x00'
>>> chemfp.openbabel.fp2.from_smiles("CCO")[:8]
b'\x00\x00\x00\x00\x00\x00\x00\x00'
```

These objects should not be imported into your module because it’s all
too easy to confuse them with the actual toolki module name. Instead,
either use `chemfp.<toolkit>` or import the actual chemfp wrapper
module.

Finally, use [`chemfp.has_toolkit()`](chemfp_toplevel.html#chemfp.has_toolkit "chemfp.has_toolkit") to check if a toolkit is
available. In the following, I used one of my local testing
environments which has OEChem installed but not the other toolkits. (I
use [venv](https://docs.python.org/3/library/venv.html) to create
and manage these virtual environments; it’s a very useful tool.):

```
>>> chemfp.has_toolkit("openeye")
True
>>> chemfp.has_toolkit("openbabel")
False
>>> chemfp.has_toolkit("rdkit")
False
>>> chemfp.has_toolkit("cdk")
False
```

The other option is to catch the ValueError raised when trying to get
an unavailable toolkit:

```
>>> chemfp.get_toolkit("openeye")
<module 'chemfp.openeye_toolkit' from 'chemfp/openeye_toolkit.py'>
  >>> chemfp.get_toolkit("cdk")
Traceback (most recent call last):
  File "chemfp/__init__.py", line 2188, in get_toolkit
    from . import cdk_toolkit as tk
  File "chemfp/cdk_toolkit.py", line 37, in <module>
    import jpype # Must install JPype so chemfp can interface to the CDK jar
    ^^^^^^^^^^^^
ModuleNotFoundError: No module named 'jpype'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "chemfp/__init__.py", line 2191, in get_toolkit
    raise ValueError("Unable to get toolkit %r: %s" % (toolkit_name, err))
ValueError: Unable to get toolkit 'cdk': No module named 'jpype'
>>>
>>> chemfp.get_toolkit("schrodinger")
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "chemfp/__init__.py", line 2199, in get_toolkit
    raise ValueError("Toolkit %r is not supported" % (toolkit_name,))
ValueError: Toolkit 'schrodinger' is not supported
```

This is a bit more complicated to do, but does have the advantage of
giving access to an error message.

## Parse and create SMILES[](#parse-and-create-smiles "Link to this heading")

In this section you’ll learn how to parse a SMILES into a molecule,
convert a molecule into a SMILES, and the difference between a SMILES
record and a SMILES string. You will need a chemistry toolkit for this
and most of the examples in this chapter.

The chemfp toolkit I/O API is the same across the different toolkits,
and examples with one will generally work with the other, except for
essential differences like the specific formats available, the
chemistry differences in how to interpret a record, the error
messages, and reader and writer arguments.

For most examples I’ll use `T` as the toolkit module name, rather
than specify a specific toolkit. My examples will be based on RDKit,
but you can use any of the following, if available on your system:

```
# Choose one of these
from chemfp import openeye_toolkit as T
from chemfp import openbabel_toolkit as T
from chemfp import rdkit_toolki