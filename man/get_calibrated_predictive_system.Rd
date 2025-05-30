% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_calibrated_predictive_system.R
\name{get_calibrated_predictive_system}
\alias{get_calibrated_predictive_system}
\title{Calibration of predictions of regression model using conformal predictive systems}
\usage{
get_calibrated_predictive_system(
  y_cal_pred,
  y_cal,
  y_test_pred,
  significance_level,
  interval_type = "two-tailed",
  direction = NULL
)
}
\arguments{
\item{y_cal_pred}{Predictions of regression model for calibration set.}

\item{y_cal}{True label of outcome variable for calibration set. Has to be in the same order as y_cal_pred.}

\item{y_test_pred}{Predictions of test data set that should be calibrated.}

\item{significance_level}{Level of uncertainty that should be reached by calibration, should be between 0 and 1.}

\item{interval_type}{Type of interval, choose either two-tailed or one-tailed}

\item{direction}{Direction of one-tailed interval, choose either left-tailed or right-tailed}
}
\value{
\item{data frame with point prediction and lower and upper bound of prediction interval.}
}
\description{
\code{get_calibrated_predictive_system} calibrates regression predictions using conformal predictive systems
to a point prediction with prediction one- or two-tailed interval for each observation of the test data set.
}
\examples{
require(ranger)
require(timbR)
require(dplyr)
require(ggplot2)

# Get train, test and calibration data
regr_data <- diamonds \%>\% data.frame()
train_data <- regr_data[1:17980,]
test_data <- regr_data[17981:35960,]
cal_data <- regr_data[35961:53940,]

# Train random forest with ranger
rf <- ranger(carat ~ ., data = train_data, num.trees = 10, importance = "permutation")

# Calculate pair-wise distances for all trees
rep_tree <- generate_tree(rf = rf, metric = "splitting variables", train_data = train_data, dependent_varname = "carat", importance.mode = TRUE, imp.num.var = 2, probs_quantiles = c(0.25,0.5,0.75), num.splits = 5)

# Get predictions
y_test_pred <- predict(rep_tree, test_data)$predictions
y_cal_pred <- predict(rep_tree, cal_data)$predictions
y_cal <- cal_data$carat

# Calibrated predictions
get_calibrated_predictive_system(y_cal_pred = y_cal_pred, y_cal = y_cal, y_test_pred = y_test_pred[1:10], significance_level = 0.05,interval_type = "two-tailed")

}
\author{
Lea Louisa Kronziel, M.Sc.
}
