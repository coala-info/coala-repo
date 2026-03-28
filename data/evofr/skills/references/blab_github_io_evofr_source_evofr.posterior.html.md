[evofr](../index.html)

Contents

* [Installation Guide](../installation.html)
* [API Reference](../api_reference.html)
* [Getting started with `evofr`](../notebooks/example_mlr.html)

[evofr](../index.html)

* [API Reference](../api_reference.html)
* evofr.posterior package
* [View page source](../_sources/source/evofr.posterior.rst.txt)

---

# evofr.posterior package[](#evofr-posterior-package "Link to this heading")

## Submodules[](#submodules "Link to this heading")

## evofr.posterior.posterior\_handler module[](#module-evofr.posterior.posterior_handler "Link to this heading")

*class* MultiPosterior(*posteriors=None*, *posterior=None*)[](#evofr.posterior.posterior_handler.MultiPosterior "Link to this definition")
:   Bases: `object`

    Parameters:
    :   * **posteriors** (*List**[*[*PosteriorHandler*](#evofr.posterior.posterior_handler.PosteriorHandler "evofr.posterior.posterior_handler.PosteriorHandler")*]* *|* *None*)
        * **posterior** ([*PosteriorHandler*](#evofr.posterior.posterior_handler.PosteriorHandler "evofr.posterior.posterior_handler.PosteriorHandler") *|* *None*)

    add\_posterior(*posterior*)[](#evofr.posterior.posterior_handler.MultiPosterior.add_posterior "Link to this definition")
    :   Add PosteriorHandler to MultiPosterior by its name.

        Parameters:
        :   **posterior** ([*PosteriorHandler*](#evofr.posterior.posterior_handler.PosteriorHandler "evofr.posterior.posterior_handler.PosteriorHandler"))

    add\_posteriors(*posteriors*)[](#evofr.posterior.posterior_handler.MultiPosterior.add_posteriors "Link to this definition")
    :   Add multiple PosteriorHandlers to MultiPosterior by name.

        Parameters:
        :   **posteriors** (*List**[*[*PosteriorHandler*](#evofr.posterior.posterior_handler.PosteriorHandler "evofr.posterior.posterior_handler.PosteriorHandler")*]*)

    get(*name*)[](#evofr.posterior.posterior_handler.MultiPosterior.get "Link to this definition")
    :   Return PosteriorHandler by name

*class* PosteriorHandler(*samples=None*, *data=None*, *name=None*)[](#evofr.posterior.posterior_handler.PosteriorHandler "Link to this definition")
:   Bases: `object`

    Parameters:
    :   * **samples** (*Dict* *|* *None*)
        * **data** ([*DataSpec*](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec") *|* *None*)
        * **name** (*str* *|* *None*)

    get\_data\_dict()[](#evofr.posterior.posterior_handler.PosteriorHandler.get_data_dict "Link to this definition")
    :   Convert dataspec to corresponding dictionary.

    get\_site(*site*)[](#evofr.posterior.posterior_handler.PosteriorHandler.get_site "Link to this definition")
    :   Get samples at a given site from PosteriorHandler.

        Parameters:
        :   **site** (*str*)

    load\_posterior(*filepath*, *method=None*)[](#evofr.posterior.posterior_handler.PosteriorHandler.load_posterior "Link to this definition")
    :   Load posterior samples from a given filepath.

        Parameters:
        :   **filepath** (*str*)

    save\_posterior(*filepath*, *method=None*)[](#evofr.posterior.posterior_handler.PosteriorHandler.save_posterior "Link to this definition")
    :   Parameters:
        :   **filepath** (*str*)

    unpack\_posterior()[](#evofr.posterior.posterior_handler.PosteriorHandler.unpack_posterior "Link to this definition")
    :   Return samples and dataspec from PosteriorHandler.

determine\_method(*filepath*)[](#evofr.posterior.posterior_handler.determine_method "Link to this definition")
:   Determines the serialization method based on the file extension.

    Parameters:
    :   **filepath** (*str*) – The path of the file including its extension.

    Returns:
    :   The serialization method (“json” or “pickle”).

    Return type:
    :   str

    Raises:
    :   **ValueError** – If the file extension is not recognized.

load\_data(*filename*, *method='json'*)[](#evofr.posterior.posterior_handler.load_data "Link to this definition")
:   Load data from a file using either JSON or pickle based on the user’s choice.

    Parameters:
    - filename: The filename from which the data will be loaded.
    - method: The serialization method (‘json’ or ‘pickle’).

    Returns:
    - The data loaded from the file.

    Raises:
    - ValueError: If the provided method is not supported.

save\_data(*data*, *filename*, *method='json'*)[](#evofr.posterior.posterior_handler.save_data "Link to this definition")
:   Save data to a file using either JSON or pickle based on the user’s choice.

    Parameters:
    - data: The data to be serialized and saved.
    - filename: The filename where the data will be saved.
    - method: The serialization method (‘json’ or ‘pickle’).

    Raises:
    - ValueError: If the provided method is not supported.

## evofr.posterior.posterior\_helpers module[](#module-evofr.posterior.posterior_helpers "Link to this heading")

*class* EvofrEncoder(*\**, *skipkeys=False*, *ensure\_ascii=True*, *check\_circular=True*, *allow\_nan=True*, *sort\_keys=False*, *indent=None*, *separators=None*, *default=None*)[](#evofr.posterior.posterior_helpers.EvofrEncoder "Link to this definition")
:   Bases: `JSONEncoder`

    default(*obj*)[](#evofr.posterior.posterior_helpers.EvofrEncoder.default "Link to this definition")
    :   Implement this method in a subclass such that it returns
        a serializable object for `o`, or calls the base implementation
        (to raise a `TypeError`).

        For example, to support arbitrary iterators, you could
        implement default like this:

        ```
        def default(self, o):
            try:
                iterable = iter(o)
            except TypeError:
                pass
            else:
                return list(iterable)
            # Let the base class default method raise the TypeError
            return super().default(o)
        ```

combine\_sites\_tidy(*tidy\_dicts*)[](#evofr.posterior.posterior_helpers.combine_sites_tidy "Link to this definition")

get\_freq(*samples*, *data*, *ps*, *name*, *forecast=False*)[](#evofr.posterior.posterior_helpers.get_freq "Link to this definition")
:   Parameters:
    :   * **samples** (*Dict*)
        * **data** ([*DataSpec*](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec"))

get\_growth\_advantage(*samples*, *data*, *ps*, *name*, *rel\_to=None*)[](#evofr.posterior.posterior_helpers.get_growth_advantage "Link to this definition")

get\_median(*samples*, *site*)[](#evofr.posterior.posterior_helpers.get_median "Link to this definition")
:   Returns median value across all samples for a site

    Parameters:
    :   **samples** (*Dict*)

get\_quantile(*samples*, *p*, *site*)[](#evofr.posterior.posterior_helpers.get_quantile "Link to this definition")
:   Returns credible interval of size ‘p’ from ‘samples’ at ‘site’.

    Parameters:
    :   * **samples** (*Dict*) – Dictionary with keys being site or variable names.
          Values are Arrays with shape (sample\_number, site\_shape).
        * **p** – Percent credible interval to return.
        * **site** – Name of variable to generate credible interval for.

    Return type:
    :   Array of shape (site\_shape).

get\_quantiles(*samples*, *ps*, *site*)[](#evofr.posterior.posterior_helpers.get_quantiles "Link to this definition")
:   Returns credible interval of sizes ‘ps’ from ‘samples’ at ‘site’.

    Parameters:
    :   **samples** (*Dict*)

get\_site\_by\_variant(*samples*, *data*, *ps*, *name*, *site*, *forecast=False*)[](#evofr.posterior.posterior_helpers.get_site_by_variant "Link to this definition")
:   Parameters:
    :   * **samples** (*Dict*)
        * **data** ([*DataSpec*](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec"))

get\_sites\_quantiles\_json(*samples*, *data*, *sites*, *ps*, *name=None*)[](#evofr.posterior.posterior_helpers.get_sites_quantiles_json "Link to this definition")
:   Parameters:
    :   * **samples** (*Dict*)
        * **data** ([*DataSpec*](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec"))
        * **sites** (*List**[**str**]*)
        * **name** (*str* *|* *None*)

get\_sites\_variants\_json(*samples*, *data*, *sites*, *ps*, *name=None*)[](#evofr.posterior.posterior_helpers.get_sites_variants_json "Link to this definition")
:   Parameters:
    :   * **samples** (*Dict*)
        * **data** ([*DataSpec*](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec"))
        * **sites** (*List**[**str**]*)
        * **name** (*str* *|* *None*)

get\_sites\_variants\_tidy(*samples*, *data*, *sites*, *dated*, *forecasts*, *ps*, *name=None*)[](#evofr.posterior.posterior_helpers.get_sites_variants_tidy "Link to this definition")
:   Parameters:
    :   * **samples** (*Dict*)
        * **data** ([*DataSpec*](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec"))
        * **sites** (*List**[**str**]*)
        * **dated** (*List**[**bool**]*)
        * **forecasts** (*List**[**bool**]*)
        * **name** (*str* *|* *None*)

save\_json(*out*, *path*)[](#evofr.posterior.posterior_helpers.save_json "Link to this definition")
:   Parameters:
    :   **out** (*dict*)

    Return type:
    :   None

## Module contents[](#module-evofr.posterior "Link to this heading")

[Previous](evofr.infer.html "evofr.infer package")
[Next](evofr.plotting.html "evofr.plotting package")

---

© Copyright 2025, Marlin Figgins.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).