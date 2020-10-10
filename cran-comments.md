This is a resubmission. 

I have reset par() at the end of the vignette because I changed par() earlier.

There are no obvious references for the methods used in this package, because they are essentially trival shifting, scaling and rotating of data (the latter using Cholesky decomposition of the sample covariance matrix).  However, your suggestion has prompted me to include in the DESCRIPTION a citatio of the related datasauRus package.

## R CMD check results

0 errors | 0 warnings | 0 notes

## Test environments

- ubuntu 12.04 (on travis-ci), R-release, R-devel    
- osx (on travis-ci), R-oldrel, R-release            
- win-builder (R-release)
- solaris-x86-patched using r-hub

## win-builder check

Possibly mis-spelled words in DESCRIPTION: Anscombe's
which is a false positive  

## Downstream dependencies

None

