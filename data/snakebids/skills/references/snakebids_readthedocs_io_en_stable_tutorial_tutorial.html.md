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
* Tutorial
* [Bids Function](../bids_function/overview.html)
* [Bids Apps](../bids_app/overview.html)[ ]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](../migration/index.html)[ ]

Reference

* [API](../api/main.html)[ ]
* [Internals](../api/internals.html)
* [Plugins](../api/plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/tutorial/tutorial.md?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/tutorial/tutorial.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Tutorial[¶](#tutorial "Link to this heading")

## Getting started[¶](#getting-started "Link to this heading")

In this example we will make a workflow to smooth `bold` scans from a bids dataset.

We will start by creating a simple rule, then make this more generalizable in each step. To begin with, this is the command we are using to smooth a bold scan.

```
fslmaths ../bids/sub-001/func/sub-001_task-rest_run-1_bold.nii.gz -s 2.12 results/sub-001/func/sub-001_task-rest_run-1_fwhm-5mm_bold.nii.gz
```

This command performs smoothing with a sigma=2.12 Gaussian kernel (equivalent to 5mm FWHM, with sigma=fwhm/2.355), and saves the smoothed file as `results/sub-001/func/sub-001_task-rest_run-1_fwhm-5mm_bold.nii.gz`.

### Installation[¶](#installation "Link to this heading")

Start by making a new directory:

```
$ mkdir snakebids-tutorial
$ cd snakebids-tutorial
```

Check your python version to make sure you have at least version 3.10 or higher:

```
$ python --version
Python 3.10.0
```

Make a new virtual environment:

```
$ python -m venv .venv
$ source .venv/bin/activate
```

And use pip to install snakebids:

```
$ pip install snakebids
```

In our example, we’ll be using the [`fslmaths`](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Fslutils) tool from [*FSL*](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/). If you want to actually run the workflow, you’ll need to have FSL installed. This is not actually necessary to follow along the tutorial however, as we can use “dry runs” to see what snakemake *would* do if FSL were installed.

### Getting the dataset[¶](#getting-the-dataset "Link to this heading")

We will be running the tutorial on a test dataset consisting only of empty files. We won’t actually be able to run our workflow on it (`fslmaths` will fail), but as mentioned above, we can use dry runs to see would would normally happen.

If you wish to follow along using the same dataset, currently the easiest way is to start by cloning snakebids:

```
$ git clone https://github.com/khanlab/snakebids.git
```

Then copy the following directory:

```
$ cp -r snakebids/docs/tutorial/bids ./data
```

It’s also perfectly possible (and probably better!) to try the tutorial on your own dataset. Just adjust any paths below so that they match your data!

## Part I: Snakemake[¶](#part-i-snakemake "Link to this heading")

### Step 0: a basic non-generic workflow[¶](#step-0-a-basic-non-generic-workflow "Link to this heading")

In this rule, we start by creating a rule that is effectively hard-coding the paths for input and output to re-create the command as above.

In this rule we have an `input:` section for input **files**, a `params:` section for **non-file** parameters, and an `output:` section for output files. The shell section is used to build the shell command, and can refer to the input, output or params using curly braces. Note that any of these can also be named inputs, but we have only used this for the `sigma` parameter in this case.

Snakefile[¶](#id1 "Link to this code")

```
1rule smooth:
2    input:
3        'data/sub-001/func/sub-001_task-rest_run-1_bold.nii.gz'
4    params:
5        sigma = '2.12'
6    output:
7        'results/sub-001/func/sub-001_task-rest_run-1_fwhm-5mm_bold.nii.gz'
8    shell:
9        'fslmaths {input} -s {params.sigma} {output}'
```

With this rule in our Snakefile, we can then run `snakemake -np` to execute a dry-run of the workflow. Here the `-n` specifies dry-run, and the `-p` prints any shell commands that are to be executed.

When we invoke `snakemake`, it uses the first rule in the snakefile as the `target` rule. The target rule is what snakemake uses as a starting point to determine what other rules need to be run in order to generate the inputs. We’ll learn a bit more about that in the next step.

So far, we just have a fancy way of specifying the exact same command we started with, so there is no added benefit (yet). But we will soon add to this rule to make it more generalizable.

### Step 1: adding wildcards[¶](#step-1-adding-wildcards "Link to this heading")

First step to make the workflow generalizeable is to replace the hard-coded identifiers (e.g. the subject, task and run) with wildcards.

In the Snakefile, we can replace `sub-001` with `sub-{subject}`, and so forth for task and run. Now the rule is generic for any subject, task, or run.

Snakefile[¶](#id2 "Link to this code")

```
1rule smooth:
2    input:
3        'data/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_bold.nii.gz'
4    params:
5        sigma = '2.12'
6    output:
7        'results/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_fwhm-5mm_bold.nii.gz'
8    shell:
9        'fslmaths {input} -s {params.sigma} {output}'
```

However, if we try to execute (dry-run) the workflow as before, we get an error. This is because the `target` rule now has wildcards in it. So snakemake is unable to determine what rules need to be run to generate the inputs, since the wildcards can take any value.

So for the time being, we will make use of the snakemake command-line argument to specify `targets`, and specify the file we want generated from the command-line, by running:

```
$ snakemake -np results/sub-001/func/sub-001_task-rest_run-1_fwhm-5mm_bold.nii.gz
```

We can now even try running this for another subject by changing the target file.

```
$ snakemake -np results/sub-002/func/sub-002_task-rest_run-1_fwhm-5mm_bold.nii.gz
```

Try using a subject that doesn’t exist in our bids dataset, what happens?

Now, try changing the output smoothing value, e.g. `fwhm-10mm`, and see what happens.
As expected the command still uses a smoothing value of 2.12, since that has been hard-coded, but we will see how to rectify this in the next step.

### Step 2: adding a params function[¶](#step-2-adding-a-params-function "Link to this heading")

As we noted, the sigma parameter needs to be computed from the FWHM. We can use a function to do this. Functions can be used for any `input` or `params`, and must take `wildcards` as an input argument, which provides a mechanism to pass the wildcards (determined from the output file) to the function.

We can thus define a simple function that returns a string representing `FWHM/2.355` as follows:

Snakefile[¶](#id3 "Link to this code")

```
1def calc_sigma_from_fwhm(wildcards):
2    return f'{float(wildcards.fwhm)/2.355:0.2f}'
```

Note 1: We now have to make the fwhm in the output filename a wildcard, so that it can be passed to the function (via the wildcards object).

Note 2: We have to convert the fwhm to float, since all wildcards are always strings (since they are parsed from the output filename).

Once we have this function, we can replace the hardcoded `2.12` with the name of the function:

Snakefile[¶](#id4 "Link to this code")

```
6        'data/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_bold.nii.gz'
7    params:
8        sigma = calc_sigma_from_fwhm
9    output:
```

Here is the full Snakefile:

Snakefile[¶](#id5 "Link to this code")

```
 1def calc_sigma_from_fwhm(wildcards):
 2    return f'{float(wildcards.fwhm)/2.355:0.2f}'
 3
 4rule smooth:
 5    input:
 6        'data/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_bold.nii.gz'
 7    params:
 8        sigma = calc_sigma_from_fwhm
 9    output:
10        'results/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_fwhm-{fwhm}mm_bold.nii.gz'
11    shell:
12        'fslmaths {input} -s {params.sigma} {output}'
```

Now try running the workflow again, with `fwhm-5` as well as `fwhm-10`.

### Step 3: adding a target rule[¶](#step-3-adding-a-target-rule "Link to this heading")

Now we have a generic rule, but it is pretty tedious to have to type out the filename of each target from the command-line in order to use it.

This is where target rules come in. If you recall from earlier, the first rule in a workflow is interpreted as the target rule, so we just need to add a dummy rule to the Snakefile that has all the target files as inputs. It is a dummy rule since it doesn’t have any outputs or any command to run itself, but snakemake will take these input files, and determine if any other rules in the workflow can generate them (considering any wildcards too).

In this case, we have a BIDS dataset with two runs (run-1, run-2), and suppose we wanted to compute smoothing with several different FWHM kernels (5,10,15,20). We can thus make a target rule that has all these resulting filenames as inputs.

A very useful function in snakemake is [`expand()`](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#snakefiles-expand "Snakemake 9.13.7"). It is a way to perform array expansion to create lists of strings (input filenames).

Snakefile[¶](#id6 "Link to this code")

```
 1rule all:
 2    input:
 3        expand(
 4            'results/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_fwhm-{fwhm}mm_bold.nii.gz',
 5            subject='001',
 6            task='rest',
 7            run=[1,2],
 8            fwhm=[5,10,15,20]
 9        )
10
11
```

Now, we don’t need to specify any targets from the command-line, and can just run:

```
$ snakemake -np
```

The entire Snakefile for reference is:

Snakefile[¶](#id7 "Link to this code")

```
 1rule all:
 2    input:
 3        expand(
 4            'results/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_fwhm-{fwhm}mm_bold.nii.gz',
 5            subject='001',
 6            task='rest',
 7            run=[1,2],
 8            fwhm=[5,10,15,20]
 9        )
10
11
12def calc_sigma_from_fwhm(wildcards):
13    return f'{float(wildcards.fwhm)/2.355:0.2f}'
14
15rule smooth:
16    input:
17        'data/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_bold.nii.gz'
18    params:
19        sigma = calc_sigma_from_fwhm,
20    output:
21        'results/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_fwhm-{fwhm}mm_bold.nii.gz'
22    shell:
23        'fslmaths {input} -s {params.sigma} {output}'
```

### Step 4: adding a config file[¶](#step-4-adding-a-config-file "Link to this heading")

We have a functional workflow, but suppose you need to configure or run it on another bids dataset with different subjects, tasks, runs, or you want to run it for different smoothing values. You have to actually modify your workflow in order to do this.

It is a better practice instead to keep your configuration variables separate from the actual workflow. Snakemake supports this by allowing for a separate config file (can be YAML or JSON, here we will use YAML), where we can store any dataset specific configuration. Then to apply it for a new purpose, you can simply update the config file.

To do this, we simply add a line to our workflow:

Snakefile[¶](#id8 "Link to this code")

```
1configfile: 'config.yml'
2
3rule all:
4    input:
```

Snakemake will then handle reading it in, and making the configuration variables available via dictionary called `config`.

In our config file, we will add variables for everything in the target rule [`expand()`](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#snakefiles-expand "Snakemake 9.13.7"):

config.yaml[¶](#id9 "Link to this code")

```
 1subjects:
 2  - '001'
 3
 4tasks:
 5  - rest
 6
 7runs:
 8  - 1
 9  - 2
10
11fwhm:
12  - 5
13  - 10
14  - 15
15  - 20
16
17
18in_bold: 'data/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_bold.nii.gz'
```

In our Snakefile, we then need to replace these hardcoded values with `config[key]`. The entire updated Snakefile is shown here:

Snakefile[¶](#id10 "Link to this code")

```
 1configfile: 'config.yml'
 2
 3rule all:
 4    input:
 5        expand(
 6            'results/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_fwhm-{fwhm}mm_bold.nii.gz',
 7            subject=config['subjects'],
 8            task=config['tasks'],
 9            run=config['runs'],
10            fwhm=config['fwhm']
11        )
12
13
14def calc_sigma_from_fwhm(wildcards):
15    return f'{float(wildcards.fwhm)/2.355:0.2f}'
16
17rule smooth:
18    input:
19        config['in_bold']
20    params:
21        sigma = calc_sigma_from_fwhm
22    output:
23        'results/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_fwhm-{fwhm}mm_bold.nii.gz'
24    shell:
25        'fslmaths {input} -s {params.sigma} {output}'
```

After these changes, the workflow should still run just like the last step, but now you can make any changes via the config file.

## Part II: Snakebids[¶](#part-ii-snakebids "Link to this heading")

Now that we have a fully functioning and generic Snakemake workflow, let’s see what Snakebids can add.

### Step 5: the bids() function[¶](#step-5-the-bids-function "Link to this heading")

The first thing we can make use of is the [`bids()`](../api/paths.html#snakebids.bids "snakebids.bids") function. This provides an easy way to generate bids filenames. This is especially useful when defining output files in your workflow and you have many bids entities.

In our existing workflow, this was our output file:

Snakefile[¶](#id11 "Link to this code")

```
22    output:
23        'results/sub-{subject}/func/sub-{subject}_task-{task}_run-{run}_fwhm-{fwhm}mm_bold.nii.gz'
```

To create the same path using [`bids()`](../api/paths.html#snakebids.bids "snakebids.bids"), we just need to specify the root directory (`results`), all the bids tags (subject, task, run, fwhm), and the suffix (which includes the extension):

Snakefile[¶](#id12 "Link to this code")

```
31    output:
32        bids(
33            root='results',
34            subject='{subject}',
35            task='{task}',
36            run='{run}',
37            fwhm='{fwhm}',
38            suffix='bold.nii.gz',
39        )
```

Note

To make a snakemake wildcard, we wrapped the `'value'` in curly braces (e.g. `'{value}'`).

Note

The entities you supply in the [`bids()`](../api/paths.html#snakebids.bids "snakebids.bi