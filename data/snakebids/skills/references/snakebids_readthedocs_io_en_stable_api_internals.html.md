Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[Snakebids 0.15.0 documentation](../index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[Snakebids 0.15.0 documentation](../index.html)

User Guide

* [Why use snakebids?](../general/why_snakebids.html)
* [Tutorial](../tutorial/tutorial.html)
* [Bids Function](../bids_function/overview.html)
* [Bids Apps](../bids_app/overview.html)[ ]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](../migration/index.html)[ ]

Reference

* [API](main.html)[ ]
* Internals
* [Plugins](plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/api/internals.rst?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/api/internals.rst "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Internals[¶](#internals "Link to this heading")

Note

These types are mostly used internally. The API most users will need is documented in [the main API page](main.html#main-api), but these are listed here for reference (and some of the main API items link here).

## utils[¶](#module-snakebids.utils.utils "Link to this heading")

*class* snakebids.utils.utils.BidsTag[¶](#snakebids.utils.utils.BidsTag "Link to this definition")
:   Interface for BidsTag configuration.

snakebids.utils.utils.DEPRECATION\_FLAG *= '<!DEPRECATED!>'*[¶](#snakebids.utils.utils.DEPRECATION_FLAG "Link to this definition")
:   Sentinel string to mark deprecated config features

snakebids.utils.utils.read\_bids\_tags(*bids\_json=None*)[¶](#snakebids.utils.utils.read_bids_tags "Link to this definition")
:   Read the bids tags we are aware of from a JSON file.

    This is used specifically for compatibility with pybids, since some tag keys
    are different from how they appear in the file name, e.g. `subject` for
    `sub`, and `acquisition` for `acq`.

    Parameters:
    :   **bids\_json** ([*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* *None*) – Path to JSON file to use, if not specified will use
        `bids_tags.json` in the snakebids module.

    Returns:
    :   Dictionary of bids tags

    Return type:
    :   [dict](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")

*class* snakebids.utils.utils.BidsEntity(*entity*)[¶](#snakebids.utils.utils.BidsEntity "Link to this definition")
:   Bids entities with tag and wildcard representations.

    Parameters:
    :   **entity** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    *property* tag*: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*[¶](#snakebids.utils.utils.BidsEntity.tag "Link to this definition")
    :   Get the bids tag version of the entity.

        For entities in the bids spec, the tag is the short version of the entity
        name. Otherwise, the tag is equal to the entity.

    *property* match*: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*[¶](#snakebids.utils.utils.BidsEntity.match "Link to this definition")
    :   Get regex of acceptable value matches.

        If no pattern is associated with the entity, the default pattern is a word with
        letters and numbers

    *property* before*: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*[¶](#snakebids.utils.utils.BidsEntity.before "Link to this definition")
    :   Regex str to search before value in paths.

    *property* after*: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*[¶](#snakebids.utils.utils.BidsEntity.after "Link to this definition")
    :   Regex str to search after value in paths.

    *property* regex*: [Pattern](https://docs.python.org/3/library/re.html#re.Pattern "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")]*[¶](#snakebids.utils.utils.BidsEntity.regex "Link to this definition")
    :   Complete pattern to match when searching in paths.

        Contains three capture groups, the first corresponding to “before”, the second
        to “value”, and the third to “after”

    *property* wildcard*: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*[¶](#snakebids.utils.utils.BidsEntity.wildcard "Link to this definition")
    :   Get the snakebids {wildcard}.

        The wildcard is generally equal to the tag, i.e. the short version of the entity
        name, except for subject and session, which use the full name name. This is to
        ensure compatibility with the bids function

    *property* type*: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)")*[¶](#snakebids.utils.utils.BidsEntity.type "Link to this definition")
    :   Get the type of the entity.

        Returns None if type unspecified.

    *classmethod* from\_tag(*tag*)[¶](#snakebids.utils.utils.BidsEntity.from_tag "Link to this definition")
    :   Return the entity associated with the given tag, if found.

        If not associated entity is found, the tag itself is used as the entity name

        Parameters:
        :   **tag** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – tag to search

        Return type:
        :   [BidsEntity](#snakebids.utils.utils.BidsEntity "snakebids.utils.utils.BidsEntity")

    *classmethod* normalize(*item*, */*)[¶](#snakebids.utils.utils.BidsEntity.normalize "Link to this definition")
    :   Return the entity associated with the given item, if found.

        Supports both strings and BidsEntities as input. Unlike the constructor, if a
        tag name is given, the associated entity will be returned. If no associated
        entity is found, the tag itself is used as the entity name

        Parameters:
        :   **item** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*BidsEntity*](#snakebids.utils.utils.BidsEntity "snakebids.utils.utils.BidsEntity")) – tag to search

        Return type:
        :   [*BidsEntity*](#snakebids.utils.utils.BidsEntity "snakebids.utils.utils.BidsEntity")

snakebids.utils.utils.matches\_any(*item*, *match\_list*, *match\_func*, *\*args*)[¶](#snakebids.utils.utils.matches_any "Link to this definition")
:   Test if item matches any of the items in match\_list.

    Parameters:
    :   * **item** (*\_T*) – Item to test
        * **match\_list** ([*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")*[**\_T**]*) – Items to compare with
        * **match\_func** ([*BinaryOperator*](#snakebids.types.BinaryOperator "snakebids.types.BinaryOperator")*[**\_T**,* [*object*](https://docs.python.org/3/library/functions.html#object "(in Python v3.14)")*]*) – Function to test equality. Defaults to basic equality (`==`) check
        * **args** ([*Any*](https://docs.python.org/3/library/typing.html#typing.Any "(in Python v3.14)"))

    Return type:
    :   [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")

*exception* snakebids.utils.utils.BidsParseError(*path*, *entity*)[¶](#snakebids.utils.utils.BidsParseError "Link to this definition")
:   Exception raised for errors encountered in the parsing of Bids paths.

    Parameters:
    :   * **path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))
        * **entity** ([*BidsEntity*](#snakebids.utils.utils.BidsEntity "snakebids.utils.utils.BidsEntity"))

    Return type:
    :   None

snakebids.utils.utils.property\_alias(*prop*, *label=None*, *ref=None*, *copy\_extended\_docstring=False*)[¶](#snakebids.utils.utils.property_alias "Link to this definition")
:   Set property as an alias for another property.

    Copies the docstring from the aliased property to the alias

    Parameters:
    :   * **prop** ([*property*](https://docs.python.org/3/library/functions.html#property "(in Python v3.14)")) – Property to alias
        * **label** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Text to use in link to aliased property
        * **ref** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Name of the property to alias
        * **copy\_extended\_docstring** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – If True, copies over the entire docstring, in addition to the summary line

    Return type:
    :   [property](https://docs.python.org/3/library/functions.html#property "(in Python v3.14)")

snakebids.utils.utils.surround(*s*, *object\_*, */*)[¶](#snakebids.utils.utils.surround "Link to this definition")
:   Surround a string or each string in an iterable with characters.

    Parameters:
    :   * **s** ([*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]* *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))
        * **object\_** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    Return type:
    :   [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")]

snakebids.utils.utils.zip\_list\_eq(*first*, *second*, */*)[¶](#snakebids.utils.utils.zip_list_eq "Link to this definition")
:   Compare two zip lists, allowing the order of columns to be irrelevant.

    Parameters:
    :   * **first** ([*Mapping*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Mapping "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]**]*)
        * **second** ([*Mapping*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Mapping "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]**]*)

snakebids.utils.utils.get\_first\_dir(*path*)[¶](#snakebids.utils.utils.get_first_dir "Link to this definition")
:   Return the top level directory in a path.

    If absolute, return the root. This function is necessary to handle paths with
    `./`, as `pathlib.Path` filters this out.

    Parameters:
    :   **path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    Return type:
    :   [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")

snakebids.utils.utils.to\_resolved\_path(*path*)[¶](#snakebids.utils.utils.to_resolved_path "Link to this definition")
:   Convert provided object into resolved path.

    Parameters:
    :   **path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*PathLike*](https://docs.python.org/3/library/os.html#os.PathLike "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*)

snakebids.utils.utils.get\_wildcard\_dict(*entities*, */*)[¶](#snakebids.utils.utils.get_wildcard_dict "Link to this definition")
:   Turn entity strings into wildcard dicts as {“entity”: “{entity}”}.

    Parameters:
    :   **entities** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*)

    Return type:
    :   [dict](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"), [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")]

snakebids.utils.utils.entity\_to\_wildcard(*entities*, */*)[¶](#snakebids.utils.utils.entity_to_wildcard "Link to this definition")
:   Turn entity strings into wildcard dicts as {“entity”: “{entity}”}.

    Parameters:
    :   **entities** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*)

snakebids.utils.utils.text\_fold(*text*)[¶](#snakebids.utils.utils.text_fold "Link to this definition")
:   Fold a block of text into a single line as in yaml folded multiline string.

    Parameters:
    :   **text** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

## snakemake\_io[¶](#module-snakebids.utils.snakemake_io "Link to this heading")

File globbing functions based on snakemake.io library.

snakebids.utils.snakemake\_io.regex(*filepattern*)[¶](#snakebids.utils.snakemake_io.regex "Link to this definition")
:   Build Snakebids regex based on the given file pattern.

    Parameters:
    :   **filepattern** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    Return type:
    :   [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")

snakebids.utils.snakemake\_io.glob\_wildcards(*pattern*, *files=None*, *followlinks=False*)[¶](#snakebids.utils.snakemake_io.glob_wildcards "Link to this definition")
:   Glob the values of wildcards by matching a pattern to the filesystem.

    Returns a zip\_list of field names with matched wildcard values.

    Parameters:
    :   * **pattern** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)")) – Path including wildcards to glob on the filesystem.
        * **files** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)")*]* *|* *None*) – Files from which to glob wildcards. If None (default), the directory
