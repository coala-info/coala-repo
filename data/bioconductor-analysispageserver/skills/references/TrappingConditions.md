Table of Contents

* [Condition Trapping with AnalysisPageServer](#toc_0)
* [SessionInfo](#toc_1)

# Condition Trapping with AnalysisPageServer

In R "conditions" are messages, warnings and
errors. `AnalysisPageServer` contains an API, completely independent
of its other components, to trap all
of these and be able to examine the call stacks.

First let's make some functions so that we'll have non-trivial call stacks.

```
e2 <- function(...)  stop(...)
e1 <- function(...)  e2(...)

w2 <- function(...)  warning(...)
w1 <- function(...)  w2(...)

m2 <- function(...)  message(...)
m1 <- function(...)  m2(...)
```

To use this functionality wrap your code in a call to
`tryKeepConditions()`, which returns an object of class
class `"AnalysisPageValueWithConditions"`.
Despite the name this is completely independent of the rest of
`AnalysisPageServer`. We'll build two such objects, one without an
error and one with

```
library(AnalysisPageServer)
vwc <- tryKeepConditions({
  m1("first message")
  m1("second message")
  w1("a warning")
  42
})
vwcErr <- tryKeepConditions({
  w1("a warning before the error")
  e1("this is a bad error")
  42
})
```

All of the functions to access these types of objects begin with
`vwc.`.

Check if your expression resulted in an error, and, if not, see what
the value was (`NULL` if it did result in an error):

```
vwc.is.error(vwc)
```

```
## [1] FALSE
```

```
vwc.is.error(vwcErr)
```

```
## [1] TRUE
```

```
vwc.value(vwc)
```

```
## [1] 42
```

```
vwc.value(vwcErr)
```

```
## NULL
```

To inspect the three types of conditions there are a family of
functions called `vwc.TYPE(s).condition(s)()`, `vwc.TYPE(s)()` and
`vwc.TYPE(s).traceback(s)()`
where `TYPE` is `message`, `warning` or `error`. The `(s)` is present
in the function names for messages and warnings since there can be
more than one, but absent for errors, since there can be only one.

`vwc.TYPE(s).condition(s)()` returns the condition object, or, for messages
and warnings, a list of all the condition objects:

```
vwc.messages.conditions(vwc)
```

```
## [[1]]
## <simpleMessage in message(...): first message
## >
##
## [[2]]
## <simpleMessage in message(...): second message
## >
```

```
vwc.messages.conditions(vwcErr)
```

```
## list()
```

```
vwc.warnings.conditions(vwc)
```

```
## [[1]]
## <simpleWarning in w2(...): a warning>
```

```
vwc.warnings.conditions(vwcErr)
```

```
## [[1]]
## <simpleWarning in w2(...): a warning before the error>
```

```
vwc.error.condition(vwc)
```

```
## NULL
```

```
vwc.error.condition(vwcErr)
```

```
## <simpleError in e2(...): this is a bad error>
```

`vwc.TYPE(s)` returns the condition messages as strings or character
vectors:

```
vwc.messages(vwc)
```

```
## [1] "first message\n"  "second message\n"
```

```
vwc.messages(vwcErr)
```

```
## character(0)
```

```
vwc.warnings(vwc)
```

```
## [1] "a warning"
```

```
vwc.warnings(vwcErr)
```

```
## [1] "a warning before the error"
```

```
vwc.error(vwcErr)
```

```
## [1] "this is a bad error"
```

(`vwc.error(vwc)` would throw a (new) error if the expression did not
result in an error, so we don't call it here.)

Finally, `vwc.TYPE(s).traceback(s)()` return tracebacks as character
vectors. Note that the "real" tracebacks can be extracted from the
condition objects as returned by `vwc.TYPE(s).conditions(s)()`, but
these functions return something suitable for showing to an end user.

(Since this vignette was rendered with `knitr` the call stacks are fairly complicated,
but if you run it in an R session you would just see the top few levels.)

```
vwc.messages.tracebacks(vwc)
```

```
## [[1]]
##  [1] "20: message(...) at <text>#7"
##  [2] "19: m2(...) at <text>#8"
##  [3] "18: m1(\"first message\") at <text>#3"
##  [4] "17: eval(expr, envir, enclos)"
##  [5] "16: eval(expr, envir, enclos)"
##  [6] "15: withVisible(eval(expr, envir, enclos))"
##  [7] "14: evaluate_call(expr, parsed$src[[i]], envir = envir, enclos = enclos, "
##  [8] "13: evaluate::evaluate(...)"
##  [9] "12: evaluate(code, envir = env, new_device = FALSE, keep_warning = !isFALSE(options$warning), "
## [10] "11: in_dir(input_dir(), evaluate(code, envir = env, new_device = FALSE, "
## [11] "10: block_exec(params)"
## [12] "9: call_block(x)"
## [13] "8: process_group.block(group)"
## [14] "7: process_group(group)"
## [15] "6: process_file(text, output)"
## [16] "5: knit(input, text = text, envir = envir, encoding = encoding, "
## [17] "4: knit2html(..., force_v1 = TRUE)"
## [18] "3: (if (grepl(\"\\\\.[Rr]md$\", file)) knit2html_v1 else if (grepl(\"\\\\.[Rr]rst$\", "
## [19] "2: engine$weave(file, quiet = quiet, encoding = enc)"
## [20] "1: tools::buildVignettes(dir = \".\", tangle = TRUE)"
##
## [[2]]
##  [1] "20: message(...) at <text>#7"
##  [2] "19: m2(...) at <text>#8"
##  [3] "18: m1(\"second message\") at <text>#4"
##  [4] "17: eval(expr, envir, enclos)"
##  [5] "16: eval(expr, envir, enclos)"
##  [6] "15: withVisible(eval(expr, envir, enclos))"
##  [7] "14: evaluate_call(expr, parsed$src[[i]], envir = envir, enclos = enclos, "
##  [8] "13: evaluate::evaluate(...)"
##  [9] "12: evaluate(code, envir = env, new_device = FALSE, keep_warning = !isFALSE(options$warning), "
## [10] "11: in_dir(input_dir(), evaluate(code, envir = env, new_device = FALSE, "
## [11] "10: block_exec(params)"
## [12] "9: call_block(x)"
## [13] "8: process_group.block(group)"
## [14] "7: process_group(group)"
## [15] "6: process_file(text, output)"
## [16] "5: knit(input, text = text, envir = envir, encoding = encoding, "
## [17] "4: knit2html(..., force_v1 = TRUE)"
## [18] "3: (if (grepl(\"\\\\.[Rr]md$\", file)) knit2html_v1 else if (grepl(\"\\\\.[Rr]rst$\", "
## [19] "2: engine$weave(file, quiet = quiet, encoding = enc)"
## [20] "1: tools::buildVignettes(dir = \".\", tangle = TRUE)"
```

```
vwc.messages.tracebacks(vwcErr)
```

```
## list()
```

```
vwc.warnings.tracebacks(vwc)
```

```
## [[1]]
##  [1] "20: warning(...) at <text>#4"
##  [2] "19: w2(...) at <text>#5"
##  [3] "18: w1(\"a warning\") at <text>#5"
##  [4] "17: eval(expr, envir, enclos)"
##  [5] "16: eval(expr, envir, enclos)"
##  [6] "15: withVisible(eval(expr, envir, enclos))"
##  [7] "14: evaluate_call(expr, parsed$src[[i]], envir = envir, enclos = enclos, "
##  [8] "13: evaluate::evaluate(...)"
##  [9] "12: evaluate(code, envir = env, new_device = FALSE, keep_warning = !isFALSE(options$warning), "
## [10] "11: in_dir(input_dir(), evaluate(code, envir = env, new_device = FALSE, "
## [11] "10: block_exec(params)"
## [12] "9: call_block(x)"
## [13] "8: process_group.block(group)"
## [14] "7: process_group(group)"
## [15] "6: process_file(text, output)"
## [16] "5: knit(input, text = text, envir = envir, encoding = encoding, "
## [17] "4: knit2html(..., force_v1 = TRUE)"
## [18] "3: (if (grepl(\"\\\\.[Rr]md$\", file)) knit2html_v1 else if (grepl(\"\\\\.[Rr]rst$\", "
## [19] "2: engine$weave(file, quiet = quiet, encoding = enc)"
## [20] "1: tools::buildVignettes(dir = \".\", tangle = TRUE)"
```

```
vwc.warnings.tracebacks(vwcErr)
```

```
## [[1]]
##  [1] "20: warning(...) at <text>#4"
##  [2] "19: w2(...) at <text>#5"
##  [3] "18: w1(\"a warning before the error\") at <text>#9"
##  [4] "17: eval(expr, envir, enclos)"
##  [5] "16: eval(expr, envir, enclos)"
##  [6] "15: withVisible(eval(expr, envir, enclos))"
##  [7] "14: evaluate_call(expr, parsed$src[[i]], envir = envir, enclos = enclos, "
##  [8] "13: evaluate::evaluate(...)"
##  [9] "12: evaluate(code, envir = env, new_device = FALSE, keep_warning = !isFALSE(options$warning), "
## [10] "11: in_dir(input_dir(), evaluate(code, envir = env, new_device = FALSE, "
## [11] "10: block_exec(params)"
## [12] "9: call_block(x)"
## [13] "8: process_group.block(group)"
## [14] "7: process_group(group)"
## [15] "6: process_file(text, output)"
## [16] "5: knit(input, text = text, envir = envir, encoding = encoding, "
## [17] "4: knit2html(..., force_v1 = TRUE)"
## [18] "3: (if (grepl(\"\\\\.[Rr]md$\", file)) knit2html_v1 else if (grepl(\"\\\\.[Rr]rst$\", "
## [19] "2: engine$weave(file, quiet = quiet, encoding = enc)"
## [20] "1: tools::buildVignettes(dir = \".\", tangle = TRUE)"
```

```
vwc.error.traceback(vwc)
```

```
## NULL
```

```
vwc.error.traceback(vwcErr)
```

```
##  [1] "20: stop(...) at <text>#1"
##  [2] "19: e2(...) at <text>#2"
##  [3] "18: e1(\"this is a bad error\") at <text>#10"
##  [4] "17: eval(expr, envir, enclos)"
##  [5] "16: eval(expr, envir, enclos)"
##  [6] "15: withVisible(eval(expr, envir, enclos))"
##  [7] "14: evaluate_call(expr, parsed$src[[i]], envir = envir, enclos = enclos, "
##  [8] "13: evaluate::evaluate(...)"
##  [9] "12: evaluate(code, envir = env, new_device = FALSE, keep_warning = !isFALSE(options$warning), "
## [10] "11: in_dir(input_dir(), evaluate(code, envir = env, new_device = FALSE, "
## [11] "10: block_exec(params)"
## [12] "9: call_block(x)"
## [13] "8: process_group.block(group)"
## [14] "7: process_group(group)"
## [15] "6: process_file(text, output)"
## [16] "5: knit(input, text = text, envir = envir, encoding = encoding, "
## [17] "4: knit2html(..., force_v1 = TRUE)"
## [18] "3: (if (grepl(\"\\\\.[Rr]md$\", file)) knit2html_v1 else if (grepl(\"\\\\.[Rr]rst$\", "
## [19] "2: engine$weave(file, quiet = quiet, encoding = enc)"
## [20] "1: tools::buildVignettes(dir = \".\", tangle = TRUE)"
```

# SessionInfo

```
sessionInfo()
```

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ggplot2_3.1.0             knitr_1.20
## [3] AnalysisPageServer_1.16.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.19        pillar_1.3.0        compiler_3.5.1
##  [4] log4r_0.2           plyr_1.8.4          highr_0.7
##  [7] bindr_0.1.1         tools_3.5.1         evaluate_0.12
## [10] tibble_1.4.2        gtable_0.2.0        pkgconfig_2.0.2
## [13] rlang_0.3.0.1       graph_1.60.0        parallel_3.5.1
## [16] bindrcpp_0.2.2      withr_2.1.2         stringr_1.3.1
## [19] dplyr_0.7.7         stats4_3.5.1        grid_3.5.1
## [22] tidyselect_0.2.5    glue_1.3.0          Biobase_2.42.0
## [25] R6_2.3.0            purrr_0.2.5         reshape2_1.4.3
## [28] magrittr_1.5        scales_1.0.0        BiocGenerics_0.28.0
## [31] assertthat_0.2.0    colorspace_1.3-2    labeling_0.3
## [34] stringi_1.2.4       lazyeval_0.2.1      munsell_0.5.0
## [37] markdown_0.8        crayon_1.3.4        rjson_0.2.20
```