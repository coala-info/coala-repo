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

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/api/paths.rst?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/api/paths.rst "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Path Building[¶](#path-building "Link to this heading")

snakebids.bids(*root=None*, *\**, *datatype=None*, *prefix=None*, *suffix=None*, *extension=None*, *\*\*entities*)[¶](#snakebids.bids "Link to this definition")
:   Generate bids or bids-like paths.

    File path is of the form:

    ```
    [root]/[sub-{subject}]/[ses-{session]/
    [prefix]_[sub-{subject}]_[ses-{session}]_[{key}-{val}_ ... ]_[suffix]
    ```

    If no arguments are specified, an empty string will be returned.

    Datatype and prefix may not be used in isolation, but must be given with
    another entity.

    BIDS paths are built based on specs, which are versioned for long-term stability.
    The latest version is `v0_0_0`. Information on its spec can be found at
    [`v0_0_0()`](#snakebids.paths.specs.v0_0_0 "snakebids.paths.specs.v0_0_0").

    Warning

    By default, `bids()` will always use the latest BIDS spec. This is unsafe for
    production environments, as the spec may be updated without warning, even on
    patch releases. These updates may change the path output by `bids()`,
    resulting in breaking changes in downstream apps

    Production code should always explicitly set the spec version using
    [`set_bids_spec()`](#snakebids.set_bids_spec "snakebids.set_bids_spec"):

    ```
    from snakebids import set_bids_spec
    set_bids_spec("v0_0_0")
    ```

    Parameters:
    :   * **root** ([*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Root folder to include in the path (e.g. `results`)
        * **datatype** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Folder to include after sub-/ses- (e.g. `anat`, `dwi` )
        * **prefix** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – String to prepend to the file name. Useful for injecting custom entities at
          the front of the filename, e.g. `tpl-{tpl}`
        * **suffix** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Suffix plus, optionally, the extension (e.g. `T1w.nii.gz`)
        * **extension** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – bids extension, beginning with `.` (e.g. `.nii.gz`). Typically
          shouldn’t be specified manually: extensions should be listed along with the
          suffix.
        * **entities** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – bids entities as keyword arguments paired with values (e.g. `space="T1w"`
          for `space-T1w`)

    Return type:
    :   [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")

    Examples

    Below is a rule using bids naming for input and output:

    ```
    rule proc_img:
        input: 'sub-{subject}_T1w.nii.gz' output:
        'sub-{subject}_space-snsx32_desc-preproc_T1w.nii.gz'
    ```

    With bids() you can instead use:

    ```
    rule proc_img: input: bids(subject='{subject}',suffix='T1w.nii.gz')
    output: bids(
        subject='{subject}', space='snsx32', desc='preproc',
        suffix='T1w.nii.gz'
    )
    ```

    Note that here we are not actually using “functions as inputs” in snakemake,
    which would require a function definition with wildcards as the argument, and
    restrict to input/params, but bids() is being used simply to return a string.

    Also note that space, desc and suffix are NOT wildcards here, only {subject} is.
    This makes it easy to combine wildcards and non-wildcards with bids-like naming.

    However, you can still use bids() in a lambda function. This is especially
    useful if your wildcards are named the same as bids entities (e.g. {subject},
    {session}, {task} etc..):

    ```
    rule proc_img:
        input: lambda wildcards: bids(**wildcards,suffix='T1w.nii.gz') output:
        bids(
            subject='{subject}', space='snsx32', desc='preproc',
            suffix='T1w.nii.gz'
        )
    ```

    Or another example where you may have many bids-like wildcards used in your
    workflow:

    ```
    rule denoise_func:
        input: lambda wildcards: bids(**wildcards, suffix='bold.nii.gz') output:
        bids(
            subject='{subject}', session='{session}', task='{task}',
            acq='{acq}', desc='denoise', suffix='bold.nii.gz'
        )
    ```

    In this example, all the wildcards will be determined from the output and passed
    on to bids() for inputs. The output filename will have a ‘desc-denoise’ flag
    added to it.

    Also note that even if you supply entities in a different order, the entities
    will be ordered based on the OrderedDict defined here. If entities not known are
    provided, they will be just be placed at the end (before the suffix), in the
    order you provide them in.

snakebids.bids\_factory(*spec*)[¶](#snakebids.bids_factory "Link to this definition")
:   Generate bids functions according to the supplied spec.

    Parameters:
    :   * **spec** ([*list*](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")*[*[*BidsPathEntitySpec*](#snakebids.paths.BidsPathEntitySpec "snakebids.paths._utils.BidsPathEntitySpec")*]*) – Valid Bids Spec object
        * **\_implicit** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Flag used internally to mark the default generated bids function. The
          resulting builder will warn when custom entities are used

    Return type:
    :   [*BidsFunction*](#snakebids.BidsFunction "snakebids.paths._factory.BidsFunction")

snakebids.set\_bids\_spec(*spec*)[¶](#snakebids.set_bids_spec "Link to this definition")
:   Set the spec to be used by path generation functions (such as [`bids()`](#snakebids.bids "snakebids.bids")).

    Parameters:
    :   **spec** ([*BidsPathSpec*](#snakebids.paths.BidsPathSpec "snakebids.paths.BidsPathSpec") *|* *VALID\_SPECS*) – Either a spec object, or the name of a builtin [spec](#specs)

## Specs[¶](#specs "Link to this heading")

BIDS specs control the formatting of paths produced by the [`bids()`](#snakebids.bids "snakebids.bids") function. They specify the order of recognized entities, placing `ses-X` after `sub-Y`, for instance, no matter what order they are specified in the function. Unrecognized entities are placed in the order specified in the function call.

Because of this, each addition of entities to the spec presents a potentially breaking change. Suppose an entity called `foo` were added to the spec. Calls to [`bids()`](#snakebids.bids "snakebids.bids") with `foo` as an argument would place the entity at the end of the path:

```
from snakebids import bids

# Before foo is in the spec
bids(
    subject="001",
    session="1",
    label="WM",
    foo="bar",
    suffix="data.nii.gz",
) == "sub-001_ses-1_label-WM_foo-bar_data.nii.gz"
```

The addition of `foo` to the spec might move the position of the entity forward in the output:

```
# After foo is in the spec
bids(
    subject="001",
    session="1",
    label="WM",
    foo="bar",
    suffix="data.nii.gz",
) == "sub-001_ses-1_foo-bar_label-WM_data.nii.gz"
```

This would change the output paths of workflow using this function call, causing a breaking change in workflow behaviour.

To ensure stable path generation across releases, Snakebids ships with versioned specs that can be explicitly set using `snakebids.set_bids_specs()`. These specs are named after the snakebids version they release with. By default, [`bids()`](#snakebids.bids "snakebids.bids") will always use the latest spec, but production code should generally declare the spec to be used by the workflow:

```
from snakebids import set_bids_spec
set_bids_spec("v0_0_0")
```

This is especially true of workflows using custom entities. To emphasize this, a warning is issued in python scripts and apps using such entities without declaring a spec version.

snakebids.paths.specs.v0\_0\_0(*subject\_dir=True*, *session\_dir=True*)[¶](#snakebids.paths.specs.v0_0_0 "Link to this definition")
:   Get the v0.0.0 BidsPathSpec.

    This spec alone equips [`bids()`](#snakebids.bids "snakebids.bids") with 2 extra arguments:
    `include_subject_dir` and `include_session_dir`. These default to `True`, but
    if set `False`, remove the subject and session dirs respectively from the output
    path. For future specs, this behaviour should be achieved by modifying the spec and
    generating a new [`bids()`](#snakebids.bids "snakebids.bids") function

    Formatted as:

    ```
    sub-{subject}/ses-{session}/{datatype}/{prefix}_sub-{subject}_ses-{session}_
    task-{task}_acq-{acq}_ce-{ce}_rec-{rec}_dir-{dir}_run-{run}_mod-{mod}_
    echo-{echo}_hemi-{hemi}_space-{space}_res-{res}_den-{den}_label-{label}_
    desc-{desc}_..._{suffix}{extension}
    ```

    Parameters:
    :   * **subject\_dir** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – If False, downstream path generator will not include the subject dir
          sub-{subject}/\*
        * **session\_dir** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")*,* *optional*) – If False, downstream path generator will not include the session dir
          \*/ses-{session}/\*

    Return type:
    :   [list](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")[[*BidsPathEntitySpec*](#snakebids.paths.BidsPathEntitySpec "snakebids.paths._utils.BidsPathEntitySpec")]

snakebids.paths.specs.v0\_11\_0(*subject\_dir=True*, *session\_dir=True*)[¶](#snakebids.paths.specs.v0_11_0 "Link to this definition")
:   Spec corresponding to [BIDS v1.9.0](https://bids-specification.readthedocs.io/en/v1.9.0/).

    Significantly expanded from the v0.0.0 spec, now including long names for every
    relevant entity. In addition to the official spec, it includes from and to
    entities intended for transformations. Unknown entities are placed just before desc,
    so that the description entity is always last.

    Formatted as:

    ```
    sub-{subject}/ses-{session}/{datatype}/{prefix}_sub-{subject}_ses-{session}_
    sample-{sample}_task-{task}_tracksys-{tracksys}_acq-{acquisition}_
    ce-{ceagent}_stain-{staining}_trc-{tracer}_rec-{reconstruction}_
    dir-{direction}_run-{run}_mod-{modality}_echo-{echo}_flip-{flip}_
    inv-{inversion}_mt-{mt}_proc-{processed}_part-{part}_space-{space}_
    atlas-{atlas}_seg-{segmentation}_hemi-{hemisphere}_res-{resolution}_
    den-{density}_roi-{roi}_from-{from}_to-{to}_split-{split}_
    recording-{recording}_chunk-{chunk}_model-{model}_subset-{subset}_
    label-{label}_..._desc-{description}_{suffix}{extension}
    ```

    Parameters:
    :   * **subject\_dir** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – If False, downstream path generator will not include the subject dir
          sub-{subject}/\*
        * **session\_dir** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")*,* *optional*) – If False, downstream path generator will not include the session dir
          \*/ses-{session}/\*

    Return type:
    :   [list](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")[[*BidsPathEntitySpec*](#snakebids.paths.BidsPathEntitySpec "snakebids.paths._utils.BidsPathEntitySpec")]

snakebids.paths.specs.v0\_15\_0(*subject\_dir=True*, *session\_dir=True*)[¶](#snakebids.paths.specs.v0_15_0 "Link to this definition")
:   Spec corresponding to [BIDS v1.10.1](https://bids-specification.readthedocs.io/en/v1.10.1/).

    In addition to the official spec, it includes from and to entities intended for
    transformations. Unknown entities are placed just before desc, so that the
    description entity is always last.

    Formatted as:

    ```
    sub-{subject}/ses-{session}/{datatype}/{prefix}_sub-{subject}_ses-{session}_
    sample-{sample}_task-{task}_tracksys-{tracksys}_acq-{acquisition}_
    nuc-{nucleus}_voi-{volume}_ce-{ceagent}_stain-{staining}_trc-{tracer}_
    rec-{reconstruction}_dir-{direction}_run-{run}_mod-{modality}_echo-{echo}_
    flip-{flip}_inv-{inversion}_mt-{mt}_proc-{processed}_part-{part}_
    space-{space}_atlas-{atlas}_seg-{segmentation}_hemi-{hemisphere}_
    res-{resolution}_den-{density}_roi-{roi}_from-{from}_to-{to}_split-{split}_
    recording-{recording}_chunk-{chunk}_model-{model}_subset-{subset}_
    label-{label}_..._desc-{description}_{suffix}{extension}
    ```

    Parameters:
    :   * **subject\_dir** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – If False, downstream path generator will not include the subject dir
          sub-{subject}/\*
        * **session\_dir** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")*,* *optional*) – If False, downstream path generator will not include the session dir
          \*/ses-{session}/\*

    Return type:
    :   [list](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")[[*BidsPathEntitySpec*](#snakebids.paths.BidsPathEntitySpec "snakebids.paths._utils.BidsPathEntitySpec")]

snakebids.paths.specs.latest()[¶](#snakebids.paths.specs.latest "Link to this definition")
:   Points to the most recent spec

## Types[¶](#types "Link to this heading")

*class* snakebids.BidsFunction(*\*args*, *\*\*kwargs*)[¶](#snakebids.BidsFunction "Link to this definition")
:   Signature for functions returned by `bids_factory`.

    See [`bids()`](#snakebids.bids "snakebids.bids") for more details

*class* snakebids.paths.BidsPathEntitySpec[¶](#snakebids.paths.BidsPathEn