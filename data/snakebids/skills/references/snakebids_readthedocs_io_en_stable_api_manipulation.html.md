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

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/api/manipulation.rst?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/api/manipulation.rst "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Dataset Manipulation[¶](#module-snakebids "Link to this heading")

snakebids.filter\_list(*zip\_list*, *filters*, *return\_indices\_only=False*, *regex\_search=False*)[¶](#snakebids.filter_list "Link to this definition")
:   Filter zip\_list, including only entries with provided entity values.

    Parameters:
    :   * **zip\_list** ([*ZipListLike*](internals.html#snakebids.types.ZipListLike "snakebids.types.ZipListLike")) – generated zip lists dict from config file to filter
        * **filters** (*Mapping**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* *Iterable**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]* *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*) – wildcard values to filter the zip lists
        * **return\_indices\_only** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – return the indices of the matching wildcards
        * **regex\_search** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Use regex matching to filter instead of the default equality check.

    Return type:
    :   [ZipList](internals.html#snakebids.types.ZipList "snakebids.types.ZipList") | [list](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")[[int](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")]

    Examples

    ```
    >>> import snakebids
    ```

    Filtering to get all `subject='01'` scans:

    ```
    >>> snakebids.filter_list(
    ...     {
    ...         'dir': ['AP','PA','AP','PA', 'AP','PA','AP','PA'],
    ...         'acq': ['98','98','98','98','99','99','99','99'],
    ...         'subject': ['01','01','02','02','01','01','02','02' ]
    ...     },
    ...     {'subject': '01'}
    ... ) == {
    ...     'dir': ['AP', 'PA', 'AP', 'PA'],
    ...     'acq': ['98', '98', '99', '99'],
    ...     'subject': ['01', '01', '01', '01']
    ... }
    True
    ```

    Filtering to get all `acq='98'` scans:

    ```
    >>> snakebids.filter_list(
    ...     {
    ...         'dir': ['AP','PA','AP','PA', 'AP','PA','AP','PA'],
    ...         'acq': ['98','98','98','98','99','99','99','99'],
    ...         'subject': ['01','01','02','02','01','01','02','02' ]
    ...     },
    ...     {'acq': '98'}
    ... ) == {
    ...     'dir': ['AP', 'PA', 'AP', 'PA'],
    ...     'acq': ['98', '98', '98', '98'],
    ...     'subject': ['01', '01', '02', '02']
    ... }
    True
    ```

    Filtering to get all `dir=='AP'` scans:

    ```
    >>> snakebids.filter_list(
    ...     {
    ...         'dir': ['AP','PA','AP','PA', 'AP','PA','AP','PA'],
    ...         'acq': ['98','98','98','98','99','99','99','99'],
    ...         'subject': ['01','01','02','02','01','01','02','02' ]
    ...     },
    ...     {'dir': 'AP'}
    ... ) == {
    ...     'dir': ['AP', 'AP', 'AP', 'AP'],
    ...     'acq': ['98', '98', '99', '99'],
    ...     'subject': ['01', '02', '01', '02']
    ... }
    True
    ```

    Filtering to get all `subject='03'` scans (i.e. no matches):

    ```
    >>> snakebids.filter_list(
    ...     {
    ...         'dir': ['AP','PA','AP','PA', 'AP','PA','AP','PA'],
    ...         'acq': ['98','98','98','98','99','99','99','99'],
    ...         'subject': ['01','01','02','02','01','01','02','02' ]
    ...     },
    ...     {'subject': '03'}
    ... ) == {
    ...     'dir': [],
    ...     'acq': [],
    ...     'subject': []
    ... }
    True
    ```

snakebids.get\_filtered\_ziplist\_index(*zip\_list*, *wildcards*, *subj\_wildcards*)[¶](#snakebids.get_filtered_ziplist_index "Link to this definition")
:   Return the indices of all entries matching the filter query.

    Parameters:
    :   * **zip\_list** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")) – lists for scans in a dataset, zipped to get each instance
        * **wildcards** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")) – wildcards for the single instance for querying it’s index
        * **subj\_wildcards** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")) – keys of this dictionary are used to pick out the subject/(session)
          from the wildcards

    Return type:
    :   [int](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)") | [list](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")[[int](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")]

    Examples

    ```
    >>> import snakebids
    ```

    In this example, we have a dataset where with scans from two subjects,
    where each subject has `dir-AP` and `dir-PA` scans, along with
    `acq-98` and `acq-99`:

    * `sub-01_acq-98_dir-AP_dwi.nii.gz`
    * `sub-01_acq-98_dir-PA_dwi.nii.gz`
    * `sub-01_acq-99_dir-AP_dwi.nii.gz`
    * `sub-01_acq-99_dir-PA_dwi.nii.gz`
    * `sub-02_acq-98_dir-AP_dwi.nii.gz`
    * `sub-02_acq-98_dir-PA_dwi.nii.gz`
    * `sub-02_acq-99_dir-AP_dwi.nii.gz`
    * `sub-02_acq-99_dir-PA_dwi.nii.gz`

    The `zip_list` produced by `generate_inputs()` is the set of entities
    that when zipped together, e.g. with `expand(path, zip, **zip_list)`,
    produces the entity combinations that refer to each scan:

    ```
    {
        'dir': ['AP','PA','AP','PA', 'AP','PA','AP','PA'],
        'acq': ['98','98','98','98','99','99','99','99'],
        'subject': ['01','01','02','02','01','01','02','02']
    }
    ```

    The `filter_list()` function produces a subset of the entity
    combinations as a filtered zip list. This is used e.g. to get all the
    scans for a single subject.

    This `get_filtered_ziplist_index()` function performs `filter_list()`
    twice:

    1. Using the `subj_wildcards` (e.g.: `'subject': '{subject}'`) to get
       a subject/session-specific `zip_list`.
    2. To return the indices from that list of the matching wildcards.

    In this example, if the wildcards parameter was:

    ```
    {'dir': 'PA', 'acq': '99', 'subject': '01'}
    ```

    Then the first (subject/session-specific) filtered list provides this zip
    list:

    ```
    {
        'dir': ['AP','PA','AP','PA'],
        'acq': ['98','98','99','99'],
        'subject': ['01','01','01','01']
    }
    ```

    which has 4 combinations, and thus are indexed from 0 to 3.

    The returned value would then be the index (or indices) that matches the
    wildcards. In this case, since the wildcards were
    `{'dir': 'PA', 'acq': '99', 'subject':'01'}`, the return index is 3.

    ```
    >>> snakebids.get_filtered_ziplist_index(
    ...     {
    ...         'dir': ['AP','PA','AP','PA', 'AP','PA','AP','PA'],
    ...         'acq': ['98','98','98','98','99','99','99','99'],
    ...         'subject': ['01','01','02','02','01','01','02','02' ]
    ...     },
    ...     {'dir': 'PA', 'acq': '99', 'subject': '01'},
    ...     {'subject': '{subject}' }
    ... )
    3
    ```

[Next

Data Structures](structures.html)
[Previous

Dataset Creation](creation.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Dataset Manipulation
  + [`filter_list()`](#snakebids.filter_list)
  + [`get_filtered_ziplist_index()`](#snakebids.get_filtered_ziplist_index)