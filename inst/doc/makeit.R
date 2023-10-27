## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(collapse=TRUE, comment="#>")
library(makeit)
unlink("examples", recursive=TRUE)
file.copy(system.file("examples", package="makeit"), ".", recursive=TRUE)

## ----include=FALSE------------------------------------------------------------
knitr::opts_knit$set(root.dir="examples/analysis")

## ----echo=FALSE, comment=""---------------------------------------------------
cat(dir(), sep="\n")

## -----------------------------------------------------------------------------
make("analysis.R", "input.dat", "output.dat")

## -----------------------------------------------------------------------------
make("analysis.R", "input.dat", "output.dat")

## ----echo=FALSE, comment=""---------------------------------------------------
cat(dir(), sep="\n")

## ----include=FALSE------------------------------------------------------------
knitr::opts_knit$set(root.dir="examples/sequential")

## ----echo=FALSE, comment=""---------------------------------------------------
cat(dir()[dir() != "_make.R"], sep="\n")

## -----------------------------------------------------------------------------
make("01_model.R", "data.dat", "results.dat")
make("02_plots.R", "results.dat", c("plots/A.png", "plots/B.png"))
make("03_tables.R", "results.dat", c("tables/A.csv", "tables/B.csv"))

## ----echo=FALSE, comment=""---------------------------------------------------
files <- dir(recursive=TRUE)
files <- files[files != "_make.R"]
files <- c(grep("/", files, value=TRUE),
           grep("/", files, value=TRUE, invert=TRUE))
cat(files, sep="\n")

## ----include=FALSE------------------------------------------------------------
knitr::opts_knit$set(root.dir="examples/four_minutes")

## ----echo=FALSE, comment=""---------------------------------------------------
cat(dir()[dir() != "_make.R"], sep="\n")

## -----------------------------------------------------------------------------
make("get_data.R", "data_raw.csv", "data/data.csv")
make("fit_model.R", "data/data.csv", "output/coefs.dat")
make("plot_model.R", c("data/data.csv", "output/coefs.dat"), "output/plot.pdf")

## ----echo=FALSE, comment=""---------------------------------------------------
files <- dir(recursive=TRUE)
files <- files[files != "_make.R"]
files <- c(grep("/", files, value=TRUE),
           grep("/", files, value=TRUE, invert=TRUE))
cat(files, sep="\n")

## ----include=FALSE------------------------------------------------------------
knitr::opts_knit$set(root.dir="examples/dag_wikipedia")

## ----echo=FALSE, comment=""---------------------------------------------------
cat(dir()[dir() != "_make.R"], sep="\n")

## -----------------------------------------------------------------------------
make("a.R", prereq=NULL, target="out/a.dat")
make("b.R", prereq="out/a.dat", target="out/b.dat")
make("c.R", prereq="out/a.dat", target="out/c.dat")
make("d.R", prereq=c("out/b.dat", "out/c.dat"), target="out/d.dat")
make("e.R", prereq="out/d.dat", target="out/e.dat")

## ----echo=FALSE, comment=""---------------------------------------------------
files <- dir(recursive=TRUE)
files <- files[files != "_make.R"]
files <- c(grep("/", files, value=TRUE),
           grep("/", files, value=TRUE, invert=TRUE))
cat(files, sep="\n")

## ----include=FALSE------------------------------------------------------------
knitr::opts_knit$set(root.dir="examples/dag_targets")

## ----echo=FALSE, comment=""---------------------------------------------------
cat(dir()[dir() != "_make.R"], sep="\n")

## -----------------------------------------------------------------------------
make("first_target.R", NULL, "output/first_target.dat")
make("global_object.R", NULL, "output/global_object.dat")
make("second_target.R",
     prereq=c("output/first_target.dat", "output/global_object.dat",
              "inner_function.R", "outer_function.R"),
     target="output/second_target.dat")

## ----echo=FALSE, comment=""---------------------------------------------------
files <- dir(recursive=TRUE)
files <- files[files != "_make.R"]
files <- c(grep("/", files, value=TRUE),
           grep("/", files, value=TRUE, invert=TRUE))
cat(files, sep="\n")

