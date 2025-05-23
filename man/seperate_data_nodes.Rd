% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/seperate_data_nodes.R
\name{seperate_data_nodes}
\alias{seperate_data_nodes}
\title{\code{seperate_data_nodes} splits the input data using the inserted split variable into
two sub-data sets like a stump of a decision tree using the inserted split value.}
\usage{
seperate_data_nodes(split_var, split_value, node_data)
}
\arguments{
\item{split_var}{Name of variable that is used to split the data.}

\item{split_value}{Split value of variable that is used to split the data.}

\item{node_data}{Data set that should be splitted.}
}
\value{
list containing data frames, first entry for left daughter node, second entry for right daughter node
}
\description{
\code{seperate_data_nodes} splits the input data using the inserted split variable into
two sub-data sets like a stump of a decision tree using the inserted split value.
}
\author{
Lea Louisa Kronziel, M.Sc.
}
