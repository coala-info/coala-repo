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

* [API](main.html)[x]
* [Internals](internals.html)
* [Plugins](plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/api/structures.rst?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/api/structures.rst "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Data Structures[¶](#data-structures "Link to this heading")

*class* snakebids.BidsComponent(*\**, *name*, *path*, *zip\_lists*)[¶](#snakebids.BidsComponent "Link to this definition")
:   Representation of a bids data component.

    A component is a set of data entries all corresponding to the same type of object.
    Entries vary over a set of entities. For example, a component may represent all the
    unprocessed, T1-weighted anatomical images acquired from a group of 100 subjects,
    across 2 sessions, with three runs per session. Here, the subject, session, and run
    are the entities over which the component varies. Each entry in the component has
    a single value assigned for each of the three entities (e.g subject 002, session
    01, run 1).

    Each entry can be defined solely by its wildcard values. The complete collection of
    entries can thus be stored as a table, where each row represents an entity and each
    column represents an entry.

    `BidsComponent` stores and indexes this table. It uses ‘row-first’ indexing,
    meaning first an entity is selected, then an entry. It also has a number of
    properties and methods making it easier to incorporate the data in a snakemake
    workflow.

    In addition, `BidsComponent` stores a template [`~BidsComponent.path`](#snakebids.BidsComponent.path "snakebids.BidsComponent.path")
    derived from the source dataset. This path is used by the
    [`expand()`](#snakebids.BidsComponent.expand "snakebids.BidsComponent.expand") method to recreate the original filesystem paths.

    The real power of the `BidsComponent`, however, is in creating derived paths based
    on the original dataset. Using the :meth`~BidsComponent.expand` method, you can pass
    new paths with `{wildcard}` placeholders wrapped in braces and named according to
    the entities in the component. These placeholders will be substituted with the
    entity values saved in the table, giving you a list of paths the same length as the
    number of entries in the component.

    BidsComponents are immutable: their values cannot be altered.

    Parameters:
    :   * **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))
        * **path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    name*: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*[¶](#snakebids.BidsComponent.name "Link to this definition")
    :   Name of the component

    path*: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*[¶](#snakebids.BidsComponent.path "Link to this definition")
    :   Wildcard-filled path that matches the files for this component.

    expand(*paths=None*, */*, *allow\_missing=False*, *\*\*wildcards*)[¶](#snakebids.BidsComponent.expand "Link to this definition")
    :   Safely expand over given paths with component wildcards.

        Uses the entity-value combinations found in the dataset to expand over the given
        paths. If no path is provided, expands over the component
        [`path`](#snakebids.BidsComponent.path "snakebids.BidsComponent.path") (thus returning the original files used to
        create the component). Extra wildcards can be specified as keyword arguments.

        By default, expansion over paths with extra wildcards not accounted for by the
        component causes an error. This prevents accidental partial expansion. To allow
        the passage of extra wildcards without expansion,set `allow_missing` to
        `True`.

        Uses the snakemake [expand](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#snakefiles-expand "(in Snakemake v9.13.7)") under the hood.

        Parameters:
        :   * **paths** ([*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")*[*[*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]* *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Path or list of paths to expand over. If not provided, the component’s own
              [`path`](#snakebids.BidsComponent.path "snakebids.BidsComponent.path") will be expanded over.
            * **allow\_missing** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*) – If True, allow `{wildcards}` in the provided paths that are not present
              either in the component or in the extra provided `**wildcards`. These
              wildcards will be preserved in the returned paths.
            * **wildcards** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*) – Each keyword should be the name of an wildcard in the provided paths.
              Keywords not found in the path will be ignored. Keywords take values or
              lists of values to be expanded over the provided paths.

        Return type:
        :   [list](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")]

    *property* entities*: MultiSelectDict[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"), [list](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")]]*[¶](#snakebids.BidsComponent.entities "Link to this definition")
    :   Component entities and their associated values.

        Dictionary where each key is an entity and each value is a list of the
        unique values found for that entity. These lists might not be the same length.

    filter(*\**, *regex\_search=False*, *\*\*filters*)[¶](#snakebids.BidsComponent.filter "Link to this definition")
    :   Filter component based on provided entity filters.

        This method allows you to expand over a subset of your wildcards. This could be
        useful for extracting subjects from a specific patient group, running different
        rules on different acquisitions, and any other reason you may need to filter
        your data after the workflow has already started.

        Takes entities as keyword arguments assigned to values or list of values to
        select from the component. Only columns containing the provided entity-values
        are kept. If no matches are found, a component with the all the original
        entities but with no values will be returned.

        Returns a brand new [`BidsComponent`](#snakebids.BidsComponent "snakebids.BidsComponent"). The original component is
        not modified.

        Parameters:
        :   * **regex\_search** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*) – Treat filters as regex patterns when matching with entity-values.
            * **filters** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*) – Each keyword should be the name of an entity in the component. Entities not
              found in the component will be ignored. Keywords take values or a list of
              values to be matched with the component
              [`zip_lists`](#snakebids.BidsComponent.zip_lists "snakebids.BidsComponent.zip_lists")

        Return type:
        :   *Self*

    pformat(*max\_width=None*, *tabstop=4*)[¶](#snakebids.BidsComponent.pformat "Link to this definition")
    :   Pretty-format component.

        Parameters:
        :   * **max\_width** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)") *|* [*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)") *|* *None*) – Maximum width of characters for output. If possible, zip\_list table will be
              elided to fit within this width
            * **tabstop** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")) – Number of spaces for output indentation

        Return type:
        :   [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")

    *property* wildcards*: MultiSelectDict[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"), [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")]*[¶](#snakebids.BidsComponent.wildcards "Link to this definition")
    :   Wildcards in brace-wrapped syntax.

        Dictionary where each key is the name of a wildcard entity, and each value is
        the Snakemake wildcard used for that entity.

    *property* zip\_lists[¶](#snakebids.BidsComponent.zip_lists "Link to this definition")
    :   Table of unique wildcard groupings for each member in the component.

        Dictionary where each key is a wildcard entity and each value is a list of the
        values found for that entity. Each of these lists has length equal to the number
        of images matched for this modality, so they can be zipped together to get a
        list of the wildcard values for each file.

Legacy `BidsComponents` properties

The following properties are historical aliases of `BidsComponents` properties. There are no current plans to deprecate them, but new code should avoid them.

*property* BidsComponent.input\_zip\_lists*: [snakebids.types.ZipList](internals.html#snakebids.types.ZipList "snakebids.types.ZipList")*[¶](#snakebids.BidsComponent.input_zip_lists "Link to this definition")
:   Alias of [`zip_lists`](#snakebids.BidsComponent.zip_lists "snakebids.BidsComponent.zip_lists").

    Dictionary where each key is a wildcard entity and each value is a list of the
    values found for that entity. Each of these lists has length equal to the number
    of images matched for this modality, so they can be zipped together to get a
    list of the wildcard values for each file.

*property* BidsComponent.input\_wildcards[¶](#snakebids.BidsComponent.input_wildcards "Link to this definition")
:   Alias of [`wildcards`](#snakebids.BidsComponent.wildcards "snakebids.BidsComponent.wildcards")

    Wildcards in brace-wrapped syntax.

*property* BidsComponent.input\_name*: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*[¶](#snakebids.BidsComponent.input_name "Link to this definition")
:   Alias of [`name`](#snakebids.BidsComponent.name "snakebids.BidsComponent.name").

    Name of the component

*property* BidsComponent.input\_path*: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*[¶](#snakebids.BidsComponent.input_path "Link to this definition")
:   Alias of [`path`](#snakebids.BidsComponent.path "snakebids.BidsComponent.path").

    Wildcard-filled path that matches the files for this component.

*property* BidsComponent.input\_lists[¶](#snakebids.BidsComponent.input_lists "Link to this definition")
:   Alias of [`entities`](#snakebids.BidsComponent.entities "snakebids.BidsComponent.entities")

    Component entities and their associated values.

*class* snakebids.BidsPartialComponent(*\**, *zip\_lists*)[¶](#snakebids.BidsPartialComponent "Link to this definition")
:   Primitive representation of a bids data component.

    See [`BidsComponent`](#snakebids.BidsComponent "snakebids.BidsComponent") for an extended definition of a data component.

    `BidsPartialComponents` are typically derived from a [`BidsComponent`](#snakebids.BidsComponent "snakebids.BidsComponent"). They
    do not store path information, and do not represent real data files. They just have
    a table of entity-values, typically a subset of those present in their source
    [`BidsComponent`](#snakebids.BidsComponent "snakebids.BidsComponent").

    Despite this, `BidsPartialComponents` still allow you to expand the data table
    over new paths, allowing you to derive paths from your source dataset.

    The members of `BidsPartialComponent` are identical to [`BidsComponent`](#snakebids.BidsComponent "snakebids.BidsComponent") with
    the following exceptions:

    * No [`name`](#snakebids.BidsComponent.name "snakebids.BidsComponent.name") or [`path`](#snakebids.BidsComponent.path "snakebids.BidsComponent.path")
    * `expand()` must be given a path or list of paths as the
      first argument

    `BidsPartialComponents` are immutable: their values cannot be altered.

*class* snakebids.BidsComponentRow(*iterable*, */*, *entity*)[¶](#snakebids.BidsComponentRow "Link to this definition")
:   A single row from a BidsComponent.

    This class is derived by indexing a single entity from a [`BidsComponent`](#snakebids.BidsComponent "snakebids.BidsComponent") or
    [`BidsPartialComponent`](#snakebids.BidsPartialComponent "snakebids.BidsPartialComponent"). It 