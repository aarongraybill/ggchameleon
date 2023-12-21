#' Chameleon Measurements
#'
#' A dataset of measurements of 26 veiled chameleons (\href{https://en.wikipedia.org/wiki/Veiled_chameleon}{\emph{Chamaeleo
#' calyptratus}}) from R. M. Drown, A. L. Liebl, and C. V. Anderson (2022). The
#' functional basis for variable antipredatory behavioral strategies in the
#' chameleon \emph{Chamaeleo calyptratus}. Journal of Experimental Biology,
#' 15 May 2022; 225 (10).
#'
#' @format A data frame with 26 rows and 15 columns
#'
#' \describe{
#'  \item{id}{unique id identifying each chameleon}
#'  \item{growth_stage}{how old the animal is. One of `"hatchling"`,
#'   `"juvenile"`, or `"adult"`}
#'  \item{head_length}{diagonal length (in cm) from snout to top of head}
#'  \item{head_height}{vertical height (in cm) from jaw to top of head (including the casque)}
#'  \item{casque_height}{vertical height (in cm) of the \href{https://en.wikipedia.org/wiki/Casque_(anatomy)}{casque}}
#'  \item{lower_jaw_length}{horizontal length (in cm) from the tip of the
#'    snout to the back of the jaw}
#'  \item{head_width}{distance (in cm) between the eye sockets}
#'  \item{casque_width}{depth (in cm), of the casque. See paper for details}
#'  \item{jaw_width}{distance (in cm) between jaw bones}
#'  \item{snout_vent_length}{length (in cm) from the tip of the snout to back of the cloaca (excludes tail)}
#'  \item{mass}{mass in grams}
#'  \item{max_bite_force}{bite force in newtons. Normalized, see paper for details}
#'  \item{normalized_peak_velocity}{maximal velocity in body lengths per second (snout_vent_length/seconds)}
#'  \item{peak_velocity_m}{maximal velocity, meters per second}
#'  \item{peak_velocity_cm}{maximal velocity, centimeters per second}
#' }
#'
#' @source <https://doi.org/10.1242/jeb.242955>
#'
#' @details
#' Raw data available from GitHub at <https://github.com/alliebl/Drown-et-al>.
#'
"chameleons"

#' Responses to Simulated Predation
#'
#' @description
#' A dataset of the defensive responses of chameleons to simulated predators.
#'
#' Data derived from R. M. Drown, A. L. Liebl, and C. V. Anderson (2022). The
#' functional basis for variable antipredatory behavioral strategies in the
#' chameleon \emph{Chamaeleo calyptratus}. Journal of Experimental Biology,
#' 15 May 2022; 225 (10).
#'
#' @format A data frame with 416 rows and 4 columns
#'
#' \describe{
#'  \item{id}{unique id identifying each chameleon}
#'  \item{predator}{type of predator simulated}
#'  \item{foliage}{density of the foliage available to the chameleon}
#'  \item{response}{response to the simulated threat; one of: \itemize{
#'    \item `"aggression"`: "body inflation, mouth gaping, hissing and/or lunging"
#'    \item `"fleeing"`: "quick escape from the predator"
#'    \item `"crypsis"`: "changing color to more closely match background"
#'    \item `"ring-flipping"`: "rotating to the side of the branch opposite from the predator’s view"
#'    \item `"free-falling"`: "dropping from the branch"
#'    \item `"leaf mimicry"`: "slow, back-and-forth movement imitating foliage"
#'    \item `"nothing"`
#'    }}
#'
#' }
#' @source <https://doi.org/10.1242/jeb.242955>
#'
#' @details
#' Descriptions for `repsonse` quoted directly from R. M. Drown, A. L. Liebl,
#' and C. V. Anderson (2022). Raw data available from GitHub at
#'<https://github.com/alliebl/Drown-et-al>.
"predation"
