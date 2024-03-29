% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{predation}
\alias{predation}
\title{Responses to Simulated Predation}
\format{
A data frame with 416 rows and 4 columns

\describe{
\item{id}{unique id identifying each chameleon}
\item{predator}{type of predator simulated}
\item{foliage}{density of the foliage available to the chameleon}
\item{response}{response to the simulated threat; one of: \itemize{
\item \code{"aggression"}: "body inflation, mouth gaping, hissing and/or lunging"
\item \code{"fleeing"}: "quick escape from the predator"
\item \code{"crypsis"}: "changing color to more closely match background"
\item \code{"ring-flipping"}: "rotating to the side of the branch opposite from the predator’s view"
\item \code{"free-falling"}: "dropping from the branch"
\item \code{"leaf mimicry"}: "slow, back-and-forth movement imitating foliage"
\item \code{"nothing"}
}}

}
}
\source{
\url{https://doi.org/10.1242/jeb.242955}
}
\usage{
predation
}
\description{
A dataset of the defensive responses of chameleons to simulated predators.

Data derived from R. M. Drown, A. L. Liebl, and C. V. Anderson (2022). The
functional basis for variable antipredatory behavioral strategies in the
chameleon \emph{Chamaeleo calyptratus}. Journal of Experimental Biology,
15 May 2022; 225 (10).
}
\details{
Descriptions for \code{repsonse} quoted directly from R. M. Drown, A. L. Liebl,
and C. V. Anderson (2022). Raw data available from GitHub at
\url{https://github.com/alliebl/Drown-et-al}.

Linkable to \link{chameleons} via the \code{id} column.
}
\keyword{datasets}
