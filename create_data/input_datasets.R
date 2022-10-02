# Input datasets from which to create Anscombe-like datasets using anscombise()

# Functions that will be used

## 3^d factorial design function

fac3 <- function(d) {
  # Creates a design matrix for a 3^d full factorial design
  #
  # Args:
  #   d : a positive integer scalar
  #
  # Returns:
  #   a 3^d by d integer matrix containing -1, 0, 1 for the levels of the d
  #   factors.  The first column varies fastest, the second column second
  #   fastest etc.
  rep_fn <- function(x) {
    rep(-1L:1L, times = 3L ^ x, each = 3L ^ (d - 1L - x))
  }
  return(vapply((d - 1L):0, rep_fn, numeric(3L ^ d)))
}

# Create points on a circle

circle <- function(n, x = 0, y = 0, r = 1) {
  dangle <- 2 * pi / n
  angles <- seq(0, 2 * pi - dangle, by = dangle)
  xv <- cos(angles) * r + x
  yv <- sin(angles) * r + y
  cbind(xv, yv)
}

# Input 1

input1 <- fac3(2)
input1 <- rbind(input1, matrix(c(0, 0, -2, 2), 2, 2))

# Input 2

input2 <- circle(11)

# Input 3

oldx <- 1:4
oldy <- rep(0, 4)
oldx <- c(oldx, c(1.5, 2.5, 3.5))
oldy <- c(oldy, rep(1, 3))
oldx <- c(oldx, 2:3)
oldy <- c(oldy, rep(2, 2))
oldx <- c(oldx, rep(2.5, 2))
oldy <- c(oldy, 3:4)
input3 <- cbind(oldy, oldx)

# Input 4

x <- c(rep(1, 3), rep(2, 2), 3, rep(4, 2), rep(5, 3))
y <- c(1:3, c(1.5, 2.5), 2, c(1.5, 2.5), 1:3)
input4 <- cbind(x, y)

# Input 5

x <- c(1, rep(2, 9), 3)
y <- c(5, 1:9, 5)
input5 <- cbind(x, y)

# Input 6

x <- c(1, 1, rep(2, 7), 3)
y <- c(3.75, 4.25, 1:7, 7)
input6 <- cbind(x, y)

# Input 7

x <- c(rep(1, 5), 2, rep(3, 5))
y <- c(1:5, 3, 1:5)
input7 <- cbind(x, y)

# Input 8

x <- c(1:6, (1:5))
y <- c(rep(1, 6), rep(2, 5))
input8 <- cbind(x, y)

colnames(input1) <- c("x", "y")
colnames(input2) <- c("x", "y")
colnames(input3) <- c("x", "y")
colnames(input4) <- c("x", "y")
colnames(input5) <- c("x", "y")
colnames(input6) <- c("x", "y")
colnames(input7) <- c("x", "y")
colnames(input8) <- c("x", "y")

use_data(input1)
use_data(input2)
use_data(input3)
use_data(input4)
use_data(input5)
use_data(input6)
use_data(input7)
use_data(input8)
