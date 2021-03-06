#' Silently Catch Errors for \code{vglm()} Calls
#'
#' This function is used in \code{multi.bootstrap()} to catch errors and warnings in
#' \code{vglm()} model fits.
#'
#' @param ... Arguments to be passed to \code{vglm()}.
#' @return If fit is successful, an object of class \code{vglm}. If fit is
#'   unsuccessful, an object of class \code{try-error}.
#' @seealso \code{\link[VGAM]vglm()}; \code{\link[base]try()}.
#' @export
#' @examples
#' df <- data.frame(id = sample(1:20, size = 100, replace = TRUE),
#'                  x1 = rnorm(n = 100),
#'                  x2 = rbinom(p = 0.75, n = 100, size = 1),
#'                  y = sample(LETTERS[1:3], size = 100, replace = TRUE))
#' df <- df[order(df$id),]
#' df$time <- unlist(lapply(1:length(unique(df$id)),
#'                          FUN = function(idnum){ 1:nrow(df[df$id == unique(df$id)[idnum],]) }))
#'
#' ## Successful fit
#' try.vglm(y ~ x1 + x2, data = df, family = multinomial(refLevel = 1))
#'
#' ## Unsuccessful fit
#' try.vglm(y ~ x1 + x2, data = df[1:5,], family = multinomial(refLevel = 1))

try.vglm <- function(...){
  op <- options(warn = 2)
  on.exit(options(op))
  try(vglm(..., silent = TRUE))
}
