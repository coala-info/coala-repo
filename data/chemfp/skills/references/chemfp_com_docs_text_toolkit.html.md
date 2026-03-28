[chemfp.com](https://chemfp.com/)

[chemfp documentation](index.html)

* [Installing chemfp](installing.html)
* [Command-line examples for binary fingerprints](tools.html)
* [Command-line examples for sparse count fingerprints](count_tools.html)
* [The chemfp command-line tools](tool_help.html)
* [Getting started with the API](getting_started_api.html)
* [Fingerprint family and type examples](fingerprint_types.html)
* [Toolkit API examples](toolkit.html)
* Text toolkit examples
  + [Toolkits may modify the molecular structure](#toolkits-may-modify-the-molecular-structure)
  + [Toolkits may modify SDF syntax](#toolkits-may-modify-sdf-syntax)
  + [The text toolkit “molecules”](#the-text-toolkit-molecules)
  + [The text toolkit implements the toolkit API](#the-text-toolkit-implements-the-toolkit-api)
  + [Reading and adding SD tags with the text\_toolkit](#reading-and-adding-sd-tags-with-the-text-toolkit)
  + [Synchronizing readers from different toolkits through the text toolkit](#synchronizing-readers-from-different-toolkits-through-the-text-toolkit)
  + [Add multiple toolkit fingerprints to an SD file](#add-multiple-toolkit-fingerprints-to-an-sd-file)
  + [Text toolkit and SDF files](#text-toolkit-and-sdf-files)
  + [Read id and tag value pairs from an SD file](#read-id-and-tag-value-pairs-from-an-sd-file)
  + [Extract the id and atom and bond counts from an SD file](#extract-the-id-and-atom-and-bond-counts-from-an-sd-file)
    - [Records are byte strings](#records-are-byte-strings)
  + [SDF-specific parser parameters](#sdf-specific-parser-parameters)
  + [Working with SD records as strings](#working-with-sd-records-as-strings)
  + [Unicode and other character encoding](#unicode-and-other-character-encoding)
  + [Mixed encodings and raw bytes](#mixed-encodings-and-raw-bytes)
* [chemfp API](chemfp_api.html)
* [Licenses](licenses.html)
* [What’s new in chemfp 5.1](whats_new_in_51.html)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* Text toolkit examples

---

# Text toolkit examples[](#text-toolkit-examples "Link to this heading")

The text toolkit separates record parsing from chemical parsing. It
understands the basic text structure of SDF and SMILES-based files and
records, but not chemistry. It’s designed with the following use cases
in mind:

* add tag data to an input SDF record but keep everything else
  unchanged. This preserves data which might be lost by converting
  to then from a chemical toolkit molecule.
* synchronize operations between multiple toolkits; For example,
  consider a hybrid fingerprint using both OEChem and RDKit. The
  individual RDKit and OEChem SDF readers may get out of synch when
  on toolkit can’t parse a record which the other can. In that case,
  use the text toolkit to read the records then pass the record to
  the chemistry toolkit.
* extract tags from an SD file. Chemfp’s sdf2fps uses the text
  toolkit to get the id and the tag value which contains the
  fingerprint.

The text toolkit implements the chemistry toolkit API, except that
instead of real molecule objects it uses a thin wrapper around the
text for each wrapper. This chapter uses many of the concepts
developed in the chapter on [Toolkit API examples](toolkit.html#toolkit-chapter).

## Toolkits may modify the molecular structure[](#toolkits-may-modify-the-molecular-structure "Link to this heading")

In this section you’ll learn that a chemistry toolkit might change
details of a structure record so the input record and output record
have some differences, even though the molecular “essence” is
preserved. This is meant as an example for why you might not want to
work through a chemistry toolkit molecule for everything.

The section [Add fingerprints to an SD file using a toolkit](toolkit.html#add-fingerprint-as-sd-tag) gave an example of using
a toolkit to read an SD file, compute a MACCS fingerprint, add the
fingerprint as a new SD tag, and save the result to a new SD
file. This is a very common task.

A problem is that toolkits can apply various normalizations, like
aromaticity perception, which change atom and bond aromaticity
assignments. RDKit by default will also convert explicit hydrogens
into implicit hydrogens. In that section, the input record had 46
atoms while RDKit generated an output record with 28 atoms. RDKit may
also ‘sanitize’ the structures further (for example, convert ‘neutral
5 coordinate Ns with double bonds to Os to the zwitterionic form’).

While it’s possible to configure RDKit to keep implicit hydrogens, the
RDKit MACCS fingerprinter assumes there are no explicit hydrogens. You
would need to make a copy of the molecule, remove the explicit
hydrogens yourself, generate the fingerprint, and then add the
fingerprint to the molecule which still has the explicit hydrogens.

Bear in mind that the number of explicit atoms and bonds is based on
the molecular graph model, which is only one possible representation
for the actual chemical molecule. While I said there was a semantic
change, the 46 atom structure and the 28 atom structure are really the
same structure, just at different levels of conceptualization.

## Toolkits may modify SDF syntax[](#toolkits-may-modify-sdf-syntax "Link to this heading")

In this section you’ll see that passing a structure file through a
chemistry toolkit and back to the same format will likely make syntax
changes to the record. While not as significant as the previous
section, it may help persuade you that there are cases where you want
to work with the original record as text rather than as a molecule.

You will need Compound\_099000001\_099500000.sdf.gz
from PubChem.

I’ll read an SD file to get the first record as a toolkit molecule,
save the molecule to SDF format, and compare the original record with
the new one. This is called a round-trip test. Will there be
differences?

```
import chemfp

# Select your toolkit of choice
T = chemfp.get_toolkit("openeye")
#T = chemfp.get_toolkit("rdkit")
#T = chemfp.get_toolkit("openbabel")

reader_args = {"rdkit.*.removeHs": False}
with T.read_molecules("Compound_099000001_099500000.sdf.gz",
                      reader_args=reader_args) as reader:
    with T.open_molecule_writer("example.sdf") as writer:
        for mol in reader:
            writer.write_molecule(mol)
            break  # only process the first molecule
```

If I use the “openeye” toolkit and compare its output to the first
record of the input then the difference is trivial:

```
2c2
<   -OEChem-04292009532D
---
>   -OEChem-06182012582D
```

This difference is shown in the [diff](http://en.wikipedia.org/wiki/Diff_utility) utility’s default
format. The “2c2” means there was a change in line 2, and the changed
line is also on line 2. The “<” indicates the line in the first file
(in this case the original PubChem file) and the “>” indicates the
line in the second file (in this case “example.sdf”). The “`---`” is
to make it easier for humans to see break between the two files.

But what does that line mean? The “[CTfile](http://accelrys.com/products/informatics/cheminformatics/ctfile-formats/no-fee.php)”
(“connection table file”) spec from MDL, err, I mean Accelry, err, I
mean Symyx, err, I mean BIOVIA, gives the full details. The first two
characters (both blank here) are the user’s initials, the next 8
characters (OpenEye uses “`-`” to pad out “OEChem”) are the program
name.

The next six character are the date, followed by 4 characters for the
time. The PubChem record was created on 29 April 2020 at 09:33 while I
did the transformation on 18 June 2020 at 12:58. The last two
characters are the dimensionality; in this case the structure contains
2D coordinates.

PubChem used OEChem to make the file in the first place, so it’s not
too suprising that there weren’t any differences. What about Open
Babel? I changed the toolkit to “openbabel” and re-did the comparison.
The first few lines of the diff are:

```
2c2
<   -OEChem-04292009532D
---
>  OpenBabel06182013012D
4c4
<  46 49  0     1  0  0  0  0  0999 V2000
---
>  46 49  0  0  1  0  0  0  0  0999 V2000
```

The 2c2 change you know already, and you can see it was a few minutes
between when I ran the OEChem code and the Open Babel code.

The change to line 4 is meaningless. If you look closely you’ll see
that OEChem has a blank in column 12 where Open Babel has a “0”. The
specification say that this field is obsolete, so I think you can do
whatever you want there.

The next few lines are:

```
65c65
<   8  9  1  6  0  0  0
---
>   8  9  1  0  0  0  0
67c67
<   8 29  1  0  0  0  0
---
>   8 29  1  1  0  0  0
```

This says that OEChem interprets the bond between atoms 8 and 9 as “6”
= “down” stereochemistry, while Open Babel says it’s not stereo. On
the other hand, OEChem interprets the bond bond atoms 8 and 29 as
having no stereochemistry while Open Babel says it has “1” = “up”
stereochemistry. Looks to me like two valid interpretations of the
same thing.

The rest of the differences are trivial and semantically meaningless:
Open Babel uses two spaces between the “>” and “<” of a data header
line, while OEChem uses one space:

```
101c101
< > <PUBCHEM_COMPOUND_CID>
---
> >  <PUBCHEM_COMPOUND_CID>
104c104
```

Finally, I’ll use RDKit for the conversion. By default RDKit removes
hydrogens, which would leave the result with 15 atoms. Unlike Open
Babel, that action is configurable. I told RDKit to never remove
hydrogens for any of its supported formats, via the reader\_args:

```
reader_args = {"rdkit.*.removeHs": False}
```

(I didn’t actually need the “rdkit.\*.” namespace prefix, but the
“rdkit” helps as a reminder that this is an RDKit-specific option.)

There are the familiar changes in the second and fouth lines:

```
2c2
<   -OEChem-04292009532D
---
>      RDKit          2D
4c4
<  46 49  0     1  0  0  0  0  0999 V2000
---
>  46 49  0  0  1  0  0  0  0  0999 V2000
```

RDKit doesn’t include the timestamp so leaves that fields blank. (Then
again, just how useful is the timestamp? On the third hand, the chemfp
fingerprint formats include a timestamp as part of the metadata, so
it’s odd that I question having it in another format. On the fourth
hand, OEChem supports the `SuppressTimestamps` option to disable
including the timestamp.)

While I love knowing these sorts of details, none of these (except for
the explicit hydrogens) affect the semantic interpretation. Still, I
can think of cases where you want to preserve the original syntax,
like if you have fragile code which expects a “0” at a certain field
and will crash if there’s a blank.

## The text toolkit “molecules”[](#the-text-toolkit-molecules "Link to this heading")

In this section you’ll learn about the molecule-like object used by
the [`text_toolkit`](chemfp_text_toolkit.html#module-chemfp.text_toolkit "chemfp.text_toolkit").

The text\_toolkit implements the standard toolkit API, which means it
reads and writes “molecules”. Remember that it isn’t really a chemical
molecule but more like a thin layer around a molecule
record. Internally these are subclasses of a [`TextRecord`](chemfp_text_records.html#chemfp.text_records.TextRecord "chemfp.text_records.TextRecord"),
though I’ll often refer to them as “text molecules” to distinguish
them from the the actual record as a text string.

Every text molecule has an [`id`](chemfp_text_records.html#chemfp.text_records.TextRecord.id "chemfp.text_records.TextRecord.id") attribute, which may
be None if there is no identifier, and a [`record`](chemfp_text_records.html#chemfp.text_records.TextRecord.record "chemfp.text_records.TextRecord.record")
attribute containing the actual record as a string:

```
>>> from chemfp import text_toolkit
>>> mol = text_toolkit.parse_molecule("c1ccccc1O benzene", "smi")
>>> mol
SmiRecord(id='benzene', record=b'c1ccccc1O benzene', smiles='c1ccccc1O',
encoding='utf8', encoding_errors='strict')
>>> mol.id   # a Unicode string
'benzene'
>>> mol.record  # a byte string
b'c1ccccc1O benzene'
>>> text_toolkit.create_string(mol, "smistring")
'c1ccccc1O'
>>> text_toolkit.create_string(mol, "smi")
'c1ccccc1O benzene\n'
>>> text_toolkit.create_bytes(mol, "smistring")
b'c1ccccc1O'
>>> text_toolkit.create_bytes(mol, "smistring.zlib")
b'x\x9cK6L\x06\x01C\x7f\x00\x0fh\x03\x04'
>>>
>>> sdf_record = (
...   'methane\n' +
...   '\n' +
...   '\n' +
...   '  1  0  0  0  0  0  0  0  0  0999 V2000\n' +
...   '    0.0000    0.0000    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n' +
...   'M  END\n' +
...   '$$$$\n')
>>>
>>> sdf_mol = text_toolkit.parse_molecule(sdf_record, "sdf")
>>> sdf_mol
SDFRecord(id_bytes=b'methane'(id='methane'),
record=b'methane\n\n\n  1  0  0  0  0  0  0  0  0  0999 V2000\n    0.0 ...',
encoding='utf8', encoding_errors='strict')
>>> sdf_mol.id
'methane'
>>> sdf_mol.record[-20:]
b'0  0  0\nM  END\n$$$$\n'
```

The record is always uncompressed.

Each of the SMILES-based records has its own unique class:

```
>>> text_toolkit.parse_molecule("c1ccccc1O benzene", "smi")
SmiRecord(id='benzene', record=b'c1ccccc1O benzene',
smiles='c1ccccc1O', encoding='utf8', encoding_errors='strict')
>>> text_toolkit.parse_molecule("c1ccccc1O benzene", "can")
CanRecord(id='benzene', record=b'c1ccccc1O benzene',
smiles='c1ccccc1O', encoding='utf8', encoding_errors='strict')
>>> text_toolkit.parse_molecule("c1ccccc1O benzene", "usm")
UsmRecord(id='benzene', record=b'c1ccccc1O benzene',
smiles='c1ccccc1O', encoding='utf8', encoding_errors='strict')
>>> text_toolkit.parse_molecule("c1ccccc1O benzene", "smistring")
SmiStringRecord(id=None, record=b'c1ccccc1O', smiles='c1ccccc1O')
>>> text_toolkit.parse_molecule("c1ccccc1O benzene", "canstring")
CanStringRecord(id=None, record=b'c1ccccc1O', smiles='c1ccccc1O')
>>> text_toolkit.parse_molecule("c1ccccc1O benzene", "usmstring")
UsmStringRecord(id=None, record=b'c1ccccc1O', smiles='c1ccccc1O')
```

and for SMILES records you can access the SMILES directly through the
[`smiles`](chemfp_text_records.html#chemfp.text_records.TextRecord.smiles "chemfp.text_records.TextRecord.smiles") attribute:

```
>>> text_mol = text_toolkit.parse_molecule("C methane", "smistring")
>>> text_mol.smiles
'C'
```

Each text molecule also has a [`record_format`](chemfp_text_records.html#chemfp.text_records.TextRecord.record_format "chemfp.text_records.TextRecord.record_format")
attribute, which is the format name for the record.

```
>>> text_mol.record_format
'smistring'
>>> sdf_mol.record_format
'sdf'
```

The [`record_format`](chemfp_text_records.html#chemfp.text_records.TextRecord.record_format "chemfp.text_records.TextRecord.record_format") values are “smi”, “can”, …,
“usmstring” for the SMILES formats or “sdf” for a file in SDF
format. The [`record_format`](chemfp_text_records.html#chemfp.text_records.TextRecord.record_format "chemfp.text_records.TextRecord.record_format") will ne