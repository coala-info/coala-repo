# Code example from 'style_guide' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
 # Good
fun <- function(param1,
                param2,
                param_with_dir_for_st_important = get_st_important_dir()) {
  # Code is indented by two spaces.
  ...
}
 # Bad
fun <- function(param1, param2, param_with_dir_for_st_important = file.path(system.file(paste(param1, "SE", "rds", sep = "."), package = "important_package"))) {
  ...
}

## -----------------------------------------------------------------------------
  # Good.
  foo <- function() {
    # Do stuff.
    x
  }
  # Bad.
  foo <- function() {
    # Do stuff.
    return(x)
  }

## -----------------------------------------------------------------------------
if (TRUE) {
  NULL
} else {
  NULL
}

## ----eval=FALSE---------------------------------------------------------------
# what_is_going_on <- if (is_check()) {
#   flog <- "it's getting hot..."
# } else if (is_mate()) {
#   flog <- "Oh noooo..."
# } else {
#   flog <- "there is a hope..."
# }

## ----eval=FALSE---------------------------------------------------------------
# # Good.
# idx <- foo()
# if (length(idx) == 1) {
#   f <- c(f[idx], f[-idx])
# }
# # Bad.
# if (length(foo()) == 1) {
#   f <- c(f[foo()], f[foo()])
# }

## -----------------------------------------------------------------------------
#' @note To learn more about functions start with `help(package = "{pkgname}")` 
#' @keywords internal
#' @return package help page
"_PACKAGE"

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

