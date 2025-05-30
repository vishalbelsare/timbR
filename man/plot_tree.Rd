% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_tree.R
\name{plot_tree}
\alias{plot_tree}
\title{Generates pdf document with plot from decision tree (classification or regression)}
\usage{
plot_tree(
  tree_info_df,
  train_data_df,
  test_data_df = NULL,
  rf_list,
  tree_number = 1,
  dependent_var,
  show_sample_size = FALSE,
  show_prediction_nodes = FALSE,
  show_uncertainty = FALSE,
  show_coverage = FALSE,
  show_intervalwidth = FALSE,
  vert_sep = 25,
  hor_sep = 25,
  work_dir,
  plot_name,
  colors = NULL
)
}
\arguments{
\item{tree_info_df}{Data frame containing information about the structure of the decision tree, which is built like a "treeInfo()" data frame from the package "ranger"}

\item{train_data_df}{Data frame of the training data with which the random forest was trained}

\item{test_data_df}{Data frame of the test data (only needed, if show_coverage = TRUE)}

\item{rf_list}{Random forest, which is built like the one you get from ranger()}

\item{tree_number}{Number of the decision tree of the rf_list to be displayed}

\item{dependent_var}{Name of the column of the dependent variable in training data}

\item{show_sample_size}{Option to display percentage of observations that reach nodes during training, inbag data must be available (TRUE or FALSE, TRUE could be time consuming)}

\item{show_prediction_nodes}{Option to display prediction in all nodes, inbag data must be available (TRUE or FALSE, TRUE could be time consuming)}

\item{show_uncertainty}{Option to display uncertainty quantification in terminal nodes (for now only available for regression)}

\item{show_coverage}{Option to display marginal coverage (only in combination with show_uncertainty = TRUE)}

\item{show_intervalwidth}{Option to display interval width uncertainty quantification in terminal nodes (only in combination with show_uncertainty = TRUE)}

\item{vert_sep}{Vertical spacing of nodes in mm (parameter from Latex package "forest")}

\item{hor_sep}{Horizontal spacing of nodes in mm (parameter from Latex package "forest")}

\item{work_dir}{Path where plot should be saved}

\item{plot_name}{Plot name}

\item{colors}{Vector with color names with one entry for each node, so for each row in tree_info_df}
}
\value{
PDF document with plot
}
\description{
Generates pdf document with plot from decision tree (classification or regression)
}
\examples{
require(dplyr)
require(knitr)
require(tinytex)
require(ranger)
require(timbR)

## Specify the path to the folder where the plot should be saved
work_dir <- getwd()

data(iris)

set.seed(12345)
## Train random forest with ranger
rf_iris <- ranger(Species ~ ., data = iris, write.forest=TRUE, num.trees = 10, min.node.size = 70)
## Get the treeInfo() of the first tree
treeinfo_iris <- treeInfo(rf_iris)

## Plot the first tree
timbR::plot_tree(tree_info_df = treeinfo_iris, train_data_df = iris, test_data_df = iris, rf_list = rf_iris,
                 dependent_var = "Species", work_dir = work_dir, plot_name = "example_plot")
}
\author{
Lea Louisa Kronziel, M.Sc.
}
