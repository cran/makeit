% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make.R
\name{make}
\alias{make}
\alias{makeit}
\title{Run R Script if Needed}
\usage{
make(recipe, prereq, target, include = TRUE, details = FALSE,
  force = FALSE, recon = FALSE, quiet = FALSE, ...)
}
\arguments{
\item{recipe}{script filename.}

\item{prereq}{one or more files required by the script. For example, data
files, scripts, or \code{NULL}.}

\item{target}{one or more output files produced by the script. Directory
names can also be used.}

\item{include}{whether to automatically include the script itself as a
prerequisite file. This means that if the script file has been
modified, it should be run.}

\item{details}{whether to show a diagnostic table of files and time last
modified.}

\item{force}{whether to run the R script unconditionally.}

\item{recon}{whether to return \code{TRUE} or \code{FALSE}, without actually
running the R script.}

\item{quiet}{whether to suppress messages.}

\item{\dots}{passed to \code{source}.}
}
\value{
\code{TRUE} or \code{FALSE}, indicating whether the script was run.
}
\description{
Run an R script if underlying files have changed, otherwise do nothing.
}
\note{
This function provides functionality similar to makefile rules, to determine
whether a script should be (re)run or not.

If any \code{target} is either missing or is older than any \code{prereq},
then the script is run.
}
\examples{
\donttest{
# Copy examples 'analysis' and 'sequential' to temporary directory
exdir <- tempdir()
file.copy(system.file("examples/analysis", package="makeit"),
          exdir, recursive=TRUE)
file.copy(system.file("examples/sequential", package="makeit"),
          exdir, recursive=TRUE)
owd <- getwd()

# This analysis uses input.dat to produce output.dat
setwd(file.path(exdir, "analysis"))
dir()
make("analysis.R", "input.dat", "output.dat")  # Running analysis.R
dir()
make("analysis.R", "input.dat", "output.dat")  # Nothing to be done

# Suppress message, show last modified
make("analysis.R", "input.dat", "output.dat", quiet=TRUE)
make("analysis.R", "input.dat", "output.dat", details=TRUE)

# Sequential scripts
setwd(file.path(exdir, "sequential"))
print.simple.list(dir(recursive=TRUE))
make("01_model.R", "data.dat", "results.dat")
make("02_plots.R", "results.dat", c("plots/A.png", "plots/B.png"))
make("03_tables.R", "results.dat", c("tables/A.csv", "tables/B.csv"))
print.simple.list(dir(recursive=TRUE))

# Clean up
unlink(file.path(exdir, c("analysis", "sequential")), recursive=TRUE)
setwd(owd)

# See vignette("makeit") for more examples and discussion
}

}
\references{
Stallman, R. M. \emph{et al}.
An introduction to makefiles.
Chapter 2 in the \emph{\href{https://www.gnu.org/software/make/manual/}{GNU
Make manual}}.
}
\seealso{
See \code{vignette("makeit")} for annotated examples and discussion.

\code{\link{file.exists}} and \code{\link{file.mtime}} are the underlying
functions used to check if files are missing or have changed.

\code{\link{source}} is the underlying function to run a script.
}
