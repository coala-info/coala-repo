# Introduction to STRUCT - STatistics in R using Class-based Templates

Gavin R Lloyd1\* and Ralf J Weber1\*\*

1Phenome Centre Birmingham, University of Birmingham, UK

\*g.r.lloyd@bham.ac.uk
\*\*r.j.weber@bham.ac.uk

#### 22 December 2025

#### Package

struct 1.22.1

# 1 Introduction

The aim of this vignette is to use `struct` to implement a small set of exemplar objects (i.e. class-based templates) that can be used to conduct exploratory and statistical analysis of a multivariate dataset (e.g. Metabolomics or other omics). A more extensive and advanced use of `struct` templates is provided in the `structToolbox` package, which included quality filters, normalisation, scaling, univariate and multivariate statistics and machine learning methods.

# 2 Getting started

The latest version of `struct` compatible with your current R version can be installed using `BiocManager`.

```
# install BiocManager if not present
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# install structToolbox and dependencies
BiocManager::install("struct")

# install ggplot if not already present
 if (!require('ggplot2')) {
  install.packages('ggplot2')
}
```

The `ggplot2` package is also needed for this vignette.

```
suppressPackageStartupMessages({
  # load the package
  library(struct)

  # load ggplot
  library(ggplot2)
})
```

# 3 `struct` helper functions

‘struct’ provides a number of helper functions that can be used to create a new `struct` object from the command line, or in a script:

* `set_struct_obj()`
  + Used to create a new struct object
* `set_obj_method()`
  + Used to modify a method for a struct object
* `set_obj_show()`
  + Used to modify the displayed output for a struct object

Examples of using these functions to create new `struct` objects based on the provided templates are included in section [5.1](#model).

## 3.1 Creating a new struct object

To create a new struct object use the `set_struct_obj()` function. There are several inputs which are described below.

* `class_name`
  + The name of the new struct object (character).
* `struct_obj`
  + The type of struct object to create e.g. model, iterator, metric, etc.
* `params`
  + A named vector of types for input slots. The names will become slots and the types will be used to determine what type of assignments are allowed to the named slot (e.g. integer, character etc).
* `outputs`
  + As `params`, but for output slots.
* `private`
  + As `params` and `outputs` but for slots that are used internally by the object and not intended for use by the user. These slots are only accessible using @.
* `prototype`
  + A named list of default values for each input/output/private slot. It is good practice to set any initial values for private slots here. It also good practice to set the value for the `predicted` slot here to set the default output of the object.
* `where`
  + Specifies the environment in which the class definition is created. Default is `.GlobalEnv`

Note that slots listed in `params` and `outputs` will be accessible using dollar syntax and are intended to be get/set by the user, while slots named in `private` are only available internally to the developer.

## 3.2 Changing the default methods

All `struct` objects have some default methods that are intended to be “overloaded” i.e. replaced to provide functionality specific to the new object being implemented. The helper function `set_obj_method()` provides this functionality with the following inputs:

* `class_name`
  + The name of the to update the method for.
* `method_name`
  + The name of the method to update. Must be an existing method for the object.
* `definition`
  + The function to replace the method with. This function will be used when the method is called on the object.
* `signature`
  + The classes required for the input arguments.

## 3.3 Changing the default `show` output

All `struct` objects have a default `show` output, which prints the `name` and `description` for an object.

If you want to provide additional information when printing an object then you can overload the `show` method using the `set_obj_show()` function, which has the following inputs:

* `class_name`
  + the name of the class to update the show method for
* `extra_string`:
  + a function that takes the `class_name` object as input and outputs a string

The string output from the `extra_string` function will be appended to the default `show` output.

# 4 Class-based templates and `struct` objects

`struct` provides S4 classes, which can be thought of as extendable templates, for a number of different types of objects. These objects are fundamental components of a data analysis workflow and include:

* `DatasetExperiment` objects
  + An extension of `SummarizedExperiment` objects for holding data and meta data
* `model` objects
  + Used for filtering, normalisation, transformation, classification and others.
* `model_seq` objects
  + A sequence of model objects, used to connect models together.
* `iterator` objects
  + Used for repetitive approaches applied to models and model sequences e.g. cross-validation, resampling, permutations etc.
* `metric` objects
  + Used to define performance metrics for classifiers, regression models etc.
* `chart` objects
  + Used to define model/iterator specific ggplot objects
* `entity` objects
  + Used to define input and output parameters
* `enum` objects
  + Similar to `entity` objects but with a fixed set of allowed values

Each of the templates has a similar structure and a number of template-specific methods defined. They have been designed with the development of data analysis workflows in mind and make it easy to incorporate new methods into the existing framework.

All `struct` objects have a number of common fields or “slots”, which are defined in the base `struct_class` object:

* `name`
  + A short name for the object
* `description`
  + A longer description of what the object does
* `type`
  + A list of keywords for the object, such as ‘classifier’
* `libraries`
  + A list of R packages needed for to use the object
* `citations`
  + A list of citations for the object in `citation` `bibentry` format
* `ontology`
  + A vector of ontology term identifiers for the object

All `struct` objects have a `show` method defined which summarises the object.

```
S = struct_class()
S
```

```
## A "struct_class" object
## -----------------------
## name:
## description:
```

Slots can be set by including them as named inputs when the object is created.

```
S = struct_class(name = 'Example',
                 description = 'An example struct object')
S
```

```
## A "struct_class" object
## -----------------------
## name:          Example
## description:   An example struct object
```

Methods have also been defined so that the value for slots can be set and retrieved using dollar syntax.

```
# set the name
S$name = 'Basic example'

# get the name
S$name
```

```
## [1] "Basic example"
```

In addition to these publicly accessible slots two additional hidden, or internal, slots are defined. These slots are not intended for general access and therefore cannot be accessed using dollar syntax.

* `.params`
  + a list of additional slots that are to be used as input parameters for a `model`, `iterator` or `chart`.
* `.outputs`
  + a list of additional slots that will be used as outputs from a `model` or `iterator`.

Use of these slots will be covered in section [5](#modelobj) as they are only applicable when extending the base `struct_class` template.

## 4.1 `DatasetExperiment` objects

The `DatasetExperiment` object is an extension of `SummarizedExperiment`. It is used to hold measured data and the relevant meta data, such as group labels or feature/variable annotations. All `struct` objects expect the data to be in the `DatasetExperiment` format, with samples in rows and variables/features in columns. As well as the default slots, `DatasetExperiment` objects also have the following additional slots:

* `data`
  + a data.frame containing the measured data. Samples in rows and variables in columns.
* `sample_meta`
  + a data.frame containing meta data related to the samples, such as group labels. The number of rows must be equal to the number of samples.
* `variable_meta`
  + a data.frame containing meta data related to the features, such as annotations. The number of rows must be equal to the number of features.

As for all `struct` objects these slots, as well as the slots from the base class can be assigned during object creation.

```
DE = DatasetExperiment(
  data = iris[,1:4],
  sample_meta=iris[,5,drop=FALSE],
  variable_meta=data.frame('idx'=1:4,row.names=colnames(data)),
  name = "Fisher's iris dataset",
  description = 'The famous one')
DE
```

```
## A "DatasetExperiment" object
## ----------------------------
## name:          Fisher's iris dataset
## description:   The famous one
## data:          150 rows x 4 columns
## sample_meta:   150 rows x 1 columns
## variable_meta: 4 rows x 1 columns
```

A formal version of the iris dataset is included in the `struct` package.

```
DE = iris_DatasetExperiment()
DE
```

```
## A "DatasetExperiment" object
## ----------------------------
## name:          Fisher's Iris dataset
## description:   This famous (Fisher's or Anderson's) iris data set gives the measurements in centimeters of
##                  the variables sepal length and width and petal length and width,
##                  respectively, for 50 flowers from each of 3 species of iris. The species are
##                  Iris setosa, versicolor, and virginica.
## data:          150 rows x 4 columns
## sample_meta:   150 rows x 1 columns
## variable_meta: 4 rows x 1 columns
```

Because `DatasetExperiment` extends `SummarizedExperiment` it inherits functionality such as subsetting, nrow, ncol, etc.

```
# number of columns
ncol(DE)
```

```
## [1] 4
```

```
# number of rows
nrow(DE)
```

```
## [1] 150
```

```
# subset the 2nd and 3rd column
Ds = DE[,c(2,3)]
Ds
```

```
## A "DatasetExperiment" object
## ----------------------------
## name:          Fisher's Iris dataset
## description:   This famous (Fisher's or Anderson's) iris data set gives the measurements in centimeters of
##                  the variables sepal length and width and petal length and width,
##                  respectively, for 50 flowers from each of 3 species of iris. The species are
##                  Iris setosa, versicolor, and virginica.
## data:          150 rows x 2 columns
## sample_meta:   150 rows x 1 columns
## variable_meta: 2 rows x 1 columns
```

The slots are also accessible using dollar syntax.

```
# get data frame
head(DE$data)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width
## 1          5.1         3.5          1.4         0.2
## 2          4.9         3.0          1.4         0.2
## 3          4.7         3.2          1.3         0.2
## 4          4.6         3.1          1.5         0.2
## 5          5.0         3.6          1.4         0.2
## 6          5.4         3.9          1.7         0.4
```

```
# sample meta
head(DE$sample_meta)
```

```
##   Species
## 1  setosa
## 2  setosa
## 3  setosa
## 4  setosa
## 5  setosa
## 6  setosa
```

Note that although technically it is possible to set `data`, `sample_meta` and `variable_meta` using dollar syntax, it is usually better to create a new `DatasetExperiment` and assign them during creation of the object due to the strict definition of a `SummarizedExperiment`.

# 5 `model` objects

Model objects are the most commonly used template as they are the main building block of data analysis workflows. They can be used to implement data processing methods for quality filtering, normalisation, and scaling, as well as methods for statistics and machine learning (e.g. classification, regression and clustering).

`model` objects have three unique slots defined, but they are all related to model sequences, so they are discussed in detail in section [6](#modelseq).

`model` objects also have four methods that are used to actually carry out the intended data analysis method.

* `model_train`
  + A method used to train a model using a `DatasetExperiment` object.
* `model_predict`
  + A method used to apply a trained model to a second `DatasetExperiment` object e.g. a test set.
* `model_apply`
  + Used when training/testing doesn’t fit the type of model e.g. certain types of normalisation. By default this method calls `model_train` and `model_predict` sequentially on the same input data (sometimes called autoprediction).
* `model_reverse`
  + A method generally only used for preprocessing methods where it is advantageous to be able to reverse the processing e.g. after regression so that the predictions are in the input units. For example, `model_apply` might subtract the mean, while `model_reverse` adds the mean back again.

For the base `model` template these methods function only as placeholder; they should be defined as part of extending the template, as described in the next section.

Model objects also make use of the `.params` and `.outputs` slots of the base class to allow flexibility when extending the template, as shown in the next section.

## 5.1 using the `model` template

The `model` object is intended as a template for creating new objects. In programming terms it is intended to be inherited by new objects derived from it. Methods have been defined so that they can be overloaded with new functionality.

In `structToolbox` a number of model objects have been defined using `setClass` and `setMethod`, which is the preferred way to extend the templates in a package.

`struct` also makes it possible to define new `model` objects as you go, which we will demonstrate here. We will define two new objects, one for mean centring and one for Principal Component Analysis. More complete versions of these objects are available as part of the `structToolbox` package.

The first step is to define the new model objects using the `set_struct_object()` function (see section [3](#helpers)).

```
# mean centre object
mean_centre = set_struct_obj(
  class_name = 'mean_centre',
  struct_obj = 'model',
  params = character(0),
  outputs = c(centred = 'DatasetExperiment',
              mean = 'numeric'),
  private = character(0),
  prototype=list(predicted = 'centred')
)

# PCA object
PCA = set_struct_obj(
  class_name = 'PCA',
  struct_obj = 'model',
  params = c(number_components = 'numeric'),
  outputs = c(scores = 'DatasetExperiment',
              loadings = 'data.frame'),
  private = character(0),
  prototype = list(number_components = 2,
                  ontology = 'OBI:0200051',
                  predicted = 'scores')
)
```

The objects we have created (`mean_centre` and `PCA`) both extend the `model` object template. `mean_centre` is a fairly basic model with a single output slot `centred` while the PCA object has inputs, outputs and sets a some default values.

The new objects can be initialised like other `struct`, with named input parameter values.

```
M = mean_centre()
M
```

```
## A "mean_centre" object
## ----------------------
## name:
## description:
## outputs:       centred, mean
## predicted:     centred
## seq_in:        data
```

```
P = PCA(number_components=4)
P
```

```
## A "PCA" object
## --------------
## name:
## description:
## input params:  number_components
## outputs:       scores, loadings
## predicted:     scores
## seq_in:        data
```

The new objects currently have the default methods, which need to be replaced using the either `setMethod` or the helper function `set_obj_method()` to provide the desired functionality.

We will need to define `model_train` and `model_predict` for both of our new objects. We will start with the `mean_centre` object.

```
# mean centre training
set_obj_method(
  class_name = 'mean_centre',
  method_name = 'model_train',
  definition = function(M,D) {
    # calculate the mean of all training data columns
    m = colMeans(D$data)
    # assign to output slot
    M$mean = m
    # always return the modified model object
    return(M)
  }
)

# mean_centre prediction
set_obj_method(
  class_name = 'mean_centre',
  method_name = 'model_predict',
  definition = function(M,D) {
    # subtract the mean from each column of the test data
    D$data = D$data - rep(M$mean, rep.int(nrow(D$data), ncol(D$data)))
    # assign to output
    M$centred = D
    # always return the modified model object
    return(M)
  }
)
```

The `mean_centre` object can now be used with `DatasetExperiment` objects.

```
# create instance of object
M = mean_centre()

# train with iris data
M = model_train(M,iris_DatasetExperiment())

# print to mean to show the function worked
M$mean
```

```
## Sepal.Length  Sepal.Width Petal.Length  Petal.Width
##     5.843333     3.057333     3.758000     1.199333
```

```
# apply to iris_data
M = model_predict(M,iris_DatasetExperiment())

# retrieve the centred data and show that the column means are zero
colMeans(M$centred$data)
```

```
##  Sepal.Length   Sepal.Width  Petal.Length   Petal.Width
## -3.671137e-16  9.177844e-17 -3.256654e-17 -3.404684e-17
```

Now we define methods for the PCA object.

```
# PCA training
set_obj_method(
  class_name = 'PCA',
  method_name = 'model_train',
  definition = function(M,D) {

    # get number of components
    A = M$number_components

    # convert to matrix
    X=as.matrix(D$data)

    # do svd
    model=svd(X,A,A)

    # loadings
    P=as.data.frame(model$v)

    # prepare data.frame for output
    varnames=rep('A',1,A)
    for (i in 1:A) {
      varnames[i]=paste0('PC',i)
    }
    rownames(P)=colnames(X)
    colnames(P)=varnames
    output_value(M,'loadings')=P

    # set output
    M$loadings = P

    # always return the modified model object
    return(M)
  }
)

# PCA prediction
set_obj_method(
  class_name = 'PCA',
  method_name = 'model_predict',
  definition = function(M,D) {
    ## calculate scores using loadings

    # get number of components
    A = M$number_components

    # convert to matrix
    X=as.matrix(D$data)

    # get loadings
    P=M$loadings

    # calculate scores
    that=X%*%as.matrix(P)

    # convert scores to DatasetExperiment
    that=as.data.frame(that)
    rownames(that)=rownames(X)
    varnames=rep('A',1,A)
    for (i in 1:A) {
      varnames[i]=paste0('PC',i)
    }
    colnames(that)=varnames
    S=DatasetExperiment(
      data=that,
      sample_meta=D$sample_meta,
      variable_meta=varnames)

    # set output
    M$scores=S

    # always return the modified model object
    return(M)
  }
)
```

Like the `mean_centre` object the `PCA` object now has methods defined and can be used with `DatasetExperiment` objects.

```
# get the mean centred data
DC = M$centred

# train PCA model
P = model_apply(P,DC)

# get scores
P$scores
```

```
## A "DatasetExperiment" object
## ----------------------------
## name:
## description:
## data:          150 rows x 4 columns
## sample_meta:   150 rows x 1 columns
## variable_meta: 4 rows x 1 columns
```

Note that because we defined `model_train` and `model_predict` for the `PCA` object we didn’t need to explicitly define a `model_apply` method as it defaults to applying `model_train` and `model_precict` sequentially. For some methods defining a `model_apply` definition would be more appropriate (e.g. t-test) and `model_train` and `model_predict` left undefined.

# 6 `model_seq` objects

Model sequences are a special kind of list defined by the `struct` package. They can be created by symbolically “adding” models together to form a sequence. We will do that here using the `mean_centre()` and `PCA()` objects we created.

```
# create model sequence
MS = mean_centre() + PCA(number_components = 2)

# print summary
MS
```

```
## A model_seq object containing:
##
## [1]
## A "mean_centre" object
## ----------------------
## name:
## description:
## outputs:       centred, mean
## predicted:     centred
## seq_in:        data
##
## [2]
## A "PCA" object
## --------------
## name:
## description:
## input params:  number_components
## outputs:       scores, loadings
## predicted:     scores
## seq_in:        data
```

The `model_train` and `model_predict` methods for model sequences will automatically pass data along the list of models. `model_apply` works in the same way as for models and will use `model_train` and `model_predict` sequentially for the model sequence.

Unless specified the default output named in the ‘predicted’ slot of the object will be used as the data input for the next object in the sequence.

For the PCA example, the data is input into the `mean_centre` object, mean centring is applied, and then the `centred` output is used an input into the `PCA` object to calculate the scores and loadings.

```
# apply model sequence to iris_data
MS = model_apply(MS,iris_DatasetExperiment())

# get default output from sequence (PCA scores with 2 components)
predicted(MS)
```

```
## A "DatasetExperiment" object
## ----------------------------
## name:
## description:
## data:          150 rows x 2 columns
## sample_meta:   150 rows x 1 columns
## variable_meta: 2 rows x 1 columns
```

To change the flow of data through a model sequence three slots can be set for each model:

* `predicted`
  + The name of the output slot to output from the model when used in a model sequence.
* `seq_in`
  + The name of an input parameter slot that receives the input from the previous model in the sequence, overriding any value set for the slot. The default value ‘data’ assumes the connecting object is a `DatasetExperiment` object and uses it as input for `model_train` and `model_predict`.
* `seq_fcn`
  + Sometimes the default output isn’t in the correct format for the input. For example, a numerical output might need to be converted to a logical by applying threshold. This operation can be defined as a function in the `seq_fcn` slot.

There are examples of this advanced model sequence flow control in the vignettes of the `structToolbox` package.

# 7 `iterator` objects

Iterator objects are similar to `model` object templates in that they can be extended to have input parameters and outputs specified. They have some unique slots:

* `models`
  + Can be a `model` or `model_seq` (model sequence) object. The iterator will call `model_train` and `model_predict` multiple times using this model.
* `result`
  + operates in a similar fashion to the `predicted` slot for `model` objects and specifies the default output of the object. This is less useful than `predicted` at this time as `iterators` cannot be combined into a sequence (but this may be implemented in the future).

`iterator` objects are intended for resampling methods, where an input model is run multiple times by subsetting the data into training and test sets. Cross-validation and permutation tests are just two examples where iterator objects might be used.

The model to be run by the iterator can be get/set using the `models` method.

```
# create iterator
I = iterator()

# add PCA model sequence
models(I) = MS

# retrieve model sequence
models(I)
```

```
## A model_seq object containing:
##
## [1]
## A "mean_centre" object
## ----------------------
## name:
## description:
## outputs:       centred, mean
## predicted:     centred
## seq_in:        data
##
## [2]
## A "PCA" object
## --------------
## name:
## description:
## input params:  number_components
## outputs:       scores, loadings
## predicted:     scores
## seq_in:        data
```

Models can also be ‘nested’ within an iterator by symbolically multiplying them by a `model` or `model_seq`. The implication is that the `iterator` will use the `model` multiple times. This can be combined with the symbolic adding of models to create sequences.

```
# alternative to assign models for iterators
I = iterator() * (mean_centre() + PCA())
models(I)
```

```
## A model_seq object containing:
##
## [1]
## A "mean_centre" object
## ----------------------
## name:
## description:
## outputs:       centred, mean
## predicted:     centred
## seq_in:        data
##
## [2]
## A "PCA" object
## --------------
## name:
## description:
## input params:  number_components
## outputs:       scores, loadings
## predicted:     scores
## seq_in:        data
```

It is also possible to nest iterators within iterators e.g. to create a ‘permuted cross\_validation’ using a similar approach.

```
I = iterator() * iterator() * (mean_centre() + PCA())
```

A `run` method is provided, which can be extended in a similar fashion to `method_train` etc to implement the desired functionality. It is up to the developer to ensure that the `iterator` can handle `model`, `model_seq` and `iterator` objects as input and as such `iterator` run methods can be quite complex. For brevity we do not demonstrate one here, but there are several examples in the `structToolbox` package and the corresponding vignettes.

# 8 `metric` objects

Metric objects calculate a scalar value by comparing true, known values to predicted outputs from a model, usually a classifier or a regression model. They are a required input for running iterators and may be calculated multiple times depending on the `iterator`. Metrics have a single unique slot.

* value
  + The calculated value of the metric

The `calculate` method is provided for `metric` object templates, which can be extended using the same approach as for `model_train` etc. It takes three inputs:

* `M`
  + The metric object to calculate.
* `Y`
  + The true value for each each sample e.g. the group labels.
* `Yhat`
  + The predicted value for each sample e.g. from a classification model.

The `calculate` method can be called manually, but usually it is called by an `iterator` during e.g. a cross-validation.

## 8.1 `chart` objects

Chart object templates are intended to produce a ggplot object from an input `DatasetExperiment`, `model` or `iterator`. The template has no unique slots but includes a `chart_plot` method to generate the ggplot object from the input object.

As a simple example we create a chart for plotting scores from the PCA object we created earlier. A more comprehensive `pca_scores_plot` object is included in the `structToolbox` as well several others for plotting the outputs of different methods.

We use the helper function `set_struct_object()` to define the new chart object.

```
# new chart object
set_struct_obj(
  class_name = 'pca_scores_plot',
  struct_obj = 'chart',
  params = c(factor_name = 'character'),
  prototype = list(
    name = 'PCA scores plot',
    description = 'Scatter plot of the first two principal components',
    libraries = 'ggplot2'
  )
)
```

The `chart_plot` method for our new object can then be replaced using the `set_obj_method()` helper function.

```
# new chart_plot method
set_obj_method(
  class_name = 'pca_scores_plot',
  method_name = 'chart_plot',
  signature = c('pca_scores_plot','PCA'),
  definition = function(obj,dobj) {

    if (!is(dobj,'PCA')) {
      stop('this chart is only for PCA objects')
    }

    # get the PCA scores data
    S = dobj$scores$data

    # add the group labels
    S$factor_name = dobj$scores$sample_meta[[obj$factor_name]]

    # ggplot
    g = ggplot(data = S, aes_string(x='PC1',y='PC2',colour='factor_name')) +
      geom_point() + labs(colour = obj$factor_name)

    # chart objects return the ggplot object
    return(g)
  }

)
```

Note that we set `signature = c('pca_scores_plot', 'PCA')` to indicate that only `PCA` objects should be accepted as the second input for this chart.

The new chart object is now ready to be used with `PCA` objects.

```
# create chart object
C = pca_scores_plot(factor_name = 'Species')

# plot chart using trained PCA object from model sequence
chart_plot(C,MS[2]) + theme_bw() # add theme
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

# 9 `entity` and `enum` objects

These `struct` classes are used to make input params and outputs more informative and more flexible. The are not intednded to be an extendable template in the same way as `model` objects.

By specifying the type or class of a slot as an `entity` or `enum` object you can provide additional information about the slot, such as a more informative `name` and a `description`. `entity` and `enum` slots have some unique slots:

* `value`
  + The value assigned to the input parameter / output.
* `max_length`
  + The maximum length of the input value. e.g. setting to 1 ensures that the value cannot be set to c(1,2) for example. Default is Inf.
* `allowed`
  + `enum` objects only. A list of allowed values for the input parameter / output.

Both objects also make use of the `type` slot to ensure the assigned value for a slot can only be of a certain class e.g. setting `type = c('numeric', 'integer')` will not allow the parameter value to be set to a character.

The `name` and `description` slots can be useful e.g. in report writing for providing a standard definition of a parameter.

`enitity` and `enum` objects have methods for getting/setting all slots. They are designed to work seamlessly with dollar syntax in the same way you would access the value of any non-entity slot.

As an example the `number_components` parameter for the `PCA` object could be defined as an `entity` object.

```
# define entity
npc = entity(
  name = 'Number of principal components',
  description = 'The number of principal components to calculate',
  type = c('numeric','integer'),
  value = 2,
  max_length = 1
)

# summary
npc
```

```
## A "entity" object
## -----------------
## name:          Number of principal components
## description:   The number of principal components to calculate
## value:         2
## type:          numeric, integer
## max length:    1
```

It can then be used with the `set_struct_obj()` function when creating the PCA object by using “entity” as the input type for `params` and including the entity object in the `prototype` for the object. It will function exactly as it did before, but has the additional information (`name`, `description`, etc) attached as well.

```
# PCA object
PCA = set_struct_obj(
  class_name = 'PCA',
  struct_obj = 'model',
  params = c(number_components = 'entity'),
  outputs = c(scores = 'DatasetExperiment',
              loadings = 'data.frame'),
  private = character(0),
  prototype = list(number_components = npc,
                  ontology = 'OBI:0200051',
                  predicted = 'scores')
)

# create PCA model
P = PCA(number_components = 3)

# get set value
P$number_components
```

```
## [1] 3
```

```
# get description
param_obj(P,'number_components')$description
```

```
## [1] "The number of principal components to calculate"
```

## 9.1 Ontology.

All `struct` objects have an `ontology` slot that can be assigned ontology term identifiers. `struct` makes use of the `rols` bioconductor package to access the Ontology lookup Service API and obtain names and definitions based on the provided identifiers.

```
P = PCA()

# return a list of ontologies for PCA, including the input parameters and outputs
ontology(P)
```

```
## An object of class "ontology_list"
## Slot "terms":
## [[1]]
## term id:       OBI:0200051
## ontology:      obi
## label:         principal components analysis dimensionality reduction
## description:   A principal components analysis dimensionality reduction is a dimensionality reduction
##                  achieved by applying principal components analysis and by keeping low-order principal
##                  components and excluding higher-order ones.
## iri:           http://purl.obolibrary.org/obo/OBI_0200051
```

```
# return the ontology id'd for PCA only (not inputs/outputs)
P$ontology
```

```
## [1] "OBI:0200051"
```

```
# get the ontology for a specific input
IN = param_obj(P,'number_components') # get as entity object
IN$ontology
```

```
## character(0)
```

NOTE: in versions prior to v1.5.1 `stato` classes were used. This has now been deprecated in favour of `ontology` and will be removed in a future release.

# 10 Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ggplot2_4.0.1    struct_1.22.1    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3              sass_0.4.10
##  [3] generics_0.1.4              SparseArray_1.10.8
##  [5] lattice_0.22-7              rols_3.6.1
##  [7] digest_0.6.39               magrittr_2.0.4
##  [9] evaluate_1.0.5              grid_4.5.2
## [11] RColorBrewer_1.1-3          bookdown_0.46
## [13] fastmap_1.2.0               jsonlite_2.0.0
## [15] Matrix_1.7-4                ontologyIndex_2.12
## [17] tinytex_0.58                BiocManager_1.30.27
## [19] scales_1.4.0                httr2_1.2.2
## [21] jquerylib_0.1.4             abind_1.4-8
## [23] cli_3.6.5                   crayon_1.5.3
## [25] rlang_1.1.6                 XVector_0.50.0
## [27] Biobase_2.70.0              withr_3.0.2
## [29] cachem_1.1.0                DelayedArray_0.36.0
## [31] yaml_2.3.12                 otel_0.2.0
## [33] S4Arrays_1.10.1             tools_4.5.2
## [35] dplyr_1.1.4                 SummarizedExperiment_1.40.0
## [37] BiocGenerics_0.56.0         curl_7.0.0
## [39] vctrs_0.6.5                 R6_2.6.1
## [41] magick_2.9.0                matrixStats_1.5.0
## [43] stats4_4.5.2                lifecycle_1.0.4
## [45] Seqinfo_1.0.0               S4Vectors_0.48.0
## [47] IRanges_2.44.0              pkgconfig_2.0.3
## [49] pillar_1.11.1               bslib_0.9.0
## [51] gtable_0.3.6                Rcpp_1.1.0
## [53] glue_1.8.0                  tidyselect_1.2.1
## [55] tibble_3.3.0                xfun_0.55
## [57] GenomicRanges_1.62.1        MatrixGenerics_1.22.0
## [59] knitr_1.51                  dichromat_2.0-0.1
## [61] farver_2.1.2                htmltools_0.5.9
## [63] labeling_0.4.3              rmarkdown_2.30
## [65] compiler_4.5.2              S7_0.2.1
```