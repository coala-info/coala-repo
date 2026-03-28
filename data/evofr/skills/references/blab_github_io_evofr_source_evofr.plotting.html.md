[evofr](../index.html)

Contents

* [Installation Guide](../installation.html)
* [API Reference](../api_reference.html)
* [Getting started with `evofr`](../notebooks/example_mlr.html)

[evofr](../index.html)

* [API Reference](../api_reference.html)
* evofr.plotting package
* [View page source](../_sources/source/evofr.plotting.rst.txt)

---

# evofr.plotting package[](#evofr-plotting-package "Link to this heading")

## Submodules[](#submodules "Link to this heading")

## evofr.plotting.plot\_functions module[](#module-evofr.plotting.plot_functions "Link to this heading")

add\_dates(*ax*, *dates*, *sep=1*)[](#evofr.plotting.plot_functions.add_dates "Link to this definition")

add\_dates\_sep(*ax*, *dates*, *sep=7*)[](#evofr.plotting.plot_functions.add_dates_sep "Link to this definition")

plot\_R(*ax*, *samples*, *ps*, *alphas*, *colors*, *forecast=False*, *plot\_neutral\_line=True*)[](#evofr.plotting.plot_functions.plot_R "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **colors** (*List**[**str**]*)
        * **forecast** (*bool* *|* *None*)
        * **plot\_neutral\_line** (*bool* *|* *None*)

plot\_R\_censored(*ax*, *samples*, *ps*, *alphas*, *colors*, *forecast=False*, *thres=0.001*, *plot\_neutral\_line=True*)[](#evofr.plotting.plot_functions.plot_R_censored "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **colors** (*List**[**str**]*)
        * **forecast** (*bool* *|* *None*)
        * **thres** (*float* *|* *None*)
        * **plot\_neutral\_line** (*bool* *|* *None*)

plot\_cases(*ax*, *LD*)[](#evofr.plotting.plot_functions.plot_cases "Link to this definition")

plot\_ga\_time\_censored(*ax*, *samples*, *ps*, *alphas*, *colors*, *forecast=False*, *thres=0.001*, *plot\_pivot\_line=True*, *dates=None*)[](#evofr.plotting.plot_functions.plot_ga_time_censored "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **colors** (*List**[**str**]*)
        * **forecast** (*bool* *|* *None*)
        * **thres** (*float* *|* *None*)
        * **plot\_pivot\_line** (*bool* *|* *None*)
        * **dates** (*List* *|* *None*)

plot\_growth\_advantage(*ax*, *samples*, *LD*, *ps*, *alphas*, *colors*, *plot\_pivot\_line=True*)[](#evofr.plotting.plot_functions.plot_growth_advantage "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **colors** (*List**[**str**]*)
        * **plot\_pivot\_line** (*bool* *|* *None*)

plot\_little\_r\_censored(*ax*, *samples*, *ps*, *alphas*, *colors*, *forecast=False*, *thres=0.001*, *plot\_neutral\_line=False*)[](#evofr.plotting.plot_functions.plot_little_r_censored "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **colors** (*List**[**str**]*)
        * **forecast** (*bool* *|* *None*)
        * **thres** (*float* *|* *None*)
        * **plot\_neutral\_line** (*bool* *|* *None*)

plot\_observed\_frequency(*ax*, *LD*, *colors*)[](#evofr.plotting.plot_functions.plot_observed_frequency "Link to this definition")
:   Parameters:
    :   **colors** (*List**[**str**]*)

plot\_observed\_frequency\_size(*ax*, *LD*, *colors*, *size*)[](#evofr.plotting.plot_functions.plot_observed_frequency_size "Link to this definition")
:   Parameters:
    :   * **colors** (*List**[**str**]*)
        * **size** (*Callable*)

plot\_posterior\_I(*ax*, *samples*, *ps*, *alphas*, *colors*, *forecast=False*)[](#evofr.plotting.plot_functions.plot_posterior_I "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **colors** (*List**[**str**]*)
        * **forecast** (*bool* *|* *None*)

plot\_posterior\_average\_R(*ax*, *samples*, *ps*, *alphas*, *color*, *plot\_neutral\_line=True*)[](#evofr.plotting.plot_functions.plot_posterior_average_R "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **color** (*str*)
        * **plot\_neutral\_line** (*bool* *|* *None*)

plot\_posterior\_frequency(*ax*, *samples*, *ps*, *alphas*, *colors*, *forecast=False*)[](#evofr.plotting.plot_functions.plot_posterior_frequency "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **colors** (*List**[**str**]*)
        * **forecast** (*bool* *|* *None*)

plot\_posterior\_smooth\_EC(*ax*, *samples*, *ps*, *alphas*, *color*)[](#evofr.plotting.plot_functions.plot_posterior_smooth_EC "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **color** (*str*)

plot\_posterior\_time(*ax*, *t*, *med*, *quants*, *alphas*, *colors*, *included=None*)[](#evofr.plotting.plot_functions.plot_posterior_time "Link to this definition")
:   Loop over variants to plot medians and quantiles at specifed points.
    Plots all time points unless time points to be included
    are specified in ‘included’.

    Parameters:
    :   * **ax** – Matplotlib axis to plot on.
        * **t** – Time points to plot over.
        * **med** – Median values.
        * **quants** – Quantiles to be plotted. Organized as a list of CIs as Arrays.
        * **alphas** (*List**[**float**]*) – Transparency for each quantile.
        * **colors** (*List**[**str**]*) – List of colors to use for each variant.
        * **included** (*List**[**bool**]* *|* *None*) – optional list of bools which determine
          which time points and variants to include observations from.

plot\_ppc\_cases(*ax*, *samples*, *ps*, *alphas*, *color*)[](#evofr.plotting.plot_functions.plot_ppc_cases "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **color** (*str*)

plot\_ppc\_frequency(*ax*, *samples*, *LD*, *ps*, *alphas*, *colors*, *forecast=False*)[](#evofr.plotting.plot_functions.plot_ppc_frequency "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **colors** (*List**[**str**]*)
        * **forecast** (*bool* *|* *None*)

plot\_ppc\_seq\_counts(*ax*, *samples*, *ps*, *alphas*, *colors*, *forecast=False*)[](#evofr.plotting.plot_functions.plot_ppc_seq_counts "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **colors** (*List**[**str**]*)
        * **forecast** (*bool* *|* *None*)

plot\_site(*ax*, *site*, *samples*, *ps*, *alphas*, *colors*, *forecast*, *times*)[](#evofr.plotting.plot_functions.plot_site "Link to this definition")

plot\_time\_varying\_single(*ax*, *site*, *samples*, *ps*, *alphas*, *color*)[](#evofr.plotting.plot_functions.plot_time_varying_single "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **color** (*str*)

plot\_time\_varying\_variant(*ax*, *site*, *samples*, *ps*, *alphas*, *colors*, *forecast=False*)[](#evofr.plotting.plot_functions.plot_time_varying_variant "Link to this definition")
:   Parameters:
    :   * **ps** (*List**[**float**]*)
        * **alphas** (*List**[**float**]*)
        * **colors** (*List**[**str**]*)
        * **forecast** (*bool* *|* *None*)

plot\_total\_by\_median\_frequency(*ax*, *samples*, *LD*, *total*, *colors*)[](#evofr.plotting.plot_functions.plot_total_by_median_frequency "Link to this definition")
:   Parameters:
    :   **colors** (*List**[**str**]*)

plot\_total\_by\_obs\_frequency(*ax*, *LD*, *total*, *colors*)[](#evofr.plotting.plot_functions.plot_total_by_obs_frequency "Link to this definition")
:   Parameters:
    :   **colors** (*List**[**str**]*)

prep\_posterior\_for\_plot(*site*, *samples*, *ps*, *forecast=False*)[](#evofr.plotting.plot_functions.prep_posterior_for_plot "Link to this definition")
:   Prep posteriors for plotting by finding time span, medians, and quantiles.

    Parameters:
    :   * **site** – Name of the site to access from samples.
        * **samples** – Dictionary with keys being site or variable names.
          Values are Arrays containing posterior samples
          with shape (sample\_number, site\_shape).
        * **ps** (*List**[**float**]*) – Levels of confidence to generate quantiles for.
        * **forecast** (*bool* *|* *None*) – Prep posterior for forecasts? Defaults to False.

## Module contents[](#module-evofr.plotting "Link to this heading")

[Previous](evofr.posterior.html "evofr.posterior package")
[Next](../notebooks/example_mlr.html "Getting started with evofr")

---

© Copyright 2025, Marlin Figgins.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).