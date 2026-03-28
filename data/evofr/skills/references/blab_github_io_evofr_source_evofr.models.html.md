[evofr](../index.html)

Contents

* [Installation Guide](../installation.html)
* [API Reference](../api_reference.html)
* [Getting started with `evofr`](../notebooks/example_mlr.html)

[evofr](../index.html)

* [API Reference](../api_reference.html)
* evofr.models package
* [View page source](../_sources/source/evofr.models.rst.txt)

---

# evofr.models package[](#evofr-models-package "Link to this heading")

## Subpackages[](#subpackages "Link to this heading")

* [evofr.models.renewal\_model package](evofr.models.renewal_model.html)
  + [Subpackages](evofr.models.renewal_model.html#subpackages)
  + [Submodules](evofr.models.renewal_model.html#submodules)
  + [evofr.models.renewal\_model.LAS module](evofr.models.renewal_model.html#module-evofr.models.renewal_model.LAS)
  + [evofr.models.renewal\_model.model\_factories module](evofr.models.renewal_model.html#module-evofr.models.renewal_model.model_factories)
  + [evofr.models.renewal\_model.model\_functions module](evofr.models.renewal_model.html#module-evofr.models.renewal_model.model_functions)
  + [evofr.models.renewal\_model.model\_helpers module](evofr.models.renewal_model.html#module-evofr.models.renewal_model.model_helpers)
  + [evofr.models.renewal\_model.model\_options module](evofr.models.renewal_model.html#module-evofr.models.renewal_model.model_options)
  + [evofr.models.renewal\_model.renewal\_model module](evofr.models.renewal_model.html#module-evofr.models.renewal_model.renewal_model)
  + [evofr.models.renewal\_model.renewal\_regression module](evofr.models.renewal_model.html#module-evofr.models.renewal_model.renewal_regression)
  + [evofr.models.renewal\_model.renewal\_single\_variant module](evofr.models.renewal_model.html#module-evofr.models.renewal_model.renewal_single_variant)
  + [evofr.models.renewal\_model.spline\_incidence module](evofr.models.renewal_model.html#module-evofr.models.renewal_model.spline_incidence)
  + [Module contents](evofr.models.renewal_model.html#module-evofr.models.renewal_model)

## Submodules[](#submodules "Link to this heading")

## evofr.models.mlr\_hierarchical module[](#module-evofr.models.mlr_hierarchical "Link to this heading")

*class* HierMLR(*tau*, *pool\_scale=None*, *xi\_prior=None*, *xi\_by\_group=False*)[](#evofr.models.mlr_hierarchical.HierMLR "Link to this definition")
:   Bases: [`ModelSpec`](#evofr.models.model_spec.ModelSpec "evofr.models.model_spec.ModelSpec")

    Parameters:
    :   * **tau** (*float*)
        * **pool\_scale** (*float* *|* *None*)
        * **xi\_prior** (*float* *|* *None*)
        * **xi\_by\_group** (*bool*)

    augment\_data(*data*)[](#evofr.models.mlr_hierarchical.HierMLR.augment_data "Link to this definition")
    :   Augments existing data for inference with model specific information.

        Parameters:
        :   **data** (*dict*)

        Return type:
        :   None

    *static* forecast\_frequencies(*samples*, *forecast\_L*)[](#evofr.models.mlr_hierarchical.HierMLR.forecast_frequencies "Link to this definition")
    :   Use posterior beta to forecast posterior frequencies.

    *static* make\_ols\_feature(*start*, *stop*, *n\_groups*)[](#evofr.models.mlr_hierarchical.HierMLR.make_ols_feature "Link to this definition")
    :   Construct simple OLS features (1, x) for HierMLR as nd.array.

        Parameters:
        :   * **start** – Start value for OLS feature.
            * **stop** – Stop value for OLS feature.
            * **n\_groups** – number of groups in the hierarchical model.

hier\_MLR\_numpyro(*seq\_counts*, *N*, *X*, *tau=None*, *pool\_scale=None*, *xi\_prior=None*, *xi\_by\_group=False*, *pred=False*, *var\_names=None*)[](#evofr.models.mlr_hierarchical.hier_MLR_numpyro "Link to this definition")

simulate\_hier\_mlr(*growth\_advantages*, *freq0*, *tau*, *Ns*)[](#evofr.models.mlr_hierarchical.simulate_hier_mlr "Link to this definition")

## evofr.models.mlr\_innovation module[](#module-evofr.models.mlr_innovation "Link to this heading")

*class* DeltaNormalPrior(*loc=None*, *scale=None*)[](#evofr.models.mlr_innovation.DeltaNormalPrior "Link to this definition")
:   Bases: [`DeltaPriorModel`](#evofr.models.mlr_innovation.DeltaPriorModel "evofr.models.mlr_innovation.DeltaPriorModel")

    Parameters:
    :   * **loc** (*float* *|* *None*)
        * **scale** (*float* *|* *None*)

    model(*N\_variants*)[](#evofr.models.mlr_innovation.DeltaNormalPrior.model "Link to this definition")

*class* DeltaPriorModel[](#evofr.models.mlr_innovation.DeltaPriorModel "Link to this definition")
:   Bases: `ABC`

    *abstract* model()[](#evofr.models.mlr_innovation.DeltaPriorModel.model "Link to this definition")

*class* DeltaRegressionPrior(*features*)[](#evofr.models.mlr_innovation.DeltaRegressionPrior "Link to this definition")
:   Bases: [`DeltaPriorModel`](#evofr.models.mlr_innovation.DeltaPriorModel "evofr.models.mlr_innovation.DeltaPriorModel")

    model(*N\_variants*)[](#evofr.models.mlr_innovation.DeltaRegressionPrior.model "Link to this definition")

    predict(*features*, *samples*)[](#evofr.models.mlr_innovation.DeltaRegressionPrior.predict "Link to this definition")

*class* InnovationMLR(*tau*, *delta\_prior=None*)[](#evofr.models.mlr_innovation.InnovationMLR "Link to this definition")
:   Bases: [`ModelSpec`](#evofr.models.model_spec.ModelSpec "evofr.models.model_spec.ModelSpec")

    Parameters:
    :   * **tau** (*float*)
        * **delta\_prior** ([*DeltaPriorModel*](#evofr.models.mlr_innovation.DeltaPriorModel "evofr.models.mlr_innovation.DeltaPriorModel") *|* *None*)

    augment\_data(*data*)[](#evofr.models.mlr_innovation.InnovationMLR.augment_data "Link to this definition")
    :   Augments existing data for inference with model specific information.

        Parameters:
        :   **data** (*dict*)

        Return type:
        :   None

*class* InnovationSequenceCounts(*raw\_seq*, *raw\_variant\_parents*, *date\_to\_index=None*, *var\_names=None*, *pivot=None*)[](#evofr.models.mlr_innovation.InnovationSequenceCounts "Link to this definition")
:   Bases: [`DataSpec`](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec")

    Parameters:
    :   * **raw\_seq** (*DataFrame*)
        * **raw\_variant\_parents** (*DataFrame*)
        * **date\_to\_index** (*dict* *|* *None*)
        * **var\_names** (*List* *|* *None*)
        * **pivot** (*str* *|* *None*)

    make\_data\_dict(*data=None*)[](#evofr.models.mlr_innovation.InnovationSequenceCounts.make_data_dict "Link to this definition")
    :   Get arguments to be passed to numpyro models as a dictionary.

        Parameters:
        :   **data** (*dict* *|* *None*) – Optional dictionary to add arguments to.

        Returns:
        :   Dictionary containing arguments.

        Return type:
        :   dict

MLR\_innovation\_model(*seq\_counts*, *N*, *X*, *innovation\_matrix*, *delta\_prior*, *tau=None*, *pred=False*)[](#evofr.models.mlr_innovation.MLR_innovation_model "Link to this definition")

MLR\_innovation\_model\_time\_varying(*seq\_counts*, *N*, *innovation\_matrix*, *delta\_prior*, *tau=None*, *pred=False*)[](#evofr.models.mlr_innovation.MLR_innovation_model_time_varying "Link to this definition")

prep\_clade\_list(*raw\_variant\_parents*, *var\_names=None*)[](#evofr.models.mlr_innovation.prep_clade_list "Link to this definition")
:   Process ‘raw\_variant\_parents’ data to nd.array showing
    which innovations present by variant.

    Parameters:
    :   * **raw\_variant\_parents** (*DataFrame*) – a dataframe containing variant name and parent variant
        * **var\_names** (*List* *|* *None*) – optional list of variants
        * **pivot** – optional name of variant to place last.
          Defaults to “other” if present otherwise.
          This will usually used as a reference or pivot strain.

    Returns:
    :   binary matrix showing whether A[i,j] = i has innovation from j.

    Return type:
    :   innovation\_matrix

## evofr.models.mlr\_nowcast module[](#module-evofr.models.mlr_nowcast "Link to this heading")

*class* BetaHazard[](#evofr.models.mlr_nowcast.BetaHazard "Link to this definition")
:   Bases: [`HazardModel`](#evofr.models.mlr_nowcast.HazardModel "evofr.models.mlr_nowcast.HazardModel")

    model(*N\_variants*, *D*)[](#evofr.models.mlr_nowcast.BetaHazard.model "Link to this definition")

*class* DelaySequenceCounts(*raw\_seq*, *date\_to\_index=None*, *var\_names=None*, *max\_delay=None*, *pivot=None*)[](#evofr.models.mlr_nowcast.DelaySequenceCounts "Link to this definition")
:   Bases: [`DataSpec`](evofr.data.html#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec")

    Parameters:
    :   * **raw\_seq** (*DataFrame*)
        * **date\_to\_index** (*dict* *|* *None*)
        * **var\_names** (*List* *|* *None*)
        * **max\_delay** (*int* *|* *None*)
        * **pivot** (*str* *|* *None*)

    make\_data\_dict(*data=None*)[](#evofr.models.mlr_nowcast.DelaySequenceCounts.make_data_dict "Link to this definition")
    :   Get arguments to be passed to numpyro models as a dictionary.

        Parameters:
        :   **data** (*dict* *|* *None*) – Optional dictionary to add arguments to.

        Returns:
        :   Dictionary containing arguments.

        Return type:
        :   dict

*class* HazardModel[](#evofr.models.mlr_nowcast.HazardModel "Link to this definition")
:   Bases: `ABC`

    *abstract* model(*N\_variants*, *D*)[](#evofr.models.mlr_nowcast.HazardModel.model "Link to this definition")

*class* LinearHazard[](#evofr.models.mlr_nowcast.LinearHazard "Link to this definition")
:   Bases: [`HazardModel`](#evofr.models.mlr_nowcast.HazardModel "evofr.models.mlr_nowcast.HazardModel")

    model(*N\_variants*, *D*)[](#evofr.models.mlr_nowcast.LinearHazard.model "Link to this definition")

*class* LogitRWHazard[](#evofr.models.mlr_nowcast.LogitRWHazard "Link to this definition")
:   Bases: [`HazardModel`](#evofr.models.mlr_nowcast.HazardModel "evofr.models.mlr_nowcast.HazardModel")

    model(*N\_variants*, *D*)[](#evofr.models.mlr_nowcast.LogitRWHazard.model "Link to this definition")

*class* LogitSplineHazard(*k=None*, *order=None*, *pool\_scale=None*)[](#evofr.models.mlr_nowcast.LogitSplineHazard "Link to this definition")
:   Bases: [`HazardModel`](#evofr.models.mlr_nowcast.HazardModel "evofr.models.mlr_nowcast.HazardModel")

    Parameters:
    :   * **k** (*int* *|* *None*)
        * **order** (*int* *|* *None*)
        * **pool\_scale** (*float* *|* *None*)

    model(*N\_variants*, *D*)[](#evofr.models.mlr_nowcast.LogitSplineHazard.model "Link to this definition")

*class* MLRNowcast(*tau*, *hazard\_model=None*, *SeqLik=None*)[](#evofr.models.mlr_nowcast.MLRNowcast "Link to this definition")
:   Bases: [`ModelSpec`](#evofr.models.model_spec.ModelSpec "evofr.models.model_spec.ModelSpec")

    Parameters:
    :   * **tau** (*float*)
        * **hazard\_model** ([*HazardModel*](#evofr.models.mlr_nowcast.HazardModel "evofr.models.mlr_nowcast.HazardModel") *|* *None*)

    augment\_data(*data*)[](#evofr.models.mlr_nowcast.MLRNowcast.augment_data "Link to this definition")
    :   Augments existing data for inference with model specific information.

        Parameters:
        :   **data** (*dict*)

        Return type:
        :   None

MLR\_nowcast\_model(*seq\_counts*, *seq\_counts\_delay*, *N*, *X*, *hazard\_model*, *SeqLik*, *tau=None*, *pred=False*)[](#evofr.models.mlr_nowcast.MLR_nowcast_model "Link to this definition")

discrete\_hazard\_to\_pmf\_cdf(*h*)[](#evofr.models.mlr_nowcast.discrete_hazard_to_pmf_cdf "Link to this definition")

estimate\_delay(*seq\_count\_delays*, *hazard\_model*)[](#evofr.models.mlr_nowcast.estimate_delay "Link to this definition")

prep\_sequence\_counts\_delay(*raw\_seqs*, *date\_to\_index=None*, *var\_names=None*, *max\_delay=None*, *pivot=None*)[](#evofr.models.mlr_nowcast.prep_sequence_counts_delay "Link to this definition")
:   Process ‘raw\_seq’ data to nd.array including unobserved dates.

    Parameters:
    :   * **raw\_seq** – a dataframe containing sequence counts with
          columns ‘sequences’ and ‘date’.
        * **raw\_seqs** (*DataFrame*)
        * **date\_to\_index** (*dict* *|* *None*)
        * **var\_names** (*List* *|* *None*)
        * **max\_delay** (*int* *|* *None*)
        * **pivot** (*str* *|* *None*)

    date\_to\_index:
    :   optional dictionary for mapping calender dates to nd.array indices.

    var\_names:
    :   optional list of variant to count observations.

    pivot:
    :   optional name of variant to place last.
        Defaults to “other” if present otherwise.
        This will usually used as a reference or pivot strain.

    Returns:
    :   * *var\_names* – list of variants counted
        * *C* – nd.array containing number of sequences of each variant on each date.

    Parameters:
    :   * **raw\_seqs** (*DataFrame*)
        * **date\_to\_index** (*dict* *|* *None*)
        * **var\_names** (*List* *|* *None*)
        * **max\_delay** (*int* *|* *None*)
        * **pivot** (*str* *|* *None*)

## evofr.models.mlr\_spline module[](#module-evofr.models.mlr_spline "Link to this heading")

*class* MLRSpline(*tau*, *s=None*, *k=None*, *order=None*)[](#evofr.models.mlr_spline.MLRSpline "Link to this definition")
:   Bases: [`ModelSpec`](#evofr.models.model_spec.ModelSpec "evofr.models.model_spec.ModelSpec")

    Parameters:
    :   * **tau** (*float*)
        * **s** (*Array* *|* *None*)
        * **k** (*int* *|* *None*)
        * **order** (*int* *|* *None*)

    augment\_data(*data*)[](#evofr.models.mlr_spline.MLRSpline.augment_data "Link to this definition")
    :   Augments existing data for inference with model specific information.

        Parameters:
        :   **data** (*dict*)

        Return type:
        :   None

MLR\_spline\_numpyro(*seq\_counts*, *N*, *X*, *X\_deriv*, *tau=None*, *pred=False*, *var\_names=None*)[](#evofr.models.mlr_spline.MLR_spline_numpyro "Link to this definition")

## evofr.models.model\_spec module[](#module-evofr.models.model_spec "Link to this heading")

*class* ModelSpec[](#evofr.models.model_spec.ModelSpec "Link to this definition")
:   Bases: `ABC`

    Abstract model class.
    Used by evofr to handle model specifications for inference.
    Classes which inherit from ModelSpec must have an attribute ‘model\_fn’
    which defines the function to be used for inference in numpyro.

    *abstract* augment\_data(*data*)[](#evofr.models.model_spec.ModelSpec.augment_data "Link to this definition")
    :   Augments existing data for inference with model specific information.

        Parameters:
        :   **data** (*dict*)

        Return type:
        :   None

    model\_fn*: Callable*[](#evofr.models.model_spec.ModelSpec.model_fn "Link to this definition")

    registry *= {'DistanceMigrationModel': <class 'evofr.models.migration\_from\_distances.DistanceMigrationModel'>, 'HierMLR': <class 'evofr.models.mlr\_hierarchical.HierMLR'