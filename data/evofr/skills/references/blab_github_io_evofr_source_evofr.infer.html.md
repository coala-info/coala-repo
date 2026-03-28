[evofr](../index.html)

Contents

* [Installation Guide](../installation.html)
* [API Reference](../api_reference.html)
* [Getting started with `evofr`](../notebooks/example_mlr.html)

[evofr](../index.html)

* [API Reference](../api_reference.html)
* evofr.infer package
* [View page source](../_sources/source/evofr.infer.rst.txt)

---

# evofr.infer package[](#evofr-infer-package "Link to this heading")

## Submodules[](#submodules "Link to this heading")

## evofr.infer.BJBackendsScrap module[](#evofr-infer-bjbackendsscrap-module "Link to this heading")

## evofr.infer.InferMCMC module[](#module-evofr.infer.InferMCMC "Link to this heading")

*class* InferMCMC(*num\_warmup*, *num\_samples*, *kernel*, *\*\*kernel\_kwargs*)[](#evofr.infer.InferMCMC.InferMCMC "Link to this definition")
:   Bases: `object`

    Parameters:
    :   * **num\_warmup** (*int*)
        * **num\_samples** (*int*)
        * **kernel** (*Type**[**MCMCKernel**]*)

    fit(*model*, *data*, *name=None*)[](#evofr.infer.InferMCMC.InferMCMC.fit "Link to this definition")
    :   Fit model given data using specificed MCMC method.

        Parameters:
        :   * **model** ([*ModelSpec*](evofr.models.html#evofr.models.model_spec.ModelSpec "evofr.models.model_spec.ModelSpec")) – ModelSpec for model
            * **data** ([*DataSpec*](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec")) – DataSpec for data to do inference on
            * **name** (*str* *|* *None*) – name used to index posterior

        Return type:
        :   [PosteriorHandler](evofr.posterior.html#evofr.posterior.posterior_handler.PosteriorHandler "evofr.posterior.posterior_handler.PosteriorHandler")

*class* InferNUTS(*num\_warmup*, *num\_samples*, *\*\*kernel\_kwargs*)[](#evofr.infer.InferMCMC.InferNUTS "Link to this definition")
:   Bases: [`InferMCMC`](#evofr.infer.InferMCMC.InferMCMC "evofr.infer.InferMCMC.InferMCMC")

    Parameters:
    :   * **num\_warmup** (*int*)
        * **num\_samples** (*int*)

*class* InferNUTS\_from\_MAP(*num\_warmup*, *num\_samples*, *iters*, *lr*)[](#evofr.infer.InferMCMC.InferNUTS_from_MAP "Link to this definition")
:   Bases: `object`

    fit(*model*, *data*, *name=None*)[](#evofr.infer.InferMCMC.InferNUTS_from_MAP.fit "Link to this definition")

## evofr.infer.InferSVI module[](#module-evofr.infer.InferSVI "Link to this heading")

*class* InferFullRank(*iters*, *lr*, *num\_samples*, *\*\*handler\_kwargs*)[](#evofr.infer.InferSVI.InferFullRank "Link to this definition")
:   Bases: [`InferSVI`](#evofr.infer.InferSVI.InferSVI "evofr.infer.InferSVI.InferSVI")

    Parameters:
    :   * **iters** (*int*)
        * **lr** (*float*)
        * **num\_samples** (*int*)

*class* InferMAP(*iters*, *lr*, *\*\*handler\_kwargs*)[](#evofr.infer.InferSVI.InferMAP "Link to this definition")
:   Bases: [`InferSVI`](#evofr.infer.InferSVI.InferSVI "evofr.infer.InferSVI.InferSVI")

    Parameters:
    :   * **iters** (*int*)
        * **lr** (*float*)

*class* InferSVI(*iters*, *lr*, *num\_samples*, *guide\_fn*, *\*\*handler\_kwargs*)[](#evofr.infer.InferSVI.InferSVI "Link to this definition")
:   Bases: `object`

    Parameters:
    :   * **iters** (*int*)
        * **lr** (*float*)
        * **num\_samples** (*int*)
        * **guide\_fn** (*Type**[**AutoGuide**]*)

    fit(*model*, *data*, *name=None*)[](#evofr.infer.InferSVI.InferSVI.fit "Link to this definition")
    :   Fit model given data using specificed SVI method.

        Parameters:
        :   * **model** ([*ModelSpec*](evofr.models.html#evofr.models.model_spec.ModelSpec "evofr.models.model_spec.ModelSpec")) – ModelSpec for model
            * **data** ([*DataSpec*](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec")) – DataSpec for data to do inference on
            * **name** (*str* *|* *None*) – name used to index posterior

        Return type:
        :   [PosteriorHandler](evofr.posterior.html#evofr.posterior.posterior_handler.PosteriorHandler "evofr.posterior.posterior_handler.PosteriorHandler")

init\_to\_MAP(*model*, *data*, *iters=10000*, *lr=0.004*)[](#evofr.infer.InferSVI.init_to_MAP "Link to this definition")
:   Initilization strategy for MCMC.
    Estimates MAP for given model and data.
    Returns initilization strategy and MAP estimates.

    Parameters:
    :   * **model** ([*ModelSpec*](evofr.models.html#evofr.models.model_spec.ModelSpec "evofr.models.model_spec.ModelSpec"))
        * **data** ([*DataSpec*](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec"))
        * **iters** (*int*)
        * **lr** (*float*)

## evofr.infer.MCMC\_handler module[](#module-evofr.infer.MCMC_handler "Link to this heading")

*class* MCMCHandler(*rng\_key=None*, *kernel=None*, *\*\*kernel\_kwargs*)[](#evofr.infer.MCMC_handler.MCMCHandler "Link to this definition")
:   Bases: `object`

    Parameters:
    :   * **rng\_key** (*Array* *|* *None*)
        * **kernel** (*Type**[**MCMCKernel**]* *|* *None*)

    fit(*model*, *data*, *num\_warmup*, *num\_samples*, *\*\*mcmc\_kwargs*)[](#evofr.infer.MCMC_handler.MCMCHandler.fit "Link to this definition")
    :   Fit model using MCMC given data.

        model:
        :   a numpyro model.

        data:
        :   dictionary containing arguments to ‘model’.

        num\_warmup:
        :   number of samples for warmup period in MCMC.

        num\_samples:
        :   number of samples to be returned in MCMC.

        mcmc\_kwargs:
        :   additional arguments to be passed to MCMC algorithms.

        Parameters:
        :   * **model** (*Callable*)
            * **data** (*Dict*)
            * **num\_warmup** (*int*)
            * **num\_samples** (*int*)

    load\_state(*file\_path*)[](#evofr.infer.MCMC_handler.MCMCHandler.load_state "Link to this definition")

    *property* params*: Dict*[](#evofr.infer.MCMC_handler.MCMCHandler.params "Link to this definition")

    predict(*model*, *data*, *\*\*kwargs*)[](#evofr.infer.MCMC_handler.MCMCHandler.predict "Link to this definition")
    :   Parameters:
        :   * **model** (*Callable*)
            * **data** (*Dict*)

    save\_state(*file\_path*)[](#evofr.infer.MCMC_handler.MCMCHandler.save_state "Link to this definition")

## evofr.infer.SVI\_handler module[](#module-evofr.infer.SVI_handler "Link to this heading")

*class* SVIHandler(*rng\_key=None*, *loss=None*, *optimizer=None*)[](#evofr.infer.SVI_handler.SVIHandler "Link to this definition")
:   Bases: `object`

    Parameters:
    :   * **rng\_key** (*Array* *|* *None*)
        * **loss** (*Trace\_ELBO* *|* *None*)
        * **optimizer** (*Any* *|* *None*)

    fit(*model*, *guide*, *data*, *n\_epochs*)[](#evofr.infer.SVI_handler.SVIHandler.fit "Link to this definition")
    :   Parameters:
        :   * **model** (*Callable*)
            * **guide** (*AutoGuide*)
            * **data** (*dict*)
            * **n\_epochs** (*int*)

    init\_svi(*model*, *guide*, *data*)[](#evofr.infer.SVI_handler.SVIHandler.init_svi "Link to this definition")
    :   Parameters:
        :   * **model** (*Callable*)
            * **guide** (*AutoGuide*)
            * **data** (*dict*)

    load\_state(*fp*)[](#evofr.infer.SVI_handler.SVIHandler.load_state "Link to this definition")

    *property* losses[](#evofr.infer.SVI_handler.SVIHandler.losses "Link to this definition")

    *property* optim\_state[](#evofr.infer.SVI_handler.SVIHandler.optim_state "Link to this definition")

    *property* params[](#evofr.infer.SVI_handler.SVIHandler.params "Link to this definition")

    predict(*model*, *guide*, *data*, *\*\*kwargs*)[](#evofr.infer.SVI_handler.SVIHandler.predict "Link to this definition")

    reset\_state()[](#evofr.infer.SVI_handler.SVIHandler.reset_state "Link to this definition")

    save\_state(*fp*)[](#evofr.infer.SVI_handler.SVIHandler.save_state "Link to this definition")

## Module contents[](#module-evofr.infer "Link to this heading")

[Previous](evofr.models.renewal_model.basis_functions.html "evofr.models.renewal_model.basis_functions package")
[Next](evofr.posterior.html "evofr.posterior package")

---

© Copyright 2025, Marlin Figgins.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).