# Using RProtoBufLib

The existing CRAN package [RProtoBuf](https://cran.r-project.org/web/packages/RProtoBuf/index.html) implements the R interface to `protobuf` library. However it does not provide the c++ header and library file. So users are required to install the `protobuf` C++ library properly before they can install the packages that use `protobuf` C++ library directly.

To eliminate this system-wise library dependency and ease the installation process for the R end users, We provide **RProtoBufLib** package as a utility for package developers. It bundles [ProtoBuf C++ library](https://developers.google.com/protocol-buffers/) and exposes the c++ headers and static library so that user packages can compile and link against it once it is installed.

The **RProtoBufLib** package is installed in the normal `R` manner without the need of any user efforts.

All packages wishing to use the libraries in `RProtoBufLib` only need to:

* add `RProtoBufLib` to **LinkingTo** field in **DESCRIPTION** file so that the compiler knows where to find the headers when user package is complied e.g.

```
Imports: RProtoBufLib
LinkingTo: Rcpp, RProtoBufLib
```

* set **PKG\_LIBS** in **src/Makevars** file so that linker can find and linked to the **libprotobuf.a** file e.g.

```
PKG_LIBS =`${R_HOME}/bin/Rscript -e "RProtoBufLib::LdFlags()"`
```

See **flowWorkspace** package for the example of using `RProtoBufLib`.