# Using cytolib

`cytolib` provides the c++ headers for users to use and interact with the `GatingSet` (the gated cytometry data structure) at c++ level.

The **cytolib** package is installed in the normal `R` manner without the need of any user efforts.

All packages wishing to use the libraries in `cytolib` only need to:

* add `cytolib` to **LinkingTo** field in **DESCRIPTION** file so that the compiler knows where to find the headers when user package is complied e.g.

```
LinkingTo: cytolib
```

See **flowWorkspace** package for the example of using `cytolib`.