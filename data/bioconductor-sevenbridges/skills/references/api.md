# Complete Guide for Seven Bridges API R Client

#### 2025-10-30

# 1 Introduction

`sevenbridges` is an R/Bioconductor package that provides an interface for Seven Bridges public API. The supported platforms includes the [Seven Bridges Platform](https://igor.sbgenomics.com/), [Cancer Genomics Cloud (CGC)](https://www.cancergenomicscloud.org), and [Cavatica](https://cavatica.sbgenomics.com).

Learn more from our documentation on the [Seven Bridges Platform](https://docs.sevenbridges.com/page/api) and the [Cancer Genomics Cloud (CGC)](http://docs.cancergenomicscloud.org/v1.0/page/the-cgc-api).

## 1.1 R Client for Seven Bridges API

The `sevenbridges` package only supports v2+ versions of the API, since versions prior to V2 are not compatible with the Common Workflow Language (CWL). This package provides a simple interface for accessing and trying out various methods.

There are two ways of constructing API calls. For instance, you can use low-level API calls which use arguments like `path`, `query`, and `body`. These are documented in the API reference libraries for the [Seven Bridges Platform](https://docs.sevenbridges.com/reference#list-all-api-paths) and the [CGC](http://docs.cancergenomicscloud.org/docs/new-1). An example of a low-level request to “list all projects” is shown below. In this request, you can also pass `query` and `body` as a list.

```
library("sevenbridges")
a <- Auth(token = "your_token", platform = "aws-us")
a$api(path = "projects", method = "GET")
```

***(Advanced user option)*** The second way of constructing an API request is to directly use the `httr` package to make your API calls, as shown below.

```
a$project()
```

## 1.2 API General Information

Before we start, keep in mind the following:

**`offset` and `limit`**

Every API call accepts two arguments named `offset` and `limit`.

* Offset defines where the retrieved items started.
* Limit defines the number of items you want to get.

By default, `offset` is set to `0` and `limit` is set to `100`. As such, your API request returns the **first 100 items** when you list items or search for items by name. To search and list all items, use `complete = TRUE` in your API request.

**Search by ID**

When searching by ID, your request will return your exact resource as it is unique. As such, you do not have to set `offset` and `limit` manually. It is a good practice to find your resources by their ID and pass this ID as an input to your task. You can find a resource’s ID in the final part of the URL on the visual interface or via the API requests to list resources or get a resource’s details.

**Search by name**

Search by name returns all partial matches unless you specify `exact = TRUE`.

## 1.3 Installation

The `sevenbridges` package is available on both the `release` and `devel` branch from Bioconductor.

To install it from the `release` branch, use:

```
install.packages("BiocManager")
BiocManager::install("sevenbridges")
```

To install it from the `devel` branch, use:

```
install.packages("BiocManager")
BiocManager::install("sevenbridges", version = "devel")
```

Since we are constantly improving our API and client libraries, please also visit our [GitHub repository](https://github.com/sbg/sevenbridges-r) for the most recent news and the latest version of the package.

**If you do not have `devtools`**

This installation requires that you have the `devtools` package. If you do not have this package, you can install it from CRAN.

```
install.packages("devtools")
```

You may get an error for missing system dependencies such as `curl` and `openssl`. For example, in Ubuntu, you probably need to do the following first to install `devtools` and to build vignettes since you need `pandoc`.

```
apt-get update
apt-get install libcurl4-gnutls-dev libssl-dev pandoc pandoc-citeproc
```

**If `devtools` is already installed**

Install the latest version for `sevenbridges` from GitHub with the following:

```
install.packages("BiocManager")
install.packages("readr")

devtools::install_github(
  "sbg/sevenbridges-r",
  repos = BiocManager::repositories(),
  build_vignettes = TRUE, dependencies = TRUE
)
```

If you have trouble with `pandoc` and do not want to install it, set `build_vignettes = FALSE` to avoid the vignettes build.

# 2 Quickstart

For more details about how to use the API client in R, please consult the [Seven Bridges API Reference](#reference) section below for a complete guide.

## 2.1 Create `Auth` Object

Before you can access your account via the API, you have to provide your credentials. You can obtain your credentials in the form of an [“authentication token”](https://docs.sevenbridges.com/v1.0/docs/get-your-authentication-token) from the **Developer Tab** under **Account Settings** on the visual interface. Once you’ve obtained this, create an `Auth` object, so it remembers your authentication token and the path for the API. All subsequent requests will draw upon these two pieces of information.

Let’s load the package first:

```
library("sevenbridges")
```

You have three different ways to provide your token. Choose from one method below:

1. [Direct authentication.](#method1) This explicitly and temporarily sets up your token and platform type (or alternatively, API base URL) in the function call arguments to `Auth()`.
2. [Authentication via system environment variables.](#method2) This will read the credential information from two system environment variables: `SB_API_ENDPOINT` and `SB_AUTH_TOKEN`.
3. [Authentication via the user configuration file.](#method3) This file, by default `$HOME/.sevenbridges/credentials`, provides an organized way to collect and manage all your API authentication information for Seven Bridges platforms.

**Method 1: Direct authentication**

This is the most common method to construct the `Auth` object. For example:

```
(a <- Auth(platform = "cgc", token = "your_token"))
```

```
Using platform: cgc
== Auth ==
url : https://cgc-api.sbgenomics.com/v2/
token : <your_token>
```

**Method 2: Environment variables**

To set the two environment variables in your system, you could use the function `sbg_set_env()`. For example:

```
sbg_set_env("https://cgc-api.sbgenomics.com/v2", "your_token")
```

Note that this change might be just temporary, please feel free to use the standard method to set persistent environment variables according to your operating system.

Create an `Auth` object:

```
a <- Auth(from = "env")
```

***Method 3: User configuration file***

Assume we have already created the configuration file named `credentials` under the directory `$HOME/.sevenbridges/`:

```
[aws-us-rfranklin]
api_endpoint = https://api.sbgenomics.com/v2
auth_token = token_for_this_user

# This is a comment:
# another user on the same platform
[aws-us-rosalind-franklin]
api_endpoint = https://api.sbgenomics.com/v2
auth_token = token_for_this_user

[default]
api_endpoint = https://cgc-api.sbgenomics.com/v2
auth_token = token_for_this_user

[gcp]
api_endpoint = https://gcp-api.sbgenomics.com/v2
auth_token = token_for_this_user
```

To load the user profile `aws-us-rfranklin` from this configuration file, simply use:

```
a <- Auth(from = "file", profile_name = "aws-us-rfranklin")
```

If `profile_name` is not specified, we will try to load the profile named `[default]`:

```
a <- Auth(from = "file")
```

***Note:*** API paths (base URLs) differ for each Seven Bridges environment. Be sure to provide the correct path for the environment you are using. API paths for some of the environments are:

| Platform Name | API Base URL | Short Name |
| --- | --- | --- |
| Seven Bridges Platform (US) | `https://api.sbgenomics.com/v2` | `"aws-us"` |
| Seven Bridges Platform (EU) | `https://eu-api.sbgenomics.com/v2` | `"aws-eu"` |
| Seven Bridges Platform (China) | `https://api.sevenbridges.cn/v2` | `"ali-cn"` |
| Cancer Genomics Cloud (CGC) | `https://cgc-api.sbgenomics.com/v2` | `"cgc"` |
| Cavatica | `https://cavatica-api.sbgenomics.com/v2` | `"cavatica"` |
| BioData Catalyst Powered by Seven Bridges | `https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2` | `"f4c"` |

Please refer to the [API reference section](#auth-reference) for more usage and technical details about the three authentication methods.

[top](#top)

## 2.2 Get User Information

**Get your own information**

This call returns information about your account.

```
a$user()
```

```
== User ==
href : https://cgc-api.sbgenomics.com/v2/users/RFranklin
username : RFranklin
email : rosalind.franklin@sbgenomics.com
first_name : Rosalind
last_name : Franklin
affiliation : Seven Bridges Genomics
country : United States
```

[top](#top)

**Get information about a user**

This call returns information about the specified user. Note that currently you can view only your own user information, so this call is equivalent to the [call to get information about your account](#youruser).

```
a$user(username = "RFranklin")
```

[top](#top)

## 2.3 Rate Limit

This call returns information about your current rate limit. This is the number of API calls you can make in one hour.

```
a$rate_limit()
```

```
== Rate Limit ==
limit : 1000
remaining : 993
reset : 1457980957
```

[top](#top)

## 2.4 Show Billing Information

Each project must have a Billing Group associated with it. This Billing Group pays for the storage and computation in the project.

For example, your first project(s) were created with the free funds from the Pilot Funds Billing Group assigned to each user at sign-up. To get information about billing:

```
# check your billing info
a$billing()
a$invoice()
```

For more information, use `breakdown = TRUE`.

```
a$billing(id = "your_billing_id", breakdown = TRUE)
```

[top](#top)

## 2.5 Create Project

Projects are the core building blocks of the platform. Each project corresponds to a distinct scientific investigation, serving as a container for its data, analysis tools, results, and collaborators.

Create a new project called “api testing” with the billing group `id` obtained above.

```
# get billing group id
bid <- a$billing()$id
# create new project
(p <- a$project_new(name = "api testing", bid, description = "Just a test"))
```

```
== Project ==
id : RFranklin/api-testing
name : api testing
description : Just a test
billing_group_id : <your_bid>
type : v2
-- Permission --
```

[top](#top)

## 2.6 Get Details about Existing Project

```
# list first 100
a$project()
# list all
a$project(complete = TRUE)
# return all named match "demo"
a$project(name = "demo", complete = TRUE)
# get the project you want by id
p <- a$project(id = "RFranklin/api-tutorial")
```

[top](#top)

## 2.7 Copy Public Apps into Your Project

Seven Bridges maintains workflows and tools available to all of its users in the Public Apps repository.

To find out more about public apps, you can do the following:

* Browse them online. Check out the [tutorial](http://docs.cancergenomicscloud.org/docs/) for the “Find apps” section.
* You can use the `sevenbridges` package to find it, as shown below.

```
# search by name matching, complete = TRUE search all apps,
# not limited by offset or limit.
a$public_app(name = "STAR", complete = TRUE)
# search by id is accurate
a$public_app(id = "admin/sbg-public-data/rna-seq-alignment-star/5")
# you can also get everything
a$public_app(complete = TRUE)
# default limit = 100, offset = 0 which means the first 100
a$public_app()
```

Now, from your `Auth` object, you copy an App `id` into your `project` id with a new `name`, following this logic.

```
# copy
a$copy_app(
  id = "admin/sbg-public-data/rna-seq-alignment-star/5",
  project = "RFranklin/api-testing", name = "new copy of star"
)
# check if it is copied
p <- a$project(id = "RFranklin/api-testing")
# list apps your got in your project
p$app()
```

The short name is changed to `newcopyofstar`.

```
== App ==
id : RFranklin/api-testing/newcopyofstar/0
name : RNA-seq Alignment - STAR
project : RFranklin/api-testing-2
revision : 0
```

Alternatively, you can copy it from the `app` object.

```
app <- a$public_app(id = "admin/sbg-public-data/rna-seq-alignment-star")
app$copy_to(
  project = "RFranklin/api-testing",
  name = "copy of star"
)
```

[top](#top)

## 2.8 Import CWL App and Run a Task

You can also upload your own Common Workflow Language JSON file which describes your app to your project.

***Note:*** Alternatively, you can directly describe your CWL tool in R with this package. Please read the vignette on “Describe CWL Tools/Workflows in R and Execution”.

```
# add an CWL file to your project
f.star <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
app <- p$app_add("starlocal", fl.runif)
(aid <- app$id)
```

You will get an app `id`, like the one below:

```
"RFranklin/api-testing/starlocal/0"
```

It’s composed of the following elements:

1. **project id** : `RFranklin/api`
2. **app short name** : `runif`
3. **revision** : `0`

Alternatively, you can describe tools in R directly, as shown below:

```
fl <- system.file("docker", "sevenbridges/rabix/generator.R",
  package = "sevenbridges"
)
cat(readLines(fl), sep = "\n")
```

```
library("sevenbridges")

in.lst <- list(
  input(
    id = "number",
    description = "number of observations",
    type = "integer",
    label = "number",
    prefix = "--n",
    default = 1,
    required = TRUE,
    cmdInclude = TRUE
  ),
  input(
    id = "min",
    description = "lower limits of the distribution",
    type = "float",
    label = "min",
    prefix = "--min",
    default = 0
  ),
  input(
    id = "max",
    description = "upper limits of the distribution",
    type = "float",
    label = "max",
    prefix = "--max",
    default = 1
  ),
  input(
    id = "seed",
    description = "seed with set.seed",
    type = "float",
    label = "seed",
    prefix = "--seed",
    default = 1
  )
)

# the same method for outputs
out.lst <- list(
  output(
    id = "random",
    type = "file",
    label = "output",
    description = "random number file",
    glob = "*.txt"
  ),
  output(
    id = "report",
    type = "file",
    label = "report",
    glob = "*.html"
  )
)

rbx <- Tool(
  id = "runif",
  label = "Random number generator",
  hints = requirements(docker(pull = "tengfei/runif"), cpu(1), mem(2000)),
  baseCommand = "runif.R",
  inputs = in.lst, # or ins.df
  outputs = out.lst
)

fl <- "inst/docker/sevenbridges/rabix/runif.json"
write(rbx$toJSON(pretty = TRUE), fl)
```

Then, you can add it like this:

```
# rbx is the object returned by `Tool` function
app <- p$app_add("runif", rbx)
(aid <- app$id)
```

Please consult another tutorial `vignette("apps", "sevenbridges")` about how to describe tools and flows in R.

[top](#top)

## 2.9 Execute a New Task

### 2.9.1 Find your app inputs

Once you have copied the public app `admin/sbg-public-data/rna-seq-alignment-star/5` into your project, `username/api-testing`, the app `id` in your current project is `username/api-testing/newcopyofstar`. Conversely, you can use another app you already have in your project for this Quickstart.

To draft a new task, you need to specify the following:

* The name of the task
* An optional description
* The app `id` of the workflow you are executing
* The inputs for your workflow. In this case, the CWL app accepts four parameters: number, min, max, and seed.

You can always check the App details on the visual interface for task input requirements. To find the required inputs with R, you need to get an `App` object first.

```
app <- a$app(id = "RFranklin/api-testing-2/newcopyofstar")
# get input matrix
app$input_matrix()
app$input_matrix(c("id", "label", "type"))
# get required node only
app$input_matrix(c("id", "label", "type"), required = TRUE)
```

Conversely, you can load the app from a CWL JSON and convert it into an R object first, as shown below.

```
f1 <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
app <- convert_app(f1)
# get input matrix
app$input_matrix()
```

```
##                                id                    label    type required
## 1                    #sjdbGTFfile              sjdbGTFfile File...    FALSE
## 2                          #fastq                    fastq File...     TRUE
## 3               #genomeFastaFiles         genomeFastaFiles    File     TRUE
## 4 #sjdbGTFtagExonParentTranscript      Exons' parents name  string    FALSE
## 5       #sjdbGTFtagExonParentGene                Gene name  string    FALSE
## 6          #winAnchorMultimapNmax         Max loci anchors     int    FALSE
## 7             #winAnchorDistNbins Max bins between anchors     int    FALSE
##   fileTypes
## 1      null
## 2      null
## 3      null
## 4      null
## 5      null
## 6      null
## 7      null
```

```
app$input_matrix(c("id", "label", "type"))
```

```
##                                id                    label    type
## 1                    #sjdbGTFfile              sjdbGTFfile File...
## 2                          #fastq                    fastq File...
## 3               #genomeFastaFiles         genomeFastaFiles    File
## 4 #sjdbGTFtagExonParentTranscript      Exons' parents name  string
## 5       #sjdbGTFtagExonParentGene                Gene name  string
## 6          #winAnchorMultimapNmax         Max loci anchors     int
## 7             #winAnchorDistNbins Max bins between anchors     int
```

```
app$input_matrix(c("id", "label", "type"), required = TRUE)
```

```
##                  id            label    type
## 2            #fastq            fastq File...
## 3 #genomeFastaFiles genomeFastaFiles    File
```

Note that `input_matrix` and `output_matrix` are useful accessors for `Tool`, `Flow`, you can call these two function on a JSON file directly as well.

```
tool.in <- system.file("extdata/app", "tool_unpack_fastq.json", package = "sevenbridges")
flow.in <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
input_matrix(tool.in)
input_matrix(tool.in, required = TRUE)
input_matrix(flow.in)
input_matrix(flow.in, c("id", "type"))
input_matrix(flow.in, required = TRUE)
output_matrix(tool.in)
output_matrix(flow.in)
```

In the response body, locate the names of the required inputs. Note that task inputs need to match the expected data type and name. In the above example, we see two required fields:

* **fastq:** This input takes a file array as indicated by “File…”
* **genomeFastaFiles:** This is a single file as indicated by “File”.

We also want to provide a gene feature file:

* **sjdbGTFfile:** A single file as indicated by “File”.

You can find a list of possible input types below:

* **number, character or integer:** you can directly pass these to the input parameter as it is.
* **enum type:** Pass this value to the input parameter.
* **file:** This input is a file. However, while some inputs accept only single file (`File`), other inputs take more than one file (`File` arrays, `FilesList`, or ‘`File...`’ ). This input requires you to pass a `Files` object (for a single file input) or `FilesList` object (for inputs which accept more than one file) or simply a list in a “Files” object. You can search for your file by `id` or by `name` with an exact match (`exact = TRUE`), as shown in the example below.

[top](#top)

### 2.9.2 Get your input files ready

```
fastqs <- c("SRR1039508_1.fastq", "SRR1039508_2.fastq")

# get all 2 exact files
fastq_in <- p$file(name = fastqs, exact = TRUE)

# get a single file
fasta_in <- p$file(
  name = "Homo_sapiens.GRCh38.dna.primary_assembly.fa",
  exact = TRUE
)
# get all single file
gtf_in <- p$file(
  name = "Homo_sapiens.GRCh38.84.gtf",
  exact = TRUE
)
```

[top](#top)

### 2.9.3 Create a new draft task

```
# add new tasks
taskName <- paste0("RFranklin-star-alignment ", date())

tsk <- p$task_add(
  name = taskName,
  description = "star test",
  app = "RFranklin/api-testing-2/newcopyofstar/0",
  inputs = list(
    sjdbGTFfile = gtf_in,
    fastq = fastq_in,
    genomeFastaFiles = fasta_in
  )
)
```

Remember the `fastq` input expects a list of files. You can also do something as follows:

```
f1 <- p$file(name = "SRR1039508_1.fastq", exact = TRUE)
f2 <- p$file(name = "SRR1039508_2.fastq", exact = TRUE)
# get all 2 exact files
fastq_in <- list(f1, f2)

# or if you know you only have 2 files whose names match SRR924146*.fastq
fastq_in <- p$file(name = "SRR1039508*.fastq", complete = TRUE)
```

Use `complete = TRUE` when the number of items is over 100.

### 2.9.4 Draft a batch task

Now let’s do a batch with 8 files in 4 groups, which is batched by metadata `sample_id` and `library_id`. We will assume each file has these two metadata fields entered. Since these files can be evenly grouped into 4, we will have a single parent batch task with 4 child tasks.

```
fastqs <- c(
  "SRR1039508_1.fastq", "SRR1039508_2.fastq", "SRR1039509_1.fastq",
  "SRR1039509_2.fastq", "SRR1039512_1.fastq", "SRR1039512_2.fastq",
  "SRR1039513_1.fastq", "SRR1039513_2.fastq"
)

# get all 8 files
fastq_in <- p$file(name = fastqs, exact = TRUE)
# can also try to returned all SRR*.fastq files
# fastq_in <- p$file(name= "SRR*.fastq", complete = TRUE)

tsk <- p$task_add(
  name = taskName,
  description = "Batch Star Test",
  app = "RFranklin/api-testing-2/newcopyofstar/0",
  batch = batch(
    input = "fastq",
    criteria = c("metadata.sample_id", "metadata.noexist_id")
  ),
  inputs = list(
    sjdbGTFfile = gtf_in,
    fastq = fastqs_in,
    genomeFastaFiles = fasta_in
  )
)
```

Now you have a draft batch task. Please check it out in the visual interface. Your response body should inform you of any errors or warnings.

Note: you can also directly pass file id or file names as characters to inputs list, the package will first guess if the passed strings are file id (24-bit hexadecimal) or names, then convert it to Files or FilesList object. However, as a good practice, we recommend you construct your files object(e.g. `p$file(id = ..., name = ...)`) first, check the value, then pass it to `task_add` inputs. This is a safer approach.

[top](#top)

## 2.10 Run a Task

Now, we are ready to run our task.

```
# run your task
tsk$run()
```

Before you run your task, you can adjust your draft task if you have any final modifications. Alternatively, you can delete the draft task if you no longer wish to run it.

```
# # not run
# tsk$delete()
```

After you run a task, you can abort it.

```
# abort your task
tsk$abort()
```

If you want to update your task and then re-run it, follow the example below.

```
tsk$getInputs()
# missing number input, only update number
tsk$update(inputs = list(sjdbGTFfile = "some new file"))
# double check
tsk$getInputs()
```

[top](#top)

## 2.11 Run tasks using spot instances

Running tasks with [spot instances](https://docs.sevenbridges.com/docs/about-spot-instances) could potentially [reduce a considerable amount of computational cost](https://www.sevenbridges.com/spot-instances-cost-reduction/). This option can be controlled on the project level or the task level on Seven Bridges platforms. Our package follows the same [logic](https://docs.sevenbridges.com/docs/use-spot-instances) as our platform’s web interface (the current default setting for spot instances is **on**).

For example, when we create a project using `project_new()`, we can set `use_interruptible = FALSE` to use on-demand instances (non-interruptible but more expensive) instead of the spot instances (interruptible but cheaper):

```
p <- a$project_new(
  name = "spot-disabled-project", bid, description = "spot disabled project",
  use_interruptible = FALSE
)
```

Then all the new tasks created under this project will use on-demand instances to run **by default**, unless an argument `use_interruptible_instances` is specifically set to `TRUE` when drafting the new task using `task_add()`.

For example, if `p` is the above spot disabled project, to draft a task that will use spot instances to run:

```
tsk <- p$task_add(
  name = paste0("spot enabled task in a spot disabled project"),
  description = "spot enabled task",
  app = ...,
  inputs = list(...),
  use_interruptible_instances = TRUE
)
```

Conversely, you can have a spot instance enabled project, but draft and run specific tasks using on-demand instances, by setting `use_interruptible_instances = FALSE` in `task_add()` explicitly.

## 2.12 Execution hints per task run

During workflow development and benchmarking, sometimes we need to view and make adjustments to the computational resources needed for a task to run more efficiently. Also, if a task fails due to resource deficiency, we often want to define a larger instance for the task re-run without editing the app itself. This is particularly important in cases where there is not enough disk space.

The Seven Bridges API allows setting specific task execution parameters by using `execution_settings`. It includes the instance type (`instance_type`) and the maximum number of parallel instances (`max_parallel_instances`):

```
tsk <- p$task_add(
  ...,
  execution_settings = list(
    instance_type = "c4.2xlarge;ebs-gp2;2000",
    max_parallel_instances = 2
  )
)
```

For details about `execution_settings`, please check [create a new draft task](https://docs.sevenbridges.com/v1.0/reference#create-a-new-task).

## 2.13 Task Monitoring

To monitor your task as it runs, you can always request a task `update` to ask your task to report its status. Or, you can monitor a running task with a hook function, which triggers the function when that status is “completed”. Please check the details in [section](#hooktask) below.

```
tsk$update()
```

By default, your task alerts you by email when it has been completed.

```
# Monitor your task (skip this part)
# tsk$monitor()
```

Use the following to download all files from a completed task.

```
tsk$download("~/Downloads")
```

Instead of the default task monitor action, you can use `setTaskHook` to connect a function call to the status of a task. When you run `tsk$monitor(time = 30)` it will check your task every 30 seconds to see if the current task status matches one of the following statuses: “queued”, “draft”, “running”, “completed”, “aborted”, and “failed”. When it finds a match for the task status, `getTaskHook` returns the function call for the specific status.

```
getTaskHook("completed")
```

```
## function (...)
## {
##     cat("\r", "completed")
##     return(TRUE)
## }
## <environment: 0x63908f4bfa38>
```

If you want to customize the monitor function, you can adjust the following requirement. Your function must return `TRUE` or `FALSE` in the end. When it is `TRUE` (or non-logical value) it means the monitoring will be terminated after it finds a status matched and the function executes, such as when the task is completed. When it is `FALSE`, it means the monitoring will continue for the next iteration of checking, e.g., when it is “running”, you want to keep tracking.

Follow the example below to set a new function to monitor the status “completed”. Then, when the task is completed, it will download all task output files to the local folder.

```
setTaskHook("completed", function() {
  tsk$download("~/Downloads")
  return(TRUE)
})
tsk$monitor()
```

[top](#top)

# 3 Seven Bridges API Reference

The `sevenbridges` package provides a user-friendly interface, so you do not have to combine several `api()` calls and constantly reference the API documentation to issue API requests.

[top](#top)

## 3.1 Authentication

Before you can interact with the API, you need to construct an `Auth` object which stores the following information:

* Your authentication token. This is used to authenticate your credentials with the API. Learn more about obtaining your authentication token on the [Seven Bridges Platform](https://docs.sevenbridges.com/v1.0/docs/get-your-authentication-token) and the [Cancer Genomics Cloud](http://docs.cancergenomicscloud.org/v1.0/docs/get-your-authentication-token). The approach for obtaining the authentication token also applies to the other Seven Bridges platforms.
* The path for the API (base URL).
* The platform name you are using. This is an optional field, as the base URL of the API ultimately decides where the API calls will be sent to. This field will only be blank when the URL was directly provided, and the platform name could not be inferred from that URL.

The general authentication logic for `Auth()` is as follows:

1. The package will use the direct authentication method if `from` is not specified explicitly or specified as `from = "direct"`.
2. The package will load the authentication information from environment variables when `from = "env"`, or user configuration file when `from = "file"`.

### 3.1.1 Direct authentication

To use direct authentication, users need to specify one of `platform` or `url`, with the corresponding `token`. Examples of direct authentication:

```
a <- Auth(
  token = "your_token",
  platform = "aws-us"
)
```

The above will use the Seven Bridges Platform on AWS (US).

```
a <- Auth(
  token = "your_token",
  url = "https://gcp-api.sbgenomics.com/v2"
)
```

The above will use the specified `url` as the base URL for the API calls. In this example, the `url` points to the Seven Bridges Platform on Google Cloud Platform (GCP).

```
a <- Auth(token = "your_token")
```

The above will use the Cancer Genomics Cloud environment since no `platform` nor `url` were explicitly specified (not recommended).

***Note:*** `platform` and `url` should not be specified at the same time.

[top](#top)

### 3.1.2 Authentication via system environment variables

The R API client supports reading authentication information stored in system environment variables.

To set the two environment variables in your system, you could use the function `sbg_set_env()`. For example:

```
sbg_set_env(
  url = "https://cgc-api.sbgenomics.com/v2",
  token = "your_token"
)
```

See if the environment variables are correctly set:

```
sbg_get_env("SB_API_ENDPOINT")
## "https://cgc-api.sbgenomics.com/v2"
sbg_get_env("SB_AUTH_TOKEN")
## "your_token"
```

To create an `Auth` object:

```
a <- Auth(from = "env")
```

To unset the two environment variables:

```
Sys.unsetenv("SB_API_ENDPOINT")
Sys.unsetenv("SB_AUTH_TOKEN")
```

[top](#top)

### 3.1.3 Authentication via user configuration file

You can create an ini-like file named `credentials` under the folder `$HOME/.sevenbridges/` and maintain your credentials for multiple accounts across various Seven Bridges environments. An example:

```
[aws-us-rfranklin]
api_endpoint = https://api.sbgenomics.com/v2
auth_token = token_for_this_user

# This is a comment:
# another user on the same platform
[aws-us-rosalind-franklin]
api_endpoint = https://api.sbgenomics.com/v2
auth_token = token_for_this_user

[default]
api_endpoint = https://cgc-api.sbgenomics.com/v2
auth_token = token_for_this_user

[gcp]
api_endpoint = https://gcp-api.sbgenomics.com/v2
auth_token = token_for_this_user
```

Please make sure to have two fields **exactly** named as `api_endpoint` and `auth_token` under each profile.

To load the default profile (named `[default]`) from the default user configuration file (`$HOME/.sevenbridges/credentials`), please use:

```
a <- Auth(from = "file")
```

To load the user profile `aws-us-rfranklin` from this configuration file, change the `profile_name`:

```
a <- Auth(from = "file", profile_name = "aws-us-rfranklin")
```

To use a user configuration file from other locations (not recommended), please specify the file path using the argument `config_file`. For example:

```
a <- Auth(
  from = "file", config_file = "~/sevenbridges.cfg",
  profile_name = "aws-us-rfranklin"
)
```

***Note:*** If you edited the `credentials` file, please use `Auth()` to re-authenticate.

[top](#top)

## 3.2 List All API Calls

If you did not pass any parameters to `api()` from `Auth`, it would list all API calls. Any parameters you provide will be passed to the `api()` function, but you do not have to pass your input token and path once more since the `Auth` object already has this information. The following call from the `Auth` object will check the response as well.

```
a$api()
```

[top](#top)

## 3.3 Offset, Limit, Search, and Advance Access Features

### 3.3.1 `offset` and `limit`

Every API call accepts two arguments named `offset` and `limit`.

* `offset` defines where the retrieved items started.
* `limit` defines the number of items you want to get.

By default, `offset` is set to `0` and `limit` is set to `50`. As such, your API request returns the **first 100 items** when you list items or search for items by name. To search and list all items, use `complete = TRUE` in your API request.

```
getOption("sevenbridges")$offset
getOption("sevenbridges")$limit
```

[top](#top)

### 3.3.2 Search by ID

When searching by ID, your request will return your exact resource as it is unique. As such, you do not have to set `offset` and `limit` manually. It is a good practice to find your resources by their ID and pass this ID as an input to your task. You can find a resource’s ID in the final part of the URL on the visual interface or via the API requests to list resources or get a resource’s details.

[top](#top)

### 3.3.3 Search by name

Search by name returns all partial matches unless you specify `exact = TRUE`. This type of search will only search across current pulled content, so use `complete = TRUE` if you want to search across everything.

For example, to list all public apps, use `visibility` argument, but make sure you pass `complete = TRUE` to it, to show everything. This arguments generally works for items like “App”, “Project”, “Task”, “File”, etc.

```
# first, search by id is fast
x <- a$app(visibility = "public", id = "admin/sbg-public-data/sbg-ucsc-b37-bed-converter/1")

# show 100 items from public
x <- a$app(visibility = "public")
length(x) # 100

x <- a$app(visibility = "public", complete = TRUE)
length(x) # 272 by Nov 2016
# this return nothing, because it is not in the first 100 returned names
a$app(visibility = "public", name = "bed converter")
# this return an app, because it pulls *all* app names and did search
a$app(visibility = "public", name = "bed converter", complete = TRUE)
```

[top](#top)

### 3.3.4 Experiment with Advance Access features

Similar to `offset` and `limit`, every API call accepts an argument named `advance_access`. This argument was first introduced in August 2017 and controls if a special field in the HTTP request header will be sent, which can enable the access to the “Advance Access” features in the Seven Bridges API. Note that the Advance Access features in the API are **not officially released yet**, therefore the API usages are subject to change, so please use with discretion.

In addition to modifying each API call that uses Advance Access features, the option can also be set globally at the beginning of your API script. This offers a one-button switch for users who want to experiment with the Advance Access features. The option is disabled by default:

```
library("sevenbridges")
getOption("sevenbridges")$advance_access
```

```
## [1] FALSE
```

For example, the Markers API is in Advance Access as of November 2018. If we try to use the Markers API to list markers available on a BAM file with the `advance_access` option disabled, it will return an error message:

```
req <- api(
  token = "your_token", path = "genome/markers?file={bam_file_id}",
  method = "GET"
)

httr::content(req)$"message"
```

```
## [1] "Advance access feature needs X-SBG-Advance-Access: advance header."
```

To enable the Advance Access features, one can use

```
opt <- getOption("sevenbridges")
opt$advance_access <- TRUE
options(sevenbridges = opt)
```

at the beginning of their scripts. Let’s check if the option has been enabled:

```
getOption("sevenbridges")$advance_access
```

```
## [1] TRUE
```

Send the API call again:

```
req <- api(
  token = "your_token", path = "genome/markers?file={bam_file_id}",
  method = "GET"
)
```

The information of the markers available on that BAM file will be returned:

```
httr::content(req)
```

```
$href
[1] "https://api.sbgenomics.com/v2/genome/markers?file={bam_file_id}&offset=0&limit=2"

$items
$items[[1]]
$items[[1]]$href
[1] "https://api.sbgenomics.com/v2/genome/markers/{bam_file_id}"

$items[[1]]$id
[1] "{bam_file_id}"

$items[[1]]$name
[1] "Marker Title"

$items[[2]]
$items[[2]]$href
[1] "https://api.sbgenomics.com/v2/genome/markers/{bam_file_id}"

$items[[2]]$id
[1] "{bam_file_id}"

$items[[2]]$name
[1] "Marker Title"

$links
list()
```

[top](#top)

## 3.4 Query Parameter `'fields'`

Please read the documentation [detail](https://docs.sevenbridges.com/reference#section-general-api-information).

All API calls take the optional query parameter fields. This parameter enables you to specify the fields you want to be returned when listing resources (e.g., all your projects) or getting details of a specific resource (e.g., a given project).

The fields parameter can be used in the following ways:

1. No `fields` parameter specified: calls return default fields. For calls that return complete details of a single resource, this is all their properties; for calls that list resources of a certain type, this is some default properties.
2. The `fields` parameter can be set to a list of fields: for example, to return the fields id, name and size for files in a project, you may issue the call `p$file(fields = "id,name,size")`
3. The fields parameter can be used to exclude a specific file: if you wish to omit certain field from the response, do so using the fields parameter with the prefix `!`. For example, to get the details of a file without listing its metadata, issue a call `p$file(fields = '!metadata')` The entire metadata field will be removed from the response.
4. The fields parameter can be used to include or omit certain nested fields, in the same way as listed in 2 and 3 above: for example, you can use `metadata.sample_id` or `origin.task` for files.
5. To see all fields for a resource, specify `fields="_all"`. This returns all fields for each resource returned. Note that if you are getting the details of a specific resource, the use of `fields="_all"` won’t return any more properties than would have been shown without this parameter — the use case is instead for when you are listing details of many resources. Please use with care if your resource has particularly large fields; for example, the raw field for an app resource contains the complete CWL specification of the app which can result in bulky response if listing many apps.
6. Negations and nesting can be combined freely, so, for example, you can issue `p$file(fields="id,name,status,!metadata.library,!origin")` or `p$task(fields="!inputs,!outputs")`.

Please try the following examples.

```
## default fields id, name, project
p$file()
## return file(s) with id, name, siae information
p$file(fields = "id,name,size")
## return file(s) with all available info
p$file(detail = TRUE)
## same as above
p$file(fields = "_all")
```

[top](#top)

## 3.5 Rate Limits

This call returns information about your current rate limit. This is the number of API calls you can make in one hour.

```
a$rate_limit()
```

[top](#top)

## 3.6 Users

This call returns a list of the resources, such as projects, billing groups, and organizations, that are accessible to you. Currently, this call will only return a successful response if {username} is replaced with your own username. Be sure to capitalize your username in the same way as when you registered for an account.

If you did not provide a username, it will show your user information.

```
# return your information
a$user()
# return user RFranklin's information
a$user("RFranklin")
```

[top](#top)

## 3.7 Billing Group and Invoices

### 3.7.1 For billing

If no billing group `id` is provided, this call returns a list of paths used to access billing information via the API. If a username is provided, this call lists all your billing groups, including groups that are pending or which have been disabled. If you specify `breakdown = TRUE`, the call below returns a breakdown of the spending per-project for the billing group specified by billing\_group. Information is also displayed for each of the projects a particular billing group is associated with, including task executions, their initiating user, start and end time, and their cost.

```
# return a BillingList object
(b <- a$billing())
a$billing(id = b$id, breakdown = TRUE)
```

[top](#top)

### 3.7.2 For invoices

If no Billing Group `id` provided, This call returns a list of invoices, with information about each, including whether or not the invoice is pending and the billing period it covers. This call returns information about all your available invoices unless you use the query parameter bg\_id to specify the ID of a particular Billing Group, in which case it will return the invoice incurred by that Billing Group only. If an invoice `id` is provided, this call retrieves information about the specified invoice, including the costs for analysis and storage and the invoice period.

```
a$invoice()
a$invoice(id = "your_id")
```

***Note:*** Currently, invoice is not an object. Instead, it just returns a regular R list.

[top](#top)

## 3.8 Project

Projects are the basic units to organize different entities: files, tasks, apps, etc. As such, many actions stem from the `Project` object.

[top](#top)

### 3.8.1 List all projects

The following call returns a list of all projects of which you are a member. Each project’s `project_id` and the path will be returned.

```
a$project()
```

If you want to list the projects owned by and accessible to a particular user, specify the `owner` argument as follows. Each project’s ID and path will be returned.

```
a$project(owner = "RFranklin")
a$project(owner = "Rosalind.Franklin")
```

To get details about the project(s), use `detail = TRUE`, as shown below.

```
a$project(detail = TRUE)
```

[top](#top)

### 3.8.2 Partial match project name

For a more friendly interface and convenient search, the `sevenbridges` package supports *partial name matching*. The first argument for the following request is `name`.

```
# want to return a project called
a$project("hello")
```

[top](#top)

### 3.8.3 Filter by project creation date, modification date, and creator

Project creation date, modification date, and creator information is useful for quickly locating the project you need, especially when you want to follow the life cycle of a large number of projects and distinguish recent projects from old ones. To facilitate such needs, the fields `created_by`, `created_on`, and `modified_on` are returned in the project query calls:

```
# return all projects matching the name "wgs"
p <- a$project("wgs", complete = TRUE)

# filter by project creators
creators <- sapply(p, "[[", "created_by")
which(creator == "RFranklin")

# filter by project creation date
create_date <- as.Date(sapply(p, "[[", "created_on"))
which(as.Date(create_date) < as.Date("2019-01-01"))

# filter by project modification date
modify_date <- as.Date(sapply(p, "[[", "modified_on"))
which(as.Date(modify_date) < as.Date("2019-01-01"))
```

[top](#top)

### 3.8.4 Create a new project

To create a new project, users need to specify the following:

* `name` (required)
* `billing_group_id` (required)
* `description` (optional)
* `tags` (optional): This has to be a list(). If you are using the API on the CGC environment, you can create a TCGA Controlled Data project by specifying `TCGA` in `tags`.
* `type` (optional): By default, we create a V2, CWL compatible project.

```
a$project_new("api_testing_tcga", b$id,
  description = "Test for API"
)
```

[top](#top)

### 3.8.5 Create a new project with TCGA controlled data on CGC

Follow the directions above, but pass `tcga` as a value for `tags`.

```
a$project_new("controlled_project", b$id,
  description = "Test for API", tags = list("tcga")
)
```

[top](#top)

### 3.8.6 Delete a project

You can delete a *single* project by making the request to `$delete()`. Note that the returned object from `a$project()` sometimes returns list if you use partial matching by name. The `$delete()` request cannot operate on a list. If you want to operate on a list of object, read more about batch functions in the relevant section below.

```
# remove it, not run
a$project("api_testing")$delete()
# check
# will delete all projects match the name
delete(a$project("api_testing_donnot_delete_me"))
```

[top](#top)

### 3.8.7 Update/edit a project

You can update the following information about an existing project:

* `name`
* `description`
* `billing_group_id`

```
a$project(id = "RFranklin/helloworld")
a$project(id = "RFranklin/helloworld")$update(
  name = "Hello World Update",
  description = "Update description"
)
```

### 3.8.8 Project member

#### 3.8.8.1 List members

This call returns a list of the members of the specified project. For each member, the response lists:

* The member’s username
* The member’s permissions in the specified project

```
a$project(id = "RFranklin/demo-project")$member()
```

[top](#top)

#### 3.8.8.2 Add a member

This call adds a new user to the specified project. It can only be made by a user who has admin permissions in the project.

Requests to add a project member must include the key `permissions`. However, if you do not include a value, the member’s permissions will be set to `false` by default.

Set permission by passing the following values: `copy`, `write`, `execute`, `admin`, or `read`.

Note: `read` is implicit and set by default. You can not be a project member without having `read` permissions.

```
m <- a$project(id = "RFranklin/demo-project")$
  member_add(username = "Rosalind.Franklin")
```

[top](#top)

#### 3.8.8.3 Update a member

This call edits a user’s permissions in the specified project. It can only be made by a user who has admin permissions in the project.

```
m <- a$project(id = "RFranklin/demo-project")$
  member(username = "Rosalind.Franklin")
m$update(copy = TRUE)
```

```
== Member ==
username : Rosalind.Franklin
-- Permission --
read : TRUE
write : FALSE
copy_permission : TRUE
execute : FALSE
admin : FALSE
```

[top](#top)

#### 3.8.8.4 Delete a member

To delete an existing member, call the `delete()` action on the `Member` object.

```
m$delete()
# confirm
a$project(id = "RFranklin/demo-project")$member()
```

[top](#top)

### 3.8.9 List all files

To list all files belonging to a project, use the following request:

```
p <- a$project(id = "RFranklin/demo-project")
p$file()
```

[top](#top)

## 3.9 Files, Metadata, and Tags

### 3.9.1 List all files

A better way to list files in a project uses the following:

```
# first 100 files, default offset = 0, limit = 100
p$file()
# list all files
p$file(complete = TRUE)
```

Alternatively, you can get files from the `Auth` object.

```
a$file(project = p$id)
a$file(name = "omni", project = p$id, detail = TRUE)
```

[top](#top)

### 3.9.2 Search and filter file(s)

#### 3.9.2.1 Rule of thumb

You can easily search by partial name, exact name, or id for many items like project, apps, files. Fortunately, we have more powerful filters for files. The user could search by metadata, tags, and the original task ID.

1. **First rule: understand the scope**: We know we have default `limit = 100` and `offset = 0` for first 100 items, unless you are using arguments `complete = TRUE`. Things are different when it comes to files. When you search with exact name (search by name with `exact = TRUE` on), metadata, or tags, it searches through ALL files. You do not have to specify `complete = TRUE`. Simply provide the project id or make the call from a project object as shown below.
2. **Second rule: understand the operation**: When filtering on any resource, including the same field several times with different filtering criteria results in an implicit OR operation for that field and the different criteria.When filtering by different specified fields, an implicit AND is performed between those criteria." so which are different fields, metadata, origin.task, tags, those are different fields. **Note** different metadata fields are treated as different fields as well, so it will be an **AND** operation for different metadata fields.

As a quick example, the following code gives us all files in the project `RFranklin/demo` that with metadata sample\_id “Sample1” **OR** “Sample2”, **AND** the library id has to be “EXAMPLE”, **AND** tags has either “hello” **OR** “world”.

```
p <- a$project(id = "RFranklin/demo")
p$file(
  metadata = list(
    sample_id = "Sample1",
    sample_id = "Sample2",
    library_id = "EXAMPLE"
  ),
  tag = c("hello", "world")
)
```

[top](#top)

#### 3.9.2.2 Search by name and id

There are two ways to return the exact file you want. One is by `id`, the other one is by exact `name`.

***For advanced users:*** When searching by name with `exact = TRUE`, it directly uses our public API call to match the exact name and return the object with a single query. When you turn off `exact`, it will `grep` all files or files defined with `limit` and `offset` first, then match by name, which could be slow.

To get the file id, you can check the URL on the web interface from the file details page.

```
# return single object id is "some_file_id"
p$file(id = "some_file_id")
# return a single object named a.fastq
p$file(name = "a.fastq", exact = TRUE)
# public file search using Auth object
a$public_file(name = "ucsc.hg19.fasta.fai", exact = TRUE)
a$public_file(id = "578cf94a507c17681a3117e8")
```

To get more than one object, the arguments `id` and `name` both accept vectors, so you can pass more than one `id` or `name` to it.

```
# get two files
p$file(name = c("test1.fastq", "test2.fastq"), exact = TRUE)
# get two files from public files using shorthand
a$public_file(
  name = c("ucsc.hg19.fasta.fai", "ucsc.hg19.fasta"),
  exact = TRUE
)
```

If you did not use `exact = TRUE`, the API would assume it is pattern grep and use partial matching.

```
# get matchd the pattern for searching first 100 files
p$file(name = c("gz", "fastq"))
# get all matched files from the project
p$file(name = c("gz", "fastq"), complete = TRUE)
# get all files matched ucsc
a$public_file(name = "ucsc.hg19", complete = TRUE)
```

[top](#top)

#### 3.9.2.3 Search by metadata

When you specify different metadata fields, the values use an **AND** operation, and when you specify the same metadata fields, the values use an **OR** operation.

To list all files in project `RFranklin/demo`, that have a `sample_id` of “Sample1” **OR** “Sample2” **AND** another metadata field library\_id set to “EXAMPLE”, make the following request.

```
p <- a$project(id = "RFranklin/demo")
p$file(metadata = list(
  sample_id = "Sample1",
  sample_id = "Sample2",
  library_id = "EXAMPLE"
))
```

[top](#top)

#### 3.9.2.4 Search by tags

Tags are more flexible than metadata. You can search with multiple tags using an **OR** operation.

This example shows how to return all files with the tag “s1” **OR** “s2”.

```
p <- a$project(id = "RFranklin/demo")
p$file(tag = c("s1", "s2"))
```

[top](#top)

#### 3.9.2.5 Search by original task id

You can also get all files from a task. There are two ways to do it:

1. Started from the `Task` object;
2. Use the filter criteria.

```
# list all outputs file from a task id
a$task(id = "53020538-6936-422f-80de-02fa65ae4b39")$file()

# OR
p <- a$project(id = "RFranklin/demo")
p$file(origin.task = "53020538-6936-422f-80de-02fa65ae4b39")
```

[top](#top)

### 3.9.3 Copy a file or group of files

This call copies the specified file to a new project. Files retain their metadata when copied, but may be assigned new names in their target project.

Note that Controlled Data files may not be copied to Open Data projects. To make this request, you should have copy permission within the project you are copying from.

Let’s try to copy a file from the Public File repository. The file’s id is “561e1b33e4b0aa6ec48167d7”.

You must provide

* `id`: file id or list/vector of files ids
* `project`: project id.
* `name` (optional):if omitted, use the same name as the original file name

```
# 1000G_omni2.5.b37.vcf
fid <- "561e1b33e4b0aa6ec48167d7"
fid2 <- "561e1b33e4b0aa6ec48167d3"
pid <- a$project("demo")$id
a$copyFile(c(fid, fid2), project = pid)
a$project(id = pid)$file()
```

**NOTE:** To copy a group of files, you need the `Auth$copyFile()` interface. The `id` of the files in your project will be different from their `id` in the Public Files repository.

Alternatively, you copy a **single file** as shown below.

```
a$project("hello")$file(id = fid)$copyTo(pid)
```

Notably, if you have many files to copy between projects, we would always recommend using the `Auth$bulk_file_copy()` method described in the Actions API section below, to batch copy the files in a single API call and save the number of API calls.

[top](#top)

### 3.9.4 Delete file(s)

***Note:*** The `delete` action only works for one file at a time. Be sure your `file` call returns a single file rather than a file list.

```
a$project("demo")$file()[[1]]$delete()
## confirm the deletion
a$project("demo")$file()
```

You can also delete a group of files or `FilesList` object, just **be careful** when using this function.

```
## return 5 files
a$project("demo")$file("phase1")
## delete all of them
delete(a$project("demo")$file("phase1"))
a$project("demo")$file("phase1")
```

[top](#top)

### 3.9.5 Download files

To get the download information, please use the following:

```
a$project("demo")$file()[[1]]$download_url()
```

To download directly from R, use the `download` call directly from a single `File` object.

```
fid <- a$project("demo")$file()[[1]]$id
a$project("demo")$file(id = fid3)$download("~/Downloads/")
```

I also created a `download` function for `FilesList` object to save your time, as follows:

```
fls <- a$project("demo")$file()
download(fls, "~/Downloads/")
```

To download all files from a project, use the following:

```
a$project("demo")$download("~/Downloads")
```

[top](#top)

### 3.9.6 Upload files via API

Seven Bridges platforms provide a few different methods for data import:

* Import from FTP or HTTP with the web interface
* The GUI uploader
* The file upload API that you can directly call with the `sevenbridges` package
* The command line uploader which can be invoked with the `sevenbridges` package

Use the API client uploader by calling the `project$upload` function to upload a file, a file list, or a folder recursively or via a manifest file.

#### 3.9.6.1 Upload single file

```
a <- Auth(username = "RFranklin", platform = "cgc")
fl <- system.file("extdata", "sample1.fastq", package = "sevenbridges")

(p <- a$project(id = "RFranklin/quickstart"))

# by default load .meta for the file
p$upload(fl, overwrite = TRUE)
# pass metadata
p$upload(fl, overwrite = TRUE, metadata = list(library_id = "testid2", platform = "Illumina x11"))
# rename
p$upload(fl,
  overwrite = TRUE, name = "sample_new_name.fastq",
  metadata = list(library_id = "new_id")
)
```

#### 3.9.6.2 Upload a folder

```
dir.ext <- system.file("extdata", package = "sevenbridges")
list.files(dir.ext)
p$upload(dir.ext, overwrite = TRUE)
```

#### 3.9.6.3 Upload a list of files

```
dir.ext <- system.file("extdata", package = "sevenbridges")
# enable full name
fls <- list.files(dir.ext, recursive = TRUE, full.names = TRUE)
p$upload(fls, overwrite = TRUE)
p$upload("~/Documents/Data/sbgtest/1000G_phase1.snps.high_confidence.b37.vcf")
```

#### 3.9.6.4 Upload files via a defined manifest file

A manifest file is a file used to define metadata values for a set of files. It can be used when uploading files to the platform to set their metadata. The supported file format for the manifest file is CSV. A CSV file contains a number of rows with columns which are separated with a comma. The format of a manifest file is defined in the [documentaion](https://docs.sevenbridges.com/docs/format-of-a-manifest-file).

Some requirements:

* The first row has to contain column names which are parsed as metadata fields (e.g. `sample`, `library`). When it is not customized fields, we do the conversion for meta fields like `sample_id` which need to be a string.
* The first column has to contain the names of the files which will be uploaded. In case the files are not in the same directory as the manifest file, you should also include a path to the files (e.g. `../filename.fastq`).

We allow users to

* choose to upload metadata or not
* choose to use `subset` to upload only part of the metadata
* choose to use `subset` to upload only part of files with filter

Please check the examples below.

```
# upload all fiels and all metadata
p$upload(manifest_file = "~/manifest.csv")

# verbal = TRUE, print single file level progress
p$upload(manifest_file = "~/manifest.csv", overwrite = TRUE, verbal = TRUE)

# manifest_metadata = FALSE doens't attach any metadata
p$upload(manifest_file = "~/manifest.csv", manifest_metadata = FALSE, overwrite = TRUE)

# filter files first, upload only files with score < 0.5
p$upload(manifest_file = "~/manifest.csv", overwrite = TRUE, subset = score < 0.5)

# attach all meta except "bad_field" and "sample_id"
p$upload(
  manifest_file = "~/manifest.csv", overwrite = TRUE,
  subset = score < 0.5, select = -c(bad_field, sample_id)
)
```

[top](#top)

### 3.9.7 Upload files via command line uploader

As an alternative to API file uploading, we also offer an interface in the `sevenbridges` package for uploading (possibly large) files via the Java-based command line uploader.

The first step is to download the command line uploader. With `get_uploader()`, users can easily download the uploader to a local directory for a specified Seven Bridges platform, for example, the Cancer Genomics Cloud:

```
get_uploader("cgc", "~/Downloads/")
```

To list the available projects accessible from your account via the uploader, use `cli_list_projects()`, with your authentication token for that platform and the directory containing the uploader:

```
cgc_token <- "your_cgc_token"
cgc_uploader <- "~/Downloads/cgc-uploader/"

cli_list_projects(
  token = cgc_token,
  uploader = cgc_uploader
)
```

The function will return a character vector containing the available projects which you could upload files to, in the form of `username/project-name`.

Similarly, to list all the file tags in a project via the uploader, use `cli_list_tags()`:

```
cli_list_tags(
  token = cgc_token,
  uploader = cgc_uploader,
  project = "username/project-name"
)
```

Eventually, use `cli_upload()` to upload local files to a project:

```
cli_upload(
  token = cgc_token,
  uploader = cgc_uploader,
  file = "~/example.fastq",
  project = "username/project-name"
)
```

[top](#top)

### 3.9.8 Update a file

You can call the `update()` function from the Files object. With this call, the following can be updated:

* The file’s `name`.
* The file’s `metadata`. The metadata is in the form of a list. Note that as this call overwrites all the metadata for a given file, please supply a full list of all the metadata for the file. Conversely, you can use the [`set_meta()` function](#set_metadata) to patch but not overwrite the metadata for a file.

If no parameters were provided, this call will get the details of that file and update the object itself.

```
(fl <- a$project(id = "RFranklin/demo-project")$file(name = "sample.fastq"))
```

```
== File ==
id : 56c7916ae4b03b56a7d7
name : sample.fastq
project : RFranklin/demo-project
```

**Show metadata**

```
# show metadata
fl$meta()
```

**Update meta**

```
fl$update(
  name = "sample.fastq",
  metadata = list(
    new_item1 = "item1",
    new_item2 = "item2",
    file_extension = "fastq"
  )
)
# check it out
fl$meta()
```

[top](#top)

### 3.9.9 Metadata operations

Learn about metadata fields and their values for the relevant environment: [[Seven Bridges Platform](https://docs.sevenbridges.com/docs/metadata-on-the-seven-bridges-platform)] [[CGC](http://docs.cancergenomicscloud.org/v1.0/docs/metadata-for-private-data)].

Note that the name of a file is not the same as its ID. A file’s ID is a hexadecimal string automatically assigned to a file in a project. The file’s name is a human-readable string. For information, please see the API overview for the [Seven Bridges Platform](https://docs.sevenbridges.com/v1.0/docs/the-api) and for the [CGC](http://docs.cancergenomicscloud.org/docs/the-cgc-api).

**Get metadata**

To get the metadata for a file, call the `meta()` function, as shown below.

```
# meta is pulling the latest information via API
fl$meta()
# field metadata saved the previously saved one
fl$metadata
```

**Set metadata**

Files from curated datasets on Seven Bridges environments have a defined set of metadata which is visible on the visual interface of each environment. However, you can also pass additional metadata for each file which is stored with your copy of the file in your project.

To set metadata but not overwrite all previously stored metadata, call the `set_meta()` function from the Files object. Unlike the `update()` function for the Files object, the `set_meta()` function doesn’t overwrite the metadata field. To overwrite the metadata field, use the `update()` function or pass the optional argument `overwrite = TRUE` for the `set_meta()` call.

```
fl$set_meta(new_item3 = "item3")
fl
# oops it removed rest of the meta
fl$set_meta(new_item4 = "item4", overwrite = TRUE)
fl
```

**Check details of each metadata field**

You can use the `Metadata()` constructor to check the details of each metadata field. Simply call the function (name of the metadata) to display descriptions and enumerated items. Please pay attention to the `suggested_values` field.

```
# check which schema we have
Metadata()$show(full = TRUE)
# check details for each, play with it
platform()
paired_end()
quality_scale()
```

As you can see, some metadata fields have suggested values. To construct the metadata, use `Metadata()` directly to pass the metadata fields and their values directly into the call. The call will perform the validation.

```
Metadata(
  platform = "Affymetrix SNP Array 6.0",
  paired_end = 1,
  quality_scale = "sanger",
  new_item = "new test"
)
```

[top](#top)

### 3.9.10 Tag file(s)

You can tag your files with keywords or strings to make it easier to identify and organize files. Tags are different from metadata and are more convenient and visible from the files list on the visual interface.

**Add a new tag**

To add a new tag, call the `obj$add_tag()` method for the File object with a single tag string or a list or vector of tags.

**Overwrite the tags for a file**

To completely overwrite the tags for a file, use the `obj$set_tag()` method, which contains the default argument `overwrite = TRUE`.

Let’s use a file called `sample.bam` and play with its tags.

```
p <- a$project(id = "RFranklin/s3tutorial")
fl <- p$file("sample.bam", exact = TRUE)
# show tags for single file
fl$tag()
# add new tags
fl$add_tag("new tag")
# equavilent to
fl$set_tag("new tag 2", overwrite = FALSE)
# set tags to overwrite existing
x <- list("this", "is", 1234)
fl$set_tag(x)
# filter by tags
p$file(tag = c("1234", "new"))
p$file(tag = list("1234", "new"))
p$file(tag = "1234")
```

Below, find convenient methods for `FilesList`. Let’s add the tag “s1” to a group files matching “Sample1” and add the tag “s2” to a group of files that match “s2”. Then, we will filter by these tags to obtain specific files.

```
# work on a group of files
# add tag "s2" to a group of files named with "Sample2" in it
fl2 <- p$file("Sample2")
add_tag(fl2, "s2")
# add tag "s2" to a group of files named with "Sample1" in it
fl1 <- p$file("Sample1")
add_tag(fl1, "s1")
# filter by tag s1 or s2
p$file(tag = "s1")
p$file(tag = "s2")
# get files tagged with s2 and 1234
p$file(tag = list("s2", "s1"))
```

[top](#top)

## 3.10 Folders

The Folders API allows you to organize your files using folders in projects. From a filesystem perspective, folders are simply a special type of file. Therefore, within this package, the folder objects are still represented using the same class as the file objects above, only with specific methods for operating on them.

[top](#top)

### 3.10.1 Get project root folder

To create new folders and manage files using folders in a project, we first need to get the information about the root folder of the project. For example

```
p <- a$project(id = "RFranklin/folders-api-testing")
```

We can get the project root folder ID:

```
p$get_root_folder_id()
```

```
[1] "5bd7c53ee4b04b8fb1a9f63c"
```

Or, return the project root folder as an object:

```
(root_folder <- p$get_root_folder())
```

```
== Files ==
id : 5bd7c53ee4b04b8fb1a9f63c
name : 8c02ceda-e46b-49c0-362f-4318fa8f3e4k
project : RFranklin/folders-api-testing
created_on : 2018-10-29T18:45:50Z
modified_on : 2018-10-29T18:45:50Z
type : folder
```

[top](#top)

### 3.10.2 Create a folder

To create a new\_folder under the project root folder, use

```
folder1 <- root_folder$create_folder("folder1")
```

To create a new folder under `folder1`, use

```
folder2 <- folder1$create_folder("folder2")
```

[top](#top)

### 3.10.3 Copy files between folders

Let’s copy a public reference file into the project root folder:

```
file_public <- a$public_file(name = "Homo_sapiens_assembly38.fasta", exact = TRUE)
file1 <- file_public$copy_to_folder(root_folder$id)
```

We can also rename the file when copying it into a folder:

```
file2 <- file_public$copy_to_folder(root_folder$id, "ref_grch38.fasta")
```

[top](#top)

### 3.10.4 Move files between folders

To move files to another folder (for example, `folder1` we just created), use

```
file1 <- file1$move_to_folder(folder1$id)
```

[top](#top)

### 3.10.5 List folder contents

To list all files and folders in a folder (for example, the root folder), use

```
(contents_root <- root_folder$list_folder_contents(complete = TRUE))
```

```
[[1]]
== Files ==
id : 5bede476e4b03b8ff38c28ba
name : folder1
project : RFranklin/folders-api-testing
parent : 5bd7c53ee4b04b8fb1a9f63c
type : folder

[[2]]
== Files ==
id : 5bedc431e4b09b8ff3966e9c
name : ref_grch38.fasta
project : RFranklin/folders-api-testing
parent : 5bd7c53ee4b04b8fb1a9f63c
type : file
```

If `complete = FALSE` (default), it will only return the (first) page from the API based on `offset` and `limit`.

To list only files or only folders, set `type = "file"` or `type = "folder"`:

```
root_folder$list_folder_contents(type = "file", complete = TRUE)
root_folder$list_folder_contents(type = "folder", complete = TRUE)
```

[top](#top)

### 3.10.6 Get file and folder details

Get the type of a single file/folder object:

```
contents_root[[1]]$typeof()
```

```
[1] "folder"
```

Or, get the type(s) for all objects in the folder:

```
sapply(contents_root, function(x) x$typeof())
```

```
[1] "folder" "file"
```

Sometimes, it’s convenient to get the parent folder ID for a file or folder:

```
contents_root[[1]]$get_parent_folder_id()
```

```
[1] "5bd7c53ee4b04b8fb1a9f63c"
```

This is essentially the root folder ID. Alternatively, to get the parent folder as an object, use

```
contents_root[[1]]$get_parent_folder()
```

[top](#top)

### 3.10.7 Delete files in a folder

We can delete a file in a folder:

```
file1$delete()
```

[top](#top)

### 3.10.8 Delete a folder

If a folder still has files in it, it cannot be deleted:

```
file2 <- file2$move_to_folder(folder2$id)
folder2$delete()
```

```
Error: HTTP Status 400: Deleting non-empty folders is not supported.
```

We need to delete all files (and subfolders) within a folder before deleting the folder itself:

```
file2$delete()
folder2$delete()
folder1$delete()
```

[top](#top)

## 3.11 Apps

All Seven Bridges environments support the [Common Workflow Language (CWL)](http://www.commonwl.org/) natively to allow for reproducible and portable workflows and tools. In this section, we will work with apps, including tools and workflows, via the API using the `sevenbridges` R package.

[top](#top)

### 3.11.1 List all apps

This call lists all the apps available to you.

```
a$app()
# or show details
a$app(detail = TRUE)
```

**Search for an app by name**

To search for a specific app by its name, pass a pattern for the `name` argument or provide a unique `id` as shown below.

```
# pattern match
a$app(name = "STAR")
# unique id
aid <- a$app()[[1]]$id
aid
a$app(id = aid)
# get a specific revision from an app
a$app(id = aid, revision = 0)
```

**List all apps in a project**

To list all apps belonging to a specific project, use the `project` argument.

```
# my favorite, always
a$project("demo")$app()

# or alternatviely
pid <- a$project("demo")$id
a$app(project = pid)
```

**List all public apps**

To list all public apps, use the `visibility` argument.

```
# show 100 items from public
x <- a$app(visibility = "public")
length(x)
x <- a$app(visibility = "public", complete = TRUE)
length(x)
x <- a$app(project = "RFranklin/helloworld", complete = TRUE)
length(x)
a$app(visibility = "public", limit = 5, offset = 150)
```

**Search through all public apps in all locations**

To search for a public app cross all locations, make the following call. Note that this may take a bit of time.

```
a$app("STAR", visibility = "public", complete = TRUE)
```

[top](#top)

### 3.11.2 Copy an app

This call copies the specified app to a specified project. The app should be one in a project that you can access, either an app which has been uploaded by a project member or a publicly available app which has been copied to the project.

This call requires the following two arguments:

* `project`: include the project id
* `name` (optional): use this field to optionally re-name your app

```
aid <- a$public_app()[[1]]$id
a$copy_app(aid, project = pid, name = "copy-rename-test")
# check if it is copied
a$app(project = pid)
```

You can also copy directly from the app object, as shown below.

```
app <- a$public_app(id = "admin/sbg-public-data/rna-seq-alignment-star")
app$copy_to(
  project = "RFranklin/api-testing",
  name = "copy of star"
)
```

[top](#top)

### 3.11.3 Get an app’s CWL description

This call returns the raw CWL of a specific app, including its raw CWL. The call differs from the call to GET details of an app in that it returns a JSON object that is the CWL.

The app should be one in a project that you can access, either an app which has been uploaded by a project member or a publicly available app which has been copied to the project.

To get a specific revision, pass the `revision` argument.

```
ap <- a$app(visibility = "public")[[1]]
a$project("demo")$app("index")
# get a specific revision
a$project("demo")$app("index", revision = 0)
```

Coming soon: converting apps to CWL objects

[top](#top)

### 3.11.4 Add CWL as an app

To add a CWL object as an app, use the `app_add` function call for a `Project` object. The following two parameters are required:

* `short_name`: Project short names are based on the name you give to a project when you create it. Learn more about project short names on the [Seven Bridges Platform](https://docs.sevenbridges.com/v1.0/docs/the-api#section-project-short-names) or the [CGC](http://docs.cancergenomicscloud.org/v1.0/docs/the-cgc-api#section-project-short-names).
* `filename`: The name of the JSON file containing the CWL.

```
cwl.fl <- system.file("extdata", "bam_index.json", package = "sevenbridges")
a$project("demo")$app_add(short_name = "new_bam_index_app", filename = cwl.fl)
a$project("demo")$app_add(short_name = "new_bam_index_app", revision = 2, filename = cwl.fl)
```

Note: If you provide the same `short_name`, this will add a new revision.

[top](#top)

### 3.11.5 Describe CWL in R directly

This is introduced in another vignette (`vignette("apps", "sevenbridges")`).

[top](#top)

### 3.11.6 Create test or keep the previous test for Tool

On Seven Bridges platforms, when you create or update your tools in the GUI, there is a test tab allow users to tweak the parameters and see what it looks like in your command line simulated terminal. To do this via R when you push your Tool object to your project, you need to provide `"sbg:job"` information like the example shown below

```
rbx <- Tool(
  id = "runif",
  label = "Random number generator",
  hints = requirements(
    docker(pull = "RFranklin/runif"),
    cpu(1), mem(2000)
  ),
  baseCommand = "runif.R",
  inputs = in.lst,
  outputs = out.lst,
  "sbg:job" = list(
    allocatedResources = list(mem = 9000, cpu = 1),
    inputs = list(min = 1, max = 150)
  )
)
p$app_add("random", rbx)
```

Or if you have created test info on the platform or previously pushed one, and you want to keep the previous test setup. We provide an argument named `keep_test` to allow you to keep the previous revision’s test information.

```
rbx <- Tool(
  id = "runif",
  label = "Random number generator",
  hints = requirements(
    docker(pull = "RFranklin/runif"),
    cpu(1), mem(2000)
  ),
  baseCommand = "runif.R",
  inputs = in.lst,
  outputs = out.lst
)
p$app_add("random", rbx, keep_test = TRUE)
```

[top](#top)

## 3.12 Tasks

### 3.12.1 List tasks

This call returns a list of tasks that you can access. You can filter tasks by status.

```
# all tasks
a$task()
# filter
a$task(status = "completed")
a$task(status = "running")
```

To list all the tasks in a project, use the following.

```
# a better way
a$project("demo")$task()

# alternatively
pid <- a$project("demo")$id
a$task(project = pid)
```

To list all tasks with details, pass `detail = TRUE`.

```
p$task(id = "your task id here", detail = TRUE)
p$task(detail = TRUE)
```

To list a batch task using the `parent` parameter, pass the batch parent task id.

```
p <- a$project(id = "RFranklin/demo")
p$task(id = "2e1ebed1-c53e-4373-870d-4732acacbbbb")
p$task(parent = "2e1ebed1-c53e-4373-870d-4732acacbbbb")
p$task(parent = "2e1ebed1-c53e-4373-870d-4732acacbbbb", status = "completed")
p$task(parent = "2e1ebed1-c53e-4373-870d-4732acacbbbb", status = "draft")
```

[top](#top)

### 3.12.2 Create a draft task

To create a draft task, you need to call the `task_add` function from the Project object. And you need to pass the following arguments:

* `name`: The name for this task
* `description` (optional): A description for this task
* `app`: The app id
* `inputs`: A list of inputs for this task

```
# push an app first
fl.runif <- system.file("extdata", "runif.json", package = "sevenbridges")
a$project("demo")$app_add("runif_draft", fl.runif)
runif_id <- "RFranklin/demo-project/runif_draft"
# create a draft task
a$project("demo")$task_add(
  name = "Draft runif 3",
  description = "Description for runif 3",
  app = runif_id,
  inputs = list(min = 1, max = 10)
)
# confirm
a$project("demo")$task(status = "draft")
```

[top](#top)

### 3.12.3 Modify a task

Call the `update` function from a Task object to update the following:

* `name`
* `description`
* `inputs` list. Note that you can only update the items you provided.

```
# get the single task you want to update
tsk <- a$project("demo")$task("Draft runif 3")
tsk
tsk$update(
  name = "Draft runif update",
  description = "draft 2",
  inputs = list(max = 100)
)
# alternative way to check all inputs
tsk$getInputs()
```

[top](#top)

### 3.12.4 Run a task

This call runs (“executes”) the specified task. Only tasks with a “DRAFT” status may be run.

```
tsk$run()
# run update without information just return latest information
tsk$update()
```

[top](#top)

### Monitor a running task and set the hook function

To monitor a running task, call `monitor` from a Task object.

* The first argument sets the interval time to check the status
* Rest of the arguments might be used for the hook function

```
tsk$monitor()
```

Get and set default a hook function for task status. Currently, failed tasks will break the monitoring.

Note: Hook function has to return `TRUE` (break monitoring) or `FALSE` (continuing) in the end.

```
getTaskHook("completed")
getTaskHook("draft")
setTaskHook("draft", function() {
  message("never happens")
  return(TRUE)
})
getTaskHook("draft")
```

[top](#top)

### 3.12.5 Abort a running task

This call aborts the specified task. Only tasks whose status is “RUNNING” may be aborted.

```
# abort
tsk$abort()
# check
tsk$update()
```

[top](#top)

### 3.12.6 Delete a task

Note that you can only delete DRAFT tasks, not running tasks.

```
tsklst <- a$task(status = "draft")
# delete a single task
tsklst[[1]]$delete()
# confirm
a$task(status = "draft")
# delete a list of tasks
delete(tsklst)
```

[top](#top)

### 3.12.7 Download all files from a completed task

```
tsk$download("~/Downloads")
```

[top](#top)

### 3.12.8 Run tasks in batch mode

To run tasks in batch mode, (check `?batch`) for more details. The code below is a mockup example.

```
# batch by items
(tsk <- p$task_add(
  name = "RNA DE report new batch 2",
  description = "RNA DE analysis report",
  app = rna.app$id,
  batch = batch(input = "bamfiles"),
  inputs = list(
    bamfiles = bamfiles.in,
    design = design.in,
    gtffile = gtf.in
  )
))

# batch by metadata, input files has to have metadata fields specified
(tsk <- p$task_add(
  name = "RNA DE report new batch 3",
  description = "RNA DE analysis report",
  app = rna.app$id,
  batch = batch(
    input = "fastq",
    c("metadata.sample_id", "metadata.library_id")
  ),
  inputs = list(
    bamfiles = bamfiles.in,
    design = design.in,
    gtffile = gtf.in
  )
))
```

[top](#top)

### 3.12.9 Download all files from a batch task

We can loop through the batch task and download the files in each child task:

```
batch_task <- p$task(parent = "<parent_task_id>")
tsk_id <- sapply(batch_task, "[[", "id")
for (i in 1:length(tsk_id)) {
  tsk <- p$task(id = tsk_id[i])
  tsk$file()
  tsk$download()
}
```

## 3.13 Volumes

Cloud storage providers come with their own interfaces, features, and terminology. At a certain level, though, they all view resources as data objects organized in repositories. Authentication and operations are commonly defined on those objects and repositories, and while each cloud provider might call these things different names and apply different parameters to them, their basic behavior is the same.

Seven Bridges environments mediate access to these repositories using volumes. A volume is associated with a particular cloud storage repository that you have enabled Seven Bridges to read from (and, optionally, to write to). Currently, volumes may be created using two types of cloud storage repository: Amazon Web Services’ (AWS) S3 buckets and Google Cloud Storage (GCS) buckets.

A volume enables you to treat the cloud repository associated with it as external storage. You can ‘import’ files from the volume to your Seven Bridges environment to use them as inputs for computation. Similarly, you can write files from the Seven Bridges environment to your cloud storage by ‘exporting’ them to your volume.

Learn more about volumes on the [Seven Bridges Platform](https://docs.sevenbridges.com/docs/connecting-cloud-storage-overview) and the [CGC](http://docs.cancergenomicscloud.org/docs/connect-cloud-storage-overview).

### 3.13.1 Create a volume

```
a <- Auth(user = "RFranklin", platform = "aws-us")

a$add_volume(
  name = "tutorial_volume",
  type = "s3",
  bucket = "RFranklin-demo",
  prefix = "",
  access_key_id = "your_access_key_id",
  secret_access_key = "your_secret_access_key",
  sse_algorithm = "AES256",
  access_mode = "RW"
)
```

[top](#top)

### 3.13.2 List and search all volumes

```
# list all volume
a$volume()
# get unique volume by id
a$volume(id = "RFranklin/RFranklin_demo")
# partial search by name
a$volume(name = "demo")
```

[top](#top)

### 3.13.3 Get a volume’s detail

```
v <- a$volume()
v[[1]]$detail()
```

[top](#top)

### 3.13.4 Delete volume

This call deletes a volume you’ve created to refer to storage on Amazon Web Services or Google Cloud Storage.

Note that any files you’ve imported from your volume onto a Seven Bridges environment, known as an alias, will no longer be usable. If a new volume is created with the same volume\_id as the deleted volume, aliases will point to files on the newly created volume instead (if those exist).

```
a$volume(id = "RFranklin/RFranklin_demo")$delete()
```

[top](#top)

### 3.13.5 Import file from volume to project

This call imports a file from volume to your project.

```
v <- a$volume(id = "RFranklin/tutorial_volume")
res <- v$import(
  location = "A-RNA-File.bam.bai",
  project = "RFranklin/s3tutorial",
  name = "new.bam.bai",
  overwrite = TRUE
)

# get job status update
# state will be "COMPLETED" when it's finished, otherwise "PENDING"
v$get_import_job(res$id)
v
```

### 3.13.6 Export file from project to volume

**Important** :

* The file selected for export must not be a public file or an alias. Aliases are objects stored in your cloud storage bucket which have been made available on a Seven Bridges environment. The volume you are exporting to must be configured for read-write access. To do this, set the access\_mode parameter to RW when creating or modifying a volume.
* If this call is successful, the original project file will become an alias to the newly exported object on the volume. The source file will be deleted from the Seven Bridges environment and, if no more copies of this file exist, it will no longer count towards your total storage price on the Seven Bridges environment.

When testing, please update your file in a project.

```
res <- v$export(
  file = "579fb1c9e4b08370afe7903a",
  volume = "RFranklin/tutorial_volume",
  location = "", # when "" use old name
  sse_algorithm = "AES256"
)
# get job status update
# state will be "COMPLETED" when it's finished other wise "PENDING"
v$get_export_job(res$id)
v
```

[top](#top)

## 3.14 Public Files and Apps

Seven Bridges hosts publicly accessible files and apps on its environments. The `sevenbridges` package provides two easy function calls from the Authentication object to search for and copy files and apps to a project.

### 3.14.1 Public files

```
# list the first 100 files
a$public_file()
# list by offset and limit
a$public_file(offset = 100, limit = 100)
# simply list everything!
a$public_file(complete = TRUE)
# get exact file by id
a$public_file(id = "5772b6f0507c175267448700")
# get exact file by name with exact = TRUE
a$public_file(name = "G20479.HCC1143.2.converted.pe_1_1Mreads.fastq", exact = TRUE)
# with exact = FALSE by default search by name pattern
a$public_file(name = "fastq")
a$public_file(name = "G20479.HCC1143.2.converted.pe_1_1Mreads.fastq")
```

Public files are hosted in the project called `admin/sbg-public-data`, and you can alternatively use the `file` request to get files you need.

[top](#top)

### 3.14.2 Public apps

For public apps, there are similar API calls.

```
# list for 100 apps
a$public_app()
# list by offset and limit
a$public_app(offset = 100, limit = 50)
# search by id
a$public_app(id = "admin/sbg-public-data/control-freec-8-1/12")
# search by name in ALL apps
a$public_app(name = "STAR", complete = TRUE)
# search by name with exact match
a$public_app(name = "Control-FREEC", exact = TRUE, complete = TRUE)
```

[top](#top)

## 3.15 Actions

The Actions API allows you to copy files between projects in batch or send feedback to Seven Bridges.

### 3.15.1 Copy files between projects

This call allows you to copy files between projects. Unlike `a$copyFile()` or `file(...)$copyTo(...)` which only copy one file with each API call, this call lets you batch the copy operation and copy a list of files at a time.

```
p <- a$project(id = "RFranklin/source-project")
f <- p$file(complete = TRUE)
# get all file IDs
file_ids <- sapply(f, "[[", "id")
# bulk copy files to the target project
req <- a$bulk_file_copy(file_ids, "RFranklin/target-project")
# print the response list
(req <- unname(req))
```

```
[[1]]
[[1]]$status
[1] "OK"

[[1]]$new_file_id
[1] "5bf31316e4b09b8ff39f9df7"

[[1]]$new_file_name
[1] "merged-tumor.converted.pe_1.fastq"

...
```

We can use `sapply` to get the copy operation status, new file IDs, and (new) file names for the copied files:

```
sapply(req, "[[", "status")
```

```
[1] "OK" "OK" "OK" "OK"
```

```
sapply(req, "[[", "new_file_id")
```

```
[1] "5bf31316e4b09b8ff39f9df7" "5bf31316e4b09b8ff39f9dfa" "5bf31316e4b09b8ff39f9df4" "5bf31316e4b09b8ff39f9df1"
```

```
sapply(req, "[[", "new_file_name")
```

```
[1] "merged-tumor.converted.pe_1.fastq"  "merged-tumor.converted.pe_2.fastq"  "merged-normal.converted.pe_2.fastq"
[4] "merged-normal.converted.pe_1.fastq"
```

Note that a file’s ID is dependent on the project it is contained in. So, when you copy files from one project to another, their IDs will be different in the target project. The file names, however, do not change by copying, except where copying would yield non-unique file names in the target project.

[top](#top)

### 3.15.2 Send a feedback item

Use this call to send feedbacks to Seven Bridges via the API. There are three feedback types available: `"idea"`, `"thought"`, or `"problem"`. You can send one feedback item per minute.

```
a$send_feedback(
  "This is a test for sending feedback via API. Please ignore this message.",
  type = "thought"
)
```

[top](#top)

## 3.16 Enterprise

The Enterprise API allows you to manage your Enterprise on the Seven Bridges Platform via dedicated API calls.

### 3.16.1 API token for the division context

Note that the authentication token for the Enterprise API is a separate token generated under the context of your division, which is different from your non-division (personal) auth token. You may see the following error when using the non-division token to call the Enterprise API:

```
Error: HTTP Status 400: Insufficient privileges to access this resource. Not a division user.
```

If you see this error, first switch to the correct division context (use the dropdown menu in the upper left corner), then click the “Developer” tab, click “Auth token”, generate the token, and use this token for API authentication.

[top](#top)

### 3.16.2 List all divisions

To list all divisions you have access to, use

```
a <- Auth(...)

a$division()
```

```
[[1]]
== Division ==
  id : the-division
name : The Division
[[2]]
== Division ==
  id : another-division
name : Another Division
```

[top](#top)

### 3.16.3 Get details of a division

To get the details (ID and name) of a division, for example, the first division listed above, use

```
(d <- a$division("the-division"))
```

```
== Division ==
  id : the-division
name : The Division
```

[top](#top)

### 3.16.4 Create a team

Let’s create two new teams under this division:

```
team1 <- d$create_team(name = "New Team 1")
team2 <- d$create_team(name = "New Team 2")
```

[top](#top)

### 3.16.5 Get details of a team

To check the details (ID and name) of the first team we just created, use

```
d$team(team1$id)
```

```
== Team ==
id : 39f6cb44-9e3c-40e7-8639-3c0f3c1e4892
name : New Team 1
```

[top](#top)

### 3.16.6 Add a team member

We can add division members to the teams we created. For example, let’s add yourself (with the division username `the-division/your_username`) and another division member (with the division username `the-division/another_username`) to the first team. Also, let’s add yourself to the second team:

```
team1$add_member("the-division/your_username")
team1$add_member("the-division/another_username")

team2$add_member("the-division/your_username")
```

[top](#top)

### 3.16.7 List team members

List all team members and their roles:

```
(m1 <- team1$member())
(m2 <- team2$member())
```

```
[[1]]
== Team Member ==
username : the-division/another_username
role : ADMIN
[[2]]
== Team Member ==
username : the-division/your_username
role : ADMIN
```

```
[[1]]
== Team Member ==
username : the-division/your_username
role : ADMIN
```

[top](#top)

### 3.16.8 Remove a team member

Let’s remove a user from the first team:

```
team1$remove_member(m1[[1]]$username)
```

[top](#top)

### 3.16.9 Rename a team

To rename a team, use:

```
team1$rename("Another Team Name")
```

```
== Team ==
id : 39f6cb44-9e3c-40e7-8639-3c0f3c1e4892
name : Another Team Name
```

After renaming, the team will still have the same ID, just with a different name.

[top](#top)

### 3.16.10 List your teams in the division

To list the teams that you are a member of in a division, use

```
d$team()
```

Note that there could be a one-minute delay in the backend here if you just added yourself to the teams seconds ago.

[top](#top)

### 3.16.11 Delete a team

To delete the teams we created, use

```
team1$delete()
team2$delete()
```

[top](#top)

## 3.17 Markers

The Markers API allows you to add, get, modify, and delete genetic markers on BAM files. These genetic markers can be then examined in the [Seven Bridges Genome Browser](https://docs.sevenbridges.com/v1.0/docs/seven-bridges-genome-browser).

As of November 2018, the Markers API is still an Advance Access feature. To use this API, set the `advance_access` option to `TRUE`:

```
opt <- getOption("sevenbridges")
opt$advance_access <- TRUE
options(sevenbridges = opt)
```

### 3.17.1 Create a marker

Let’s create a new marker on a BAM file first:

```
# locate the project
p <- a$project(id = "RFranklin/api-markers")
# search for files with `.bam` in their names
f <- p$file(name = ".bam")
# use the first BAM file
f <- p$file(id = f[[1]]$id)

# create two markers
m1 <- f$create_marker("The First Marker", start = 21631232, end = 21631232)
m2 <- f$create_marker("The Second Marker", start = 21631156, end = 21631158, chromosome = "chr7", private = FALSE)
```

The possible parameters for creating the marker include

* The marker’s name (`name`)
* The marker’s position (`start` and `end`)
* Chromosome number (`chromosome`)
* Whether the marker is private or public (`private`).

The marker’s name and its position are mandatory parameters, and the others are optional.

### 3.17.2 List markers available on a file

To list all markers on a file, use:

```
f$marker()
```

```
[[1]]
== Marker ==
id : 5bf478e5d38f185f0c23bc44
name : The First Marker
[[2]]
== Marker ==
id : 5bf478e6d38f185f0c23bc45
name : The Second Marker
```

### 3.17.3 Get details for a marker

We can also check the details for a specific marker:

```
marker_id <- m1$id
f$marker(id = marker_id)
```

```
== Marker ==
id : 5bf478e5d38f185f0c23bc44
name : The First Marker
file : 5bf46c1be4b39b8f5232282e
position:
  start : 21631232
  end : 21631232
created_time : 2018-11-20T21:13:00Z
created_by : RFranklin
private : TRUE
```

### 3.17.4 Modify a marker

We can also modify the information of existing markers:

```
(m1 <- m1$modify(name = "New Marker Name", end = 21631233, private = FALSE))
```

```
== Marker ==
id : 5bf478e5d38f185f0c23bc44
name : New Marker Name
file : 5bf46c1be4b39b8f5232282e
position:
  start : 21631232
  end : 21631233
created_time : 2018-11-20T21:13:00Z
created_by : RFranklin
private : FALSE
```

All of the five marker parameters mentioned above can be modified.

### 3.17.5 Delete a marker

To delete the markers we just added, use

```
m1$delete()
m2$delete()
```

## 3.18 Get Raw Response from httr

In the easy API, we return an object which contains the raw response from `httr` as a field. You can either call `response()` on that object or use the field as is.

[top](#top)

## 3.19 Batch Operation on Project/Files/Tasks

Currently, users have to use `lapply` to do those operations themselves. It’s a simple implementation.

In this package, we implement `delete` and `download` for some objects like task, project, or file.

[top](#top)

# 4 API Cheatsheet

Quick API cheat sheet (work in progress):

```
# 01 - Authentication ----------------------------------------------------------

getToken()

# authentication methods
a <- Auth(token = token)
a <- Auth(token = token, platform = "cgc")
a <- Auth(from = "env")
a <- Auth(from = "file", profile_name = "aws-us-user")

# list all API calls
a$api()

# API rate limit
a$rate_limit()

# 02 - User -------------------------------------------------------------------

a$user()
a$user("RFranklin")

# 03 - Billing -----------------------------------------------------------------

a$billing()
a$billing(id = ..., breakdown = TRUE)
a$invoice()
a$invoice(id = "your_id")

# 04 - Project -----------------------------------------------------------------

# create new project
a$project_new(name = ..., billing_group_id = ..., description = ...)

# list all project owned by you
a$project()
a$project(owner = "Rosalind.Franklin")

# partial match
p <- a$project(name = ..., id = ..., exact = TRUE)

# delete
p$delete()

# update
p$update(name = ..., description = ...)

# members
p$member()
p$member_add(username = ...)
p$member(username = ...)$update(write = ..., copy = ..., execute = ...)
p$memeber(usrname = ...)$delete()

# 05 - File --------------------------------------------------------------------

# list all files in this project
p$file()

# list all public files
a$file(visibility = "public")

# copy
a$copyFile(c(fid, fid2), project = pid)

# delete
p$file(id = fid)$delete()

# download
p$file()[[1]]$download_url()
p$file(id = fid3)$download("~/Downloads/")

# download all
download(p$file())

# update a file
fl$update(name = ..., metadata = list(a = ..., b = ..., ...))

# metadata
fl$meta()
fl$setMeta()
fl$setMeta(..., overwrite = TRUE)

# 06 - App ---------------------------------------------------------------------

a$app()

# apps in a project
p$app()
p$app(name, id, revision = ...)
a$copy_app(aid, project = pid, name = ...)

# add new app
p$app_add(short_name = ..., filename = ...)

# 07 - Task --------------------------------------------------------------------

a$task()
a$task(id = ...)
a$task(status = ...)

p$task()
p$task(id = ...)
p$task(status = ...)

tsk <- p$task(id = ...)
tsk$update()
tsk$abort()
tsk$run()
tsk$download()
tsk$detele()
tsk$getInputs()
tsk$monitor()

getTaskHook()
setTaskHook(status = ..., fun = ...)
```

[top](#top)