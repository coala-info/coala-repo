R packages: LaTeX vignettes

Henrik Bengtsson

2016-05-16

To include a PDF vignette that is compiled from a plain LaTeX file, all you need is
the LaTeX file with LaTeX comments containing meta directives to R such that it will be
listed as a vignette in the package. The LaTeX-based vignette file should be placed in the
vignettes/ directory of your package. If your LaTeX file includes other files such as figure
files, these should also be located in the vignettes/. For instance, this PDF document was
compiled from LaTeX file:

1. vignettes/R packages-LaTeX vignettes.ltx

which contains the following meta directives at the top of the file:

%\VignetteIndexEntry{R packages: LaTeX vignettes}
%\VignetteEngine{R.rsp::tex}

%% Optional:
%\VignetteKeyword{R}
%\VignetteKeyword{package}
%\VignetteKeyword{vignette}
%\VignetteKeyword{LaTeX}

Here I choose filename extension *.ltx, which is a lesser known LaTeX filename extension,
because if one uses *.tex, then R CMD check will give a NOTE complaining that the file
is a stray file that should not be part of the built package.

Also, the above first two entries are required whereas the keyword entries are optional.
Note also that the %\VignetteIndexEntry{} controls the title shown in R’s help indices
as well as in online package respositories such as CRAN.

As for any type of (non-Sweave) package vignette, don’t forget to specify:

Suggests: R.rsp
VignetteBuilder: R.rsp

in your package’s DESCRIPTION file. That’s all it takes to include a LaTeX file that will
be compiled into a PDF vignette as part of the package build.

1

