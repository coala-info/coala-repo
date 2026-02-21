# MACSQuantifyR - Introduction

#### Raphaël Bonnet, Jean-François Peyron

Université Côte d’Azur, Inserm, C3M, France
raphael.bonnet@unice.fr

#### 2025-10-30

* [Introduction](#introduction)
* [Pipelines](#pipelines)
  + [Automatic pipeline](#automatic-pipeline)
  + [Step-by-step pipeline](#step-by-step-pipeline)

# Introduction

Flow cytometry is a largely used and popular technique not only to establish cells’ phenotypes but also to investigate functional parameters such as proliferation, death/apoptosis, cell cycle phases, signaling pathways, mitochondrial functions… on living cells.

The MACSQuantify software from Miltenyi® is used to process and analyze flow cytometry data (compensation settings, gate strategy to identify particular cellular subpopulations) and to export FCS files for treatment by outside programs.

The experimental design always differ between different biologists because of specific scientific questions, use of different drugs, combinations of drugs. That can lead to unique and complex types of templates across biologists (e.g multiple drugs on one plate).

This experimental diversity prevents the use of an effective processing methods for the biologist to handle his data automatically.

This package aims at providing automatic treatment of the data after the acquisition and the validation of the data by the user.

To illustrate the benefits of this package, we take the example of a drug screening experiment on cell viability. More precisely, this experiment corresponds to the analysis of the combination effects of two drugs on a human cancer cell line.

Here is the plate template chosen by the user that represents each drug alone (upper part of the culture plate) and combinations (lower part of the plate).

![](data:image/png;base64...)

From such an experiment, the user can choose to export the results in the form of an excel spreadsheet. This new document will provide access to all replicates values that needs to be treated. As mentioned previously, each biologist has his own plate setup, therefore most of the users are subject to a considerable waste of time in the process of sorting the excel document according to the plate template they followed.

One way to process these data automatically in this experiment would have been to follow the template shown bellow (that would allow an automatic sorting of the replicates on the excel document).

Such template may not be suitable for all experiments thus forcing the biologists to follow one of those template could increase the complexity of the experiment and therefore increase the risk of experimental errors.

![](data:image/png;base64...)

```
## [1] "Horizontal template would allow to sort the excel document according to well names (A1, A2, A3...)"
```

```
## [1] "Vertical template would allow to sort the excel document according to well number(exp_name_001,exp_name_002))"
```

The package that we present in these vignettes provides a efficient solution to the sorting issue of the replicates and allows the automatic treatment of any template.

Also this package provides a variety of graphical representations and the possibility of generating a complete report of the statistical analysis done one each conditions.

# Pipelines

There are two ways to run this package:

## Automatic pipeline

* Through the fully automated function

  + pipeline()

This function will load the data, create a graphical interface, which will allow the user to select the replicates.

Then the function will generate intermediary results and will generate a complete report with all the informations provided by the user and all the graphical representations of the data.

![](data:image/png;base64...)

[Click to see the dedicated vignette](MACSQuantifyR_pipeline.html)

## Step-by-step pipeline

* Manually through the functions

  + new\_class\_MQ()
  + load\_data()
  + on\_plate\_selection()
  + barplot\_data()
  + combination\_index()
  + generate\_report()

This utilization of the manual pipeline allows the user to generate more complex (2D/3D) graphics and to have a better control on the output.

The **generate\_report()** function allows the user to generate the final report at each step of the analysis.

![](data:image/png;base64...)

[Click to see the dedicated vignette](MACSQuantifyR_combo.html)