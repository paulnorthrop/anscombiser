# Donald Trump by Accentaur from the Noun Project

library("png")

img <- readPNG("C:/Users/paul/Pictures/noun_Donald Trump_727774.png")

d <- dim(img)[1]
i <- dim(img)[3]
m <- img[, , i]

the_points <- which(m > 0)
y <- the_points %% d
x <- floor(the_points / d)
plot(x, -y, pch = 20)

abline(h=-610)
# Cut off the

trump <- data.frame(x = x, y = -y)
plot(trump, pch = 20)
trump <- subset(trump, trump$y > -610)
plot(trump, pch = 20)
trump <- scale(trump)
plot(trump, pch = 20)
trump <- trump[, 1:2]
dim(trump)
