% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_predictive_distribution.R
\name{get_predictive_distribution}
\alias{get_predictive_distribution}
\title{Calculation of cummulative predictive distribution (cpd)}
\usage{
get_predictive_distribution(y_cal_pred, y_cal, y_test_pred)
}
\arguments{
\item{y_cal_pred}{Predictions of regression model for calibration set.}

\item{y_cal}{True label of outcome variable for calibration set. Has to be in the same order as y_cal_pred.}

\item{y_test_pred}{Predictions of test data set that should be calibrated.}
}
\value{
\item{list with one cpd for each test observation}
}
\description{
\code{get_predictive_distribution} calculates cummulative predictive distribution using conformel predictive systems
to a point prediction with prediction interval for each observation of the test data set.
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
rep_tree <- generate_tree(rf = rf, metric = "splitting variables", train_data = train_data, dependent_varname = "carat", importance.mode = TRUE, imp.num.var = 5, probs_quantiles = c(0.25,0.5,0.75), num.splits = 3)

# Get predictions
y_test_pred <- predict(rep_tree, test_data)$predictions
y_cal_pred <- predict(rep_tree, cal_data)$predictions
y_cal <- cal_data$carat

# Get cummulative distributions for all test observations
cpds <- get_predictive_distribution(y_cal_pred = y_cal_pred, y_cal = y_cal, y_test_pred = y_test_pred)

# Plot distribution of first observation
cpd <- cpds[[1]]
y <- seq(0, 1 - 1/length(cpd), length.out = length(cpd))

ggplot(mapping = aes(y=y, x = cpd)) + geom_line()

}
\author{
Lea Louisa Kronziel, M.Sc.
}
