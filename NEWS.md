# anscombiser 1.1.0

## New features

* The functions `anscombise` and `mimic` have a new argument `idempotent`. See the documentation of these functions for details. The default setting is `idempotent = TRUE` but version 1.0.0 of anscombiser equates to `idempotent = FALSE`.
* New functions `anscombise_gif` and `mimic_gif` to produce animations of plots of datasets with the same summary statistics.
* Eight simple datasets that can be used as input to `anscombise` to create Anscombe-like datasets are provided.

## Bug fixes and minor improvements

* Corrected the description of the class of the returned object in the documentation for `anscombise` and `mimic`.
* Minor cosmetic improvements to the package manual.
* Activated 3rd edition of the `testthat` package.
