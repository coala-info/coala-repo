[Skip to contents](#main)

[easypar](../index.html)
1.0.0

* [Get started](../articles/easypar.html)
* [Reference](../reference/index.html)
* Articles

  [LSF array jobs with easypar](../articles/lsf.html)
  [PBSpro array jobs with easypar](../articles/pbspro.html)
* [Changelog](../news/index.html)

![](../logo.png)

# Vignette for easypar

#### Giulio Caravagna

#### 15 November 2018

Source: [`vignettes/easypar.Rmd`](https://github.com/caravagnalab/easypar/blob/HEAD/vignettes/easypar.Rmd)

`easypar.Rmd`

The `easypar` R package allows you to:

* run R functions in a parallel fashion in a trivial way.
* easily switch between parallel and serial executions of the same calls (at runtime).
* save results of paralle computation as far as they are produced (i.e., cache).

`easypar` can help if you have to run several different independent computations (for instance bootstrap estimates or multiple local-optimisations) and you want these to be parallel on multi-core architectures. `easypar` interfaces to `doParallel` in order to make this task easier to code, and to debug.

The idea is to exploit a code template and switch easily between parallel and sequential runs of a function. The code skeleton looks like this

```
if(parallel)
{
   R = foreach(i = 1:N) %dopar% { ....fun....  }
}
else
{
   for(i in 1:N) { ....fun... }
}
```

where `f` is the actual computation.

I want to use `parallel = FALSE` when I have to debug `f`, and eventually, I want to use `parallel = TRUE` to speed up computations. Parallel execution are hard to debug: inside `%dopar%`, tasks run in different memory spaces, and thus outputs (i.e., `print` etc) are asynchronous.

This piece of code is at the base of `easypar`, whose functioning is shown with some examples.

## Examples

Consider a dummy function `f` that sleeps for some random time and then print the output.

```
f = function(x)
{
  clock = 2 * runif(1)

  print(paste("Before sleep", x, " - siesta for ", clock))

  Sys.sleep(clock)

  print(paste("After sleep", x))

  return(x)
}
```

`f` runs as

```
f(3)
```

```
## [1] "Before sleep 3  - siesta for  1.31458618817851"
## [1] "After sleep 3"
```

```
## [1] 3
```

**Input(s).** We want to run `f` on 4 inputs (random univariate numbers). We store them in a list where each position is a full set of parameters that we want to pass to each calls to `f` (list of lists), named according to the actual parameter names.

```
inputs = lapply(runif(4), list)
print(inputs)
```

```
## [[1]]
## [[1]][[1]]
## [1] 0.4605249
##
##
## [[2]]
## [[2]][[1]]
## [1] 0.3707466
##
##
## [[3]]
## [[3]][[1]]
## [1] 0.5387441
##
##
## [[4]]
## [[4]][[1]]
## [1] 0.8236765
```

`easypar` provides a single function that takes as input `f`, its list of inputs and some execution parameters for the type of execution requested. The simplest call runs `f` in parallel, without seeing any output and just receiving the return values in a list as follows

```
library(easypar)
```

```
## Warning: replacing previous import 'cli::num_ansi_colors' by
## 'crayon::num_ansi_colors' when loading 'easypar'
```

```
easypar::run(FUN = f, PARAMS = inputs, parallel = TRUE, outfile = NULL)
```

```
## $`1`
## [1] 0.4605249
##
## $`2`
## [1] 0.3707466
##
## $`3`
## [1] 0.5387441
##
## $`4`
## [1] 0.8236765
```

We can control the amount (0 to 1) of cores to use at maximum (which are checked via `doPar`). Other combinations are also possible.

* make each thread dump to a shared `rds` file its result, implementing a cache which is usefull if one want to real-time analyze output results (with another process).

```
easypar::run(FUN = f, PARAMS = inputs, parallel = TRUE, outfile = NULL, cache = "My_task.rds")
```

```
## $`1`
## [1] 0.4605249
##
## $`2`
## [1] 0.3707466
##
## $`3`
## [1] 0.5387441
##
## $`4`
## [1] 0.8236765
```

```
# Check
cache = readRDS("My_task.rds")
print(cache)
```

```
## $`1`
## [1] 0.8403834
##
## $`3`
## [1] 0.8789801
##
## $`4`
## [1] 0.2348121
##
## $`2`
## [1] 0.2028515
##
## $`1`
## [1] 0.4605249
##
## $`2`
## [1] 0.3707466
##
## $`3`
## [1] 0.5387441
##
## $`4`
## [1] 0.8236765
```

* get outputs to screen (asynchronous per thread) with `outfile`

```
easypar::run(FUN = f, PARAMS = inputs, parallel = TRUE, outfile = '')
```

```
## $`1`
## [1] 0.4605249
##
## $`2`
## [1] 0.3707466
##
## $`3`
## [1] 0.5387441
##
## $`4`
## [1] 0.8236765
```

* sequentially every tasks in a `for`-loop fashion

```
easypar::run(FUN = f, PARAMS = inputs, parallel = FALSE, outfile = '')
```

```
## [1] "Before sleep 0.460524902213365  - siesta for  1.17825787793845"
## [1] "After sleep 0.460524902213365"
## [1] "Before sleep 0.370746633503586  - siesta for  1.68623037077487"
## [1] "After sleep 0.370746633503586"
## [1] "Before sleep 0.538744056597352  - siesta for  1.98223616415635"
## [1] "After sleep 0.538744056597352"
## [1] "Before sleep 0.823676499305293  - siesta for  0.678401350043714"
## [1] "After sleep 0.823676499305293"
```

```
## $`1`
## [1] 0.4605249
##
## $`2`
## [1] 0.3707466
##
## $`3`
## [1] 0.5387441
##
## $`4`
## [1] 0.8236765
```

## Runtime control of `easypar`

We can disable parallel executions easily.

We have a *global option* to force the execution to go serial, whatever its source code default behaviour is (`parallel = TRUE` will not work).

When `f` is plugged in a tool and called as

```
easypar::run(FUN = f, PARAMS = inputs)
```

which has default `parallel = TRUE`, and you set the global option `easypar.parallel`, `easypar` will run `f` sequentially.

```
options(easypar.parallel = FALSE)
easypar::run(FUN = f, PARAMS = inputs, parallel = TRUE)
```

```
## [easypar] 2022-05-30 14:21:37 - Overriding parallel execution setup [TRUE] with global option : FALSE
```

```
## [1] "Before sleep 0.460524902213365  - siesta for  0.00448952708393335"
## [1] "After sleep 0.460524902213365"
## [1] "Before sleep 0.370746633503586  - siesta for  0.929127100855112"
## [1] "After sleep 0.370746633503586"
## [1] "Before sleep 0.538744056597352  - siesta for  1.34369249502197"
## [1] "After sleep 0.538744056597352"
## [1] "Before sleep 0.823676499305293  - siesta for  1.93069661827758"
## [1] "After sleep 0.823676499305293"
```

```
## $`1`
## [1] 0.4605249
##
## $`2`
## [1] 0.3707466
##
## $`3`
## [1] 0.5387441
##
## $`4`
## [1] 0.8236765
```

## Errors handling

```
# Hopefully r will crash at least once but not all calls
f = function(x)
{
  if(runif(1) > .5) stop("Boom!!")

  "Ok"
}

# Restore parallel and run
options(easypar.parallel = TRUE)
runs = easypar::run(FUN = f, PARAMS = inputs, parallel = TRUE, outfile = NULL)
```

```
## [easypar] 2022-05-30 14:21:41 - Overriding parallel execution setup [TRUE] with global option : TRUE
```

```
## [easypar] 3/4 computations returned errors and will be removed.
```

```
# inspect and filter function
numErrors(runs)
```

```
## [1] 0
```

```
runs
```

```
## $`1`
## [1] "Ok"
```

```
filterErrors(runs)
```

```
## $`1`
## [1] "Ok"
```

## On this page

Developed by Giulio Caravagna.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.0.3.